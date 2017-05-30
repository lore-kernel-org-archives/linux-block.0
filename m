Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 08/19] block: Introduce request_queue.initialize_rq_fn()
Date: Tue, 30 May 2017 17:54:50 +0000
Message-ID: <1496166889.2627.20.camel@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
	 <20170525184327.23570-9-bart.vanassche@sandisk.com>
	 <20170528083758.GC13083@lst.de>
In-Reply-To: <20170528083758.GC13083@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sun, 2017-05-28 at 10:37 +0200, Christoph Hellwig wrote:
> Oh, and btw - for the mq case we don't want to use the function
> pointer directly in the queue, but in blk_mq_ops, so that we have
> all the mq methods in one place.

Hello Christoph,

Are you sure of this? All other function pointers that apply to both blk-sq
and blk-mq occur in struct request, e.g. .make_request_fn(), .init_rq_fn()
and .exit_rq_fn(). If the .initialize_rq_fn() will be added to struct reque=
st
all I have to add to blk_get_request is the following:

=A0=A0=A0=A0=A0=A0=A0 if (!IS_ERR(req) && q->initialize_rq_fn)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q->initialize_rq_fn(req);

However, if for the mq case the .initialize_rq_fn() would be added to struc=
t
blk_mq_ops then that code would look as follows:

=A0=A0=A0=A0=A0=A0=A0 if (!IS_ERR(req))
                if (q->mq_ops)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q->mq=
_ops->initialize_rq_fn(req);
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0q->in=
itialize_rq_fn(req);

Personally I prefer the first alternative.

Bart.=
