#Open the file in python and read all the files so it would be available in `file` for the  functions.
with open("access.log", "r") as logfile:
    file = logfile.readlines()

def top_5_ips(file):
    """
    Function that receives a file as an argument.
    We loop through the lines and use the split() function so we can easily count the times that a ip appear in the file. We save it in the dictionary `top_ip`.
    Finally, the dictionary is sorted in reverse so we can print the top 5 entries
    """
    top_ip = {}
    for line in file:
        ip = line.split()[0]
        if ip not in top_ip:
            top_ip[ip] = 0
        top_ip[ip] += 1
    top_5_sorted  = sorted(top_ip.items(), key=lambda x: x[1], reverse=True) #- Sorting dictionary by value in python in the [documentation](https://docs.python.org/3/howto/sorting.html)
    print("---TOP 5 IP---")
    for ip, hits in top_5_sorted[:5]:
        print(f"{hits} {ip}")

def count_http_methods_by_code(file):
    """
    Function that receives a file as an argument.
    We loop through the lines and use the split(). The http code and verb are known positions so we save it as a tuple in order to save the count in the dictionary http_verb_by_code.
    Finally, the dictionary is order and printed.
    """
    http_verb_by_code = {}
    for line in file:
        http_verb = line.split()[5][1:]
        http_code = line.split()[8]
        if (http_verb, http_code) not in http_verb_by_code:
            http_verb_by_code[(http_verb, http_code)] = 0
        http_verb_by_code[(http_verb, http_code)] += 1
    http_verb_by_code_orded = sorted(http_verb_by_code.items(), key=lambda x: x[1], reverse=True) #- Sorting dictionary by value in python in the [documentation](https://docs.python.org/3/howto/sorting.html)
    print("---HTTP METHODS---")
    for http_tuple, hits in http_verb_by_code_orded:
        http_verb, http_code = http_tuple
        print(f"{hits} {http_verb} {http_code}")



top_5_ips(file)
count_http_methods_by_code(file)