Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 4/6] mtip32xx: convert internal command issue to block IO
 path
Date: Tue, 2 May 2017 15:42:22 +0000
Message-ID: <1493739741.2552.3.camel@sandisk.com>
References: <1493398473-29872-1-git-send-email-axboe@fb.com>
	 <1493398473-29872-5-git-send-email-axboe@fb.com>
	 <20170502072810.GA11582@lst.de>
	 <b5eae6e4-92f3-3266-5f8e-21c7ab6e69f6@fb.com>
	 <a43cf987-6f97-a82d-38e7-f8880c4d63ae@kernel.dk>
	 <da3549ce-74ad-07da-528c-3a8b84b275f9@kernel.dk>
	 <20170502151607.GA22963@lst.de>
	 <f2281c8c-0982-7d2f-ba35-060d9ea1bb48@kernel.dk>
In-Reply-To: <f2281c8c-0982-7d2f-ba35-060d9ea1bb48@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-05-02 at 09:25 -0600, Jens Axboe wrote:
> On 05/02/2017 09:16 AM, Christoph Hellwig wrote:
> > Any reason for the move from ->end_io_data to ->special?  I thought
> > that ->special was something we'd get rid of sooner or later now
> > that we can have additional per-cmd data even for !mq.
>=20
> With the switch to blk_execute_rq(), we can't be using end_io_data
> and end_io, as we use that internally for the wakeup. So I have to
> stuff it somewhere.
>=20
> The obvious option would be to move it to mtip_cmd, but we can't
> safely access that prior to having a driver tag assigned, which doesn't
> happen until we end up in our ->queue_rq(). So we need to stuff it
> somewhere.

Hello Jens,

Do you think it would be a good idea to allow blk_get_request() callers
to specify that a driver tag has to be allocated even if a scheduler has
been configured? That would make it possible to store completion data in
mtip_cmd for the mtip driver.

Thanks,

Bart.=
