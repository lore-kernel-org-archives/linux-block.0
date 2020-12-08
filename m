Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D72C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D710B23A61
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 06:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLHGEP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 01:04:15 -0500
Received: from mail.synology.com ([211.23.38.101]:53592 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725208AbgLHGEO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 01:04:14 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 01:04:14 EST
Received: from localhost.localdomain (unknown [10.17.210.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 1355ACE78176;
        Tue,  8 Dec 2020 13:53:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1607406786; bh=99FM34qn7bv2Kafzd8rddLNVupGbZ3+KNNzGxYmOFTk=;
        h=From:To:Cc:Subject:Date;
        b=mK8YWqjrSPqwDidSQXs88nsmaYnRRLuq0yJikI6DfyLG5zzxzfSu0BfzcwpQ7Ci20
         77geazfjY2Pn8dYjPRmF7nPNhtHzu8L8TdwEvC8Mt9WIB4fhnFlA+AlTvkI760/QND
         36aAD8hzrE75mbcsJYoLQ55Ii3UmSbOBSAzXHHsg=
From:   edwardh <edwardh@synology.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, s3t@synology.com,
        Edward Hsieh <edwardh@synology.com>
Subject: [PATCH] block: fix trace completion for chained bio
Date:   Tue,  8 Dec 2020 13:52:11 +0800
Message-Id: <1607406731-25553-1-git-send-email-edwardh@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Edward Hsieh <edwardh@synology.com>

For chained bio, trace_block_bio_complete in bio_endio is called only by
the parent bio once upon all chained bio completed. However, the sector and
the size for the parent bio are modified in bio_split. Therefore,
the size of the complete events might not match the queue events.

The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
completion of all bios.") wants multiple complete events to correspond
to one queue event but missed this.

md/raid5 read with bio cross chunks can reproduce this issue.

To fix, move trace completion into the loop for every chained bio to call.

Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
Reviewed-by: Wade Liang <wadel@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Edward Hsieh <edwardh@synology.com>
---
 block/bio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef3..d202d6b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1411,8 +1411,7 @@ static inline bool bio_remaining_done(struct bio *bio)
  *
  *   bio_endio() can be called several times on a bio that has been chained
  *   using bio_chain().  The ->bi_end_io() function will only be called the
- *   last time.  At this point the BLK_TA_COMPLETE tracing event will be
- *   generated if BIO_TRACE_COMPLETION is set.
+ *   last time.
  **/
 void bio_endio(struct bio *bio)
 {
@@ -1425,6 +1424,11 @@ void bio_endio(struct bio *bio)
 	if (bio->bi_disk)
 		rq_qos_done_bio(bio->bi_disk->queue, bio);
 
+	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
+		trace_block_bio_complete(bio->bi_disk->queue, bio);
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+	}
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
@@ -1438,11 +1442,6 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
-	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_complete(bio->bi_disk->queue, bio);
-		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-	}
-
 	blk_throtl_bio_endio(bio);
 	/* release cgroup info */
 	bio_uninit(bio);
-- 
2.7.4

