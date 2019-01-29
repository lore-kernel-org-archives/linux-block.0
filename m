Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3AC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068A42184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IowwWKVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfA2Xbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:31:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44863 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2Xbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:31:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id g16so15525552otg.11
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWNZAO0n0cz7IOServSg577WcC7AbpDr4VbVQ4yUSAE=;
        b=IowwWKVGl0U8E97sjPtqEiWHEjdbuDzhhkYO4vzydMzYqBD5T8S/yUuwBnzoy7BzxU
         aRECVbsYb+BdGI/aPDlblK2Sxdt8KNN3mWiYPZ2+mU+mjbbQnXK+BtXRnO0G1HuzGmqA
         tMbj18BHQkBHXE0alVBnCstd2dAyftooB+X6gBrXNNinqN8LNOndsv2hP+4dMAb1yWpX
         PdDxKgKr93YwOpG+Tk7LwL98Cbe/ChWuX1SlMgg490D48bWgsW5gSuwH3OfbmHlQDj0G
         1rtHlK3VpdKtCD85c+Kka+9T9gvV7oXEG0ZlCM8ar1qliKIKL0TrcTrQMdkPUC9dRHKP
         i3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWNZAO0n0cz7IOServSg577WcC7AbpDr4VbVQ4yUSAE=;
        b=C4dYTL6IukLGjjP/CtS9VJW0fO+uRTh4tBbLrqvEU7QN0jEcnRmbWOUppK2QgyuiJm
         hdqSm8z1cWMtBL5w5nfT06e1EeDj5d3/6OkgcbGGFOQ/xs+Ws6rZFOGhP5SCUq1FbBCT
         LKHJDpv1ImQypndIlS0LdOcX6VkY/PLf3bRptIJR9bbMazWxdR11fAGWGupgxi2hEKFD
         om6ytQHgtY8MRQZJEvA+XlM9NbLvU/l8h4jpLldftJjYgzhGvQqRWQhaYIbTShUtf/Dp
         eV34yAxHcvPVaEkZPvII0YE8e0UNkXg3npEZCIPTvaAAfFzXdIltrpwje6CDMlKlYwsS
         kGGg==
X-Gm-Message-State: AJcUuke/JIyi/ZohmqogTfWEGOAgajCXWxMoT5DI3G/Qvc6a0mej/DrZ
        lSlxSBdcwHc64jKKarKYAIKVQoNz3zRupuW/Y9BCsEamJIiwgg==
X-Google-Smtp-Source: ALg8bN66kseHdvmLwLmXEFiz9rHW4wPbuTOCGkHV7sBm8CbbsMh104czmfF26DkDFWHIdMkUOyK8BBlISY8jASCSrQs=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr22282118otq.255.1548804690869;
 Tue, 29 Jan 2019 15:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20190129192702.3605-1-axboe@kernel.dk> <20190129192702.3605-10-axboe@kernel.dk>
In-Reply-To: <20190129192702.3605-10-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Jan 2019 00:31:05 +0100
Message-ID: <CAG48ez3_1mY1Fb91Q3H-S2+4OiMsV5F9v78JX+YMjWqLteHpzw@mail.gmail.com>
Subject: Re: [PATCH 09/18] io_uring: use fget/fput_many() for file references
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
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
[...]
> +static void io_file_put(struct io_submit_state *state, struct file *file)
> +{
> +       if (!state) {
> +               fput(file);
> +       } else if (state->file) {
> +               int diff = state->has_refs - state->used_refs;
> +
> +               if (diff)
> +                       fput_many(state->file, diff);
> +               state->file = NULL;
> +       }
> +}

Hmm, this function confuses me.
The state==NULL path works as I'd expect, it calls fput() on the file.
But if `state!=NULL && state->file==NULL`, it does nothing, it never
uses `file`.
And if `state->file!=NULL`, it drops the excess bias on the file's
refcount, but it doesn't drop the current reference - and again
without even looking at `file`.

So when io_prep_rw() uses io_file_get() to grab a reference on a file
it hasn't seen before, it will acquire `ios_left` references and
actually use one of them; then if it goes through the out_fput error
path, it goes through the path for `state->file!=NULL`, drops
`ios_left-1` references (leaving the refcount elevated by 1), and
forgets about the file?

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
> +
> +       state->fd = fd;
> +       state->has_refs = state->ios_left;
> +       state->used_refs = 1;
> +       state->ios_left--;
> +       return state->file;
> +}
> +
>  static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> -                     bool force_nonblock)
> +                     bool force_nonblock, struct io_submit_state *state)
>  {
>         struct io_ring_ctx *ctx = req->ctx;
>         struct kiocb *kiocb = &req->rw;
> @@ -487,7 +560,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>         int fd, ret;
>
>         fd = READ_ONCE(sqe->fd);
> -       kiocb->ki_filp = fget(fd);
> +       kiocb->ki_filp = io_file_get(state, fd);
>         if (unlikely(!kiocb->ki_filp))
>                 return -EBADF;
>         kiocb->ki_pos = READ_ONCE(sqe->off);
> @@ -528,7 +601,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>         }
>         return 0;
>  out_fput:
> -       fput(kiocb->ki_filp);
> +       io_file_put(state, kiocb->ki_filp);
>         return ret;
>  }
[...]
> +static void io_submit_state_start(struct io_submit_state *state,
> +                                 struct io_ring_ctx *ctx, unsigned max_ios)

There are various places in your series where you use raw "unsigned"
instead of "unsigned int"; when I run your tree through checkpatch.pl,
it complains about that and a few other things. Please fix the
checkpatch warnings (except for warnings where you know that they
shouldn't apply here for some reason).
