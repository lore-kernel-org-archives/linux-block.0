Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D760C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8A064EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhBBFjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:39:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61699 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhBBFjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244347; x=1643780347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Q2jC0OPZ8uqyBmu9/DnQ3WNz+pA3U0nEaVOd/URfOg=;
  b=aULJxgjeWqNm+7haoQjKNw4+YlSZfPvCrSLpcFNJ+w1MiEnYbuiiSMM1
   i/qvFtvOUjfX+AAuGOeRiTXOEbcC+jZ7bZ5gA/yzH5QBtXibiGRFG8CDv
   HO44qirgSOU58E5wsLd9iwWnCEb7i6E9K3xg49lCzi5xo1Tep6WzWZr1Y
   uPcLC9cPYv+/LcK4bo1oq6MbObVkmCcIx0YVQUROOVoJuVLj6uhmJIwGe
   rtQa5SyDHjsGveaYIQvyk7iJRdIPAl04l7hE/rt7b7rQZKyKB1KuU8xc5
   CTuv0qy6nS6XaNBMap/Zk23xg6lgQQkArNDwZ9w1jmdox6Wzm4udM43nS
   A==;
IronPort-SDR: WIo2OwMSm2IQpV6BypL5EOxVI95j1xPnhJFyI7nV2Yaewhc4nYjb70VZAnmTyi4T9OBBDmCIsO
 4LSkQcg6EkdhX2jePK5nCu+HhgI7CfJxM0BBVoVHUVqCH/QlIC8abr4aejj8QGu53TOJC+dreD
 l0sMOw47qExnP2UdroQnA0NuZUcne2vPttvCqOCA5lXq5cdvgtUo+Q1dXCOjsD6ZI0QvH3r9RU
 yuD8ONYv67LdQMUmNp1aERasLMhbUEQAGAb+p2XK3p8YXWlw0+qNLhhr1HV46ygyeQQcIDggNY
 XDU=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885272"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:38:02 +0800
IronPort-SDR: 3DSoLkbUEVLQSFN4Bj/wauBnG3osqsc1w75sHoYDLa4T6xYv4X+NiNbayAf4A1KJuCEDauSRzm
 HAh3Eb1bsPK3NB2SxQbdykXR44WtWQ10RzSfctCtEDwJC38qApf1+o0h/7957BKv0a2FOJcqQz
 MTqSzuT5G+3xIr81CvKyC+kCbJynZpuLQADwNJPLJFwVxqsjg61g6JRTPcsp9Cuhgvdv1Wi/VY
 OjtZ3yL9u5eITC4Ky0l4xbar8A6SCExawTSKdPt7at1eZrTQnaVEnFzQcoDYOD+42AZkD/1vZQ
 VvE8FEd5By2tvsS57KhFmG/x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:20:11 -0800
IronPort-SDR: 8nOar2qtKuOOqOWFnecwIgTuu4TLlKI+cCvdRRKN6X4O4QOpYuTATAP6deam6NPhcFVS6EWMD0
 9Dswy6Sj3wz4nOiKYQLT0u6U+FSSFqBpe0v9aYYPg1vVc6S4+HuuR0fxJqU2XCnKIbbxxxBRty
 2VXzBs5NqB8iSG3GBCsgX24iH09vfKP3ZJPspD/mHVKj1cNlTvl8SiAY/FFdbrbHBVSWhcTCqo
 OEclhsJTDDcMtZtcW91hacIv/3mz+HFIj8RJbIZDODc4HgZZTSqEde3RaqSkkcGDCTjwViln3l
 oT4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:38:03 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 16/20] loop: remove memset in loop_info64_to_old()
Date:   Mon,  1 Feb 2021 21:35:48 -0800
Message-Id: <20210202053552.4844-17-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current code loop_info64_to_old() is only called from the one caller
loop_get_status_old(). Initialize the info local variable to zero
before we pass it to the loop_info64_from_old() so that we can get rid
of the memset in the loop_info64_to_old().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 62f622791fb5..af3e3bcd564d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1481,7 +1481,6 @@ static void loop_info64_from_old(const struct loop_info *info,
 static int loop_info64_to_old(const struct loop_info64 *info64,
 			      struct loop_info *info)
 {
-	memset(info, 0, sizeof(*info));
 	info->lo_number = info64->lo_number;
 	info->lo_device = info64->lo_device;
 	info->lo_inode = info64->lo_inode;
@@ -1533,7 +1532,7 @@ static int loop_set_status64(struct loop_device *lo,
 static int loop_get_status_old(struct loop_device *lo,
 			       struct loop_info __user *arg)
 {
-	struct loop_info info;
+	struct loop_info info = { };
 	struct loop_info64 info64;
 	int err;
 
-- 
2.22.1

