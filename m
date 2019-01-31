Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68657C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385C020820
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ot3P9fPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfAaQhq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:37:46 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38932 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388247AbfAaQhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 11:37:46 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so5119320itl.4
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HogKsjFM1RZLoSPhgHJQqjbm0LmXrQ4cXp8pXGs9D5I=;
        b=Ot3P9fPL6XD0yQanjnOz9EYLVLL9z4BUI/t5V2MS5rVm271pr+Q/hBmu4S4ETqkZyC
         bUlrvPREcAdmEhZ3KXX/aaMypbC3+lt0vulyxU1W868gseEk+hfqDkVd1hA/BZzzyYXP
         TNf9p3zgHchO+8z3+NR7o6n972plY9pMbO32q85xeWurXwuWlb3c5fJ70v+RjtlO76VY
         g8av62mo6DqStUaVR7rOx1lM7yEAH1GNmu9MBUA0Ro3+qXWT5jJMdJ3lQ3Lh/kzrG9Ra
         aA8MXSZYAbhcvaOvlJJzjaPd8rTzwWgTzBOhN/2R5JlrOJXxuNi6gHnY8eaJA88BsF9B
         yVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HogKsjFM1RZLoSPhgHJQqjbm0LmXrQ4cXp8pXGs9D5I=;
        b=ANOrh4SGhy6QqW5hH+lfzsPGpc6LW0TxsxXnAc/u6H4BL0/0z/Q/SwAKPCbVREQn4R
         wXsSJwG3yWSOe+w3SCbeu2OPVOr4+fmv4htRxLYiXWiSWZnlVV4Wt9OlGx1qR2JwXGZi
         ed5YaVPmBtZiSt1wXOScZve+Q1wIOjDsbz9FDJ8nYOwEenXVqFNUy253YL08/sZoFN+z
         TlhHF3nTA49/tmSBG8Y/MCZYzdOBNKUXYGewVUsN53SKnKZahzjmRXxexnNd4/N4c5hp
         9qYy/3KyUgkICEBkqyizYnuLVfzTH0Q4EHzuColwXPnoFWIhuDoXH3SuH0L4rhjdJpQu
         Mvxg==
X-Gm-Message-State: AHQUAuaa8xKyulLnqM8pSAwlWVD+G8jpjrzQe4kpwgGhf9vlq6Ohba01
        Ik81MM3awQP5rorSgRP19lrVGA==
X-Google-Smtp-Source: AHgI3IaAwqDN1EqK4sPe2+4Dl2f0uBB9wjNva1MbfJjocXmRfmV33TJSF0K7l6lLtZipYhqfjpFFDA==
X-Received: by 2002:a24:d745:: with SMTP id y66mr5913245itg.18.1548952664891;
        Thu, 31 Jan 2019 08:37:44 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i135sm3179354iti.34.2019.01.31.08.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 08:37:43 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
 <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
 <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk>
 <CALCETrVwHcWcJB4r=14=uB2NHGasW+rRRWVoun6-UY_t3+AU2A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <58f458d1-f2fd-5d7c-974a-06b35701d92d@kernel.dk>
Date:   Thu, 31 Jan 2019 09:37:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVwHcWcJB4r=14=uB2NHGasW+rRRWVoun6-UY_t3+AU2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 10:11 PM, Andy Lutomirski wrote:
>>>> On Jan 28, 2019, at 5:20 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 1/28/19 5:47 PM, Andy Lutomirski wrote:
>>>> On Mon, Jan 28, 2019 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> [please make sure linux-api and linux-man are CCed on new syscalls
>>>> so that we get API experts to review them]
>>>
>>>>> +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>>>>> +                        const struct io_uring_sqe *sqe,
>>>>> +                        struct iovec **iovec, struct iov_iter *iter)
>>>>> +{
>>>>> +     void __user *buf = u64_to_user_ptr(sqe->addr);
>>>>> +
>>>>> +#ifdef CONFIG_COMPAT
>>>>> +     if (ctx->compat)
>>>>> +             return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
>>>>> +                                             iovec, iter);
>>>>> +#endif
>>>>
>>>> I think we can just check in_compat_syscall() here, which means we
>>>> can kill the ->compat member, and the separate compat version of the
>>>> setup syscall.
>>>
>>> Since this whole API is new, I don't suppose you could introduce a
>>> struct iovec64 or similar and just make the ABI be identical for
>>> 64-bit and 32-bit code?
>>
>> Sure, that would be straight forward. Is there a strong reason to do
>> so outside of "that would be nice"? It's not like it's a huge amount
>> of code.
> 
> Here are some minor-ish benefits:
> 
>  - It avoids having a code path that is only used with 32 bit code on
> 64 bit kernels and is therefore rarely tested.  (In this particular
> case, the code path doesn't diverge much, but for most compat
> syscalls, it's almost an entirely separate implementation of the main
> syscall code.)
> 
>  - It makes life easier for tools like strace.
> 
>  - It minimizes the chance of making a giant mess on x32, which isn't
> really native or compat.

Not really anything major here, at least not to the extent that
suffering the pain of having a different iovec for this is warranted.

-- 
Jens Axboe

