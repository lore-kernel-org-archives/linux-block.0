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
 <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk>
 <CA+55aFzK6j+jM8eHcMirbe2huV1RKEmqwrKTYH9YuXWBYZxsug@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2fa1c161-2893-438a-45f9-adbf5284ee71@kernel.dk>
Date: Wed, 22 Feb 2017 11:52:05 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFzK6j+jM8eHcMirbe2huV1RKEmqwrKTYH9YuXWBYZxsug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 11:45 AM, Linus Torvalds wrote:
> On Wed, Feb 22, 2017 at 10:41 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> The fact is that we have two different sets, until we can yank
>> the old ones. So I can't just ask one question, since the sets
>> aren't identical.
> 
> Bullshit.
> 
> I'm, saying: rip out the question ENTIRELY. For *both* cases.
> 
> If you cannot yourself give a good answer, then there's no f*cking way
> any user can give a good answer. So asking the question is totally and
> utterly pointless.
> 
> All it means is that different people will try different (in random
> ways) configurations, and the end result is random crap.
> 
> So get rid of those questions. Pick a default, and live with it. And
> if people complain about performance, fix the performance issue.
> 
> It's that simple.

No, it's not that simple at all. Fact is, some optimizations make sense
for some workloads, and some do not. CFQ works great for some cases, and
it works poorly for others, even if we try to make heuristics that enable
it to work well for all cases. Some optimizations are costly, that's
fine on certain types of hardware or maybe that's a trade off you want
to make. Or we end up with tons of settings for a single driver, that
does not reduce the configuration matrix at all.

By that logic, why do we have ANY config options outside of what drivers
to build? What should I set HZ at? RCU options? Let's default to ext4,
and kill off xfs? Or btrfs? slab/slob/slub/whatever?

Yes, that's taking the argument a bit more to the extreme, but it's the
same damn thing.

I'm fine with getting rid of the default selections, but we're NOT
going to be able to have just one scheduler for everything. We can
make sane defaults based on the hardware type.

-- 
Jens Axboe
