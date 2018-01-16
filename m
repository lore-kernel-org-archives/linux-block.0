Return-Path: <ming.lei@redhat.com>
Date: Tue, 16 Jan 2018 09:57:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: axboe@kernel.dk, Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 0/3] blk-mq: issue request directly for
 blk_insert_cloned_request
Message-ID: <20180116015710.GF3213@ming.t460p>
References: <20180115165810.2515-1-ming.lei@redhat.com>
 <20180115174344.GA17634@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115174344.GA17634@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 15, 2018 at 12:43:44PM -0500, Mike Snitzer wrote:
> On Mon, Jan 15 2018 at 11:58am -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Hi Guys,
> > 
> > The 3 paches changes the blk-mq part of blk_insert_cloned_request(),
> > in which we switch to blk_mq_try_issue_directly(), so that both dm-rq
> > and blk-mq can get the dispatch result of underlying queue, and with
> > this information, blk-mq can handle IO merge much better, then
> > sequential I/O performance is improved much.
> > 
> > In my dm-mpath over virtio-scsi test, this whole patchset improves
> > sequential IO by 3X ~ 5X.
> > 
> > V4:
> > 	- remove dm patches which are in DM tree already
> > 	- cleanup __blk_mq_issue_req as suggested by Jens
> > 
> 
> Ming,
> 
> You dropped the header cleanups that I did in v3 ("blk-mq: issue request
> directly for blk_insert_cloned_request") being the one header I care
> about being updated).
> 
> I also worked in parallel on my own v4 to address Jens' dislike for v3's
> 3 returns.  But I skinned the cat a different way, by dropping your
> first patch that introduces the __blk_mq_issue_req helper, please see
> these 2 commits:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=block-4.16&id=40f8947784128bb83dc5f7a6aed7ed230222f675
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=block-4.16&id=f641015f42f41df75220313ee62e8241f2feeeed
> 
> I think it makes the changes more obvious (not spread across 2 methods
> and doesn't require use of BLK_STS_AGAIN).
> 
> Happy to yield to Jens to decide which he prefers.
> 
> Jens, if you'd like to pick my variant of v4 up they are here, thanks!

Hi Mike,

Looks we were working on it at the same time, I am fine with your V4.

Jens, please let us know if Mike's V4 is OK, if not, we can make V5/.., :-)

Thanks,
Ming
