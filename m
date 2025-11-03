Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158E29992A
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152307; cv=none; b=hYwA/n1TCKTaSFxH6CHHfX6yh9fsbDK+E/0P5gPYikM8v4rqKgtMRTcP1td1BO5NX7OBCb/DDSsa+1F84D6THG8Womj1YiAf2i3+i9rhYZm3/c8+ppay3WGy0Eb79pjPuX9lidKmYYrH/pvB/Niiarola44kjzjzK005/9M6vOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152307; c=relaxed/simple;
	bh=MhlBcWbLbcmhQVJFe0KtjTX0KwwyZTrGrkWJKkt1g6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu9pP+Qjc5sh8Sbd0qtgQapclXM4xdlgkaJgNfDdDs7OicHic/x7TEErja7BtPosRYDQy2VznlTRmvitbH0NKIcUYZ9wEhfdp2xxNuO6uyQAM74y1MXgnvJ8qvnafGDPVtOAmQgrzjoy+1yvcvZBf7c/VPKAsg6nPFAKYonAGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WVNO7Vl1; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WVNO7Vl1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762152305; x=1793688305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhlBcWbLbcmhQVJFe0KtjTX0KwwyZTrGrkWJKkt1g6Q=;
  b=WVNO7Vl1IETa+QCb5QsI26pttpGGlmCgCEBywuMdrT6niVYpaUUnYPun
   Pt5Nfk3AWu9reAZ8d3e/+wwvGunxamupPANHtEAWAxGMVsgL1rwjRtszD
   0Krmz1lryeWWUcspnQE3a7/NLohatAB78DWRHqbPt9tcSh7dvD80y0G3j
   zfdwDMks+0XFUrwskPNFqFOInVEQFt6qV3IEM6bDIs9nYCTClG7cwMtFZ
   X9MLAK+UB5jQlJD2glKRihOGzCsfHqRashM5o2kXO+wjdRAWG7gSlH5Z/
   g7EO7sGaGnNXqTJrUOl6aCEzI/yGu5D/fPh4+UsBWisq9mvwIP5vj99Cr
   g==;
X-CSE-ConnectionGUID: ol196fTXRHe9vPebekqUtw==
X-CSE-MsgGUID: g+nUVoXsQTuYPPh7xtzidQ==
X-IronPort-AV: E=Sophos;i="6.19,275,1754928000"; 
   d="scan'208";a="134391242"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 14:45:00 +0800
IronPort-SDR: 69084f6c_VBW69VKo6VGKLChRg21wWZSLrhhdzsTyRQz8z5q0yTmAVl+
 WlGf22t6c4O4qRKAspvCMiTBuAugn3lIYFsVl3w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2025 22:45:00 -0800
