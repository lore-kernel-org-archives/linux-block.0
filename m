Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D2C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE0C217F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFgkpabV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfA1V5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:57:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43104 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfA1V5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:57:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so14412008oie.10
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPQ1YqYSY6Zg8w9H/9nVnFViP9ZBBnPgbzDRe9zu78g=;
        b=SFgkpabVUtH3zEFSjazAfzII4DZvEtqTgqoPA5WWooGzi2HzF14gQja+orsKqOjX4Q
         aNPPI9mVPsWlxBMTpomsEiGcWt9u+r5st5b387j0+UydjZk8ZgjxER+iojA5b9BoiIlF
         9ZkCtyEDuqUQs8W+oxWrw0gOVe6iy0gBLOFgyH+NI7jOluqGniLohLxHCZhA3g79hy9I
         w0sfif0M2pkm9UA/TOd5VMFnM85tDr+mZAla8AGQzyfyWS1FtAg+uc6A1qGYESWbVOWB
         OcEaD/UeqDO5/HEMNLzJvs9qBOkkmZeiodkfY1hY5bdz7Ejjemp+DpWWDu7hPNlV/OsU
         BasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPQ1YqYSY6Zg8w9H/9nVnFViP9ZBBnPgbzDRe9zu78g=;
        b=guKY1JT6kOVvEhsLRtw7pcUc7HcolGGgiWbMI9gVedn0BFS+bsfxg/Ol+p8HEPtmss
         HAi+WWZOWGCu34gFI95zYETyyY1NAcD/LdC0CobpM6341vBpMnl3ADT07W2e5j0CHWzz
         A+WI4CMQqHp/F92q3xxMuRsOq4xAg4RDvj5VInOzphOHnQYupz/AKkySZXXTm8ncO7r0
         mJF4IJIwsJIWz9oxk8/JSyUoSUU+S5e3vRCI252OGkmQrjanjeO/sg5hReKME/BE74s0
         1zFE6C8BpPC6A2fJcq0JZAQA77Cq5GGFtteyZnyc6a4JS4bKtBs0QDlFKdyo6w0OlVyk
         CSmQ==
X-Gm-Message-State: AJcUukdIfOmy92tz041/mNZrIlt9TFrfM55uY18eUMjUe/CHzFC2oMmD
        WnLcreTJ4/XpSlG12Q8xrYR1x4HliGAKZHv9kMJZjA==
X-Google-Smtp-Source: AHgI3Ib+dMQZiz8Hvb0WEhjR/hORBGG7S69byb8kQ2pZh1l8WtWGVWK4Diyw1UcACQaCrc82+eEv9aXa79vowWDyIkA=
X-Received: by 2002:aca:ad14:: with SMTP id w20mr7147734oie.3.1548712619231;
 Mon, 28 Jan 2019 13:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-10-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-10-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Jan 2019 22:56:33 +0100
Message-ID: <CAG48ez0WzBEG5w5faFZ_DjU_62aTT=iBEPHEdYZuyq-LGRJtPw@mail.gmail.com>
Subject: Re: [PATCH 09/18] io_uring: use fget/fput_many() for file references
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
> Add a separate io_submit_state structure, to cache some of the things
> we need for IO submission.
>
> One such example is file reference batching. io_submit_state. We get as
> many references as the number of sqes we are submitting, and drop
> unused ones if we end up switching files. The assumption here is that
> we're usually only dealing with one fd, and if there are multiple,
> hopefuly they are at least somewhat ordered. Could trivially be extended
> to cover multiple fds, if needed.
>
> On the completion side we do the same thing, except this is trivially
> done just locally in io_iopoll_reap().
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
[...]
> +/*
> + * Get as many references to a file as we have IOs left in this submission,
> + * assuming most submissions are for one file, or at least that each file
> + * has more than one submission.
> + */
> +static struct file *io_file_get(struct io_submit_state *state, int fd)
> +{
> +       if (!state)
> +               return fget(fd);
> +
> +       if (state->file) {
> +               if (state->fd == fd) {
> +                       state->used_refs++;
> +                       state->ios_left--;
> +                       return state->file;
> +               }
> +               io_file_put(state, NULL);
> +       }
> +       state->file = fget_many(fd, state->ios_left);
> +       if (!state->file)
> +               return NULL;

This looks wrong.

Looking at "[PATCH 05/18] Add io_uring IO interface", as far as I can
tell, io_ring_submit() is called via __io_uring_enter() <-
sys_io_uring_enter() with an unchecked argument "unsigned int
to_submit" that is then, in this patch, stored in state->ios_left and
then used here. On a 32-bit platform, file->f_count is only 32 bits
wide, so I think you can then trivially overflow the reference count,
leading to use-after-free. Am I missing something?

> +       state->fd = fd;
> +       state->has_refs = state->ios_left;
> +       state->used_refs = 1;
> +       state->ios_left--;
> +       return state->file;
> +}
[...]
> +static void io_submit_state_start(struct io_submit_state *state,
> +                                 struct io_ring_ctx *ctx, unsigned max_ios)
> +{
> +       blk_start_plug(&state->plug);
> +       state->file = NULL;
> +       state->ios_left = max_ios;
> +}
> +
>  static void io_commit_sqring(struct io_ring_ctx *ctx)
>  {
>         struct io_sq_ring *ring = ctx->sq_ring;
> @@ -879,11 +974,13 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>
>  static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
>  {
> +       struct io_submit_state state, *statep = NULL;
>         int i, ret = 0, submit = 0;
> -       struct blk_plug plug;
>
> -       if (to_submit > IO_PLUG_THRESHOLD)
> -               blk_start_plug(&plug);
> +       if (to_submit > IO_PLUG_THRESHOLD) {
> +               io_submit_state_start(&state, ctx, to_submit);
> +               statep = &state;
> +       }
[...]
