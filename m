Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB384C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCTXvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCTXvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:51:06 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAB32527
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:32 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso18166976pjb.3
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0htuxj+xYDwdXpkOC4+cEB037EaSURNu1sQNEZqd9U=;
        b=rCm0NDcikhNANqWw8WSqRUxxb/NfokjmJOmkJL93UIWEkFswG8ZbYpHIh6AApzKzto
         9vdp9Qn5brpEHm8BFYP7O0AzoEszqP3GcjwnMPObyDbH6F4mg+4uZfhGA2I288RYuasP
         /2qhsKscIsPl1aelHJfGi/vkpwzS9jSc2qFtrs3CbM0X91EJn1fLNL3SNF9GVoOWWZly
         CC57TmwEFT0qmgDoNPtmapX2CfADuiZtw6Huj+0PtA2Piy9xZLpLkARJ+NO9/49UutiW
         qanbT6qpFY5a/EYGxHWooETFITAukmfQ1ziLwsujPp1ffhU1tLhtBwdMbv/NKoqZeBV3
         bVmA==
X-Gm-Message-State: AO0yUKXrCRNH/aoRvtGv54mT4/rn8imQ2n4Nsf/QOkordL++yluvAIFn
        /9bva6Ew7aGbYPWGBz2q894=
X-Google-Smtp-Source: AK7set8dqmKN3FrcKC8uVy6/xMsdjkzP+OE0+R2UcvwHVE4gQ6tObZkVCMn9q1d7XnY1XEe2ryoBow==
X-Received: by 2002:a05:6a20:8b85:b0:cb:6869:ca66 with SMTP id m5-20020a056a208b8500b000cb6869ca66mr314788pzh.19.1679356174508;
        Mon, 20 Mar 2023 16:49:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78dd7000000b0058bf2ae9694sm6915907pfr.156.2023.03.20.16.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:49:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/3] block: Split and submit bios in LBA order
Date:   Mon, 20 Mar 2023 16:49:04 -0700
Message-Id: <20230320234905.3832131-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230320234905.3832131-1-bvanassche@acm.org>
References: <20230320234905.3832131-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Submit the bio fragment with the lowest LBA first. This approach prevents
write errors when submitting large bios to host-managed zoned block devices.
This patch only modifies the behavior of drivers that call
bio_split_to_limits() directly. This includes DRBD, pktcdvd, dm, md and
the NVMe multipath code.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d6f8552ef209..7281f2d91b2f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -345,8 +345,8 @@ EXPORT_SYMBOL_GPL(bio_split_rw);
  * @nr_segs: returns the number of segments in the returned bio
  *
  * Check if @bio needs splitting based on the queue limits, and if so split off
- * a bio fitting the limits from the beginning of @bio and return it.  @bio is
- * shortened to the remainder and re-submitted.
+ * a bio fitting the limits from the beginning of @bio. @bio is shortened to
+ * the remainder.
  *
  * The split bio is allocated from @q->bio_split, which is provided by the
  * block layer.
@@ -379,10 +379,23 @@ struct bio *__bio_split_to_limits(struct bio *bio,
 		split->bi_opf |= REQ_NOMERGE;
 
 		blkcg_bio_issue_init(split);
-		bio_chain(split, bio);
 		trace_block_split(split, bio->bi_iter.bi_sector);
-		submit_bio_noacct(bio);
-		return split;
+		if (current->bio_list) {
+			/*
+			 * The caller will submit the first half ('split')
+			 * before the second half ('bio').
+			 */
+			bio_chain(split, bio);
+			submit_bio_noacct(bio);
+			return split;
+		}
+		/*
+		 * Submit the first half ('split') let the caller submit the
+		 * second half ('bio').
+		 */
+		*nr_segs = bio_chain_nr_segments(bio, lim);
+		bio_chain(split, bio);
+		submit_bio_noacct(split);
 	}
 	return bio;
 }
