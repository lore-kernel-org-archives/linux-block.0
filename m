Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC4C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184CF20881
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Io81cfcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfA2Xm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:42:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37758 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfA2Xm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:42:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so19561969otq.4
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04p0a1GArbkzaJitR5d/Duv5PJ0kPrBZq00zhIJyJm0=;
        b=Io81cfcsQP3+BCLr6/0a9Ai4lgnFG4nd6BDm7GMDnt7S9/7C+z5ASq6qM7ZpH/sjja
         72NXUoC91epLLTWnUWIcGYpUKdu9p0c1jXtNNP/v/mcypdajIq7ZU1zwj6SVC0NuGyE7
         Qze0oKMEck/Jv9LYUROFTzaYvTw6jSSuhlpJX99hIkMqtGF3tjdCMUSS6CMUWpO3RaH/
         7TALz8osM5QLnF/KJYBMAZgSqcpZbHS/E/vDcwhAD2A2b+jn3we6B7yYtIxkxwLo38ah
         fDFUJUjQexGQVGR2yQoz0VYbTGcgifyHA9uHIRj1ukbMebFLKqb9hbtBYhaJ4M2PDvOX
         m9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04p0a1GArbkzaJitR5d/Duv5PJ0kPrBZq00zhIJyJm0=;
        b=XolDe8jR6ZOHfhMN5voKBSUA6Rb3DISdV0XeN/v1hReEa6mfzgdEl6sTGHTL+TgVpR
         vuB/blL7eUdYB21t+XsuocPxucI68plnyUzFUPSjSzcuqzFuL5F61fB8NTcObkAyCwtU
         9QmuwD8FMCTmln7Ipd74WDtPle4rmpZcZ2Fwq1JMY3pa8QNkb60lSLObUxiw1SOGK6G2
         2MpwnmvtbrDQCqftGG2EbJeCsH0f5huJXanAX8OKv2pCO1F9CLBusNOhzHfIpAgg58tZ
         KbXzZ7I5024UaE11BuAF5g2v803rw1XLw1owKamES+q/HfaGSXuk4ld9FscvDZ+ycrEA
         KReQ==
X-Gm-Message-State: AJcUuke4CIbGFfCukNjSinnQtaco/1qkKg6MxJqjCryxZTJVIAzWsNv5
        odJw9nZc7bkZG2Pe3Ah3m9yxU7DD8JFuVh6v4WJtYA==
X-Google-Smtp-Source: ALg8bN6AMOmwIZ7ondNoqVnnFGO9xD97GnbupsTc/h/2nz9cPw4XGyheWmmwVOD7YTGJujgH32GBerQSk3oJ0Rg4xEQ=
X-Received: by 2002:a9d:460e:: with SMTP id y14mr21928216ote.198.1548805376081;
 Tue, 29 Jan 2019 15:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20190129192702.3605-1-axboe@kernel.dk> <20190129192702.3605-13-axboe@kernel.dk>
 <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com>
 <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk> <CAG48ez3x5x+P=8L1p-bHvcUnypeT1TizkXq2+Q0bCP0GdE-bog@mail.gmail.com>
 <87b25ce2-a5bc-3e81-ddba-5c932c71b40f@kernel.dk> <CAG48ez1m22z0Pqi0cT=UZdsA14SCM5579T1d40cZdyD6KqBw_g@mail.gmail.com>
 <379a631f-e55b-cc31-f84a-ace73fd66ea1@kernel.dk>
In-Reply-To: <379a631f-e55b-cc31-f84a-ace73fd66ea1@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Jan 2019 00:42:30 +0100
Message-ID: <CAG48ez3Jtq3ka+cSVxQWjMLQU=YRqV2dJuq5Kp2Nx_YLz3FsNQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 12:14 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/29/19 4:08 PM, Jann Horn wrote:
> > On Wed, Jan 30, 2019 at 12:06 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/29/19 4:03 PM, Jann Horn wrote:
> >>> On Tue, Jan 29, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>> On 1/29/19 3:44 PM, Jann Horn wrote:
> >>>>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>> If we have fixed user buffers, we can map them into the kernel when we
> >>>>>> setup the io_context. That avoids the need to do get_user_pages() for
> >>>>>> each and every IO.
> >>>>>>
> >>>>>> To utilize this feature, the application must call io_uring_register()
> >>>>>> after having setup an io_uring context, passing in
> >>>>>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
> >>>>>> to an iovec array, and the nr_args should contain how many iovecs the
> >>>>>> application wishes to map.
> >>>>>>
> >>>>>> If successful, these buffers are now mapped into the kernel, eligible
> >>>>>> for IO. To use these fixed buffers, the application must use the
> >>>>>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
> >>>>>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
> >>>>>> must point to somewhere inside the indexed buffer.
> >>>>>>
> >>>>>> The application may register buffers throughout the lifetime of the
> >>>>>> io_uring context. It can call io_uring_register() with
> >>>>>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
> >>>>>> buffers, and then register a new set. The application need not
> >>>>>> unregister buffers explicitly before shutting down the io_uring context.
[...]
> Just folded in this incremental, which should fix all the issues outlined
> in your email.
>
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 7364feebafed..d42541357969 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
[...]
> @@ -1602,6 +1605,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
>
>  static int io_sq_thread(void *data)
>  {
> +       struct io_uring_sqe lsqe[IO_IOPOLL_BATCH];
>         struct sqe_submit sqes[IO_IOPOLL_BATCH];
>         struct io_ring_ctx *ctx = data;
>         struct mm_struct *cur_mm = NULL;
> @@ -1701,6 +1705,14 @@ static int io_sq_thread(void *data)
>                 i = 0;
>                 all_fixed = true;
>                 do {
> +                       /*
> +                        * Ensure sqe is stable between checking if we need
> +                        * user access, and actually importing the iovec
> +                        * further down the stack.
> +                        */
> +                       memcpy(&lsqe[i], sqes[i].sqe, sizeof(lsqe[i]));
> +                       sqes[i].sqe = &lsqe[i];
> +

What if io_submit_sqe() gets an -EAGAIN from __io_submit_sqe() and
queues io_sq_wq_submit_work()? Could that cause io_sq_wq_submit_work()
to read from io_sq_thread()'s lsge[i] while io_sq_thread() is already
in the next loop iteration of the outer loop and has copied new data
into lsge[i]?
