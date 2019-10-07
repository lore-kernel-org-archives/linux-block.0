Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C19C47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 22:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330902133F
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 22:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DM5HY1oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfJGWMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:12:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20422 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 18:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570486368; x=1602022368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X56rtn7IhMY93+dUIFEw1OslYrBQOThrSB6B8UVduA8=;
  b=DM5HY1oHKS5+cEcPZT0PQihqq8lE/2D5lvFv17XX9vaDU6a5HbYn1MJj
   m1VJfgxI/7drcfBsHBvLPp8bWEudGgO+otyoNJpJ5+tPpBjV2rzLAMG5p
   NKoJmiVxfsAnVNeyNu9xDNiS7Pt30XA5wDn66CaHPjDJKE4OLiL2LIjcK
   bzB03vrh68FiYsdbH0SIqCPrXy/ZSxHgVtAi++KUXj20sxEYzlQ6hTEaH
   foPiSsvqlHR1kCetUPH6BKOByYoap+/VWJ+c6hDO/+EbZLUEFJvW9uGNc
   HnmxFbTYiGj56D3B5YsMT+kKOtDJ/yP+F1YU2PHI8ICwKMHUa9oQxwLMm
   A==;
IronPort-SDR: qiX/MH66kVA+5fMzDdxdRyZBlmGafzg7R4Nfo0IHBqcn1qFZ3A6i4OvR52EZVZnijFlkPrANQS
 Cv5NXG78S8GTwx4yu0d5WnALPs3O+QbSzjXvnyfD0MgOXkHROEXDVvRXX1UHA0a5nsQwk/1Da4
 qkFJsAq0tD6LX1cxKtf9O6Gtnc/CF64LYNIGPp/A8Vh2btrwlsmhkDSHImONe83e6d17yZm9Mi
 T4f5wQzQ+rVuVttOq02Vd2cB90ak8g6nIICDetLUo0msShw9/P+tvmU2jGSOCJIXe49KZCz3V2
 YGU=
X-IronPort-AV: E=Sophos;i="5.67,269,1566835200"; 
   d="scan'208";a="226941498"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2019 06:12:47 +0800
IronPort-SDR: 0ORtf6QIXPjKWxXBHlODxOPSoQFo2Hgy0V7clWlxN5V0HeKbngr7WhIlpICytHHYcc6uVc9SlS
 8Z23iJSX+BJXGBQKmnRmx7GXb5OqMUEoFlc6HWwGsbaFkFKpCOxZciEUuYaipu9HX3RssZnv66
 FaaAKx+h9fayD2N6BEwtrId+8ZR+rWrJj4wzsUIErieSm0Z5Ok8uYXKROta6GvEFiMHJUfcCMS
 Dw9eWrwG4SvJXpVlHE2c35yb5mW23M4pSXXDtLNwYm2xvEa/hbkM5CUc03izpt6O96QKr0Nr2O
 t0JaEPqE54wJIr3m0C5KqK3o
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 15:08:49 -0700
IronPort-SDR: SDMJMP/8SdzF21dG9chT6MB6i5FwLk2hYcI1RfdPIJQcGjHGB/5HAuFtxM1FRms3b+7bJWySS/
 RoOeH8rEEUzeMrzLSYaIDPiNy7isuQ2Qs9BP4ezPMJQEd6kjFyHd9sVAxHVRJQLOhqsKclwr7R
 eo6f4lICNqBNypCzGSY+BrZI/KqanU2XTJTbAQ7fVJimnjBKmEBAsj2Zi7xKk5PzsVHAQYRVEa
 Ady5IFrwkfgcd8l6dR1F/kAMZjUT2h5seIJz1U7wrYoY3l7gO2PcejeJWl1FXZIDYaetCUfNde
 oAs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Oct 2019 15:12:48 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: Fix elv_support_iosched()
Date:   Tue,  8 Oct 2019 07:12:46 +0900
Message-Id: <20191007221246.12824-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A BIO based request queue does not have a tag_set, which prevent testing
for the flag BLK_MQ_F_NO_SCHED indicating that the queue does not
require an elevator. This leads to an incorrect initialization of a
default elevator in some cases such as BIO based nullblk (queue_mode ==
BIO) with zoned mode enabled as the default elevator in this case is
mq-deadline instead of "none".

Fix this by including the absence of a tag_set for a queue as an
indicator that the queue should not have an elevator.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5437059c9261..995d1e67056c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -616,7 +616,7 @@ int elevator_switch_mq(struct request_queue *q,
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
+	if (!q->tag_set || (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
-- 
2.21.0

