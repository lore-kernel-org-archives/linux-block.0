Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB06C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9602186A
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551289162;
	bh=GlTJOFxQGa7YiUdEzm38xwKfhO/EuKwLFpIb0JOFknk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBKOPQFpddzKsRyOUGAJeFHO/MV190tHilv3QMri52KwjxBO2HU9IYdo7Ih9SkVxM
	 3+/CxQZRKyihzwW+9nnvSrI7KOvH+SnWrz1qZd7bon3r9vG2/0S14DuV9QJZqPg7YV
	 9fcpN7vZznLMaZAgaaZHqMdtAFhs+6u70H0oCvOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfB0RjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfB0RjV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:39:21 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D518120C01;
        Wed, 27 Feb 2019 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551289160;
        bh=GlTJOFxQGa7YiUdEzm38xwKfhO/EuKwLFpIb0JOFknk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tybfHo6jvqezAzrLaQnG/t+L6Y2q/sxS67STDm1g4pBt+l1hGYmYlMJwgJFs2qpjs
         diU9YX3dqhEfE0JmU3ms1bQp+PdlNDfZNul98l10oWCEW9d7+AKpfh9zEukxrCOcog
         UoH+L+Tra/6XyqDZUKkDa9bP23ZRTeyKBdacs+IE=
Date:   Wed, 27 Feb 2019 12:39:18 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 49/77] block: cover another queue enter
 recursion via BIO_QUEUE_ENTERED
Message-ID: <20190227173918.GL10616@sasha-vm>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-49-sashal@kernel.org>
 <20190215022807.GC21045@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215022807.GC21045@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 15, 2019 at 10:28:08AM +0800, Ming Lei wrote:
>On Thu, Feb 14, 2019 at 09:08:27PM -0500, Sasha Levin wrote:
>> From: Ming Lei <ming.lei@redhat.com>
>>
>> [ Upstream commit 698cef173983b086977e633e46476e0f925ca01e ]
>>
>> Except for blk_queue_split(), bio_split() is used for splitting bio too,
>> then the remained bio is often resubmit to queue via generic_make_request().
>> So the same queue enter recursion exits in this case too. Unfortunatley
>> commit cd4a4ae4683dc2 doesn't help this case.
>>
>> This patch covers the above case by setting BIO_QUEUE_ENTERED before calling
>> q->make_request_fn.
>>
>> In theory the per-bio flag is used to simulate one stack variable, it is
>> just fine to clear it after q->make_request_fn is returned. Especially
>> the same bio can't be submitted from another context.
>>
>> Fixes: cd4a4ae4683dc2 ("block: don't use blocking queue entered for recursive bio submits")
>> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: NeilBrown <neilb@suse.com>
>> Reviewed-by:  Mike Snitzer <snitzer@redhat.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  block/blk-core.c  | 11 +++++++++++
>>  block/blk-merge.c | 10 ----------
>>  2 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index deb56932f8c4..22260339f66f 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -2449,7 +2449,18 @@ blk_qc_t generic_make_request(struct bio *bio)
>>  			/* Create a fresh bio_list for all subordinate requests */
>>  			bio_list_on_stack[1] = bio_list_on_stack[0];
>>  			bio_list_init(&bio_list_on_stack[0]);
>> +
>> +			/*
>> +			 * Since we're recursing into make_request here, ensure
>> +			 * that we mark this bio as already having entered the queue.
>> +			 * If not, and the queue is going away, we can get stuck
>> +			 * forever on waiting for the queue reference to drop. But
>> +			 * that will never happen, as we're already holding a
>> +			 * reference to it.
>> +			 */
>> +			bio_set_flag(bio, BIO_QUEUE_ENTERED);
>>  			ret = q->make_request_fn(q, bio);
>> +			bio_clear_flag(bio, BIO_QUEUE_ENTERED);
>>
>>  			/* sort new bios into those for a lower level
>>  			 * and those for the same level
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 7695034f4b87..adfe835ab258 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -272,16 +272,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
>>  		/* there isn't chance to merge the splitted bio */
>>  		split->bi_opf |= REQ_NOMERGE;
>>
>> -		/*
>> -		 * Since we're recursing into make_request here, ensure
>> -		 * that we mark this bio as already having entered the queue.
>> -		 * If not, and the queue is going away, we can get stuck
>> -		 * forever on waiting for the queue reference to drop. But
>> -		 * that will never happen, as we're already holding a
>> -		 * reference to it.
>> -		 */
>> -		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
>> -
>>  		bio_chain(split, *bio);
>>  		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
>>  		generic_make_request(*bio);
>> --
>> 2.19.1
>>
>
>This one should be dropped, given it has been reverted.

Dropped, thank you.

--
Thanks,
Sasha
