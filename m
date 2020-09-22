Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D43C4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 04:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D5323A34
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 04:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgIVEnm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 00:43:42 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53401 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbgIVEnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 00:43:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U9jvbgr_1600749817;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0U9jvbgr_1600749817)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 12:43:37 +0800
Subject: Re: [RFC] block: enqueue splitted bios into same cpu
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <20200911032958.125068-1-jefflexu@linux.alibaba.com>
 <20200911110101.GA143560@T590>
 <e787faa8-d31f-04e7-f722-5013a52dc8ab@linux.alibaba.com>
 <20200913140017.GA230984@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <c709e970-c711-11b7-e897-c66a12be454e@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 12:43:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913140017.GA230984@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for replying. Comments embedded below.


On 9/13/20 10:00 PM, Ming Lei wrote:
> On Fri, Sep 11, 2020 at 07:40:14PM +0800, JeffleXu wrote:
>> Thanks for replying ;)
>>
>>
>> On 9/11/20 7:01 PM, Ming Lei wrote:
>>> On Fri, Sep 11, 2020 at 11:29:58AM +0800, Jeffle Xu wrote:
>>>> Splitted bios of one source bio can be enqueued into different CPU since
>>>> the submit_bio() routine can be preempted or fall asleep. However this
>>>> behaviour can't work well with iopolling.
>>> Do you have user visible problem wrt. io polling? If yes, can you
>>> provide more details?
>> No, there's no practical example yet. It's only a hint from the code base.
>>
>>
>>>> Currently block iopolling only polls the hardwar queue of the input bio.
>>>> If one bio is splitted to several bios, one (bio 1) of which is enqueued
>>>> into CPU A, while the others enqueued into CPU B, then the polling of bio 1
>>>> will cotinuously poll the hardware queue of CPU A, though the other
>>>> splitted bios may be in other hardware queues.
>>> If it is guaranteed that the returned cookie is from bio 1, poll is
>>> supposed to work as expected, since bio 1 is the chained head of these
>>> bios, and the whole fs bio can be thought as done when bio1 .end_bio
>>> is called.
>> Yes, it is, thanks for your explanation. But except for polling if the input
>> bio has completed, one of the
>>
>> important work of polling logic is to reap the completion queue. Let's say
>> one bio is split into
>>
>> two bios, bio 1 and bio 2, both of which are enqueued into the same hardware
>> queue.When polling bio1,
>>
>> though we have no idea about bio2 at all, the polling logic itself is still
>> reaping the completion queue of
>>
>> this hardware queue repeatedly, in which case the polling logic still
>> stimulates reaping bio2.
>>
>>
>> Then what if these two split bios enqueued into two different hardware
>> queue? Let's say bio1 is enqueued
>>
>> into hardware queue A, while bio2 is enqueued into hardware queue B. When
>> polling bio1, though the polling
>>
>> logic is repeatedly reaping the completion queue of hardware queue A, it
>> doesn't help reap bio2. bio2 is reaped
>>
>> by IRQ as usual. This certainly works currently, but this behavior may
>> deviate the polling design? I'm not sure.
>>
>>
>> In other words, if we can ensure that all split bios are enqueued into the
>> same hardware queue, then the polling
>>
>> logic *may* be faster.
> __submit_bio_noacct_mq() returns cookie from the last bio in current->bio_list, and
> this bio should be the bio passed to __submit_bio_noacct_mq() when bio splitting happens.
>
> Suppose CPU migration happens during bio splitting, the last bio should be
> submitted to LLD much late than other bios, so when blk_poll() finds
> completion on the hw queue of the last bio, usually other bios should
> be completed already most of times.
>
> Also CPU migration itself causes much bigger latency, so it is reasonable to
> not expect good IO performance when CPU migration is involved. And CPU migration
> on IO task shouldn't have been done frequently. That said it should be
> fine to miss the poll in this situation.

Yes you're right. After diving into the code of nvme driver, currently 
nvme driver indeed allocate interrupt for polling queues,

that is, reusing the interrupt used by admin queue.

Jens had ever said that the interrupt may be disabled for queues working 
in polling mode someday (from my colleague). If

that is true, then this may become an issue. But at least now this 
indeed works.


>
> Also the following part of your patch may not work reliably:
>
> @@ -370,7 +370,8 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>          }
>
>   retry:
> -       data->ctx = blk_mq_get_ctx(q);
> +       cpu = (data->cpu_hint != -1) ? data->cpu_hint : raw_smp_processor_id();
> +       data->ctx = __blk_mq_get_ctx(q, cpu);
>          data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
>          if (!e)
>                  blk_mq_tag_busy(data->hctx);
>
> If the cpu of data->cpu_hint is becoming offline, the above retry may
> never be finished. Also I really don't like this way to allocate request
> on specified cpu or ctx.
>
>>
>>>> The iopolling logic has no idea if the input bio is splitted bio, or if
>>>> it has other splitted siblings. Thus ensure that all splitted bios are
>>>> enqueued into one CPU at the beginning.
>>> Yeah, that is why io poll can't work on DM.
>> Exactly I'm interested in dm polling. The polling of bio to dm device can be
>> mapped into the polling of the
>>
>> several underlying device. Except for the the design of the cookie,
>> currently I have not found other blocking
>>
>> points technically. Please let me know if I missed something.
> At least dm(except for dm-mpath) doesn't use blk-mq , so far io poll is
> based on blk-mq. Not mention it could be hard to return the expected
> cookie.

Polling mode is important if we want to use io-uring on dm.


I want to refactor the cookie to u64 from unsigned int, thus the u64 
cookie can be a pointer to some structure for device

mapper, e.g. struct dm_io, and all cookies from underlying devices can 
be stored in this structure (struct dm_io).

This need to refactor the io polling framework somehow, and I'm not sure 
if the community likes this idea.


>
>>
>>>> This is only one RFC patch and it is not complete since dm/mq-scheduler
>>>> have not been considered yet. Please let me know if it is on the correct
>>>> direction or not.
>>>>
>>>> Besides I have one question on the split routine. Why the split routine
>>>> is implemented in a recursive style? Why we can't split the bio one time
>>>> and then submit the *already splitted* bios one by one?
>>> Forward progress has to be provided on new splitted bio allocation which
>>> is from same bio_set.
>> Sorry I can't understand this. Is this a suggestion on how to improving this
>> patch, or a reply to the question
>>
>> why the split routine is implemented in a recursive style? Would you please
>> provide more details?
> It is for preventing stack overflows.
>
> Please take a close look at bio_alloc_bioset's comment and understand
> why 'callers must never allocate more than 1 bio at a time from this pool'

Thanks.

Jeffle

