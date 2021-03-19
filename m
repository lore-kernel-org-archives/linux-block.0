Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF3C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 09:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984BA64EE2
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 09:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCSJsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 05:48:07 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:39714 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCSJrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 05:47:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USZnQFW_1616147254;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0USZnQFW_1616147254)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Mar 2021 17:47:34 +0800
Subject: Re: [RFC PATCH V2 05/13] block: add req flag of REQ_TAG
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-6-ming.lei@redhat.com>
 <50e454b9-2027-cf38-0be7-a4ecfdd54027@linux.alibaba.com>
 <YFRlYw0efpq/PfMu@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <23a5b4cc-af80-9ec9-ae91-8b1a7e284ac9@linux.alibaba.com>
Date:   Fri, 19 Mar 2021 17:47:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFRlYw0efpq/PfMu@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/19/21 4:48 PM, Ming Lei wrote:
> On Fri, Mar 19, 2021 at 03:59:06PM +0800, JeffleXu wrote:
>>
>>
>> On 3/19/21 12:48 AM, Ming Lei wrote:
>>> Add one req flag REQ_TAG which will be used in the following patch for
>>> supporting bio based IO polling.
>>>
>>> Exactly this flag can help us to do:
>>>
>>> 1) request flag is cloned in bio_fast_clone(), so if we mark one FS bio
>>> as REQ_TAG, all bios cloned from this FS bio will be marked as REQ_TAG.
>>>
>>> 2)create per-task io polling context if the bio based queue supports polling
>>> and the submitted bio is HIPRI. This per-task io polling context will be
>>> created during submit_bio() before marking this HIPRI bio as REQ_TAG. Then
>>> we can avoid to create such io polling context if one cloned bio with REQ_TAG
>>> is submitted from another kernel context.
>>>
>>> 3) for supporting bio based io polling, we need to poll IOs from all
>>> underlying queues of bio device/driver, this way help us to recognize which
>>> IOs need to polled in bio based style, which will be implemented in next
>>> patch.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-core.c          | 29 +++++++++++++++++++++++++++--
>>>  include/linux/blk_types.h |  4 ++++
>>>  2 files changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 0b00c21cbefb..efc7a61a84b4 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -840,11 +840,30 @@ static inline bool blk_queue_support_bio_poll(struct request_queue *q)
>>>  static inline void blk_bio_poll_preprocess(struct request_queue *q,
>>>  		struct bio *bio)
>>>  {
>>> +	bool mq;
>>> +
>>>  	if (!(bio->bi_opf & REQ_HIPRI))
>>>  		return;
>>>  
>>> -	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
>>> +	/*
>>> +	 * Can't support bio based IO poll without per-task poll queue
>>> +	 *
>>> +	 * Now we have created per-task io poll context, and mark this
>>> +	 * bio as REQ_TAG, so: 1) if any cloned bio from this bio is
>>> +	 * submitted from another kernel context, we won't create bio
>>> +	 * poll context for it, so that bio will be completed by IRQ;
>>> +	 * 2) If such bio is submitted from current context, we will
>>> +	 * complete it via blk_poll(); 3) If driver knows that one
>>> +	 * underlying bio allocated from driver is for FS bio, meantime
>>> +	 * it is submitted in current context, driver can mark such bio
>>> +	 * as REQ_TAG manually, so the bio can be completed via blk_poll
>>> +	 * too.
>>> +	 */
>>
>> Sorry I can't understand case 3, could you please further explain it? If
> 
> I meant driver may allocate bio and submit it in current context, and this
> allocated bio is for completing FS hipri bio too. So far, HIPRI won't be
> set for this bio, but driver may mark this bio as HIPRI and TAG, so this
> created bio can be polled.
> 
>> 'driver marks such bio as REQ_TAG manually', then per-task io poll
>> context won't be created, and thus REQ_HIPRI will be cleared, in which
>> case the bio will be completed by IRQ. How could it be completed by
>> blk_poll()?
> 
> The io poll context is created when FS HIPRI bio on based queue(DM) is
> submitted, at that time, bio based driver's ->submit_bio isn't called
> yet. So when bio driver's ->submit_bio() allocates new bios and submits
> them in current context, if driver marks this bio as HIPRI and TAG, they
> can be polled too.

Got it.


> 
>>
>>
>>> +	mq = queue_is_mq(q);
>>> +	if (!blk_queue_poll(q) || (!mq && !blk_get_bio_poll_ctx()))
>>>  		bio->bi_opf &= ~REQ_HIPRI;
>>
>>
>>
>>
>> If the use cases are mixed, saying one kernel context may submit IO with
>> and without REQ_TAG at the meantime (though I don't know if this
>> situation exists), then the above code may not work as we expect.
> 
> Poll context shouldn't be created for kernel context.
> 
> So far, this patch won't cover bios submitted from kernel context, and
> for any bios submitted from kernel context, their HIPRI will be cleared.
> 
>>
>> For example, dm-XXX will return DM_MAPIO_SUBMITTED and actually submits
>> the cloned bio (with REQ_TAG) with internal kernel threads. Besides,
>> dm-XXX will also allocate bio (without REQ_TAG) of itself for metadata
>> logging or something. When submitting bios (without REQ_TAG), per-task
> 
> But HIPRI won't be set for this allocated bio.
> 
>> io poll context will be allocated. Later when submitting cloned bios
>> (with REQ_TAG), the poll context already exists and thus REQ_HIPRI is
>> kept for these bios and they are submitted to polling hw queues.
> 
> Originally I planed to add new helper of submit_poll_bio() for current
> HIPRI uses, and only create poll context in this code path, this way can
> decouple REQ_TAG a bit. But looks it is enough to re-use REQ_TAG for this
> purpose. If not, it can be quite easy to address issue wrt. creating poll
> context.
> 
> 
> Thanks, 
> Ming
> 

-- 
Thanks,
Jeffle
