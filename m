Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcFCDyR (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 2 Jun 2016 23:54:17 -0400
Date: Thu, 2 Jun 2016 23:54:15 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Shaohua Li <shli@fb.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	sitsofe@yahoo.com, axboe@fb.com, Kernel-team@fb.com
Subject: Re: block: correctly fallback for zeroout
Message-ID: <20160603035415.GA8236@redhat.com>
References: <20160526180813.GA49039@shli-mbp.local>
 <20160529064728.GA14383@infradead.org>
 <yq1h9dbrmwf.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1h9dbrmwf.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 02 2016 at 11:06pm -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> >>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
> 
> Christoph> As part of that I also removed the strange EOPNOTSUPP ignore,
> Christoph> but Mike reverted it just because it changed something in the
> Christoph> dm testsuite.
> 
> Mike?

Yes? ;)

Seems there is some serious confusion going on here.  The entirety of
hch's post (to which you quoted a subset) makes little sense to me.

shli's patch builds ontop of latest blk-lib.c code yet hch said this::
"We've split blkdev_issue_discard into __blkdev_issue_discard and a
small wrapper around in for 4.7, so this will need a bit of an update."

And hch never "removed the strange EOPNOTSUPP ignore".  He preserved it
(see his commit 38f25255330's "return ret != -EOPNOTSUPP ? ret : 0;"
that I adjusted in commit bbd848e0f -- _and_ he expanded it to eat the
early return that I restored).

So I can only infer that hch is still missing why my revert fixes
historic blkdev_issue_discard() behavior that his commit regressed.
Please read commit bbd848e0f's header.  That at least details the early
vs late -EOPNOTSUPP blkdev_issue_discard() return.

But all that nuance aside, AFAICT my commit bbd848e0f ("block: reinstate
early return of -EOPNOTSUPP from blkdev_issue_discard") really has
_nothing_ to do with the issue shli is addressing with his fix.

> Christoph> I still believe we should never ignore it in this helper, and
> Christoph> only do so in callers that believe it's the right thing.
> 
> Yeah.

Hmm...

You agreed to what hch said there about how we should probably always
return EOPNOTSUPP but then you immediately elaborated with details that
mean you don't agree:
 
> I really wish EOPNOTSUPP would just go away except for ioctl callers.
> Now that we have real bi_error I don't understand why we need it.

But hch was originally in favor of _always_ dropping EOPNOTSUPP on the
floor (that is what his commit 38f25255330 did).  Then he said he
disagrees with these interfaces playing games with masking EOPNOTSUPP --
to which you seemingly really don't agree.  Unless I'm completely
misreading you.

Anyway, shli is at least making it so that blkdev_issue_zerout() can
fallback to other mechanisms as needed.
