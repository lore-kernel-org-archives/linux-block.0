Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E92C433E7
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 09:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFCB214D8
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 09:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgJLJG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 05:06:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgJLJG1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 05:06:27 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 6704141541879497BE93;
        Mon, 12 Oct 2020 17:06:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 12 Oct 2020 17:06:24 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 12
 Oct 2020 17:06:24 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Ming Lei <ming.lei@redhat.com>
CC:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        "Jens Axboe" <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
Date:   Mon, 12 Oct 2020 17:06:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201012081306.GB556731@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/10/12 16:13, Ming Lei wrote:
> On Mon, Oct 12, 2020 at 11:59:21AM +0800, Chao Leng wrote:
>>
>>
>> On 2020/10/10 14:08, Yi Zhang wrote:
>>>
>>>
>>> On 10/10/20 2:29 AM, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 10/9/20 6:55 AM, Yi Zhang wrote:
>>>>> Hi Sagi
>>>>>
>>>>> On 10/9/20 4:09 PM, Sagi Grimberg wrote:
>>>>>>> Hi Sagi
>>>>>>>
>>>>>>> I applied this patch on block origin/for-next and still can reproduce it.
>>>>>>
>>>>>> That's unexpected, can you try this patch?
>>>>>> -- 
>>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>>> index 629b025685d1..46428ff0b0fc 100644
>>>>>> --- a/drivers/nvme/host/tcp.c
>>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>>> @@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>>>>>>          /* fence other contexts that may complete the command */
>>>>>>          mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>>>>>>          nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>>>>> -       if (!blk_mq_request_completed(rq)) {
>>>>>> +       if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>>>>>>                  nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>>>>>>                  blk_mq_complete_request_sync(rq);
>>>>>>          }
>> This may just reduce the probability. The concurrency of timeout and teardown will cause the same request
>> be treated repeatly, this is not we expected.
> 
> That is right, not like SCSI, NVME doesn't apply atomic request completion, so
> request may be completed/freed from both timeout & nvme_cancel_request().
> 
> .teardown_lock still may cover the race with Sagi's patch because teardown
> actually cancels requests in sync style.
In extreme scenarios, the request may be already retry success(rq state change to inflight).
Timeout processing may wrongly stop the queue and abort the request.
teardown_lock serialize the process of timeout and teardown, but do not avoid the race.
It might not be safe.
> 
>> In the teardown process, after quiesced queues delete the timer and cancel the timeout work maybe a better option.
> 
> Seems better solution, given it is aligned with NVME PCI's reset
> handling. nvme_sync_queues() may be called in nvme_tcp_teardown_io_queues() to
> avoid this race.
> 
> 
> Thanks,
> Ming
> 
> .
> 
