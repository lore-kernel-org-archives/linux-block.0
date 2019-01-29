Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9692C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 21:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750EC214D8
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 21:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASgEp9Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfA2VKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:10:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33528 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2VKo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 16:10:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so17462278oib.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ieESoslk/+vy8XugbTMbEvAPvSEySVEHpg9anodsfE=;
        b=ASgEp9Wo0zsKxDSx8sP/uhY0aWF6eOveITktp3UgzzprdeRe4YIALW+cX/C/B1kuuy
         7JT3huGqJZdnEWuxMuvM+e4+ztVhX6yKdP40yRky47qjGdENvlIby5lPtfF9Qrx++CDE
         IaWZyk/1eUsxBzNrokRsVkPbBAoOdQ+48fK9h1DF0Xzvogm6i+zir/b8W9KgLlGtMNh4
         VqpGsQtq1bQ4/KFjK24EEFPvKkm9UmLbDP6ZQmUfxK8tIXvR6YklrXidsfpVgcT2zHks
         ra10p31JJSkEPmn/shSabBh/OwhMfE7lp0AxTWBsTUPk/8Emuy0f1LzQVS+Tt234o8PS
         D23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ieESoslk/+vy8XugbTMbEvAPvSEySVEHpg9anodsfE=;
        b=W2HkFCbA5D1Gv3KEra6Ca667z86OyXs1ktJTq3kJ4jtUV4WeqjlDw3xN8RX8OCG4jx
         6rumEYeegeZUEJA2tXo8B17yTQDjTUfJZDe0ohvZTrD/1Zx98mx+wMgg4BHsxszHxb8I
         2KkwT4iYkMgmwADiE+OKDv8d+TaJQ1tILCUvXiAWt5jTnThPBlqeBgH0W2EwstsOTilX
         N4aBsPhPhewbow5zwoL52gxxDleZ8h9uqMs+a4LEUYuru+Tjn2S+7/KMMQan11Ui5jex
         QQVzXISOrQ0sl3itn+A3SHOzlrUAJaOFNO8rpELb5Mp+cxJhaef3PXVKtkcl84loK4lK
         8q0Q==
X-Gm-Message-State: AJcUukeYVxUcwo3VW3TwhENtcjsnoqHE5sa6ZuG5/5lS8VWEyS6doDAx
        ttEFMU7l3ArA1c2UZ+fNHuatNXKosbB/iowUCJ2aKQ==
X-Google-Smtp-Source: ALg8bN5YgO7liUr3+OWxZFc48JA2sDGl42f5UJqwyC6pgy54HvxqKZ9RqzlG9wv9jLVu/2Hq+2dlZK5hn3TEEwVuXvE=
X-Received: by 2002:aca:c413:: with SMTP id u19mr10075012oif.209.1548796243381;
 Tue, 29 Jan 2019 13:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20190129192702.3605-1-axboe@kernel.dk> <20190129192702.3605-8-axboe@kernel.dk>
 <CAG48ez270gG64wmHtG8pNUoBWiSwYiGxsyuSCQ_4wn7v_n_h_w@mail.gmail.com> <7337bdfc-39b5-2383-4b58-a9efc3dea1cb@kernel.dk>
In-Reply-To: <7337bdfc-39b5-2383-4b58-a9efc3dea1cb@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 22:10:17 +0100
Message-ID: <CAG48ez1uZocSQ6rcT8469SUQtyw3btnP8Js3Ht6VNFb_kfDUDQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 9:56 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/29/19 1:47 PM, Jann Horn wrote:
> > On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> Add support for a polled io_uring context. When a read or write is
> >> submitted to a polled context, the application must poll for completions
> >> on the CQ ring through io_uring_enter(2). Polled IO may not generate
> >> IRQ completions, hence they need to be actively found by the application
> >> itself.
> >>
> >> To use polling, io_uring_setup() must be used with the
> >> IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
> >> polled and non-polled IO on an io_uring.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > [...]
> >> @@ -102,6 +102,8 @@ struct io_ring_ctx {
> >>
> >>         struct {
> >>                 spinlock_t              completion_lock;
> >> +               bool                    poll_multi_file;
> >> +               struct list_head        poll_list;
> >
> > Please add a comment explaining what protects poll_list against
> > concurrent modification, and ideally also put lockdep asserts in the
> > functions that access the list to allow the kernel to sanity-check the
> > locking at runtime.
>
> Not sure that's needed, and it would be a bit difficult with the SQPOLL
> thread and non-thread being different cases.
>
> But comments I can definitely add.
>
> > As far as I understand:
> > Elements are added by io_iopoll_req_issued(). io_iopoll_req_issued()
> > can't race with itself because, depending on IORING_SETUP_SQPOLL,
> > either you have to come through sys_io_uring_enter() (which takes the
> > uring_lock), or you have to come from the single-threaded
> > io_sq_thread().
> > io_do_iopoll() iterates over the list and removes completed items.
> > io_do_iopoll() is called through io_iopoll_getevents(), which can be
> > invoked in two ways during normal operation:
> >  - sys_io_uring_enter -> __io_uring_enter -> io_iopoll_check
> > ->io_iopoll_getevents; this is only protected by the uring_lock
> >  - io_sq_thread -> io_iopoll_check ->io_iopoll_getevents; this doesn't
> > hold any locks
> > Additionally, the following exit paths:
> >  - io_sq_thread -> io_iopoll_reap_events -> io_iopoll_getevents
> >  - io_uring_release -> io_ring_ctx_wait_and_kill ->
> > io_iopoll_reap_events -> io_iopoll_getevents
> >  - io_uring_release -> io_ring_ctx_wait_and_kill -> io_ring_ctx_free
> > -> io_iopoll_reap_events -> io_iopoll_getevents
>
> Yes, your understanding is correct. But of important note, those two
> cases don't co-exist. If you are using SQPOLL, then only the thread
> itself is the one that modifies the list. The only valid call of
> io_uring_enter(2) is to wakeup the thread, the task itself will NOT be
> doing any issues. If you are NOT using SQPOLL, then any access is inside
> the ->uring_lock.
>
> For the reap cases, we don't enter those at shutdown for SQPOLL, we
> expect the thread to do it. Hence we wait for the thread to exit before
> we do our final release.
>
> > So as far as I can tell, you can have various races around access to
> > the poll_list.
>
> How did you make that leap?

Ah, you're right, I missed a check when going through
__io_uring_enter(), never mind.
