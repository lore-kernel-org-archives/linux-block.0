Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3049FA3740
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 05:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJaFPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 01:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaFPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 01:15:41 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F22B95BF
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 22:15:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VTPU4X3_1667193336;
Received: from 30.97.56.208(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VTPU4X3_1667193336)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 13:15:37 +0800
Message-ID: <3c76a77d-df7d-a3e7-1209-e15db52344db@linux.alibaba.com>
Date:   Mon, 31 Oct 2022 13:15:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4] ublk_drv: avoid to touch io_uring cmd in blk_mq io
 path
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20221029010432.598367-1-ming.lei@redhat.com>
 <20221029010432.598367-4-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221029010432.598367-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/29 09:04, Ming Lei wrote:
> io_uring cmd is supposed to be used in ubq daemon context mainly,
> and we should try to avoid to touch it in ublk io submission context,
> otherwise this data could become shared between the two contexts,
> and performance is hurt.
> 
> So link request into one per-queue list, and use same batching policy
> of io_uring command, just avoid to touch ucmd in blk-mq io context.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 83 +++++++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6b2f214f0d5c..3a59271dafe4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -57,11 +57,14 @@
>  #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
>  
>  struct ublk_rq_data {
> -	struct callback_head work;
> +	union {
> +		struct callback_head work;
> +		struct llist_node node;
> +	};
>  };
>  
>  struct ublk_uring_cmd_pdu {
> -	struct request *req;
> +	struct ublk_queue *ubq;
>  };
>  
>  /*
> @@ -119,6 +122,8 @@ struct ublk_queue {
>  	struct task_struct	*ubq_daemon;
>  	char *io_cmd_buf;
>  
> +	struct llist_head	io_cmds;
> +
>  	unsigned long io_addr;	/* mapped vm address */
>  	unsigned int max_io_sz;
>  	bool force_abort;
> @@ -764,8 +769,12 @@ static inline void __ublk_rq_task_work(struct request *req)
>  static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
>  {
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> +	struct ublk_queue *ubq = pdu->ubq;
> +	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> +	struct ublk_rq_data *data;
>  
> -	__ublk_rq_task_work(pdu->req);
> +	llist_for_each_entry(data, io_cmds, node)
> +		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
>  }
>  
>  static void ublk_rq_task_work_fn(struct callback_head *work)
> @@ -777,17 +786,50 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>  	__ublk_rq_task_work(req);
>  }
>  
> +static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
> +{
> +	struct ublk_io *io = &ubq->ios[rq->tag];
> +
> +	/*
> +	 * If the check pass, we know that this is a re-issued request aborted
> +	 * previously in monitor_work because the ubq_daemon(cmd's task) is
> +	 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
> +	 * because this ioucmd's io_uring context may be freed now if no inflight
> +	 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
> +	 *
> +	 * Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
> +	 * the tag). Then the request is re-started(allocating the tag) and we are here.
> +	 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
> +	 * guarantees that here is a re-issued request aborted previously.
> +	 */
> +	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED)) {
> +		struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> +		struct ublk_rq_data *data;
> +
> +		llist_for_each_entry(data, io_cmds, node)
> +			__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
> +	} else {
> +		struct io_uring_cmd *cmd = io->cmd;
> +		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> +
> +		pdu->ubq = ubq;
> +		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
> +	}
> +}
> +
>  static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		const struct blk_mq_queue_data *bd)
>  {
>  	struct ublk_queue *ubq = hctx->driver_data;
>  	struct request *rq = bd->rq;
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
>  	blk_status_t res;
>  
>  	/* fill iod to slot in io cmd buffer */
>  	res = ublk_setup_iod(ubq, rq);
>  	if (unlikely(res != BLK_STS_OK))
>  		return BLK_STS_IOERR;
> +
>  	/* With recovery feature enabled, force_abort is set in
>  	 * ublk_stop_dev() before calling del_gendisk(). We have to
>  	 * abort all requeued and new rqs here to let del_gendisk()
> @@ -809,36 +851,15 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	}
>  
>  	if (ublk_can_use_task_work(ubq)) {
> -		struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
>  		enum task_work_notify_mode notify_mode = bd->last ?
>  			TWA_SIGNAL_NO_IPI : TWA_NONE;
>  
>  		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
>  			goto fail;
>  	} else {
> -		struct ublk_io *io = &ubq->ios[rq->tag];
> -		struct io_uring_cmd *cmd = io->cmd;
> -		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> -
> -		/*
> -		 * If the check pass, we know that this is a re-issued request aborted
> -		 * previously in monitor_work because the ubq_daemon(cmd's task) is
> -		 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
> -		 * because this ioucmd's io_uring context may be freed now if no inflight
> -		 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
> -		 *
> -		 * Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
> -		 * the tag). Then the request is re-started(allocating the tag) and we are here.
> -		 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
> -		 * guarantees that here is a re-issued request aborted previously.
> -		 */
> -		if ((io->flags & UBLK_IO_FLAG_ABORTED))
> -			goto fail;
> -
> -		pdu->req = rq;
> -		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
> +		if (llist_add(&data->node, &ubq->io_cmds))
> +			ublk_submit_cmd(ubq, rq);
>  	}
> -
>  	return BLK_STS_OK;
>  }
>  
> @@ -1168,17 +1189,19 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
>  {
>  	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
>  	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
>  
>  	if (ublk_can_use_task_work(ubq)) {
> -		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> -
>  		/* should not fail since we call it just in ubq->ubq_daemon */
>  		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
>  	} else {
>  		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>  
> -		pdu->req = req;
> -		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
> +		if (llist_add(&data->node, &ubq->io_cmds)) {
> +			pdu->ubq = ubq;
> +			io_uring_cmd_complete_in_task(cmd,
> +					ublk_rq_task_work_cb);
> +		}
>  	}
>  }
>  

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
