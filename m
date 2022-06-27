Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81BEC43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 07:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiF0HlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiF0HlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 03:41:13 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDDDF60D7
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 00:41:12 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AmeXoeKDwEn/BkBVW/xXhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fU1K/hjgl1jFSmmofXmvVO6rcYjGgfN0jYI+39UhS6pWAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSX8jYvMcpeOvzX+X9Jb7I1f9W3/txeh+SUsyOoYb0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqe27K6TOhnhsU5K4/oNZwWoXhjzBnGAf1gSpfGK5gmT/cwM?=
 =?us-ascii?q?CwY35gIRKiBIZFCL2cHUfgJWDUXUn9/NX70tLzz3xETqwFllW8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AM0VF96vznvZI1E2fIepkttBJ7skDntV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHvJYVcqKRYdcL+7WJVoLUmxyXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLhuGO/9SKIUzDH4BmupuIC5IOauEYE2IK9vrS0U2pFco62tmb/OSNjefa?=
 =?us-ascii?q?9X1kSgZncMhbnn5EIzfeAktrXxNHGJZ8MJKd4/BMrz2mdW9SQd+8AhA+LpD+ju?=
 =?us-ascii?q?yOhJT7egQHGhJizAGPiAmj4Ln8HwPd/jp2aUIo/Ysf?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="126576254"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jun 2022 15:38:29 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 2A4264D16FDF;
        Mon, 27 Jun 2022 15:36:26 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 27 Jun 2022 15:36:25 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 27 Jun 2022 15:36:26 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-block@vger.kernel.org>
CC:     <shinichiro.kawasaki@wdc.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests v2] blktests: Add _have_kernel_config_file() and _check_kernel_option()
Date:   Mon, 27 Jun 2022 15:32:49 +0800
Message-ID: <20220627073249.34907-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2A4264D16FDF.A887F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

1) _have_kernel_config_file() sets SKIP_REASON when neither
   /boot/config* nor /proc/config.gz is available.
2) _check_kernel_option() doesn't set SKIP_RESAON when
   the specified kernel option is not defined.
3) _have_kernel_option() combines _have_kernel_config_file() and
   _check_kernel_option() and then sets SKIP_RESAON when
   _check_kernel_option() returns false.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 common/multipath-over-rdma |  3 ++-
 common/rc                  | 29 ++++++++++++++++++++++++-----
 tests/nvme/039             |  3 +--
 tests/nvmeof-mp/rc         |  6 ++----
 4 files changed, 29 insertions(+), 12 deletions(-)

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
index d18144b..bf6cd10 100644
--- a/common/rc
+++ b/common/rc
@@ -149,25 +149,44 @@ _have_configfs() {
 	return 0
 }
 
-_have_kernel_option() {
-	local f opt=$1
-
+# Check if the specified kernel config files are available.
+_have_kernel_config_file() {
 	if [[ ! -f /proc/config.gz && ! -f /boot/config-$(uname -r) ]]; then
 		SKIP_REASON="kernel $(uname -r) config not found"
 		return 1
 	fi
+
+	return 0
+}
+
+# Check if the specified kernel option is defined.
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
 
 	return 1
 }
 
+# Combine _have_kernel_config_file() and _check_kernel_option().
+# Set SKIP_RESAON when _check_kernel_option() returns false.
+_have_kernel_option() {
+	local opt=$1
+
+	_have_kernel_config_file || return
+	if ! _check_kernel_option "$opt"; then
+		SKIP_REASON="kernel option $opt has not been enabled"
+		return 1
+	fi
+
+	return 0
+}
+
 # Check whether the version of the running kernel is greater than or equal to
 # $1.$2.$3
 _have_kver() {
diff --git a/tests/nvme/039 b/tests/nvme/039
index 85827fa..e175055 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -128,10 +128,9 @@ test_device() {
 
 	echo "Running ${TEST_NAME}"
 
-	if _have_kernel_option NVME_VERBOSE_ERRORS; then
+	if _check_kernel_option NVME_VERBOSE_ERRORS; then
 		nvme_verbose_errors=true
 	else
-		unset SKIP_REASON
 		nvme_verbose_errors=false
 	fi
 
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 708196b..2ae80c3 100755
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
-- 
2.34.1



