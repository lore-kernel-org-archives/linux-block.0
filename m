Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1058C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F94921655
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckgv0Kft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfD3Bcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:32:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33081 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3Bce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 21:32:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id g7so14439132qtc.0;
        Mon, 29 Apr 2019 18:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R2C7F3zzlU+QPhzu9XF5UnJK2sqppWmuGAOu6ts1R9w=;
        b=Ckgv0KftBBtUaRjQf6tuEYnGV8juQ+fQFqXelBVcbX/kSn/KWHYTBltiv+ktilC7j4
         lSM8GJye2ERzg6UxJqSZ4z1x8HnBti6XafeWH5VP9+Q4HAqM6ttTckZsGxLO4Xmuwwdi
         TdIgNBErAG9Ay4NM0gN7NVWb/73llIxhea12elVC3UUuoP2ItLM9UYVYS+ysIk0z4uiL
         a0fy1UocumprtUeJBBI9StmdIN+NONmSIoeNbynhuy0VSYHxGx/3wEkziJ4wN4FNXWzF
         ei3VxwPKTsJ61iRGfH1x838SnVMO94tPp7noLAa5iPM9uPT3iTUOvqoM6B3Um7CrsI35
         Cwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R2C7F3zzlU+QPhzu9XF5UnJK2sqppWmuGAOu6ts1R9w=;
        b=G4R3KBNd+IFtBeUVeH/M10xGEj3xxss+voHAR0KYygI7Zt88LeYzuwmBsJlfx1wVW7
         ryhvPgcp86DlSdc+MkgmU5RNV6ZDdMzyiwR1nemYu2RPt3XryeDCGR6IxEOSuB5D95r1
         Q6D+7CcNj3XRm5gMcRqfuNVHKd7o92y728kBEeVykcGiMmGwXpCk9ByCTPs6No1/bAVR
         PBaJn4fCEpb4kQ4MubP0P39k1AoroJh8oIHCsShOWJnyxnUvH1pi6tRLNoplnFDyK99j
         dQLpj9S4ZweurQCmwAbajEu6aNUfc35dG29A/VHop5A6I7NNgIUIOOW02Q7KFdQO15s/
         6yGg==
X-Gm-Message-State: APjAAAXdJwl/Psy1J9AoABtcdIckRGr/M9rKYlDyAsNIdLweeIBJy1Dn
        qvPYmDOlpco8TN6jmJtb+8+77H+M
X-Google-Smtp-Source: APXvYqyaeYs0rDegse3R6D+FOUz1B89BOk8vXc+8nXDfbEgvXyjg1qkQEgvxYmVPeodcj3TwyW4rXw==
X-Received: by 2002:a0c:ac83:: with SMTP id m3mr51240137qvc.85.1556587953055;
        Mon, 29 Apr 2019 18:32:33 -0700 (PDT)
Received: from laptop.suse.cz ([179.185.223.166])
        by smtp.gmail.com with ESMTPSA id v57sm5127019qtc.10.2019.04.29.18.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:32:32 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] null_blk: Make use of size_to_sectors helper
Date:   Mon, 29 Apr 2019 22:32:05 -0300
Message-Id: <20190430013205.1561708-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
References: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This helper tries to make the code easier to read, and unifies the code
of returning the number of sectors for a given number of bytes.

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 No changes from v1.

 drivers/block/null_blk_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d7ac09c092f2..05f0bef54296 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -853,7 +853,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	dst = kmap_atomic(t_page->page);
 
 	for (i = 0; i < PAGE_SECTORS;
-			i += (nullb->dev->blocksize >> SECTOR_SHIFT)) {
+			i += (size_to_sectors(nullb->dev->blocksize))) {
 		if (test_bit(i, c_page->bitmap)) {
 			offset = (i << SECTOR_SHIFT);
 			memcpy(dst + offset, src + offset,
@@ -957,7 +957,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 			null_free_sector(nullb, sector, true);
 
 		count += temp;
-		sector += temp >> SECTOR_SHIFT;
+		sector += size_to_sectors(temp);
 	}
 	return 0;
 }
@@ -989,7 +989,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 		kunmap_atomic(dst);
 
 		count += temp;
-		sector += temp >> SECTOR_SHIFT;
+		sector += size_to_sectors(temp);
 	}
 	return 0;
 }
@@ -1004,7 +1004,7 @@ static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
 		null_free_sector(nullb, sector, false);
 		if (null_cache_active(nullb))
 			null_free_sector(nullb, sector, true);
-		sector += temp >> SECTOR_SHIFT;
+		sector += size_to_sectors(temp);
 		n -= temp;
 	}
 	spin_unlock_irq(&nullb->lock);
@@ -1074,7 +1074,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 			spin_unlock_irq(&nullb->lock);
 			return err;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += size_to_sectors(len);
 	}
 	spin_unlock_irq(&nullb->lock);
 
@@ -1109,7 +1109,7 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 			spin_unlock_irq(&nullb->lock);
 			return err;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += size_to_sectors(len);
 	}
 	spin_unlock_irq(&nullb->lock);
 	return 0;
@@ -1201,7 +1201,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		if (dev->queue_mode == NULL_Q_BIO) {
 			op = bio_op(cmd->bio);
 			sector = cmd->bio->bi_iter.bi_sector;
-			nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
+			nr_sectors = size_to_sectors(cmd->bio->bi_iter.bi_size);
 		} else {
 			op = req_op(cmd->rq);
 			sector = blk_rq_pos(cmd->rq);
@@ -1406,7 +1406,7 @@ static void null_config_discard(struct nullb *nullb)
 		return;
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_discard_sectors(nullb->q, size_to_sectors(UINT_MAX));
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
@@ -1520,7 +1520,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	if (!disk)
 		return -ENOMEM;
 	size = (sector_t)nullb->dev->size * 1024 * 1024ULL;
-	set_capacity(disk, size >> 9);
+	set_capacity(disk, size_to_sectors(size));
 
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
-- 
2.16.4

