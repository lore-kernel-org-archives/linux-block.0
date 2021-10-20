Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E3C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 09:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1245661359
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTJWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 05:22:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25173 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 05:22:48 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HZ4mQ34zDz1DHl0;
        Wed, 20 Oct 2021 17:18:46 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 17:20:32 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 20 Oct 2021 17:20:32 +0800
Subject: Re: [PATCH v4 1/2] block, bfq: counted root group into
 'num_groups_with_pending_reqs'
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211014014556.3597008-1-yukuai3@huawei.com>
 <20211014014556.3597008-2-yukuai3@huawei.com>
 <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <1f89cece-a123-6190-bb72-d59035dac266@huawei.com>
Date:   Wed, 20 Oct 2021 17:20:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/20 16:51, Paolo Valente wrote:

>> @@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> 			     struct bfq_queue *bfqq)
>> {
>> 	struct bfq_entity *entity = bfqq->entity.parent;
>> +	struct bfq_sched_data *sd;
>> +
>> +	/*
>> +	 * If the bfq queue is in root group, the decrement of
>> +	 * num_groups_with_pending_reqs is performed immediately upon the
>> +	 * deactivation of entity.
>> +	 */
>> +	if (!entity) {
>> +		entity = &bfqd->root_group->entity;
>> +		sd = entity->my_sched_data;
>> +
>> +		if (!sd->in_service_entity)
>> +			bfq_clear_group_with_pending_reqs(bfqd, entity);
>> +
>> +		return;
>> +	}
>>
>> 	for_each_entity(entity) {
>> -		struct bfq_sched_data *sd = entity->my_sched_data;
>> +		sd = entity->my_sched_data;
>>
>> 		if (sd->next_in_service || sd->in_service_entity) {
>> 			/*
>> @@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> 		}
>>
>> 		/*
>> -		 * The decrement of num_groups_with_pending_reqs is
>> +		 * If the bfq queue is not in root group,
>> +		 * the decrement of num_groups_with_pending_reqs is
> 
> 
> I'm sorry if I didn't notice this before, but why do you postpone the
> decrement only for queues not in root group?  If I'm not missing
> anything, the active (i.e., with pending reqs) state of the root group
> is to be computed as that of ay other group.

Hi, Paolo

I thought if queue is in root group, then bfqq->entity.parent is NULL,
and such case is handled above, which is separate from previous
implementation for queues that are not in root group.

Is this the wrong way to handle root group?

Thanks,
Kuai
