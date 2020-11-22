Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC40DC56201
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 19:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C720782
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VxGhmukW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgKVTW3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 14:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgKVTW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 14:22:29 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B37C0613D3
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 11:22:29 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 142so15660985ljj.10
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zCFPYC7NieJSPwfWvwXaHyvNAXU5hOa2nbtBXCuwjQ=;
        b=VxGhmukWqaHWigNsKzqHqk9TIPfVskleOV5Imj9Zf5YAT4dgZBn2NNVPb5hXde0AlD
         2ounXEXn95qj7dZBgtxlxlEWoJZnBVysC4tfTJYRJiyrLiBCBMLj5xiiQwK5jqsSwF9q
         ACr7jjAQeuMF7X3NiHUezng0xq4TE6ipz5CbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zCFPYC7NieJSPwfWvwXaHyvNAXU5hOa2nbtBXCuwjQ=;
        b=m7BecUksmr2MHLSnClDTAET/jntpga5TiMQ4N09efGqvyzABXp013hH9PGLgMHPEq5
         Zyfz0fzi+flmpxD64U24JiAFFCki0qpQZ79uE02S3Ahn/5Ad2NAfhwT3BLOlzyBtSff5
         JQtdRSO/scx3xrkjdiScWO1mgBCwvv1bH+yI7tBDVn2T8pOZrjMt2FjAkFZ7Q4l05w7L
         DO0v15be9JxhcHvdz5NwIfg/4X9kCKhHob97JgOXHuZ0jt6ytwz4j5yeelxuJweZyH4E
         g5ZeG2rsIzOYKUXViC9EFkcHsFUGfFU5N86kMPtD7YEL9p7lMOkCt0eXuLN6SFlZA9YM
         wByg==
X-Gm-Message-State: AOAM532NeFIpnjL0SD03z0dVLbYMN+lhVcvoyuzhUlN91Q1DGIx7pKKE
        mOeGNY6uUWMnYJsdo/YujNFntOjcTrfbgQ==
X-Google-Smtp-Source: ABdhPJw+kyCW6GAedZ6TTSysoqIXbvObblydxZtMbA525WK2KLNUDqzDWQObpB6MvDvQWgvnBZFZZQ==
X-Received: by 2002:a2e:540d:: with SMTP id i13mr11274773ljb.55.1606072946297;
        Sun, 22 Nov 2020 11:22:26 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r66sm1113624lff.265.2020.11.22.11.22.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 11:22:25 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id y10so218362ljc.7
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 11:22:25 -0800 (PST)
X-Received: by 2002:a2e:50c:: with SMTP id 12mr444533ljf.371.1606072944698;
 Sun, 22 Nov 2020 11:22:24 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com> <254318.1606051984@warthog.procyon.org.uk>
In-Reply-To: <254318.1606051984@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Nov 2020 11:22:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggLYmTe5jm7nWvywcNNxUd=Vm4eGFYq8MjNZizpOzBLw@mail.gmail.com>
Message-ID: <CAHk-=wggLYmTe5jm7nWvywcNNxUd=Vm4eGFYq8MjNZizpOzBLw@mail.gmail.com>
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 22, 2020 at 5:33 AM David Howells <dhowells@redhat.com> wrote:
>
> I don't know enough about how spectre v2 works to say if this would be a
> problem for the ops-table approach, but wouldn't it also affect the chain of
> conditional branches that we currently use, since it's branch-prediction
> based?

No, regular conditional branches aren't a problem. Yes, they may
mispredict, but outside of a few very rare cases that we handle
specially, that's not an issue.

Why? Because they always mispredict to one or the other side, so the
code flow may be mis-predicted, but it is fairly controlled.

In contrast, an indirect jump can mispredict the target, and branch
_anywhere_, and the attack vectors can poison the BTB (branch target
buffer), so our mitigation for that is that every single indirect
branch isn't predicted at all (using "retpoline").

So a conditional branch takes zero cycles when predicted (and most
will predict quite well). And as David Laight pointed out a compiler
can also turn a series of conditional branches into a tree, means that
N conditional branches basically only needs log2(N) conditionals
executed.

In contrast, with retpoline in place, an indirect branch will
basically always take something like 25-30 cycles, because it always
mispredicts.

End result:

 - well-predicted conditional branches are basically free (apart from
code layout issues)

 - even with average prediction, a series of conditional branches has
to be fairly long for it to be worse than an indirect branch

 - only completely unpredictable conditional branches end up basically
losing, and even then you probably need more than one. And while
completely unpredictable conditional branches do exist, they are
pretty rare.

The other side of the coin, of course, is

 - often this is not measurable anyway.

 - code cleanliness is important

 - not everything needs retpolines and the expensive indirect branches.

So this is not in any way "indirect branches are bad". It's more of a
"indirect branches really aren't necessarily better than a couple of
conditionals, and _may_ be much worse".

For example, look at this gcc bugzilla:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86952

which basically is about the compiler generating a jump table (is a
single indirect branch) vs a series of conditional branches. With
retpoline, the cross-over point is basically when you need to have
over 10 conditional branches - and because of the log2(N) behavior,
that's around a thousand cases!

(But this depends hugely on microarchitectural details).

             Linus
