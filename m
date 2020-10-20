Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D63C433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C338B222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgJTIPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:15:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgJTIPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:15:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so993377wro.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 01:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JICnmpgJqEyWxnJUxHlU/3GJOgOwF6R6VyauLHmmydI=;
        b=gZ7/VItSMHBOT+k5Y/F8wKKcSWJDZrsALupgiUgKK8pUF7QA5BWuD7oOYh2TDCx+or
         TRlEaytFp5ftgdMqDDtoRJpJM9KrSDOQgGK80XXciSC41x59TSfqbwwooBSLXB7QBF7H
         je8VMTWRy2ZuzrRV7Iv4wJnk0ZX+NoIbmCfCcsESGno9JG0GnVj77rYS9JvmdU9F29t4
         fsQ3JALHIQUgXpdCShTXzy2jFKEy1Hm6aA7ZZwcm/4FNkXsibsjgA2GGXdYYdndXN+4E
         T2PuU3VIKN8KUWkhuw7f85lbSLLSKpw7dkq6YzkaPAYNC9kgZc+5H8LOH9KWGqckqeSQ
         tTlA==
X-Gm-Message-State: AOAM532jLo+Xr3AvVSSmE5o8XBnxYIni9X8kzDkFeCh0+k+OeinpxH1z
        jyAy6ERLDgld+WLCRftas1I=
X-Google-Smtp-Source: ABdhPJyy0gjEXQHtBQIRwv+UBiM50spMkkmt05u1TTdrEwJ573UPitbqj/kIxQgGeVSAwhrCJDTLhg==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr1938653wro.381.1603181703320;
        Tue, 20 Oct 2020 01:15:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:104e:47d9:f0fe:a697? ([2601:647:4802:9070:104e:47d9:f0fe:a697])
        by smtp.gmail.com with ESMTPSA id m14sm1735292wro.43.2020.10.20.01.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 01:15:02 -0700 (PDT)
Subject: Re: [PATCH 4/4] nvme: tcp: complete non-IO requests atomically
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Chao Leng <lengchao@huawei.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-5-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a63d842-a1d3-6452-9961-f22c212bf545@grimberg.me>
Date:   Tue, 20 Oct 2020 01:14:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016142811.1262214-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> During controller's CONNECTING state, admin/fabric/connect requests
> are submitted for recovery, and we allow to abort this request directly
> in time out handler for not blocking the setup step.
> 
> So timout vs. normal completion race may be triggered on these requests.
> 
> Add atomic completion for requests from connect/fabric/admin queue for
> avoiding the race.

I don't understand why this is needed... I don't understand the race,
and I don't understand why fencing the queue with nvme_tcp_stop_queue
and serialization against the teardown flow is not sufficient.

> 
> CC: Chao Leng <lengchao@huawei.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 56ac61a90c1b..654061abdc5a 100644
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
> @@ -2173,7 +2206,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
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
