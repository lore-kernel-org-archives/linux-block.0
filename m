Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B33DC10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8C1214AF
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555950690;
	bh=UJRO1Oi3ulhye3OpRl6c52a1PNJfYnOMeAX3mVXNJCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZaNLEsG7acF9ASNk71s23YRK80w8zhaKfKKysCa8PiqqwnJjufF97NTlVF3T9Ebdb
	 Pj+qWndEQkr70gO/Tsp/Se0UZbhYFbRWg05PQtExKELZCfdJpcSMlJSEvIOvsX6iNa
	 V8LqqJqdkMPzaZLMIzSMILLD8QNMS+xABgALrOlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfDVQb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:31:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36121 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDVQb3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:31:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id l23so232151lja.3
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xSQ2HaBp4VGGOaQ5AmjairlFsxNFXDYMnHC9JTDLQA=;
        b=Z/pQMMBUlGyOB8H85WuIeuwHzg6mopT5yJKnUmy71VmGvnPUI8qHmOEaXVPHjw1UuX
         74v2FHJ84fP3N75pJ0VHJAf23tGCxgFUDbATwWP9Ikz6+ZBZnZz+Rk9/EGEZzc1oR86A
         d6KibssRcIiW9xsYi8AfO7IFTOIdA5/YHiFsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xSQ2HaBp4VGGOaQ5AmjairlFsxNFXDYMnHC9JTDLQA=;
        b=kXyqnMVTzSW93jcbQjjlAU6wP1jwSdAy7fRitHNlzq8N4Hmx2xmBeZYWhS0kX6Ehf+
         Nb5xFfACSVvlvO9i2l81OEEO5keaah49kcAMHOCzczFjVTWenRamr51Fqx3NnZMMouM4
         pmKWabKgGU7o9gFutRnMglovDLXcSD+PzoDo/VOv0/eSKhg9Z2mtPIsT6JZJ76XkLddo
         2BaRYrA38lyQp8aYw3FIk8ddOAvxsT1uTB6t4rtyBX3NjoOOZ6dXrzwau4fc6M8Y6w5D
         L4GR6MUbrZK01gQlpXvJChrpG3FsmTof1h7f4b0xMKTZZ0mdk4Rr95eUNbYAi0Zia3Ac
         SAEQ==
X-Gm-Message-State: APjAAAXs6gpDebfoOv9kDC2H+R321ifvNhbCWhjsfOkXoqB3bI0XlYni
        PYXSwXdklca8drGc1wIc+ZL6ooyO8w8=
X-Google-Smtp-Source: APXvYqxSaP2BI1/hqbDeLhbJQcV5DVFaEFxreMXq6Xm+4HB4e+bj+z0Agri4v9FHyMM0IdBKgtGNlA==
X-Received: by 2002:a2e:74f:: with SMTP id i15mr10328313ljd.156.1555950687178;
        Mon, 22 Apr 2019 09:31:27 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w8sm3076152lfn.95.2019.04.22.09.31.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:31:26 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q66so10801247ljq.7
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:31:26 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr10159740ljg.118.1555950249750;
 Mon, 22 Apr 2019 09:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com>
In-Reply-To: <00000000000043fe9c058720a5d3@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 09:23:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC5mNgPN5excXyTNtFpOyF4+9jk3tLiC+s-VezgGbVTA@mail.gmail.com>
Message-ID: <CAHk-=wgC5mNgPN5excXyTNtFpOyF4+9jk3tLiC+s-VezgGbVTA@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@alien8.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 22, 2019 at 9:06 AM syzbot
<syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com> wrote:
>
>
> The bug was bisected to:
>
> commit 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Mar 8 22:48:40 2019 +0000
>
>      Merge tag 'io_uring-2019-03-06' of git://git.kernel.dk/linux-block
>
> percpu_ref_kill_and_confirm called more than once on io_ring_ctx_ref_free!

So I don't see how that happens in the original code (because
__io_uring_register() is called with the uring_lock held), but let's
see.

HOWEVER.

I do see how it happens now as of the latest kernel as of commit
b19062a56726 ("io_uring: fix possible deadlock between
io_uring_{enter,register}") where the code explicitly drops the mutex
in order to wait for other uring users to finish.

So Jens, I think that commit was buggy. I suspect that
io_uring_register() should perhaps do something like

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2934,7 +2934,10 @@ static int __io_uring_register(struct
io_ring_ctx *ctx, unsigned opcode,
 {
        int ret;

+       if (!percpu_ref_tryget(&ctx->refs))
+               return -EBUSY;
        percpu_ref_kill(&ctx->refs);
+       percpu_ref_put(&ctx->refs);

        /*
         * Drop uring mutex before waiting for references to exit. If another

to guarantee that it's the *only* case of io_uring_register() doing that kill.

Hmm?

                Linus
