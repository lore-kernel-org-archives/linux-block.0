Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA7DC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA97208A9
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHZMGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:06:20 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729494AbgHZMGG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 08:06:06 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3C460F36EAB786817D3;
        Wed, 26 Aug 2020 13:06:05 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 26 Aug
 2020 13:06:04 +0100
Subject: Re: [PATCH 0/5] blk-mq: fix use-after-free on stale request
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
 <accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org>
 <20200821024949.GA3110165@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e42f1c04-eb34-63aa-c9c8-57c58d4b28b0@huawei.com>
Date:   Wed, 26 Aug 2020 13:03:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200821024949.GA3110165@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.200]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/08/2020 03:49, Ming Lei wrote:
> Hello Bart,
> 
> On Thu, Aug 20, 2020 at 01:30:38PM -0700, Bart Van Assche wrote:
>> On 8/20/20 11:03 AM, Ming Lei wrote:
>>> We can't run allocating driver tag and updating tags->rqs[tag] atomically,
>>> so stale request may be retrieved from tags->rqs[tag]. More seriously, the
>>> stale request may have been freed via updating nr_requests or switching
>>> elevator or other use cases.
>>>
>>> It is one long-term issue, and Jianchao previous worked towards using
>>> static_rqs[] for iterating request, one problem is that it can be hard
>>> to use when iterating over tagset.
>>>
>>> This patchset takes another different approach for fixing the issue: cache
>>> freed rqs pages and release them until all tags->rqs[] references on these
>>> pages are gone.
>>
>> Hi Ming,
>>
>> Is this the only possible solution? Would it e.g. be possible to protect the
>> code that iterates over all tags with rcu_read_lock() / rcu_read_unlock() and
>> to free pages that contain request pointers only after an RCU grace period has
>> expired?
> 
> That can't work, tags->rqs[] is host-wide, request pool belongs to scheduler tag
> and it is owned by request queue actually. When one elevator is switched on this
> request queue or updating nr_requests, the old request pool of this queue is freed,
> but IOs are still queued from other request queues in this tagset. Elevator switch
> or updating nr_requests on one request queue shouldn't or can't other request queues
> in the same tagset.
> 
> Meantime the reference in tags->rqs[] may stay a bit long, and RCU can't cover this
> case.
> 
> Also we can't reset the related tags->rqs[tag] simply somewhere, cause it may
> race with new driver tag allocation. 

How about iterate all tags->rqs[] for all scheduler tags when exiting 
the scheduler, etc, and clear any scheduler requests references, like this:

cmpxchg(&hctx->tags->rqs[tag], scheduler_rq, 0);

So we NULLify any tags->rqs[] entries which contain a scheduler request 
of concern atomically, cleaning up any references.

I quickly tried it and it looks to work, but maybe not so elegant.

Or some atomic update is required,
> but obviously extra load is introduced in fast path.

Yes, similar said on this patch:
https://lore.kernel.org/linux-block/cf524178-c497-373c-37f6-abee13eacf19@kernel.dk/

> 
>> Would that perhaps result in a simpler solution?
> 
> No, that doesn't work actually.
> 
> This patchset looks complicated, but the idea is very simple. With this
> approach, we can extend to support allocating request pool attached to
> driver tags dynamically. So far, it is always pre-allocated, and never be
> used for normal single queue disks.
> 

I'll continue to check this solution, but it seems to me that we should 
not get as far as the rq->q == hctx->queue check in bt_iter().

Thanks,
John

