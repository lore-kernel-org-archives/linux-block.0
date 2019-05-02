Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C5AC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 01:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F17208C3
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 01:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1gkIa6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBB5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 21:57:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40038 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBB5v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 21:57:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id y49so765904qta.7;
        Wed, 01 May 2019 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ScoPHCSfbUSZNYhPTetSXWB/AATr0GLAAk+sax2NZU=;
        b=k1gkIa6YCGgKNVzVLbsAj3/h+e7cPZnRkRyFs8tXxy6N36SuR0FSwpozKEtNYMvjz5
         jjIM73DkOjG19DIb/Ad2hge3rpcp52A6abPDa7sqhU/MfxXXLqiL3Et/3Vs1lNQxS78/
         KKUufhv9h8bADZjGf9i9S0aHNi2p/OSXbuqZSeEkkJDhtKUlg+7a4JA5SOCQ4s9mpKPK
         dz0WnyyJZXEQ82AgPldR12UkJnWOloU7kz/252eGhrK6MwmhbEo8E001BF49iQgcIzZX
         GmMvahL++H13PPTRhO7wDx5W0MVW3pAb2MC/bNwtCQOvQEvNYpBBaUPfMI3vfT/acn1Q
         MdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ScoPHCSfbUSZNYhPTetSXWB/AATr0GLAAk+sax2NZU=;
        b=BCmE2WQ68wvt/w55aXEAhpxt7BPu57EoibX13lxUBXzE+4rALsz+A8EPMbIfhCfPRh
         BYoYx0Lw3P1GAJV219F+0Wxpm1dtzeW37pvGlcm4GRmuy/yF6fMju+6Uek3EB4T9BHxw
         XCEjn5K5HAyP2WJJzDrcJGmPzhblidJQfHlNus/uwwfudTIn4696LlVP8Blltf9O/5uO
         1pySnrNWWvDjZTtlrZrc5+9p+8P/nX5/w8aGZkLHkdvJULL2yiP42PCFSw6rYn1u+tRs
         HB86kGKQZe0CZL0GJ05DA6cLmh3cS9mo8wROJkO5W/BhjcFkVVLMc30GDUSPK3+UE5IE
         PSIw==
X-Gm-Message-State: APjAAAWP4YEET0H79qGq14pVpH+XKyKPYvzyd/t5XlkwfUIEvALGtV3X
        Qyb20Vt1l+547r33nE//EpedsBCPU/c=
X-Google-Smtp-Source: APXvYqwv8RiGxY0Oxi8iFGQ9LN/fcv8jh3xmzRYRlebyanZuQF4UXm0PniS98Es9Np8aH89nVL7rAA==
X-Received: by 2002:a0c:b585:: with SMTP id g5mr1119212qve.220.1556762269953;
        Wed, 01 May 2019 18:57:49 -0700 (PDT)
Received: from localhost.localdomain (189.26.185.89.dynamic.adsl.gvt.net.br. [189.26.185.89])
        by smtp.gmail.com with ESMTPSA id d55sm9031059qtb.59.2019.05.01.18.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 18:57:49 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] null_blk: Make use of bytes_to_sectors helper
Date:   Wed,  1 May 2019 22:57:28 -0300
Message-Id: <20190502015728.71468-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190502015728.71468-1-marcos.souza.org@gmail.com>
References: <20190502015728.71468-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This helper tries to make the code easier to read, and unifies the code
of returning the number of sectors for a given number of bytes.

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

---
 Changes from v1:
 Rename size_to_sectors to bytes_to_sectors. (Martin K. Petersen)

 drivers/block/null_blk_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d7ac09c092f2..4c48f2a30941 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -853,7 +853,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	dst = kmap_atomic(t_page->page);
 
 	for (i = 0; i < PAGE_SECTORS;
-			i += (nullb->dev->blocksize >> SECTOR_SHIFT)) {
+			i += (bytes_to_sectors(nullb->dev->blocksize))) {
 		if (test_bit(i, c_page->bitmap)) {
 			offset = (i << SECTOR_SHIFT);
 			memcpy(dst + offset, src + offset,
@@ -957,7 +957,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 			null_free_sector(nullb, sector, true);
 
 		count += temp;
-		sector += temp >> SECTOR_SHIFT;
+		sector += bytes_to_sectors(temp);
 	}
 	return 0;
 }
@@ -989,7 +989,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 		kunmap_atomic(dst);
 
 		count += temp;
-		sector += temp >> SECTOR_SHIFT;
+		sector += bytes_to_sectors(temp);
 	}
 	return 0;
 }
@@ -1004,7 +1004,7 @@ static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
 		null_free_sector(nullb, sector, false);
 		if (null_cache_active(nullb))
 			null_free_sector(nullb, sector, true);
-		sector += temp >> SECTOR_SHIFT;
+		sector += bytes_to_sectors(temp);
 		n -= temp;
 	}
 	spin_unlock_irq(&nullb->lock);
@@ -1074,7 +1074,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 			spin_unlock_irq(&nullb->lock);
 			return err;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += bytes_to_sectors(len);
 	}
 	spin_unlock_irq(&nullb->lock);
 
@@ -1109,7 +1109,7 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 			spin_unlock_irq(&nullb->lock);
 			return err;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += bytes_to_sectors(len);
 	}
 	spin_unlock_irq(&nullb->lock);
 	return 0;
@@ -1201,7 +1201,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		if (dev->queue_mode == NULL_Q_BIO) {
 			op = bio_op(cmd->bio);
 			sector = cmd->bio->bi_iter.bi_sector;
-			nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
+			nr_sectors = bytes_to_sectors(cmd->bio->bi_iter.bi_size);
 		} else {
 			op = req_op(cmd->rq);
 			sector = blk_rq_pos(cmd->rq);
@@ -1406,7 +1406,7 @@ static void null_config_discard(struct nullb *nullb)
 		return;
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_discard_sectors(nullb->q, bytes_to_sectors(UINT_MAX));
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
@@ -1520,7 +1520,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	if (!disk)
 		return -ENOMEM;
 	size = (sector_t)nullb->dev->size * 1024 * 1024ULL;
-	set_capacity(disk, size >> 9);
+	set_capacity(disk, bytes_to_sectors(size));
 
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
-- 
2.16.4

