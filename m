Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB51C433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4F5222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 09:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbgJTJEc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 05:04:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389610AbgJTJEb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 05:04:31 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 58830B7502192D6CB01D;
        Tue, 20 Oct 2020 17:04:30 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 20 Oct 2020 17:04:29 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Tue, 20
 Oct 2020 17:04:29 +0800
Subject: Re: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "Christoph Hellwig" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
 <20201020085301.1553959-4-ming.lei@redhat.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
Date:   Tue, 20 Oct 2020 17:04:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201020085301.1553959-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/10/20 16:53, Ming Lei wrote:
> During controller's CONNECTING state, admin/fabric/connect requests
> are submitted for recovery controller, and we allow to abort this request
> directly in time out handler for not blocking setup procedure.
> 
> So timout vs. normal completion race exists on these requests since
> admin/fabirc/connect queues won't be shutdown before handling timeout
> during CONNECTING state.
> 
> Add atomic completion for requests from connect/fabric/admin queue for
> avoiding the race.
> 
> CC: Chao Leng <lengchao@huawei.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d6a3e1487354..7e85bd4a8d1b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -30,6 +30,8 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +#define REQ_STATE_COMPLETE     0
> +
>   enum nvme_tcp_send_state {
>   	NVME_TCP_SEND_CMD_PDU = 0,
>   	NVME_TCP_SEND_H2C_PDU,
> @@ -56,6 +58,8 @@ struct nvme_tcp_request {
>   	size_t			offset;
>   	size_t			data_sent;
>   	enum nvme_tcp_send_state state;
> +
> +	unsigned long		comp_state;
I do not think adding state is a good idea.
It is similar to rq->state.
In the teardown process, after quiesced queues delete the timer and
cancel the timeout work maybe a better option.
I will send the patch later.
The patch is already tested with roce more than one week.
>   };
>   
>   enum nvme_tcp_queue_flags {
> @@ -469,6 +473,33 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
>   }
>   
> +/*
> + * requests originated from admin, fabrics and connect_q have to be
> + * completed atomically because we don't cover the race between timeout
> + * and normal completion for these queues.
> + */
> +static inline bool nvme_tcp_need_atomic_complete(struct request *rq)
> +{
> +	return !rq->rq_disk;
> +}
> +
> +static inline void nvme_tcp_clear_rq_complete(struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
> +		clear_bit(REQ_STATE_COMPLETE, &req->comp_state);
> +}
> +
> +static inline bool nvme_tcp_mark_rq_complete(struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
> +		return !test_and_set_bit(REQ_STATE_COMPLETE, &req->comp_state);
> +	return true;
> +}
> +
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> @@ -483,7 +514,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	if (nvme_tcp_mark_rq_complete(rq) &&
> +			!nvme_try_complete_req(rq, cqe->status, cqe->result))
>   		nvme_complete_rq(rq);
>   	queue->nr_cqe++;
>   
> @@ -674,7 +706,8 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
>   	union nvme_result res = {};
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> +	if (nvme_tcp_mark_rq_complete(rq) &&
> +			!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
>   		nvme_complete_rq(rq);
>   }
>   
> @@ -2174,7 +2207,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>   	/* fence other contexts that may complete the command */
>   	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
> -	if (!blk_mq_request_completed(rq)) {
> +	if (nvme_tcp_mark_rq_complete(rq) && !blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>   		blk_mq_complete_request(rq);
>   	}
> @@ -2315,6 +2348,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (unlikely(ret))
>   		return ret;
>   
> +	nvme_tcp_clear_rq_complete(rq);
>   	blk_mq_start_request(rq);
>   
>   	nvme_tcp_queue_request(req, true, bd->last);
> 
