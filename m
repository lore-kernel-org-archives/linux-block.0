Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F217BCC
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314415; cv=none; b=XDkGLC+WqSwSA/a+4jP5lMTQdizpwnXO0y02rEqjYQd6/pIH+pvWe8CzTuyQYACvMV1fXUxaaU2UFAjzP+A16ns62VIwSnDGEYlJU17mT3kuGbRM/z+BkT9X+Ql83WvDI5bvz9WiY1OFw4xjy/MQpbgtzGxnFPcZTovhQkTlMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314415; c=relaxed/simple;
	bh=ohsF5ey6/duza+HrJETl7GSSoz86gTPvSJIqxzrdIRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9wupqZw25wRH1zSdjBldbmXy75mbxm3eIYLTmPZoxAMDeDi7LCojZsZTOmcf+1fR4D5mJb+gLQTEP+vj6Gc38Rlb3QMm+zntVuVsGjIrUsQTb6JRYLpoA/rB7D2aKnufoDObjpicT0SJHx6XpFImGMq9aJRdHRB5wqBv9Dr5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lk043Fdj; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lk043Fdj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719314413; x=1750850413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ohsF5ey6/duza+HrJETl7GSSoz86gTPvSJIqxzrdIRM=;
  b=lk043FdjaaxrAGTZ8yi+BCCFRGmena7/h66jYNc+9+SGWoYKMg1y9Nd0
   IwxlZIaPV4djEM4aOOn2ZX56dRsGvp3y36hHKl2rpAdqChGjQ/61acxDx
   qyHdvAMBw5ubAQJWDytyQjDzNvnsOHMHrymyRsxZFV1g/rMVJ7/CnRqHq
   j+UKS6t6WpL7LV5MGaryqF4Uk27mppE3E/Q0GSBB2Uoret71o5wkNDYQ1
   gfryOmFEqJPBPV7Ku+cDM9v6wrZIj26yyiswx/X0Wk8B3JVsVkQ58fCSY
   qzuKvNDM7RA5oWsLa7l7Lye6RmeUs6C0kkoX6Wid4/84mUzmiwTrhZwoc
   g==;
X-CSE-ConnectionGUID: 3uFLApNlRSOJnCVTdnVjjg==
X-CSE-MsgGUID: 0W3GbTpeTmm/s0FNo3HvDQ==
X-IronPort-AV: E=Sophos;i="6.08,263,1712592000"; 
   d="scan'208";a="20327179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 19:20:12 +0800
IronPort-SDR: 667a9a27_uh0ymX6MYUb+mQmwCUICXFBrqWDrmx1LSEEr+8bQATyySDz
 Wi5/rQ9o7PKY1lz57UsKcMcKlLdD/gIfOVxepVQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 03:21:27 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2024 04:20:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Gulam Mohamed <gulam.mohamed@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Date: Tue, 25 Jun 2024 20:20:11 +0900
Message-ID: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the test case loop/010 assumes that the
prepared loop device is /dev/loop0, which is not always true. When other
loop devices are set up before the test case run, the assumption is
wrong and the test case fails.

To avoid the failure, use the prepared loop device name stored in
$loop_device instead of /dev/loop0. Adjust the grep string to meet the
device name. Also use "losetup --detach" instead of
"losetup --detach-all" to not detach the loop devices which existed
before the test case runs.

Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach and open")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Replaced the losetup --find option with the loop device name
* Added the missing "p1" postfix to the blkid argument

 tests/loop/010 | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/loop/010 b/tests/loop/010
index ea396ec..ade8044 100755
--- a/tests/loop/010
+++ b/tests/loop/010
@@ -16,18 +16,23 @@ requires() {
 }
 
 create_loop() {
+	local dev=$1
+
 	while true
 	do
-		loop_device="$(losetup --partscan --find --show "${image_file}")"
-		blkid /dev/loop0p1 >& /dev/null
+		if losetup --partscan "$dev" "${image_file}" &> /dev/null; then
+			blkid "$dev"p1 >& /dev/null
+		fi
 	done
 }
 
 detach_loop() {
+	local dev=$1
+
 	while true
 	do
-		if [ -e /dev/loop0 ]; then
-			losetup --detach /dev/loop0 >& /dev/null
+		if [[ -e "$dev" ]]; then
+			losetup --detach "$dev" >& /dev/null
 		fi
 	done
 }
@@ -38,6 +43,7 @@ test() {
 	local create_pid
 	local detach_pid
 	local image_file="$TMPDIR/loopImg"
+	local grep_str
 
 	truncate --size 1G "${image_file}"
 	parted --align none --script "${image_file}" mklabel gpt
@@ -53,9 +59,9 @@ test() {
 	mkfs.xfs --force "${loop_device}p1" >& /dev/null
 	losetup --detach "${loop_device}" >&  /dev/null
 
-	create_loop &
+	create_loop "${loop_device}" &
 	create_pid=$!
-	detach_loop &
+	detach_loop "${loop_device}" &
 	detach_pid=$!
 
 	sleep "${TIMEOUT:-90}"
@@ -66,8 +72,9 @@ test() {
 		sleep 1
 	} 2>/dev/null
 
-	losetup --detach-all >& /dev/null
-	if _dmesg_since_test_start | grep --quiet "partition scan of loop0 failed (rc=-16)"; then
+	losetup --detach "${loop_device}" >& /dev/null
+	grep_str="partition scan of ${loop_device##*/} failed (rc=-16)"
+	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
 		echo "Fail"
 	fi
 	echo "Test complete"
-- 
2.45.0

