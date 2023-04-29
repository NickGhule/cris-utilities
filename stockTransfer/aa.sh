# output=$(latencyall wc)
output="======= wc  latency in DWH ====================

         161 Apr 16 2023  4:30PM  Apr 16 2023  4:30PM  0        puwcut_db                      PDRUWXUT_CLS

(2 rows affected)
Gateway connection to 'PCPUCXSG_CLS.pcpucxdw_rs_rssd' is created.
 origin      origin_time          dest_commit_time     diff     dbname                         dsname
 ----------- -------------------- -------------------- -------- ------------------------------ ------------------------------
         151 Apr 16 2023  4:41PM  Apr 16 2023  4:42PM  0        puwcut_db                      PMUUWXUT_CLS
         161 Apr 16 2023  4:30PM  Apr 16 2023  4:30PM  0        puwcut_db                      PDRUWXUT_CLS

(2 rows affected)


======= wc  latency in Recon ====================
         161 Apr 16 2023  4:30PM  Apr 16 2023  4:30PM  0        puwcut_db                      PDRUWXUT_CLS

(2 rows affected)
Gateway connection to 'PCPUCXSG_CLS.pcpucxdw_rs_rssd' is created.
 origin      origin_time          dest_commit_time     diff     dbname                         dsname
 ----------- -------------------- -------------------- -------- ------------------------------ ------------------------------
         151 Apr 16 2023  4:41PM  Apr 16 2023  4:42PM  0        puwcut_db                      PMUUWXUT_CLS
         161 Apr 16 2023  4:30PM  Apr 16 2023  4:30PM  0        puwcut_db                      PDRUWXUT_CLS

(2 rows affected)"


origin_time=$(echo "$output" | grep puwcut_db | awk '{print $2,$3,$4,$5}' | head -1)
destination_time=$(echo "$output" | grep puwcut_db | awk '{print $6,$7,$8,$9}' | head -1)
# convert to date
origin_date=$(date -d "$origin_time" +%s)
destination_date=$(date -d "$destination_time" +%s)

echo origin_date: $origin_date
echo destination_date: $destination_date

#  check if difference is less than 5 minutes
if [ $((destination_date - origin_date)) -lt 300 ]; then
    echo "Latency is less than 5 minutes"
else
    echo "Latency is more than 5 minutes"
fi