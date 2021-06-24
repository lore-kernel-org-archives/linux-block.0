Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0544AC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08346054E
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFXMdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:33:39 -0400
Received: from mail.synology.com ([211.23.38.101]:57720 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhFXMdd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 08:33:33 -0400
Received: from localhost.localdomain (unknown [10.17.210.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 78FDA157F371;
        Thu, 24 Jun 2021 20:31:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1624537873; bh=QAn28bZkU1zhptlirNyycdhlvS3W1aY4Z1E/pRqikQ8=;
        h=From:To:Cc:Subject:Date;
        b=gwALpyjVsrkZAw0xGAT4F9Lvmj1lColvw/hLx3/OFNJ6HglxTvjrMR/L6UIDZnarW
         ErLObRVzCSBzT8Vv/RU90j5Xhkn6FPPQ8D5g7T5ANHhYO1Izt3pkcyiu86TxxwEHNe
         PS2wXnDOTQu4tsNo87vN3whujS+3XpAN5YUGGK6s=
From:   edwardh <edwardh@synology.com>
To:     axboe@kernel.dk, neilb@suse.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com,
        Edward Hsieh <edwardh@synology.com>,
        Wade Liang <wadel@synology.com>
Subject: [PATCH v4] block: fix trace completion for chained bio
Date:   Thu, 24 Jun 2021 20:30:30 +0800
Message-Id: <20210624123030.27014-1-edwardh@synology.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Edward Hsieh <edwardh@synology.com>

For chained bio, trace_block_bio_complete in bio_endio is currently called
only by the parent bio once upon all chained bio completed.
However, the sector and size for the parent bio are modified in bio_split.
Therefore, the size and sector of the complete events might not match the
queue events in blktrace.

The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
completion of all bios.") wants multiple complete events to correspond
to one queue event but missed this.

The issue can be reproduced by md/raid5 read with bio cross chunks.

To fix, move trace completion into the loop for every chained bio to call.

Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
Reviewed-by: Wade Liang <wadel@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Edward Hsieh <edwardh@synology.com>
---
 block/bio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..1fab762e079b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1375,8 +1375,7 @@ static inline bool bio_remaining_done(struct bio *bio)
  *
  *   bio_endio() can be called several times on a bio that has been chained
  *   using bio_chain().  The ->bi_end_io() function will only be called the
- *   last time.  At this point the BLK_TA_COMPLETE tracing event will be
- *   generated if BIO_TRACE_COMPLETION is set.
+ *   last time.
  **/
 void bio_endio(struct bio *bio)
 {
@@ -1389,6 +1388,11 @@ void bio_endio(struct bio *bio)
 	if (bio->bi_bdev)
 		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);
 
+	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
+		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+	}
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
@@ -1402,11 +1406,6 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
-	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
-		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-	}
-
 	blk_throtl_bio_endio(bio);
 	/* release cgroup info */
 	bio_uninit(bio);
-- 
2.31.1

