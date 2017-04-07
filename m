Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] Avoid that scsi-mq and dm-mq queue processing
 stalls sporadically
Date: Fri, 7 Apr 2017 18:33:44 +0000
Message-ID: <1491590023.2559.18.camel@sandisk.com>
References: <20170407181654.27836-1-bart.vanassche@sandisk.com>
	 <78b80b12-a764-a793-f8a1-7a941dc84ee5@kernel.dk>
In-Reply-To: <78b80b12-a764-a793-f8a1-7a941dc84ee5@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-07 at 12:23 -0600, Jens Axboe wrote:
> On 04/07/2017 12:16 PM, Bart Van Assche wrote:
> > Hello Jens,
> >=20
> > The six patches in this patch series fix the queue lockup I reported
> > recently on the linux-block mailing list. Please consider these patches
> > for inclusion in the upstream kernel.
>=20
> Some of this we need in 4.11, but not all of it. I can't be applying patc=
hes
> that "improve scalability" at this point.
>=20
> 4-6 looks like what we want for 4.11, I'll see if those apply directly. T=
hen
> we can put 1-3 on top in 4.12, with the others pulled in first.

Hello Jens,

Please note that patch 2/6 is a bug fix. The current implementation of
blk_mq_sched_restart_queues() only considers hardware queues associated wit=
h
the same request queue as the hardware queue that has been passed as an
argument. If a tag set is shared across request queues - as is the case for
SCSI - then all request queues that share a tag set with the hctx argument
must be considered.

Bart.=
