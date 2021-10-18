Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E09C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B7B60FDC
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJRIzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJRIzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:55:46 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83053C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OkNOV03UC44psyg4uN32nicamtNF+OkBMi6UDo8hFOU=; b=gE1y8wPZwCnoitPzPh3EAlEcWq
        IGWF597bUzas3HCMrLTLxyqUziWowYivi2LQZ1L5/mP6bVt/qjV49rfRvISpCwLtrrf9QcBFHvahE
        gp9F605rjPfCR5u/CXZlfBdWZrS8zLvILbkQocKdCq9Bgq+21Arj8ftHcBQWEvb+f2QGpdwK40McG
        iVqhigbjEnAPd31hGivv36jnvNsRmZHUvahegj/nzAYQzkjgVwp6l/8w/JEp+jki1GiZC4rabfYIv
        9/xJAYyxQ7kFVv3sSHz1Ff7HsgCq1EBFLfU8e3Fw8F9Q6NG4xMgrFDVLxJ4kc1nFB7JVrFxZ9kJFR
        r/YLnkog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOOl-00EiBg-2F; Mon, 18 Oct 2021 08:53:35 +0000
Date:   Mon, 18 Oct 2021 01:53:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/14] block: don't call blk_status_to_errno() for
 success status
Message-ID: <YW02D5sdhgxH8rwo@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:39PM -0600, Jens Axboe wrote:
> We only need to call it to resolve the blk_status_t -> errno mapping
> if the status is different than BLK_STS_OK. Check that it is before
> doing so.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---

Actually what I had in mind was something like this:

---
From 371ccad84c28127ff0ce8a09106505986532b5ec Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 18 Oct 2021 10:45:18 +0200
Subject: block: don't call blk_status_to_errno in blk_update_request

We only need to call it to resolve the blk_status_t -> errno mapping for
tracing, so move the conversion into the tracepoints that are not called
at all when tracing isn't enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c             | 2 +-
 include/trace/events/block.h | 6 +++---
 kernel/trace/blktrace.c      | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5b0258dd218b..007bc2b339c55 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1451,7 +1451,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 {
 	int total_bytes;
 
-	trace_block_rq_complete(req, blk_status_to_errno(error), nr_bytes);
+	trace_block_rq_complete(req, error, nr_bytes);
 
 	if (!req->bio)
 		return false;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index cc5ab96a7471f..a95daa4d4caa2 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -114,7 +114,7 @@ TRACE_EVENT(block_rq_requeue,
  */
 TRACE_EVENT(block_rq_complete,
 
-	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
 
 	TP_ARGS(rq, error, nr_bytes),
 
@@ -122,7 +122,7 @@ TRACE_EVENT(block_rq_complete,
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
-		__field(  int,		error			)
+		__field(  int	,	error			)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -131,7 +131,7 @@ TRACE_EVENT(block_rq_complete,
 		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
-		__entry->error     = error;
+		__entry->error     = blk_status_to_errno(error);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fa91f398f28b7..1183c88634aa6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -816,7 +816,7 @@ blk_trace_request_get_cgid(struct request *rq)
  *     Records an action against a request. Will log the bio offset + size.
  *
  **/
-static void blk_add_trace_rq(struct request *rq, int error,
+static void blk_add_trace_rq(struct request *rq, blk_status_t error,
 			     unsigned int nr_bytes, u32 what, u64 cgid)
 {
 	struct blk_trace *bt;
@@ -834,7 +834,8 @@ static void blk_add_trace_rq(struct request *rq, int error,
 		what |= BLK_TC_ACT(BLK_TC_FS);
 
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
-			rq->cmd_flags, what, error, 0, NULL, cgid);
+			rq->cmd_flags, what, blk_status_to_errno(error), 0,
+			NULL, cgid);
 	rcu_read_unlock();
 }
 
@@ -863,7 +864,7 @@ static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)
 }
 
 static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
-			int error, unsigned int nr_bytes)
+			blk_status_t error, unsigned int nr_bytes)
 {
 	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,
 			 blk_trace_request_get_cgid(rq));
-- 
2.30.2

