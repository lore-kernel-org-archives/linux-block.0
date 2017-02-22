Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk>
 <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk>
 <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk>
Date: Wed, 22 Feb 2017 11:41:28 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 11:26 AM, Linus Torvalds wrote:
> On Wed, Feb 22, 2017 at 10:14 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> What do you mean by "the regular IO scheduler"? These are different
>> schedulers.
> 
> Not to the user they aren't.
> 
> If the user already answered once about the IO schedulers, we damn
> well shouldn't ask again abotu another small implementaiton detail.
> 
> How hard is this to understand? You're asking users stupid things.

The fact is that we have two different sets, until we can yank
the old ones. So I can't just ask one question, since the sets
aren't identical.

This IS confusing to the user, and it's an artifact of the situation
that we have where we are phasing out the old IO path and switching
to blk-mq. I don't want to user to know about blk-mq, I just want
it to be what everything runs on. But until that happens, and it is
happening, we are going to be stuck with that situation.

We have this exposed in other places, too. Like for dm, and for
SCSI. Not a perfect situation, but something that WILL go away
eventually.

> It's not just about the wording. It's a fundamental issue.  These
> questions are about internal implementation details. They make no
> sense to a user. They don't even make sense to a kernel developer, for
> chrissake!
> 
> Don't make the kconfig mess worse. This "we can't make good defaults
> in the kernel, so ask users about random things that they cannot
> possibly answer" model is not an acceptable model.

There are good defaults! mq single-queue should default to mq-deadline,
and mq multi-queue should default to "none" for now. If you feel that
strongly about it (and I'm guessing you do, judging by the speed
typing and generally annoyed demeanor), then by all means, let's kill
the config entries and I'll just hardwire the defaults. The config
entries were implemented similarly to the old schedulers, and each
scheduler is selectable individually. I'd greatly prefer just
improving the wording so it makes more sense.

> If the new schedulers aren't better than NOOP, they shouldn't exist.
> And if you want people to be able to test, they should be dynamic.

They are dynamic! You can build them as modules, you can switch at
runtime. Just like we have always been able to. I can't make it more
dynamic than that. We're reusing the same internal infrastructure for
that, AND the user visible ABI for checking what is available, and
setting a new one.

> And dammit, IF YOU DON'T EVEN KNOW, WHY THE HELL ARE YOU ASKING THE POOR USER?

BECAUSE IT'S POLICY! Fact of that matter is, if I just default to what
we had before, it'd all be running with none. In a few years time, if
I'm lucky, someone will have shipped udev rules setting this appropriately.
If I ask the question, we'll get testing NOW. People will run with
the default set.

-- 
Jens Axboe
