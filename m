Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C482C282C7
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 05:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754E62087F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 05:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548911523;
	bh=GIje4IagvFcLkyQY0xZUYSVnN7ly4UjDIjgrcQoAReY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vrMy6o2gp+bm8Ok61PdyQ3Ivw+kaxYfxxEBKLbRN6E67cUhN45/zUJ+9iI617aBo+
	 FGDlkyelQtqwZpbXqkzL8xKdXry2uK/2KOllWCSJ/XhcrU7tCVWrHAULFnIeVlC1sP
	 MY1lN8eZIVlGDLB0bBBWqA8yPo4RSOLeu9akmUSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfAaFMC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfAaFMC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 00:12:02 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C325F218DA
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 05:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548911521;
        bh=GIje4IagvFcLkyQY0xZUYSVnN7ly4UjDIjgrcQoAReY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DQbVybqI8QhBEjIAfpyp4rEMBIn8yucQ1RMiXjryFMZ575twk+EVkAnYIu5S17OGQ
         L1FrQUa+V9aiYS6x4rOvMySZy8nfM+NuFF6B55UO+/k0/4xUVMsl6DBtvGMRT/ht6g
         LVZMMW0HLNvw1JEysUn4IeQKC+OC+Mul1FoWjeqY=
Received: by mail-wm1-f45.google.com with SMTP id m22so1084681wml.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 21:12:00 -0800 (PST)
X-Gm-Message-State: AJcUukc2ndn7N+/S2bFMuirBwclt9SWW1sxHFRY/jMEqMXB7cXOUfmnx
        mQK/CBzQXvZSB3rxlwjdWd4u0Q3ibvVXtqpPnUzCNA==
X-Google-Smtp-Source: ALg8bN4MMxZVBzAEq8mD387Va/Xm33kI65QtmHg324U84VkFfNFRU8aR3W/UlI7gm+muezmTxbrOaPFp/l7mAQvVXsc=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr29293975wmf.32.1548911519071;
 Wed, 30 Jan 2019 21:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de> <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
 <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk>
In-Reply-To: <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Jan 2019 21:11:46 -0800
X-Gmail-Original-Message-ID: <CALCETrVwHcWcJB4r=14=uB2NHGasW+rRRWVoun6-UY_t3+AU2A@mail.gmail.com>
Message-ID: <CALCETrVwHcWcJB4r=14=uB2NHGasW+rRRWVoun6-UY_t3+AU2A@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>> On Jan 28, 2019, at 5:20 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 1/28/19 5:47 PM, Andy Lutomirski wrote:
>>> On Mon, Jan 28, 2019 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> [please make sure linux-api and linux-man are CCed on new syscalls
>>> so that we get API experts to review them]
>>
>>>> +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>>>> +                        const struct io_uring_sqe *sqe,
>>>> +                        struct iovec **iovec, struct iov_iter *iter)
>>>> +{
>>>> +     void __user *buf = u64_to_user_ptr(sqe->addr);
>>>> +
>>>> +#ifdef CONFIG_COMPAT
>>>> +     if (ctx->compat)
>>>> +             return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
>>>> +                                             iovec, iter);
>>>> +#endif
>>>
>>> I think we can just check in_compat_syscall() here, which means we
>>> can kill the ->compat member, and the separate compat version of the
>>> setup syscall.
>>
>> Since this whole API is new, I don't suppose you could introduce a
>> struct iovec64 or similar and just make the ABI be identical for
>> 64-bit and 32-bit code?
>
> Sure, that would be straight forward. Is there a strong reason to do
> so outside of "that would be nice"? It's not like it's a huge amount
> of code.

Here are some minor-ish benefits:

 - It avoids having a code path that is only used with 32 bit code on
64 bit kernels and is therefore rarely tested.  (In this particular
case, the code path doesn't diverge much, but for most compat
syscalls, it's almost an entirely separate implementation of the main
syscall code.)

 - It makes life easier for tools like strace.

 - It minimizes the chance of making a giant mess on x32, which isn't
really native or compat.

--Andy
