Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E1AC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 23:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DC32081B
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552088228;
	bh=Nj2eEDHTfjrs1w44KqU6FyCgUPvCisSl3IxacxtVqTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UxDdtMsfty7QkZMowCm7GdQ3QcFkYNdDUiB3Y3VQJMG15y+PgZJWfhGgNEsUEt5Ql
	 Ed+VMkeTQCizemP0bvO88/iwDhzUhh7P0y5zTfsFpGjcClxO5BCqpb74BDGfYyPGUe
	 mA+XJRqsAHK81SEEAxonHxQ57tJycjEvY5SUTmI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCHXhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:37:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46502 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCHXhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 18:37:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id g12so15400850lfb.13
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 15:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUQVTZ0r3/OTP5tgK8N2Pvo9zf9k7vbT+rbn/pVcFRQ=;
        b=g7BoElOdod3kUi3B/fuYnJVHNiiR5REdmHBTavpGk9+tK2tbnsMxYdaYGw8hecNzoR
         Si00xQnMHS0JSc10I/wavrSCQ6O3f04GIWM3Nv/pZwfmbEkJ4WWlImO17powAE3owHE3
         QckXY7m7C95nEGR7zFDet/QsbGve17xzny2a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUQVTZ0r3/OTP5tgK8N2Pvo9zf9k7vbT+rbn/pVcFRQ=;
        b=Jg7T0XjAKdHDDNkwDhDjDqnRIu+MXkSaQx772YhFRrnm0ajAjXK65SnXG8W9f/9TOZ
         aBrw1yQuBl1nTAL2UaFg0LaiZbZ39t2NNzwpYgnN45jkiPg6TVjVuyh+McDrZBQ1QjZJ
         JqORvRzNn0wfn8H+UyEzwUobeyDzdVdcdE17t9Mm5N7eSQksiYZ54Weomt7cSdP4oUGe
         bDiuHgYl6oX7St47RdaKLvWKIjbzFInqIdszwPd9AebLAOFduAr61MneRXdpB5jQ2ugA
         HZwa53WYkk9l2hRyxK4/R7Qpz/s/yW2jqMUNoJfzGhk+XogGSfQqIorPt3p/8jEPFrRa
         XH/A==
X-Gm-Message-State: APjAAAWfTdVTMSU9dDjx/VZU98fw7kZcAvPhV59Hdng6pjQj57LEDQpI
        XSpoMc6NgkWDuubn0TIzGf2lAZV86oE=
X-Google-Smtp-Source: APXvYqzDbgqKoqzkb8+RIsErJzBkvHBNIO+KMkBEZ0sVTC8KVdSLx4/otHycoxQ239ZEBykM6TcPuA==
X-Received: by 2002:a19:a1cc:: with SMTP id k195mr2949547lfe.65.1552088223994;
        Fri, 08 Mar 2019 15:37:03 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 8sm1652892ljs.42.2019.03.08.15.37.02
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 15:37:03 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id z7so18831849lji.0
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 15:37:02 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr10198076ljg.94.1552088222447;
 Fri, 08 Mar 2019 15:37:02 -0800 (PST)
MIME-Version: 1.0
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk> <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
In-Reply-To: <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 15:36:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
Message-ID: <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 8, 2019 at 2:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm going to run the usual build tests, but also look at the basic
> sanity tests and boot and run them just to be careful before actually
> doing that final "ok pushed out".

While waiting for that, I'm looking at the file pointer refs, because
that was completely buggered in fs/aio.c.

What protects somebody from:

 - io_uring_register(IORING_REGISTER_FILES);

 - start async IO

 - io_uring_register(IORING_UNREGISTER_FILES);

and now it had better synchronize everything.

It looks like it migth work due to

 (a) the mutex_lock(&ctx->uring_lock) around registration

 (b) the wait_for_completion(&ctx->ctx_done) in __io_uring_register
presumably waits for each outstanding request.

HOWEVER.

The io_kiocb reference counting seems to be the *exact* same bogus
reference counting that fs/aio.c had, with the magical "zero means it
was never initialized and counts as one" handling, which was buggy in
fs/aio.c too, and caused serious problems with races between request
creation (the "synchronous" part) and requests actually being finished
asynchronously (the "completion" part).

IOW, I can already tell that the reference counting looks suspicious with

  static void io_free_req(struct io_kiocb *req)
  {
        if (!refcount_read(&req->refs) || refcount_dec_and_test(&req->refs)) {

where that whole first "oh, a zero refcount is magic" handling looks
*very* suspicious. It basically says "some ops don't do references
properly at all".

This is *exactly* the same bogosity that fds/aio.c had, and it has
*exactly* the same pattern, with the "poll" code doing

        /* one for removal from waitqueue, one for this function */
        refcount_set(&req->refs, 2);

and then everybody else seems to initialize req->refs to zero at
allocation time, because they magically have no lifetime rules for the
req.

It was bogus garbage in fs/aio.c, and honestly, looking at how much of
the logic looks suspiciously very similar jhere, I suspect it's bogus
garbage here too.

In fact, all the setup code looks suspiciously similar in general. It
has the same broken "prep_rw" and "complete_rw" thing which was racy
with files opened with O_DIRECT "competing" their IO while still
holding i_rwsem on the inode, and then possibly things getting
dropped.

I'm getting the very strong signal that this code had all the logic
taken from fs/aio.c, bugs and all.

Al has patches to fix the aio.c cases. I very much suspect some very
similar patches are needed in fs/io_ring.c.

                        Linus
