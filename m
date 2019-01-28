Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59794C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 23:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2347A2171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 23:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v6ODMQpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfA1XuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:50:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46625 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfA1XuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 18:50:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so8459136ply.13
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 15:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ne5qLhfPQY9Q08DUBwLNL8BdHuA1uJ8INqGL1j9PAdI=;
        b=v6ODMQpCyZAGjyrd2W3iqFEzfzo/ug2RPa2NC6SybL+9CDk+Rb9d/MDoH9ac0gd+dk
         +aJNY1IhaRaMG0z2wKaF3bPW9uzwJ8rVyOeXo8qRPBnQnN/o98jbNYUWYV+8vnHfMps8
         0Y56VFXfl9MPGEWbx2J3dzFTVJUIFp+PdmKELjL6S0yRzQIg5RBPp7Hsae9Ue+/zpenp
         Ryip9CO/I9TtDpEKz9EYgwCrWZkzy9M0v68WP1eoQ4UtFLYtoc8pbXn3BZYbxRG6fC5c
         gYSx+6S4u7K6Y2mn9jKe/1VxgZg/5HgOtN0VdfrqL02gkIx0Cc4Q7qLanaV16qG6MUvj
         j5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ne5qLhfPQY9Q08DUBwLNL8BdHuA1uJ8INqGL1j9PAdI=;
        b=g50PgbFP4qCtb/dzdj9T/lfc1dn6FEQXfblUIfp2wifOLKhgz917l0lM3MufpKHym5
         iZf4Xz0jfkWdw8YwhgrpwbwClHSCFAwioqo0r6POtVMKyCYcDNEfFU8BJFThVD44XYZQ
         8gjTEMQGd40A4PKQWe5DvjGbFjT06p4We5bDCZnTuLMkzonD16ehbfNDbrDfvIa9l1O4
         vYZL+aRFoZdxaBYObtqC1PoaVo/jg8Ks4bt7fFCTfJfsUJqvBhIks+f8IGKu6Id3eMYj
         R918ImC6HwCXsHMoiFwfi0fm4e4U+DoGyGH5SrLA+/nVp1ROfdg+vrkOhchMuGl2L6OE
         IwqA==
X-Gm-Message-State: AJcUukd8DFtRr92liZ51K+20q2mhfReauFhOLpc4HIy3r0ahK+2143xM
        XKHo6m95D89/P3TBmyCxqw2F2g==
X-Google-Smtp-Source: ALg8bN7ImMDCPPlstiFL0tmzFZ4zlrBnCRb41zMu0Fo31XVQaWVh0rb5A4qFjdyGJHlIQke/LRxbHw==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr23961437plp.336.1548719421723;
        Mon, 28 Jan 2019 15:50:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y5sm58442325pge.49.2019.01.28.15.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:50:20 -0800 (PST)
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO
 buffers
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-13-axboe@kernel.dk>
 <CAG48ez3cJS=RUqyP630du3pNw_wBdM82KOtbX=YY6U4LxfMBew@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb243bfc-0e3a-d5a4-3087-90af1a1824a0@kernel.dk>
Date:   Mon, 28 Jan 2019 16:50:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3cJS=RUqyP630du3pNw_wBdM82KOtbX=YY6U4LxfMBew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 4:35 PM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>> If we have fixed user buffers, we can map them into the kernel when we
>> setup the io_context. That avoids the need to do get_user_pages() for
>> each and every IO.
> [...]
>> +static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
>> +                              void __user *arg, unsigned nr_args)
>> +{
>> +       int ret;
>> +
>> +       /* Drop our initial ref and wait for the ctx to be fully idle */
>> +       percpu_ref_put(&ctx->refs);
> 
> The line above drops a reference that you just got in the caller...

Right

>> +       percpu_ref_kill(&ctx->refs);
>> +       wait_for_completion(&ctx->ctx_done);
>> +
>> +       switch (opcode) {
>> +       case IORING_REGISTER_BUFFERS:
>> +               ret = io_sqe_buffer_register(ctx, arg, nr_args);
>> +               break;
>> +       case IORING_UNREGISTER_BUFFERS:
>> +               ret = -EINVAL;
>> +               if (arg || nr_args)
>> +                       break;
>> +               ret = io_sqe_buffer_unregister(ctx);
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>> +       }
>> +
>> +       /* bring the ctx back to life */
>> +       reinit_completion(&ctx->ctx_done);
>> +       percpu_ref_resurrect(&ctx->refs);
>> +       percpu_ref_get(&ctx->refs);
> 
> And then this line takes a reference that the caller will immediately
> drop again? Why?

Just want to keep it symmetric and avoid having weird "this function drops
a reference" use cases.

> 
>> +       return ret;
>> +}
>> +
>> +SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>> +               void __user *, arg, unsigned int, nr_args)
>> +{
>> +       struct io_ring_ctx *ctx;
>> +       long ret = -EBADF;
>> +       struct fd f;
>> +
>> +       f = fdget(fd);
>> +       if (!f.file)
>> +               return -EBADF;
>> +
>> +       ret = -EOPNOTSUPP;
>> +       if (f.file->f_op != &io_uring_fops)
>> +               goto out_fput;
>> +
>> +       ret = -ENXIO;
>> +       ctx = f.file->private_data;
>> +       if (!percpu_ref_tryget(&ctx->refs))
>> +               goto out_fput;
> 
> If you are holding the uring_lock of a ctx that can be accessed
> through a file descriptor (which you do just after this point), you
> know that the percpu_ref isn't zero, right? Why are you doing the
> tryget here?

Not sure I follow... We don't hold the lock at this point. I guess your
point is that since the descriptor is open (or we'd fail the above
check), then there's no point doing the tryget variant here? That's
strictly true, that could just be a get().

-- 
Jens Axboe

