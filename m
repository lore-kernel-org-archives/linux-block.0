Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] First set of block changes for 4.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
 <CA+55aFwrpd+fz3jxK3d6dckFcApc=aCZOrsKogxRYZozwUdHrg@mail.gmail.com>
 <dfc0dc22-00c3-a28b-93d5-15dad2e55d9f@kernel.dk>
 <CA+55aFyFYX0XAQdqXs65KP-TpBCh7buhzq-HC7ZJ_9p81oOc+w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05ddaa43-3467-ce73-b98c-028c2b7dcca2@kernel.dk>
Date: Thu, 7 Sep 2017 13:47:44 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFyFYX0XAQdqXs65KP-TpBCh7buhzq-HC7ZJ_9p81oOc+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/07/2017 01:38 PM, Linus Torvalds wrote:
> On Thu, Sep 7, 2017 at 12:27 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Which was committed yesterday? It was not from my tree. I try to keep
>> an eye out for potential conflicts or issues.
> 
> It was from Andrew, so I'm assuming it was in linux-next. Not as a git
> tree, but as the usual akpm branch.
> 
> I'm not sure why I didn't see any reports from linux-next about it,
> though - and I looked.
> 
> There was no actual visible merge problem, because the conflict was
> not a data conflict but a semantic one.
> 
> But the issue showed up for a trivial allmodconfig build, so it
> *should* have been caught automatically.
> 
> But it's not even the conflict that annoys me.
> 
> It's the *reason* for the conflict - the block layer churn that you
> said was done. We've had too much of it.
> 
>>> We need *stability* by now, after these crazy changes. Make sure
>>> that happens.

I might have missed a build notice from linux-next, since I know for a
fact that all my stuff is in -next, updated daily, and Andrew's tree
definitely is too.

>> I am pushing back, but I can't embargo any sort of API change. This one has
>> good reasoning behind it, which is actually nicely explained in the commit
>> itself. It's not pointless churn, which I would define as change just for
>> the sake of change itself. Or pointless cleanups.
> 
> You can definitely put your foot down on any more random changes to
> the bio infrastructure. Including for good reasons.

And I am, but this one wasn't random. As I said, some of the previous
releases have had more frivolous changes that should have been pushed
back harder on. And particularly nvme, where fixes that go in after the
merge window have been doing pointless cleanups while fixing issues,
causing unnecessary pain for the next release. I am definitely pushing
back hard on those, just last week after more of that showed up.

You'll see exactly one of those when I send in the next merge request,
which sucks, and which was the reason the yelling in that area recently.

> We have had some serious issues in the block layer - and I'm not
> talking about the merge conflicts. I'm talking about just the
> collateral damage, with things like SCSI having to revert using blk-mq
> by default etc.

I'm a bit puzzled as to why the suspend/resume thing has existed for so
long, honestly. But some of these issues don't show themselves until you
flip the switch. A lot of the production setups have been using scsi-mq
for YEARS without issues, but obviously they don't hit this. Given how
big of a switch this is, it's hard to avoid minor fallout. We're dealing
with it.

> Christ, things like that are pretty *fundamnetal*, wouldn't you say.
> Get those right before doing more churn. And aim to have one or two
> releases literally just fixing things, with a "no churn" rule.

That's the plan...

-- 
Jens Axboe
