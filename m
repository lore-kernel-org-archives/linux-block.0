Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B53A3831
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331423; cv=none; b=gBB1oiIioRpgupuCeFxoq/muxgYnZH4mWg3L3vdQiGM3BaiRuI/a7qi/YrEi+sVqyJbi9n/kN3VTA+db2xpGCqVAFM4+9xhGKI7CzybYqoBGkJklQC6fl5/Nqzl/S5S0zmPE9zqk8DcBScoWd/E5wzHWye40n6CPXFfrXbAEkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331423; c=relaxed/simple;
	bh=dfCqphHNhNsuTvZobjR69c/TDWubFq0+hDUydtOjZYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVfTUviFs7lGr8TDmc5pRNoL5fyvmLbxNt9z/AIncGVLCDNZdaiwC4Osfcf/teyXxXpGp5RQ7vgmbLt5Wzp+0guA4/g4+ltEpP/vmtH9CehxqQK/du8Ao2DF1S5oTJx+WiVKA22tdPF1e0MtnQLGiHp+kMEG9ThuFZKLe+2+GnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Jse1+exs; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jse1+exs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331419; x=1805867419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dfCqphHNhNsuTvZobjR69c/TDWubFq0+hDUydtOjZYg=;
  b=Jse1+exsBX7CpVAuf1FPmTpoPG6nU7+OAdMsFLdbOerzcrhk0Cg1lxbZ
   QbHEee59kf6cmH2Eel0fjAWN7VnRB15wnbt2yQ/2oq4jvrhzFD4W8iVBC
   hDyZaHkiJlnrrEnH/A3KwfHOsxsTu7YX5nBmw/Fgs/MMIUlMFmSye3EnX
   hCTvQHWve/D0vrMuKtMBQxPssdZl3A3pTmUD5xu4devwfRNqolfEDov7g
   BHQh3E2+wM5Z1NC3dOeV9eV+Jn+s2LnnoYCYN4QfOGGYv9glxBR0hJaWa
   e6j1xGXG67ZyWriJc6jPvJ2mIt9p2pL2/DY7FBzm7LmfBvYFg2Kqx0DOn
   w==;
X-CSE-ConnectionGUID: L/C644LgQUuS7uODRyFTbQ==
X-CSE-MsgGUID: DFWhew4sQsKP3d84gAmTPw==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614100"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c22602_sp3ZhQK7Lq5p5eo8t2LUtRcsg2kyeHavdEhbbHEy5XEfiDq
 BICuAol1kE6A6bu/1u3uU3Yl5XnBapfH7pKcvew==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:54 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/7] Skip tests if scsi_debug module is already loaded and in use
Date: Tue, 24 Mar 2026 14:49:47 +0900
Message-ID: <20260324054949.3821569-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Disha Goel <disgoel@linux.ibm.com>

Several tests across block/, scsi/, dm/, md/, zbd/, nvme/ require
exclusive access to the scsi_debug module because they load, unload
or reconfigure it. When scsi_debug is loadable and already loaded
by the environment (e.g., by another driver or a previous setup),
these tests fail with:

    modprobe: FATAL: Module scsi_debug is in use.
    Unloading scsi_debug failed

    scsi_debug            327680  4

To prevent these failures, this patch introduces a new helper function
_have_loadable_scsi_debug(). It verifies if the module is already loaded
by checking the ${MODULES_TO_UNLOAD[*]} array. If the module exists but
is not in the array, it indicates the module was loaded before the test
started, and the test is skipped.

Additionally, for cases where scsi_debug is built-in, the environment may
have already created additional hosts. To prevent the tests from disrupting
these hosts, _have_scsi_debug() now checks the add_host attribute. If the
number of hosts is greater than 1, the test is skipped.

Link: https://github.com/linux-blktests/blktests/pull/218
Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/scsi_debug | 29 +++++++++++++++++++++++++----
 tests/block/009   |  2 +-
 tests/block/025   |  2 +-
 tests/block/028   |  2 +-
 tests/block/032   |  2 +-
 tests/loop/004    |  2 +-
 tests/md/002      |  2 +-
 tests/scsi/007    |  2 +-
 tests/scsi/009    |  2 +-
 tests/srp/rc      |  2 +-
 tests/zbd/008     |  2 +-
 tests/zbd/009     |  2 +-
 tests/zbd/010     |  2 +-
 13 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index 8964558..97a65c2 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,13 +4,34 @@
 #
 # scsi_debug helper functions.
 
-_have_scsi_debug() {
-	_have_driver scsi_debug
-}
-
 SD_PARAM_PATH=/sys/module/scsi_debug/parameters
 SD_PSEUDO_PATH=/sys/bus/pseudo/drivers/scsi_debug
 
