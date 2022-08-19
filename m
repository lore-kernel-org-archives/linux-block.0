Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F61C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348180AbiHSJjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348063AbiHSJjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2990790C78
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901969; x=1692437969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6obXhxhY9qtgAFL2tsIqRdOXxuO7TSXMR0YvdlunUPc=;
  b=aImxn/me67tflbvrHeHjvJHlh8eUv5zWtOoUvMJ6aNzya8ht7ux1pUbi
   1dJtmpKn275kco1lgHWnjZXFtkHlyUrkFrMDEXnMNdKMaiHkkvRB81N+q
   lPpOf+i2T7lTanIvt3V/DvSgoc0ZEkNJ6k7LEKd5JpP1I+gfhy6LGGSwl
   wfm1qlv/Zk5DeJ44P/hw7gq8WC/NBKHgsU3uu10H7ewnF+jpixlgDmLCg
   oGPwD8JOWGMuPJ42UUY8PHxoPUES2zQ7DI+22MBFJyh+Ex7hqhorGBmDg
   tOBflok6n0S4zZ1WJ9GyBgDa3SzwPdwHgMlIp7ig7pB5DjGovQ8aTjjSE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411561"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:27 +0800
IronPort-SDR: UTgMsRgTaF+mP9RhMMUAb9HmVhLy40PQFdsYBdk9Gko8Zg4nTj9d7hJMCcYlHmjto4fct3WK72
 BsX2Y1Wgr75ml6colyC9ds9kNAnh4Rv/zh4pT7rsYkpa7B+7qFLYN7w+etloO+53IhEDLumlle
 pE7FTz6M0AJLdtOolgAUOQimcdiZSneasWxMe3TafbUBe7llXpIy814mVh36qb1mmsIYZRdZZv
 q+lxac45ljZbHRrrFbJSiqJ2DDEYuI67CRe1wgVPGfgMV+rY6ZMVF3Gm1w0A0lg/F2COBCqtmf
 MHygIadpCE9rGX2rs1rLJy0N
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:52 -0700
IronPort-SDR: 9sJNSC3nqmfKSxOWrUq2Wr0eB0Q6GDWtwMTpF2+ftb492luV81QW+YTeNKMZ0pXKKoe7GvDmO3
 w8AQVLd5V92l3ix7kR5lVmrvjMYl2chszlJEqmrB8nqgpwXTHeSeLF6Zz0IMfPz9UPa5tK6lrM
 qqe8F++xN3lSyq2YPEjh1KD4A+TW3YrSpvkZk5FCsWKBMwWeVk4TnMTWV9kuQtFRN1BclNHYwz
 sQ6yGVEyub+0yrgSbMNHmMEqUXZESj/rdOJnPTKJkeZe1mj5CIztbcXSBxIr+Db4NcbuC0l8Mp
 8Yc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:27 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 4/6] common,tests: replace _have_driver() with _have_drivers()
Date:   Fri, 19 Aug 2022 18:39:18 +0900
Message-Id: <20220819093920.84992-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _have_driver() checks single driver but it is often
required to check multiple drivers. Rename _have_driver() to
_have_drivers() and improve it to check multiple drivers. This makes its
usage consistent with _have_modules().

While at it, replace single brackets in _have_drivers() with double
brackets to have consistent bracket style as _have_modules().

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
index 8681a46..fdeda24 100644
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
 
-	if [ ! -d "/sys/module/${modname}" ] &&
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

