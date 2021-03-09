Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F8C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8909965215
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 17:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCIRt2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:49:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2673 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhCIRtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 12:49:20 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dw2fH35Pdz67x39;
        Wed, 10 Mar 2021 01:44:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 18:49:18 +0100
Received: from [10.210.172.22] (10.210.172.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 17:49:16 +0000
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
 <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
 <784a3686-cb54-561d-740c-30e0b3f46df8@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f60dc68f-9206-2bfb-950e-cb312f1c4c8b@huawei.com>
Date:   Tue, 9 Mar 2021 17:47:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <784a3686-cb54-561d-740c-30e0b3f46df8@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.22]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/03/2021 19:59, Bart Van Assche wrote:
>>> This changes the behavior of blk_mq_tagset_busy_iter(). What will e.g.
>>> happen if the mtip driver calls blk_mq_tagset_busy_iter(&dd->tags,
>>> mtip_abort_cmd, dd) concurrently with another blk_mq_tagset_busy_iter()
>>> call and if that causes all mtip_abort_cmd() calls to be skipped?
>>
>> I'm not sure that I understand this problem you describe. So if 
>> blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd) is called, 
>> either can happen:
>> a. normal operation, iter_usage_counter initially holds >= 1, and then 
>> iter_usage_counter is incremented in blk_mq_tagset_busy_iter() and we 
>> iter the busy tags. Any parallel call to blk_mq_tagset_busy_iter() 
>> will also increase iter_usage_counter.
>> b. we're switching IO scheduler. In this scenario, first we quiesce 
>> all queues. After that, there should be no active requests. At that 
>> point, we ensure any calls to blk_mq_tagset_busy_iter() are finished 
>> and block (or discard may be a better term) any more calls. Blocking 
>> any more calls should be safe as there are no requests to iter. 
>> atomic_cmpxchg() is used to set iter_usage_counter to 0, blocking any 
>> more calls.
> 


Hi Bart,

> My concern is about the insertion of the early return statement in 
> blk_mq_tagset_busy_iter(). 

So I take this approach as I don't see any way to use a mutual exclusion 
waiting mechanism to block calls to blk_mq_tagset_busy_iter() while the 
IO scheduler is being switched.

The reason is that blk_mq_tagset_busy_iter() can be called from any 
context, including hardirq.

> Although most blk_mq_tagset_busy_iter() 
> callers can handle skipping certain blk_mq_tagset_busy_iter() calls 
> (e.g. when gathering statistics), I'm not sure this is safe for all 
> blk_mq_tagset_busy_iter() callers. The example I cited is an example of 
> a blk_mq_tagset_busy_iter() call with side effects.

I don't like to think that we're skipping it, which may imply that there 
are some active requests to iter and we're just ignoring them.

It's more like: we know that there are no requests active, so don't 
bother trying to iterate.

> 
> The mtip driver allocates one tag set per request queue so quiescing 
> queues should be sufficient to address my concern for the mtip driver.
> 
> The NVMe core and SCSI core however share a single tag set across 
> multiple namespaces / LUNs. In the error path of nvme_rdma_setup_ctrl()
> I found a call to nvme_cancel_tagset(). nvme_cancel_tagset() calls 
> blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl). I'm 
> not sure it is safe to skip the nvme_cancel_request() calls if the I/O 
> scheduler for another NVMe namespace is being modified.

Again, I would be relying on all request_queues associated with that 
tagset to be queisced when switching IO scheduler at the point 
blk_mq_tagset_busy_iter() is called and returns early.

Now if there were active requests, I am relying on the request queue 
quiescing to flush them. So blk_mq_tagset_busy_iter() could be called 
during that quiescing period, and would continue to iter the requests.

This does fall over if some tags are allocated without associated 
request queue, which I do not know exists.

Thanks,
John

