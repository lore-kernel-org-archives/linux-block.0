Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "osandov@fb.com" <osandov@fb.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq: Make blk_mq_quiesce_queue() wait for all
 .queue_rq() calls
Date: Fri, 28 Apr 2017 15:35:59 +0000
Message-ID: <1493393758.2767.3.camel@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
	 <20170427155437.23228-2-bart.vanassche@sandisk.com>
	 <20170428020038.GA31518@ming.t460p>
In-Reply-To: <20170428020038.GA31518@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-28 at 10:00 +0800, Ming Lei wrote:
> On Thu, Apr 27, 2017 at 08:54:32AM -0700, Bart Van Assche wrote:
> >  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
> >  {
> > -	cancel_work(&hctx->run_work);
> > -	cancel_delayed_work(&hctx->delay_work);
> > +	cancel_work_sync(&hctx->run_work);
> > +	cancel_delayed_work_sync(&hctx->delay_work);
>=20
> Could you explain it a bit why we need the sync version?

Because the purpose of this patch is to make blk_mq_quiesce_queue() wait fo=
r
all .queue_rq() calls.

> So I suggest to unity both .run_work and .dealyed_run_work
> into one work, just as what Jens did in the following link:
>=20
> 	http://marc.info/?t=3D149183989800010&r=3D1&w=3D2

That should be done after this patch is upstream otherwise this
patch won't apply to the stable trees.

Bart.=
