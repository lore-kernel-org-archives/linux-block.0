Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk>
 <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk>
Date: Wed, 22 Feb 2017 11:14:58 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/21/2017 04:23 PM, Linus Torvalds wrote:
> On Tue, Feb 21, 2017 at 3:15 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> But under a device managed by blk-mq, that device exposes a number of
>> hardware queues. For older style devices, that number is typically 1
>> (single queue).
> 
> ... but why would this ever be different from the normal IO scheduler?

Because we have a different set of schedulers for blk-mq, different
than the legacy path. mq-deadline is a basic port that will work
fine with rotational storage, but it's not going to be a good choice
for NVMe because of scalability issues.

We'll have BFQ on the blk-mq side, catering to the needs of those
folks that currently rely on the richer feature set that CFQ supports.

We've continually been working towards getting rid of the legacy
IO path, and its set of schedulers. So if it's any consolation,
those options will go away in the future.

> IOW, what makes single-queue mq scheduling so special that
> 
>  (a) it needs its own config option
> 
>  (b) it is different from just the regular IO scheduler in the first place?
> 
> So the whole thing stinks. The fact that it then has an
> incomprehensible config option seems to be just gravy on top of the
> crap.

What do you mean by "the regular IO scheduler"? These are different
schedulers.

As explained above, single-queue mq devices generally DO want mq-deadline.
multi-queue mq devices, we don't have a good choice for them right now,
so we retain the current behavior (that we've had since blk-mq was
introduced in 3.13) of NOT doing any IO scheduling for them. If you
do want scheduling for them, set the option, or configure udev to
make the right choice for you.

I agree the wording isn't great, and we can improve that. But I do
think that the current choices make sense.

>> "none" just means that we don't have a scheduler attached.
> 
> .. which makes no sense to me in the first place.
> 
> People used to try to convince us that doing IO schedulers was a
> mistake, because modern disk hardware did a better job than we could
> do in software.
> 
> Those people were full of crap. The regular IO scheduler used to have
> a "NONE" option too. Maybe it even still has one, but only insane
> people actually use it.
> 
> Why is the MQ stuff magically so different that NONE would make sense at all>?

I was never one of those people, and I've always been a strong advocate
for imposing scheduling to keep devices in check. The regular IO scheduler
pool includes "noop", which is probably the one you are thinking of. That
one is a bit different than the new "none" option for blk-mq, in that it
does do insertion sorts and it does do merges. "none" does some merging,
but only where it happens to make sense. There's no insertion sorting.

> And equally importantly: why do we _ask_ people these issues? Is this
> some kind of sick "cover your ass" thing, where you can say "well, I
> asked about it", when inevitably the choice ends up being the wrong
> one?
> 
> We have too damn many Kconfig options as-is, I'm trying to push back
> on them. These two options seem fundamentally broken and stupid.
> 
> The "we have no good idea, so let's add a Kconfig option" seems like a
> broken excuse for these things existing.
> 
> So why ask this question in the first place?
> 
> Is there any possible reason why "NONE" is a good option at all? And
> if it is the _only_ option (because no other better choice exists), it
> damn well shouldn't be a kconfig option!

I'm all for NOT asking questions, and not providing tunables. That's
generally how I do write code. See the blk-wbt stuff, for instance, that
basically just has one tunable that's set sanely by default, and we
figure out the rest.

I don't want to regress performance of blk-mq devices by attaching
mq-deadline to them. When we do have a sane scheduler choice, we'll
make that the default. And yes, maybe we can remove the Kconfig option
at that point.

For single queue devices, we could kill the option. But we're expecting
bfq-mq for 4.12, and we'll want to have the option at that point unless
you want to rely solely on runtime setting of the scheduler through
udev or by the sysadmin.

-- 
Jens Axboe
