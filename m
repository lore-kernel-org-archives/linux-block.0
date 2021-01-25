Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D603C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424C323102
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAYSly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAYSlt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 13:41:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E5C061573
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aOCxoP8Cx0GzsvjMPiqxOtxmA7O57lsfvcpJEQamQpY=; b=mp1zZ00vyAXrctAyDGXMxoZV/6
        40Y5f7yBaZc62dV7cucEXhU9PbtrTKRlXmY8f1OmTxZ3YWZLTF8vqi/Bk6yYF1o6EBoMFrifn0VBh
        zdFzey11c+NfXvdc68SKiHye9pbQXkrDhkHeRRN35uXh2Oz7Sjcq6l7l/q4Ol0zA0TFZ3tqkLn1zj
        sqHnQSDfzccccQWmr0+CaiN7sXgnwDS9Uxvt9N6bGY4r4Wwv+iCe/oawDz4pihGOqeSvsrW0N799N
        2UyAnm7Xt8+IStP9eccvtLj7AewsT1ec7stowRj+a5t8zcudShaOD5q62hotGlSXBvxHTdEcMzxTU
        FMUoxM3A==;
Received: from [2001:4bb8:18c:2252:9e10:9882:7bee:417c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l46mN-004WlX-D3; Mon, 25 Jan 2021 18:40:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: skip bio_check_eod for partition-remapped bios
Date:   Mon, 25 Jan 2021 19:39:57 +0100
Message-Id: <20210125183957.1674124-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When an already remapped bio is resubmitted (e.g. by blk_queue_split),
bio_check_eod will compare the remapped bi_sector against the size
of the partition, leading to spurious I/O failures.

Skip the EOD check in this case.

Fixes: 309dca309fc3 ("block: store a block_device pointer in struct bio")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 88f60890443264..5e752840b41a1f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -815,11 +815,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		goto end_io;
 	if (unlikely(bio_check_ro(bio)))
 		goto end_io;
-	if (unlikely(bio_check_eod(bio)))
-		goto end_io;
-	if (bio->bi_bdev->bd_partno && !bio_flagged(bio, BIO_REMAPPED) &&
-	    unlikely(blk_partition_remap(bio)))
-		goto end_io;
+	if (!bio_flagged(bio, BIO_REMAPPED)) {
+		if (unlikely(bio_check_eod(bio)))
+			goto end_io;
+		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+			goto end_io;
+	}
 
 	/*
 	 * Filter flush bio's early so that bio based drivers without flush
-- 
2.29.2

