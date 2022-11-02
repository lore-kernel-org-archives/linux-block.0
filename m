Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67315C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 07:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKBHJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKBHJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 03:09:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC920F7F;
        Wed,  2 Nov 2022 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lKs3DorkQ/m5TEvN7EBKJabGBuD3jc29jbflcKCnzDE=; b=Pu84GOCXuIHf4nVtjEbYGzbgml
        MKm0HrjVcy+oSdq9On4erHfvZEuNp+q1Ysh9X+wJk6nYNXt+gLPokIlSjyv7nIJGtrhg6f7+2KfPC
        VuaucAhxOh8j9xba2miV1AVsungF6UXJoD5QsMp7gKZW9LX/MXUXDTfFjVPl8sjGEALm4nUpF9CsJ
        6rWw7WKac4upU7R9A7gqiZ9mAVKUaLecYr753ePY3vQ/I7tmDVdjRmcJHJvOmx3WZkxUm2aVJs1UO
        Tdru0QXAh5COR96tynZQCQRBFSkFZY6HRP1PoP7pQVnRtZMgm7VsNllHswieBib0FYRkHp93wkiP4
        qD5U55eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq7rz-008ZQu-Pw; Wed, 02 Nov 2022 07:09:03 +0000
Date:   Wed, 2 Nov 2022 00:09:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Message-ID: <Y2IXjzWL5eHA3Co9@infradead.org>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
 <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 07:05:35AM +0900, Damien Le Moal wrote:
> >> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
> >> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
> > 
> > How could this even happen?  If we want a debug check,  I think it
> > should be in submit_bio and a WARN_ON_ONCE.
> 
> I have not found any code that issues a FUA read. So I do not think this
> can happen at all currently. The check is about making sure that it
> *never* happens.
> 
> I thought of having the check higher up in the submit path but I wanted to
> avoid adding yet another check in the very hot path. But if you are OK
> with that, I will move it.

I'd do something like this:

---
From 96847cce848938d1ee368e609ccb28a19854fba3 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 2 Nov 2022 08:05:41 +0100
Subject: block: add a sanity check for non-write flush/fua bios

Check that the PREFUSH and FUA flags are only set on write bios,
given that the flush state machine expects that.

Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e9e2bf15cd909..4e2b01a53c6ab 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -720,12 +720,15 @@ void submit_bio_noacct(struct bio *bio)
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
-		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-		if (!bio_sectors(bio)) {
-			status = BLK_STS_OK;
+	if (op_is_flush(bio->bi_opf)) {
+		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE))
 			goto end_io;
+		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
+			if (!bio_sectors(bio)) {
+				status = BLK_STS_OK;
+				goto end_io;
+			}
 		}
 	}
 
-- 
2.30.2

