Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 28 Feb 2017 21:50:45 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Parav Pandit <parav@mellanox.com>
Cc: Jens Axboe <axboe@kernel.dk>, "axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: connect cmd error for nvme-rdma with eventual kernel crash
Message-ID: <20170301055045.GA27251@vader>
References: <VI1PR0502MB3008851A3D20ECF93FC70FCCD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <A520FEF3-9BB7-4265-ADBA-29ADE118B971@kernel.dk>
 <VI1PR0502MB3008EA53FCF29CF9E993918BD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR0502MB3008EA53FCF29CF9E993918BD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 01, 2017 at 04:55:23AM +0000, Parav Pandit wrote:
> Hi Jens,
> 
> > -----Original Message-----
> > From: Jens Axboe [mailto:axboe@kernel.dk]
> > Subject: Re: connect cmd error for nvme-rdma with eventual kernel crash
> > 
> > > On Feb 28, 2017, at 5:57 PM, Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > Hi Jens,
> > >
> > > With your commit 2af8cbe30531eca73c8f3ba277f155fc0020b01a in
> > > linux-block git tree, There are two requests tables. Static and dynamic of
> > same size.
> > > However function blk_mq_tag_to_rq() always try to get the tag from the
> > dynamic table which doesn't seem to be always initialized.
> > >
> > > I am running nvme-rdma initiator and it fails to find the request for the
> > given tag when command completes.
> > > Command triggers error recovery with "tag not found" error.
> > > Eventually kernel is crashing in blk_mq_queue_tag_busy_iter() with NULL
> > pointer. Seems to be additional bug in error recovery.
> > >
> > > To debug, I added initializing dynamic tags as well.
> > >
> > > blk_mq_alloc_rqs() {
> > >            tags->static_rqs[i] = rq;
> > > +            tags->rqs[i] = rq;
> > >
> > > This appears to resolve the issue. But that's not the fix.
> > > It appears to me that nvme stack is broken in certain conditions with recent
> > static and dynamic rq tables change.
> > 
> > Can you try my for-linus branch?
> 
> I tried for-linus branch and it works.
> 
> Seems like ac6e0c2d633ab0411810fe6b15a40808309041db fixes it.
> __blk_mq_alloc_request() 
> data->hctx->tags->rqs[rq->tag] = rq;
> 
> Commit says no functional difference but it is actually fixing this issue.
> 
> Parav

The fix is actually this one:

commit f867f4804d55adeef42c68c89edad49cdf3058f7
Author: Omar Sandoval <osandov@fb.com>
Date:   Mon Feb 27 10:28:27 2017 -0800

    blk-mq: make blk_mq_alloc_request_hctx() allocate a scheduler request

    blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
    its blk_mq_alloc_request() counterpart. It also crashes because it
    doesn't update the tags->rqs map.

    Fix it by making it allocate a scheduler request.

    Reported-by: Sagi Grimberg <sagi@grimberg.me>
    Signed-off-by: Omar Sandoval <osandov@fb.com>
    Signed-off-by: Jens Axboe <axboe@fb.com>
    Tested-by: Sagi Grimberg <sagi@grimberg.me>

The commit you pointed out would have also fixed it, but after this
change it's a no-op.
