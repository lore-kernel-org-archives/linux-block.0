Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF0C636CC
	for <linux-block@archiver.kernel.org>; Sat, 11 Feb 2023 18:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBKS5b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Feb 2023 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBKS5a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 13:57:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15F199E5
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 10:57:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r3so8111690edq.13
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3PcKjkZEscdfAV5ya0phdN14wwNaXoRb40kNT9Dczeo=;
        b=YHVu5kUXNJwub6fL2bFRhFub6fqpPJshyUtgnUVxZxBIopwouTR/KgSkKN4JSR5uve
         Wkfn8LbbiLtb+QLkrXegG9Ji77YU2cy+xueHjxfB9bGAjhzAGT4k9x0ToEiwbgOMILfW
         LyuiuxNGORWZQC9nxgiaZUsmJDUDBv4eCG8b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PcKjkZEscdfAV5ya0phdN14wwNaXoRb40kNT9Dczeo=;
        b=suH0WPUGnC+gNTrR/yvM7BWUuzp3IfZnluEUNXPZB8FCvc4EC5Rt4njPAUb5wjF0mT
         84EmIoRbHWcwfs+lGCxntBj5bTKhKn/U25IsJbv/U4YtLuPPU3Lh6w6HYfGRZc9LDnhG
         HP5i0WXsnb/+SKsREeBoJM45GIbUb03dFeoTJwxGVkRp5N4NbQt9IflSPPgNk/a8R7Tg
         PhG1JYbpWirVQx8voZdOciTP4oYdyl2/9Rcj1CSu0RTt9zoOqbSh1TjwIHdMkKRrgGJE
         a0V6LlfI8JGfRjIwvf7+sI7DqHvwVON6aFQAfO+Dwe4sRkXeAwY03q1wPcxfLr9Ve9Nl
         /HGQ==
X-Gm-Message-State: AO0yUKUfWLGheKfbTRhlobLbI7mUy9N9vLeX1fEsA7cxAmEDt7AoMg10
        fbxAGcCzmXmZTGY1B/JY+hTqO3mbVSK8Y+4PZHM=
X-Google-Smtp-Source: AK7set+R8h1xG8wr2YT949bNZK6Rw2y8Cx4UJDNbS92645xYjwA2h58V3ensSciif8Q4zxBcplm2DA==
X-Received: by 2002:a50:9f69:0:b0:4ac:b32d:3dab with SMTP id b96-20020a509f69000000b004acb32d3dabmr4264028edf.29.1676141846457;
        Sat, 11 Feb 2023 10:57:26 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id j16-20020a508a90000000b004ab4ba814a0sm2695556edj.47.2023.02.11.10.57.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 10:57:25 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id bt8so2359761edb.12
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 10:57:24 -0800 (PST)
X-Received: by 2002:a50:c353:0:b0:4ac:b616:4ba9 with SMTP id
 q19-20020a50c353000000b004acb6164ba9mr1152399edb.5.1676141844693; Sat, 11 Feb
 2023 10:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210153212.733006-1-ming.lei@redhat.com> <20230210153212.733006-2-ming.lei@redhat.com>
 <Y+e3b+Myg/30hlYk@T590>
In-Reply-To: <Y+e3b+Myg/30hlYk@T590>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2023 10:57:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
Message-ID: <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/splice: enhance direct pipe & splice for moving
 pages in kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 11, 2023 at 7:42 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> +/*
> + * Used by source/sink end only, don't touch them in generic
> + * splice/pipe code. Set in source side, and check in sink
> + * side
> + */
> +#define PIPE_BUF_PRIV_FLAG_MAY_READ    0x1000 /* sink can read from page */
> +#define PIPE_BUF_PRIV_FLAG_MAY_WRITE   0x2000 /* sink can write to page */
> +

So this sounds much more sane and understandable, but I have two worries:

 (a) what's the point of MAY_READ? A non-readable page sounds insane
and wrong. All sinks expect to be able to read.

 (b) what about 'tee()' which duplicates a pipe buffer that has
MAY_WRITE? Particularly one that may already have been *partially*
given to something that thinks it can write to it?

So at a minimum I think the tee code then needs to clear that flag.
And I think MAY_READ is nonsense.

          Linus
