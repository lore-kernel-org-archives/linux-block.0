Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2404C433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF86661075
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 13:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhKLNwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 08:52:53 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:41639 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhKLNwv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 08:52:51 -0500
Received: by mail-ua1-f46.google.com with SMTP id p37so17231513uae.8
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 05:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUdQZVhiyhie97TXNa+YUpmmFObDGKydL5DM8l6Do+U=;
        b=EUAoZSHSrltihmWeeIR9+Urgn9/H62ebZqciqjoViNd9tOEzURAUKUHQv2hHJmAeF+
         SiWG5E5yjIncG6P6ZAG/9ESCe5eW8PwJiK+R1lfI4ZJARe4XvqVzN0/3V9TpW+Bh+cjH
         ELqQp8FJoISDpqgTfkjQ1tIXH73OqcSGorfE/MMHidCOiXjI15fhAV2VN/8tv/J+gjez
         CXRrCO0B4upwzRdTxeCKbC7DRbR86bNDTokdveDtv/w9La5Fo8ml8TyrHbYsOUrxHM4z
         Z3BpmuyMeH5EKlWpwX2+AIqS44+c9r7L77JU5dNqE9iUKW7I4SYwJDoEl2/Fu/f8Agye
         a2hA==
X-Gm-Message-State: AOAM531oe+CJ7NSrQzf4lcB7wK5nq4k9eeCMefXRZVaUflZdYUym6Cem
        OKm6jOOcweEuBV4Yc4oacDPguWkN2zG8Eg==
X-Google-Smtp-Source: ABdhPJyvqsVLEbFi9xVnjDiS3D98sL58PGl4bbEAcaps0eUslVwdmzN6lJL8MXNoU1MDeqZ0FDNsNw==
X-Received: by 2002:a05:6102:d94:: with SMTP id d20mr10631504vst.12.1636725000353;
        Fri, 12 Nov 2021 05:50:00 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id s22sm3961694vkm.28.2021.11.12.05.49.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 05:49:59 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id p37so17231383uae.8
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 05:49:59 -0800 (PST)
X-Received: by 2002:a9f:2431:: with SMTP id 46mr22724510uaq.114.1636724999518;
 Fri, 12 Nov 2021 05:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20211112081137.406930-1-ming.lei@redhat.com> <20211112082140.GA30681@lst.de>
 <YY4nv5eQUTOF5Wfv@T590> <20211112084441.GA32120@lst.de> <YY5iUwZ2TVtfqfXN@T590>
In-Reply-To: <YY5iUwZ2TVtfqfXN@T590>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Nov 2021 14:49:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJFfWOyBAFE4GuK7yohGUVd+9qOkhUz1r7ZMsinJNzDQ@mail.gmail.com>
Message-ID: <CAMuHMdUJFfWOyBAFE4GuK7yohGUVd+9qOkhUz1r7ZMsinJNzDQ@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Fri, Nov 12, 2021 at 1:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> On Fri, Nov 12, 2021 at 09:44:41AM +0100, Christoph Hellwig wrote:
> > On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
> > > > can only be used for reads, and no fua can be set if the preallocating
> > > > I/O didn't use fua, etc.
> > > >
> > > > What are the pitfalls of just chanigng cmd_flags?
> > >
> > > Then we need to check cmd_flags carefully, such as hctx->type has to
> > > be same, flush & passthrough flags has to be same, that said all
> > > ->cmd_flags used for allocating rqs have to be same with the following
> > > bio->bi_opf.
> > >
> > > In usual cases, I guess all IOs submitted from same plug batch should be
> > > same type. If not, we can switch to change cmd_flags.
> >
> > Jens: is this a limit fitting into your use cases?
> >
> > I guess as a quick fix this rejecting different flags is probably the
> > best we can do for now, but I suspect we'll want to eventually relax
> > them.
>
> rw mixed workload will be affected, so I think we need to switch to
> change cmd_flags, how about the following patch?
>
> From 9ab77b7adee768272944c20b7cffc8abdb85a35b Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Fri, 12 Nov 2021 08:14:38 +0800
> Subject: [PATCH] blk-mq: fix filesystem I/O request allocation
>
> submit_bio_checks() may update bio->bi_opf, so we have to initialize
> blk_mq_alloc_data.cmd_flags with bio->bi_opf after submit_bio_checks()
> returns when allocating new request.
>
> In case of using cached request, fallback to allocate new request if
> cached rq isn't compatible with the incoming bio, otherwise change
> rq->cmd_flags with incoming bio->bi_opf.
>
> Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks, this alternative patch seems to work fine, too.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
