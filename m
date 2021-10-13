Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1ADC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CC2610A2
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJMPva (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMPv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:51:29 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE6C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:49:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i11so154977ila.12
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s2SV06/OAwoXYtJwNkm3enj3iJ/XQZ4SN5/CerSv24w=;
        b=ZLQDrFdjZaXsSZXJ003hpRNbWeyYgqgIHkfL6C40k2N/OIZMvmmgs1QOCLAys/nSKs
         mzNSfwEBK3I6looRU+i/V+7UmdV9q2TddJVyQDec3C2x/exEPGLJIS4rUmoNcCrArWkn
         4IOIQTp60uPB0GAATH3ZDZLrXq8wpBvsrN4Q0RKXPt6wvbX3PxAaTqceVZutxmla8it6
         ua4Qc6ZL7SWcP5q6wOsfLSiaKl+8djWLhzRLvhfuK897uN3ilNWLvwwjXs8eVnBEfQAo
         4OIShUXBN7wSCeIaH/HP0nxUxS+Sttf5CjfcPc2J3TrGq/bTmXwEvOZwd4Hk1wh8LPds
         kx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2SV06/OAwoXYtJwNkm3enj3iJ/XQZ4SN5/CerSv24w=;
        b=i0HwKtu1/rhocUj+TF3GOewV5BJR/ZKN/cP7HQBqUMqDvN+sG+hRQi1jgCwsuLEHZu
         OAreCDPahQFoKjVkDWw64Do+Yz/jvamULb/JZZKuOEZoAorVDvMmU6UGR9iSE3deX/kN
         uznvcoCOLpLO0EwCEKjtHksPkEZHedCIJ+3WYimHAIubvP2zIYJJtqldsHAotASQCXDx
         RSgecWprYgw4mobrAb6VRrFXjHblbNXarkX594/dvtGL3OkbgU5qMPJXuf1+MMtyxIZd
         QScRqgjj8LkjNinMzWWFoH3yVaPWjsAtgkSGN57oC8bXpWQaKFcLL2Wk4ZrALazSAhXg
         BcaQ==
X-Gm-Message-State: AOAM532OYURFJzyvEUtvQZkl4GZLLZs8pZqdLBF4G+XsSfOpxKB2ldqX
        sO5giazg8BCDEvFWJ0t5i/KLb2bUeYhzcg==
X-Google-Smtp-Source: ABdhPJweO1CQ9AZQ5ugWQ/kd4gKNcSfYYO8MtrGrAGiDFofo4V2RV6BU72iS8GVdLSdjdDJsiB+TLQ==
X-Received: by 2002:a05:6e02:1a61:: with SMTP id w1mr199182ilv.197.1634140164960;
        Wed, 13 Oct 2021 08:49:24 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z11sm7176377ilb.11.2021.10.13.08.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:49:24 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk> <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
 <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
Message-ID: <f01803a9-10d6-a5e1-27ae-e19ad50e7396@kernel.dk>
Date:   Wed, 13 Oct 2021 09:49:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 9:42 AM, Jens Axboe wrote:
> On 10/13/21 9:16 AM, Christoph Hellwig wrote:
>> On Wed, Oct 13, 2021 at 09:10:01AM -0600, Jens Axboe wrote:
>>>> Also - can you look into turning this logic into an inline function with
>>>> a callback for the driver?  I think in general gcc will avoid the
>>>> indirect call for function pointers passed directly.  That way we can
>>>> keep a nice code structure but also avoid the indirections.
>>>>
>>>> Same for nvme_pci_complete_batch.
>>>
>>> Not sure I follow. It's hard to do a generic callback for this, as the
>>> batch can live outside the block layer through the plug. That's why
>>> it's passed the way it is in terms of completion hooks.
>>
>> Basically turn nvme_pci_complete_batch into a core nvme helper (inline)
>> with nvme_pci_unmap_rq passed as a function pointer that gets inlined.
> 
> Something like this?

Full patch below for reference, might be easier to read. Got rid of
the prep patch for nvme as well, so this is everything.


commit 002fcc4dd9869cd0fc8684b37ede8e20bdca16a4
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
index c2c2e8545292..26328fd26ff0 100644
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
@@ -381,6 +385,23 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_complete_batch(struct io_batch *iob, void (*fn)(struct request *rq))
+{
+	struct request *req;
+
+	req = rq_list_peek(&iob->req_list);
+	while (req) {
+		fn(req);
+		nvme_cleanup_cmd(req);
+		nvme_end_req_zoned(req);
+		req->status = BLK_STS_OK;
+		req = rq_list_next(req);
+	}
+
+	blk_mq_end_request_batch(iob);
+}
+EXPORT_SYMBOL_GPL(nvme_complete_batch);
+
 /*
  * Called to unwind from ->queue_rq on a failed command submission so that the
  * multipathing code gets called to potentially failover to another path.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..b73a573472d9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,7 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+void nvme_complete_batch(struct io_batch *iob, void (*fn)(struct request *));
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9db6e23f41ef..b3e686404adf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static void nvme_pci_complete_rq(struct request *req)
+static void nvme_pci_unmap_rq(struct request *req)
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

