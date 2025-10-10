Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F26246BDE
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084409; cv=none; b=KG19d/ZEF7s1cNqIaVPLY7HOCSeRWgWoeqcf/vNoRMZpb+DNJgBog7cxnfT/9wb4yADSTFixJm6zJV0ckeGXWqJCx70Zl/fHZ/fG6928c6J3Ddsv0QSm/V/6Ya8oXfrU+ikHplSmWS37TdM4Wsqe504sgtof+yV4iAcVfEq6dXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084409; c=relaxed/simple;
	bh=fQhrbWry1m36ZBFywyj1t+nNDPAvr0m6s5bxIf27sDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INpY753WQ3zTEcgUYU80FhMUwY7VTLPYXGfGksXjK4rZTb4oPxa9+7/a5Bwsmnne3rogebIkrqSwgunwEJh6h+35O0965GNsdMWFTPmNObiFrKLD2P43hZopPFbPfr9yqRT6XGomw3fcF8n7jj1rW9xMsHpjHAmQfmvW0yKk8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A6Dntn3P; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A6Dntn3P"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760084407; x=1791620407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQhrbWry1m36ZBFywyj1t+nNDPAvr0m6s5bxIf27sDg=;
  b=A6Dntn3PaReMwNfbl0+/Je8fj8HGHK8/7K4UEXGxPLvgqmJMDgo1VIOf
   OEGPI2+anOXte50vpqilTjJWiWatepybOTtqJkN1XCN+HWzeY9WfAVsgO
   F8EQUF5fgZPNp+9IJVseYxTFfYWFmYnJVzSAm+9E5q9ZTCBrOYCm8xx0z
   r5WI7CRxSD5cosjJWpQC72Bz0rsg4JAQjjS704h9tFKakv7o8a5NPhfkj
   L98QS3PGtoNxzuC8jqn08N0JdWNJaFMKcc0i6yM76h8JXoFLYZBiziHMU
   H2vpPFp1Nuf9npg7L1VqCqq2LK56OJ21pR0OrGIhPe+sgXpNJ0r6KpQ/o
   w==;
X-CSE-ConnectionGUID: kfX9D90lSGehKHumM/kjqg==
X-CSE-MsgGUID: uxm680nmRrGeByV0utfc1A==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132653548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 16:19:57 +0800
IronPort-SDR: 68e8c1ad_5tMVbSqoa4DsAnn4MdC7CMK8vLLpvjdhlcyU1l8CbihuI0l
 A1AyrGi3Om0NmA9XJEk7O1mqPZOjC2xUzf4uBMg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2025 01:19:58 -0700
WDCIronportException: Internal
Received: from 5cg2148fq4.ad.shared (HELO shinmob.wdc.com) ([10.224.163.88])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Oct 2025 01:19:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/4] throtl: support tests with both null_blk and scsi_debug in a single run
Date: Fri, 10 Oct 2025 17:19:52 +0900
Message-ID: <20251010081952.187064-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
References: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
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

The command line below runs the throtl group with both null_blk and
scsi_debug:

  $ sudo bash -c "THROTL_BLKDEV_TYPES='nullb sdebug' ./check throtl/"

Of note is that the default value of THROTL_BLKDEV_TYPES is 'nullb'
since throtl/002 currently fails for scsi_debug. While the default of
'nullb sdebug' would provide broader coverage, 'nullb' is chosen to
avoid the potential user confusion because of the failure.

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
index 8ccd739..a22043c 100644
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
+  test with both, set 'nullb sdebug'. Default value is 'nullb'.
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
index bed876d..b082b99 100755
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
index c7539aa..70254f7 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -10,6 +10,7 @@
 . common/cgroup
 
 THROTL_DIR=$(echo "$TEST_NAME" | tr '/' '_')
+THROTL_BLKDEV_TYPES=${THROTL_BLKDEV_TYPES:-"nullb"}
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

