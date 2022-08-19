Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A0C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348055AbiHSJjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348179AbiHSJj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42EB7F0B1
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901965; x=1692437965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OWpSCTcZijPgiFp6MTHHj4KNHWiOMwVmdoA8J0Xfcc=;
  b=QMf7d/0PJo7QJlHzN6zQbvLFoSa4qb1LrLNiddXaXVNrd73vYbljmUN7
   mHODzJtFfBiXElfs0OYKt0zz1+UZtDssgqjYUKBHXlUYv778Hw1gLY2L/
   W5X3dylLXv3UcwR58FdKCyXTWDylONhf4/2QbT+8rwupm9NiVj6PB99xW
   ly6SlO6+VwTIIdpN8Iarv7fHapknXhjqEnsLHBTO+kN0Poi48njbcmNuX
   NiCSTNgMAwHypZllTnEuUSZ3QueztaLhrd5hcKFFK8wYsGO0qA8Dn9iEu
   s8l4WuW2r7cQR63MtvLU74Jp7g/jJZCYMVuJLubx9vAmQSZo3pduKdHLY
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411547"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:25 +0800
IronPort-SDR: oPIWOi5gjOCsWrj+1tpmwXrNgKQMh1uV4hZ7epcT3RkW6+5QOeUr1D6UyH9krnWoO++IGAXgmV
 5qlD32Adkrjih8DGLyjF01vLJS4xEBHxgeIosAEa/qKLNTTSJox1Ly1D5r3tsEDEFdcCE9uHvN
 RGM6TMeOMtLoonFaD+WBEPxPFgdcvHiB3J78zBK/Rv3W3M/vLN+jBLYFHg9L+Qt84OF0tmbFvV
 c7ub6+Mfmm20E4XjputhEXVtp7Aba09UxgWBQgTf9GI6TyptOMqvcHfPS+Mn6CZ4S16T8qkL20
 rJt3krv3hUMQVPjpZc8xOCJl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:49 -0700
IronPort-SDR: SyLxo9eStl2n0jlQdZVNk54WmwiCwIxIPJXsm33H4fgx4xp0+ERKVZq39Y7qul4UpL1VNnDn7H
 o1uSCwXNkRVdciQM/f6fXgrIIzUZ7xphIRT1+SYpi3dZlEMk0EI3AX5f/2ld/d1rImsJ3xXG63
 ZhjRGqBoAjFE3SFJ3GovzcbVRqKfzJzF3ZU4biHulkYGcD7Lgvo+AelJMz4yqYcydO5mCojY4L
 LCEgSuZZA09lB5nHes1jCwgzhUYm6hNzyMGiNM9wj15b1n3EU/trbc7ZGSyoiwd++LDFMbCuIv
 xrI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:24 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 2/6] nbd/rc: load nbd module explicitly
Date:   Fri, 19 Aug 2022 18:39:16 +0900
Message-Id: <20220819093920.84992-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
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

