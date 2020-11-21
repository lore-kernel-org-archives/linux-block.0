Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13486C5519F
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 18:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A7E22206
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 18:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OWXHkUpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgKUSVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgKUSVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 13:21:38 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB7C0613CF
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2020 10:21:37 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so13523503ljc.9
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2020 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXimiLJTrNupHkZvWwFLioXTRq0xyflB27lsWAkpfI4=;
        b=OWXHkUpTUVUoKPLewahV2bn8y9YWUhTKYYqZPcYsYz/RxIyBL9VvoEJydt/4b22Nc/
         FTt0PAtaMLOG4UkWlpyTiyFvNX9w7VTVF8V5pJRqz8mT2iV3leIIRlo5cQY61ut3NtZU
         1FFF98JuFgYzZovWcgU3304W0AGFjzWEOXuJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXimiLJTrNupHkZvWwFLioXTRq0xyflB27lsWAkpfI4=;
        b=aq73rFuvAE4CMQjneS3cnP1/GIv4SDOQNw/mNixHxQXocKvT/+s0ogU86ac7rnyL3s
         gVFVx8bPD0Wi69BPTFJ5UrkwM5bSCyr/T2bcGnprQP5TYzZPhPpttH84jhcdwwgD47YZ
         /gjQa0TFGTYcPktyVHLtwQTCV+gSMsrZWageTOS49Zv78eyOoAqXmVn/DLz+nYKNb0K4
         SB4TXCILIU/KwBEIKsbVex7w9hMPFS0rllyuiZTiDkq08AW2mjDJLQdFVpSHOm+p1wok
         ToZslXJuCQVyWPAdAOZKvMIshexWRK1+CbbBnO8p0So0qyl3kA/4Z32fsUQDQNqLKkDG
         tycA==
X-Gm-Message-State: AOAM532PLEgTAxjmBx1o+MspC4F0OqJf+uq8flIe3GADaujp4remak9C
        iCyiCeJoXiCdg3rM3hKB7bB64aXVP48PCQ==
X-Google-Smtp-Source: ABdhPJztbVjH7ilspaeOye7cv/8X3qlTlO3foQq6s5+Vw8P5tKHBySfXD0FRjB7+DWz+rsSp+faPvQ==
X-Received: by 2002:a2e:9046:: with SMTP id n6mr10912211ljg.22.1605982895273;
        Sat, 21 Nov 2020 10:21:35 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id x139sm784965lff.45.2020.11.21.10.21.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 10:21:34 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id f11so18141955lfs.3
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2020 10:21:34 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr11475617lfd.603.1605982893826;
 Sat, 21 Nov 2020 10:21:33 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 10:21:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
Message-ID: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
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

On Sat, Nov 21, 2020 at 6:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Switch to using a table of operations.  In a future patch the individual
> methods will be split up by type.  For the moment, however, the ops tables
> just jump directly to the old functions - which are now static.  Inline
> wrappers are provided to jump through the hooks.

So I think conceptually this is the right thing to do, but I have a
couple of worries:

 - do we really need all those different versions? I'm thinking
"iter_full" versions in particular. They I think the iter_full version
could just be wrappers that call the regular iter thing and verify the
end result is full (and revert if not). No?

 - I don't like the xxx_iter_op naming - even as a temporary thing.

   Please don't use "xxx" as a placeholder. It's not a great grep
pattern, it's not really descriptive, and we've literally had issues
with things being marked as spam when you use that. So it's about the
worst pattern to use.

   Use "anycase" - or something like that - which is descriptive and
greps much better (ie not a single hit for that pattern in the kernel
either before or after).

 - I worry a bit about the indirect call overhead and spectre v2.

   So yeah, it would be good to have benchmarks to make sure this
doesn't regress for some simple case.

Other than those things, my initial reaction is "this does seem cleaner".

Al?

              Linus
