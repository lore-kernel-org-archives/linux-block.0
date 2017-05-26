Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 08/19] block: Introduce request_queue.initialize_rq_fn()
Date: Fri, 26 May 2017 23:56:30 +0000
Message-ID: <1495842989.2634.13.camel@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
	 <20170525184327.23570-9-bart.vanassche@sandisk.com>
	 <20170526063430.GA19034@lst.de>
In-Reply-To: <20170526063430.GA19034@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-05-26 at 08:34 +0200, Christoph Hellwig wrote:
> On Thu, May 25, 2017 at 11:43:16AM -0700, Bart Van Assche wrote:
> > Several block drivers need to initialize the driver-private data
> > after having called blk_get_request() and before .prep_rq_fn() is
> > called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
> > that initialization code has to be repeated after every
> > blk_get_request() call by adding a new callback function to struct
> > request_queue.
>=20
> I still think we should do this at the end of blk_mq_alloc_request /
> blk_old_get_request to exactly keep the old semantics and keep the
> calls out of the hot path.

Hello Christoph,

I have tried to move that call into blk_mq_alloc_request() but that
resulted in a kernel oops during boot due to scsi_add_cmd_to_list()
dereferencing scsi_cmnd.device and due to that pointer being invalid.
I think that pointer was invalid because moving the initialize_rq_fn()
call into blk_mq_alloc_request() caused request initialization to be
skipped for the following code path:
submit_bio()
-> generic_make_request()
  -> .make_request_fn =3D=3D blk_mq_make_request()
 =A0  -> blk_mq_sched_get_request()
      -> __blk_mq_alloc_request()
 =A0 =A0 =A0  -> blk_mq_rq_ctx_init()

This is why I would like to keep the .initialize_rq_fn() call in
blk_mq_rq_ctx_init().

Bart.=
