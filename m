Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C290C32774
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiHWANu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiHWANR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:13:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC55788D
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213529; x=1692749529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcWAWKQ+gQlcpUMQfxKLW7gJ8sGcBFqT00P9MNyZgyk=;
  b=i2b+LImNvh1QSkYugKkBhEyYYz/H5AzmT4iMKBqkVwaWwgZKMB9FJxCX
   uJ3gjJ+V8ffHB1LuBG3WaRdz5uYMMyW01PbVujo0gPP8uQ5IpB9w4qk/D
   GeWNLF89WL7tNN9ne+DEWe8BFKxsC6DTKR0+5IyUIsWm4lBf0At8W9ABv
   9tb6Nr7KbBK3Wc6+0ER80+gjSzUQMIl1sXJ3ivdDXT2o1+VCIMrLruqEh
   c1fdpecFUdVa7/i9P1//1sl3w1yViaoBeX+9pWL5kNZ183tNWhGzYGRhy
   uIETW1XvHi637mgaG06tfNNj+GToRTfwjnn/ACu0fQIInovgmLbXf93I8
   g==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645303"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:12:02 +0800
IronPort-SDR: o+waiWYaA3pfwVhGEGJK5ARLHHZyboKAyRk1gaqNDYZEsoxCHO4tKTRlnMeQ9QxbjlPGAa2ejH
 nyOd01k5IRlR+axrcutOWCmez2+s4KexyUAhiD9CPYiOADPvWtlbCU9EEqGD9Nms2lSovb7qmA
 oQvXxoBgUbR2d7oM99uhvDC1qbC4SdHkVlDKBpRy0kxCZgI5gWHIRebjW0yZX7dr5ndqT5l7rR
 u+tveQ+817taaVYq1nDZxrhiumAhk6w6Rx96tW9r7i8u4+DW6orUJhl3xqPL/K5KQ12ALP+StC
 ZZmeAoenWUOE7n8nolYIwH4+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:43 -0700
IronPort-SDR: CZN0W3mU2MoQfqsg5Fz6vyy4IgdyikuoDQcHZ3RUC0TxxLJdV2JvtcJFX+x5tVhozumbbkft89
 5Pm5TTdZ/Q2oYQxzvs837hdcoSBLv1eP8C6ougDQXJ/kUYOtbNxoJHWuAdYtbRK3vD1eNKhraI
 6muDeudRJmsGAGIf1iN0fpVJaw2t4ezixpLtncwJseNnxbsZX678PpecWM4G3IjiK3+jRj5Q6+
 kNnO2HJ4diJj5tqSRN9MURFn4D2gRcGMeiFX1rNoApfj0wA8iABLsHv7d9sn0wCLHhvGoctLFZ
 dTo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:12:02 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 6/6] common,tests: replace _have_modules() with _have_module()
Date:   Tue, 23 Aug 2022 09:11:53 +0900
Message-Id: <20220823001154.114624-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper functions _have_modules() and _have_driver() have similar
roles, but they take different number of arguments. The former takes
multiple module names and the latter takes single module name. To make
their usage consistent, modify _have_modules() to _have_module() to take
single argument. This improves readability by checking one module per
line.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc          | 19 ++++---------------
 common/scsi_debug  |  2 +-
 tests/nbd/004      |  2 +-
 tests/nvmeof-mp/rc | 32 +++++++++++++++-----------------
 tests/srp/015      |  2 +-
 tests/srp/rc       | 40 +++++++++++++++++++---------------------
 tests/zbd/010      |  2 +-
 7 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/common/rc b/common/rc
index 8681a46..be69a4d 100644
--- a/common/rc
+++ b/common/rc
@@ -57,22 +57,11 @@ _have_driver()
 	return 0
 }
 
-# Check that the specified modules are available as loadable modules and not
+# Check that the specified module is available as a loadable module and not
 # built-in the kernel.
