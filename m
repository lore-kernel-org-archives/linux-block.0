Return-Path: <ming.lei@redhat.com>
Date: Fri, 8 Sep 2017 10:25:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Cathy Avery <cavery@redhat.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [GIT PULL] First set of block changes for 4.14-rc1
Message-ID: <20170908022520.GD3802@ming.t460p>
References: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
 <CA+55aFwrpd+fz3jxK3d6dckFcApc=aCZOrsKogxRYZozwUdHrg@mail.gmail.com>
 <dfc0dc22-00c3-a28b-93d5-15dad2e55d9f@kernel.dk>
 <CA+55aFyFYX0XAQdqXs65KP-TpBCh7buhzq-HC7ZJ_9p81oOc+w@mail.gmail.com>
 <05ddaa43-3467-ce73-b98c-028c2b7dcca2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05ddaa43-3467-ce73-b98c-028c2b7dcca2@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 07, 2017 at 01:47:44PM -0600, Jens Axboe wrote:
> On 09/07/2017 01:38 PM, Linus Torvalds wrote:
> > On Thu, Sep 7, 2017 at 12:27 PM, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Which was committed yesterday? It was not from my tree. I try to keep
> >> an eye out for potential conflicts or issues.
> > 
> > It was from Andrew, so I'm assuming it was in linux-next. Not as a git
> > tree, but as the usual akpm branch.
> > 
> > I'm not sure why I didn't see any reports from linux-next about it,
> > though - and I looked.
> > 
> > There was no actual visible merge problem, because the conflict was
> > not a data conflict but a semantic one.
> > 
> > But the issue showed up for a trivial allmodconfig build, so it
> > *should* have been caught automatically.
> > 
> > But it's not even the conflict that annoys me.
> > 
> > It's the *reason* for the conflict - the block layer churn that you
> > said was done. We've had too much of it.
> > 
> >>> We need *stability* by now, after these crazy changes. Make sure
> >>> that happens.
> 
> I might have missed a build notice from linux-next, since I know for a
> fact that all my stuff is in -next, updated daily, and Andrew's tree
> definitely is too.
> 
> >> I am pushing back, but I can't embargo any sort of API change. This one has
> >> good reasoning behind it, which is actually nicely explained in the commit
> >> itself. It's not pointless churn, which I would define as change just for
> >> the sake of change itself. Or pointless cleanups.
> > 
> > You can definitely put your foot down on any more random changes to
> > the bio infrastructure. Including for good reasons.
> 
> And I am, but this one wasn't random. As I said, some of the previous
> releases have had more frivolous changes that should have been pushed
> back harder on. And particularly nvme, where fixes that go in after the
> merge window have been doing pointless cleanups while fixing issues,
> causing unnecessary pain for the next release. I am definitely pushing
> back hard on those, just last week after more of that showed up.
> 
> You'll see exactly one of those when I send in the next merge request,
> which sucks, and which was the reason the yelling in that area recently.
> 
> > We have had some serious issues in the block layer - and I'm not
> > talking about the merge conflicts. I'm talking about just the
> > collateral damage, with things like SCSI having to revert using blk-mq
> > by default etc.
> 
> I'm a bit puzzled as to why the suspend/resume thing has existed for so
> long, honestly. But some of these issues don't show themselves until you
> flip the switch. A lot of the production setups have been using scsi-mq
> for YEARS without issues, but obviously they don't hit this. Given how
> big of a switch this is, it's hard to avoid minor fallout. We're dealing
> with it.

Hi Jens,

If you mean the I/O hang during suspend/resume reported by Oleksandr,
that shouldn't be blk-mq only. The root cause is in SCSI's quiesce
design(even in blk-mq's quiesce, but no such issue because no new
request is allocated in the context which queue is quiesced.)

The issue is a bit long-term, since Cathy can reproduce this kind of
I/O hang on 2.6.32 based kernel.

I am working on fixing that[1], but looks the preempt quiesce still
need to be nested, so will post out V4 with supporting nested preempt
quiesce.

The real SCSI_MQ regression is the report of 'SCSI-MQ performance
regression'[2], and the commit of 'scsi: default to scsi-mq' was
reverted after this report. Patch for this regression has been
posted for several round, and the V4 [3] should be ready for merge, looks
it is ignored because of the merge timing?


[1] https://marc.info/?l=linux-scsi&m=150435774503165&w=2
[2] https://marc.info/?l=linux-kernel&m=150271934904399&w=2
[3] https://marc.info/?t=150436555700002&r=1&w=2

-- 
Ming
