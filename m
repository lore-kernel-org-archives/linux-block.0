Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: connect cmd error for nvme-rdma with eventual kernel crash
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <VI1PR0502MB3008851A3D20ECF93FC70FCCD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Date: Tue, 28 Feb 2017 18:26:32 -0700
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Max Gurtovoy <maxg@mellanox.com>
Message-Id: <A520FEF3-9BB7-4265-ADBA-29ADE118B971@kernel.dk>
References: <VI1PR0502MB3008851A3D20ECF93FC70FCCD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
To: Parav Pandit <parav@mellanox.com>
List-ID: <linux-block@vger.kernel.org>


> On Feb 28, 2017, at 5:57 PM, Parav Pandit <parav@mellanox.com> wrote:
>=20
> Hi Jens,
>=20
> With your commit 2af8cbe30531eca73c8f3ba277f155fc0020b01a in linux-block g=
it tree,
> There are two requests tables. Static and dynamic of same size.
> However function blk_mq_tag_to_rq() always try to get the tag from the dyn=
amic table which doesn't seem to be always initialized.
>=20
> I am running nvme-rdma initiator and it fails to find the request for the g=
iven tag when command completes.
> Command triggers error recovery with "tag not found" error.
> Eventually kernel is crashing in blk_mq_queue_tag_busy_iter() with NULL po=
inter. Seems to be additional bug in error recovery.
>=20
> To debug, I added initializing dynamic tags as well.
>=20
> blk_mq_alloc_rqs() {
>            tags->static_rqs[i] =3D rq;
> +            tags->rqs[i] =3D rq;
>=20
> This appears to resolve the issue. But that's not the fix.
> It appears to me that nvme stack is broken in certain conditions with rece=
nt static and dynamic rq tables change.

Can you try my for-linus branch?
