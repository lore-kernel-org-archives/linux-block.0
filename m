Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356DC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 19:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCQTyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQTyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 15:54:04 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B74FA8F
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:53:43 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so6364139pjt.5
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyqzNfxRjzaxRGDvXIW8KRgKsEi4R5QcVSdz6OWE1F8=;
        b=hZ03oLn8bUL2FAIwNP4ySQF94lxRAQBaWdKQC6NzoD60oDXz5qz+m+Lgq9Cl+4jF/g
         UIu2nFh04p40wMnvYMC4mRZhBNoNcqZeg7n18eSZDTyM0QCbFBP/PqT3005c/Gwd490S
         QGP1MclnxKe9k/KPmVY7NE/VEnKCdU12Y02zOfqbJbYb9A9fsNiZXCk2hiLVk1xyHwab
         uK76Br4qxfimBo0W9goMPodQ1nQc+tRi6DYMGhPbZskwN0TAgWJIDP1iHKIFJQ18fE9p
         lL/N2Q0eFCfxtnmGokMLWBTBxpeFeyqESVU+Zzv9qO/AapWkdIwrttNbKQ7MpAHG28J3
         5wKQ==
X-Gm-Message-State: AO0yUKUnkipsU0Fz0gWcTQBnkS+cQB1mga4opIFsrqDN+mXqPCsanOR2
        Ah7z1X+Cm0xGjwjJ23PVf1o=
X-Google-Smtp-Source: AK7set8IXcMzJ/GI75E1Nm0Wz+44E1jfZYn/lfP0cvCG5w0q7TfrMknRmmGmB8o90FgRx+dwOEerRg==
X-Received: by 2002:a17:903:234a:b0:1a0:51d4:f055 with SMTP id c10-20020a170903234a00b001a051d4f055mr10055822plh.49.1679082798604;
        Fri, 17 Mar 2023 12:53:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b0019e81c8fd01sm1737453plt.249.2023.03.17.12.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:51:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] block: Support splitting REQ_OP_ZONE_APPEND bios
Date:   Fri, 17 Mar 2023 12:50:35 -0700
Message-Id: <20230317195036.1743712-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it easier for filesystems to submit zone append bios that exceed
the block device limits by adding support for REQ_OP_ZONE_APPEND in
bio_split(). See also commit 0512a75b98f8 ("block: Introduce
REQ_OP_ZONE_APPEND").

This patch is a bug fix for commit d5e4377d5051 because that commit
introduces a call to bio_split() for zone append bios without adding
support for splitting REQ_OP_ZONE_APPEND bios in bio_split().

Untested.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fc98c1c723ca..8a4805565638 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1631,10 +1631,6 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
 
-	/* Zone append commands cannot be split */
-	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-		return NULL;
-
 	split = bio_alloc_clone(bio->bi_bdev, bio, gfp, bs);
 	if (!split)
 		return NULL;
@@ -1644,7 +1640,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	if (bio_integrity(split))
 		bio_integrity_trim(split);
 
-	bio_advance(bio, split->bi_iter.bi_size);
+	if (bio_op(bio) != REQ_OP_ZONE_APPEND)
+		bio_advance(bio, split->bi_iter.bi_size);
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
