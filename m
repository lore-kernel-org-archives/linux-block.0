Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52DFA3740
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 06:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJaGLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaGLX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 02:11:23 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF172DD2
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 23:11:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VTQwfyo_1667196678;
Received: from 30.97.56.208(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VTQwfyo_1667196678)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 14:11:19 +0800
Message-ID: <805e2799-c4cb-9e61-ceb7-dbf3d39e645e@linux.alibaba.com>
Date:   Mon, 31 Oct 2022 14:11:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] ublk_drv: add ublk_queue_cmd() for cleanup
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20221029010432.598367-1-ming.lei@redhat.com>
 <20221029010432.598367-5-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221029010432.598367-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/29 09:04, Ming Lei wrote:
> Add helper of ublk_queue_cmd() so that both ublk_queue_rq()
> and ublk_handle_need_get_data() can reuse this helper.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 47 ++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3a59271dafe4..f96cb01e9604 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -817,12 +817,28 @@ static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
>  	}
>  }
>  
> +static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq,
> +		bool last)
> +{
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> +
> +	if (ublk_can_use_task_work(ubq)) {
> +		enum task_work_notify_mode notify_mode = last ?
> +			TWA_SIGNAL_NO_IPI : TWA_NONE;
> +
> +		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
> +			__ublk_abort_rq(ubq, rq);
> +	} else {
> +		if (llist_add(&data->node, &ubq->io_cmds))
> +			ublk_submit_cmd(ubq, rq);
> +	}
> +}
> +
>  static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		const struct blk_mq_queue_data *bd)
>  {
>  	struct ublk_queue *ubq = hctx->driver_data;
>  	struct request *rq = bd->rq;
> -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
>  	blk_status_t res;
>  
>  	/* fill iod to slot in io cmd buffer */
> @@ -845,21 +861,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_mq_start_request(bd->rq);
>  
>  	if (unlikely(ubq_daemon_is_dying(ubq))) {
> - fail:
>  		__ublk_abort_rq(ubq, rq);
>  		return BLK_STS_OK;
>  	}
>  
> -	if (ublk_can_use_task_work(ubq)) {
> -		enum task_work_notify_mode notify_mode = bd->last ?
> -			TWA_SIGNAL_NO_IPI : TWA_NONE;
> +	ublk_queue_cmd(ubq, rq, bd->last);
>  
> -		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
> -			goto fail;
> -	} else {
> -		if (llist_add(&data->node, &ubq->io_cmds))
> -			ublk_submit_cmd(ubq, rq);
> -	}
>  	return BLK_STS_OK;
>  }
>  
> @@ -1185,24 +1192,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  }
>  
>  static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> -		int tag, struct io_uring_cmd *cmd)
> +		int tag)
>  {
>  	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
>  	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
> -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
>  
> -	if (ublk_can_use_task_work(ubq)) {
> -		/* should not fail since we call it just in ubq->ubq_daemon */
> -		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
> -	} else {
> -		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> -
> -		if (llist_add(&data->node, &ubq->io_cmds)) {
> -			pdu->ubq = ubq;
> -			io_uring_cmd_complete_in_task(cmd,
> -					ublk_rq_task_work_cb);
> -		}
> -	}
> +	ublk_queue_cmd(ubq, req, true);
>  }
>  
>  static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> @@ -1290,7 +1285,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		io->addr = ub_cmd->addr;
>  		io->cmd = cmd;
>  		io->flags |= UBLK_IO_FLAG_ACTIVE;
> -		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag, cmd);
> +		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
>  		break;
>  	default:
>  		goto out;

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
