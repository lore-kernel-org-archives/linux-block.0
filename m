Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB36C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 10:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A164F5F
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 10:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCHKxI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 05:53:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2650 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCHKw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 05:52:57 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvFSM0Fy1z67wYf;
        Mon,  8 Mar 2021 18:48:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 11:52:55 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 10:52:54 +0000
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     Bart Van Assche <bvanassche@acm.org>, <hare@suse.de>,
        <ming.lei@redhat.com>, <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <52618092-07ca-ecb5-320f-957af26ab146@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3c6cbe11-ac31-9a47-0096-17fbd584b83e@huawei.com>
Date:   Mon, 8 Mar 2021 10:50:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <52618092-07ca-ecb5-320f-957af26ab146@acm.org>
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

On 06/03/2021 04:32, Bart Van Assche wrote:
> On 3/5/21 7:14 AM, John Garry wrote:
>> diff --git a/block/blk.h b/block/blk.h
>> index 3b53e44b967e..1a948bfd91e4 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -201,10 +201,29 @@ void elv_unregister_queue(struct request_queue *q);
>>   static inline void elevator_exit(struct request_queue *q,
>>   		struct elevator_queue *e)
>>   {
>> +	struct blk_mq_tag_set *set = q->tag_set;
>> +	struct request_queue *tmp;
>> +
>>   	lockdep_assert_held(&q->sysfs_lock);
>>   
>> +	mutex_lock(&set->tag_list_lock);
>> +	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
>> +		if (tmp == q)
>> +			continue;
>> +		blk_mq_freeze_queue(tmp);
>> +		blk_mq_quiesce_queue(tmp);
>> +	}
>> +
>>   	blk_mq_sched_free_requests(q);
>>   	__elevator_exit(q, e);
>> +
>> +	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
>> +		if (tmp == q)
>> +			continue;
>> +		blk_mq_unquiesce_queue(tmp);
>> +		blk_mq_unfreeze_queue(tmp);
>> +	}
>> +	mutex_unlock(&set->tag_list_lock);
>>   }

Hi Bart,

> This patch introduces nesting of tag_list_lock inside sysfs_lock. The
> latter is per request queue while the former can be shared across
> multiple request queues. Has it been analyzed whether this is safe?

Firstly - ignoring implementation details for a moment - this patch is 
to ensure that the concept is consistent with your suggestion and 
whether it is sound.

As for nested locking, I can analyze more, but I did assume that we 
don't care about locking-out sysfs intervention during this time. And it 
seems pretty difficult to avoid nesting the locks.

And further to this, I see that 
https://lore.kernel.org/linux-block/3aa5407c-0800-2482-597b-4264781a7eac@grimberg.me/T/#mc3e3175642660578c0ae2a6c32185b1e34ec4b8a 
has a new interface for tagset quiesce, which could make this process 
more efficient.

Please let me know further thoughts.

Thanks,
John
