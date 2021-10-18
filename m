Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A025C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E09860F9E
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhJRKW0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhJRKW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:22:26 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E40DC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+NKa1DdLRDB05oE1UgygTzJn0IB2I16l2taxcEzmWYg=; b=n2t8ZIBXU/QoNeDVM1IXSI868k
        QxXm4S5M9A7qCrE9AvfmjxiSk7LQiyZ/rBXDa8R4a5IDNjm/0CLBkWH0fcGPDVo6EpMTG9qo8lwBG
        81hlDUegy1pN3NAum9VgLvzkGI6J62wJO+aVr2b9n02fpQD7Ksbf4BNtA0PZAl7q31mr4temwXmT0
        qS3Q6Sg904yBUFT7tvpktow5XeZlBykDkljj8fDmSUrXT5tSGGixFxq3nyuvbxiRSbiUvqh1VNhiV
        /uyRLBX71I3wi4BC7Bz2/+SxrpAmAvEwzALf6e4e1a6HuisjABtcQSpFIeiBrXHTPRq3fZqLEm2L1
        UxabLVpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPkc-00EyOB-TS; Mon, 18 Oct 2021 10:20:14 +0000
Date:   Mon, 18 Oct 2021 03:20:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 4/6] nvme: add support for batched completion of polled IO
Message-ID: <YW1KXttSKkHh/cX4@infradead.org>
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017020623.77815-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 08:06:21PM -0600, Jens Axboe wrote:
> Take advantage of struct io_comp_batch, if passed in to the nvme poll
> handler. If it's set, rather than complete each request individually
> inline, store them in the io_comp_batch list. We only do so for requests
> that will complete successfully, anything else will be completed inline as
> before.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/core.c | 17 ++++++++++++++---
>  drivers/nvme/host/nvme.h | 14 ++++++++++++++
>  drivers/nvme/host/pci.c  | 31 +++++++++++++++++++++++++------
>  3 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2c2e8545292..4eadecc67c91 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -346,15 +346,19 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  	return RETRY;
>  }
>  
> -static inline void nvme_end_req(struct request *req)
> +static inline void nvme_end_req_zoned(struct request *req)
>  {
> -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> -
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>  	    req_op(req) == REQ_OP_ZONE_APPEND)
>  		req->__sector = nvme_lba_to_sect(req->q->queuedata,
>  			le64_to_cpu(nvme_req(req)->result.u64));
> +}
> +
> +static inline void nvme_end_req(struct request *req)
> +{
> +	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>  
> +	nvme_end_req_zoned(req);
>  	nvme_trace_bio_complete(req);
>  	blk_mq_end_request(req, status);
>  }
> @@ -381,6 +385,13 @@ void nvme_complete_rq(struct request *req)
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_rq);
>  
> +void nvme_complete_batch_req(struct request *req)
> +{
> +	nvme_cleanup_cmd(req);
> +	nvme_end_req_zoned(req);
> +}
> +EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
> +
>  /*
>   * Called to unwind from ->queue_rq on a failed command submission so that the
>   * multipathing code gets called to potentially failover to another path.
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ed79a6c7e804..ef2467b93adb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -638,6 +638,20 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
>  }
>  
>  void nvme_complete_rq(struct request *req);
> +void nvme_complete_batch_req(struct request *req);
> +
> +static __always_inline void nvme_complete_batch(struct io_comp_batch *iob,
> +						void (*fn)(struct request *rq))
> +{
> +	struct request *req;
> +
> +	rq_list_for_each(&iob->req_list, req) {
> +		fn(req);
> +		nvme_complete_batch_req(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
>  blk_status_t nvme_host_path_error(struct request *req);
>  bool nvme_cancel_request(struct request *req, void *data, bool reserved);
>  void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d1ab9250101a..e916d5e167c1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> -static void nvme_pci_complete_rq(struct request *req)
> +static __always_inline void nvme_pci_unmap_rq(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct nvme_dev *dev = iod->nvmeq->dev;
> @@ -969,9 +969,19 @@ static void nvme_pci_complete_rq(struct request *req)
>  			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
>  	if (blk_rq_nr_phys_segments(req))
>  		nvme_unmap_data(dev, req);
> +}
> +
> +static void nvme_pci_complete_rq(struct request *req)
> +{
> +	nvme_pci_unmap_rq(req);
>  	nvme_complete_rq(req);
>  }
>  
> +static void nvme_pci_complete_batch(struct io_comp_batch *iob)
> +{
> +	nvme_complete_batch(iob, nvme_pci_unmap_rq);
> +}
> +
>  /* We read the CQE phase first to check if the rest of the entry is valid */
>  static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
>  {
> @@ -996,7 +1006,8 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
>  	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
>  }
>  
> -static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> +static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
> +				   struct io_comp_batch *iob, u16 idx)
>  {
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	__u16 command_id = READ_ONCE(cqe->command_id);
> @@ -1023,7 +1034,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
> -	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
> +	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
> +	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
> +					nvme_pci_complete_batch))
>  		nvme_pci_complete_rq(req);
>  }
>  
> @@ -1039,7 +1052,8 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>  	}
>  }
>  
> -static inline int nvme_process_cq(struct nvme_queue *nvmeq)
> +static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
> +			       struct io_comp_batch *iob)
>  {
>  	int found = 0;
>  
> @@ -1050,7 +1064,7 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>  		 * the cqe requires a full read memory barrier
>  		 */
>  		dma_rmb();
> -		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
> +		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
>  		nvme_update_cq_head(nvmeq);
>  	}
>  
> @@ -1059,6 +1073,11 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>  	return found;
>  }
>  
> +static inline int nvme_process_cq(struct nvme_queue *nvmeq)
> +{
> +	return nvme_poll_cq(nvmeq, NULL);
> + }

Extra whitespace here.  But I'd prefer to just drop this wrapping,
and just add the io_comp_batch argument to nvme_process_cq.
