Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EFCC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3DC2145D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkiKdxfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgIVCc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:55 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642CC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:55 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j3so8712043qvi.7
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JYQbtbils7OGh5uP6Fpkr+447ZcftT0pb1EE6IEMw9o=;
        b=mkiKdxfHRbocn+6bI/8KHAVuSl23Yrn1u0PS315sZpGO/RINOWhJ15tgErpSY4o0EA
         Gs4YuG9O8wNSZZNNsW6kNeuW6A8LNd1v4RxttPmjbIRLsYpBLXAR3SbS1JNOIhWurKa4
         WfLv4bhH54e4y64IGUqPiRlYpIgbQ0ISLbCM/Yq+DsCA24Av5p93zGGRFFI5kw2WDfdn
         leOLJHFfh0BOb/g9wwTGDVlyslD41oQxNkFYnUgDvvO0onYdcIwtg1a2ro9gG1SrSAV1
         zwHK9FJozNznMz4wqXhss2tJae96ffyyZnWbPdEaux5Qf+5w9SMCVzSWq92pTHK7Lztx
         TvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JYQbtbils7OGh5uP6Fpkr+447ZcftT0pb1EE6IEMw9o=;
        b=WlfY0FImy/TYDar3McozQ/aS+w8lTn5bFLUuPY4i8OjWN/uzULVhOhy90ZhyrmjN0Z
         XSGYM0S4Ja8CgL4dIhp+mfcR45NNjuatBPaDTQrDreQBknqjEdccVMYPgRdek4DjwIqy
         +T+1EDMbe7MJOW9cHdfbTBZ2cE5dAwgAhdzWTXMiW6+lEnD5brmm6VcYRahkRVZTzNZ2
         SgU3Xv/adQHFbzI//Ja4WGxhSZMVXrNiblllWwd6ENG9uH7i09vX6zO4wwJpAhqriz9S
         e5s6b1c4Cd6FUVXntaOLQ+NOZc3cJ9NMW7Oqk6gp7sdq9g+O52hCfgp2unKZZVScee+M
         X4wA==
X-Gm-Message-State: AOAM532Ejjv8f6NLZwKUvAcA113REC8uCS8labBNuvRVkyyTikA+hOa6
        JCmP1pWdl57/DCQ2UR4w3Gw=
X-Google-Smtp-Source: ABdhPJyoXtCEfYkk40FJYctRlI58zYdrRSpqflZViwb6wpJ8jBCqLGDhFf4TjNMvg6lfMx80mAgojQ==
X-Received: by 2002:a0c:c492:: with SMTP id u18mr3606404qvi.18.1600741974844;
        Mon, 21 Sep 2020 19:32:54 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id n1sm11622494qte.91.2020.09.21.19.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:32:54 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 1/6] dm: fix bio splitting and its bio completion order for regular IO
Date:   Mon, 21 Sep 2020 22:32:46 -0400
Message-Id: <20200922023251.47712-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm_queue_split() is removed because __split_and_process_bio() _must_
handle splitting bios to ensure proper bio submission and completion
ordering as a bio is split.

Otherwise, multiple recursive calls to ->submit_bio will cause multiple
split bios to be allocated from the same ->bio_split mempool at the same
time. This would result in deadlock in low memory conditions because no
progress could be made (only one bio is available in ->bio_split
mempool).

This fix has been verified to still fix the loss of performance, due
to excess splitting, that commit 120c9257f5f1 provided.

Fixes: 120c9257f5f1 ("Revert "dm: always call blk_queue_split() in dm_process_bio()"")
Cc: stable@vger.kernel.org # 5.0+, requires custom backport due to 5.9 changes
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4a40df8af7d3..d948cd522431 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1724,23 +1724,6 @@ static blk_qc_t __process_bio(struct mapped_device *md, struct dm_table *map,
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
@@ -1768,14 +1751,12 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
 	if (current->bio_list) {
 		if (is_abnormal_io(bio))
 			blk_queue_split(&bio);
-		else
-			dm_queue_split(md, ti, &bio);
+		/* regular IO is split by __split_and_process_bio */
 	}
 
 	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
 		return __process_bio(md, map, bio, ti);
-	else
-		return __split_and_process_bio(md, map, bio);
+	return __split_and_process_bio(md, map, bio);
 }
 
 static blk_qc_t dm_submit_bio(struct bio *bio)
-- 
2.15.0

