Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F071C43444
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F80C20657
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 10:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392178AbfAPKpf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:45:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34375 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392153AbfAPKpf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 05:45:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so6641948qtp.1;
        Wed, 16 Jan 2019 02:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pm30JPtJMNn6/SgCe3BYnF1HN4XH/TdXgtjuaCvmvOU=;
        b=dTkqXB0AIhwyihLuYHNF8rCQ3pLuULeQdgczpP/P40TqyL3ephOoXfLdLSMldnXUcU
         f1GWmPx3ziJQGJOFzsDikNi6Ts+sWvOsyZGGGmy1mVvhxHf6mFhXuaRTo4SpS39tnOYw
         e8PoYXYv8URq3MbpD8VAzCcQsMDPPAtNRUFOsi8GTKUaASkCSfOtx/C6MgkLyVSnbcE0
         TG74XFbSfP9pygzXhoddAW23dKeg1HrjSHIKIU05GeujAsx8p3YJVfgOSvXqUlabnomf
         4YF1R7gXgfoqPwTQVBhDpkx2XyiNVj71Hk/tjTAjixFZ0ktVsk8SueSQwnPUnX+6S/9O
         /v7A==
X-Gm-Message-State: AJcUukeWP0djQhDMZK/fKuJ0UPGq2OburZxRcFICgv7bbANYnhJXmBBK
        +8BWNhq9wnMRNloc3zlw5s522WGcARB5rGcs6NI=
X-Google-Smtp-Source: ALg8bN4AT+8ZUWGt86eErS8HUJdy/bAHjLods09CbL2Vb9845L8ZET7uN0PxFYHeNxKfFTH3UlVJHPpzhpG4RTAA5vE=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr6627347qta.152.1547635534059;
 Wed, 16 Jan 2019 02:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-16-axboe@kernel.dk>
In-Reply-To: <20190115025531.13985-16-axboe@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 11:45:17 +0100
Message-ID: <CAK8P3a2oHO-q6Nes3uakjFVcwYOAPHvLMyQW_qQg1_47PfH8Ng@mail.gmail.com>
Subject: Re: [PATCH 15/16] io_uring: add file registration
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:

> @@ -132,4 +139,12 @@ struct io_uring_register_buffers {
>         __u32 nr_iovecs;
>  };
>
> +struct io_uring_register_files {
> +       union {
> +               __s32 *fds;
> +               __u64 pad;
> +       };
> +       __u32 nr_fds;
> +};

I think you should either remove the pad field here, or pass the pointer
using a __u64 argument itself. With the current definition, the ioctl
command code is the same between 32-bit and 64-bit architectures
(since the length is the same on anything other than x86), but the
structures are incompatible.

I would also suggest adding an explicit 32-bit pad field at the end
of the structure, to avoid the implicit padding on non-i386 machines.

     Arnd
