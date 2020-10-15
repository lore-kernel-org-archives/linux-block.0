Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528DC433E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 10:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AADE22249
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 10:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgJOKcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:32:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3575 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbgJOKcS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 06:32:18 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id B5F85C92A0A351A510C8;
        Thu, 15 Oct 2020 18:05:53 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 15 Oct 2020 18:05:53 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 15
 Oct 2020 18:05:52 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
References: <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590> <20201014033434.GC775684@T590>
 <f5870b91-28c5-ea99-59df-cdcc8c482011@huawei.com>
 <20201014095642.GE775684@T590>
 <c9cf7168-d8ce-276f-de01-739199ed4258@huawei.com>
 <20201015075020.GA1099950@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <c8cb03f2-0dce-3c67-7700-526f26111a7e@huawei.com>
Date:   Thu, 15 Oct 2020 18:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201015075020.GA1099950@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/10/15 15:50, Ming Lei wrote:
> On Thu, Oct 15, 2020 at 02:05:01PM +0800, Chao Leng wrote:
>>
>>
>> On 2020/10/14 17:56, Ming Lei wrote:
>>> On Wed, Oct 14, 2020 at 05:39:12PM +0800, Chao Leng wrote:
>>>>
>>>>
>>>> On 2020/10/14 11:34, Ming Lei wrote:
>>>>> On Wed, Oct 14, 2020 at 09:08:28AM +0800, Ming Lei wrote:
>>>>>> On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
>>>>>>>
>>>>>>>>>> This may just reduce the probability. The concurrency of timeout
>>>>>>>>>> and teardown will cause the same request
>>>>>>>>>> be treated repeatly, this is not we expected.
>>>>>>>>>
>>>>>>>>> That is right, not like SCSI, NVME doesn't apply atomic request
>>>>>>>>> completion, so
>>>>>>>>> request may be completed/freed from both timeout & nvme_cancel_request().
>>>>>>>>>
>>>>>>>>> .teardown_lock still may cover the race with Sagi's patch because
>>>>>>>>> teardown
>>>>>>>>> actually cancels requests in sync style.
>>>>>>>> In extreme scenarios, the request may be already retry success(rq state
>>>>>>>> change to inflight).
>>>>>>>> Timeout processing may wrongly stop the queue and abort the request.
>>>>>>>> teardown_lock serialize the process of timeout and teardown, but do not
>>>>>>>> avoid the race.
>>>>>>>> It might not be safe.
>>>>>>>
>>>>>>> Not sure I understand the scenario you are describing.
>>>>>>>
>>>>>>> what do you mean by "In extreme scenarios, the request may be already retry
>>>>>>> success(rq state change to inflight)"?
>>>>>>>
>>>>>>> What will retry the request? only when the host will reconnect
>>>>>>> the request will be retried.
>>>>>>>
>>>>>>> We can call nvme_sync_queues in the last part of the teardown, but
>>>>>>> I still don't understand the race here.
>>>>>>
>>>>>> Not like SCSI, NVME doesn't complete request atomically, so double
>>>>>> completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
>>>>>>
>>>>>> Given request is completed remotely or asynchronously in the two code paths,
>>>>>> the teardown_lock can't protect the case.
>>>>>
>>>>> Thinking of the issue further, the race shouldn't be between timeout and
>>>>> teardown.
>>>>>
>>>>> Both nvme_cancel_request() and nvme_tcp_complete_timed_out() are called
>>>>> with .teardown_lock, and both check if the request is completed before
>>>>> calling blk_mq_complete_request() which marks the request as COMPLETE state.
>>>>> So the request shouldn't be double-freed in the two code paths.
>>>>>
>>>>> Another possible reason is that between timeout and normal completion(fail
>>>>> fast pending requests after ctrl state is updated to CONNECTING).
>>>>>
>>>>> Yi, can you try the following patch and see if the issue is fixed?
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index d6a3e1487354..fab9220196bd 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -1886,7 +1886,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>>>>>     static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>>>>>     		bool remove)
>>>>>     {
>>>>> -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>>     	blk_mq_quiesce_queue(ctrl->admin_q);
>>>>>     	nvme_tcp_stop_queue(ctrl, 0);
>>>>>     	if (ctrl->admin_tagset) {
>>>>> @@ -1897,15 +1896,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>>>>>     	if (remove)
>>>>>     		blk_mq_unquiesce_queue(ctrl->admin_q);
>>>>>     	nvme_tcp_destroy_admin_queue(ctrl, remove);
>>>>> -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>>     }
>>>>>     static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>>>>>     		bool remove)
>>>>>     {
>>>>> -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>>     	if (ctrl->queue_count <= 1)
>>>>> -		goto out;
>>>>> +		return;
>>>>>     	blk_mq_quiesce_queue(ctrl->admin_q);
>>>>>     	nvme_start_freeze(ctrl);
>>>>>     	nvme_stop_queues(ctrl);
>>>>> @@ -1918,8 +1915,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>>>>>     	if (remove)
>>>>>     		nvme_start_queues(ctrl);
>>>>>     	nvme_tcp_destroy_io_queues(ctrl, remove);
>>>>> -out:
>>>>> -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>>     }
>>>>>     static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>>> @@ -2030,11 +2025,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>>>>>     	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>>>>     	nvme_stop_keep_alive(ctrl);
>>>>> +
>>>>> +	mutex_lock(&tcp_ctrl->teardown_lock);
>>>>>     	nvme_tcp_teardown_io_queues(ctrl, false);
>>>>> -	/* unquiesce to fail fast pending requests */
>>>>> -	nvme_start_queues(ctrl);
>>>>>     	nvme_tcp_teardown_admin_queue(ctrl, false);
>>>>> -	blk_mq_unquiesce_queue(ctrl->admin_q);
>>>> Delete blk_mq_unquiesce_queue will cause a bug which may cause reconnect failed.
>>>> Delete nvme_start_queues may cause another bug.
>>>
>>> nvme_tcp_setup_ctrl() will re-start io and admin queue, and only .connect_q
>>> and .fabrics_q are required during reconnect.I check the code. Unquiesce the admin queue in nvme_tcp_configure_admin_queue, so reconnect can work well.
>>>
>>> So can you explain in detail about the bug?
>> First if reconnect failed, quiesce the io queue and admin queue will cause IO pause long time.
> 
> Any normal IO can't make progress until reconnect is successful, so this
> change won't increase IO pause. This way is exactly what NVMe PCI takes,
> see nvme_start_queues() called from nvme_reset_work().
now is ok. Now the patch which fix the long pause time is discussing.
> 
>> Second if reconnect failed more than max_reconnects, delete ctrl will hang.
> 
> No, delete ctrl won't hang, because 'shutdown' parameter is true in case
> of deleting ctrl, which will unquiesce both admin_q and io queues in
> nvme_tcp_teardown_io_queues() and nvme_tcp_teardown_admin_queue().
No, now nvme_remove_namespaces is before tear down queues.
tear down queues is in ctrl->ops->delete_ctrl.
static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
{
	dev_info(ctrl->device,
		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);

	flush_work(&ctrl->reset_work);
	nvme_stop_ctrl(ctrl);
	nvme_remove_namespaces(ctrl);
	ctrl->ops->delete_ctrl(ctrl);
	nvme_uninit_ctrl(ctrl);
}
> 
> 
> Thanks,
> Ming
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> .
> 
