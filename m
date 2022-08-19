Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C0C32773
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348179AbiHSJjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348180AbiHSJj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B997D1DE
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901967; x=1692437967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFET1SUx0caKxsTQyMuZvm0KziFkHquAoaowiYDawa0=;
  b=fFky4/lqpfoMcU6JVD7phHY8MYXaLWrPi/aRe+y5ZmrQjdmRHPwiBE16
   boDDK7cHfLfrv7YpjZqWxxwdOMdaff3GVSBaPXdCj6H+MYpYMbRyxmFfY
   BU6wmn/2oudFc39tdNhYGVBBtK5dQErpJDj4gVtxHZqmnfUPRIsYJAHRQ
   57nrmkuUTsRRpO3HCTbepZ/SN7CkhpF+/5uP/vmGRwT6Ww61Nens+Txi4
   KaLqjIZIthxQJGG6X+L5Oak8z5/3RDaQ8bOOOStHgUsEjmM9SIZ4MIC6P
   3XZEJDkRD9LVtcwJAXU6zB5s3d9aQzFWJwjfP/jhEcIZsCqr2N4YYy1yF
   g==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411553"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:26 +0800
IronPort-SDR: yJXmNzVxBC12axSwlsG5rEmoGvENjNSyCK+4Gkrm9MitVz9p0aWxc2kgtdhe0HgNg2kIPD4yTV
 VUY/cOah87W4rEBS27OjJZWEpwkpqiKOzgaie3QRM0Ybk9MArEa/b246yrgerVCDO/VsoODr86
 dxe0IXrs1mUTiBPra/BEeQEOy+GRHKCbFD4+hGz9/2VuF6aVOMdFl0H3JOGaSzfOPtGzOfEJP4
 1bMcoFeIPe0SMkpPNNgvHnAIa30fYCY/xYHeawDQS67ijW6gl+Q27PUhZ2OswYec9UYjOL3eJw
 dQqKm/bp8JGe2pS7tS3HjYVY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:50 -0700
IronPort-SDR: /D9zJMykwUde/D77kXcieIX9pS5inlqv19IKmnXaFCVn+cA2r+6PuXQVw5EieUDO1mC7BV0Pr3
 KFS0bkhYW/V50fIXGCgqAesDc9HNoaY7dsJSosc5jFqPJ1QcS+RnjIaoNMG2NnrarLXVKeNY0C
 pz0yBW5Sxl7WslHrSgOBh3sV9SwMsqkJJRLtZTBKFNtDgWkvhisZIXpcxbtufHYRPBVCjd9uf1
 8jfYUsj5XBJxrpLvjjWtwwIIYMoFLjpgK1/I/KLkCtN3r+syBR+0H58Q6UGBj+2XeiqtLPXQ1q
 dcY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:25 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 3/6] common/rc: ensure modules are loadable in _have_modules()
Date:   Fri, 19 Aug 2022 18:39:17 +0900
Message-Id: <20220819093920.84992-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
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
index 5b34c60..8681a46 100644
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
+	count=$(find "$libpath" -name "$ko_underscore" -o \
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
2.37.1

