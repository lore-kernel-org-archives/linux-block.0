Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE34960FF2
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhJNHqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 03:46:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA35C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wmHsD1hKIhXSMXsc77chwqWOC74D9HpD+o99oxhGH3Q=; b=AlhxFYdyHdOrMxkxrvIH8Mn4mn
        ECpTcPH2Ej8xyxe6PcZcl5TMx5jGbf0z22LW8tdD3jJppbinkQwjCSIC0HLd99w87fADh0pDaGVMY
        Un4Ts3FTmmRyDhGsi5Z9krVOrYD7Hc16xvqo2H1phSC3HnZYEyy0mtoY+eqK6CLjqTakY3DVAnbtt
        NVIZmP22du7Xlidg1hwdXWlnu+B+Yblowu7vWRKu/qIZOI67B1XaroJOR1s62rEhtzg+nJCAH7Idq
        8bbuliyKo5bwKJc90j00h6B0jVAUlwpLwcu0qWp91TtP092ZWw5nS7cnY4aqzSsh4X5FpJighSowU
        0mrQoA/g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mavOT-0089RP-3X; Thu, 14 Oct 2021 07:43:31 +0000
Date:   Thu, 14 Oct 2021 08:43:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
Message-ID: <YWffkZ2w/mhcJIAU@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165416.985696-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:54:13AM -0600, Jens Axboe wrote:
> +void nvme_complete_batch_req(struct request *req)
> +{
> +	nvme_cleanup_cmd(req);
> +	nvme_end_req_zoned(req);
> +	req->status = BLK_STS_OK;
> +}
> +EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
> +

I'd be tempted to just merge this helper into the only caller.
nvme_cleanup_cmd is exported anyway, so this would just add an export
for nvme_end_req_zoned.

> +static __always_inline void nvme_complete_batch(struct io_batch *iob,
> +						void (*fn)(struct request *rq))
> +{
> +	struct request *req;
> +
> +	req = rq_list_peek(&iob->req_list);
> +	while (req) {
> +		fn(req);
> +		nvme_complete_batch_req(req);
> +		req = rq_list_next(req);
> +	}
> +
> +	blk_mq_end_request_batch(iob);

Can we turn this into a normal for loop?

	for (req = rq_list_peek(&iob->req_list); req; req = rq_list_next(req)) {
		..
	}

> +	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
> +		/*
> +		 * Do normal inline completion if we don't have a batch
> +		 * list, if we have an end_io handler, or if the status of
> +		 * the request isn't just normal success.
> +		 */
> +		if (!iob || req->end_io || nvme_req(req)->status)
> +			nvme_pci_complete_rq(req);
> +		else
> +			rq_list_add_tail(&iob->req_list, req);
> +	}

The check for the conditions where we can or cannot batch complete
really should go into a block layer helper.  Something like the
incremental patch below:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce69e9666caac..57bef8229bfab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1034,17 +1034,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	}
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
-		/*
-		 * Do normal inline completion if we don't have a batch
-		 * list, if we have an end_io handler, or if the status of
-		 * the request isn't just normal success.
-		 */
-		if (!iob || req->end_io || nvme_req(req)->status)
-			nvme_pci_complete_rq(req);
-		else
-			rq_list_add_tail(&iob->req_list, req);
-	}
+	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
+	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status))
+		nvme_pci_complete_rq(req);
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index aea7d866a34c6..383d887e32f6d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -773,6 +773,19 @@ void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
 void blk_mq_end_request_batch(struct io_batch *ib);
 
+/*
+ * Batched completions only work when there is no I/O error and not special
+ * ->end_io handler.
+ */
+static inline bool blk_mq_add_to_batch(struct request *req,
+		 struct io_batch *iob, bool ioerror)
+{
+	if (!iob || req->end_io || ioerror)
+		return false;
+	rq_list_add_tail(&iob->req_list, req);
+	return true;
+}
+
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
