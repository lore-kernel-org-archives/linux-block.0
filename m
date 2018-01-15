Return-Path: <msnitzer@redhat.com>
Date: Mon, 15 Jan 2018 12:43:44 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 0/3] blk-mq: issue request directly for
 blk_insert_cloned_request
Message-ID: <20180115174344.GA17634@redhat.com>
References: <20180115165810.2515-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115165810.2515-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 15 2018 at 11:58am -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> Hi Guys,
> 
> The 3 paches changes the blk-mq part of blk_insert_cloned_request(),
> in which we switch to blk_mq_try_issue_directly(), so that both dm-rq
> and blk-mq can get the dispatch result of underlying queue, and with
> this information, blk-mq can handle IO merge much better, then
> sequential I/O performance is improved much.
> 
> In my dm-mpath over virtio-scsi test, this whole patchset improves
> sequential IO by 3X ~ 5X.
> 
> V4:
> 	- remove dm patches which are in DM tree already
> 	- cleanup __blk_mq_issue_req as suggested by Jens
> 

Ming,

You dropped the header cleanups that I did in v3 ("blk-mq: issue request
directly for blk_insert_cloned_request") being the one header I care
about being updated).

I also worked in parallel on my own v4 to address Jens' dislike for v3's
3 returns.  But I skinned the cat a different way, by dropping your
first patch that introduces the __blk_mq_issue_req helper, please see
these 2 commits:

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=block-4.16&id=40f8947784128bb83dc5f7a6aed7ed230222f675
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=block-4.16&id=f641015f42f41df75220313ee62e8241f2feeeed

I think it makes the changes more obvious (not spread across 2 methods
and doesn't require use of BLK_STS_AGAIN).

Happy to yield to Jens to decide which he prefers.

Jens, if you'd like to pick my variant of v4 up they are here, thanks!

The following changes since commit c100ec49fdd2222836ff8a17c7bfcc7611d2ee2b:

  dm: fix incomplete request_queue initialization (2018-01-15 08:54:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-block-4.16/dm-changes-2

for you to fetch changes up to d86beab5712a8f18123011487dee797a1e3a07e1:

  blk-mq: issue request directly for blk_insert_cloned_request (2018-01-15 12:40:44 -0500)

----------------------------------------------------------------
- Ming's blk-mq improvements to blk_insert_cloned_request(), which is
  used exclusively by request-based DM's blk-mq mode, that enable
  substantial dm-mpath sequential IO performance improvements.

----------------------------------------------------------------
Ming Lei (2):
      blk-mq: return dispatch result from blk_mq_try_issue_directly
      blk-mq: issue request directly for blk_insert_cloned_request

 block/blk-core.c   |  3 +--
 block/blk-mq.c     | 65 +++++++++++++++++++++++++++++++++++++++++-------------
 block/blk-mq.h     |  3 +++
 drivers/md/dm-rq.c | 19 +++++++++++++---
 4 files changed, 70 insertions(+), 20 deletions(-)