+_have_scsi_debug() {
+	_have_driver scsi_debug
+
+	if _module_file_exists scsi_debug; then
+		_have_loadable_scsi_debug
+		return $?
+	fi
+
+	if [[ -e "$SD_PSEUDO_PATH/add_host" ]] && \
+		[[ $(cat "$SD_PSEUDO_PATH/add_host") -gt 1 ]]; then
+		SKIP_REASONS+=("scsi_debug already has multiple hosts configured")
+		return 1
+	fi
+}
+
+_have_loadable_scsi_debug() {
+	_have_module scsi_debug || return 1
+
+	if [[ -d /sys/module/scsi_debug ]] && \
+		[[ ! ${MODULES_TO_UNLOAD[*]} =~ scsi_debug ]]; then
+		SKIP_REASONS+=("scsi_debug is already loaded before test")
+		return 1
+	fi
+}
+
 _scsi_debug_key_path() {
 	local key=${1}
 
diff --git a/tests/block/009 b/tests/block/009
index 7256afc..8995646 100755
--- a/tests/block/009
+++ b/tests/block/009
@@ -12,7 +12,7 @@
 DESCRIPTION="check page-cache coherency after BLKDISCARD"
 
 requires() {
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 	_have_program xfs_io
 }
 
diff --git a/tests/block/025 b/tests/block/025
index 4c48e9f..6582fa3 100755
--- a/tests/block/025
+++ b/tests/block/025
@@ -12,7 +12,7 @@
 DESCRIPTION="do a huge discard with 4k sector size"
 
 requires() {
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 }
 
 test() {
diff --git a/tests/block/028 b/tests/block/028
index 13b3278..c03ad6c 100755
--- a/tests/block/028
+++ b/tests/block/028
@@ -12,7 +12,7 @@ DESCRIPTION="do I/O on scsi_debug with DIF/DIX enabled"
 DMESG_FILTER="sed -r 's/(guard tag error at sector|ref tag error at location)/blktests failure: \\1/'"
 
 requires() {
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 }
 
 test_pi() {
diff --git a/tests/block/032 b/tests/block/032
index 5e25d0b..7f89a15 100755
--- a/tests/block/032
+++ b/tests/block/032
@@ -14,7 +14,7 @@ QUICK=1
 
 requires() {
 	_have_xfs
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 }
 
 test() {
diff --git a/tests/loop/004 b/tests/loop/004
index ca52d80..fc7e4b0 100755
--- a/tests/loop/004
+++ b/tests/loop/004
@@ -12,7 +12,7 @@ QUICK=1
 
 requires() {
 	_have_program xfs_io
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 	_have_src_program loblksize
 	_have_loop_set_block_size
 }
diff --git a/tests/md/002 b/tests/md/002
index 1349a18..e1da8b6 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -12,7 +12,7 @@ DESCRIPTION="test md atomic writes"
 QUICK=1
 
 requires() {
-	_have_driver scsi_debug
+	_have_scsi_debug
 	_stacked_atomic_test_requires
 }
 
diff --git a/tests/scsi/007 b/tests/scsi/007
index a638e20..8a8d4ea 100755
--- a/tests/scsi/007
+++ b/tests/scsi/007
@@ -12,7 +12,7 @@ DESCRIPTION="Trigger the SCSI error handler"
 QUICK=1
 
 requires() {
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 }
 
 start_tracing() {
diff --git a/tests/scsi/009 b/tests/scsi/009
index 8860e1c..41a5152 100755
--- a/tests/scsi/009
+++ b/tests/scsi/009
@@ -12,7 +12,7 @@ DESCRIPTION="test scsi atomic writes"
 QUICK=1
 
 requires() {
-	_have_driver scsi_debug
+	_have_scsi_debug
 	_have_xfs_io_atomic_write
 }
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 8585272..03fe55a 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -58,7 +58,7 @@ group_requires() {
 		_have_kver 5 5
 		_have_iproute2 190404
 	fi
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 	_have_module target_core_iblock
 	_have_module target_core_mod
 	_module_not_in_use scsi_transport_srp
diff --git a/tests/zbd/008 b/tests/zbd/008
index 55b5b6c..cdfbedf 100755
--- a/tests/zbd/008
+++ b/tests/zbd/008
@@ -13,7 +13,7 @@ DESCRIPTION="check no stale page cache after BLKZONERESET and data read race"
 TIMED=1
 
 requires() {
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 	_have_module_param scsi_debug zbc
 	_have_program xfs_io
 }
diff --git a/tests/zbd/009 b/tests/zbd/009
index b268483..a36ad71 100755
--- a/tests/zbd/009
+++ b/tests/zbd/009
@@ -36,7 +36,7 @@ requires() {
 	_have_driver btrfs
 	_have_module_param scsi_debug zone_cap_mb
 	_have_program mkfs.btrfs && have_good_mkfs_btrfs
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 }
 
 test() {
diff --git a/tests/zbd/010 b/tests/zbd/010
index c5cb76a..cb7202c 100755
--- a/tests/zbd/010
+++ b/tests/zbd/010
@@ -15,7 +15,7 @@ requires() {
 	_have_module null_blk
 	_have_module_param scsi_debug zone_cap_mb
 	_have_program mkfs.f2fs
-	_have_module scsi_debug
+	_have_loadable_scsi_debug
 }
 
 test() {
-- 
2.49.0

