Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80710C4332F
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 01:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJMBhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 21:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJMBhn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 21:37:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895215E0D8
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 18:37:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MnsTx2NcrzQj77;
        Thu, 13 Oct 2022 09:33:09 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 09:37:36 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
 <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
 <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
 <f9fce880-4714-3cdb-dfd1-f1d77d033d7a@huawei.com>
 <a44292df-ce46-828a-91a6-aa7377aa23f7@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <1c39ae7c-7b70-851c-813e-50a97ec44c50@huawei.com>
Date:   Thu, 13 Oct 2022 09:37:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <a44292df-ce46-828a-91a6-aa7377aa23f7@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/12 19:13, Sagi Grimberg wrote:
> 
> 
> On 10/12/22 11:43, Chao Leng wrote:
>> Add Ming Lei.
>>
>> On 2022/10/12 14:37, Sagi Grimberg wrote:
>>>
>>>>> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>>>>>> But maybe we can avoid that, and because we allocate
>>>>>> the connect_q ourselves, and fully know that it should
>>>>>> not be apart of the tagset quiesce, perhaps we can introduce
>>>>>> a new interface like:
>>>>>> -- 
>>>>>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>>>>>> {
>>>>>>     ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>>>>>>     if (IS_ERR(ctrl->connect_q))
>>>>>>         return PTR_ERR(ctrl->connect_q);
>>>>>>     return 0;
>>>>>> }
>>>>>> -- 
>>>>>>
>>>>>> And then blk_mq_quiesce_tagset can simply look into a per request-queue
>>>>>> self_quiesce flag and skip as needed.
>>>>>
>>>>> I'd just make that a queue flag set after allocation to keep the
>>>>> interface simple, but otherwise this seems like the right thing
>>>>> to do.
>>>> Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
>>>> If we use blk_mq_quiesce_tagset, It will cause the above mechanism to fail.
>>>> I review the code, only pci can not ensure secure stop/start pairing.
>>>> So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, not PCI.
>>>> Do you think that's acceptable?
>>>> If that's acceptable, I will try to send a patch set.
>>>
>>> I don't think that this is acceptable. But I don't understand how
>>> NVME_NS_STOPPED would change anything in the behavior of tagset-wide
>>> quiesce?
>> If use blk_mq_quiesce_tagset, it will quiesce all queues of all ns,
>> but can not set NVME_NS_STOPPED of all ns. The mechanism of NVME_NS_STOPPED
>> will be invalidated.
>> NVMe-pci has very complicated quiesce/unquiesce use pattern, quiesce/unquiesce
>> may be called unpaired.
>> It will cause some backward. There may be some bugs in this scenario:
>> A thread: quiesce the queue
>> B thread: quiesce the queue
>> A thread end, and does not unquiesce the queue.
>> B thread: unquiesce the queue, and do something which need the queue must be unquiesed.
>>
>> Of course, I don't think it is a good choice to guarantee paired access through NVME_NS_STOPPED,
>> there exist unexpected unquiesce and start queue too early.
>> But now that the code has done so, the backward should be unacceptable.
>> such as this scenario:
>> A thread: quiesce the queue
>> B thread: want to quiesce the queue but do nothing because NVME_NS_STOPPED is already set.
>> A thread: unquiesce the queue
>> Now the queue is unquiesced too early for B thread.
>> B thread: do something which need the queue must be quiesced.
>>
>> Introduce NVME_NS_STOPPED link:
>> https://lore.kernel.org/all/20211014081710.1871747-5-ming.lei@redhat.com/
> 
> I think we can just change a ns flag to a controller flag ala:
> NVME_CTRL_STOPPED, and then do:
> 
> void nvme_stop_queues(struct nvme_ctrl *ctrl)
> {
>      if (!test_and_set_bit(NVME_CTRL_STOPPED, &ns->flags))
>          blk_mq_quiesce_tagset(ctrl->tagset);
> }
> EXPORT_SYMBOL_GPL(nvme_stop_queues);
> 
> void nvme_start_queues(struct nvme_ctrl *ctrl)
> {
>      if (test_and_clear_bit(NVME_CTRL_STOPPED, &ns->flags))
>          blk_mq_unquiesce_tagset(ctrl->tagset);
> }
> EXPORT_SYMBOL_GPL(nvme_start_queues);
> 
> Won't that achieve the same result?
No, nvme_set_queue_dying call nvme_start_ns_queue for one ns.
ctrl->flags can not cover this scenario.
This still results in unpaired quiesce/unquiesce.

Maybe it is necessary to clean up the confused quiesce/unquiesce of nvme-pci,
Thus blk_mq_quiesce_tagset can be easy to use for nvme-pci.
Before that, we could only optimize batched quiesce/unquiesce based on ns,
Although I also think using blk_mq_quiesce_tagset is a better choice.
