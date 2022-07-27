Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5FC19F2C
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiG0Iw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiG0Iw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE546D88
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911976; x=1690447976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2obaopggOapRz6dEOPBLVSK8fM+e2f3KuoJzYWGrSzk=;
  b=MUlmASGC3d7IysTn0ejOHuHR9M3mpeKucCsNX3nBzlTfj21OYdj5wP/0
   c2HLbKovGsHUT00Khp4UXr2VJgO9GloNTeQ1vzH9T1gYC1cpr8lHCN6Zy
   tB/BzcZb2z6qjzMD9TOininbK87uxzmTNrVMdOzOsavllXRes62TqtUr2
   zZ9wa4vQiKu+guQugN4rwRLTqHyavkxNox1bFIjdO1tv8Mr2eRiFjka11
   EXp+GUEK40ifo70EjpUcc1iZW0IJssWLUxJ0EZioziErU81AJsqp3t6dX
   iIY2xd3sirpJGC9MJeT735rPXtvdepOrGfKKn2kOhsdSCGlkvCL+4kW00
   A==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584980"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:55 +0800
IronPort-SDR: 5HusYWdUpGwgOrs/3IvoLwDWSlBC6hyWuqjfbXhTKgRBA8YLC0QLKCFZHSRTfeRFxHpZQXulcD
 igKzrictzFtWSSfeqi2Ow7beux/jg60rEwidZXAMr2lWfsb8Gaah80X5UILnc/WaQNF7oCk0wi
 LWOld4uD6HCnOl9SEnEFpiQjbHQ0jxXzYC2DJz5VA4RcBQJUbJQqrCaCx945PAz5+Oo3B2CQ4/
 QZ6v8K5d7x0Yb48X8Z/M5g4yuH9s6aUR5ZNAKUb08agUN5tS3RAmXYZ1NBk28cTSsqgP83V++9
 XM+XdBnsTc02njvGPQOYmiGQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:07 -0700
IronPort-SDR: OzU8ATJEKRBcaIseZCwCrUAotgk0QmCjvbUgU9hqBiURpHW68DAnSYSrtddw2fANs3ywFWPndm
 YJz8/Na8cjh2pA4EtPm7TyLDcyp4aW7TI2n2kaCTUfqaFh69nSQ1d+QXUX5/R5oKVb4kD+vukp
 VFocglxD7rHGJRL/0QSp2kJpR9dmotSrs6sxWoADFq5KHCh8SmbbkS506n8LRBz1XP/Q4gmxb2
 ChaCI0q1qcGFEAfYBh935866aApNOVLDZ/GFNP6la66w0+xvkJpJ5JnHytKggDlodPbpncwCp3
 W+s=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:55 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/6] common/rc: ensure modules are loadable in _have_modules()
Date:   Wed, 27 Jul 2022 17:52:48 +0900
Message-Id: <20220727085251.1474340-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit e9645877fbf0 ("common: add a helper if a driver is
available") introduced the helper function _have_driver() to check the
driver or module is available no matter whether it is a loadable module
or built-in module. It was assumed that _have_modules() whould check
that specified modules are loadable and not built-in.

However, the function _have_modules() returns true even if the specified
modules are built-in and not loadable. This causes failures of some test
cases on test system with built-in modules such as nbd/004. It also
means that _have_modules() and _have_driver() have same functionality.

To avoid the unexpected failures, fix _have_modules() to return false
when the specified modules are built-in. Check if loadable module file
exists by searching the module file path. If the module file does not
exist, return false. Also add comments to describe the difference
between _have_driver() and _have_modules().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 8150fee..ee2289c 100644
--- a/common/rc
+++ b/common/rc
@@ -28,6 +28,22 @@ _have_root() {
 	return 0
 }
 
+_module_file_exists()
+{
+	local ko_underscore=${1//-/_}.ko
+	local ko_hyphen=${1//_/-}.ko
+	local libpath
+	local -i count
+
+	libpath="/lib/modules/$(uname -r)/kernel"
+	count=$(find "$libpath" -name "$ko_underscore" -or \
+		     -name "$ko_hyphen" | wc -l)
+	((count)) && return 0
+	return 1
+}
+
+# Check that the specified module or driver is available, regardless of whether
+# it is built-in or built separately as a module.
 _have_driver()
 {
 	local modname="${1//-/_}"
@@ -41,12 +57,14 @@ _have_driver()
 	return 0
 }
 
+# Check that the specified modules are available as loadable modules and not
+# built-in the kernel.
 _have_modules() {
 	local missing=()
 	local module
 
 	for module in "$@"; do
-		if ! modprobe -n -q "$module"; then
+		if ! _module_file_exists "${module}"; then
 			missing+=("$module")
 		fi
 	done
-- 
2.36.1

