Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C50C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 14:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiFZOYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiFZOYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 10:24:37 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FCADFE2
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 07:24:36 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AwANz/qIDl9VZ+L0/FE+R45clxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC61zlwhTBSnDEdDT+POauPNzH8c4p0aI7goU1XuZHRz4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkY/YcqeaXfRBTtuTWlSUqaUDEx/RoEVFzN4kf8eVfH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqgSuhqh88jLdPseoAWpXh7xDLYJekqStbIRKCi2DPy9?=
 =?us-ascii?q?F/cnegXRbCHOZVfMmEpMXz9j9R0Eg9/IPoDcC2A3xETqwFllW8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADHbHBqAySGECVuDlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="126329184"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jun 2022 22:24:35 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 937674D17189;
        Sun, 26 Jun 2022 22:24:30 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Jun 2022 22:24:31 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Jun 2022 22:24:30 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-block@vger.kernel.org>
CC:     <shinichiro.kawasaki@wdc.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] blktests: Split _have_kernel_option()
Date:   Sun, 26 Jun 2022 22:24:28 +0800
Message-ID: <20220626142428.32874-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 937674D17189.A4A34
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split _have_kernel_option() into _have_kernel_config_file()
and _check_kernel_option().
1) _have_kernel_config_file() will set SKIP_REASON when neither
   /boot/config* nor /proc/config.gz is available.
