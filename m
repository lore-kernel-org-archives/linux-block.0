Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"osandov@fb.com" <osandov@fb.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
Date: Fri, 26 May 2017 21:27:22 +0000
Message-ID: <1495834041.2634.11.camel@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
	 <20170525233810.23211-5-bart.vanassche@sandisk.com>
	 <60bf5a0d-461e-94b7-98d6-56583d53cd73@suse.de>
In-Reply-To: <60bf5a0d-461e-94b7-98d6-56583d53cd73@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-05-26 at 16:38 +0200, Hannes Reinecke wrote:
> Hmm. I wonder if this is going to work as intended; 'busy' might be
> changing rapidly, so the busy_iter might be giving us unintended results.
> Have you checked?

Hello Hannes,

The intention is that this attribute is used by developers to figure out wh=
ich
requests got stuck if one or more requests got stuck. Querying this attribu=
te a
few times should help to see whether the requests shown are requests that
complete quickly or whether these are requests that got stuck. The output I
collected while testing this debugfs attribute looks fine to me:

# while true; do (cd /sys/kernel/debug/block && for f in */*/busy; do [ -e =
$f ] && grep -aH '' $f; done); done
[ ... ]
sde/hctx0/busy:ffff880267dcba00 {.op=3DWRITE, .cmd_flags=3DFAILFAST_TRANSPO=
RT|SYNC|META|PRIO|NOMERGE, .rq_flags=3DMQ_INFLIGHT|DONTPREP|IO_STAT|STATS, =
.atomic_flags=3DSTARTED, .tag=3D19, .internal_tag=3D-1,
.cmd=3DWrite(10) 2a 00 00 07 92 38 00 00 08 00}
sde/hctx0/busy:ffff880267dcd140 {.op=3DWRITE, .cmd_flags=3DFAILFAST_TRANSPO=
RT|SYNC|META|PRIO|NOMERGE, .rq_flags=3DMQ_INFLIGHT|DONTPREP|IO_STAT|STATS, =
.atomic_flags=3DSTARTED, .tag=3D20, .internal_tag=3D-1,
.cmd=3DWrite(10) 2a 00 00 07 92 80 00 00 08 00}
[ ... ]
sr0/hctx0/busy:ffff88046797d140 {.op=3DSCSI_IN, .cmd_flags=3D, .rq_flags=3D=
DONTPREP|PREEMPT|COPY_USER|QUIET|IO_STAT|STATS, .atomic_flags=3DSTARTED, .t=
ag=3D20, .internal_tag=3D-1, .cmd=3DGet event status
notification 4a 01 00 00 10 00 00 00 08 00}
[ ... ]

Bart.=
