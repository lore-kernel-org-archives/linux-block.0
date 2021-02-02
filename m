Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34341C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED84164EAC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhBBFi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8116 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFi1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244307; x=1643780307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qIVA0C3ycXIeiJRxPQOf+nQs3Rs9IxQg6NJhJdQlGOE=;
  b=MWMrXHqP0XVzflYiGdeJP/f3+JEsaGVlFWZhCkYlyrigH4ArTKdALpiV
   1/K9u6rDPAZuXE4yvDkack3c/va/XNBDt2jdmKAMQSrfD/Cdo1J5mBjlh
   Duwp8Y1/r881v0UCO7zHtIntG+5dVQFYyMhocjuoNcE5AipKuV76l+JLr
   BI+WTAuM+spi+X15J182kW52XngsK6GYbuq7t9ymplUa6s9K5Q7H7tdtg
   C1JJnOpZRs2VR0zCCuRbIXu7hb8IerAXM+fdXnLgN1E+1mz1eUfSq2oq6
   FQwetohC2MCYZrUR22dTR2xINM7PahmMPL2Y7couP6MOlN+bAeOCWbT7D
   A==;
IronPort-SDR: T+s7MclAQ3znUNT0jATANHT6FFNHqMczlfELsptL5I/y8RrCk7T7fx10fhNvewaQ4elJAUpPnb
 3LpQpzpO6FcFx/UAj06JOTGQs6RtfVNmWf2cmlZgKjJnxkgfOTreQXA0JDwYmOrFCjWo+CPIbv
 ruus4a7us0EfS0AN+X3Ty19tTK79aIJJ47E/7sUSexb2kmbuYAI08Nec9PzhiQ5fL7YY1AVNGh
 p6zyWPCtEcVH+chCm2T9+Y+zW4AmO+1C0Nh4KqHnFA4RFYwckOs+v0b9jgf4AV0Xsnzf5Y9+n4
 xP4=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160067226"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:22 +0800
IronPort-SDR: gYkf1nsMkV7S4xOiFsv3STXtyfz30jEMME22Uyrr0CGTispKdsoNsmLeErbvsvUejNmZJSsY32
 XOshf5Cx3yf1Odev7fGHVzOO7h7eGM3nJPjzSzMhOyV2ol5XeSTXlwkEYlK72baNq4Mwklk1z3
 Tjf2bj3+4xIG9NSweJjgrA0EzNg9K9Db0Ztr6h6e3a6LPTmZR9c7SThIjv+19LnO6aulimyKvQ
 rSXwpdaW5hEht0thvH6uOsF77GmfpIQRQXBS6FHUNXXyCkazzNSlzlrx264ElbGmCF7jYVlFtO
 RzbQsnIlQ7/pRvqP6XADxKFb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:19:30 -0800
IronPort-SDR: fnsAWigMe+SnwnJnl0pgI1o0a1QknBMm+LZyfLd1kfs7BrCnwzq0L+SXKVuofpN+BYv3Y3vuWd
 qPS+IJCFsI6dEzZnIU2uQ9LckjDyqDiDaYFxJFbcfO7RpWO8rVcj76VHRrKfre1IqQKWEnTdII
 j8/s9zH7ceAr75qth7oZx644P0Jp+7vnD76huhgGoWY83zg42frSW7cAH4RyDWBwvLyoZssOZ8
 fijSkNZsxWYSsEChwDUhwk0q3FvWPbvlA5/Smfuj5QOykp/Y1UruCCRUQJV2b8urXBKNI/L4Ev
 ZVU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:21 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 11/20] loop: remove local variable in lo_compat_ioctl
Date:   Mon,  1 Feb 2021 21:35:43 -0800
Message-Id: <20210202053552.4844-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of storing the return values into the err variable just return
the err from switch cases, since we don't do anything after switch with
that error but return. This also removes the need for the local
variable err in lo_compat_ioctl().

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b8028c6d5ecc..d9cd0ac3d947 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1838,17 +1838,14 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
-	int err;
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
-			     (const struct compat_loop_info __user *)arg);
-		break;
+		return loop_set_status_compat(lo,
+				(const struct compat_loop_info __user *)arg);
 	case LOOP_GET_STATUS:
-		err = loop_get_status_compat(lo,
-				     (struct compat_loop_info __user *)arg);
-		break;
+		return loop_get_status_compat(lo,
+				(struct compat_loop_info __user *)arg);
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
@@ -1860,13 +1857,10 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_BLOCK_SIZE:
 	case LOOP_SET_DIRECT_IO:
-		err = lo_ioctl(bdev, mode, cmd, arg);
-		break;
+		return lo_ioctl(bdev, mode, cmd, arg);
 	default:
-		err = -ENOIOCTLCMD;
-		break;
+		return  -ENOIOCTLCMD;
 	}
-	return err;
 }
 #endif
 
-- 
2.22.1

