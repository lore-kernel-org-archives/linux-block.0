Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6697C3F6B0
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiHRB0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242574AbiHRB0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E64A1A4D
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785989; x=1692321989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tYaAQ7mV6RGdu7wNnqXIDpi/EGElDG83oOeRqsY1Rk=;
  b=e6vSQm33SL5dGFO9B0u/j5yBw7tBC3gtEg+g9+tLvXmm4NJ+C0WPVoM3
   eSMLM7WhGXoZhfeqC2CQOR9i3eSkpKhENDHTxqs1HEs3Zr1ObaXZmy8E4
   KUEzXf8g/DSUqIVauDC0vlC5bwW0BeFaGuVsbS9ILXedbTbfPB8DtWGnE
   A1cVSGcNKrTIDjeDhppbKbWGKDgXRIlNN88xurmhR3BLr2IYANSDRD3uR
   oJ6C40EImbI9T/AygGOBWT8IuxLl4SOCnmVNyrftdMnG7RV+CRWXMEiY9
   0Hdj3NKk3XgqVTs9W827deY9pLemPuBq9F/GA/MVyssR9JPLe8MR9RC6Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085641"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:29 +0800
IronPort-SDR: qt1pJwaKz5TIjtEY0uNWUoitPI1QVeIGua0q+aIJhm/zY/5UMk7E/i6N710haFpfN1zVGP6wqw
 p7h3BnFcx+P2BL9896JZ+DCuQAY/wV4rJwaQpGDEZWZrShvFNoamrZjw+xF+bWvhOAxUWxkTQG
 BhhBUci4nDjCKlql7l63ogh2M563NPns8SuBgyjuFSHkCLYYeoH5BHFS2sWA/qf0FftaC7/UO2
 vRtHhBiC1gbHBPRTFqjAHo3O8CCUZqPL451oemv/d9UqpyxGhi18hA5ySNvV0UlfMPIiL9jWFQ
 czBbLRBcvkbVMn6gR1NdnPfy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:56 -0700
IronPort-SDR: j0O2FWgQmXMeCuw6mHtHqfy/wzNWCZUk54ppXlrZfvo0FRODV9eTwcAwuZx+nUjzafR7hj/u1a
 T4nRqU51CoQHzkFe49FT7fjLbH6Hr2Maexq+0L7nC0tkro10M9XJFT6KDqm5BU1nNmZ3i747bN
 iQIz0/87BQhXtgavN3H6EyRXMVi5HMyTxq9tWaoeuFz9P5SanNWhtf4EE9drarYcCQJsO6KW5q
 j1+MQGadX8Pz5hzdz/V3ODbANHB0zXgIt8URm0N7uI6hyIHso1oxeVdclnImuVZUtUZ6ai2BS9
 qh8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:29 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 3/6] common/rc: ensure modules are loadable in _have_modules()
Date:   Thu, 18 Aug 2022 10:26:21 +0900
Message-Id: <20220818012624.71544-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
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
2.37.1

