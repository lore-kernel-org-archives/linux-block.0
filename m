Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF8C388F7
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D53B22453
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411185AbgJUCUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 22:20:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411184AbgJUCUO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 22:20:14 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B37FE93A2F2A815C363A;
        Wed, 21 Oct 2020 10:20:12 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 21 Oct 2020 10:20:12 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 21
 Oct 2020 10:20:11 +0800
Subject: Re: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
 <20201020085301.1553959-4-ming.lei@redhat.com>
 <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
 <20201021012241.GC1571548@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <7a3cdbdb-8e57-484c-fcb3-e8e72dfe8d13@huawei.com>
Date:   Wed, 21 Oct 2020 10:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201021012241.GC1571548@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/10/21 9:22, Ming Lei wrote:
> On Tue, Oct 20, 2020 at 05:04:29PM +0800, Chao Leng wrote:
>>
>>
>> On 2020/10/20 16:53, Ming Lei wrote:
>>> During controller's CONNECTING state, admin/fabric/connect requests
>>> are submitted for recovery controller, and we allow to abort this request
>>> directly in time out handler for not blocking setup procedure.
>>>
>>> So timout vs. normal completion race exists on these requests since
>>> admin/fabirc/connect queues won't be shutdown before handling timeout
>>> during CONNECTING state.
>>>
>>> Add atomic completion for requests from connect/fabric/admin queue for
>>> avoiding the race.
>>>
>>> CC: Chao Leng <lengchao@huawei.com>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index d6a3e1487354..7e85bd4a8d1b 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -30,6 +30,8 @@ static int so_priority;
>>>    module_param(so_priority, int, 0644);
>>>    MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>>> +#define REQ_STATE_COMPLETE     0
>>> +
>>>    enum nvme_tcp_send_state {
>>>    	NVME_TCP_SEND_CMD_PDU = 0,
>>>    	NVME_TCP_SEND_H2C_PDU,
>>> @@ -56,6 +58,8 @@ struct nvme_tcp_request {
>>>    	size_t			offset;
>>>    	size_t			data_sent;
>>>    	enum nvme_tcp_send_state state;
>>> +
>>> +	unsigned long		comp_state;
>> I do not think adding state is a good idea.
>> It is similar to rq->state.
>> In the teardown process, after quiesced queues delete the timer and
>> cancel the timeout work maybe a better option.
>> I will send the patch later.
>> The patch is already tested with roce more than one week.
> 
> Actually there isn't race between timeout and teardown, and patch 1 and patch
> 2 are enough to fix the issue reported by Yi.
> 
> It is just that rq->state is updated to IDLE in its. complete(), so
> either one of code paths may think that this rq isn't completed, and
> patch 2 has addressed this issue.
> 
> In short, teardown lock is enough to cover the race.
The race may cause abnormals:
1. Reported by Yi Zhang <yi.zhang@redhat.com>
detail: https://lore.kernel.org/linux-nvme/1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com/
2. BUG_ON in blk_mq_requeue_request
Because error recovery and time out may repeated completion request.
First error recovery cancel request in tear down process, the request
will be retried in completion, rq->state will be changed to IDEL.
And then time out will complete the request again, and samely retry
the request, BUG_ON will happen in blk_mq_requeue_request.
3. abnormal link disconnection
Firt error recovery cancel all request, reconnect success, the request
will be restarted. And then time out will complete the request again,
the queue will be stoped in nvme_rdma(tcp)_complete_timed_out,
Abnormal link diconnection will happen. The condition(time out process
is delayed long time by some reason such as hardware interrupt) is need.
So the probability is low.

teardown_lock just serialize the race. and add checkint the rq->state can avoid
the 1 and 2 scenario, but 3 scenario can not be fixed.
> 
> 
> Thanks,
> Ming
> 
> .
> 
