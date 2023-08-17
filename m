Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98AC3065A
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjHQPb4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351987AbjHQPba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 11:31:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B130C5
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 08:31:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99d937b83efso681858666b.3
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692286287; x=1692891087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZksWXJeiDtIMomMGS5LdQjB7hSovJabWytEHylyKmNA=;
        b=UZhUSWek8RNhfZ1nvdWBd+VSKvHqLrRH4TlPcZcnXec9/4z++prdyp6oZi8xdvLY93
         cL6IO6q2GI9wO9NyHvD+6x9NEuJQaao228zPlYh7PVH0FILGjOiAVnDEOlFqvCsdkMrC
         NhSbSYaogwrq+K42GWDoxB95/a/Su+x9Z86pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286287; x=1692891087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZksWXJeiDtIMomMGS5LdQjB7hSovJabWytEHylyKmNA=;
        b=UnrEo+zU73byuSsiE/8IbE3fvaMOMV7GaQtxdTYEVJrogNUF8mjPDBXltAIOsofEXc
         G3UfvnZj/xRxApIOa/YaNug7XpujMA6Z+J3ZQ4OkB2Xq5lxLz9j2Va2j5qggG/GD3SZA
         4+Cjp/GbUTO2G3yynSmMT/4dkBc5I1gay2JojP62mNaymvvv8LXY8lXuGgbCKq0r5van
         r09a7bzclGeZ+u3MFN8/7BZKfW3wK05VeFuhrOM//87ySRD8Ph8m2L58GTedzinnpLXI
         s3ogs3LK4tvZ5URTjpk5MyLuW44hpDtozbm54QFsVEJ00QCEDptuMzIKKsj5NIzvSvGh
         EMig==
X-Gm-Message-State: AOJu0YxMt//U6G9wVLK9Y4HV6Q2bI/U5gLltkiAzz2tz56zeOWVEZa10
        R0XLGu6neYKfq5wiSe00sQG8dGCvHkxLqifZynFf1/dv
X-Google-Smtp-Source: AGHT+IFR+YweVr7habE9AN3YdrrISLkXpnNjTGuIia5uWsg3zwLirlTzM3kzMPm5vA+zgg68FXBCGA==
X-Received: by 2002:a17:906:314f:b0:992:b9f4:85db with SMTP id e15-20020a170906314f00b00992b9f485dbmr4132790eje.39.1692286287293;
        Thu, 17 Aug 2023 08:31:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090657ce00b00992ed412c74sm10200608ejr.88.2023.08.17.08.31.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:31:26 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99d937b83efso681854266b.3
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 08:31:26 -0700 (PDT)
X-Received: by 2002:a17:906:5384:b0:98d:5ae2:f1c with SMTP id
 g4-20020a170906538400b0098d5ae20f1cmr4264910ejo.34.1692286286063; Thu, 17 Aug
 2023 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com> <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
 <2190704172a5458eb909c9df59b6a556@AcuMS.aculab.com>
In-Reply-To: <2190704172a5458eb909c9df59b6a556@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 17:31:09 +0200
X-Gmail-Original-Message-ID: <CAHk-=wj1WfFGxHs4k6pn5y6V8BYd3aqODCjqEmrTWP8XO78giw@mail.gmail.com>
Message-ID: <CAHk-=wj1WfFGxHs4k6pn5y6V8BYd3aqODCjqEmrTWP8XO78giw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Aug 2023 at 17:16, David Laight <David.Laight@aculab.com> wrote:
>
> gcc for x86-64 make a pigs-breakfast when the bitfields are 'char'
> and loads the constant from memory using pc-relative access.

I think your godbolt tests must be with some other model than what the
kernel uses.

For example, for me, iov_iter_init generates

        testl   %esi, %esi      # direction test
        movb    $1, (%rdi)      # bitfields
        movq    $0, 8(%rdi)
        movq    %rdx, 16(%rdi)
        movq    %r8, 24(%rdi)
        movq    %rcx, 32(%rdi)
        setne   1(%rdi)            # set the direction byte

with my patch for me. Which is pretty much optimal.

*Without& the patch, I get

        movzwl  .LC1(%rip), %eax
        testl   %esi, %esi
        movb    $0, (%rdi)
        movb    $1, 4(%rdi)
        movw    %ax, 1(%rdi)
        movq    $0, 8(%rdi)
        movq    %rdx, 16(%rdi)
        movq    %r8, 24(%rdi)
        movq    %rcx, 32(%rdi)
        setne   3(%rdi)

which is that disgusting "move two bytes from memory", and makes
absolutely no sense as a way to "write 2 zero bytes":

.LC1:
        .byte   0
        .byte   0

I think that's some odd gcc bug, actually.


> Otherwise pretty must all variants (with or without the bitfield)
> get initialised in a single write.

So there may well be some odd gcc code generation issue that is
triggered by the fact that we use an initializer to set those things,
and we then have two bytes (with my patch) followed by a hole, or
three bytes (without it) followed by a hole.

But that bitfield thing improves things at least for me. I think the
example code you used for godbolt is actually something else than what
the kernel does.

               Linus
