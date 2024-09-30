#include <bits/stdc++.h>
using namespace std;

class SymbolInfo {
    string name, type;

   public:
    SymbolInfo(string name, string type) {
        this->name = name;
        this->type = type;
    }
    void setValue(string name, string type) {
        this->name = name, this->type = type;
    }
    string getName() { return name; }
    string getType() { return type; }
    void display() { cout << "<" << name << ", " << type << ">"; }
};


class SymbolTable {
    vector<SymbolInfo> table[17];

   public:
    int getHashIndex(string s) {
        int asciiCnt = 0;
        for (auto i : s)
            asciiCnt += i;
        return (asciiCnt * 12) % 17;
    }
    pair<int, int> lookup(string name) {
        int id = getHashIndex(name);
        for (int j = 0; j < (int)table[id].size(); j++) {
            if (table[id][j].getName() == name) {
                return {id, j};
            }
        }
        return {-1, -1};
    }
    void insert(SymbolInfo s) {
        pair<int, int> temp = lookup(s.getName());
        if (temp.first != -1 and temp.second != -1) {
            cout << "Already Exists" << endl;
            return;
        }
        int id = getHashIndex(s.getName());
        int idofid = table[id].size();
        table[id].push_back(s);
        cout << "Inserted at position " << id << ", " << idofid << endl;
    }
    void print() {
        for (int i = 0; i < 17; i++) {
            cout << i << "--> ";
            for (int j = 0; j < (int)table[i].size(); j++) {
                table[i][j].display();
                cout << " ";
            }
            cout << endl;
        }
    }
    void DELETE(string name) {
        pair<int, int> temp = lookup(name);
        if (temp.first != -1 and temp.second != -1) {
            cout << "Deleted from " << temp.first << " " << temp.second << endl;
            table[temp.first].erase(table[temp.first].begin() + temp.second);
        }
        else
            cout << "Doesn't Exists" << endl;
    }
};

int main() {
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    SymbolTable T;
    char ty;
    while (cin >> ty) {
        if (ty == 'I') {
            string name, type;
            cin >> name >> type;
            SymbolInfo S(name, type);
            T.insert(S);
        }
        else if (ty == 'P') {
            T.print();
        }
        else if (ty == 'L') {
            string s;
            cin >> s;
            pair<int, int> idx = T.lookup(s);
            if (idx.first == -1 and idx.second == -1)
                cout << "Not Found" << endl;
            else
                cout << "Found at " << idx.first << " " << idx.second << endl;
        }
        else if (ty == 'D') {
            string s;
            cin >> s;
            T.DELETE(s);
        }
    }
    return 0;
}