Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940C5C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5968620663
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wXjtx0xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbfA1Q0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:26:47 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38320 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390282AbfA1Q0q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:46 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so13952314ioj.5
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r028+yXZdnwHjwN5Ep/1T2M0YUOJNE9i3BYe9IL7n9s=;
        b=wXjtx0xd6Nur5D6WgAx+S8mlTWNrJWXSx/U1nJM8c0Oo2e/AROKryadaaXQBgMu0po
         KhKEXce99UdY2UquEEo+8N8ZN7ugjvrZ/3vcuv2orBIV6SjcVq6gStlW+fpghDbyNxiy
         8ujgxzv+ws3XCtUTJzVaI0BjpPF2glg4xXBbzD7x+9jYyMtH+vVYLsclDK4jEEevSY8R
         JNTAcRCP0+tYKyvwZqncr8G4Wthb9oJS17B5TVMlg8qCwbUGz1u+/lwaUGrZtNHaxW/B
         H8phA5aQ1zaOru4LfUg3Ag8doniclimMtm16z7z5gvaOV/iTqnlZtgOWfAp/2JKRwPK3
         XpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r028+yXZdnwHjwN5Ep/1T2M0YUOJNE9i3BYe9IL7n9s=;
        b=M5SKuV+XbzbNBejQB8fhnppI1be+QoemV5W92GwFvNIlo1vuiMN149nZDlsDUN5I6V
         mU2wjvOwqzVOkPTUI4TsBNNWBSYdFR0K3ukVS+BzLIdyLWxmtLBUo+zWy8HoW31jFJtk
         ZiZ9aYjULeCMNJ21n/deOXnPDoqMdqoqq2ItWDYRueonq17Z1aXkTgidEvMWmGfIh1S1
         pUKQYoxxKm3QRZxw4d2+QsJ9AUOcidP3s15Rq5wErBnlSLxJ55o1cD/K3hzlnprgVaEj
         d6wmx0/gkoKnf3YAHbKaVzq0A4IE6z9KAzpPyoKF2M2ZZMH1ViTb19KKkNp1QemTbYoN
         +sGw==
X-Gm-Message-State: AHQUAuZQLWwfpuUjjrrRtKA07dEK8tW/Kb0GRz2jltkZIuIPAkm1VKLY
        FCwtiTPiX9pwHMlpLSWmLzfgvg==
X-Google-Smtp-Source: AHgI3Ib4ff+40bTUD4aTdxiFTA2dVbqpkMeVek8AWOIHbG2RliwXbF02IbXGXbG4ol56NaV/7kXQpQ==
X-Received: by 2002:a6b:7312:: with SMTP id e18mr13133296ioh.288.1548692805191;
        Mon, 28 Jan 2019 08:26:45 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c3sm13706456ioi.2.2019.01.28.08.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:26:44 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <42a5b12b-8d3a-2495-ad53-6a6fdd4504c6@kernel.dk>
Date:   Mon, 28 Jan 2019 09:26:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128145700.GA9795@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 7:57 AM, Christoph Hellwig wrote:
> [please make sure linux-api and linux-man are CCed on new syscalls
> so that we get API experts to review them]

I already did review with Arnd on those parts, I'll add linux-api and
linux-man for the next posting.

>> io_uring_enter(fd, to_submit, min_complete, flags)
>> 	Initiates IO against the rings mapped to this fd, or waits for
>> 	them to complete, or both. The behavior is controlled by the
>> 	parameters passed in. If 'to_submit' is non-zero, then we'll
>> 	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>> 	kernel will wait for 'min_complete' events, if they aren't
>> 	already available. It's valid to set IORING_ENTER_GETEVENTS
>> 	and 'min_complete' == 0 at the same time, this allows the
>> 	kernel to return already completed events without waiting
>> 	for them. This is useful only for polling, as for IRQ
>> 	driven IO, the application can just check the CQ ring
>> 	without entering the kernel.
> 
> Especially with poll support now in the series, don't we need a ѕigmask
> argument similar to pselect/ppoll/io_pgetevents now to deal with signal
> blocking during waiting for events?

I guess we do.

>> +struct sqe_submit {
>> +	const struct io_uring_sqe *sqe;
>> +	unsigned index;
>> +};
> 
> Can you make sure all the structs use tab indentation for their
> field names?  Maybe even the same for all structs just to be nice
> to my eyes?

Sure, fixed.

>> +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>> +			   const struct io_uring_sqe *sqe,
>> +			   struct iovec **iovec, struct iov_iter *iter)
>> +{
>> +	void __user *buf = u64_to_user_ptr(sqe->addr);
>> +
>> +#ifdef CONFIG_COMPAT
>> +	if (ctx->compat)
>> +		return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
>> +						iovec, iter);
>> +#endif
> 
> I think we can just check in_compat_syscall() here, which means we
> can kill the ->compat member, and the separate compat version of the
> setup syscall.

