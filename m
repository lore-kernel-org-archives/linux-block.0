Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38377C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AE120855
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v+NGDjYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfA2SNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40695 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfA2SNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:12 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so5987154ita.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C40f7+peY6w5mvyaWpnAy7JQF8XqN58gt2y8A9YBkgY=;
        b=v+NGDjYgOaLrg11x980feJBeq0JTdUA57w7oks3MQXuz8kmr1tog7ZL99YqT5qoMTf
         ll32MBmb4mh1NuXGZO+/T0FhK6W0Ml4nPrr/H/t49+mdHn6JiDZ+TUvrjF+7ty2Himk/
         RIkEWYNnCHEP3RbL6mOM7jOa5W9JjJOU/v4a5mN0Ig4M5bjWK1XLaWH6bDE7pcAY/tbe
         XAY4Puvfjbk8lFCcs3H1jO7ISyrPTNGyj5r0ppDxR8+aMtpKF6VasyIHqg9da7PiuDSc
         P7V3qSADQf8mP2fSzvx9EcirHKHK4Nsx8y9qieBHd5oo9mMaQdn1uYtAfBpCpjPnqpIU
         TTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C40f7+peY6w5mvyaWpnAy7JQF8XqN58gt2y8A9YBkgY=;
        b=qBMHLKXorF1C5x+fozGJkh7T/dRSTCFRiZ4gvFeBw5kHJ0RAnbnXS5o/cRpXiqaT/T
         ygZXtesnnoX/LEeZjZSGitdMcIls/Q7EjeWm/JKRo2I9S057RD8dn3JERoRtnMFbWNAd
         R2C+f95XBtQBUsoGIN0n1c4ceko37Ry259kYfFjl2LHiO9prsX7RZdWoYuau8IrN6IEh
         +cDXgUIF3Zky6Vi+ctQsLBxy8XbbH6c0jdpkfAKrpr6MkK9i5ejfDgC6d7YRMsa98jGM
         cYhO4CyKhADXvE+1x8xjgcpP7v0+IAcNyXY5ItiUKD/PePXOmdT7B7gxXQvB8k7ejkJg
         W2jw==
X-Gm-Message-State: AJcUukf6Vqzhr193KKfnzEJhFP9Ny4yXoxidVtLpS3DsVk1u5B+b0O80
        YrTtCD1UgZk4N4Lll2te0he1uw==
X-Google-Smtp-Source: ALg8bN65TJ4mymj6Tidf4XPCrfJBEOHqWxEuSfI0JfQI4a0BrEbr/VR4d6EzgCZUUX9MLQf7qs5RoQ==
X-Received: by 2002:a02:c943:: with SMTP id u3mr3826084jao.96.1548785591020;
        Tue, 29 Jan 2019 10:13:11 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15157336iol.55.2019.01.29.10.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:13:09 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-14-axboe@kernel.dk>
 <CAG48ez2tYBePMCkd-EOdAX1gfVwPJ-fTd-8XKu6J-QPyTXHN9g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2241050-5f7a-862e-0c26-a19059f3d432@kernel.dk>
Date:   Tue, 29 Jan 2019 11:13:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2tYBePMCkd-EOdAX1gfVwPJ-fTd-8XKu6J-QPyTXHN9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 9:36 AM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>> We normally have to fget/fput for each IO we do on a file. Even with
>> the batching we do, the cost of the atomic inc/dec of the file usage
>> count adds up.
>>
>> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
>> for the io_uring_register(2) system call. The arguments passed in must
>> be an array of __s32 holding file descriptors, and nr_args should hold
>> the number of file descriptors the application wishes to pin for the
>> duration of the io_uring context (or until IORING_UNREGISTER_FILES is
>> called).
>>
>> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
>> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
>> to the index in the array passed in to IORING_REGISTER_FILES.
>>
>> Files are automatically unregistered when the io_uring context is
>> torn down. An application need only unregister if it wishes to
>> register a few set of fds.
> 
> s/few/new/ ?

Indeed, thanks.

>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 682714d6f217..77993972879b 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -98,6 +98,10 @@ struct io_ring_ctx {
>>                 struct fasync_struct    *cq_fasync;
>>         } ____cacheline_aligned_in_smp;
>>
>> +       /* if used, fixed file set */
>> +       struct file             **user_files;
>> +       unsigned                nr_user_files;
> 
> It'd be nice if you could add a comment about locking rules here -
> something like "writers must ensure that ->refs is dead, readers must
> ensure that ->refs is alive as long as the file* is used".

Will add.

> [...]
>> @@ -612,7 +625,14 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>         struct kiocb *kiocb = &req->rw;
>>         int ret;
>>
>> -       kiocb->ki_filp = io_file_get(state, sqe->fd);
>> +       if (sqe->flags & IOSQE_FIXED_FILE) {
>> +               if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
>> +                       return -EBADF;
>> +               kiocb->ki_filp = ctx->user_files[sqe->fd];
> 
> It doesn't really matter as long as ctx->nr_user_files<=INT_MAX, but
> it'd be nice if you could explicitly cast sqe->fd to unsigned here.

OK, will do.

>> +               req->flags |= REQ_F_FIXED_FILE;
>> +       } else {
>> +               kiocb->ki_filp = io_file_get(state, sqe->fd);
>> +       }
> [...]
>> +static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>> +                                unsigned nr_args)
>> +{
>> +       __s32 __user *fds = (__s32 __user *) arg;
>> +       int fd, i, ret = 0;
>> +
>> +       if (ctx->user_files)
>> +               return -EBUSY;
>> +       if (!nr_args)
>> +               return -EINVAL;
>> +
>> +       ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
>> +       if (!ctx->user_files)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < nr_args; i++) {
>> +               ret = -EFAULT;
>> +               if (copy_from_user(&fd, &fds[i], sizeof(fd)))
>> +                       break;
> 
> "i" is signed, but "nr_args" is unsigned. You can't get through that
> kcalloc() call with nr_args>=0x80000000 on a normal kernel, someone
> would have to set CONFIG_FORCE_MAX_ZONEORDER really high for that, but
> still, in theory, if you reach this copy_to_user(..., &fds[i], ...)
> with a negative "i", that'd be bad. You might want to make "i"
> unsigned here and check that it's at least smaller than UINT_MAX...

Done.

Thanks for your review!

-- 
Jens Axboe

