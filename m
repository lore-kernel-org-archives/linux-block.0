Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC3661027
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJMQru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhJMQrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:47:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F3C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:45:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h196so443548iof.2
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9CkPbgWMnSb0ryXz7g3pY7ZCCC1lIHkrUMptEe76yB4=;
        b=52neg+pNppDdwnzopi4HOjyZuZqc22BCLpJ6fh2/Q4cioDa/Odxsu1OzdewkN//xpS
         8Eryg6QeTqZUy3EHRkUeH0ytCZhW+u1qlqK7poVmkuRZeU3jcS7mfW+eGksvUEIMfw+k
         TsZ7i9WT6NxnHr8IMuYU/QnxaBIPffAaHLMqSStuFSIqFdLiY1XWnanq94T3KAXueekp
         hymLTr5hsC2bC9vdq+8ITk4JB04KzYObwdDMVAWztshrlJCrwjisLxtQ/rJeu+vQJt1Z
         5pm78372qVH2EvfJKCklfOh0UU1522tbzXQOfiYnJMm6Abk42JiJQMDBo4gE6q/WsRet
         lPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9CkPbgWMnSb0ryXz7g3pY7ZCCC1lIHkrUMptEe76yB4=;
        b=igVbsDZrBin1Y6yBE+mPSxxHW/z3dJq/1R2gS93NEeSIVnePbWmSawQlidpAX76wRK
         8jBPJfmngCKFmXfARIfiaxxXetbvnyGYIlqzBCY8TPv9gx72CoU2aUDiokFSR0agucYs
         Ze8NoL9plC6/124TAMZ6vMSSlP9C7/GTPRZCS73CqGYgQ3HnJKmkRVQAyhnoq2IUmEVS
         UtI6zX/mHWXOcQlcLoeKWA73DaL/54pkQlE+yPF7ULl7wAE31dosLkA0sHzf6dSClkMi
         iJO7SYIa8dal44idcDAqr3L0yg8HHAm8nsNKRP6tn6xp6hlNkSnfNsDy8o20ljN2Y7vf
         AgUg==
X-Gm-Message-State: AOAM533x4yukjfV81oiNaFo+bJHWXHxBasysWXvky9O43JBgi5hcsees
        G9+XAQxEq0lCsriXivv+V42HP+DTCfRhiw==
X-Google-Smtp-Source: ABdhPJzBsT4IS2SEWz+Wa4RlRbIrhT9sI9NTVpiJEmZlRWwxMQrtxrPY5rx0gQBDpnRP/0jVq6pJnA==
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr258883iov.51.1634143545184;
        Wed, 13 Oct 2021 09:45:45 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 2sm63719iob.13.2021.10.13.09.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:45:44 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk> <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
 <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
 <YWcAK5D+M6406e7w@infradead.org>
 <9456daa7-bf40-ee85-65b5-a58b9e704706@kernel.dk>
 <YWcFmHnnk1dGigO9@infradead.org>
 <31678b19-30d0-c103-da88-e1b3fa073dd1@kernel.dk>
Message-ID: <0831b07c-6920-034e-699a-c70e4e8c7b59@kernel.dk>
Date:   Wed, 13 Oct 2021 10:45:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31678b19-30d0-c103-da88-e1b3fa073dd1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 10:33 AM, Jens Axboe wrote:
> On 10/13/21 10:13 AM, Christoph Hellwig wrote:
>> On Wed, Oct 13, 2021 at 10:04:36AM -0600, Jens Axboe wrote:
>>> On 10/13/21 9:50 AM, Christoph Hellwig wrote:
>>>> On Wed, Oct 13, 2021 at 09:42:23AM -0600, Jens Axboe wrote:
>>>>> Something like this?
>>>>
>>>> Something like that.  Although without making the new function inline
>>>> this will generate an indirect call.
>>>
>>> It will, but I don't see how we can have it both ways...
>>
>> Last time I played with these optimization gcc did inline function
>> pointers passed to __always_inline function into the calling
>> function.  That is you can keep the source level abstraction but get the
>> code generation as if it was open coded.
> 
> Gotcha, so place nvme_complete_batch() in the nvme.h header. That might
> work, let me give it a whirl.

