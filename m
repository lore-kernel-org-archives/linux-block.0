Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2792C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0D9610CE
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 13:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhDPN04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbhDPN0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 09:26:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB996C06175F
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 06:26:28 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 18so11895437qkl.3
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k24lqJA2ePgDpS0UJ8YujxsEtI+mMUkUT/FN9W10Nn0=;
        b=FeyWiBbo6D0ayzDOL/QHTiIvzz4cEaXWx8o+6YjmlNc6Nojn5S7stz/I5wqw7CqjW5
         M5UbGm8i3ECiPd9eAFPJZxhRkKZ3TmSXoTfarTKV9INdGtXaLj19zEjTudfSoH60/N0U
         vT3v6qrzqvnQE6ajASowQH7QZ5lt+0ebHy6DQVl9wYS6WlTGAkNxbXHos/cbJucXS9Ng
         5nB4cf50FEyO4xM9DuFWQq7MNGssjm3u1w2aHY+rawvqWaq3gM3CrQYh1xPUa5kOQvSl
         kf8zbpEYPiH5wF1/cyTIJAQMYquv6WuePY8UKYy+il+998GMV2mIf6IP8s0TpEwAqEUo
         9HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k24lqJA2ePgDpS0UJ8YujxsEtI+mMUkUT/FN9W10Nn0=;
        b=Tk8whg87IvQZxE6P5Mn6srHZDo2HA4Y834P8nMTwXWMkJ5MGwJ08Vcnedi/Ex5zqUM
         jugvn5E0s9/LQBOb0xBX2ToNEH41AWx3zBmmEuh3i5fV89Rz3EdEtLxsBP+6cqg4Y9kw
         4pHleXmCK+aDSmJfDL3A+PFK9apboy1KdvyJHrrRCytFj8MPagA0rEvEXnv0hvuyvRyw
         XWCTobCtE0YwwO6YkYaYPZJfEKKAYAQCnG9BOF2p6QsUKhF+AO5usmksqCeXuwCmR96j
         RY1GGI09LSaAVZnr3LJJ7UEdYGV2TiV1+486dyKMyip+s1XyJvX0W1dwSli8s+cp+6y4
         hlzQ==
X-Gm-Message-State: AOAM532pGC4gMymkRrSRR8WOEBof+pvTz20Fyue2XBhqzhNQanoHqbWg
        KGkocCGDeIjOR8coGvxR2WSmFhLwnXd0JxhZ1ypdJg==
X-Google-Smtp-Source: ABdhPJxACO1LwUaPtjWtjSqHcBL2a8SxwHYAxGs7vuj8cOySNe9dSMuGs8671Ti9HBUk2JMxavnR9B4rkr4vFU39r/E=
X-Received: by 2002:a37:a993:: with SMTP id s141mr8833864qke.265.1618579587454;
 Fri, 16 Apr 2021 06:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae236f05bfde0678@google.com> <20210413134147.54556d9d@gandalf.local.home>
 <20210413134314.16068eeb@gandalf.local.home> <CACT4Y+ZrkE=ZKKncTOJRJgOTNfU8PGz=k+8V+0602ftTCHkc6Q@mail.gmail.com>
 <20210413144009.6ed2feb8@gandalf.local.home> <20210413144335.4ff14cf2@gandalf.local.home>
 <CACT4Y+YipDUHQiqJ=gtEeBQGz2AjqT6e_fje5DHsm0a5e+-GRQ@mail.gmail.com> <20210416091300.0758c62a@gandalf.local.home>
In-Reply-To: <20210416091300.0758c62a@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Apr 2021 15:26:15 +0200
Message-ID: <CACT4Y+YutXjDarTu_J=EjsDDgt5LzXyNjN-hd1ZpWg6kDYgw6g@mail.gmail.com>
Subject: Re: Bisections with different bug manifestations
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, masahiroy@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rafael.j.wysocki@intel.com,
        Sean Christopherson <seanjc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16, 2021 at 3:13 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 16 Apr 2021 09:51:45 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > If you look at substantial base of bisection logs, you will find lots
> > of cases where bug types, functions don't match. Kernel crashes
> > differently even on the same revision. And obviously things change if
> > you change revisions. Also if you see presumably a different bug, what
> > does it say regarding the original bug.
>
> Yes, but there are also several types of cases where the issue will be the
> same. Namely lockdep. I agree that use after free warnings can have a side
> effect, and may be more difficult.

But how do we know it's lockdep, rather than a use-after-free
manifested as lockdep?
A Significant portion of kernel bugs are caused by concurrency and can
manifest in different ways, e.g. these are not lockdep, or WARN, or
use-after-free, but rather a race in nature.

> But there's many other bugs that remain
> consistent across kernels. And if you stumble on one of them, look for it
> only.

For example? Does not look to be true for WARN, BUG, KASAN,
"inconsistent lock state".


> And if you hit another bug, and if it doesn't crash, then ignore it (of
> course this could be an issue if you have panic on warning set). But
> otherwise, just skip it.

It's not possible to skip, say, BUG.
And if we skip, say, a use-after-free, how do we know we are not
making things worse? Because now we are running on corrupted memory,
so anything can happen. Definitely a stray lockdep report can happen,
or other way around not happen when it should...

> > I would very much like to improve automatic bisection quality, but it
> > does not look trivial at all.
> >
> > Some random examples where, say, your hypothesis of WARN-to-WARN,
> > BUG-to-BUG does not hold even on the same kernel revision (add to this
>
> At least lockdep to lockdep, as when I do manual bisects, that's exactly
> what I look for, and ignore all other warnings. And that has found the
> problem commit pretty much every time.

What lockdep bug types do you mean? All?
In the examples above you can see at least "inconsistent lock state"
mixed with 2 other completely different bug types.

> > different revisions and the fact that a different bug does not give
> > info regarding the original bug):
> >
>
> Can you tell me that all these examples bisected to the commit that caused
> the bug? Because if it did not, then you may have just proved my point ;-)

I don't know now what was the result, but for a single run these were
manifestations of the same root bug.
E.g. see below, that's UAF in fuse_dev_do_read vs WARNING in
request_end. request_end is also fuse. And you can see that a memory
corruption causing a random bug type, in this case WARNING, but can as
well be LOCKDEP.


> > run #0: crashed: KASAN: use-after-free Read in fuse_dev_do_read
> > run #1: crashed: WARNING in request_end
> > run #2: crashed: KASAN: use-after-free Read in fuse_dev_do_read
> > run #3: OK
> > run #4: OK
