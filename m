Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BAFC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A78214DA
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t5nN4+VU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A78214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeKVAA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:00:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39003 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeKVAA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 19:00:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so5555506pla.6
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 05:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Nt+R4/AXRMSguIBnrZpDPuB1omlB0egUfPI+wT7/Dhk=;
        b=t5nN4+VUW0CGgVa9tJE1OqVWkeGbm59eUtoyms0g+TeYNKDSM71XFrD5xvi9SnTbXD
         3Lp20u3wQEhSwumWQ7+fXV5k9M+qxJAZqv3OXR0Wt+2Ej9JD8DF7PLKlK2zIJjrWI8dO
         zSfI38EAYAxMUnSXclWT0rBDA0fkQJ9CTEiVjNLkhby2dMue1UB8IrT2TlxAs/OOSX+M
         xCmhhwNJp0Lc0pt9UIu36NZAmgXBpiCjESuB09XeTygYkOh21xBQh9i0jia+dEvqCgij
         1UyQPLuh6zsjaecXbRl3ZjnQhF8t+u/OR087qML+truscYAWmei8jSqeLU+aAZbSup/M
         ZRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nt+R4/AXRMSguIBnrZpDPuB1omlB0egUfPI+wT7/Dhk=;
        b=AOhsRfWZm49xNHK04Vx7dcUaru+S0578leOmUJXcxiRHDljraC7hQjdmf3UWZHXFG1
         Cbt3IThIJXt4ow7WLzSiqxqxRDYhame5uv4qU3n6qJt1qYoNB7dKKs1zu/2wsyCVQvvk
         RnP8F9l6af1i/VUW1wh1Gt9HWWT1RtKOonfiCPuIWU7GkQ9JuPSy2Z+M++JWr9ulZ4zL
         2yZytNT+5warFQI9uMGQmrlRZ2pELtomSQWfLkWAfADpBgTlrF0NSXge2i5jqYrqiV20
         7Xf69GajBj+xe2+d+zx6ukYQhAHkMihtXkzyBCRewFq9jnBAPi7FTfkoMRojCDXhEmKZ
         /OfQ==
X-Gm-Message-State: AA+aEWYRJGCCDCIqkMczq4mKK1mfAK4efIkddwPkoTIMwlhufRG7YrSg
        wBltVP87o6/x225QML1kRGjnsA==
X-Google-Smtp-Source: AFSGD/X8X2KbUDQcQ/IpmzzjGtAVE5UaoZW1d7DY5q1iUxWTdfEg4xkO8ezQCO2Y/NilDFDT8Lh1lg==
X-Received: by 2002:a63:d157:: with SMTP id c23mr5937341pgj.170.1542806793357;
        Wed, 21 Nov 2018 05:26:33 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z14sm34543389pgv.47.2018.11.21.05.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 05:26:32 -0800 (PST)
Subject: Re: [PATCH 8/8] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
References: <20181120171953.1258-1-axboe@kernel.dk>
 <20181120171953.1258-9-axboe@kernel.dk>
 <c3066246445a9f303d3d46f6a3274944093e78e8.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb9d0381-eeaa-a67b-ea30-43525ee1fc3e@kernel.dk>
