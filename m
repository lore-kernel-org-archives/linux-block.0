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
 <CA+55aFwXmBsHBPJJLzxnY0H4ib-iro__TdYA6=rpUnoh+BbyGA@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c1d07f31-40e7-0fb0-7251-24067564a0ad@kernel.dk>
Date: Wed, 22 Feb 2017 11:44:41 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFwXmBsHBPJJLzxnY0H4ib-iro__TdYA6=rpUnoh+BbyGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 11:42 AM, Linus Torvalds wrote:
> On Wed, Feb 22, 2017 at 10:26 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> And dammit, IF YOU DON'T EVEN KNOW, WHY THE HELL ARE YOU ASKING THE POOR USER?
> 
> Basically, I'm pushing back on config options that I can't personally
> even sanely answer.

I got that much, and I don't disagree on that part.

> If it's a config option about "do I have a particular piece of
> hardware", it makes sense. But these new ones were just complete
> garbage.
> 
> The whole "default IO scheduler" thing is a disease. We should stop
> making up these shit schedulers and then say "we don't know which one
> works best for you".
> 
> All it does is encourage developers to make shortcuts and create crap
> that isn't generically useful, and then blame the user and say "well,
> you should have picked a different scheduler" when they say "this does
> not work well for me".
> 
> We have had too many of those kinds of broken choices.  And when the
> new Kconfig options get so confusing and so esoteric that I go "Hmm, I
> have no idea if my hardware does a single queue or not", I put my foot
> down.
> 
> When the IO scheduler questions were about a generic IO scheduler for
> everything, I can kind of understand them. I think it was still a
> mistake (for the reasons outline above), but at least it was a
> comprehensible question to ask.
> 
> But when it gets to "what should I do about a single-queue version of
> a MQ scheduler", the question is no longer even remotely sensible. The
> question should simply NOT EXIST. There is no possible valid reason to
> ask that kind of crap.

OK, so here's what I'll do:

1) We'll kill the default scheduler choices. sq blk-mq will default to
   mq-deadline, mq blk-mq will default to "none" (at least for now, until
   the new scheduler is done).
2) The individual schedulers will be y/m/n selectable, just like any
   other driver.

I hope that works for everyone.

-- 
Jens Axboe
