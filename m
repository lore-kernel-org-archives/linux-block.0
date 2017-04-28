Return-Path: <hch@lst.de>
Date: Fri, 28 Apr 2017 16:09:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request
	prototypes
Message-ID: <20170428140923.GA32073@lst.de>
References: <20170427174501.18965-1-hch@lst.de> <20170427174501.18965-2-hch@lst.de> <x49inlpsoey.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49inlpsoey.fsf@segfault.boston.devel.redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 27, 2017 at 02:20:21PM -0400, Jeff Moyer wrote:
> Hi, Christoph,
> 
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Remove the request_idx parameter, which can't be used safely now that we
> > support I/O schedulers with blk-mq.  Except for a superflous check in
> > mtip32xx it was unused anyway.
> 
> I'm not sure how your patch builds.  If I look at the mtip32xx driver in
> for-4.12/post-merge, I see this:

Meh, you're right.  It did build fine when I tested it based on Jens'
for-4.12/block + my nvme PR.  But it seems like the post-merge merge
branch doesn't have the previous mtip32xxx fix yet that is a prerequisite
for this change.  Jens:  any idea why?  I'm getting lost in the maze
of branches..

> If you got rid of request_idx, then this shouldn't build.  So, is there
> some other prerequisite patch I'm missing?

Yes, both you and I are.  It's "mtip32xx: use runtime tag to initialize
command header" which is in Jens' for-4.12/block tree, but not in the
post-merge one.

> 
> Note that the patch that introduced the request_idx check fixed a bug,
> where module load would walk off the end of an array.  See commit
> 74c9c9134bf8.

Yes, but that behavior is gone with the above patch, which was
necessary to support blk-mq I/O schedulers.
