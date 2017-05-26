Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"osandov@fb.com" <osandov@fb.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
Date: Fri, 26 May 2017 21:17:42 +0000
Message-ID: <1495833461.2634.7.camel@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
	 <20170525233810.23211-5-bart.vanassche@sandisk.com>
	 <fa7126bb-7652-ed01-da08-23c3f428c00b@kernel.dk>
In-Reply-To: <fa7126bb-7652-ed01-da08-23c3f428c00b@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-05-26 at 07:26 -0600, Jens Axboe wrote:
> On 05/25/2017 05:38 PM, Bart Van Assche wrote:
> > Requests that got stuck in a block driver are neither on
> > blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
> > visible in debugfs through the "busy" attribute.
> >=20
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-debugfs.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 8b06a12c1461..70a2b955afee 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -370,6 +370,30 @@ static const struct seq_operations hctx_dispatch_s=
eq_ops =3D {
> >  	.show	=3D blk_mq_debugfs_rq_show,
> >  };
> > =20
> > +struct show_busy_ctx {
> > +	struct seq_file		*m;
> > +	struct blk_mq_hw_ctx	*hctx;
> > +};
> > +
> > +static void hctx_show_busy(struct request *rq, void *data, bool reserv=
ed)
> > +{
> > +	const struct show_busy_ctx *ctx =3D data;
>=20
> Let's not call that variable 'ctx', in blk-mq that's pretty much
> reserved for the sw queues.

Hello Jens,

How about renaming show_busy_ctx into show_busy_params and ctx into params?

Bart.=
