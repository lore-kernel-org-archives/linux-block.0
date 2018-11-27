Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A0C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCF420817
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WBUSLvr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCF420817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeK1CXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:23:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37333 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeK1CXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 21:23:01 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so34481349iti.2
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 07:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=syA7u6k7dqF96sPF8nqr4ihZTpHJJRUxmYvKChCJBHA=;
        b=WBUSLvr1olJGRexYe77A+Oo/J7UeB23cBwIwUxGO1pRbvTN3ANA/7rx/Nba2HsJTQY
         WGLmdyjaosUJ+7Soo2aR1/jwXH6EJyk5ePrrvKji4uEuCWb95mlEE+f1tWCD0MjYSOgi
         jlMBXb7yGoQRzl53h93tarKgA4dF7jEl1PzpuBIHr9ULiPPTMd5P6V6ntZIVl1gt8o7l
         jdnFwBRy9axZ02QPUnqCQB3nsRR+kVqJHGv4pvb5C/9GW/N/bBlec9+77+5VoK1UxfD9
         2SWWe+rhYETVgH2XiooobZo/NEPLWNuSRJBFAZKT/cgnT/+ooV5+FDbtZQHSGSUvZsAm
         A5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=syA7u6k7dqF96sPF8nqr4ihZTpHJJRUxmYvKChCJBHA=;
        b=TGW3CJvXQUQGZ/5jUg3FlU6E1wKZlR2jY0lj7CjNqaN4vnjy5OWuN3B80PHZYRi1Di
         yZgaiuL1ykz9MqTqpWEIgAV/LPJDd77g+RsKOr8yHrqXIBKIlrrz5YUMSu3ca2GQLDdX
         cQUOA5pg99JuFLwNHmY3p1ARA+O058fe72VbsUXagTXVt1FrspaLDq8gUAYzHZqB361J
         VVc5aBW/fWCK/H5zVOQ5/QjqkdDpyBeolgzHk51W6VphBn7X2X6w+iAHV9y6Jldnd0BK
         zmAJcilY52ZnsJbfxqMcXpBbpd862hAfChLwsDMsd3AioMOYSOoLqG2U5klVwMcSKk3d
         ADGA==
X-Gm-Message-State: AA+aEWY+VnlYWYw0FovtoYSERod4oWS0cl9GaLTPXnzdOKcIViiKSniw
        wzdoKNxNggXDVbfemAD0zkvrIQ==
X-Google-Smtp-Source: AFSGD/XT3JnzK7AAinH4pCNP5WBILSOdaZp3Bs0IHAhkFfdCxhQ6JhGDTqb8TXaiJ/jy6gqfW0befg==
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr16498674itl.83.1543332285759;
        Tue, 27 Nov 2018 07:24:45 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c10sm1400070iok.23.2018.11.27.07.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 07:24:44 -0800 (PST)
Subject: Re: [PATCH 17/20] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181126164544.5699-1-axboe@kernel.dk>
 <20181126164544.5699-18-axboe@kernel.dk>
 <69acea804eaf71f2d05b6ab649ecbf9bfd026447.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a58a7fd3-7994-0e30-40f7-f990a162205f@kernel.dk>
Date:   Tue, 27 Nov 2018 08:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <69acea804eaf71f2d05b6ab649ecbf9bfd026447.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 2:53 AM, Benny Halevy wrote:
>> @@ -818,11 +853,15 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
>>  {
>>  	struct kioctx_table *table;
>>  
>> +	mutex_lock(&ctx->getevents_lock);
>>  	spin_lock(&mm->ioctx_lock);
>>  	if (atomic_xchg(&ctx->dead, 1)) {
>>  		spin_unlock(&mm->ioctx_lock);
>> +		mutex_unlock(&ctx->getevents_lock);
>>  		return -EINVAL;
>>  	}
>> +	aio_iopoll_reap_events(ctx);
>> +	mutex_unlock(&ctx->getevents_lock);
> 
> Is it worth handling the mutex lock and calling aio_iopoll_reap_events
> only if (ctx->flags & IOCTX_FLAG_IOPOLL)?  If so, testing it can be
> removed from aio_iopoll_reap_events() (and maybe it could even
> be open coded
> here since this is its only call site apparently)

I don't think it really matters, this only happens when you tear down an
io_context. FWIW, I think it's cleaner to retain the test in the
function, not outside it.

>> @@ -1072,6 +1112,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
>>  	}
>>  }
>>  
>> +static void iocb_put_many(struct kioctx *ctx, void **iocbs, int *nr)
>> +{
>> +	if (nr) {
> 
> How can nr by NULL?
> And what's the point of supporting this case?
> Did you mean: if (*nr)?
> (In this case, if safe to call the functions below with *nr==0,
> I'm not sure it's worth optimizing... especially since this is a static
> function and its callers make sure to call it only when *nr > 0)

Indeed, that should be if (*nr), thanks! The slub implementation of the
bulk free complains if you pass in nr == 0. Outside of that, a single
check should be better than checking in multiple spots.

>> @@ -1261,6 +1310,166 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
>>  	return ret < 0 || *i >= min_nr;
>>  }
>>  
>> +#define AIO_IOPOLL_BATCH	8
>> +
>> +/*
>> + * Process completed iocb iopoll entries, copying the result to userspace.
>> + */
>> +static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
>> +			    unsigned int *nr_events, long max)
>> +{
>> +	void *iocbs[AIO_IOPOLL_BATCH];
>> +	struct aio_kiocb *iocb, *n;
>> +	int to_free = 0, ret = 0;
>> +
>> +	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
>> +		if (*nr_events == max)
> 
> *nr_events >= max would be safer.

I don't see how we can get there with it being larger than already, that
would be a big bug if we fill more events than userspace asked for.

>> @@ -1570,17 +1829,43 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
>>  	default:
>>  		req->ki_complete(req, ret, 0);
>>  	}
>> +
> 
> nit: this hunk is probably unintentional

Looks like it, I'll kill it.


-- 
Jens Axboe

