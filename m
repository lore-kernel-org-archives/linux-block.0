Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B09C32792
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiHWANq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiHWAMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:12:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E405722D
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213518; x=1692749518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P+dzON1EaG+p3+uSBAk03JFfGaNTV71TpQFCrs4EsXU=;
  b=Cz5EDrIgjnrpO3rlkHBlKJcQwPshuQM+J/EiGkxc/hEpWUfEwDJ3zk+r
   iXsm93FO88rm12o1scOrk2gw7HJO/EfszqcKijS0+28M01rr4xorTrwuH
   oNAb3RTCJr3teDy9Dx1fnKGzG9ji7lKb/ABIkABgJqhZAxTpfsIhfAvmx
   aZOcIHz8w2FhQNY2Bdvh7CRkF4by9Zlyf/rh7RV9hxM5iB/a+vJc1q26D
   b5cNNSpIah3Yv45OKPF8Go/UfIKQBXXPhTvjp+zN4EvFQC+y6tpXSLDXb
   XnmovNnPTS0Urh0HbSfyd+WGMaPUi/Ilfl/zTIeNCOWIVPPE9LKwOYELc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645297"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:11:58 +0800
IronPort-SDR: PAiRfLrc/G5j9FZuJ6bgsEXoVFvkwqyNWnKyaj7OfSgMsQuFJm8K3doz2IDeCIbhi67TB2Ov38
 7tQpHX6yVnRAPKq71QZh+X2pmXY1BUafLrQMDJVFZGIw14kys6EzhGX5J2EhCuVvD36s9E34HM
 SCzH7BCCbTFG9Ufd+2FaB3GFN8o1fieDCPwoMv47whVCx0g3JsS3kcTC6/mAHADA1C3gXCFi5C
 ltdM6YcLkIoMJVQOmBDq6rTc9d8ECSH2F8Cn6PmoHcq+6xbLYuXviIltStg1qywR5+GhUsmITA
 Qzqj/vSB7yH/57A1ym2Rneqc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:38 -0700
IronPort-SDR: bF/GWDZyvwy0u0ZT2WDrRjxJ4u88M/bfzMYDS7i5ZhNKio/z+Jv56tVovQotaA1874eAfyMhZs
 mLu2+dwrrdt3okF/UpSDyPive7yiKmkzjIMjEJ30WRYLW0Rfa+rIYXdyC3v/YSAl1tQ/Er2xw9
 FTeFLZC2sz5a513RwuY8LyJVHmLhKK4/zUHUqmtshR3wgorxkbaAtsYYR5th47aJPiPf5eLUzr
 2oBhe7gFpZkk1yOBNy1CWldv/0jOqLh3yRTwZ8OrY5XsFLacsMmIywfxaLD20U1iqIs9EGPPub
 vOo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:11:57 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 2/6] nbd/rc: load nbd module explicitly
Date:   Tue, 23 Aug 2022 09:11:49 +0900
Message-Id: <20220823001154.114624-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

