Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B93148AF
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297920; cv=none; b=QpI/f6RTq9lNjN03V3BbgDmuAmxQxbrGJ1Lts7OuyhQt5LgEvIKL97VvvaGX9OLdpScBgFHF0qiKjMYeWC3ce2aexicx9JliBlXpTBkw0SrYIkw3Nl8v/wQyGbIbyPHIYfcg9A1F1Ficg7/+AyqZQVQXlgdpdM0Zbo+ITNG4ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297920; c=relaxed/simple;
	bh=WvJPKPvg/n58iKTTtV7K1RMm0IwxUDhsjVDvySf2DtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uswimGOxYZbExDxl4zjAP7qxiP79Qvzbhgz/3tX0t7veaJzXC4olsP8tFrYGXjCT+bh1VJDFuhiUD+dlBk4+G43hTkQATRdHl1kgdxahTlMV2WDd25Jmbgn0ZT7diXA/OKXENVfbpPSnNBSFDNYhMQfekBxpwHcv07aG6ezhzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m7vztYau; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m7vztYau"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D963Fv020512;
	Tue, 13 Jan 2026 09:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uHtLCO+V1V9S3zdj8e8hF0J6F3sx3utg9Ve19n2y8
	6g=; b=m7vztYauQaXLDiHn1MI7hKvtgUCV2DgkfYG5RMzt8ZQxbEgdVAI3kVsGW
	zWsXaE9EE/joa5Y9JIinOvI5gP1kdZZHGsQwcICr5/chUclL7rHr42HYXRnAH0Li
	/ltnPgbS8+kPkakCSnaD8F55W7vX8H3kIG7x3HTpFc2UaNHmLg/ssRP4V/gHaHYt
	aH+QbFeNcmKFcXqzxAMvUGS/liSOakSw05d26BzaMOXmL9MD+6Q3S0BUv3n9sDkK
	YEj75BoUkp+l4jDeVW12tK1lvCUIys2owXMSpOlLXxSkvUOAYnYaYVi3cdQ7xidD
	zqICY8KiX/EhWIUa/wG8C03w2FEvA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepuqg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 09:51:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60D7IKgU030111;
	Tue, 13 Jan 2026 09:51:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajk59t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 09:51:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60D9pr3k51446164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 09:51:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B7E02004B;
	Tue, 13 Jan 2026 09:51:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C11F20040;
	Tue, 13 Jan 2026 09:51:52 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.193])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 09:51:52 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH blktests] check: add kmemleak support to blktests
Date: Tue, 13 Jan 2026 15:21:03 +0530
Message-ID: <20260113095134.1818646-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=696615bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=LfzMfMiFqAthCEbxaP0A:9
X-Proofpoint-GUID: oHw-cVkWSRTTrGDLIQyxMvQ2I85jDhW6
X-Proofpoint-ORIG-GUID: oHw-cVkWSRTTrGDLIQyxMvQ2I85jDhW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MiBTYWx0ZWRfXwe6ybprCInxL
 JLzuhKK+o2MUJQ6krBdT1ARKTpRiru1STdOqH/b41hR2Se2Fbi1y6i+43STLSAhxBW7OcRiy0ed
 ulgTZTIB4ITTQFttWFi7gX0NEDtj9Vl6z7uQTSoNu+6cX9LW0Vnnjf4SlpbjjWSt21/j5mo0hiq
 0D8zVAYxbzErOUXt2kg2hE8GMnVz20qSkH+AcfWNDILLGUFEPqiHy0dWEsPOEqxP7aEvferZE8c
 UIpXPjHVgZwc65vLua3DRJxi3oEJtFixD+wEvxNkYz+5OdZ5vuHwL44eGuPyUbYi6slItU7AzUb
 WzKO43H0iW8WKcHwk6YOIKSfPKKjk7tu84Cs6ap1NJgrwfTTJvP6Sxg1KqKU3qHFhiugxVZPvcq
 rNQybLpXIK/v1Oe6wEvwIT8obbO+Dn8Gb0OV528g/xJQQd9oOxfZPDqd27aNjYJU9E+ylkSgYBi
 HnYjHaOCrBhZOJ2RE5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130082

