Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8F198822
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529443; cv=none; b=cqHJHxPJDXmV3e0b7o0ykW3CPpOyOgNJiM3E5of6n6JAhAC3QlGPZ3EjEt8wDIKvsj7kqjxj6770wZsIZwoNp6s6YP88FOQW4lMTx8R30rb/0t5K/9SGeH5Iea0SQACxZsQBZz3eIVmtdYplZImgLK/5p53LbTeVKYLU3tsvCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529443; c=relaxed/simple;
	bh=lC+h65E5extYhKRO73uhPfPYUsUnGB1juRy8t27RNsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ilw9q10310hV+qtpVl+oKSD4s0JADIAlimC/iMqH1htwpGL22QImmEg1MEley9pESJKUgYJJHh+mmH4vUQAeTzI89UPRijz+1LvnC37Tdbkaa0iFNpTV7e7+EE6bwo4iKnBS9839nGdQgI5QK91543w6PDwYlrhBp73MTMNCHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h4oxksLa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h4oxksLa"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI86TEZ028488;
	Wed, 18 Dec 2024 13:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rHcDGOgGtGrmVOIoU
	u/akrxjCy6KbYJoqDE6eTV/XKA=; b=h4oxksLa1yb/z2Z5IjHxxf0d0n8fg3GtC
	zZ3DD9FnIw5WM2m9+Yvser74Mgf021HGoQmEGIU//7XYHyFJNanGQXG9c0nt1Om5
	tHpK48oJmOZ8vGsLPDZGX6DOL8gSFlM+k5UJ3qkhiI/JBbJ523fTPTfa9oEvzyGY
	qkAMPqSdIeA2YOlHiy9/N1D3iVZGQN6zkDx7JP9hWkvOjggM271ufHYWVvemIW4P
	8I1+CWqrVJHixez4UwgERHQIjKijaWSZSsybw676TKYEoQ5qUU0zIt/MtQJLbCid
	gh9h4GUPAdghRNklxiDyNX64lto+z/CGR+Z0UlHQMGfSrFs04ITBA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ktk2hed4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:43:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIBnVdG029329;
	Wed, 18 Dec 2024 13:43:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsr9re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:43:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIDhWOC54722828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 13:43:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD6F2004F;
	Wed, 18 Dec 2024 13:43:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1C220040;
	Wed, 18 Dec 2024 13:43:31 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 13:43:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
        bvanassche@acm.org, gjoyce@ibm.com
Subject: [PATCHv2 blktests 2/2] throtl: fix the race between submitting IO and setting cgroup.procs
Date: Wed, 18 Dec 2024 19:13:22 +0530
Message-ID: <20241218134326.2164105-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218134326.2164105-1-nilay@linux.ibm.com>
References: <20241218134326.2164105-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6S1uHgwzEKkoTPn_Muru1TIomJNnbGV-
X-Proofpoint-ORIG-GUID: 6S1uHgwzEKkoTPn_Muru1TIomJNnbGV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=641 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180106

The throttle test cases uses _throtl_issue_io function to submit IO
to the device. This function typically runs in the background process
however before this function starts execution and submit IO, we need
to set the PID of the background process into cgroup.procs. The current
implementation adds sleep 0.1 before _throtl_issue_io and it's assumed
that during this sleep time of 0.1 second, we shall be able to write the
PID of the background process to cgroup.procs. However this may not be
always true as background process might starts running after sleep of 0.1
seconds (and hence start submitting IO) before we could actually write
the PID of background process into cgroup.procs from the parent shell.

This commit helps fix the above race condition by writing pid of the
background/child process using $BASHPID into cgroup.procs. The $BASHPID
returns the pid of the current bash process. So we leverage $BASHPID to
first write the pid of the background/child job/process into cgroup.procs
from within the child sub-shell and then start submitting IO. This way we
eliminate the need of any communication between parent shell and the 
background/child shell process and that helps avoid the race.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/throtl/004 | 7 ++-----
 tests/throtl/005 | 7 ++-----
 tests/throtl/rc  | 7 ++-----
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/tests/throtl/004 b/tests/throtl/004
index 6e28612..d1461b9 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -21,16 +21,13 @@ test() {
 	_throtl_set_limits wbps=$((1024 * 1024))
 
 	{
-		sleep 0.1
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
 		_throtl_issue_io write 10M 1
 	} &
 
-	local pid=$!
-	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-
 	sleep 0.6
 	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
-	wait "$pid"
+	wait $!
 
 	_clean_up_throtl
 	echo "Test complete"
diff --git a/tests/throtl/005 b/tests/throtl/005
index 0778258..86e52b3 100755
--- a/tests/throtl/005
+++ b/tests/throtl/005
@@ -20,16 +20,13 @@ test() {
 	_throtl_set_limits wbps=$((512 * 1024))
 
 	{
-		sleep 0.1
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
 		_throtl_issue_io write 1M 1
 	} &
 
-	local pid=$!
-	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-
 	sleep 1
 	_throtl_set_limits wbps=$((256 * 1024))
-	wait $pid
+	wait $!
 	_throtl_remove_limits
 
 	_clean_up_throtl
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 330e6b9..df54cb9 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -97,18 +97,15 @@ _throtl_issue_io() {
 # IO and then print time elapsed to the second, blk-throttle limits should be
 # set before this function.
 _throtl_test_io() {
-	local pid
 
 	{
 		local rw=$1
 		local bs=$2
 		local count=$3
 
-		sleep 0.1
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
 		_throtl_issue_io "$rw" "$bs" "$count"
 	} &
 
-	pid=$!
-	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-	wait $pid
+	wait $!
 }
-- 
2.45.2

