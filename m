Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Wed, 26 Apr 2017 20:38:11 +0000
Message-ID: <1493239091.2632.14.camel@sandisk.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
	 <20170425203745.19946-6-bart.vanassche@sandisk.com>
	 <20170425213018.GB6361@vader>
	 <0da834e7-f934-9317-509a-455932d837e4@kernel.dk>
In-Reply-To: <0da834e7-f934-9317-509a-455932d837e4@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-25 at 14:41 -0700, Jens Axboe wrote:
> Looks fine to me. However, I think there's room for improvement here.
> Why don't we just make it:
>=20
> 	if (!q->mq_ops) {
> 		spin_lock_irq(lock);
> 		__blk_drain_queue(q, true);
> 	} else {
> 		blk_mq_debugfs_unregister_mq(q);
> 		spin_lock_irq(lock);
> 	}
>=20
> 	queue_flag_set(QUEUE_FLAG_DEAD, q);
> 	[...]
>=20
> Would seem much more readable to me, and less dropping/acquiring for
> cases where we don't need it.

Hello Jens,

This looks fine to me. I will update the patch.

Bart.=
