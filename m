Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH v3 2/5] blk-mq: Restart a single queue if tag sets are
 shared
Date: Fri, 7 Apr 2017 15:12:40 +0000
Message-ID: <1491577958.2559.2.camel@sandisk.com>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
	 <20170406181050.12137-3-bart.vanassche@sandisk.com>
	 <4f5ecfba-f2c9-8b54-f879-86b84f407599@kernel.dk>
	 <e5c27abd-d3ad-ac21-2a37-d20999d459f5@kernel.dk>
In-Reply-To: <e5c27abd-d3ad-ac21-2a37-d20999d459f5@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-06 at 13:21 -0600, Jens Axboe wrote:
> On 04/06/2017 01:12 PM, Jens Axboe wrote:
> > On 04/06/2017 12:10 PM, Bart Van Assche wrote:
> > > +		for (i =3D 0; i < queue->nr_hw_queues; i++) {
> > > +			j =3D (i + hctx->queue_num + 1) % queue->nr_hw_queues;
> > > +			h =3D queue->queue_hw_ctx[j];
> > > +			if (h->tags =3D=3D tags && blk_mq_sched_restart_hctx(h))
> > > +				break;
> >=20
> > I'm pretty sure that doing:
> >=20
> > 	j =3D i + hctx->queue_num + 1;;
>=20
> And 'i' too many there of course:
>=20
>  	j =3D hctx->queue_num + 1;;

Hello Jens,

Thanks for the feedback. I will implement this change and retest this patch
series.

Bart.=
