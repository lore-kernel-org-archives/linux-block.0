Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC3C4332D
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 11:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2931223C8
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 11:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgLWLME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:12:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2281 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgLWLME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 06:12:04 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D19Rf6LJdz67QNY;
        Wed, 23 Dec 2020 19:08:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 23 Dec 2020 12:11:21 +0100
Received: from [10.47.6.156] (10.47.6.156) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 23 Dec
 2020 11:11:20 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <kashyap.desai@broadcom.com>, <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
 <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7bdd562d-b258-43a2-0de0-966091086cff@huawei.com>
Date:   Wed, 23 Dec 2020 11:10:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.6.156]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/12/2020 16:16, Bart Van Assche wrote:
> On 12/22/20 3:15 AM, John Garry wrote:
>> So then we could have something like this:
>>
>> ---8<---
>>
>>   -435,9 +444,13 @@ void blk_mq_queue_tag_busy_iter(struct 
>> request_queue *q, busy_iter_fn *fn,
>>      if (!blk_mq_hw_queue_mapped(hctx))
>>              continue;
>>
>> +    while (!atomic_inc_not_zero(&tags->iter_usage_counter));
>> +
>>      if (tags->nr_reserved_tags)
>>          bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
>>      bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
>>
>> +    atomic_dec(&tags->iter_usage_counter);
>> }
>>
>> blk_queue_exit(q);
>>
>> --->8---
>>
>> And similar for blk_mq_tagset_busy_iter(). How about it?
> 

Hi Bart,

> Are there any blk_mq_tagset_busy_iter() calls that happen from a context 
> where the tag set can disappear while that function is in progress?
> 

So isn't the blk_mq_tag_set always a member of the host driver data for 
those cases, and, since blk_mq_tagset_busy_iter() is for iter'ing block 
driver tags and called from block driver or hctx_busy_show(), it would 
exist for the lifetime of the host device.

> Some blk_mq_tagset_busy_iter() calls happen from a context where it is 
> not allowed to sleep but also where it is guaranteed that the tag set 
> won't disappear, e.g. the call from inside sdk_mq_queue_rq().

You're talking about skd_mq_queue_rq() -> skd_in_flight() -> 
blk_mq_tagset_busy_iter(), right?

So I would expect any .queue_rq calls to complete before the associated 
request queue and tagset may be unregistered.

> 
> How about using a mutex inside blk_mq_queue_tag_busy_iter() instead? As 
> far as I can see all blk_mq_queue_tag_busy_iter() happen from a context 
> where it is allowed to sleep.

Well then it seems sensible to add might_sleep() also.

And we still have the blk_mq_queue_tag_busy_iter() problem. As Ming 
mentioned yesterday, we know contexts where from where it is called 
which may not sleep.

Thanks,
John
