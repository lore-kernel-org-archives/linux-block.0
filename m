Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A8C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C24F6117A
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 09:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhDZJGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:06:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhDZJGT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 05:06:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DF1BB029;
        Mon, 26 Apr 2021 09:05:37 +0000 (UTC)
Subject: Re: [PATCH V6 10/12] block: limit hw queues to be polled in each
 blk_poll()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-11-ming.lei@redhat.com>
 <b6a1f1fa-bad2-e072-6292-363510fc7017@suse.de> <YIZzGAxaNnNE0Ipa@T590>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <f1a13439-9ea7-9cdd-7489-2da4abd7256f@suse.de>
Date:   Mon, 26 Apr 2021 11:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIZzGAxaNnNE0Ipa@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 10:00 AM, Ming Lei wrote:
> On Mon, Apr 26, 2021 at 09:19:20AM +0200, Hannes Reinecke wrote:
>> On 4/22/21 2:20 PM, Ming Lei wrote:
>>> Limit at most 8 queues are polled in each blk_pull(), avoid to
>>> add extra latency when queue depth is high.
>>>
>>> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-poll.c | 78 ++++++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 55 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/block/blk-poll.c b/block/blk-poll.c
>>> index 249d73ff6f81..20e7c47cc984 100644
>>> --- a/block/blk-poll.c
>>> +++ b/block/blk-poll.c
>>> @@ -288,36 +288,32 @@ static void bio_grp_list_move(struct bio_grp_list *dst,
>>>  	src->nr_grps -= cnt;
>>>  }
>>>  
>>> -static int blk_mq_poll_io(struct bio *bio)
>>> +#define POLL_HCTX_MAX_CNT 8
>>> +
>>> +static bool blk_add_unique_hctx(struct blk_mq_hw_ctx **data, int *cnt,
>>> +		struct blk_mq_hw_ctx *hctx)
>>>  {
>>> -	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
>>> -	blk_qc_t cookie = bio_get_poll_data(bio);
>>> -	int ret = 0;
>>> +	int i;
>>>  
>>> -	/* wait until the bio is submitted really */
>>> -	if (!blk_qc_t_ready(cookie))
>>> -		return 0;
>>>  
>>> -	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
>>> -		struct blk_mq_hw_ctx *hctx =
>>> -			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
>>> +	for (i = 0; i < *cnt; i++) {
>>> +		if (data[i] == hctx)
>>> +			goto exit;
>>> +	}
>>>  
>>> -		ret += blk_mq_poll_hctx(q, hctx);
>>> +	if (i < POLL_HCTX_MAX_CNT) {
>>> +		data[i] = hctx;
>>> +		(*cnt)++;
>>>  	}
>>> -	return ret;
>>> + exit:
>>> +	return *cnt == POLL_HCTX_MAX_CNT;
>>>  }
>>>  
>>> -static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
>>> +static void blk_build_poll_queues(struct bio_grp_list *grps,
>>> +		struct blk_mq_hw_ctx **data, int *cnt)
>>>  {
>>> -	int ret = 0;
>>>  	int i;
>>>  
>>> -	/*
>>> -	 * Poll hw queue first.
>>> -	 *
>>> -	 * TODO: limit max poll times and make sure to not poll same
>>> -	 * hw queue one more time.
>>> -	 */
>>>  	for (i = 0; i < grps->nr_grps; i++) {
>>>  		struct bio_grp_list_data *grp = &grps->head[i];
>>>  		struct bio *bio;
>>> @@ -325,11 +321,31 @@ static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
>>>  		if (bio_grp_list_grp_empty(grp))
>>>  			continue;
>>>  
>>> -		for (bio = grp->list.head; bio; bio = bio->bi_poll)
>>> -			ret += blk_mq_poll_io(bio);
>>> +		for (bio = grp->list.head; bio; bio = bio->bi_poll) {
>>> +			blk_qc_t  cookie;
>>> +			struct blk_mq_hw_ctx *hctx;
>>> +			struct request_queue *q;
>>> +
>>> +			if (bio_flagged(bio, BIO_DONE))
>>> +				continue;
>>> +
>>> +			/* wait until the bio is submitted really */
>>> +			cookie = bio_get_poll_data(bio);
>>> +			if (!blk_qc_t_ready(cookie) || !blk_qc_t_valid(cookie))
>>> +				continue;
>>> +
>>> +			q = bio->bi_bdev->bd_disk->queue;
>>> +			hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
>>> +			if (blk_add_unique_hctx(data, cnt, hctx))
>>> +				return;
>>> +		}
>>>  	}
>>> +}
>>> +
>>> +static void blk_bio_poll_reap_ios(struct bio_grp_list *grps)
>>> +{
>>> +	int i;
>>>  
>>> -	/* reap bios */
>>>  	for (i = 0; i < grps->nr_grps; i++) {
>>>  		struct bio_grp_list_data *grp = &grps->head[i];
>>>  		struct bio *bio;
>>> @@ -354,6 +370,22 @@ static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
>>>  		}
>>>  		__bio_grp_list_merge(&grp->list, &bl);
>>>  	}
>>> +}
>>> +
>>> +static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
>>> +{
>>> +	int ret = 0;
>>> +	int i;
>>> +	struct blk_mq_hw_ctx *hctx[POLL_HCTX_MAX_CNT];
>>> +	int cnt = 0;
>>> +
>>> +	blk_build_poll_queues(grps, hctx, &cnt);
>>> +
>>> +	for (i = 0; i < cnt; i++)
>>> +		ret += blk_mq_poll_hctx(hctx[i]->queue, hctx[i]);
>>> +
>>> +	blk_bio_poll_reap_ios(grps);
>>> +
>>>  	return ret;
>>>  }
>>>  
>>>
>> Can't we make it a sysfs attribute instead of hard-coding it?
>> '8' seems a bit arbitrary to me, I'd rather have the ability to modify it...
> 
> I'd rather not add such code in the feature 'enablement' stage since I doesn't
> observe the number plays a big role yet. It is added for holding hw queues to
> be polled on stack variables, also avoid to add too much latency if there is
> too many bios from too many hw queues to be reaped.
> 
> Also the actual polled hw queues can be observed easily via bpftrace, so debug
> purpose from sysfs isn't necessary too.
> 
Okay. You can add my

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