Looks like this, and it is indeed not an indirect call. I'll re-test the
series and send out a v2.


commit 70ed26ee000d626105b0d807545af42e6d95a323
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 8 05:59:37 2021 -0600

    nvme: add support for batched completion of polled IO
    
    Take advantage of struct io_batch, if passed in to the nvme poll handler.
    If it's set, rather than complete each request individually inline, store
    them in the io_batch list. We only do so for requests that will complete
    successfully, anything else will be completed inline as before.
    
    Add an mq_ops->complete_batch() handler to do the post-processing of
    the io_batch list once polling is complete.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c2e8545292..4b14258a3bac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -346,15 +346,19 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	return RETRY;
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void nvme_end_req_zoned(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
 			le64_to_cpu(nvme_req(req)->result.u64));
+}
+
+static inline void nvme_end_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
+	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	blk_mq_end_request(req, status);
 }
@@ -381,6 +385,14 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_complete_batch_req(struct request *req)
+{
+	nvme_cleanup_cmd(req);
+	nvme_end_req_zoned(req);
+	req->status = BLK_STS_OK;
+}
+EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
+
 /*
  * Called to unwind from ->queue_rq on a failed command submission so that the
  * multipathing code gets called to potentially failover to another path.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..e0c079f704cf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,23 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+void nvme_complete_batch_req(struct request *req);
+
+static __always_inline void nvme_complete_batch(struct io_batch *iob,
+						void (*fn)(struct request *rq))
+{
+	struct request *req;
+
+	req = rq_list_peek(&iob->req_list);
+	while (req) {
+		fn(req);
+		nvme_complete_batch_req(req);
+		req = rq_list_next(req);
+	}
+
+	blk_mq_end_request_batch(iob);
+}
+
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9db6e23f41ef..ae253f6f5c80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static void nvme_pci_complete_rq(struct request *req)
+static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_dev *dev = iod->nvmeq->dev;
@@ -969,9 +969,19 @@ static void nvme_pci_complete_rq(struct request *req)
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
+}
+
+static void nvme_pci_complete_rq(struct request *req)
+{
+	nvme_pci_unmap_rq(req);
 	nvme_complete_rq(req);
 }
 
+static void nvme_pci_complete_batch(struct io_batch *iob)
+{
+	nvme_complete_batch(iob, nvme_pci_unmap_rq);
+}
+
 /* We read the CQE phase first to check if the rest of the entry is valid */
 static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 {
@@ -996,7 +1006,8 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
 }
 
-static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
+static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
+				   struct io_batch *iob, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	__u16 command_id = READ_ONCE(cqe->command_id);
@@ -1023,8 +1034,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
-		nvme_pci_complete_rq(req);
+	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
+		/*
+		 * Do normal inline completion if we don't have a batch
+		 * list, if we have an end_io handler, or if the status of
+		 * the request isn't just normal success.
+		 */
+		if (!iob || req->end_io || nvme_req(req)->status)
+			nvme_pci_complete_rq(req);
+		else
+			rq_list_add_tail(&iob->req_list, req);
+	}
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
@@ -1050,7 +1070,7 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, NULL, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
@@ -1092,6 +1112,27 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
+static inline int nvme_poll_cq(struct nvme_queue *nvmeq, struct io_batch *iob)
+{
+	int found = 0;
+
+	while (nvme_cqe_pending(nvmeq)) {
+		found++;
+		/*
+		 * load-load control dependency between phase and the rest of
+		 * the cqe requires a full read memory barrier
+		 */
+		dma_rmb();
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+	}
+
+	if (found)
+		nvme_ring_cq_doorbell(nvmeq);
+	return found;
+}
+
+
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
@@ -1101,7 +1142,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *iob)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq);
+	found = nvme_poll_cq(nvmeq, iob);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -1639,6 +1680,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
+	.complete_batch = nvme_pci_complete_batch,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,

-- 
Jens Axboe

