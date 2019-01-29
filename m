Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CFC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A08214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsIjk8WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfA2PgV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:36:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45528 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfA2PgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:36:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so18175814ota.12
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fhtTma8g9QYg4WWKbS6DiUFalqkBt76eekqDoRV62c=;
        b=YsIjk8WGpOotaM/7F2QRAkmGSARSRJ353Gwbm8iD5Fw/Rq8+YaCuoaJ0FbutwaeElg
         En5hGYrY7nML1EBqAseEkChJKY3OggUXIdMNWGD4458A018UyE7npIDaSH9osXuyu548
         AXvsP+Q0P18BZ+5YlY8tUtSQom/bFujVmqVrGG9aGzW+7Da42AF1SlUE1SkhnOKiVPn/
         M2dA5MOTv5SPXCF/+W7iusbUQv+mui/9x9fkwJ7byuwmjkyfBOlAmpQoeqxjjnVr0I3o
         CD1BzjVaBWMDABcmnggR/jY7Csc7fVgITczF+p0j/2+9aOxKSjpEuOk8bZwU3ppbRshd
         T1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fhtTma8g9QYg4WWKbS6DiUFalqkBt76eekqDoRV62c=;
        b=jSETj4S3Wlsgi2ALLmTugYCOblaY6yLsHqbwBcy6kTAximXYX4oklVyHAaBfDUMMLC
         FD55g5Q5ITiM3WCRGtNYJs0GPGW1S5dbUu8ecS4tEeJ+/9QiWaLt92gJtIA+lpNncQut
         L/CKCjH4UdaBatMNKQOS8Up/Cc3TTBhPOWuRkyyRdC/FUiJlfIa0LpObGwF5wxnt1fm1
         t9dZJxtnhUvh02QulEeKKdS1R8AuE5jsjyZdpZDonAw0TawBZx0zxKJoHguw1V8ynwTy
         6Clx+7mDoZtRvRFtRU7MXv+IQ2dJGxV0N2NZXzVCM3OhQQgQti9bpThCZg9SMK0E9BbO
         PqKg==
X-Gm-Message-State: AJcUukdo2yIcqjeGhNVNgyRpYiAEQvc7hQKMJwnjjh0/G/G/4XbkbXIW
        eBXhZC+qSkofCGESoBAvW746e8ubCeO15r/e5QAbGlioDto=
X-Google-Smtp-Source: ALg8bN7Uomxaq2jtH6rRFf8A2utuskUv/SPiaPAys42bp/2q4PUAoidmDmIKeqFxPv7J0B31wjQ8kEZFNHZ5OrUxCbA=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr20124550otf.242.1548776180499;
 Tue, 29 Jan 2019 07:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-6-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 16:35:54 +0100
Message-ID: <CAG48ez1ZM5KxjYGuDysZfNDQ_RjrrXWAM=vwyOfRi=oFdby1mQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO.
[...]
> +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
> +                          const struct io_uring_sqe *sqe,
> +                          struct iovec **iovec, struct iov_iter *iter)
> +{
> +       void __user *buf = u64_to_user_ptr(sqe->addr);
> +
> +#ifdef CONFIG_COMPAT
> +       if (in_compat_syscall())
> +               return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
> +                                               iovec, iter);
> +#endif
> +
> +       return import_iovec(rw, buf, sqe->len, UIO_FASTIOV, iovec, iter);
> +}

This code can run in kthread context, right? I think
in_compat_syscall() might not work if this is a kthread launched by a
compat task; I don't see anything that propagates the compat flag to
the kthread.
