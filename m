Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E8CC282D0
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF31621841
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548722880;
	bh=OKJP5Fh5DztKDHQi6SW3nU2kmEAGSW82rURwNmcmePU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EOx9+AkQzGahq+9KaZR1TRDBKl47yurTp6nBgNpSRTY7nfoaEjOQEoHFXZTMpnLfi
	 HZlhEKMcLJ1xgODvB17shRHGTTZJYoeDJEuJWuOhP1e0oNnso+8Zj/qhSbM9xwEDyP
	 begZyqqdanZTHZIShrmRWYfNtNqztHDLAAP4OrcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfA2Ar6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfA2Ar6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 19:47:58 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A5D7217F5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 00:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548722877;
        bh=OKJP5Fh5DztKDHQi6SW3nU2kmEAGSW82rURwNmcmePU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V9yQpe230gungDosKrbnJtMwffL0tdeJPYl9OzlXv36sNez7hz/1dAC95cSiHz+bv
         Aixv3wtqaDIQW3fPjbadRCqU6s8H2Y0pwVWMEOYgIxiHoliQ2IEkJWYGEMLasEswO0
         8nChADoxumvxHGiwf09sxNN8sysV9z8rSCdysRF8=
Received: by mail-wr1-f49.google.com with SMTP id q18so20151971wrx.9
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 16:47:57 -0800 (PST)
X-Gm-Message-State: AJcUukd/uJckUz82+lGJSOwYQm+173fJI/1cG3whtOVBFOuT5w0LPIn2
        JhHBjYUt1Y9W8uTYl53g91owwACKa2AEL3Jd4tLvjA==
X-Google-Smtp-Source: ALg8bN6mc85CXp3I4XBLdUV/FPj7/ypCdXQxO73ptgzmwRGSAO8RzBvfBcwIsABpAvh9KYxAjghLDVZEN5BDHQQjhAs=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr22737786wro.77.1548722875714;
 Mon, 28 Jan 2019 16:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de>
In-Reply-To: <20190128145700.GA9795@lst.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 28 Jan 2019 16:47:42 -0800
X-Gmail-Original-Message-ID: <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
Message-ID: <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
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

On Mon, Jan 28, 2019 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> [please make sure linux-api and linux-man are CCed on new syscalls
> so that we get API experts to review them]

> > +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
> > +                        const struct io_uring_sqe *sqe,
> > +                        struct iovec **iovec, struct iov_iter *iter)
> > +{
> > +     void __user *buf = u64_to_user_ptr(sqe->addr);
> > +
> > +#ifdef CONFIG_COMPAT
> > +     if (ctx->compat)
> > +             return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
> > +                                             iovec, iter);
> > +#endif
>
> I think we can just check in_compat_syscall() here, which means we
> can kill the ->compat member, and the separate compat version of the
> setup syscall.
>

Since this whole API is new, I don't suppose you could introduce a
struct iovec64 or similar and just make the ABI be identical for
64-bit and 32-bit code?

--Andy
