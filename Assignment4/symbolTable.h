#include <bits/stdc++.h>
using namespace std;

class SymbolInfo {
    string name, type, code;

   public:
    SymbolInfo() {
        name = "";
        type = "";
        code = "";
    }
    SymbolInfo(string name, string type) {
        this->name = name;
        this->type = type;
    }
    void setValue(string name, string type) {
        this->name = name, this->type = type;
    }
    void setCode(string code){
        this->code += "\t" + code;
    }
    string getName() { return name; }
    string getType() { return type; }
    string getCode() { return code; }
    void display() { cout << "<" << type << ", " << name << ">"; }
};

class SymbolTable {
    vector<SymbolInfo> table[17];

   public:
    int getHashIndex(string s) {
        int asciiCnt = 0;
        for (char i : s)
            asciiCnt += i;
        return (asciiCnt * 12) % 17;
    }
    pair<int, int> lookup(string name, string type = "") {
        int id = getHashIndex(name);
        for (int j = 0; j < (int)table[id].size(); j++) {
            if (table[id][j].getName() == name) {
                return {id, j};
            }
        }
        return {-1, -1};
    }
    void print(int line = 0) {
        for (int i = 0; i < 17; i++) {
            if (table[i].size() == 0)
                continue;
            cout << i << "--> ";
            for (int j = 0; j < (int)table[i].size(); j++) {
                table[i][j].display();
                cout << " ";
            }
            cout << endl;
        }
    }
    void insert(SymbolInfo s) {
        pair<int, int> temp = lookup(s.getName(), s.getType());
        if (temp.first != -1 and temp.second != -1) {
            // cout << s.getName() << " variable already exists"
            //      << endl;
            return;
        }
        int id = getHashIndex(s.getName());
        int idofid = table[id].size();
        table[id].push_back(s);
        // print();
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