Running blktests can also help uncover kernel memory leaks when the
kernel is built with CONFIG_DEBUG_KMEMLEAK. However, until now the
blktests framework had no way to automatically detect or report such
leaks. Users typically had to manually setup kmemleak and trigger
scans after running tests[1][2].

This change integrates kmemleak support directly into the blktests
framework. Before running each test, the framework checks for the
presence of /sys/kernel/debug/kmemleak to determine whether kmemleak
is enabled for the running kernel. If available, before running a test,
any existing kmemleak reports are cleared to avoid false positives
from previous tests. After the test completes, the framework explicitly
triggers a kmemleak scan. If memory leaks are detected, they are written
to a per-test file at, "results/.../.../<test>.kmemleak" and the
corresponding test is marked as FAIL. Users can then inspect the
<test>.kmemleak file to analyze the reported leaks.

With this enhancement, blktests can automatically detect kernel memory
leaks (if kerel is configured with CONFIG_DEBUG_KMEMLEAK support)  on
a per-test basis, removing the need for manual kmemleak setup and scans.
This should make it easier and faster to identify memory leaks
introduced by individual tests.

[1] https://lore.kernel.org/all/CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com/
[2] https://lore.kernel.org/all/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 check | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/check b/check
index 6d77d8e..3a6e837 100755
--- a/check
+++ b/check
@@ -183,6 +183,36 @@ _check_dmesg() {
 	fi
 }
 
+_setup_kmemleak() {
+	local f="/sys/kernel/debug/kmemleak"
+
+	if [[ ! -e $f || ! -r $f ]]; then
+		return 0
+	fi
+
+	echo clear > "$f"
+}
+
+_check_kmemleak() {
+	local kmemleak
+	local f="/sys/kernel/debug/kmemleak"
+
+	if [[ ! -e $f || ! -r $f ]]; then
+		return 0
+	fi
+
+	echo scan > "$f"
+	sleep 1
+	kmemleak=$(cat "$f")
+
+	if [[ -z $kmemleak ]]; then
+		return 0
+	fi
+
+	printf '%s\n' "$kmemleak" > "${seqres}.kmemleak"
+	return 1
+}
+
 _read_last_test_run() {
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 
@@ -377,6 +407,8 @@ _call_test() {
 	if [[ -v SKIP_REASONS ]]; then
 		TEST_RUN["status"]="not run"
 	else
+		_setup_kmemleak
+
 		if [[ -w /dev/kmsg ]]; then
 			local dmesg_marker="run blktests $TEST_NAME at ${TEST_RUN["date"]}"
 			echo "$dmesg_marker" >> /dev/kmsg
@@ -414,6 +446,9 @@ _call_test() {
 		elif ! _check_dmesg "$dmesg_marker"; then
 			TEST_RUN["status"]=fail
 			TEST_RUN["reason"]=dmesg
+		elif ! _check_kmemleak; then
+			TEST_RUN["status"]=fail
+			TEST_RUN["reason"]=kmemleak
 		else
 			TEST_RUN["status"]=pass
 		fi
@@ -451,6 +486,18 @@ _call_test() {
 				print \"    \" \$0
 			}" "${seqres}.dmesg"
 			;;
+		kmemleak)
+			echo "    kmemleak detected:"
+                        awk "
+                        {
+                                if (NR > 10) {
+                                        print \"    ...\"
+                                        print \"    (See '${seqres}.kmemleak' for the entire message)\"
+                                        exit
+                                }
+                                print \"    \" \$0
+                        }" "${seqres}.kmemleak"
+                        ;;
 		esac
 		return 1
 	else
-- 
2.52.0

