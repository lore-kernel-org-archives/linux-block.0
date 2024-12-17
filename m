Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438F1F1917
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441300; cv=none; b=gDiQ5qO3dUoocSIQvhYid6uShVi6T/rcQ8XLjfbXVUD1i54+1Lks7sPvXLkExqE9+asFf2joOvVnN6BQhHEmWroWQRmvEXJkBjASp4zPv4mcYrHWrqFNUnC40Bfb5SM1+gsoVGHpDMquf/CdD6cV/hx92wm7rtuktKaGbd35j4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441300; c=relaxed/simple;
	bh=3fuWIPnF5AfkZ21zrcN7g5TgFcGYc02ESiajsjZ/bDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAROYdQacY13JLai+bk0YDnD1XdmSIYGcQP+tsG/DPw/o4eCGYaxcrUfFqaCRPe9qalPhFgFhbSk2OrQbB+bPIbvf1h4ta0Y9OCEJ2f4ZKVoLSOhZG2L1Y02oSQt/dE2+SnsJzQ22EivMkH72+Kx4/GOqLxjsv1p157tthQiYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZnK8DXB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZnK8DXB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHD0PI1028099;
	Tue, 17 Dec 2024 13:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EKLvQBDNiFXrEQ/79
	A/RsQVBKY1sOlU1oMW5GniJNbk=; b=pZnK8DXBMwXDvaUdT1sTB2UfqjQnfBGXu
	+J8OqAxm8jfXuaBw2cM0nehzNk7b4hsqW1672g2GmGZCrfnGagTtZANcREEViu8O
	MnMyUYwuL5h3gpa3/ovfw+fjo9KjXoi1q70hDiXtrA85GocC5UfNo00WKyNyofvo
	SapiMDckLyb8pT8sq5hpb80/sKTT1WhXWprXFLznE9QkpvJnfqbGxxOXzI952piU
	oln2vqxwHbAnrf7MX58U+dItdgl94TsE+GNuO21e+emUKMH5ZIvnzdwbghfG88dB
	5SKe/OJUAga+lIoklCz2RrrchGGASCg1cjBzGgscwka1bCHj65tdg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k9t6g1yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 13:14:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH9F5UY014391;
	Tue, 17 Dec 2024 13:14:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21jg1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 13:14:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHDElrT35914332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 13:14:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA00620040;
	Tue, 17 Dec 2024 13:14:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B16202004B;
	Tue, 17 Dec 2024 13:14:45 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.52.184])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 13:14:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com
Subject: [PATCH blktests 2/2] throtl: fix the race between submitting IO and setting cgroup.procs
Date: Tue, 17 Dec 2024 18:44:22 +0530
Message-ID: <20241217131440.1980151-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217131440.1980151-1-nilay@linux.ibm.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OVrZhX9vfTWzP6N6SVHBJkSIhujDZGjd
X-Proofpoint-ORIG-GUID: OVrZhX9vfTWzP6N6SVHBJkSIhujDZGjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=848 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412170104

The throttle test cases uses _throtl_issue_io function to submit IO to
the device. This function typically runs in the background process however
before this function starts execution and submit IO, we need to set the PID
of the background process into cgroup.procs. The current implementation
adds sleep 0.1 before _throtl_issue_io and it's assumed that during this
sleep time of 0.1 second we shall be able to write the PID of the background
process to cgroup.procs. However this may not be always true as background
process might starts running after sleep of 0.1 seconds (and hence start
submitting IO) before we could actually write the PID of background process
into cgroup.procs.

This commit helps fix the above race condition by touching a temp file. The
the existence of the temp file is then polled by the background process at
regular interval. Until the temp file is created, the background process
would not forward progress and starts submitting IO and from the main
thread we'd touch temp file only after we write PID of the background
process into cgroup.procs.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/throtl/004 | 8 +++++++-
 tests/throtl/005 | 9 ++++++++-
 tests/throtl/rc  | 9 ++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tests/throtl/004 b/tests/throtl/004
index 6e28612..44b33ec 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -21,12 +21,18 @@ test() {
 	_throtl_set_limits wbps=$((1024 * 1024))
 
 	{
-		sleep 0.1
+                while true; do
+                        if [[ -e "$TMPDIR/test-io" ]]; then
+                                break
+                        fi
+                        sleep 0.1
+                done
 		_throtl_issue_io write 10M 1
 	} &
 
 	local pid=$!
 	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+	touch "$TMPDIR/test-io"
 
 	sleep 0.6
 	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
diff --git a/tests/throtl/005 b/tests/throtl/005
index 0778258..4797ea3 100755
--- a/tests/throtl/005
+++ b/tests/throtl/005
@@ -20,12 +20,19 @@ test() {
 	_throtl_set_limits wbps=$((512 * 1024))
 
 	{
-		sleep 0.1
+                while true; do
+                        if [[ -e "$TMPDIR/test-io" ]]; then
+                                break
+                        fi
+                        sleep 0.1
+                done
+
 		_throtl_issue_io write 1M 1
 	} &
 
 	local pid=$!
 	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+	touch "$TMPDIR/test-io"
 
 	sleep 1
 	_throtl_set_limits wbps=$((256 * 1024))
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 330e6b9..a9c1889 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -104,11 +104,18 @@ _throtl_test_io() {
 		local bs=$2
 		local count=$3
 
-		sleep 0.1
+		while true; do
+			if [[ -e "$TMPDIR/test-io" ]]; then
+				break
+			fi
+			sleep 0.1
+		done
 		_throtl_issue_io "$rw" "$bs" "$count"
 	} &
 
 	pid=$!
 	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+	touch "$TMPDIR/test-io"
 	wait $pid
+	rm "$TMPDIR/test-io"
 }
-- 
2.45.2

