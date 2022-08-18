Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37A2C28B2B
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbiHRB0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiHRB03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB2A031B
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785988; x=1692321988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OWpSCTcZijPgiFp6MTHHj4KNHWiOMwVmdoA8J0Xfcc=;
  b=Z8DOyKI8nB9t56BS4zMu6QLvO74gXYU3lo3b18MtEfweh2zefBa2vo1l
   savl7aOCAfNyM+k82ixyKcmxt65azRUWq7stiqGsCc9/F2aWIv9bLz0Xc
   CJ3qICiN1Lt/arRVmpfQ31g50I2hVSIkbWqKwUHIcxBdlbCFLdoXLmUYa
   TzDcOf7ACKWIaJW4CfcKq9olxU/EIV+RMi7I3TZAc2YaOk5TOPvpk5Nzg
   oTNaz3RprQuL1ci9HtMJna1hbYIUbCzzoem5PgHx4hizXmwgS63sPbLLa
   aOUuwo6+0ZF4cv1NVrTqvPZMJ4DNzMgvn78nf3DO+owd2gZIm+R9izwjw
   w==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085640"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:28 +0800
IronPort-SDR: UKj8CkhIstvyiC3rlbg97bu6eJ7FTEYdQ54AC82nRvt4gYfxFnwe/ahd8ivhyZno2rVWcJl+4r
 RXLkd6ASG2UWoIAydbt13rNZatj4gJWjRfCVV7fZ67bOSa8kMBomyHWje7PHULMF2HJJAXoTMM
 hEPRDWBG2XnqTQvrtVYSA/NjuVqphfQI+xeieTD0GlMirdzt+2sy6+xKoFohcgOtJVujTME50R
 cn+efK0TMq23flTCV2ISnVKw44VnrFYS4geoJBUf92G/RIyq+BowcV9t22aF9KzJ0MxZoMg3LZ
 lo4sTaJh4tEBGIgLFgC7ogRr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:55 -0700
IronPort-SDR: y3DGspFYXxqHhBzttORfKQy5achm9pj9KplLb8pbHcJ2B0LzjF93YJjoszgZQ/IxUiaPu/bVVT
 Cgi4OT7cGKnm/ggf97nLceFVqnMADtSPxO2mfPeaBemOaARzkhW0tk553weoXy4iOfzsqqPBcj
 IkDr2Sh2CLJ33lxiQZhX42Xhmx6luY5KRwWK2JsewpNaQRMVyyKyxsG8VZAM/Q5BsE10aQaiev
 RzU79Rr/wFNbkWAxA+I7eKd3PkLkPBdUhteiTJ4Y1nQEohaeVjJiO+bJjxX+Cpn6jtAU3f/Usp
 lzc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:28 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/6] nbd/rc: load nbd module explicitly
Date:   Thu, 18 Aug 2022 10:26:20 +0900
Message-Id: <20220818012624.71544-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After the commit "common/rc: avoid module load in _have_driver()",
_have_driver() no longer loads specified module. However, nbd test cases
and _have_nbd_netlink() function assume that the module is loaded by
calling _have_driver(). This causes test case failures and unexpected
skips. To fix them, load and unload modules explicitly in functions
_start_nbd_server*(), _stop_nbd_server*() and _have_nbd_netlink().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/rc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index 9c1c15b..32eea45 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -28,17 +28,21 @@ _have_nbd() {
 }
 
 _have_nbd_netlink() {
+	local ret=0
+
 	if ! _have_nbd; then
 		return 1
 	fi
 	if ! _have_program genl-ctrl-list; then
 		return 1
 	fi
+	modprobe -q nbd
 	if ! genl-ctrl-list | grep -q nbd; then
 		SKIP_REASONS+=("nbd does not support netlink")
-		return 1
+		ret=1
 	fi
-	return 0
+	modprobe -qr nbd
+	return $ret
 }
 
 _wait_for_nbd_connect() {
@@ -62,6 +66,7 @@ _wait_for_nbd_disconnect() {
 }
 
 _start_nbd_server() {
+	modprobe -q nbd
 	truncate -s 10G "${TMPDIR}/export"
 	cat > "${TMPDIR}/nbd.conf" << EOF
 [generic]
@@ -73,17 +78,20 @@ EOF
 
 _stop_nbd_server() {
 	kill -SIGTERM "$(cat "${TMPDIR}/nbd.pid")"
+	modprobe -qr nbd
 	rm -f "${TMPDIR}/nbd.pid"
 	rm -f "${TMPDIR}/export"
 }
 
 _start_nbd_server_netlink() {
+	modprobe -q nbd
 	truncate -s 10G "${TMPDIR}/export"
 	nbd-server 8000 "${TMPDIR}/export" >/dev/null 2>&1
 }
 
 _stop_nbd_server_netlink() {
 	killall -SIGTERM nbd-server
+	modprobe -qr nbd
 	rm -f "${TMPDIR}/export"
 }
 
-- 
2.37.1