2) _check_kernel_option() will not set SKIP_RESAON when the specified
   kernel option is not defined.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 common/multipath-over-rdma |  3 ++-
 common/rc                  | 13 ++++++++-----
 tests/nvme/033             |  7 ++++++-
 tests/nvme/034             |  8 +++++++-
 tests/nvme/035             |  8 +++++++-
 tests/nvme/036             |  7 ++++++-
 tests/nvme/037             |  7 ++++++-
 tests/nvme/039             | 16 ++++++++++++----
 tests/nvmeof-mp/rc         | 11 ++++++-----
 tests/srp/rc               |  6 +++++-
 tests/zbd/rc               |  9 +++++++--
 11 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index f9d7b9a..8a2108f 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -19,7 +19,8 @@ if [ $ramdisk_size -gt $max_ramdisk_size ]; then
 fi
 
 _have_legacy_dm() {
-	if ! _have_kernel_option DM_MQ_DEFAULT; then
+	_have_kernel_config_file || return
+	if ! _check_kernel_option DM_MQ_DEFAULT; then
 		SKIP_REASON="legacy device mapper support is missing"
 		return 1
 	fi
diff --git a/common/rc b/common/rc
index d18144b..df9fcb3 100644
--- a/common/rc
+++ b/common/rc
@@ -149,19 +149,22 @@ _have_configfs() {
 	return 0
 }
 
-_have_kernel_option() {
-	local f opt=$1
-
+_have_kernel_config_file() {
 	if [[ ! -f /proc/config.gz && ! -f /boot/config-$(uname -r) ]]; then
 		SKIP_REASON="kernel $(uname -r) config not found"
 		return 1
 	fi
+
+	return 0
+}
+
+_check_kernel_option() {
+	local f opt=$1
+
 	for f in /proc/config.gz /boot/config-$(uname -r); do
 		[ -e "$f" ] || continue
 		if zgrep -q "^CONFIG_${opt}=[my]$" "$f"; then
 			return 0
-		else
-			SKIP_REASON="kernel option $opt has not been enabled"
 		fi
 	done
 
diff --git a/tests/nvme/033 b/tests/nvme/033
index 90aee81..0f58227 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -10,7 +10,12 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_kernel_option NVME_TARGET_PASSTHRU
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option NVME_TARGET_PASSTHRU; then
+		SKIP_REASON="NVME_TARGET_PASSTHRU has not been enabled"
+		return 1
+	fi
 }
 
 nvme_info() {
diff --git a/tests/nvme/034 b/tests/nvme/034
index f92e5e2..552c204 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -10,7 +10,13 @@ TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_kernel_option NVME_TARGET_PASSTHRU
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option NVME_TARGET_PASSTHRU; then
+		SKIP_REASON="NVME_TARGET_PASSTHRU has not been enabled"
+		return 1
+	fi
+
 	_have_fio
 }
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index ee78a75..8581e0c 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -11,7 +11,13 @@ TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_kernel_option NVME_TARGET_PASSTHRU
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option NVME_TARGET_PASSTHRU; then
+		SKIP_REASON="NVME_TARGET_PASSTHRU has not been enabled"
+		return 1
+	fi
+
 	_have_xfs
 	_have_fio
 }
diff --git a/tests/nvme/036 b/tests/nvme/036
index 8218c65..c747489 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -10,7 +10,12 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_kernel_option NVME_TARGET_PASSTHRU
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option NVME_TARGET_PASSTHRU; then
+		SKIP_REASON="NVME_TARGET_PASSTHRU has not been enabled"
+		return 1
+	fi
 }
 
 test_device() {
diff --git a/tests/nvme/037 b/tests/nvme/037
index fc6c213..92cff7f 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -9,7 +9,12 @@ DESCRIPTION="test deletion of NVMeOF passthru controllers immediately after setu
 
 requires() {
 	_nvme_requires
-	_have_kernel_option NVME_TARGET_PASSTHRU
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option NVME_TARGET_PASSTHRU; then
+		SKIP_REASON="NVME_TARGET_PASSTHRU has not been enabled"
+		return 1
+	fi
 }
 
 test_device() {
diff --git a/tests/nvme/039 b/tests/nvme/039
index 85827fa..00c6672 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -14,8 +14,17 @@ QUICK=1
 
 requires() {
 	_have_program nvme
-	_have_kernel_option FAULT_INJECTION && \
-	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option FAULT_INJECTION; then
+		SKIP_REASON="FAULT_INJECTION has not been enabled"
+		return 1
+	fi
+
+	if ! _check_kernel_option FAULT_INJECTION_DEBUG_FS; then
+		SKIP_REASON="FAULT_INJECTION_DEBUG_FS has not been enabled"
+		return 1
+	fi
 }
 
 inject_unrec_read_on_read()
@@ -128,10 +137,9 @@ test_device() {
 
 	echo "Running ${TEST_NAME}"
 
-	if _have_kernel_option NVME_VERBOSE_ERRORS; then
+	if _check_kernel_option NVME_VERBOSE_ERRORS; then
 		nvme_verbose_errors=true
 	else
-		unset SKIP_REASON
 		nvme_verbose_errors=false
 	fi
 
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 708196b..ea48c33 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -14,19 +14,17 @@ ini_timeout=1
 group_requires() {
 	local m name p required_modules
 
+	_have_kernel_config_file || return
 	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
 	# tests are incompatible with the NVME_MULTIPATH kernel configuration
 	# option with multipathing enabled in the nvme_core kernel module.
-	if _have_kernel_option NVME_MULTIPATH && \
+	if _check_kernel_option NVME_MULTIPATH && \
 		_have_module_param_value nvme_core multipath Y; then
 		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config \
 and multipathing has been enabled in the nvme_core kernel module"
 		return
 	fi
 
-	# Avoid test skip due to SKIP_REASON set by _have_kernel_option().
-	unset SKIP_REASON
-
 	_have_configfs || return
 	required_modules=(
 		dm_multipath
@@ -53,7 +51,10 @@ and multipathing has been enabled in the nvme_core kernel module"
 	
 	_have_root || return
 
-	_have_kernel_option DM_UEVENT || return
+	if ! _check_kernel_option DM_UEVENT; then
+		SKIP_REASON="DM_UEVENT has not been enabled"
+		return 1
+	fi
 
 	# shellcheck disable=SC2043
 	for name in multipathd; do
diff --git a/tests/srp/rc b/tests/srp/rc
index d44082a..38539cb 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -70,7 +70,11 @@ group_requires() {
 
 	_have_src_program discontiguous-io || return
 
-	_have_kernel_option DM_UEVENT || return
+	_have_kernel_config_file || return
+	if ! _check_kernel_option DM_UEVENT; then
+		SKIP_REASON="DM_UEVENT has not been enabled"
+		return 1
+	fi
 
 	for name in srp_daemon multipathd; do
 		if pidof "$name" >/dev/null; then
diff --git a/tests/zbd/rc b/tests/zbd/rc
index fea55d6..410e528 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -12,9 +12,14 @@
 #
 
 group_requires() {
+	_have_kernel_config_file || return
+	if ! _check_kernel_option BLK_DEV_ZONED; then
+		SKIP_REASON="BLK_DEV_ZONED has not been enabled"
+		return 1
+	fi
+
 	_have_root && _have_program blkzone && _have_program dd &&
-		_have_kernel_option BLK_DEV_ZONED && _have_null_blk &&
-		_have_module_param null_blk zoned
+		_have_null_blk && _have_module_param null_blk zoned
 }
 
 group_device_requires() {
-- 
2.34.1



