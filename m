Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C3C28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiHWANt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbiHWAM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:12:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADFA57574
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213524; x=1692749524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/XFfV4kCUhvf4bZuDwajupxV3MKZBJzi/NHaXHlh/w=;
  b=giYEQxXF2NRdPS4OpQTsNfn9W4AfRoCxnVrPJd6sP5oXM4XLFYl7T4Ho
   Q9gIfX+rMrQMqtBDRIpcFTrgIQNMOiJ3SgJKAAqiR/QHOso6bCdHy3HB3
   z31I/l95bNb70lh3cFwdOFb4U4rLAD3SKdbeYfLBv7lEdM64umgm+2Jc9
   UAFmzWl3FAAM3m7E3m40m+ytfa2plq529p5YYRme3SXhgaWpCQKuHb3Ja
   0jIL5QAhxKZ7kkPz0wmB/+eWokwHLg9VRGpNWrU3ooSKhVc0erB/JaHa2
   Yn3pHIVa/pzPPqJ7Ms9J+hq6SdhTZ4mrH7D/v9QMUX3epKTdgZNLzwcYT
   w==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645299"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:11:59 +0800
IronPort-SDR: UnkEELwsD7+IbALB404XNVbEYulUSo9HluaRoTZnMgU2xGxqnbeRTQZg/br1nLKmh+cmDMv5Vb
 CATprOqmHWwK/DRIk7NMRBqt7FBlFgP4WGKz1bmpW5ly0LUdI5inaPP0giRHiiKbapt3E+ug3L
 RbKdigR2xBzEGhVWn4azlcIq6HaboGL7ICx3R9JvT1ejLklQLSGRp4gnnx0fUPOcZSCLUcgXvz
 KZCwOVZrAYhW2YpSiDO6nW5Nyf23rbPhd3Diz1xOKuNb4qQjeIMq9T69aJo+qWLldpeS/qvBh0
 CAGMV6k2Xb99Qp/1iQp3/Jt8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:39 -0700
IronPort-SDR: Vt9Ro6Ar2qSjXdRkXRDeX9tuzM7lfvBTPghLO4WWFeTzRGmOo+fmNOZNypL6a+uVQcwx8wKZCX
 CEO0iY/dvGRtMkYb/0ujHrBa0IieabCnVAZRacr26Pfpgjs66mWQ6EnHtYgZnzN+p3MJtaRFEw
 WjyQ/v5BBHG+R5NzoHwJapnnlRS55f1J7s9uSHze7PTuCvT6pPGF48qczK4CqivAqH9WbB0Jfc
 gf7ArzcSxkIwdO2BbcgKG88Q342b7V9VSA1V28i3W6pdmlT6gUXhJ918r5s2f9h2M90P1dZ5yF
 yFw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:11:58 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 3/6] common/rc: ensure modules are loadable in _have_modules()
Date:   Tue, 23 Aug 2022 09:11:50 +0900
Message-Id: <20220823001154.114624-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

