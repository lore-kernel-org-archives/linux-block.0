Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8020C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F50B2087F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsIBGI5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfA2QhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:37:13 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36611 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfA2QhM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:37:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so16654210oix.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 08:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4StoU5DqhBUwcIq1LOzpanrz2QePC6O7mDt0fiAtt8=;
        b=WsIBGI5rcAnOCTUrxBk49Qc8NwW7oYMEn1MTdUmAlwqRoOwbVJwyYWxi0umNXQt7O9
         rL7jgGdWiwoeDd7V/sCLudD1GLxPZw0cYVBUu7RaaiOjxz8W6WBjZHZGhN/MygBD6oys
         rEJEvpcUiov3ES6YRWs+oNsBoKgWjsZAh5Q966e7mkKdPlnPmNv3JNPN66oYIdXJbUfG
         eMErQQGwjAuwAM+JHkVLS7H1HXD3Vyq4XzV4QU5zQAv7pseHu1bD05oSn2fxFmaqCvcP
         RNK7hAZsvu/7TPFsEkLYjKPscVXJy7xcyZmhwbqUaftdJaY1KSMizPJqOtcV5LJ23KvC
         1xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4StoU5DqhBUwcIq1LOzpanrz2QePC6O7mDt0fiAtt8=;
        b=KEzju/fa+nD8hLmPb/YYtWCYGcCl0uFxDl6hbHct5WKo3xRVZfX9t3UiZ+1r17F9S0
         crJwPtW2dqK36cZheDQKHI8OzZD0UXRwIVkd37WOu6TOTU/G+yRaHRtbtfhSK7Fs6oMf
         ocP2QN/LqvCKU+ys6mvHPC/c3n4oNouLmQJFldekOMleUCH4vPAg9pKMX5z8KFpnO7VS
         cEflPg6ZYV+/X7YTffEeqnW/zNL8S/YQw8+mYE7Hw5UHOHTaS5SP1rjGy4H53q6xItgL
         VFKdLEll2uwIddnv4Z4+knyS49Tn17le+vFwjs/Q4jbNqgqRkkvsEGbZ094ReXsobZ2d
         4t6Q==
X-Gm-Message-State: AHQUAuaQH9jVbmb1FSj5s+PKxtVp9Dw2sT0x7dNOkeI2krLan2bm1L7I
        2TIfFGf5vjaOzg+SjCp8gh3Ca2XtIF4nK2pzxrXa/DVsPJ4=
X-Google-Smtp-Source: AHgI3IbIYFFK/hzOwnWIpcyiG8/CdjKJbuCMFnSYemKGmO6PEgSShnPhzL3AGc3cHpot0nE3DsCttN8+NGFPZTVuz4M=
X-Received: by 2002:aca:d8c1:: with SMTP id p184mr10030766oig.22.1548779831499;
 Tue, 29 Jan 2019 08:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-14-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-14-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 17:36:45 +0100
Message-ID: <CAG48ez2tYBePMCkd-EOdAX1gfVwPJ-fTd-8XKu6J-QPyTXHN9g@mail.gmail.com>
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
> We normally have to fget/fput for each IO we do on a file. Even with
> the batching we do, the cost of the atomic inc/dec of the file usage
> count adds up.
>
> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
> for the io_uring_register(2) system call. The arguments passed in must
> be an array of __s32 holding file descriptors, and nr_args should hold
> the number of file descriptors the application wishes to pin for the
> duration of the io_uring context (or until IORING_UNREGISTER_FILES is
> called).
>
> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
> to the index in the array passed in to IORING_REGISTER_FILES.
>
> Files are automatically unregistered when the io_uring context is
> torn down. An application need only unregister if it wishes to
> register a few set of fds.

s/few/new/ ?

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/io_uring.c                 | 125 +++++++++++++++++++++++++++++-----
>  include/uapi/linux/io_uring.h |   9 ++-
>  2 files changed, 116 insertions(+), 18 deletions(-)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 682714d6f217..77993972879b 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -98,6 +98,10 @@ struct io_ring_ctx {
>                 struct fasync_struct    *cq_fasync;
>         } ____cacheline_aligned_in_smp;
>
> +       /* if used, fixed file set */
> +       struct file             **user_files;
> +       unsigned                nr_user_files;

It'd be nice if you could add a comment about locking rules here -
something like "writers must ensure that ->refs is dead, readers must
ensure that ->refs is alive as long as the file* is used".

[...]
> @@ -612,7 +625,14 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>         struct kiocb *kiocb = &req->rw;
>         int ret;
>
> -       kiocb->ki_filp = io_file_get(state, sqe->fd);
> +       if (sqe->flags & IOSQE_FIXED_FILE) {
> +               if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
> +                       return -EBADF;
> +               kiocb->ki_filp = ctx->user_files[sqe->fd];

It doesn't really matter as long as ctx->nr_user_files<=INT_MAX, but
it'd be nice if you could explicitly cast sqe->fd to unsigned here.

> +               req->flags |= REQ_F_FIXED_FILE;
> +       } else {
> +               kiocb->ki_filp = io_file_get(state, sqe->fd);
> +       }
[...]
> +static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
> +                                unsigned nr_args)
> +{
> +       __s32 __user *fds = (__s32 __user *) arg;
> +       int fd, i, ret = 0;
> +
> +       if (ctx->user_files)
> +               return -EBUSY;
> +       if (!nr_args)
> +               return -EINVAL;
> +
> +       ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
> +       if (!ctx->user_files)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < nr_args; i++) {
> +               ret = -EFAULT;
> +               if (copy_from_user(&fd, &fds[i], sizeof(fd)))
> +                       break;

"i" is signed, but "nr_args" is unsigned. You can't get through that
kcalloc() call with nr_args>=0x80000000 on a normal kernel, someone
would have to set CONFIG_FORCE_MAX_ZONEORDER really high for that, but
still, in theory, if you reach this copy_to_user(..., &fds[i], ...)
with a negative "i", that'd be bad. You might want to make "i"
unsigned here and check that it's at least smaller than UINT_MAX...


> +               ctx->user_files[i] = fget(fd);
> +
> +               ret = -EBADF;
> +               if (!ctx->user_files[i])
> +                       break;
> +               ctx->nr_user_files++;
> +               ret = 0;
> +       }
> +
> +       if (ret)
> +               io_sqe_files_unregister(ctx);
> +
> +       return ret;
> +}
> +
