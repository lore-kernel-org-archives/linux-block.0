Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E35199250
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880110; cv=none; b=MIZCyYIPqts2matJ1C2aD2KDMfWgE4oT4uaFKFYciL/fx39Rp3721a2kCNsZrMu4emhG4pVoIDgbZYuI5rInx4NvCFjf81Dq72tC7YmqDyQpd9y1kZxAh4wXAWASmehEfCnIA6x7sVntUZCd8MZoKXaLu5FK6c/bRRdaBzQ1O8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880110; c=relaxed/simple;
	bh=ucgbnsMaL3Eu+SVIuoCLnvCcOsBV2MDh+bIIRYjYvFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjTL5ZAf6i5vKySL9s6dyYicEQmA+sSUCzEpmOjshmAiDU93BfmIADnraUyiZFhcDx4SVZmaKBB5YwU9PFUq3cmiGDiL40Nl4IBmxvIg7Vu/JI6rA2oR/A9bn+1QvZUBpyFckHv/zbOd1+fm+a16zwtjHe4cRx7n0YCGhtYze0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LNAvdT2S; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LNAvdT2S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718880108; x=1750416108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ucgbnsMaL3Eu+SVIuoCLnvCcOsBV2MDh+bIIRYjYvFw=;
  b=LNAvdT2S49201j09A6VV21Z+R4DO+a9McpCKFdi6CQ1xkPBXSzGu/MAu
   wQwM46o1RDaDj4B5McJF+PP2JXMA2jHhDRWERkXlsXZE5jfJGUFXDQOoD
   HhjsbRaZKMZoYLk5/S0WTqaLf9Ua+C0GHHH0z6S8P3RagqeuQY4lbn7R1
   FRKuQuF1G1chEC95ab3P+pqYLO4IVrzxvJ36HooSa6AUVkvEjAC9U3Vrb
   Saq9O69hZvxBSqQyFudBJOQJQb1n4SqMqvfiKyWpHAOVH5H/2ilOlopuw
   AuWlAwpf0q9agAEnN5iTuJOdq52xrM5wKq/O9lpQqcqkAyI7C9EDWLV5P
   Q==;
X-CSE-ConnectionGUID: nGWtt1t3S6i3lVX/X0IHDQ==
X-CSE-MsgGUID: aEOpPoHqRmqJ6F2SqlwFfA==
X-IronPort-AV: E=Sophos;i="6.08,252,1712592000"; 
   d="scan'208";a="19586428"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2024 18:41:42 +0800
IronPort-SDR: 6673f9a7_ORSXhlpklu8UyFCecndKWMid22hPu4ijWE449+ePmoyAw89
 ZTHwbKDbBQ7qm5HOt5EnDCI6nEcdIHnma9Yr2+w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2024 02:43:04 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jun 2024 03:41:42 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Gulam Mohamed <gulam.mohamed@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] loop/010: do not assume /dev/loop0
Date: Thu, 20 Jun 2024 19:41:41 +0900
Message-ID: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
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
 tests/loop/010 | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tests/loop/010 b/tests/loop/010
index ea396ec..f8c6f2c 100755
--- a/tests/loop/010
+++ b/tests/loop/010
@@ -16,18 +16,26 @@ requires() {
 }
 
 create_loop() {
+	local dev
+
 	while true
 	do
-		loop_device="$(losetup --partscan --find --show "${image_file}")"
-		blkid /dev/loop0p1 >& /dev/null
+		dev="$(losetup --partscan --find --show "${image_file}")"
+		if [[ $dev != "$1" ]]; then
+			echo "Unepxected loop device set up: $dev"
+			return
+		fi
+		blkid "$dev" >& /dev/null
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
@@ -38,6 +46,7 @@ test() {
 	local create_pid
 	local detach_pid
 	local image_file="$TMPDIR/loopImg"
+	local grep_str
 
 	truncate --size 1G "${image_file}"
 	parted --align none --script "${image_file}" mklabel gpt
@@ -53,9 +62,9 @@ test() {
 	mkfs.xfs --force "${loop_device}p1" >& /dev/null
 	losetup --detach "${loop_device}" >&  /dev/null
 
-	create_loop &
+	create_loop "${loop_device}" &
 	create_pid=$!
-	detach_loop &
+	detach_loop "${loop_device}" &
 	detach_pid=$!
 
 	sleep "${TIMEOUT:-90}"
@@ -66,8 +75,9 @@ test() {
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

