Return-Path: <parav@mellanox.com>
From: Parav Pandit <parav@mellanox.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "axboe@fb.com" <axboe@fb.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Christoph
 Hellwig" <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
Subject: RE: connect cmd error for nvme-rdma with eventual kernel crash
Date: Wed, 1 Mar 2017 04:55:23 +0000
Message-ID: <VI1PR0502MB3008EA53FCF29CF9E993918BD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <VI1PR0502MB3008851A3D20ECF93FC70FCCD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <A520FEF3-9BB7-4265-ADBA-29ADE118B971@kernel.dk>
In-Reply-To: <A520FEF3-9BB7-4265-ADBA-29ADE118B971@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

> -----Original Message-----
> From: Jens Axboe [mailto:axboe@kernel.dk]
> Subject: Re: connect cmd error for nvme-rdma with eventual kernel crash
>=20
> > On Feb 28, 2017, at 5:57 PM, Parav Pandit <parav@mellanox.com> wrote:
> >
> > Hi Jens,
> >
> > With your commit 2af8cbe30531eca73c8f3ba277f155fc0020b01a in
> > linux-block git tree, There are two requests tables. Static and dynamic=
 of
> same size.
> > However function blk_mq_tag_to_rq() always try to get the tag from the
> dynamic table which doesn't seem to be always initialized.
> >
> > I am running nvme-rdma initiator and it fails to find the request for t=
he
> given tag when command completes.
> > Command triggers error recovery with "tag not found" error.
> > Eventually kernel is crashing in blk_mq_queue_tag_busy_iter() with NULL
> pointer. Seems to be additional bug in error recovery.
> >
> > To debug, I added initializing dynamic tags as well.
> >
> > blk_mq_alloc_rqs() {
> >            tags->static_rqs[i] =3D rq;
> > +            tags->rqs[i] =3D rq;
> >
> > This appears to resolve the issue. But that's not the fix.
> > It appears to me that nvme stack is broken in certain conditions with r=
ecent
> static and dynamic rq tables change.
>=20
> Can you try my for-linus branch?

I tried for-linus branch and it works.

Seems like ac6e0c2d633ab0411810fe6b15a40808309041db fixes it.
__blk_mq_alloc_request()=20
data->hctx->tags->rqs[rq->tag] =3D rq;

Commit says no functional difference but it is actually fixing this issue.

Parav
