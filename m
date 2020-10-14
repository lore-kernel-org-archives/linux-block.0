Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EDFC433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 01:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC24221FC
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 01:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgJNBhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 21:37:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730048AbgJNBhL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 21:37:11 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 53F903CFC23933453BDA;
        Wed, 14 Oct 2020 09:37:09 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 09:37:09 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 14
 Oct 2020 09:37:08 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
CC:     Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <a1221820-55db-e550-0a9c-684ab96608e3@huawei.com>
Date:   Wed, 14 Oct 2020 09:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201014010813.GA775684@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rdma also need do this patch.
We do test this patch with nvme over roce a few days, now work well.

On 2020/10/14 9:08, Ming Lei wrote:
> On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
>>
>>>>> This may just reduce the probability. The concurrency of timeout
>>>>> and teardown will cause the same request
>>>>> be treated repeatly, this is not we expected.
>>>>
>>>> That is right, not like SCSI, NVME doesn't apply atomic request
>>>> completion, so
>>>> request may be completed/freed from both timeout & nvme_cancel_request().
>>>>
>>>> .teardown_lock still may cover the race with Sagi's patch because
>>>> teardown
>>>> actually cancels requests in sync style.
>>> In extreme scenarios, the request may be already retry success(rq state
>>> change to inflight).
>>> Timeout processing may wrongly stop the queue and abort the request.
>>> teardown_lock serialize the process of timeout and teardown, but do not
>>> avoid the race.
>>> It might not be safe.
>>
>> Not sure I understand the scenario you are describing.
>>
>> what do you mean by "In extreme scenarios, the request may be already retry
>> success(rq state change to inflight)"?
>>
>> What will retry the request? only when the host will reconnect
>> the request will be retried.
>>
>> We can call nvme_sync_queues in the last part of the teardown, but
>> I still don't understand the race here.
> 
> Not like SCSI, NVME doesn't complete request atomically, so double
> completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> 
> Given request is completed remotely or asynchronously in the two code paths,
> the teardown_lock can't protect the case.
> 
> One solution is to apply the introduced blk_mq_complete_request_sync()
> in both two code paths.
> 
> Another candidate is to use nvme_sync_queues() before teardown, such as
> the following change:
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d6a3e1487354..dc3561ca0074 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1909,6 +1909,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	blk_mq_quiesce_queue(ctrl->admin_q);
>   	nvme_start_freeze(ctrl);
>   	nvme_stop_queues(ctrl);
> +	nvme_sync_queues(ctrl);
nvme_sync_queues now sync io queues and admin queues, so we may need like this:
nvme_sync_io_queues(struct nvme_ctrl *ctrl)
{
	down_read(&ctrl->namespaces_rwsem);
	list_for_each_entry(ns, &ctrl->namespaces, list)
		blk_sync_queue(ns->queue);
	up_read(&ctrl->namespaces_rwsem);
}
EXPORT_SYMBOL_GPL(nvme_sync_io_queues);

void nvme_sync_queues(struct nvme_ctrl *ctrl)
{
	struct nvme_ns *ns;

     nvme_sync_io_queues(ctrl);

	if (ctrl->admin_q)
		blk_sync_queue(ctrl->admin_q);
}
EXPORT_SYMBOL_GPL(nvme_sync_queues);
>   	nvme_tcp_stop_io_queues(ctrl);
>   	if (ctrl->tagset) {
>   		blk_mq_tagset_busy_iter(ctrl->tagset,
> @@ -2171,14 +2172,11 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
>   
> -	/* fence other contexts that may complete the command */
> -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>   	if (!blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>   		blk_mq_complete_request(rq);
>   	}
> -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
>   }
>   
>   static enum blk_eh_timer_return
> 
> 
> Thanks,
> Ming
> 
> .
> 
