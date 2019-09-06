Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11026C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D4420838
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567784585;
	bh=aEJ18l4wJ8bPMUW6X6opdijySgdXK3bpBCcw8vqN94A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iIMvI3FyL+bLWnaCpMN2bvFVE7q5J9000mHZ1l9jOzMI0fnlSxBNpQsYePfqNxMwH
	 yyCaZVi/zJyoSr14iLf92HfyFsY7VyiZMSM7mupnhpdeC1iyvNEuIGYa/qaPrrsSzv
	 ED028MfHqiu677g6cp3EoR3Ucudi6/evB7rCyi+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394896AbfIFPnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:43:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40003 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390317AbfIFPnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 11:43:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so6405521ljw.7
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXqD3C73hqZbQh8+pyGdwCZwxnrqPGKEEp+0kRpG5I8=;
        b=DYc6W/hyCfxAxHbkWTmDrh+ODKc6x42+38HNklF0/ptlANxl7RT8hSgyEdfrQHi6Xh
         5ChSGqRSbxC9ue8UUxHuvt5x60DSZdetyLFMHeKirW5J2qmzjwoayW12EsnqZorry25V
         3FxxQI4aE2n0uiQzkRk4wz84DwPGTYa2AbbHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXqD3C73hqZbQh8+pyGdwCZwxnrqPGKEEp+0kRpG5I8=;
        b=I3jqwFe2tKP7s1aqMbyqbgTi2qJL7D+dvmRojsF37b/0qwxrCRAMh0721c+91ZZcm2
         pUc9XsnRqWAO+LPBjHjyoyMalNqY3+g0ouaQzHlCCG1y3AyeF6w2VxqgegXsmD+V0nSY
         t1Bj9ZHh8PiboYAPSrEolqxtCDdvy/tzPdLlwz0jAbI3SjN33BktiwHoRJVM5qsFKaoL
         My7L3T5/m9173DERDdLznf4e3DOXWQk5clPev7lZQzWyCkDG7r3R+CEnVSRFUFRapSdt
         MZhnthGMP6UHMBZWO5g0ITxw0gH2ZwcKz82ibKTxJ107dB6YGt6sfTaVjE3Og71xZGwX
         DdKg==
X-Gm-Message-State: APjAAAWXEfORGXvt0C9XPMdM92sRI5ff8Uf1xRFwq4mzk5H6mt5JbdLR
        4HOwKFo9dCtWhhIcYjkVpFagoGl2VMw=
X-Google-Smtp-Source: APXvYqxPTNGm9v9LfwIZadcm+Cw5AqQ4WvIckLARzmB4w9rOAT4NFSZyYj5VOMQn2Qy9oBadZN69Kg==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr6095083lji.224.1567784581198;
        Fri, 06 Sep 2019 08:43:01 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i21sm1194425lfl.44.2019.09.06.08.43.00
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:43:00 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y4so5412111lfe.11
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 08:43:00 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr6833712lfp.134.1567784162071;
 Fri, 06 Sep 2019 08:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk>
In-Reply-To: <27732.1567764557@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 08:35:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
Message-ID: <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 6, 2019 at 3:09 AM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > But it's *literally* just finding the places that work with
> > pipe->curbuf/nrbufs and making them use atomic updates.
>
> No.  It really isn't.  That's two variables that describe the occupied section
> of the buffer.  Unless you have something like a 68020 with CAS2, or put them
> next to each other so you can use CMPXCHG8, you can't do that.
>
> They need converting to head/tail pointers first.

You misunderstand - because I phrased it badly. I meant "atomic" in
the traditional kernel sense, as in "usable in not thread context" (eg
GFP_ATOMIC etc).

I'd start out just using a spinlock.

I do agree that we could try to be fancy and do it entirely locklessly
too, and I mentioned that in another part:

 "[..] it should not
  be all that hard to just make the whole "curbuf/nrbufs" handling use
  its own locking (maybe even some lockless atomics and cmpxchg)"

but I also very much agree that it's much more complex.

The main complexity of a lockless thing is actually almost certainly
not in curbuf/nrbufs, because those could easily be packed as two
16-bit values in a 32-bit entity and then regular cmpxchg works fine.

No, the complexity in the lockless model is that then you have to be
very careful with the "buf[]" array update too.  Maybe that's trivial
(just make sure that they are NULL when not used), but it just looks
less than wonderfully easy.

So a lockless update I'm sure is _doable_ with some cleverness, but is
probably not really worth it.

That's particularly true since we already *have* a spinlock that we
would take anyway: the we could strive to use the waitqueue spinlock
in pipe->wait, and not even really add any new locking. That would
require a bit of cleverness too and re-ordering things more, but we do
that in other places (eg completions, but the fs_pin code does it too,
and a few other cases.

Look for "wake_up_locked()" and friends, which is a sure-fire sign
that somebody is playing games and taking the wait-queue lock manually
for their own nefarious reasons.

> > They really would work with almost anything. You could even mix-and-match
> > "data generated by kernel" and "data done by 'write()' or 'splice()' by a
> > user process".
>
> Imagine that userspace writes a large message and takes the mutex.  At the
> same time something in softirq context decides *it* wants to write a message -
> it can't take the mutex and it can't wait, so the userspace write would have
> to cause the kernel message to be dropped.

No. You're missing the point entirely.

The mutex is entirely immaterial for the "insert a message". It is
only used for user-space synchronization. The "add message to the pipe
buffers" would only do the low-level buffer updates (whether using a
new spinlock, re-using the pipe waitqueue lock, or entirely
locklessly, ends up being then just an implementation detail).

Note that user-space writes are defined to be atomic, but they are (a)
not ordered and (b) only atomic up to a single buffer entry (which is
that PIPE_BUF limit). So you can always put in a new buffer entry at
any time.

Obviously if a user space write just fills up the whole queue (or
_other_ messages fill up the whole queue) you'd have to drop the
notification. But that's always true. That's true even in your thing.
The only difference is that we _allow_ other user spaces to write to
the notification queue too.

But if you don't want to allow that, then don't give out the write
side of the pipe to any untrusted user space.

But in *general*, allowing user space to write to the pipe is a great
feature: it means that your notification source *can* be a user space
daemon that you gave the write side of the pipe to (possibly using fd
passing, possibly by just forking your own user-space child or cloning
a thread).

So for example, from a consumer standpoint, you can start off doing
these things in user space with a helper thread that feeds the pipe
(for example, polling /proc/mounts every second), and then when you've
prototyped it and are happy with it, you can add the system call (or
ioctl or whatever) to make the kernel generate the messages so that
you don't have to poll.

But now, once you have the kernel patch, you already have a proven
user, and you can show numbers ("My user-space thing works, but it
uses up 0.1% CPU time and has that nasty up-to-one-second latency
because of polling"). Ta-daa!

End result: it's backwards compatible, it's prototypable, and it's
fairly easily extensible. Want to add a new source of events? Just
pass the pipe to any random piece of code you want. It needs kernel
support only when you've proven the concept _and_ you can show that
"yeah, this user space polling model is a real performance or
complexity problem" or whatever.

This is why I like pipes. You can use them today. They are simple, and
extensible, and you don't need to come up with a new subsystem and
some untested ad-hoc thing that nobody has actually used.

And they work automatically with all the existing infrastructure. They
work with whatever perl or shell scripts, they work with poll/select
loops, they work with user-space sources of events, they are just very
flexible.

                     Linus
