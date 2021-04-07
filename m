Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DBC433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852A161222
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhDGPOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:14:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2798 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhDGPOv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 11:14:51 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFnnQ2BpXz681My;
        Wed,  7 Apr 2021 23:07:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 17:14:38 +0200
Received: from [10.210.168.126] (10.210.168.126) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 16:14:37 +0100
Subject: Re: [PATCH v5 0/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210405002834.32339-1-bvanassche@acm.org>
 <a4ffb3f0-414d-ba7b-db49-1660faa37873@huawei.com>
 <fd0359fd-37a5-1e60-0a2b-4e27d1d3ee33@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2168c21a-f458-fb5e-0393-c31f13f55d0d@huawei.com>
Date:   Wed, 7 Apr 2021 16:12:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <fd0359fd-37a5-1e60-0a2b-4e27d1d3ee33@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.126]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/04/2021 18:49, Bart Van Assche wrote:
> On 4/6/21 1:00 AM, John Garry wrote:
>> Hi Bart,
>>
>>> Changes between v2 and v3:
>>> - Converted the single v2 patch into a series of three patches.
>>> - Switched from SRCU to a combination of RCU and semaphores.
>>
>> But can you mention why we made to changes from v3 onwards (versus
>> v2)?
>>
>> The v2 patch just used SRCU as the sync mechanism, and the impression
>> I got from Jens was that the marginal performance drop was tolerable.
>> And the issues it tries to address seem to be solved. So why change?
>> Maybe my impression of the performance drop being acceptable was
>> wrong.
> 

Hi Bart,

> 
> It seems like I should have done a better job of explaining that change.
> On v2 I received the following feedback from Hannes: "What I don't
> particularly like is the global blk_sched_srcu here; can't
> we make it per tagset?". My reply was as follows: "I'm concerned about
> the additional memory required for one srcu_struct per tag set."

I actually said the same thing about the global blk_sched_srcu, but 
would not want a per-tagset srcu struct unless it was necessary for your 
same reason (additional memory).

> Hence
> the switch from SRCU to RCU + rwsem. See also
> https://lore.kernel.org/linux-block/d1627890-fb10-7ebe-d805-621f925f80e7@suse.de/.
> 
> Regarding the 1% performance drop measured by Jens: with debugging
> disabled srcu_dereference() is translated into READ_ONCE() and
> rcu_assign_pointer() is translated into smp_store_release(). 

I think it depends on whether assigning NULL, which gives WRITE_ONCE(), 
while non-NULL is smp_store_release().

> On x86
> smp_store_release() is translated into a compiler barrier +
> WRITE_ONCE().

Right, asm-generic gives smp mb + WRITE_ONCE(), and arm64 has a 
dedicated store-release instruction.

> In other words, I do not expect that the performance
> difference came from the switch to SRCU but rather from the two new
> hctx->tags->rqs[] assignments.
> 
> I think that the switch to READ_ONCE() / WRITE_ONCE() is unavoidable.
> Even if cmpxchg() would be used to clear hctx->tags->rqs[] pointers then
> we would need to convert all other hctx->tags->rqs[] accesses into
> READ_ONCE() / WRITE_ONCE() to make that cmpxchg() call safe.
> 

OK, I tend to agree with this. But it seems to me that they are needed 
anyway.

Anyway, I'll have a look at the latest series...

Thanks,
John
