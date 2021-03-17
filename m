Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F11C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 03:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C1A64F92
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 03:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQDxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 23:53:43 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42954 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhCQDxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 23:53:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USD1OVJ_1615953192;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0USD1OVJ_1615953192)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 11:53:12 +0800
Subject: Re: [RFC PATCH 08/11] block: use per-task poll context to implement
 bio based io poll
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210316031523.864506-1-ming.lei@redhat.com>
 <20210316031523.864506-9-ming.lei@redhat.com>
 <b4dce8c6-61dd-9524-0a55-41db63eb084d@linux.alibaba.com>
 <YFBbjY+oDpjIHI3P@T590>
 <3848e80d-e7ad-9372-c96f-d32bfb9f0ae5@linux.alibaba.com>
 <YFFvYH6dRBoqARF6@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <06bd2e9e-68c9-f74b-f59f-b565a557c47d@linux.alibaba.com>
Date:   Wed, 17 Mar 2021 11:53:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFFvYH6dRBoqARF6@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/17/21 10:54 AM, Ming Lei wrote:
> On Tue, Mar 16, 2021 at 04:52:36PM +0800, JeffleXu wrote:
>>
>>
>> On 3/16/21 3:17 PM, Ming Lei wrote:
>>> On Tue, Mar 16, 2021 at 02:46:08PM +0800, JeffleXu wrote:
>>>> It is a giant progress to gather all split bios that need to be polled
>>>> in a per-task queue. Still some comments below.
>>>>
>>>>
>>>> On 3/16/21 11:15 AM, Ming Lei wrote:
>>>>> Currently bio based IO poll needs to poll all hw queue blindly, this way
>>>>> is very inefficient, and the big reason is that we can't pass bio
>>>>> submission result to io poll task.
>>>>>
>>>>> In IO submission context, store associated underlying bios into the
>>>>> submission queue and save 'cookie' poll data in bio->bi_iter.bi_private_data,
>>>>> and return current->pid to caller of submit_bio() for any DM or bio based
>>>>> driver's IO, which is submitted from FS.
>>>>>
>>>>> In IO poll context, the passed cookie tells us the PID of submission
>>>>> context, and we can find the bio from that submission context. Moving
>>>>> bio from submission queue to poll queue of the poll context, and keep
>>>>> polling until these bios are ended. Remove bio from poll queue if the
>>>>> bio is ended. Add BIO_DONE and BIO_END_BY_POLL for such purpose.
>>>>>
>>>>> Usually submission shares context with io poll. The per-task poll context
>>>>> is just like stack variable, and it is cheap to move data between the two
>>>>> per-task queues.
>>>>>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  block/bio.c               |   5 ++
>>>>>  block/blk-core.c          |  74 +++++++++++++++++-
>>>>>  block/blk-mq.c            | 156 +++++++++++++++++++++++++++++++++++++-
>>>>>  include/linux/blk_types.h |   3 +
>>>>>  4 files changed, 235 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>> index a1c4d2900c7a..bcf5eca0e8e3 100644
>>>>> --- a/block/bio.c
>>>>> +++ b/block/bio.c
>>>>> @@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
>>>>>   **/
>>>>>  void bio_endio(struct bio *bio)
>>>>>  {
>>>>> +	/* BIO_END_BY_POLL has to be set before calling submit_bio */
>>>>> +	if (bio_flagged(bio, BIO_END_BY_POLL)) {
>>>>> +		bio_set_flag(bio, BIO_DONE);
>>>>> +		return;
>>>>> +	}
>>>>>  again:
>>>>>  	if (!bio_remaining_done(bio))
>>>>>  		return;
>>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>>> index a082bbc856fb..970b23fa2e6e 100644
>>>>> --- a/block/blk-core.c
>>>>> +++ b/block/blk-core.c
>>>>> @@ -854,6 +854,40 @@ static inline void blk_bio_poll_preprocess(struct request_queue *q,
>>>>>  		bio->bi_opf |= REQ_TAG;
>>>>>  }
>>>>>  
>>>>> +static bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
>>>>> +{
>>>>> +	struct blk_bio_poll_data data = {
>>>>> +		.bio	=	bio,
>>>>> +	};
>>>>> +	struct blk_bio_poll_ctx *pc = ioc->data;
>>>>> +	unsigned int queued;
>>>>> +
>>>>> +	/* lock is required if there is more than one writer */
>>>>> +	if (unlikely(atomic_read(&ioc->nr_tasks) > 1)) {
>>>>> +		spin_lock(&pc->lock);
>>>>> +		queued = kfifo_put(&pc->sq, data);
>>>>> +		spin_unlock(&pc->lock);
>>>>> +	} else {
>>>>> +		queued = kfifo_put(&pc->sq, data);
>>>>> +	}
>>>>> +
>>>>> +	/*
>>>>> +	 * Now the bio is added per-task fifo, mark it as END_BY_POLL,
>>>>> +	 * so we can save cookie into this bio after submit_bio().
>>>>> +	 */
>>>>> +	if (queued)
>>>>> +		bio_set_flag(bio, BIO_END_BY_POLL);
>>>>> +	else
>>>>> +		bio->bi_opf &= ~(REQ_HIPRI | REQ_TAG);
>>>>> +
>>>>> +	return queued;
>>>>> +}
>>>>
>>>> The size of kfifo is limited, and it seems that once the sq of kfifio is
>>>> full, REQ_HIPRI flag is cleared and the corresponding bio is actually
>>>> enqueued into the default hw queue, which is IRQ driven.
>>>
>>> Yeah, this patch starts with 64 queue depth, and we can increase it to
>>> 128, which should cover most of cases.
>>
>> It seems that the queue depth of kfifo will affect the performance as I
>> did a fast test.
>>
>>
>>
>> Test Result:
>>
>> BLK_BIO_POLL_SQ_SZ | iodepth | IOPS
>> ------------------ | ------- | ----
>> 64                 | 128     | 301k (IRQ) -> 340k (iopoll)
>> 64                 | 16      | 304k (IRQ) -> 392k (iopoll)
>> 128                | 128     | 204k (IRQ) -> 317k (iopoll)
>> 256                | 128     | 241k (IRQ) -> 391k (iopoll)
>>
>> It seems that BLK_BIO_POLL_SQ_SZ need to be increased accordingly when
>> iodepth is quite large. But I don't know why the performance in IRQ mode
>> decreases when BLK_BIO_POLL_SQ_SZ is increased.
> 
> This patchset is supposed to not affect IRQ mode because HIPRI isn't set
> at IRQ mode. Or you mean '--hipri' & io_uring is setup but setting
> nvme.poll_queues as 0 at your 'IRQ' mode test?
> 
> Thanks for starting to run performance test, and so far I just run test
> in KVM, not start performance test yet.
> 

'IRQ' means 'hipri=0' of fio configuration.

The above performance test was performed on one x86 machine with one
single nvme disk. I did the test on another aarch64 machine with more
nvme disks, showing that this performance drop didn't occure...

Please see my reply in another thread for detailed test results.

-- 
Thanks,
Jeffle
