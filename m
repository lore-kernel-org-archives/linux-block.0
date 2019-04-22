Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C06C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529FA2175B
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k1SOaDoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfDVQ2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:28:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56184 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfDVQ2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:28:35 -0400
Received: by mail-it1-f194.google.com with SMTP id y134so18628874itc.5
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0YMZftlMUHZo7PBuxCI1tlSTMOcGrZlt8hFWgHl+L+E=;
        b=k1SOaDoOUBGXWP4VwKGtXgfEEyuzmixr1cJ1d4C29trp67nQliQ+3pBmPbjJl3Fh28
         eDGqK+5+XTNMXKQmJnQ16lWq7a3CSAZkHCynXnAzOBK3wzIdjfRVQhP4OOHPgMfMMhOo
         ZkUiLX6JjP24oBas7VZvzqeGy5FD3gjyF5A7KHbeWlK5mNPAGUJLkJAwNBSoOGXPUris
         AP5jxRtJksBdcNFWVBuaWJHaX1aq4IIiREnINPy5T3OOj3gWfd7Icfke/dAV8H4kqBti
         yeVHDEzkubxwwzNsODVDrpub8ixtnxhTkt7Ky3t5fyHpqO+4vCjEHXKYB5wrAJx0d/As
         cQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0YMZftlMUHZo7PBuxCI1tlSTMOcGrZlt8hFWgHl+L+E=;
        b=eA8qbu05GCdeAFLJ//p4Yxc2U2iNbaxKBp5dJe4bTdcPvm8+2M6Lc9ZzczuDk+7mlA
         YWTn1RnzDG/VsGAyCV5e0prSGBolKhNoqlGsCXLniJyP7rNfQcXBl3GYwppy4Q8nmpwH
         gsRimIp86cL4NaL6XoERsK55zLaoz22pdz7kzgMYRIxQMf25fWNcjJQ2LoCBlhrAt5JO
         ymPgoqy3mvk/4gneStLa+9ZAhTUEt3KKtTb1v27Zxh/sldzmL66R4WBiY2IZ5393EPcJ
         HhXkb83a3YA4yvBj9YyVkWjxSP6bQtDRm5ZWdc/S0OLGNWWPT2udCPN8HByMFGcVymZQ
         jAzg==
X-Gm-Message-State: APjAAAWQe3JzAtWk7IQxFV9ChlQso8wKIyiIEHBevAaaQhv1QVM+wbbq
        jL7Mwllxzq6zI+f6BhqF7iJaaA==
X-Google-Smtp-Source: APXvYqziYFRJ2GfHBlcbEvYY7DEfMcp0V612OFcpBV9etEO6L9kaDRuUFLHILfUD/6nKuRL9w4w9DQ==
X-Received: by 2002:a02:1649:: with SMTP id a70mr14313951jaa.116.1555950514747;
        Mon, 22 Apr 2019 09:28:34 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u66sm4500447ioe.74.2019.04.22.09.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:28:33 -0700 (PDT)
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
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
        the arch/x86 maintainers <x86@kernel.org>
References: <00000000000043fe9c058720a5d3@google.com>
 <CAHk-=wgC5mNgPN5excXyTNtFpOyF4+9jk3tLiC+s-VezgGbVTA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <224b0113-979a-01c3-49a0-6170f075cdae@kernel.dk>
Date:   Mon, 22 Apr 2019 10:28:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgC5mNgPN5excXyTNtFpOyF4+9jk3tLiC+s-VezgGbVTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 10:23 AM, Linus Torvalds wrote:
> On Mon, Apr 22, 2019 at 9:06 AM syzbot
> <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com> wrote:
>>
>>
>> The bug was bisected to:
>>
>> commit 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Fri Mar 8 22:48:40 2019 +0000
>>
>>      Merge tag 'io_uring-2019-03-06' of git://git.kernel.dk/linux-block
>>
>> percpu_ref_kill_and_confirm called more than once on io_ring_ctx_ref_free!
> 
> So I don't see how that happens in the original code (because
> __io_uring_register() is called with the uring_lock held), but let's
> see.
> 
> HOWEVER.
> 
> I do see how it happens now as of the latest kernel as of commit
> b19062a56726 ("io_uring: fix possible deadlock between
> io_uring_{enter,register}") where the code explicitly drops the mutex
> in order to wait for other uring users to finish.
> 
> So Jens, I think that commit was buggy. I suspect that
> io_uring_register() should perhaps do something like
> 
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2934,7 +2934,10 @@ static int __io_uring_register(struct
> io_ring_ctx *ctx, unsigned opcode,
>  {
>         int ret;
> 
> +       if (!percpu_ref_tryget(&ctx->refs))
> +               return -EBUSY;
>         percpu_ref_kill(&ctx->refs);
> +       percpu_ref_put(&ctx->refs);
> 
>         /*
>          * Drop uring mutex before waiting for references to exit. If another
> 
> to guarantee that it's the *only* case of io_uring_register() doing that kill.
> 
> Hmm?

Just sent out something as well. I think we can get by with just
checking if it's dying, or we can go the route of what you did which is
actually very similar to what the earlier versions did. Both versions
should fix the issue.

I'll test just to be totally sure.

-- 
Jens Axboe

