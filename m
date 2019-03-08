Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132CEC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB2F20851
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552089182;
	bh=mUZrM84LacOemIlQ5Y/Yx1pItLMMgWtGdGw7ryyn7d0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PLyphebJOufkzJF+vZFa90ntd2970O7p5X79m91BawKd7LQ+hRRfqx9JOT918rvll
	 U3Wge0LX/cIN5aemB7OYoQM/eaICXksLxW11kv+gJTdTJSKE5ZeQ48mQaoOq95W48Q
	 9i3AXa3DIDS+w9fvG1jNOwOD4G/qHoiZc9OlxkZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCHXxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:53:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44850 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCHXxC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 18:53:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id u9so11321109lfe.11
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crqhrFgBXY1iyb8K0DRyCsEYC2GEecViGMGVIHIE0gM=;
        b=YucdF6n1Jrt6tgd2+OGGjP948SHjfrQTMG19gh/5qzzjCOVjVjvHPfJaXsAHnqQDk6
         FliMbQEt+axOy8z7Y1GMV3zpHYpZelRdeb9vNQw+dkzQb/HQJ2rbkXAFb/BBD7v4CQG/
         8Ki50dc1EOUfP07EbuBJLwsnLgaxXSYlaSrEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crqhrFgBXY1iyb8K0DRyCsEYC2GEecViGMGVIHIE0gM=;
        b=F9G1zDv2I7vYRs6uRiij+fvNfWbsqMdEIvr+FEmrNDnPWIavjBcsn76P4P0hOb1sb+
         5FDiALiHuAKyBY5O9zKyGs2peFNfKrL5ltLJ2G+Lt+STn/APelg5lrcA2wEMZof7ZwzZ
         ILf7RbX1oGkI+wXEyrx5hCIz0Alp45hwoQlVaCV679O0iwmDJj1FriPcJEdcHIop5wJi
         g4yKnbyQsyx2YdHVyQvmgUCoicJWbUrK13Sbbrdmnc8/raIdljeWW8Lsv+CqbRKXRkJd
         VodztQZi05EhSlq48MRssYaJLq0lm/KFFW6YmkS6xBDwVP5e1pM5K/6WRlETew1OtF5U
         Gmew==
X-Gm-Message-State: APjAAAXV6GxvxLEKkJ13GPzcaj34vPF5aMXG4iputrNvsJ+LUGiHYX4p
        Z+7h9qfeXObQGxolgLNu+5ctTBOMun4=
X-Google-Smtp-Source: APXvYqyrTCgAaenzOu0NHP8K/E9/H/FIlQi3xJln+FKE9iBNoFlShW3yPBi8Eoq/mt25559NnT6TAQ==
X-Received: by 2002:a19:ee18:: with SMTP id g24mr11399001lfb.63.1552089179077;
        Fri, 08 Mar 2019 15:52:59 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id i15sm1643997ljb.48.2019.03.08.15.52.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 15:52:58 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 197so5528526lfz.3
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 15:52:58 -0800 (PST)
X-Received: by 2002:ac2:5542:: with SMTP id l2mr9408968lfk.136.1552089177618;
 Fri, 08 Mar 2019 15:52:57 -0800 (PST)
MIME-Version: 1.0
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk> <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
In-Reply-To: <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 15:52:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
Message-ID: <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 8, 2019 at 3:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It was bogus garbage in fs/aio.c, and honestly, looking at how much of
> the logic looks suspiciously very similar here, I suspect it's bogus
> garbage here too.

Apart from that "this really looks suspicious" I actually like what
the refcounting code does. The code looks like it took refcounting
seriously, and the context refcounting and setup synchronization looks
like it should work with that whole registration logic etc.

But if the low-level request refcount is off, all bets are off. And I
do think it looks like the basic io_kiocb refcounting is wrong, and
that

        refcount_set(&req->refs, 0);

in io_get_req() really is a big big red flag for "Oh, I'm not doing my
refcount properly". It seems to be an optimization for "I only have a
single refcount, and I don't want to have that expensive atomic
decrement".

But that automatically means that the whole "req" pointer is now
really really dangerous, because if IO finishes early, it will be
free'd immediately, possibly even before the synchronous part of
submission is all done.

And, as mentioned, it can free the file (and thus the inode) before
the synchronous part is even done, which can cause really subtle
problems.

I think the fix is the same that fs/aio.c is getting: just always
initialize the request refcount to 2: one for the submission side, and
one for the completion side.

Initializing a refcount to 0 is basically always a bug. You can't
return a structure that has a zero refcount - by definition you'd
better have your own reference on it.

                   Linus
