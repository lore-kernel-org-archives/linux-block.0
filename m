Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Date: Thu, 13 Jul 2017 17:35:29 +0000
Message-ID: <1499967327.2740.6.camel@wdc.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
	 <20170711182103.11461-5-ming.lei@redhat.com>
	 <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
	 <20170712023028.GB13036@ming.t460p> <1499873952.2554.5.camel@wdc.com>
	 <20170713104341.GB19857@ming.t460p> <1499957797.2740.2.camel@wdc.com>
	 <20170713153240.GA25313@ming.t460p>
In-Reply-To: <20170713153240.GA25313@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-07-13 at 23:32 +0800, Ming Lei wrote:
> On Thu, Jul 13, 2017 at 02:56:38PM +0000, Bart Van Assche wrote:
> > hctx_may_queue() severely limits the queue depth if many LUNs are assoc=
iated
> > with the same SCSI host. I think that this is a performance regression
> > compared to scsi-sq and that this performance regression should be fixe=
d.
>=20
> IMO, it is hard to evaluate/compare perf between scsi-mq vs scsi-sq:
>=20
> 	- how many LUNs do you run IO on concurrently?
> 	- evaluate the perf on single LUN or multi LUN?
>=20
> BTW, active_queues is a runtime variable which accounts the actual active
> queues in use.

Hello Ming,

What I described can be verified easily by running fio against a single LUN
of a SCSI host with which a large number of LUNs are associated.

BTW, something I overlooked in my analysis of the active_queues variable is
that it is not only decremented if a queue is destroyed but also if a queue
is idle during (block layer request timeout) seconds. So the problem I
described will only occur if some software submits I/O requests periodicall=
y
to all SCSI LUNs with a shorter interval than the I/O timeout. I'm not sure
any Linux software does this today. As an example, the time between path
checks by the multipathd TUR checker typically exceeds the timeout of a
single TUR check.

Bart.=
