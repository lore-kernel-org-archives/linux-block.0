Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFDC25B08
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiHRB0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242574AbiHRB0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7880A031B
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785990; x=1692321990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M33W326ck6VqWXZzKOxU9GqsWCe3rR0fORcGJbK42U4=;
  b=jxj2PrIyqaFwdu39lzohmzqP/Z1aqXr+jA80zh0W2M/bw1mGVDMzXNQB
   RbaKXTh1J8rj6qyzf+LitpBqIK40HfBtbuXEPuZeRq7cfsja2zModyWDn
   TC22tsJf6Ud04yDyWZu7rjDgIifvBXnEy7cNXeQUBcxteZx5JnzESyUpv
   tj7WcJYcJmKIqFTWfRkPnw8ApOT/Mvn5BcAFImemORcTmGkVGDP3wuWop
   j1CBvZwvv9NxzdsP8qbhrpQXqMi9rIQW/cnSJNQoH0Oqsp0tUc54UPJXe
   NVBPFv0vx6VC32HAEhq+WMHC174go5dtt94kehmdYHpJCBcdWOlNu6380
   g==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085642"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:30 +0800
IronPort-SDR: gotQ6YyuD8XIyGH2Y67lTn/smjO2rck8p/xZO0S9e3Sz8Di4oYw9LCZghS5apcmjxelrNz7f8s
 0dHRZ771Udyus/sBK76Gu8bvawhumxV1yKNDneZKX3O4ua+TNyGpkA2BWs6XiBKwPgdg4NYpkj
 qGWARtp2Z5knSLOIv55+ZS6AL1/K4u7edxexWC94jqOsWoQfqoBqJiD89Oq0q8GCKDcwKeOu5l
 oLN/PGA+gjvd+d4FbOBcmQJB2qKeOgr4zt/Ka4kPwKn9dm9bfiEldCKMHTYei/NVS76sdKvIWG
 /WJoVsQODpgfVnvmx2yViWrK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:57 -0700
IronPort-SDR: o2yXgii89pw7RAN0btsw3+VEulcfgtV4qi6cooJsZ0SipgIovdGUoJFPUBacMZjWmnzwPdiMFC
 xFFbuxKHUZPWJnz3Sc6BPb4whgupX5eHSpyWZ1Lw6KkamdAJiEjdnrH1QKwuG0PazxSkCBPGGh
 jix2YXF3mOQYT2MmVL1yK63YQJXT6qxa2TraWr9+vi1BfzY8YlxEkH7mkCwF1ha/bD1gIkb8Ck
 uH1cGXwS8OoDDDt3fJFasBmAASWXMhb3MZo0kHKoh+Xu4MWDnFv59QHnZvu1Qy6xfXKUb5axHW
 E1c=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:30 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 4/6] common,tests: replace _have_driver() with _have_drivers()
Date:   Thu, 18 Aug 2022 10:26:22 +0900
Message-Id: <20220818012624.71544-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _have_driver() checks single driver but it is often
required to check multiple drivers. Rename _have_driver() to
_have_drivers() and improve it to check multiple drivers. This makes its
usage consistent with _have_modules().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/null_blk |  2 +-
 common/rc       | 30 ++++++++++++++++++++----------
 tests/nbd/rc    |  2 +-
 tests/nvme/rc   | 12 +++++-------
 tests/scsi/rc   |  2 +-
 tests/zbd/009   |  2 +-
 tests/zbd/010   |  2 +-
 7 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 52eb486..15bb35e 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -7,7 +7,7 @@
 . common/shellcheck
 
 _have_null_blk() {
-	_have_driver null_blk
+	_have_drivers null_blk
 }
 
 _remove_null_blk_devices() {
diff --git a/common/rc b/common/rc
index ee2289c..4b01fc3 100644
--- a/common/rc
+++ b/common/rc
@@ -42,15 +42,25 @@ _module_file_exists()
 	return 1
 }
 
