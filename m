Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "eduval@amazon.com" <eduval@amazon.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH v2 3/4] blk-mq-debugfs: Show busy requests
Date: Wed, 31 May 2017 21:45:54 +0000
Message-ID: <1496267153.2608.17.camel@sandisk.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
	 <20170531213050.30276-4-bart.vanassche@sandisk.com>
	 <20170531214327.GD7903@u40b0340c692b58f6553c.ant.amazon.com>
In-Reply-To: <20170531214327.GD7903@u40b0340c692b58f6553c.ant.amazon.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-05-31 at 14:43 -0700, Eduardo Valentin wrote:
> On Wed, May 31, 2017 at 02:30:49PM -0700, Bart Van Assche wrote:
> > +static void hctx_show_busy(struct request *rq, void *data, bool reserv=
ed)
> > +{
> > +	const struct show_busy_params *params =3D data;
> > +
> > +	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) =3D=3D params->hctx &&
> > +	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> > +		__blk_mq_debugfs_rq_show(params->m,
> > +					 list_entry_rq(&rq->queuelist));
> > +}
> > +
> > +static int hctx_busy_show(void *data, struct seq_file *m)
> > +{
> > +	struct blk_mq_hw_ctx *hctx =3D data;
> > +	struct show_busy_params params =3D { .m =3D m, .hctx =3D hctx };
> > +
> > +	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &params=
);
> > +
> > +	return 0;
> > +}
>=20
> Why not making the two above one single function?
> hctx_busy_show vs. hctx_show_busy seams a bit confusing, and I could not =
see
> where they get reused in your patch set..

Hello Eduardo,

If I would open-code blk_mq_tagset_busy_iter() then I would be able to impl=
ement
the above two functions as a single function. However, blk_mq_tagset_busy_i=
ter()
expects a function pointer as third argument. That's why the above function=
ality
has been split over two functions.

Bart.=
