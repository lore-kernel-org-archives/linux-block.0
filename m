Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "roger.pau@citrix.com" <roger.pau@citrix.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "konrad.wilk@oracle.com"
	<konrad.wilk@oracle.com>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen-blkfront: Fix handling of non-supported operations
Date: Mon, 24 Jul 2017 15:10:09 +0000
Message-ID: <1500909007.2604.3.camel@wdc.com>
References: <20170721171110.824-1-bart.vanassche@wdc.com>
	 <f744ebdd-654c-1d6e-d977-28d2a4ce7be9@kernel.dk>
In-Reply-To: <f744ebdd-654c-1d6e-d977-28d2a4ce7be9@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-07-24 at 08:46 -0600, Jens Axboe wrote:
> On 07/21/2017 11:11 AM, Bart Van Assche wrote:
> > This patch fixes the following sparse warnings:
> >=20
> > drivers/block/xen-blkfront.c:916:45: warning: incorrect type in argumen=
t 2 (different base types)
> > drivers/block/xen-blkfront.c:916:45:    expected restricted blk_status_=
t [usertype] error
> > drivers/block/xen-blkfront.c:916:45:    got int [signed] error
> > drivers/block/xen-blkfront.c:1599:47: warning: incorrect type in assign=
ment (different base types)
> > drivers/block/xen-blkfront.c:1599:47:    expected int [signed] error
> > drivers/block/xen-blkfront.c:1599:47:    got restricted blk_status_t [u=
sertype] <noident>
> > drivers/block/xen-blkfront.c:1607:55: warning: incorrect type in assign=
ment (different base types)
> > drivers/block/xen-blkfront.c:1607:55:    expected int [signed] error
> > drivers/block/xen-blkfront.c:1607:55:    got restricted blk_status_t [u=
sertype] <noident>
> > drivers/block/xen-blkfront.c:1625:55: warning: incorrect type in assign=
ment (different base types)
> > drivers/block/xen-blkfront.c:1625:55:    expected int [signed] error
> > drivers/block/xen-blkfront.c:1625:55:    got restricted blk_status_t [u=
sertype] <noident>
> > drivers/block/xen-blkfront.c:1628:62: warning: restricted blk_status_t =
degrades to integer
> >=20
> > Compile-tested only.
>=20
> Applied, but I killed your stable tag. Why did you add that?

Hello Jens,

That tag was added based on the output of git describe:
$ git describe 2a842acab109
v4.12-rc2-199-g2a842acab109

However, the following command shows that the above output is misleading an=
d that the
stable tag is indeed not needed:
$ git log v4.12..origin/master | grep '^commit 2a842acab109'           =20
commit 2a842acab109f40f0d7d10b38e9ca88390628996

Bart.=
