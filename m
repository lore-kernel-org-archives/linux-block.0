Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49718C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BF221741
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TyQRVmZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfA1RFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:05:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39694 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfA1RFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 12:05:40 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so14058709iob.6
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XDUJVps6ifSHKUlid10YG855mBGQy3cyctVsmtcr8J4=;
        b=TyQRVmZHd7bhPJ88qTY0Sg8CMEZR2jLHbyQUqc6zwSpjSAwiiHqn0hf0q4rNiQ4i5b
         CLKqxgV0y1aElMe6A4bJiqaRL4NFFxwqDi3mvtB5CWerN6hLIR+UXNAb1flUUVhOjrSl
         WnhqLyheQnwQA1dqJU/xVBqU1xqr5cyX2Dm4Fjl9tTsmDkhK56JxMcuhsi7675lUsJuW
         XaViILFV6QEA9DfQUnYkXmzAreW6BUvF5yNR7KmPMt6HOTBrD8ErLMcxScoGSbQzVObu
         Xu2tfKlyFxFfwcMXhYjMb+G+B0P5+m/pIosuVKpWj8v9Y7ujie9HqDS9tgRwl1ZoiIrq
         /8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDUJVps6ifSHKUlid10YG855mBGQy3cyctVsmtcr8J4=;
        b=kE1FhFw/bfWongcvCajcttiOs46Cz9j2Eet0qdxfpJsQajqbugmF44egRIjdsuGjeu
         B7K41EdLZbxyGB4RYqsmi3T+MjhaPs5hOs+vsAPlj6aLlBs9WGCgEe334eeAmIwXV5bG
         IRwgI56ZML5yhC6ZYHIPrIT8KOdyqZfhfRcuF2OXnA92o4khg6cPixVtR1Xh3TDwD9Ch
         r3b0F+t+UqNyTYQVbnyG0OJsc/UAPG07TU74OPoclml2fww7IZ34HeOkpXhoNRSIZwE2
         qBuDYwgFmS4KoppSCcOA0akxONc5a6s1kxf+u0YlXTACWrL+AT/P56y+iIhVsRpd/OBS
         Uxxg==
X-Gm-Message-State: AHQUAuYG8BSQBUenEGU8K+3Opmna6lZct2Tg2giBPlImjsbyd3xZPakJ
        Q6waEszXYzb4HqKy41jk8OC+oQ==
X-Google-Smtp-Source: ALg8bN7jJ1OegpkXYFKzM737vyFWHDDesG2YSBqI9kFua8uhua7/ftrGdRYkr+l69DBUW/M6/7dDaA==
X-Received: by 2002:a6b:d101:: with SMTP id l1mr13809802iob.81.1548695139366;
        Mon, 28 Jan 2019 09:05:39 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c3sm13744061ioi.2.2019.01.28.09.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 09:05:38 -0800 (PST)
Subject: Re: [PATCH 09/13] io_uring: add submission polling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-12-axboe@kernel.dk> <20190128150926.GB10110@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9cf014d9-cf16-fa49-83f0-0e9ddb57cc81@kernel.dk>
Date:   Mon, 28 Jan 2019 10:05:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128150926.GB10110@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 8:09 AM, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 08:35:22AM -0700, Jens Axboe wrote:
>> Proof of concept.
> 
> Is that still true?

I guess I can remove it now, dates back to when it was initially just
a test. But it should be solid, I'll kill that part.

>> 1) Maybe have smarter backoff. Busy loop for X time, then go to
>>    monitor/mwait, finally the schedule we have now after an idle
>>    second. Might not be worth the complexity.
>>
>> 2) Probably want the application to pass in the appropriate grace
>>    period, not hard code it at 1 second.
> 
> 2) actually sounds really useful.  Should we look into it ASAP?

I think so. Question is what kind of granularity we need for this. I
think we can go pretty coarse and keep it in msec, using a short to
pass this in like we do for the thread CPU. That gives us 0..65535 msec,
which should be plenty of range.

>>  	struct {
>>  		/* CQ ring */
>> @@ -264,6 +267,9 @@ static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
>>  
>>  	if (waitqueue_active(&ctx->wait))
>>  		wake_up(&ctx->wait);
>> +	if ((ctx->flags & IORING_SETUP_SQPOLL) &&
>> +	    waitqueue_active(&ctx->sqo_wait))
> 
> waitqueue_active is really cheap and sqo_wait should not otherwise
> by active.  Do we really need the flags check here?

Probably not, I'll kill it.

>> +			/*
>> +			 * Normal IO, just pretend everything completed.
>> +			 * We don't have to poll completions for that.
>> +			 */
>> +			if (ctx->flags & IORING_SETUP_IOPOLL) {
>> +				/*
>> +				 * App should not use IORING_ENTER_GETEVENTS
>> +				 * with thread polling, but if it does, then
>> +				 * ensure we are mutually exclusive.
> 
> Should we just return an error early on in this case instead?

I think that'd make it awkward, since it's out-of-line. If the app is doing
things it shouldn't in this case, its own io_uring_enter() would most likely
fail occasionally with -EBUSY anyway.

>>  	if (to_submit) {
>> +		if (ctx->flags & IORING_SETUP_SQPOLL) {
>> +			wake_up(&ctx->sqo_wait);
>> +			ret = to_submit;
> 
> Do these semantics really make sense?  Maybe we should have an
> IORING_ENTER_WAKE_SQ instead of overloading the to_submit argument?
> Especially as we don't really care about returning the number passed in.

I like that change, I'll add IORING_ENTER_SQ_WAKEUP instead of using
'to_submit' for this. We can't validate the number anyway.

>> +	if (ctx->sqo_thread) {
>> +		kthread_park(ctx->sqo_thread);
> 
> Can you explain why we need the whole kthread_park game?  It is only
> intended to deal with pausing a thread, and if need it to shut down
> a thread we have a bug somewhere.

It is working around a bug in shutting down a thread that is affinitized
to a single CPU, I just didn't want to deal with hunting that down right
now.

>>  static void io_sq_offload_stop(struct io_ring_ctx *ctx)
>>  {
>> +	if (ctx->sqo_thread) {
>> +		kthread_park(ctx->sqo_thread);
>> +		kthread_stop(ctx->sqo_thread);
>> +		ctx->sqo_thread = NULL;
> 
> Also there isn't really much of a point in setting pointers to NULL
> just before freeing the containing structure.  In the best case this
> now papers over bugs that poisoning or kasan would otherwise find.

Removed.

-- 
Jens Axboe

