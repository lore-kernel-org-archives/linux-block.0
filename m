Return-Path: <ming.lei@redhat.com>
Date: Mon, 30 Jul 2018 06:43:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block/023: performance test on queue creation & cleanup
Message-ID: <20180729224322.GB30770@ming.t460p>
References: <20180704052956.5110-1-ming.lei@redhat.com>
 <20180725213314.GD16847@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725213314.GD16847@vader>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 02:33:14PM -0700, Omar Sandoval wrote:
> On Wed, Jul 04, 2018 at 01:29:56PM +0800, Ming Lei wrote:
> > SCSI may have lots of channels, targets or LUNs, so it may
> > take long time for creating and cleaning up queues.
> > 
> > So introduce block/023 and uses null_blk to run this test
> > on both blk-mq and legacy mode, then compare both and check
> > the difference.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tests/block/023     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/023.out |   2 ++
> >  2 files changed, 103 insertions(+)
> >  create mode 100755 tests/block/023
> >  create mode 100755 tests/block/023.out
> 
> Hi, Ming, is this a regression test for "blk-mq: remove
> synchronize_rcu() from blk_mq_del_queue_tag_set()" and "blk-mq: avoid to
> synchronize rcu inside blk_cleanup_queue()"?

Yeah, it is.

It also shows that destroying queue may take much more time than
creating queue, and seems no solution for this one now.

Thanks,
Ming
