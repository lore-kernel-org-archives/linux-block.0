Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447ADC433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF40C20735
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYvFE6iK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgIOStr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgIORZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F257C061351
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:05 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so4993948qke.13
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7cplhJ+CMOio2eKSlQ3A9qenyuRaLVK7gDFC2tp/7iE=;
        b=sYvFE6iKk88aXGk3ud0cBpRkzDDwcUC1YidZa0ZloImjRpjWWm06AtYr/2tKD+MLOg
         +BG/38FOoIElT4iqQxA3/QfU9VLUnz10xcCx6/FWmyGhKYSajqsJr1V7P6rYABfa65Ge
         wt/zaRPN7Ixi4H1W8i+g6RzJ/g5Dqq+t7lv/GHyroHNOfYqk5qZIeB0BO4BcdjcOQkYT
         Gxa60yq1s7UK1DqEByiG5OEuBghzCANxBLckEMbs0sPsCZnZ0voAhjZ7VkTJSsziq7S0
         Fj9VfYgDUSBhGeRNYUIWIJ1soTjhNcqjQHCmxWbZQ9S727jw9xcutrsDCQ9Gw6AIFO4/
         XHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7cplhJ+CMOio2eKSlQ3A9qenyuRaLVK7gDFC2tp/7iE=;
        b=DxkpP+QOtbzXpQSM16yaHdCcRekqCaNZFh6CM8X8uuuFRFHPNFwPunX6XEIsM2SDiV
         xtxgWGrPrJV7NpAILSHwOjOVpbH+Tghh3PGg5RyHPyEeRv9sVVn6Hg9wXzWYxyWrxfKP
         m0p5K74WcXd5rID4SpGCvBFXai8ekfwA6NMDdH3sSiOJvVSm9yq7hldz7erf4/ngy/LW
         hgUVMbMbASKUgFweHwwKIUogpLQXvuMJaWGd1A98r6UFiL/3Batxos96CfokTkyDmP7x
         sK73OaucyvTpA7wcOkuRPcqeYBzUiNN0Efabu0mpPhuVo6NQh71ND17xExBMkRm3+98w
         Z08g==
X-Gm-Message-State: AOAM5305U++Pz6vMua0LyPWlEweAGLDPuznfiEC5g2bk4DBqY9les+Nk
        Mm3Ikc6sZEHHDDRpjUwcXwo=
X-Google-Smtp-Source: ABdhPJy0pc0fArTWbJ7e53JSflriiZAjMa8KQwK/gnTN75ljPFBUSMbdOP8I6gyV5ZGZiH5h588Kgg==
X-Received: by 2002:a37:2f42:: with SMTP id v63mr17521380qkh.261.1600190644615;
        Tue, 15 Sep 2020 10:24:04 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t1sm17823515qtj.12.2020.09.15.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:24:03 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 4/4] dm: unconditionally call blk_queue_split() in dm_process_bio()
Date:   Tue, 15 Sep 2020 13:23:57 -0400
Message-Id: <20200915172357.83215-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200915172357.83215-1-snitzer@redhat.com>
References: <20200915172357.83215-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_split() has become compulsory from .submit_bio -- regardless
of whether it is recursing.  Update DM core to always call
blk_queue_split().

dm_queue_split() is removed because __split_and_process_bio() handles
splitting as needed.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 45 +--------------------------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fb0255d25e4b..0bae9f26dc8e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1530,22 +1530,6 @@ static int __send_write_zeroes(struct clone_info *ci, struct dm_target *ti)
 	return __send_changing_extent_only(ci, ti, get_num_write_zeroes_bios(ti));
 }
 
-static bool is_abnormal_io(struct bio *bio)
-{
-	bool r = false;
-
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
-	case REQ_OP_WRITE_SAME:
-	case REQ_OP_WRITE_ZEROES:
-		r = true;
-		break;
-	}
-
-	return r;
-}
-
 static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 				  int *result)
 {
@@ -1723,23 +1707,6 @@ static blk_qc_t __process_bio(struct mapped_device *md, struct dm_table *map,
 	return ret;
 }
 
-static void dm_queue_split(struct mapped_device *md, struct dm_target *ti, struct bio **bio)
-{
-	unsigned len, sector_count;
-
-	sector_count = bio_sectors(*bio);
-	len = min_t(sector_t, max_io_len((*bio)->bi_iter.bi_sector, ti), sector_count);
-
-	if (sector_count > len) {
-		struct bio *split = bio_split(*bio, len, GFP_NOIO, &md->queue->bio_split);
-
-		bio_chain(split, *bio);
-		trace_block_split(md->queue, split, (*bio)->bi_iter.bi_sector);
-		submit_bio_noacct(*bio);
-		*bio = split;
-	}
-}
-
 static blk_qc_t dm_process_bio(struct mapped_device *md,
 			       struct dm_table *map, struct bio *bio)
 {
@@ -1759,17 +1726,7 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
 		}
 	}
 
-	/*
-	 * If in ->queue_bio we need to use blk_queue_split(), otherwise
-	 * queue_limits for abnormal requests (e.g. discard, writesame, etc)
-	 * won't be imposed.
-	 */
-	if (current->bio_list) {
-		if (is_abnormal_io(bio))
-			blk_queue_split(&bio);
-		else
-			dm_queue_split(md, ti, &bio);
-	}
+	blk_queue_split(&bio);
 
 	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
 		return __process_bio(md, map, bio, ti);
-- 
2.15.0

