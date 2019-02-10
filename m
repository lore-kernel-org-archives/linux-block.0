Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC1C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 14:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB5121773
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="s8aKKDCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfBJOTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 09:19:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBJOTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 09:19:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3735719pgc.12
        for <linux-block@vger.kernel.org>; Sun, 10 Feb 2019 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ls7h6vqlastgQPZbndUEexocCTzjSStbcE4DbAMhi1M=;
        b=s8aKKDCxp6w4Kmx9rKU3rlFodholgPiCIO2sPczzid7zKcT9sX2lUKpsBQls5XzOQN
         dg6dMmCFSpiRCPeWDhd51s+btYMevp9Bj68TakdaGVAtO9qnmr1QMbBCwmXJXMx/jF+H
         V+ShmEDuIveyt8EfHF3UFAZ6kdWIPFOO5fKvM0CT/svw3BE4tfC37Yvxxg5qImt98J7v
         QbHeRgxiwEWi21mBu4pXotcDVWnvbMKV7f9JhMj1PgYCZSrgmxHmQaDZrgP/2Dp2pWzk
         HjzWsj9dzRmw2j+4ZHZlPJUvlT+ic2mmn8dME5++Ppd4cax+A9Ur62LH8PeH+cDniXMs
         W2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ls7h6vqlastgQPZbndUEexocCTzjSStbcE4DbAMhi1M=;
        b=nGBmPEhACvTUObsD5/1f5WtfIHip74YAiQ7ePfkby8e44IFPFJ8TY+1fmKPFaM08xg
         GuKYYWU+13cl6nROGfDCuy326TxssS44EZqj7I9crgGwc8mwKO8vYRvOSj+D6jjZSw8V
         B3Q/bbTl0/PJjv7MIt9z+F1z85NqVCV/4dD7bIPw+xMHG7P8MFvxzKr0lUsQhKpQj3CT
         frMjyQhqoxds72atwYFYFNORxjPhx6BgeOrurVpiXiBfNmPslIGYSUGdLudumM0soOB2
         OUyXxkYgINPCM3QnyzXXL+/1jxpYIi4c1J2G8eZvCxsNyqLbFHZmlXn/VKq+WFpRfi6I
         b53g==
X-Gm-Message-State: AHQUAuZzMyppD0Emac1q5CIh3nCFkugnofzRpFJIxbBKP3347NjMiJrA
        /KmeSB9me0Ssrg3HFSL1xB3wEw==
X-Google-Smtp-Source: AHgI3Ia72mLsXyy+cmr0Lb9XmcXZf4KbJV9dBUaZBEV/JlEYwefgFZZs6l0lmtTwQ1eOT1iCupQO7w==
X-Received: by 2002:a63:2209:: with SMTP id i9mr29750091pgi.325.1549808351175;
        Sun, 10 Feb 2019 06:19:11 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y20sm11645143pfd.161.2019.02.10.06.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 06:19:10 -0800 (PST)
Subject: Re: [PATCH 05/19] Add io_uring IO interface
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk
References: <20190209211346.26060-1-axboe@kernel.dk>
 <20190209211346.26060-6-axboe@kernel.dk>
 <alpine.DEB.2.21.1902101048100.8784@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb713e6b-0fa4-852b-5a94-8e159aea0603@kernel.dk>
Date:   Sun, 10 Feb 2019 07:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902101048100.8784@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/19 5:03 AM, Thomas Gleixner wrote:
> On Sat, 9 Feb 2019, Jens Axboe wrote:
>> +static void io_commit_cqring(struct io_ring_ctx *ctx)
>> +{
>> +	struct io_cq_ring *ring = ctx->cq_ring;
>> +
>> +	if (ctx->cached_cq_tail != READ_ONCE(ring->r.tail)) {
>> +		/* order cqe stores with ring update */
> 
> This lacks a reference to the matching rmb()
> 
>> +		smp_wmb();
>> +		WRITE_ONCE(ring->r.tail, ctx->cached_cq_tail);
>> +		/* write side barrier of tail update, app has read side */
> 
> That's a bit meager. Can you please document the barriers which are paired
> with user space barriers very elaborate?

Agree, I added a lengthier comment at the top of the file to explain the
relationship between the kernel and application barriers.

Also documented all of them explicitly now, or referenced the top
comment.

>> +		if (READ_ONCE(ring->r.head) != READ_ONCE(ring->r.tail))
>> +			break;
>> +
> 
> There are undocumented smp_wmb()'s in 'io_uring: Add submission polling' as
> well. It's really hard to tell where the corresponding barriers are and
> what they are supposed to order.

Fixed those too.

> Especially the barriers which are paired with user space barriers need some
> careful documentation. What are the side effects if user space is missing a
> barrier? Just user space seing unconsistent data or is there something
> which goes the other way round and might cause havoc in the kernel?

The only side effect is that the application may not proceed as quickly
as it should, if it fails to notice a completion event come in. It'll
lead to it calling io_cqring_wait() ultimately, through a system call,
which will then ensure that it makes progress. But it may not have
needed to do that system call at all, if it used the barriers correctly.

I've also added a reference to the liburing git repo which has examples
of how to do it.

Thanks for your comments!

-- 
Jens Axboe

