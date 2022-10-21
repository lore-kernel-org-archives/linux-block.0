Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE07C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 02:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJUCtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJUCte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:49:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E6A45F
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:49:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtpkT5kQHzpSsn;
        Fri, 21 Oct 2022 10:46:09 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:49:29 +0800
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <404f5e5c-df21-3d1b-e263-2132ba7791d0@huawei.com>
Date:   Fri, 21 Oct 2022 10:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just
> pass the tagset, and move the non-mq check into the only caller that
> needs it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c           | 10 +++++-----
>   drivers/nvme/host/core.c |  4 ++--
>   drivers/scsi/scsi_lib.c  |  2 +-
>   include/linux/blk-mq.h   |  2 +-
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4a81a2da43328..cf8f9f9a96c35 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -254,15 +254,15 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>   
>   /**
>    * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
> - * @q: request queue.
> + * @set: tag_set to wait on
>    *
>    * Note: it is driver's responsibility for making sure that quiesce has
>    * been started.
>    */
> -void blk_mq_wait_quiesce_done(struct request_queue *q)
> +void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)
>   {
> -	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> -		synchronize_srcu(&q->tag_set->srcu);
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		synchronize_srcu(&set->srcu);
>   	else
>   		synchronize_rcu();
>   }
> @@ -282,7 +282,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
>   	blk_mq_quiesce_queue_nowait(q);
>   	/* nothing to wait for non-mq queues */
>   	if (queue_is_mq(q))
> -		blk_mq_wait_quiesce_done(q);
> +		blk_mq_wait_quiesce_done(q->tag_set);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>   
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 44a5321743128..a74212a4f1a5f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5100,7 +5100,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
>   		blk_mq_quiesce_queue(ns->queue);
>   	else
> -		blk_mq_wait_quiesce_done(ns->queue);
> +		blk_mq_wait_quiesce_done(ns->queue->tag_set);
>   }
>   
>   /*
> @@ -5216,7 +5216,7 @@ void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
>   	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
>   		blk_mq_quiesce_queue(ctrl->admin_q);
>   	else
> -		blk_mq_wait_quiesce_done(ctrl->admin_q);
> +		blk_mq_wait_quiesce_done(ctrl->admin_q->tag_set);
>   }
>   EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
>   
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 8b89fab7c4206..249757ddd8fea 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2735,7 +2735,7 @@ static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
>   			blk_mq_quiesce_queue(sdev->request_queue);
>   	} else {
>   		if (!nowait)
> -			blk_mq_wait_quiesce_done(sdev->request_queue);
> +			blk_mq_wait_quiesce_done(sdev->request_queue->tag_set);
>   	}
>   }
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index f040a7cab5dbf..dfd565c4fb84e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -881,7 +881,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
>   void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>   void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>   void blk_mq_quiesce_queue(struct request_queue *q);
> -void blk_mq_wait_quiesce_done(struct request_queue *q);
> +void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
>   void blk_mq_unquiesce_queue(struct request_queue *q);
>   void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
>   void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
> 