-# Check that the specified module or driver is available, regardless of whether
-# it is built-in or built separately as a module.
-_have_driver()
-{
-	local modname="${1//-/_}"
+# Check that the specified modules or drivers are available, regardless of
+# whether they are built-in or built separately as module files.
+_have_drivers() {
+	local missing=()
+	local driver modname
+
+	for driver in "$@"; do
+		modname=${driver//-/_}
+		if [[ ! -d "/sys/module/${modname}" ]] &&
+			   ! modprobe -qn "${modname}"; then
+			missing+=("$driver")
+		fi
+	done
 
-	if [[ ! -d "/sys/module/${modname}" ]] &&
-		   ! modprobe -qn "${modname}"; then
-		SKIP_REASONS+=("driver ${modname} is not available")
+	if [[ ${#missing} -gt 1 ]]; then
+		SKIP_REASONS+=("the following drivers are not available: ${missing[*]}")
+		return 1
+	elif [[ ${#missing} -eq 1 ]]; then
+		SKIP_REASONS+=("${missing[0]} driver is not available")
 		return 1
 	fi
 
@@ -98,7 +108,7 @@ _have_module_param_value() {
 	local expected_value="$3"
 	local value
 
-	if ! _have_driver "$modname"; then
+	if ! _have_drivers "$modname"; then
 		return 1;
 	fi
 
@@ -147,7 +157,7 @@ _have_src_program() {
 }
 
 _have_loop() {
-	_have_driver loop && _have_program losetup
+	_have_drivers loop && _have_program losetup
 }
 
 _have_blktrace() {
diff --git a/tests/nbd/rc b/tests/nbd/rc
index 32eea45..d3ec084 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -11,7 +11,7 @@ group_requires() {
 }
 
 _have_nbd() {
-	if ! _have_driver nbd; then
+	if ! _have_drivers nbd; then
 		return 1
 	fi
 	if ! _have_program nbd-server; then
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ff13ea2..df13548 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,23 +18,21 @@ _nvme_requires() {
 	_have_program nvme
 	case ${nvme_trtype} in
 	loop)
-		_have_driver nvme-loop
+		_have_drivers nvme-loop
 		_have_configfs
 		;;
 	pci)
-		_have_driver nvme
+		_have_drivers nvme
 		;;
 	tcp)
-		_have_driver nvme-tcp
-		_have_driver nvmet-tcp
+		_have_drivers nvme-tcp nvmet-tcp
 		_have_configfs
 		;;
 	rdma)
-		_have_driver nvme-rdma
-		_have_driver nvmet-rdma
+		_have_drivers nvme-rdma nvmet-rdma
 		_have_configfs
 		_have_program rdma
-		_have_driver rdma_rxe || _have_driver siw
+		_have_drivers rdma_rxe || _have_drivers siw
 		;;
 	*)
 		SKIP_REASONS+=("unsupported nvme_trtype=${nvme_trtype}")
diff --git a/tests/scsi/rc b/tests/scsi/rc
index 3b4a33c..d9750c0 100644
--- a/tests/scsi/rc
+++ b/tests/scsi/rc
@@ -15,7 +15,7 @@ group_device_requires() {
 }
 
 _have_scsi_generic() {
-	_have_driver sg
+	_have_drivers sg
 }
 
 _require_test_dev_is_scsi() {
diff --git a/tests/zbd/009 b/tests/zbd/009
index 483cbf6..4d6a637 100755
--- a/tests/zbd/009
+++ b/tests/zbd/009
@@ -33,7 +33,7 @@ have_good_mkfs_btrfs() {
 
 requires() {
 	_have_fio
-	_have_driver btrfs
+	_have_drivers btrfs
 	_have_module_param scsi_debug zone_cap_mb
 	_have_program mkfs.btrfs
 	_have_scsi_debug
diff --git a/tests/zbd/010 b/tests/zbd/010
index 6d634b0..ef5e0fc 100644
--- a/tests/zbd/010
+++ b/tests/zbd/010
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_have_fio
-	_have_driver f2fs
+	_have_drivers f2fs
 	_have_modules null_blk
 	_have_module_param scsi_debug zone_cap_mb
 	_have_program mkfs.f2fs
-- 
2.37.1