WDCIronportException: Internal
Received: from wdap-zcgq2z60ds.ad.shared (HELO shinmob.flets-east.jp) ([10.224.109.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2025 22:44:59 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 5/5] throtl: support test with both null_blk and scsi_debug in a single run
Date: Mon,  3 Nov 2025 15:44:54 +0900
Message-ID: <20251103064454.724084-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
References: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit introduced the global variable throtl_blkdev_type to
specify the type of block device for the throtl group. However, users
need to run tests twice modifying the variable's value each time to test
against both device types null_blk and scsi_debug. This workflow is
cumbersome.

To run the throtl group for both null_blk and scsi_debug in a single
run, introduce the global variable THROTL_BLKDEV_TYPES instead of
throtl_blkdev_type. When THROTL_BLKDEV_TYPES is set to 'nullb sdebug',
the blktests framework executes each test case in the throtl group for
both null_blk and scsi_debug sequentially. For this purpose, introduce
the helper function _set_throtl_blkdev_type() and call it in
set_conditions() hooks of the test cases.

Each of the two command lines below runs the throtl group with both
null_blk and scsi_debug. Please note that the default value of
THROTL_BLKDEV_TYPES is 'nullb sdebug'.

  $ sudo bash -c "./check throtl/"
  $ sudo bash -c "THROTL_BLKDEV_TYPES='nullb sdebug' ./check throtl/"

Each of the command lines below runs the throtl group only for null_blk
or scsi_debug, respectively.

  $ sudo bash -c "THROTL_BLKDEV_TYPES='nullb' ./check throtl/"
  $ sudo bash -c "THROTL_BLKDEV_TYPES='sdebug' ./check throtl/"

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 17 +++++++++++++++++
 tests/throtl/001               |  4 ++++
 tests/throtl/002               |  4 ++++
 tests/throtl/003               |  4 ++++
 tests/throtl/004               |  4 ++++
 tests/throtl/005               |  4 ++++
 tests/throtl/006               |  4 ++++
 tests/throtl/007               |  4 ++++
 tests/throtl/rc                | 16 ++++++++++++++++
 9 files changed, 61 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 8ccd739..4cf1a3a 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -167,6 +167,23 @@ USE_RXE=1 ./check srp/
 'USE_RXE' had the old name 'use_rxe'. The old name is still usable but not
 recommended.
 
+### Blk-throttle tests
+
+The blk-throttle tests has one environment variable below:
+
+- THROTL_BLKDEV_TYPES: 'nullb' 'sdebug'
+  Set up test target block device based on this environment variable value. To
+  test with null_blk, set 'nullb'. To test with scsi_debug, set 'sdebug'. To
+  test with both, set 'nullb sdebug'. Default value is 'nullb sdebug'.
+
+```sh
+To run with scsi_debug:
+THROTL_BLKDEV_TYPES="sdebug" ./check throtl/
+
+To run with both null_blk and scsi_debug:
+THROTL_BLKDEV_TYPES="nullb sdebug" ./check throtl/
+```
+
 ### Normal user
 
 To run test cases which require normal user privilege, prepare a user and
diff --git a/tests/throtl/001 b/tests/throtl/001
index 835cac2..89a5892 100755
--- a/tests/throtl/001
+++ b/tests/throtl/001
@@ -9,6 +9,10 @@
 DESCRIPTION="basic functionality"
 QUICK=1
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/throtl/002 b/tests/throtl/002
index 87b9f91..08e685f 100755
--- a/tests/throtl/002
+++ b/tests/throtl/002
@@ -10,6 +10,10 @@
 DESCRIPTION="iops limit over IO split"
 QUICK=1
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/throtl/003 b/tests/throtl/003
index d76a0d5..700e9e6 100755
--- a/tests/throtl/003
+++ b/tests/throtl/003
@@ -10,6 +10,10 @@
 DESCRIPTION="bps limit over IO split"
 QUICK=1
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/throtl/004 b/tests/throtl/004
index 777afcf..b1f6110 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -11,6 +11,10 @@
 DESCRIPTION="delete disk while IO is throttled"
 QUICK=1
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/throtl/005 b/tests/throtl/005
index 86e52b3..7691ad1 100755
--- a/tests/throtl/005
+++ b/tests/throtl/005
@@ -10,6 +10,10 @@
 DESCRIPTION="change config with throttled IO"
 QUICK=1
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/throtl/006 b/tests/throtl/006
index 263415f..2dcf3a3 100755
--- a/tests/throtl/006
+++ b/tests/throtl/006
@@ -15,6 +15,10 @@ requires() {
 	_have_driver ext4
 }
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test_meta_io() {
 	local path="$1"
 	local start_time
diff --git a/tests/throtl/007 b/tests/throtl/007
index 83d8dc7..97dece6 100755
--- a/tests/throtl/007
+++ b/tests/throtl/007
@@ -11,6 +11,10 @@
 DESCRIPTION="bps limit with iops limit over io split"
 QUICK=1
 
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
diff --git a/tests/throtl/rc b/tests/throtl/rc
index f5eb84e..d1afefd 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -10,6 +10,7 @@
 . common/cgroup
 
 THROTL_DIR=$(echo "$TEST_NAME" | tr '/' '_')
+THROTL_BLKDEV_TYPES=${THROTL_BLKDEV_TYPES:-"nullb sdebug"}
 throtl_blkdev_type=${throtl_blkdev_type:-"nullb"}
 THROTL_NULL_DEV=dev_nullb
 declare THROTL_DEV
@@ -25,6 +26,21 @@ group_requires() {
 	_have_program bc
 }
 
+_set_throtl_blkdev_type() {
+	local index=$1
+	local -a types
+
+	read -r -a types <<< "${THROTL_BLKDEV_TYPES[@]}"
+
+	if [[ -z $index ]]; then
+		echo ${#types[@]}
+		return
+	fi
+
+	throtl_blkdev_type=${types[index]}
+	COND_DESC="${throtl_blkdev_type}"
+}
+
 # Prepare null_blk or scsi_debug device to test, based on throtl_blkdev_type.
 _configure_throtl_blkdev() {
 	local sector_size=0 memory_backed=0
-- 
2.51.0

