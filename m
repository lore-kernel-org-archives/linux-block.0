Return-Path: <longli@microsoft.com>
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>, Bart Van Assche
	<Bart.VanAssche@sandisk.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Fri, 5 May 2017 08:58:16 +0000
Message-ID: <BN3PR03MB2227328E61F98787E89B36B5CEEB0@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
         <1491438735.2787.18.camel@sandisk.com>
         <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
         <1491450335.8994.1.camel@sandisk.com>
         <DM5PR03MB2490E70D9B18A701A81005C8A00D0@DM5PR03MB2490.namprd03.prod.outlook.com>
 <1491868058.4199.28.camel@sandisk.com>
 <BN3PR03MB2227E7A0189829B68BE83DBFCE020@BN3PR03MB2227.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR03MB2227E7A0189829B68BE83DBFCE020@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>



> -----Original Message-----
> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> owner@vger.kernel.org] On Behalf Of Long Li
> Sent: Friday, April 14, 2017 1:12 AM
> To: Bart Van Assche <Bart.VanAssche@sandisk.com>; linux-
> kernel@vger.kernel.org; linux-block@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; axboe@kernel.dk
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Subject: RE: [PATCH] block-mq: set both block queue and hardware queue
> restart bit for restart
>=20
>=20
>=20
> > -----Original Message-----
> > From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> > Sent: Monday, April 10, 2017 4:48 PM
> > To: linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; KY
> > Srinivasan <kys@microsoft.com>; Long Li <longli@microsoft.com>;
> > axboe@kernel.dk
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Subject: Re: [PATCH] block-mq: set both block queue and hardware queue
> > restart bit for restart
> >
> > On Thu, 2017-04-06 at 04:21 +0000, KY Srinivasan wrote:
> > > > -----Original Message-----
> > > > From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> > > > Sent: Wednesday, April 5, 2017 8:46 PM
> > > > To: linux-kernel@vger.kernel.org; linux-block@vger.kernel.org;
> > > > Long Li <longli@microsoft.com>; axboe@kernel.dk
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>; KY Srinivasan
> > > > <kys@microsoft.com>
> > > > Subject: Re: [PATCH] block-mq: set both block queue and hardware
> > > > queue restart bit for restart
> > > >
> > > > On Thu, 2017-04-06 at 03:38 +0000, Long Li wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> > > > > >
> > > > > > Please drop this patch. I'm working on a better solution.
> > > > >
> > > > > Thank you. Looking forward to your patch.
> > > >
> > > > Hello Long,
> > > >
> > > > It would help if you could share the name of the block or SCSI
> > > > driver with which you ran into that lockup and also if you could
> > > > share the name of the I/O scheduler used in your test.
> > >
> > > The tests that indicated the issue were run Hyper-V. The driver is
> > > storvsc_drv.c The I/O scheduler was I think noop.
> >
> > Hello Long and K.Y.,
> >
> > Thank you for the feedback. Can you repeat your test with kernel v4.11-=
rc6?
> > The patches that went into the block layer for v4.11-rc6 should be
> > sufficient to fix
> > this:
> >
> > $ PAGER=3D git log --format=3Dshort v4.11-rc5..v4.11-rc6 block
> > include/linux/blk* commit 6d8c6c0f97ad8a3517c42b179c1dc8e77397d0e2
> > Author: Bart Van Assche <bart.vanassche@sandisk.com>
> >
> > =A0=A0=A0=A0blk-mq: Restart a single queue if tag sets are shared
> >
> > commit 7587a5ae7eef0439f7be31f1b5959af062bbc5ec
> > Author: Bart Van Assche <bart.vanassche@sandisk.com>
> >
> > =A0=A0=A0=A0blk-mq: Introduce blk_mq_delay_run_hw_queue()
> >
> > commit ebe8bddb6e30d7a02775b9972099271fc5910f37
> > Author: Omar Sandoval <osandov@fb.com>
> >
> > =A0=A0=A0=A0blk-mq: remap queues when adding/removing hardware queues
> >
> > commit 54d5329d425650fafaf90660a139c771d2d49cae
> > Author: Omar Sandoval <osandov@fb.com>
> >
> > =A0=A0=A0=A0blk-mq-sched: fix crash in switch error path
> >
> > commit 93252632e828da3e90241a1c0e766556abf71598
> > Author: Omar Sandoval <osandov@fb.com>
> >
> > =A0=A0=A0=A0blk-mq-sched: set up scheduler tags when bringing up new qu=
eues
> >
> > commit 6917ff0b5bd4139e08a3f3146529dcb3b95ba7a6
> > Author: Omar Sandoval <osandov@fb.com>
> >
> > =A0=A0=A0=A0blk-mq-sched: refactor scheduler initialization
> >
> > commit 81380ca10778b99dce98940cfc993214712df335
> > Author: Omar Sandoval <osandov@fb.com>
> >
> > =A0=A0=A0=A0blk-mq: use the right hctx when getting a driver tag fails
> >
> > commit ac77a0c463c1d7d659861f7b6d1261970dd3282a
> > Author: Minchan Kim <minchan@kernel.org>
> >
> > =A0=A0=A0=A0block: do not put mq context in blk_mq_alloc_request_hctx
> >
> > Bart.
>=20
> Thank you. We are doing tests. I will update on the results.
>=20
> Long

Testing went well. There were no I/O hangs.
