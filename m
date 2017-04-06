Return-Path: <longli@microsoft.com>
From: Long Li <longli@microsoft.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: Stephen Hemminger <sthemmin@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>
Subject: RE: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Thu, 6 Apr 2017 03:38:24 +0000
Message-ID: <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
 <1491438735.2787.18.camel@sandisk.com>
In-Reply-To: <1491438735.2787.18.camel@sandisk.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>



> -----Original Message-----
> From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> Sent: Wednesday, April 5, 2017 5:32 PM
> To: linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; Long Li
> <longli@microsoft.com>; axboe@kernel.dk
> Cc: Stephen Hemminger <sthemmin@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Long Li <longli@microsoft.com>
> Subject: Re: [PATCH] block-mq: set both block queue and hardware queue
> restart bit for restart
>=20
> On Wed, 2017-04-05 at 17:16 -0700, Long Li wrote:
> > Under heavy I/O, one hardware queue may be unable to dispatch any I/O
> > to the device layer. This poses a problem with restarting this
> > hardware queue on I/O finish in blk_mq_sched_restart_queues(), becaue
> > there is nothing pending that will finish in future on this hardware qe=
ueu.
> This will result in deadlock.
> >
> > With this patch, we check for all possible stalled hardware queues
> > when I/O finishes on any hardware queues. This prevents this deadlock.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  block/blk-mq-sched.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c index
> > 09af8ff..f7f3d44 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -202,7 +202,7 @@ void blk_mq_sched_dispatch_requests(struct
> blk_mq_hw_ctx *hctx)
> >  	 * needing a restart in that case.
> >  	 */
> >  	if (!list_empty(&rq_list)) {
> > -		blk_mq_sched_mark_restart_hctx(hctx);
> > +		blk_mq_sched_mark_restart_queue(hctx);
> >  		did_work =3D blk_mq_dispatch_rq_list(hctx, &rq_list);
> >  	} else if (!has_sched_dispatch) {
> >  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
>=20
> Please drop this patch. I'm working on a better solution.

Thank you. Looking forward to your patch.

>=20
> Thanks,
>=20
> Bart.
