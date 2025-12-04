document.addEventListener("DOMContentLoaded", () => {

    let provider;
    let signer;
    let contract;

    // Contract info
    const contractAddress = "0x6F3DD186DcC2a55e6d85d795A91a8b09E2729143";
    const contractABI = [
        {
            "anonymous": false,
            "inputs": [
                { "indexed": false, "internalType": "address", "name": "player", "type": "address" },
                { "indexed": false, "internalType": "enum RPS.Move", "name": "userMove", "type": "uint8" },
                { "indexed": false, "internalType": "enum RPS.Move", "name": "computerMove", "type": "uint8" },
                { "indexed": false, "internalType": "string", "name": "result", "type": "string" }
            ],
            "name": "GamePlayed",
            "type": "event"
        },
        {
            "inputs": [{ "internalType": "uint8", "name": "userMove", "type": "uint8" }],
            "name": "play",
            "outputs": [{ "internalType": "string", "name": "", "type": "string" }],
            "stateMutability": "payable",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "betAmount",
            "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
            "stateMutability": "view",
            "type": "function"
        }
    ];

    // UI elements
    const connectBtn = document.getElementById("connectBtn");
    const walletAddress = document.getElementById("walletAddress");
    const result_p = document.querySelector(".result > p");
    const userScore_span = document.getElementById("user-score");
    const computerScore_span = document.getElementById("computer-score");

    const rock_div = document.getElementById("r");
    const paper_div = document.getElementById("p");
    const scissors_div = document.getElementById("s");

    // Scores
    let userScore = 0;
    let computerScore = 0;


    // -------------------- CONNECT WALLET --------------------
    connectBtn.addEventListener("click", async () => {
        if (!window.ethereum) {
            alert("MetaMask not detected!");
            return;
        }

        try {
            provider = new ethers.providers.Web3Provider(window.ethereum, "any");
            await provider.send("eth_requestAccounts", []);

            signer = provider.getSigner();
            const address = await signer.getAddress();
            walletAddress.innerText = `Connected: ${address}`;

            contract = new ethers.Contract(contractAddress, contractABI, signer);
            console.log("Contract initialized:", contract);

        } catch (err) {
            console.error("Wallet connection error:", err);
            alert("Wallet connection failed.");
        }
    });



    // -------------------- PLAY ON BLOCKCHAIN --------------------
    async function playOnBlockchain(move) {
        if (!contract) {
            alert("Connect wallet first.");
            return;
        }

        result_p.innerText = "Waiting for blockchain confirmation...";

        try {
            const tx = await contract.play(move, {
                value: ethers.utils.parseEther("0.0001")
            });

            const receipt = await tx.wait();
            console.log("Transaction receipt:", receipt);

            const event = receipt.events?.find(e => e.event === "GamePlayed");
            if (!event) {
                result_p.innerText = "Event not received!";
                return null;
            }

           const { userMove, computerMove, result } = event.args;

return {
    userMove: Number(userMove),
    computerMove: Number(computerMove),
    result
};


        } catch (err) {
            console.error("Transaction failed:", err);
            result_p.innerText = "Transaction failed!";
            return null;
        }
    }



    // -------------------- GAME LOGIC --------------------
    function convertToWord(n) {
        return n === 0 ? "Rock" : n === 1 ? "Paper" : "Scissors";
    }

    function updateUI(userMove, compMove, outcome) {
        if (outcome === "win") {
            userScore++;
            result_p.innerText = `${convertToWord(userMove)} beats ${convertToWord(compMove)} — You WIN!`;
        } else if (outcome === "lose") {
            computerScore++;
            result_p.innerText = `${convertToWord(userMove)} loses to ${convertToWord(compMove)} — You lose`;
        } else {
            result_p.innerText = `${convertToWord(userMove)} = ${convertToWord(compMove)} — Draw`;
        }

        userScore_span.innerText = userScore;
        computerScore_span.innerText = computerScore;
    }



    // -------------------- MAIN GAME FUNCTION --------------------
    async function game(choice) {
        const move = choice === "r" ? 0 : choice === "p" ? 1 : 2;

        const result = await playOnBlockchain(move);
        if (!result) return; // failed tx

        updateUI(move, result.computerMove, result.result);
    }



    // -------------------- UI BUTTONS --------------------
    rock_div.addEventListener("click", () => game("r"));
    paper_div.addEventListener("click", () => game("p"));
    scissors_div.addEventListener("click", () => game("s"));

});
