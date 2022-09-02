Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E4DC6FA83
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 03:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiIBDp3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiIBDp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 23:45:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B602A24F
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 20:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662090325; x=1693626325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vk0eJ8lsz1a98jZ70czxJnVa9yr/83zvWoTmuaOaYEo=;
  b=cK+E2qZdg26lfQSd4py2y4CvBQ7SJf/kCPr1Ysh5KI0aam+0TEFOW12t
   cl5Llz77LsCcKVpZgPrJ/ldv/W/Phf+nm1fO2znSXhJklS6y0irC/kg68
   zfQD04UwMrNIW48GHaaoOrj7vDCjt1dKe11dySPnuLs4COgVrDhnNE+9o
   bl/mz6LtIFtf35y58w/w1htKUE8S32ZSIjaBFKkfZHA7PZa8AB5NsQ80e
   mWJZRfl7EybZ4uq/UatWAKeZm2hoK389EvMeTVrExAb8z+wXj2G/3Yv61
   2gH0p8FY/ZBPKNvWWJU6n6t5hV/MX5VYFrLESADVXBspacPIBDxrqly84
   g==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="322404169"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 11:45:24 +0800
IronPort-SDR: vJdordwn4qEvDk/zVPulSZWJeOQkTpHGI6faev4uRKBhjensMi5jA5FFwbH4oruqlSk/gWUW0y
 aYT0CUgPSKudnW5w5Z3hx6qOVULnfPEwC7LUqaVLXGVz8SzYQ12Aw1vSkKhmOBGhi3hMzO2VtR
 ZBAuPO6/y+2GoGXygJkUEf5RDZ2lwJqFSw6lSmzTmZV2V/V0ZXK4HF6tID/iapl7mJXyDxVdh9
 eyTqqwwjI32cQmtQiAY2opotdHT0RBaYRN9ntWn3+gsK1L9jEk08loexWGtr3rYgDAoXtAvtaK
 6ufhzOzR2KSr8B9+yQOLvmfi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 20:05:53 -0700
IronPort-SDR: 2RZw9NvKwETdiuIpABB6cVwrHvXr1DlAy2RVHExxzYL7EDzt44aRPfMUgeKbvIu0NSgtSpN3nx
 7QoeUol+V/2f4CsDGvSvyAfY2YWf6goMVvIWZbxC9paC8mas6T5n9DJCV0UqJ2C+/ji2eVHt3L
 mmYxJ3feWx8mH8cR03lfZ7gaInBNslpnV01e3Xugya9MZi1Zbcnh4nW/wDqr2XHtEl+lkw65Jq
 PyKbIcg2IWYSt4by6hg8C2M+KbBUyzaefbn6IJ2EjkcEWoh7iRv4rU6m9mfi1RZ7AQil7mOqEq
 mYc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2022 20:45:24 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/5] Revert "nbd/rc: load nbd module explicitly"
Date:   Fri,  2 Sep 2022 12:45:16 +0900
Message-Id: <20220902034516.223173-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
References: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 78271b8bb8c939e1d0b9cfa3ea321a4ed06635bd.

Once I thought explicit nbd module load in nbd/rc is required due to the
commit 06a0ba866d90 ("common/rc: avoid module load in _have_driver()").
However, it was not a good solution and _have_driver() was modified
again to load module. Hence, revert explicit nbd module load in nbd/rc.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/rc | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index 32eea45..9c1c15b 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -28,21 +28,17 @@ _have_nbd() {
 }
 
 _have_nbd_netlink() {
-	local ret=0
-
 	if ! _have_nbd; then
 		return 1
 	fi
 	if ! _have_program genl-ctrl-list; then
 		return 1
 	fi
-	modprobe -q nbd
 	if ! genl-ctrl-list | grep -q nbd; then
 		SKIP_REASONS+=("nbd does not support netlink")
-		ret=1
+		return 1
 	fi
-	modprobe -qr nbd
-	return $ret
+	return 0
 }
 
 _wait_for_nbd_connect() {
@@ -66,7 +62,6 @@ _wait_for_nbd_disconnect() {
 }
 
 _start_nbd_server() {
-	modprobe -q nbd
 	truncate -s 10G "${TMPDIR}/export"
 	cat > "${TMPDIR}/nbd.conf" << EOF
 [generic]
@@ -78,20 +73,17 @@ EOF
 
 _stop_nbd_server() {
 	kill -SIGTERM "$(cat "${TMPDIR}/nbd.pid")"
-	modprobe -qr nbd
 	rm -f "${TMPDIR}/nbd.pid"
 	rm -f "${TMPDIR}/export"
 }
 
 _start_nbd_server_netlink() {
-	modprobe -q nbd
 	truncate -s 10G "${TMPDIR}/export"
 	nbd-server 8000 "${TMPDIR}/export" >/dev/null 2>&1
 }
 
 _stop_nbd_server_netlink() {
 	killall -SIGTERM nbd-server
-	modprobe -qr nbd
 	rm -f "${TMPDIR}/export"
 }
 
-- 
2.37.1

