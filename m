Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF2C3F6B0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiG0Iw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiG0Iw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFCE46D89
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911976; x=1690447976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3DvL2Kg2gd7W9ys71YLEKa5R2XUTS0He9LVGavCq4vE=;
  b=chXOGUlVc+6hZcOb85f/iksPiE1RukWVA8G1LfDzSisG6/oZGYYjjnSq
   JGtVIl+dreDrsEGxNVOrRQNTNXRNu5eYQInRFOWwVyRbWCXIotkvVT0PK
   +Pt3iJyNrqmAE1LMtcVJeTaMzp2xrU/TCqU9U941hPlJARlpYGjFX3Kfc
   mUttmasFTXZQXIafmBFKr5gnxRbemns/vsW1FtbYfZjISR+zsWK+EB8el
   axxsrB7FeGAj+sCgxA0W3KoDEOXZGPariLONvpGnYF0SDLlSo1SDWUdob
   YQqHWU523bmM80QnKwL0T68LoGgrFMdxDEv2c7Qbky3K1jGs/9AF+Jnwz
   A==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584983"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:56 +0800
IronPort-SDR: 6Nj0BKzZF/gtX04SdomMx5jOuxSmabDHQIob+6VBvKOrDjDPFOg4u9gdL/SH24oPMgiLtGpTrv
 xE2N9bNh0XEKYs4CN2J31owqwd2dUxPFRVnnPeDtBHXdNHfykMnicQ4KRhHQoq5ERWVFlOZtQX
 tI9ArdnbGoW+OtvFEGWci0kmvn6ZNSHrkft0iIRVohFuSscXrfN5ydVvX46K+hnaMVFJQAbUiT
 GKA4PPkcGsV07hEpVDuAej7G8fIgOi7hDj3uK4Xthk1hl7Sg0QihM6XhOjIDwZL+0+aHPuLUn9
 oELhSEvFuEY5N2ss+iyt4EgU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:08 -0700
IronPort-SDR: eE24adwTteVdiqIK164dtNNWl4JnXEpxIpHPdFc15OXhD/TKPFN2MFcrie2Jg0xHJYL4sceb1h
 UET6xm6Efr7eu73/YHAzwwjsCsDFsO8+CujNdmDxVIqYLo/MT/DpBnxPQzK74mSFDbdqbOnXiF
 kIbLjf1kRRkJVYzd0tTK0zLDkSD2XLpFmd2bfAckdVzw8hBLJ4trpPU0kxho489vPdx5YYDTLY
 7ffMoL5jxleSledbT9z7pLhvolsaAe1p4dOYN+qsQwDCWRE4uFU8Nc33j4rA5plOWqSmrit7sw
 L3E=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:56 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/6] common,tests: replace _have_driver() with _have_drivers()
Date:   Wed, 27 Jul 2022 17:52:49 +0900
Message-Id: <20220727085251.1474340-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
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
 5 files changed, 28 insertions(+), 20 deletions(-)

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
-- 
2.36.1