Date:   Wed, 21 Nov 2018 06:26:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c3066246445a9f303d3d46f6a3274944093e78e8.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/18 4:12 AM, Benny Halevy wrote:
>> +#define AIO_POLL_STACK	8
>> +
>> +/*
>> + * Process completed iocb iopoll entries, copying the result to userspace.
>> + */
>> +static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
>> +			    unsigned int *nr_events, long max)
>> +{
>> +	void *iocbs[AIO_POLL_STACK];
>> +	struct aio_kiocb *iocb, *n;
>> +	int to_free = 0, ret = 0;
> 
> To be on the safe side, how about checking that if (evs)
> *nr_events < max, otherwise, return -EINVAL?

Good point, I think we should re-arrange the loop a bit to move the
check up at the top to guard for entries == max at entry. I've done
that.

>> +	/*
>> +	 * Take in a new working set from the submitted list if possible.
>> +	 */
>> +	if (!list_empty_careful(&ctx->poll_submitted)) {
>> +		spin_lock(&ctx->poll_lock);
>> +		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
>> +		spin_unlock(&ctx->poll_lock);
>> +	}
>> +
>> +	if (list_empty(&ctx->poll_completing))
>> +		return 0;
> 
> Could be somewhat optimized like this:
> 
> 	if (list_empty_careful(&ctx->poll_submitted))
> 		return 0;
> 
> 	spin_lock(&ctx->poll_lock);
> 	list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> 	spin_unlock(&ctx->poll_lock);
> 	if (list_empty(&ctx->poll_completing))
> 		return 0;
> 
> Or, possibly...
> 	if (list_empty_careful(&ctx->poll_submitted) ||
> 	    ({
> 		spin_lock(&ctx->poll_lock);
> 		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> 		spin_unlock(&ctx->poll_lock);
> 		list_empty(&ctx->poll_completing);
> 	    }))
> 		return 0;

I think the readability of the existing version is better.

>> +	/*
>> +	 * Check again now that we have a new batch.
>> +	 */
>> +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (*nr_events >= min)
>> +		return 0;
>> +
>> +	/*
>> +	 * Find up to 'max_nr' worth of events to poll for, including the
> 
> What's max_nr? You mean 'max'?

It should, corrected.

>> +	 * events we already successfully polled
>> +	 */
>> +	polled = to_poll = 0;
>> +	poll_completed = atomic_read(&ctx->poll_completed);
>> +	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
>> +		/*
>> +		 * Poll for needed events with wait == true, anything after
>> +		 * that we just check if we have more, up to max.
>> +		 */
>> +		bool wait = polled + *nr_events >= min;
>> +		struct kiocb *kiocb = &iocb->rw;
>> +
>> +		if (test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
>> +			break;
>> +		if (++to_poll + *nr_events >= max)
>> +			break;
>> +
>> +		polled += kiocb->ki_filp->f_op->iopoll(kiocb, wait);
> 
> Could iopoll return a negative value? (Currently not in this patchset,
> but would it be possible in the future?)

That's a good point, I've added a separate check for this. Given that
it's a regular fops handler, it should be perfectly valid to return
-ERROR.

>> +		if (polled + *nr_events >= max)
>> +			break;
>> +		if (poll_completed != atomic_read(&ctx->poll_completed))
>> +			break;
>> +	}
>> +
>> +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (*nr_events >= min)
>> +		return 0;
>> +	return to_poll;
> 
> What does the returned value mean?
> If the intention is only to return a value greater than zero,
> how about just returning to_poll > 0?

It just means that you could call us again, if > 0, and < 0 is an error
specifically.

>> +/*
>> + * We can't just wait for polled events to come to us, we have to actively
>> + * find and complete them.
>> + */
>> +static void aio_iopoll_reap_events(struct kioctx *ctx)
>> +{
>> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
>> +		return;
>> +
>> +	while (!list_empty_careful(&ctx->poll_submitted) ||
>> +	       !list_empty(&ctx->poll_completing)) {
>> +		unsigned int nr_events = 0;
>> +
>> +		__aio_iopoll_check(ctx, NULL, &nr_events, 1, UINT_MAX);
> 
> BUG_ON(__aoi_iopoll_check() < 0) ?

Ho hum...

>> +	}
>> +}
>> +
>> +static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
>> +			    struct io_event __user *event)
>> +{
>> +	unsigned int nr_events = 0;
>> +	int ret = 0;
>> +
>> +	/* * Only allow one thread polling at a time */
> 
> nit: extra '* '

Removed.

Thanks for your review!

-- 
Jens Axboe