Good point, I'll switch to using that so we don't have to track it.

>> +/*
>> + * IORING_OP_NOP just posts a completion event, nothing else.
>> + */
>> +static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> +{
>> +	struct io_ring_ctx *ctx = req->ctx;
>> +
>> +	__io_cqring_add_event(ctx, sqe->user_data, 0, 0);
> 
> Can you explain why not taking the completion lock is safe here?  And
> why we want to have such a somewhat dangerous special case just for the
> no-op benchmarking aid?

Was going to say it's safe because we always fill the ring inside the
ring mutex, but that won't work if we intermingle with non-polled IO.
I'll switch it to using the normal locked variant.

>> +static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>> +{
>> +	struct io_sq_ring *ring = ctx->sq_ring;
>> +	unsigned head;
>> +
>> +	head = ctx->cached_sq_head;
>> +	smp_rmb();
>> +	if (head == READ_ONCE(ring->r.tail))
>> +		return false;
> 
> Do we really need to optimize the sq_head == tail case so much? Or
> am I missing why we are using the cached sq head case here?  Maybe
> add some more comments for a start.

It basically serves two purposes:

1) When we grab multiple events, only have to update the actual ring
   tail once. This is a big deal, especially on archs where the barriers
   are more expensive.

2) It means the kernel tracks the sq tail and cq head, instead of
   completely relying on the application. This seems a much saner
   choice.

>> +static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
>> +			    unsigned min_complete, unsigned flags)
>> +{
>> +	int ret = 0;
>> +
>> +	if (to_submit) {
>> +		ret = io_ring_submit(ctx, to_submit);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +	if (flags & IORING_ENTER_GETEVENTS) {
>> +		int get_ret;
>> +
>> +		if (!ret && to_submit)
>> +			min_complete = 0;
> 
> Why do we have this special case?  Does it need some documentation?

At least for polled IO, if we don't submit what we were asked to, then
we can't reliably poll for the passed in number of events. The
min_complete from the application could very well include the
expectation that to_submit were submitted as well.

I'll add a comment.

>> +
>> +		get_ret = io_cqring_wait(ctx, min_complete);
>> +		if (get_ret < 0 && !ret)
>> +			ret = get_ret;
>> +	}
>> +
>> +	return ret;
> 
> Maybe using different names and slightly different semantics for the
> return values would clear some of this up?
> 
> 	if (to_submit) {
> 		submitted = io_ring_submit(ctx, to_submit);
> 		if (submitted < 0)
> 			return submitted;
> 	}
> 	if (flags & IORING_ENTER_GETEVENTS) {
> 		...
> 		ret = io_cqring_wait(ctx, min_complete);
> 	}
> 
> 	return submitted ? submitted : ret;

That would probably make it more readable, I'll make this change.

>> +static int io_sq_offload_start(struct io_ring_ctx *ctx)
> 
>> +static void io_sq_offload_stop(struct io_ring_ctx *ctx)
> 
> Can we just merge these two functions into the callers?  Currently
> the flow is a little odd with these helpers that don't seem to be
> too clear about their responsibilities.

In the initial patch I agree, but with the later thread addition, I like
having it in a separate helper. At least for the start, the top side is
more trivial.

>> +static void io_free_scq_urings(struct io_ring_ctx *ctx)
>> +{
>> +	if (ctx->sq_ring) {
>> +		page_frag_free(ctx->sq_ring);
>> +		ctx->sq_ring = NULL;
>> +	}
>> +	if (ctx->sq_sqes) {
>> +		page_frag_free(ctx->sq_sqes);
>> +		ctx->sq_sqes = NULL;
>> +	}
>> +	if (ctx->cq_ring) {
>> +		page_frag_free(ctx->cq_ring);
>> +		ctx->cq_ring = NULL;
>> +	}
> 
> Why is this using the page_frag helpers?  Also the callers just free
> these ctx structure, so there isn't much of a point zeroing them out.

Why not use the page frag helpers? No point in open-coding it. I can
kill the zeroing, double call would be a bug anyway.

> Also I'd be tempted to open code the freeing in io_allocate_scq_urings
> instead of caling the helper, which would avoid the NULL checks and
> make the error handling code a little more obvious.

OK

>> +	if (mutex_trylock(&ctx->uring_lock)) {
>> +		ret = __io_uring_enter(ctx, to_submit, min_complete, flags);
> 
> do we even need the separate __io_uring_enter helper?

I like having it nicely separated.

>> +static void io_fill_offsets(struct io_uring_params *p)
> 
> Do we really need this as a separate helper?

That does seem pointless, folded in.

-- 
Jens Axboe

