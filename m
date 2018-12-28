Return-Path: <SRS0=yOtT=PF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86DC43387
	for <linux-block@archiver.kernel.org>; Fri, 28 Dec 2018 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A2220856
	for <linux-block@archiver.kernel.org>; Fri, 28 Dec 2018 21:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gC7rKdLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeL1Vs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:48:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43321 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeL1Vs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 16:48:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so19652757lji.10
        for <linux-block@vger.kernel.org>; Fri, 28 Dec 2018 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsExHfdxgv83LmDhj1zeQf7bLZeatKP7M8XrB7Noe/c=;
        b=gC7rKdLgyRiDetWfTK+7MoGuz/LOtlBa4Alj5JrCe2slFp4d9Ar1i2C6TO3r0zeGMB
         NSohP7QydG+wahjUP63bvjfyUm9hfD/JyMgMsdZKfT1BKoHUmZRHX6eAsEhcmzKUAKdG
         RI7B7L1Y8s8Jd54xOPDQo6n9Gp8fEj24Zv7LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsExHfdxgv83LmDhj1zeQf7bLZeatKP7M8XrB7Noe/c=;
        b=VGz/VCFSXmnlqKbcnKduMSJenvoz4RKhwKGXJa5rYCWGaRuuAs181xSP1MMvJ9W/Vz
         xhyITZXQ9LmMKZxNcv99HTK86046wCa7dv7Vi7pEnzruZokGjdZg9WxUhJmEtBrqLrlJ
         b/7xSAx5wG7DSNmV3L8KfDi+yQ3grw8G7C/6y+UHJTL0bxhmVCNwfisuBZkrm3IZmKam
         2JIJ4RDhzvucBB8Bi/Ij1jTJMLKDOZCGTJhNEgtwvdobf382O/4hJux2/MBa1lxp3ftS
         c6nEV3rufxUOBkzqFjt3JeSp/sgokg4OjF9jGiMgEOFCFv5blPvIdW/CDnbvHMUGEI36
         fQAQ==
X-Gm-Message-State: AJcUukcu19mfYl+THIZarTTjFRl4cGVV6zG4Typo2R48SJ3ond7zUe0O
        WqVRUoKQT+OloAOq1mu8vB6xdh4Od4Q=
X-Google-Smtp-Source: ALg8bN50BlIKn9mCffx1STxbzTPyQvDfEGk1on72JID0WiUO2tj67ndUF8P6PWPAgAMIet6ZVK/MPg==
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr16545969ljd.141.1546033705785;
        Fri, 28 Dec 2018 13:48:25 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id o88sm8277713lfk.38.2018.12.28.13.48.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:48:24 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id k19-v6so19642005lji.11
        for <linux-block@vger.kernel.org>; Fri, 28 Dec 2018 13:48:24 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr11648037ljj.120.1546033704289;
 Fri, 28 Dec 2018 13:48:24 -0800 (PST)
MIME-Version: 1.0
References: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
In-Reply-To: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 13:48:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKZ-AmcVQEUFLuS1uSjyHLo2Z1tYq8asOCTziF8MbAuQ@mail.gmail.com>
Message-ID: <CAHk-=wjKZ-AmcVQEUFLuS1uSjyHLo2Z1tYq8asOCTziF8MbAuQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.21-rc
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 20, 2018 at 8:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Jens Axboe (108):
>       block: avoid ordered task state change for polled IO

This one seems *very* questionable.

The commit message is misleading:

    For the core poll helper, the task state setting don't need to imply any
    atomics, as it's the current task itself that is being modified and
    we're not going to sleep.

    For IRQ driven, the wakeup path have the necessary barriers to not need
    us using the heavy handed version of the task state setting.

What? Barriers on one side have *no* meaning or point if the *other*
side doesn't have any barriers.  That's completely magical thinking.

But it's also not at all the case that such barriers even exist. The
wakup side does:

                        struct task_struct *waiter = dio->submit.waiter;
                        WRITE_ONCE(dio->submit.waiter, NULL);
                        blk_wake_io_task(waiter);

and here the sleeping side now does:

                        __set_current_state(TASK_UNINTERRUPTIBLE);

                        if (!READ_ONCE(dio->submit.waiter))
                                break;

which is entirely unordered. So just what protects against this:

  Sleeper:              Waker (different cpu)

  read submit.waker
  (sees non-NULL)

                        WRITE_ONCE(dio->submit.waiter, NULL);
                        blk_wake_io_task(waiter);

  write TASK_UNINTERRUPTIBLE
  io_schedule()

and now the sleeper sleeps forever, because there will be nobody who
ever wakes it up (the wakeup happened before the write of
TASK_UNINTERRUPTIBLE).

Notice how it does not matter AT ALL what barriers that other CPU is
doing when waking things up. The problem is the sleeping CPU having
reordered the check for "oh, there's a waiter", and "tell people I'm
going to sleep".

Those memory barriers matter. You can't just remove them randomly and
claim they don't.

Why would you even remove it in the first place?

Guys, if you don't understand memory ordering, then you have
absolutely no business using __set_current_state(). And talking about
barriers on the other side of the equation clearly shows that you
don't seem to understand memory ordering.

Barriers are only *ever* meaningful if they exist on both sides
(although sometimes said barriers can be implicit: an address
dependency or similar in RCU, now that we've decided to not care abotu
the crazy alpha read-barrier-depends)

Maybe I'm  missing something, but this really looks like a completely
invalid "optimization" to me.  And it's entirely bogus too. If that
memory barrier matters, you're almost certainly doing something wrong
(most likely benchmarking something pointless).

               Linus
