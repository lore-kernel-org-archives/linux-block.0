Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE0C433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDFF20759
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 03:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG1DxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:53:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8835 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbgG1DxR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 23:53:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 561636516745AEDC90FA;
        Tue, 28 Jul 2020 11:51:53 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 11:51:51 +0800
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
 <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
 <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
 <92b821a6-a774-d85b-2711-418d36fc10d0@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <0e40714a-e1aa-163e-0d8e-db1ea439faad@huawei.com>
Date:   Tue, 28 Jul 2020 11:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <92b821a6-a774-d85b-2711-418d36fc10d0@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/7/28 11:34, Sagi Grimberg wrote:
> 
>>>> All controller namespaces share the same tagset, so we
>>>> can use this interface which does the optimal operation
>>>> for parallel quiesce based on the tagset type (e.g.
>>>> blocking tagsets and non-blocking tagsets).
>>>>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>   drivers/nvme/host/core.c | 14 ++------------
>>>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 05aa568a60af..c41df20996d7 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>>>>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>>>>   {
>>>> -    struct nvme_ns *ns;
>>>> -
>>>> -    down_read(&ctrl->namespaces_rwsem);
>>>> -    list_for_each_entry(ns, &ctrl->namespaces, list)
>>>> -        blk_mq_quiesce_queue(ns->queue);
>>>> -    up_read(&ctrl->namespaces_rwsem);
>>>> +    blk_mq_quiesce_tagset(ctrl->tagset);
>>>
>>> Rrr.. this one is slightly annoying. We have the connect_q in
>>> fabrics that we use to issue the connect command which is now
>>> quiesced too...
>>>
>>> If we will use this interface, we can unquiesce it right away,
>>> but that seems kinda backwards..Io queue and admin queue has different treat mechanism, introduce
>> blk_mq_quiesce_tagset may make the mechanism unclear. So this is
>> probably not a good choice.
> 
> The meaning of blk_mq_quiesce_tagset is clear, the awkward thing is
> that we need to unquiesce the connect_q after blk_mq_quiesce_tagset
> quiesced it.
Io queue and admin queue has different treat mechanism. If we switch to
blk_mq_quiesce_tagset, maybe we need do more extras such as unquiesce
the connect_q, thus the mechanism maybe unclear. Surely if we introduce
blk_mq_quiesce_tagset for new feature, the abstraction is great.
> 
> I'm thinking of resorting from this abstraction...
> .
