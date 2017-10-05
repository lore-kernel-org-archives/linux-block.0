Return-Path: <tglx@linutronix.de>
Date: Thu, 5 Oct 2017 23:53:52 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
    Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
    Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
    Nicholas Piggin <npiggin@gmail.com>,
    Vladimir Davydov <vdavydov.dev@gmail.com>,
    Matthew Wilcox <mawilcox@microsoft.com>, Jeff Layton <jlayton@redhat.com>,
    linux-block@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] block/laptop_mode: Convert timers to use timer_setup()
In-Reply-To: <a74e292d-a0c5-6e75-576b-bb29580028e2@kernel.dk>
Message-ID: <alpine.DEB.2.20.1710052335030.2398@nanos>
References: <20171005004924.GA23053@beast> <4d4ccf50-d0b6-a525-dc73-0d64d26da68a@kernel.dk> <CAGXu5jJA4jfZCnhjLrO6fePVJqoJw7Hj7VF1sGLimU2fFu4AgQ@mail.gmail.com> <57ad0ef1-e147-8507-9922-aa72ad47350e@kernel.dk> <alpine.DEB.2.20.1710052102480.2398@nanos>
 <a74e292d-a0c5-6e75-576b-bb29580028e2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Jens,

On Thu, 5 Oct 2017, Jens Axboe wrote:
> On 10/05/2017 01:23 PM, Thomas Gleixner wrote:
> > Come on. You know very well that a prerequisite for global changes which is
> > not yet used in Linus tree can get merged post merge windew in order to
> > avoid massive inter maintainer tree dependencies. We've done that before.
> 
> My point is that doing it this late makes things harder than they should
> have been. If this was in for -rc1, it would have made things a lot
> easier. Or even -rc2. I try and wait to fork off the block tree for as
> long as I can, -rc2 is generally where that happens.

Well, yes. I know it's about habits. There is no real technical reason not
to merge -rc3 or later into your devel/next branch. I actually do that for
various reasons, one being that I prefer to have halfways testable
branches, which is often not the case when they are based of rc1, which is
especially true in this 4.14 cycle. The other is to pick up stuff which
went into Linus tree via a urgent branch or even got applied from mail
directly.

> I'm not judging this based on whether I find it interesting or not, but
> rather if it's something that's generally important to get in. Maybe it
> is, but I don't see any justification for that at all. So just looking
> at the isolated change, it does not strike me as something that's
> important enough to warrant special treatment (and the pain associated
> with that). I don't care about the core change, it's obviously trivial.
> Expecting maintainers to pick up this dependency asap mid cycle is what
> sucks.

I'm really not getting the 'pain' point.

'git merge linus' is not really a pain and it does not break workflows
assumed that you do that on a branch which has immutable state. If you want
to keep your branches open for rebasing due to some wreckage in the middle
of it, that's a different story.

> Please stop accusing me of being hypocritical. I'm questionning the
> timing of the change, that should be possible without someone resorting
> to ad hominem attacks.

Well, it seemed hypocritical to me for a hopefully understandable reason. I
didn't want to attack or offend you in any way.

I just know from repeated experience how painful it is to do full tree
overhauls and sit on large patch queues for a long time. There is some
point where you need to get things going and I really appreciate the work
of people doing that. Refactoring the kernel to get rid of legacy burdens
and in this case to address a popular attack vector is definitely useful
for everybody and should be supported. We tried to make it easy by pushing
this to Linus and I really did not expect that merging Linus -rc3 into a
devel/next branch is a painful work to do.

As Kees said already, we can set that particular patch aside and push it
along with the rest of ignored ones around 15-rc1 time so we can remove the
old interfaces. Though we hopefully wont end up with a gazillion of ignored
or considered too painful ones.

Thanks,

	tglx
