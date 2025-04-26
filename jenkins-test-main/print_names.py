import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: python names_cli.py name1 name2 ...")
        return

    for name in sys.argv[1:]:
        print(name)

if __name__ == "__main__":
    main()
