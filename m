Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABB6610FF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 11:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTL4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:56:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13958 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTL4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 07:56:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZ89H2ttlzZcLW;
        Wed, 20 Oct 2021 19:52:03 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 19:53:50 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 20 Oct 2021 19:53:49 +0800
Subject: Re: [PATCH v4 1/2] block, bfq: counted root group into
 'num_groups_with_pending_reqs'
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211014014556.3597008-1-yukuai3@huawei.com>
 <20211014014556.3597008-2-yukuai3@huawei.com>
 <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
 <1f89cece-a123-6190-bb72-d59035dac266@huawei.com>
 <2E8712BB-5BFB-4647-AE9A-B06E199500D7@linaro.org>
 <8912e5ca-67bb-4a9a-a2ce-ba13e0fc86ed@huawei.com>
 <AA986626-D3BF-43F3-81C2-FD7AA3C1ACD2@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c61ea2d2-91e7-249b-ac1c-e6e2240f88ae@huawei.com>
Date:   Wed, 20 Oct 2021 19:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AA986626-D3BF-43F3-81C2-FD7AA3C1ACD2@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/20 17:43, Paolo Valente wrote:
> 
> 
>> Il giorno 20 ott 2021, alle ore 11:38, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>
>> On 2021/10/20 17:29, Paolo Valente wrote:
>>>> Il giorno 20 ott 2021, alle ore 11:20, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>>>
>>>> On 2021/10/20 16:51, Paolo Valente wrote:
>>>>
>>>>>> @@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>>>> 			     struct bfq_queue *bfqq)
>>>>>> {
>>>>>> 	struct bfq_entity *entity = bfqq->entity.parent;
>>>>>> +	struct bfq_sched_data *sd;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * If the bfq queue is in root group, the decrement of
>>>>>> +	 * num_groups_with_pending_reqs is performed immediately upon the
>>>>>> +	 * deactivation of entity.
>>>>>> +	 */
>>>>>> +	if (!entity) {
>>>>>> +		entity = &bfqd->root_group->entity;
>>>>>> +		sd = entity->my_sched_data;
>>>>>> +
>>>>>> +		if (!sd->in_service_entity)
>>>>>> +			bfq_clear_group_with_pending_reqs(bfqd, entity);
>>>>>> +
>>>>>> +		return;
>>>>>> +	}
>>>>>>
>>>>>> 	for_each_entity(entity) {
>>>>>> -		struct bfq_sched_data *sd = entity->my_sched_data;
>>>>>> +		sd = entity->my_sched_data;
>>>>>>
>>>>>> 		if (sd->next_in_service || sd->in_service_entity) {
>>>>>> 			/*
>>>>>> @@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>>>> 		}
>>>>>>
>>>>>> 		/*
>>>>>> -		 * The decrement of num_groups_with_pending_reqs is
>>>>>> +		 * If the bfq queue is not in root group,
>>>>>> +		 * the decrement of num_groups_with_pending_reqs is
>>>>> I'm sorry if I didn't notice this before, but why do you postpone the
>>>>> decrement only for queues not in root group?  If I'm not missing
>>>>> anything, the active (i.e., with pending reqs) state of the root group
>>>>> is to be computed as that of ay other group.
>>>>
>>>> Hi, Paolo
>>>>
>>>> I thought if queue is in root group, then bfqq->entity.parent is NULL,
>>>> and such case is handled above, which is separate from previous
>>>> implementation for queues that are not in root group.
>>>>
>>>> Is this the wrong way to handle root group?
>>>>
>>> I think that, if we want to count also the root group among the active
>>> ones, then the logic for tagging the root group as active must be the
>>> same as the other groups. Or am I missing something?
>>
>> Hi, Paolo
>>
>> Currently, if queue is in root group, bfqq->entity.parent is NULL, and
>> this makes it hard to keep the same logic.
>>
>> Can we store root_group->my_entity to bfqq->entity.parent if the queue
>> is in root group?
>>
> 
> Any sensible implementation is ok for me.  Usually, stuff for root
> group is in the bfqd.
> 

I'll try to do implement that way,

Thanks,
Kuai

> Thanks,
> Paolo
> 
>> Thanks,
>> Kuai
> 
> .
> 
