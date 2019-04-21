Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDCEC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 03:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309872087B
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 03:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4IJS++R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDUDxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:53:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45497 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDUDxu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 23:53:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id d5so2547729qko.12;
        Sat, 20 Apr 2019 20:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bUuegO71QrnjXcC/yeAU/F4bewzxM+lh1bvWGG5YTjE=;
        b=c4IJS++R4/ofg+3qjMourEklKUa3ULaccOPBH7GVYXfb1M4GD9iH2EBkp9uivqh6wY
         jFVdEq+2LvRHrX9oPFItEQshvyRg3t7HjK54WgkqqiCtHYj8UTIEq2q3o+NYDHBCF+ly
         Kq4ZXcVPLT5cLDwNGZQ5CtCbDaKccUjJmuRk+MlvNysmbtmJdXXBVSEkdRlN/7gz3J8o
         CHR2o/vGMef7jGVY3ADABFxvrU9+tR/cqtuvxPHAzEJG/1DCXLRAuVpSsDHaSOolpTHe
         2jGr+k7YrmbfcOoDRJJM1Hno0624/6F3D6NdSItgz+fMD6uXlLp8LASZJP/AhwzmDzgv
         st5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bUuegO71QrnjXcC/yeAU/F4bewzxM+lh1bvWGG5YTjE=;
        b=DdPxvXyJXjraOwIwP+tmkjNrWESHn3DGrx+lwCqiDzjqOC5gTiYmNL2hhn9++0LEZq
         HGzjbpO6drIxjuc76Zs6xQehxocX2zoh6hZeqLaazZET/Wq9lFLL8qH0oigvzp/i5p/w
         UnFuwqLkMai/Nq/dLEI9AHxlQZOorIZaQAnZkuY0wkdcWfUM3RRnrA3lZxgKYqLzi0uW
         5Jok37wlnNda0flNvtjOwKeaOCg/o0yYLVfCKvft6B8JZRYzDiUKwhcgE2j7kEQg7dax
         q/igz74BC73AgShI5CVmJNDHS0ON/Oxc1YVR15eBcGGjhxG1C1H0o6xPJOIlGBaYNBo0
         CGXQ==
X-Gm-Message-State: APjAAAWTH2VPpumYmg9qfbBMtl1CTGogBxZi45AiouRN94wIvRY6usu+
        JBUIFnUN6/zA44kvH4A3GXf8/nuWskc=
X-Google-Smtp-Source: APXvYqwXB74+8hLLJ1COV2EVLV0hOEsqzW2dGX4kiXkd61q563wRzO26Ot6KZ7pmi7o3gtS5Ew8obA==
X-Received: by 2002:a37:4988:: with SMTP id w130mr9501589qka.262.1555818829296;
        Sat, 20 Apr 2019 20:53:49 -0700 (PDT)
Received: from localhost.localdomain ([177.96.46.237])
        by smtp.gmail.com with ESMTPSA id b37sm7341398qtb.92.2019.04.20.20.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 20:53:48 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Greg Edwards <gedwards@ddn.com>,
        Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [RFC PATCH 2/2] null_blk: Make use of size_to_sectors helper
Date:   Sun, 21 Apr 2019 00:53:28 -0300
Message-Id: <20190421035328.19322-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190421035328.19322-1-marcos.souza.org@gmail.com>
References: <20190421035328.19322-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This helper tries to make the code easier to read, and unifies the code
of returning the number of sectors for a given number of bytes.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
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

