Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/5] Avoid that scsi-mq queue processing stalls
Date: Fri, 7 Apr 2017 15:18:19 +0000
Message-ID: <1491578297.2559.7.camel@sandisk.com>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
	 <20170407094107.GC27631@ming.t460p>
In-Reply-To: <20170407094107.GC27631@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-07 at 17:41 +0800, Ming Lei wrote:
> On Thu, Apr 06, 2017 at 11:10:45AM -0700, Bart Van Assche wrote:
> > Hello Jens,
> >=20
> > The five patches in this patch series fix the queue lockup I reported
> > recently on the linux-block mailing list. Please consider these patches
> > for inclusion in the upstream kernel.
>=20
> I read the commit log of the 5 patches, looks not found descriptions
> about root cause of the queue lockup, so could you explain a bit about
> the reason behind?

Hello Ming,

If a .queue_rq() function returns BLK_MQ_RQ_QUEUE_BUSY then the block
driver that implements that function is responsible for rerunning the
hardware queue once requests can be queued successfully again. That is
not the case today for the SCSI core. Patch 5/5 ensures that hardware
queues for which scsi_queue_rq() has returned "busy" are rerun after
the "busy" condition has been cleared. This is why patch 5/5 fixes a
queue lockup.

Bart.=
