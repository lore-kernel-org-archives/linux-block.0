Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@infradead.org"
	<hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Date: Wed, 12 Jul 2017 15:39:14 +0000
Message-ID: <1499873952.2554.5.camel@wdc.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
	 <20170711182103.11461-5-ming.lei@redhat.com>
	 <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
	 <20170712023028.GB13036@ming.t460p>
In-Reply-To: <20170712023028.GB13036@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-07-12 at 10:30 +0800, Ming Lei wrote:
> On Tue, Jul 11, 2017 at 12:25:16PM -0600, Jens Axboe wrote:
> > What happens with fluid congestion boundaries, with shared tags?
>=20
> The approach in this patch should work, but the threshold may not
> be accurate in this way, one simple method is to use the average
> tag weight in EWMA, like this:
>=20
> 	sbitmap_weight() / hctx->tags->active_queues

Hello Ming,

That approach would result in a severe performance degradation. "active_que=
ues"
namely represents the number of queues against which I/O ever has been queu=
ed.
If e.g. 64 LUNs would be associated with a single SCSI host and all 64 LUNs=
 are
responding and if the queue depth would also be 64 then the approach you
proposed will reduce the effective queue depth per LUN from 64 to 1.

Bart.=
