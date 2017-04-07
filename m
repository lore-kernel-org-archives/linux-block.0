Return-Path: <ming.lei@redhat.com>
Date: Fri, 7 Apr 2017 23:34:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/5] Avoid that scsi-mq queue processing stalls
Message-ID: <20170407153426.GE29821@ming.t460p>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
 <20170407094107.GC27631@ming.t460p>
 <1491578297.2559.7.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491578297.2559.7.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 07, 2017 at 03:18:19PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-07 at 17:41 +0800, Ming Lei wrote:
> > On Thu, Apr 06, 2017 at 11:10:45AM -0700, Bart Van Assche wrote:
> > > Hello Jens,
> > > 
> > > The five patches in this patch series fix the queue lockup I reported
> > > recently on the linux-block mailing list. Please consider these patches
> > > for inclusion in the upstream kernel.
> > 
> > I read the commit log of the 5 patches, looks not found descriptions
> > about root cause of the queue lockup, so could you explain a bit about
> > the reason behind?
> 
> Hello Ming,
> 
> If a .queue_rq() function returns BLK_MQ_RQ_QUEUE_BUSY then the block
> driver that implements that function is responsible for rerunning the
> hardware queue once requests can be queued successfully again. That is
> not the case today for the SCSI core. Patch 5/5 ensures that hardware

The current .queue_rq() will call blk_mq_delay_queue() if QUEUE_BUSY is
returned, and once request is completed, the queue will be restarted
by blk_mq_start_stopped_hw_queues() in scsi_end_request(). This way
sounds OK in theory. And I just try to understand the specific reason
which causes the lockup, but still not get it.

Thanks,
Ming
