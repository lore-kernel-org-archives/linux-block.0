Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C9C432BE
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5232B61058
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 13:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbhIBNYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:24:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19004 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbhIBNYK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Sep 2021 09:24:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H0hN02rV2zbl2R;
        Thu,  2 Sep 2021 21:19:12 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 21:23:08 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 21:23:08 +0800
Subject: Re: [PATCH v2 1/4] block, bfq: add support to track if root_group
 have any pending requests
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-2-yukuai3@huawei.com>
 <2968B663-F855-4C41-AE9B-E33787DA6AF9@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7ee856f6-ca13-67dc-d2db-d73ef31ffdd9@huawei.com>
Date:   Thu, 2 Sep 2021 21:23:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2968B663-F855-4C41-AE9B-E33787DA6AF9@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/27 1:00, Paolo Valente wrote:
> 
> 
>> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>
>> Add a new member in bfq_data to track number of queues that are in
>> root_group with any pending requests.
> 
> maybe modify the last part of the sentence as: ... and that have some pending request
> 
>> This will be used in next patch
>> to optmize queue idle judgment when root_group doesn't have any
>> pending requests.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> block/bfq-iosched.c |  8 +++++++-
>> block/bfq-iosched.h | 13 +++++++++++--
>> block/bfq-wf2q.c    | 37 ++++++++++++++++++++++++-------------
>> 3 files changed, 42 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 727955918563..7c6b412f9a9c 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -859,8 +859,14 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> 			     struct bfq_queue *bfqq)
>> {
>> -	struct bfq_entity *entity = bfqq->entity.parent;
>> +	struct bfq_entity *entity = &bfqq->entity;
>> +
>> +	if (entity->in_groups_with_pending_reqs) {
>> +		entity->in_groups_with_pending_reqs = false;
>> +		bfqd->num_queues_with_pending_reqs_in_root--;
> 
> Here you cross the comment "The decrement of
> num_groups_with_pending_reqs is not performed immediately upon ...".
> 
> Find a way to
> - move that comment up, and to make it correct for this slightly
>    different decrement
> - leave a correct comment (probably shorter) in the original position
> 
>> +	}
>>
>> +	entity = entity->parent;
>> 	for_each_entity(entity) {
>> 		struct bfq_sched_data *sd = entity->my_sched_data;
>>
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 99c2a3cb081e..610769214f72 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -195,7 +195,12 @@ struct bfq_entity {
>> 	/* flag, set to request a weight, ioprio or ioprio_class change  */
>> 	int prio_changed;
>>
>> -	/* flag, set if the entity is counted in groups_with_pending_reqs */
>> +	/*
>> +	 * If entity represents bfq_group, this flag will set
> 
> will be set?
> 
>> if the group is
>> +	 * not root_group and have
> 
> has
> 
>> any pending requests; If entity represents
> 
> one more nit: use lowercase after semicolon
> 
>> +	 * bfq_queue, this flag will set
> 
> will be set
> 
>> if the queue is in root_group and have
>> +	 * any pending requests.
>> +	 */
>> 	bool in_groups_with_pending_reqs;
>>
> 
> The name of the above field follows from the fact that entity is
> counted in groups_with_pending_reqs.  You change this fact, because,
> in your patch, a queue is not counted in groups_with_pending_reqs.
> But you leave the same name. This creates confusion.
> 
> 
>> 	/* last child queue of entity created (for non-leaf entities) */
>> @@ -539,7 +544,11 @@ struct bfq_data {
>> 	 * with no request waiting for completion.
>> 	 */
>> 	unsigned int num_groups_with_pending_reqs;
>> -
>> +	/*
>> +	 * number of queues that are in root_group with at least one request
>> +	 * waiting for completion.
> 
> please link somehow this comment to the long comment that comes before it
> 
>> +	 */
>> +	unsigned int num_queues_with_pending_reqs_in_root;
> 
> Why using two counters?  I mean, couldn't you simply count also the
> root group in num_groups_with_pending_reqs?

Hi, Paolo

Thanks for taking time reviewing these patches

I was doing this too complicated, while counting root group into
num_groups_with_pending_reqs is much easier. I'll do this in next
iteration.

Thanks
Yu Kuai

> 
>> 	/*
>> 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
>> 	 * requests (including the queue in service, even if it is
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 7a462df71f68..188c8f907219 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -946,6 +946,29 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
>> 	bfq_active_insert(st, entity);
>> }
>>
>> +static void bfq_update_groups_with_pending_reqs(struct bfq_entity *entity)
>> +{
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>> +	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
>> +
> 
> why do you introduce an extra variable bfqq, instead of doing as in
> the original version of the code?  In addition, you remove the comment
> /* bfq_group */
> 
> Thanks,
> Paolo
> 
>> +	if (bfqq) {
>> +		if (!entity->parent && !entity->in_groups_with_pending_reqs) {
>> +			entity->in_groups_with_pending_reqs = true;
>> +			bfqq->bfqd->num_queues_with_pending_reqs_in_root++;
>> +		}
>> +	} else {
>> +		if (!entity->in_groups_with_pending_reqs) {
>> +			struct bfq_group *bfqg =
>> +				container_of(entity, struct bfq_group, entity);
>> +			struct bfq_data *bfqd = bfqg->bfqd;
>> +
>> +			entity->in_groups_with_pending_reqs = true;
>> +			bfqd->num_groups_with_pending_reqs++;
>> +		}
>> +	}
>> +#endif
>> +}
>> +
>> /**
>>   * __bfq_activate_entity - handle activation of entity.
>>   * @entity: the entity being activated.
>> @@ -999,19 +1022,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>> 		entity->on_st_or_in_serv = true;
>> 	}
>>
>> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>> -		struct bfq_group *bfqg =
>> -			container_of(entity, struct bfq_group, entity);
>> -		struct bfq_data *bfqd = bfqg->bfqd;
>> -
>> -		if (!entity->in_groups_with_pending_reqs) {
>> -			entity->in_groups_with_pending_reqs = true;
>> -			bfqd->num_groups_with_pending_reqs++;
>> -		}
>> -	}
>> -#endif
>> -
>> +	bfq_update_groups_with_pending_reqs(entity);
>> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
>> }
>>
>> -- 
>> 2.31.1
>>
> 
> .
> 