-_have_modules() {
-	local missing=()
-	local module
-
-	for module in "$@"; do
-		if ! _module_file_exists "${module}"; then
-			missing+=("$module")
-		fi
-	done
-	if [[ ${#missing} -gt 1 ]]; then
-		SKIP_REASONS+=("the following modules are not available: ${missing[*]}")
-		return 1
-	elif [[ ${#missing} -eq 1 ]]; then
-		SKIP_REASONS+=("${missing[0]} module is not available")
+_have_module() {
+	if ! _module_file_exists "${1}"; then
+		SKIP_REASONS+=("${1} module is not available")
 		return 1
 	fi
 	return 0
diff --git a/common/scsi_debug b/common/scsi_debug
index 95da14e..ae13bb6 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -5,7 +5,7 @@
 # scsi_debug helper functions.
 
 _have_scsi_debug() {
-	_have_modules scsi_debug
+	_have_module scsi_debug
 }
 
 _init_scsi_debug() {
diff --git a/tests/nbd/004 b/tests/nbd/004
index 98afd09..deb9673 100755
--- a/tests/nbd/004
+++ b/tests/nbd/004
@@ -11,7 +11,7 @@ DESCRIPTION="module load/unload concurrently with connect/disconnect"
 QUICK=1
 
 requires() {
-	_have_modules nbd
+	_have_module nbd
 }
 
 module_load_and_unload() {
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index b7ca611..ed27b5c 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -12,7 +12,7 @@ nvme_port=7777
 ini_timeout=1
 
 group_requires() {
-	local m name p required_modules
+	local m name p
 
 	_have_kernel_config_file || return
 	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
@@ -25,22 +25,20 @@ group_requires() {
 	fi
 
 	_have_configfs || return
-	required_modules=(
-		dm_multipath
-		dm_queue_length
-		dm_service_time
-		null_blk
-		rdma_cm
-		ib_ipoib
-		ib_umad
-		nvme-rdma
-		nvmet-rdma
-		rdma_rxe
-		scsi_dh_alua
-		scsi_dh_emc
-		scsi_dh_rdac
-	)
-	_have_modules "${required_modules[@]}" || return
+
+	_have_module dm_multipath
+	_have_module dm_queue_length
+	_have_module dm_service_time
+	_have_module null_blk
+	_have_module rdma_cm
+	_have_module ib_ipoib
+	_have_module ib_umad
+	_have_module nvme-rdma
+	_have_module nvmet-rdma
+	_have_module rdma_rxe
+	_have_module scsi_dh_alua
+	_have_module scsi_dh_emc
+	_have_module scsi_dh_rdac
 
 	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma fio; do
 		_have_program "$p" || return
diff --git a/tests/srp/015 b/tests/srp/015
index e03b204..d303921 100755
--- a/tests/srp/015
+++ b/tests/srp/015
@@ -10,7 +10,7 @@ TIMED=1
 requires() {
 	# See also iproute commit 4336c5821a7b ("rdma: add 'link add/delete'
 	# commands").
-	_have_modules siw && _have_kver 5 5 && _have_iproute2 190404
+	_have_module siw && _have_kver 5 5 && _have_iproute2 190404
 }
 
 test_disconnect_repeatedly() {
diff --git a/tests/srp/rc b/tests/srp/rc
index 13dddf2..23f87e4 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -28,7 +28,7 @@ is_lio_configured() {
 }
 
 group_requires() {
-	local m name p required_modules
+	local m name p
 
 	_have_configfs || return
 	if is_lio_configured; then
@@ -37,26 +37,24 @@ group_requires() {
 	fi
 	_have_driver sd_mod
 	_have_driver sg
-	required_modules=(
-		dm_multipath
-		dm_queue_length
-		dm_service_time
-		ib_ipoib
-		ib_srp
-		ib_srpt
-		ib_umad
-		ib_uverbs
-		null_blk
-		rdma_cm
-		rdma_rxe
-		scsi_debug
-		scsi_dh_alua
-		scsi_dh_emc
-		scsi_dh_rdac
-		target_core_iblock
-		target_core_mod
-	)
-	_have_modules "${required_modules[@]}" || return
+
+	_have_module dm_multipath
+	_have_module dm_queue_length
+	_have_module dm_service_time
+	_have_module ib_ipoib
+	_have_module ib_srp
+	_have_module ib_srpt
+	_have_module ib_umad
+	_have_module ib_uverbs
+	_have_module null_blk
+	_have_module rdma_cm
+	_have_module rdma_rxe
+	_have_module scsi_debug
+	_have_module scsi_dh_alua
+	_have_module scsi_dh_emc
+	_have_module scsi_dh_rdac
+	_have_module target_core_iblock
+	_have_module target_core_mod
 
 	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma \
 		 sg_reset fio; do
diff --git a/tests/zbd/010 b/tests/zbd/010
index 6d634b0..35143b8 100644
--- a/tests/zbd/010
+++ b/tests/zbd/010
@@ -12,7 +12,7 @@ QUICK=1
 requires() {
 	_have_fio
 	_have_driver f2fs
-	_have_modules null_blk
+	_have_module null_blk
 	_have_module_param scsi_debug zone_cap_mb
 	_have_program mkfs.f2fs
 	_have_scsi_debug
-- 
2.37.1

