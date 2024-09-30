/*
    Before running the code,
    make sure you have a file named "in.txt"
    in the same directory as this code
    and the file contains all the inputs. 
*/

#include <bits/stdc++.h>
using namespace std;

FILE *in;
FILE *out;

class TOKEN {
   public:
    string attribute;
    string value;
    TOKEN() { attribute = "", value = ""; }
    void print() { 
        cout << "<" << attribute << " : " << value << ">" << endl; 
    }
};

TOKEN getNumber() {
    int state = 12;
    char c;
    auto retract = [&]() { fseek(in, -1, SEEK_CUR); };
    TOKEN t;
    while (1) {
        c = fgetc(in);
        switch (state) {
            case 12:
                if (isdigit(c)) {
                    t.value.push_back(c);
                    state = 13;
                }
                else if (c == '.') {
                    t.value.push_back(c);
                    state = 14;
                }
                break;
            case 13:
                if (isdigit(c)) {
                    state = 13;
                    t.value.push_back(c);
                }
                else if (c == '.') {
                    state = 14;
                    t.value.push_back(c);
                }
                else if (c == 'E' or c == 'e') {
                    state = 16;
                    t.value.push_back(c);
                }
                else
                    state = 201;
                break;
            case 14:
                if (isdigit(c)) {
                    state = 15;
                    t.value.push_back(c);
                }
                else if (t.value.size() > 1) {
                    t.value.pop_back();
                    state = 202;
                }
                break;
            case 15:
                if (isdigit(c)) {
                    state = 15;
                    t.value.push_back(c);
                }
                else if (c == 'E' or c == 'e') {
                    state = 16;
                    t.value.push_back(c);
                }
                else
                    state = 203;
                break;
            case 16:
                if (isdigit(c)) {
                    state = 18;
                    t.value.push_back(c);
                }
                else if (c == '+' or c == '-') {
                    state = 17;
                    t.value.push_back(c);
                }
                break;
            case 17:                if (isdigit(c)) {
                    state = 18;
                    t.value.push_back(c);
                }
                break;
            case 18:
                if (isdigit(c)) {
                    state = 18;
                    t.value.push_back(c);
                }
                else
                    state = 204;
                break;

            case 201:
                retract();
                t.attribute = "INT       ";
                return t;
                break;
            case 202:
                retract();
                t.attribute = "INT       ";
                return t;
                break;
            case 203:
                retract();
                t.attribute = "FLOAT     ";
                return t;
                break;
            case 204:
                retract();
                t.attribute = "SCIENTIFIC";
                return t;
                break;
            default:
                break;
        }
        if (c == EOF) {
            if (isdigit(t.value[0]))
                t.attribute = "INT       ";
            return t;
        }
    }
    return TOKEN();
}

void solve() {
    while (true) {
        TOKEN token = getNumber();
        if (token.attribute.empty() or token.value.empty())
            break;
        else
            token.print();
    }
    return;
}

int main() {
    in = freopen("in.txt", "r", stdin);
    out = freopen("out.txt", "w", stdout);
    solve();
    fclose(in);
    fclose(out);
    return 0;
}
