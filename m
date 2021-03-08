Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D44EC433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B094E651D1
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 11:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCHLTh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:19:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2651 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhCHLTf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 06:19:35 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvG1C3wN4z67whm;
        Mon,  8 Mar 2021 19:13:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 8 Mar 2021 12:19:28 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 11:19:28 +0000
Subject: Re: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting
 elevator
To:     Bart Van Assche <bvanassche@acm.org>, <hare@suse.de>,
        <ming.lei@redhat.com>, <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-4-git-send-email-john.garry@huawei.com>
 <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
Date:   Mon, 8 Mar 2021 11:17:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/03/2021 04:43, Bart Van Assche wrote:
> On 3/5/21 7:14 AM, John Garry wrote:
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 7ff1b20d58e7..5950fee490e8 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -358,11 +358,16 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>   {
>>   	int i;
>>   
>> +	if (!atomic_inc_not_zero(&tagset->iter_usage_counter))
>> +		return;
>> +
>>   	for (i = 0; i < tagset->nr_hw_queues; i++) {
>>   		if (tagset->tags && tagset->tags[i])
>>   			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>>   					      BT_TAG_ITER_STARTED);
>>   	}
>> +
>> +	atomic_dec(&tagset->iter_usage_counter);
>>   }
>>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);

Hi Bart,

> This changes the behavior of blk_mq_tagset_busy_iter(). What will e.g.
> happen if the mtip driver calls blk_mq_tagset_busy_iter(&dd->tags,
> mtip_abort_cmd, dd) concurrently with another blk_mq_tagset_busy_iter()
> call and if that causes all mtip_abort_cmd() calls to be skipped?

I'm not sure that I understand this problem you describe. So if 
blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd) is called, either 
can happen:
a. normal operation, iter_usage_counter initially holds >= 1, and then 
iter_usage_counter is incremented in blk_mq_tagset_busy_iter() and we 
iter the busy tags. Any parallel call to blk_mq_tagset_busy_iter() will 
also increase iter_usage_counter.
b. we're switching IO scheduler. In this scenario, first we quiesce all 
queues. After that, there should be no active requests. At that point, 
we ensure any calls to blk_mq_tagset_busy_iter() are finished and block 
(or discard may be a better term) any more calls. Blocking any more 
calls should be safe as there are no requests to iter. atomic_cmpxchg() 
is used to set iter_usage_counter to 0, blocking any more calls.

> 
>> +	while (atomic_cmpxchg(&set->iter_usage_counter, 1, 0) != 1);
> Isn't it recommended to call cpu_relax() inside busy-waiting loops?

Maybe, but I am considering changing this patch to use percpu_refcnt() - 
I need to check it further.

> 
>>   	blk_mq_sched_free_requests(q);
>>   	__elevator_exit(q, e);
>>   
>> +	atomic_set(&set->iter_usage_counter, 1);
> Can it happen that the above atomic_set() call happens while a
> blk_mq_tagset_busy_iter() call is in progress?

No, as at this point it should be ensured that iter_usage_counter holds 
0 from atomic_cmpxchg(), so there should be no active processes in 
blk_mq_tagset_busy_iter() sensitive region. Calls to 
blk_mq_tagset_busy_iter() are blocked when iter_usage_counter holds 0.

> Should that atomic_set()
> call perhaps be changed into an atomic_inc() call?

They have the same affect in practice, but we use atomic_set() in 
blk_mq_alloc_tag_set(), so at least consistent.

Thanks,
John
