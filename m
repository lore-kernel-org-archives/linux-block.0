Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B86C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C5D2177B
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6wOnn/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfBHWg7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:36:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37195 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHWg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 17:36:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so8572395otq.4
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 14:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kFUFNZdcqJ5ma5yINDd2vrLsdGXwTafpUtaM6X25yE=;
        b=n6wOnn/Ux8MOIbdTx9QjAw0ypXh5XlMaYs8aCuOcXGZ3Wt2plH1a7+2fk243GLPx0r
         wmsUZPEsEVQy71tj7xSXbGR6F94tDVihLGYalTJlrqYGynenCFMsAhRKlXtNiwdPRFZB
         n/FAEugWqe6DltWXIOrayD8sZ7wPRJLUY2mWOzcvALVzGQEgXSDVVC8dmcW0eBwW70di
         bIXuimvmwJurVcL9wFD5kSKSCkxSQ0KEEdCVGqbaNFxgSMHaa/rk2n7Z3h/GCiEOBLkz
         5DWkmof8tpenz7t+IcGAd3ii3r3bs4dz5yB5IIdQ/KTdoVIg9JIGJAPaFbLqaNAt3v51
         KwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kFUFNZdcqJ5ma5yINDd2vrLsdGXwTafpUtaM6X25yE=;
        b=MnkXa/0TkvA2+92hprha6+1CL2fQsiLXKmg/0QoMnEGdgwgVob9p5N64ntfG1HiKJx
         nQh2sm7ZoQKkduYUvMg0r2oGUgdrZEsv314RcgYRnroLCgylTmbd+ic5rh9Wj0ktoeWb
         9r5rOUi4din8gKkrTP2d3HlVamxPpVhJ9YaZmgSfZzVGVAzxWR5diXSQCJsIIuVrvJEm
         bQ+7vw/Tjfeez5N0xQsEa/togA/ySZQXJJXzku/J+OZTqmV7ptAYPD3liZa1xloSi9Fh
         bdRHbOmLCIAbv6zbNf5GpToKo6RnUQdlw/aOiCnyPODhZCzFcN1WUe/GOMUeaoYAHlh0
         J+dQ==
X-Gm-Message-State: AHQUAuaExfnDM8Tf9sEW1FfSJ9RS/LOgINUYmrT+k5KJ10PmK05xPe5o
        +sRKdGs8kZrHnKjXRVb4+bRGhnvMlVO3mRJ52Ru4Bw==
X-Google-Smtp-Source: AHgI3IZ2nAAbjKDYVry/XaVmDlTKtjtJiKmqk2rjvlu8bxDMK0JoNHE1cLjUw9IPGNG8cm+gbvDmI0Rl0yru5QMq9us=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr16241437otq.255.1549665418014;
 Fri, 08 Feb 2019 14:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20190208173423.27014-1-axboe@kernel.dk> <20190208173423.27014-7-axboe@kernel.dk>
In-Reply-To: <20190208173423.27014-7-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 8 Feb 2019 23:36:32 +0100
Message-ID: <CAG48ez1zUf9GqZyoD3XEEYyeg2zrBSAO5uKT3MKHOPMk6eujDQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] io_uring: add fsync support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
> From: Christoph Hellwig <hch@lst.de>
>
> Add a new fsync opcode, which either syncs a range if one is passed,
> or the whole file if the offset and length fields are both cleared
> to zero.  A flag is provided to use fdatasync semantics, that is only
> force out metadata which is required to retrieve the file data, but
> not others like metadata.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
[...]
> +static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> +                   bool force_nonblock)
> +{
> +       struct io_ring_ctx *ctx = req->ctx;
> +       loff_t sqe_off = READ_ONCE(sqe->off);
> +       loff_t sqe_len = READ_ONCE(sqe->len);
> +       loff_t end = sqe_off + sqe_len;
> +       unsigned fsync_flags;
> +       struct file *file;
> +       int ret, fd;
> +
> +       /* fsync always requires a blocking context */
> +       if (force_nonblock)
> +               return -EAGAIN;
> +
> +       if (unlikely(sqe->addr || sqe->ioprio))
> +               return -EINVAL;
> +
> +       fsync_flags = READ_ONCE(sqe->fsync_flags);
> +       if (unlikely(fsync_flags & ~IORING_FSYNC_DATASYNC))
> +               return -EINVAL;
> +
> +       fd = READ_ONCE(sqe->fd);
> +       file = fget(fd);

This always runs on the workqueue, right? Is it possible to call
fget() on a workqueue?

> +       if (unlikely(!file))
> +               return -EBADF;
> +
> +       ret = vfs_fsync_range(file, sqe_off, end > 0 ? end : LLONG_MAX,
> +                               fsync_flags & IORING_FSYNC_DATASYNC);
> +
> +       fput(file);
> +       io_cqring_add_event(ctx, sqe->user_data, ret, 0);
> +       io_free_req(req);
> +       return 0;
> +}
