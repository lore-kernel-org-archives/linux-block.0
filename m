Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1131EC19F29
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiG0Iw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG0Iw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2946D83
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911975; x=1690447975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvOnCWOa9FoGp8j6yKay3efEtXc+6xbc6ZlBDhjCd6s=;
  b=n8J2SStGIpptBYJYSEXHnrOQakm/oBAKQvOBfgInozCd4PALCrjAaCBX
   kJ4MPZT6Gb6rnkrX0iHl2ig90Pzn60Afv578BF7Di3iFuRNJvaiHLbgU0
   TL6kLdAwZdEwfIQrtpIE4xOI13pkiO0D5LX05yoZzjeMHS+ItpmW2gg21
   kIkLQv/pCHN+5ufNjmkWHJyqUdQx1Tmqshkhs70Wuv256fKqav95V1E2Y
   Ij+eYiv0UiLwh+FYuoVeDAWg/MXTT2HSy2e6dbEqWntB/rvIfoqouDoln
   sbSCEVVxPB/zvDgMmVJ+tyNGqlJb4/JOE8kfx0EQRmqasFJRDT5EOnSdU
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584975"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:54 +0800
IronPort-SDR: YVIEofBUA8lXs/+nkFUUWS7ZfLWAD2eLzaR25yWEnaufeINjCqdIJzq9EvVsosfYIa3XWR4/st
 AFRZtxRtTTEUXGB0BJujwO7yuWamloUaxyTtIv4tRd141gH8CiSSDLHLx/q57/bIsF3k2291kf
 /wlTO4EG9e5swZykSDR/7hAoPESaSDizsMm+EDe1f4CXxbpGQ3kgqSq/6tpKk2t0f/5h10pd+a
 gByOuDMJik0S0MyRJNg9dCUztrSiL2VSI3ZdADpOpYAMek2tTTL8bAwlQcntl0IjHhJY9e7V8W
 mdKLxjHLO56D/MnRis56/1Zf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:07 -0700
IronPort-SDR: MdjPGhRUGRYvGQvvi2T81m6jYSKMDCwqqkISCwG9RRHUG7PXVD2JgkOv3snRziCkkhZKdP10lG
 KHeAWhAVhtDpiSX5d+BOIZ3U1VBDs0Z69qjnpk3mpZOtg3OFu5LwVTXrd/DYl7IdgMc/oUkB0/
 JPxIZKEHmkW13DAWRUzHfpXz3qbWyQSQPt8LjSI1F2o/J4piP9fdabVFPwlO0ovvXOZ/o9nVC6
 kcPsim12wFbMYuU03CShMJQQ7pdU9UDi2CsXxluB1Rtm8TRNqEKD3SyfyUu409D+AU2l7XDMKu
 jyI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:55 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/6] nbd/rc: load nbd module explicitly
Date:   Wed, 27 Jul 2022 17:52:47 +0900
Message-Id: <20220727085251.1474340-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
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
2.36.1

