Return-Path: <ming.lei@redhat.com>
Date: Thu, 1 Mar 2018 15:58:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
	Peter Rivera <peter.rivera@broadcom.com>
Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
 .host_tagset
Message-ID: <20180301075801.GE30449@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
 <20180228152124.GA28612@ming.t460p>
 <1519834930.7327.1.camel@redhat.com>
 <9ccb507aaa8fcec81fcf83d0ee2ba4c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ccb507aaa8fcec81fcf83d0ee2ba4c2@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 10:54:17AM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Laurence Oberman [mailto:loberman@redhat.com]
> > Sent: Wednesday, February 28, 2018 9:52 PM
> > To: Ming Lei; Kashyap Desai
> > Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
> > Snitzer;
> > linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar Sandoval;
> > Martin K . Petersen; James Bottomley; Christoph Hellwig; Don Brace; Peter
> > Rivera
> > Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance
> > via
> > .host_tagset
> >
> > On Wed, 2018-02-28 at 23:21 +0800, Ming Lei wrote:
> > > On Wed, Feb 28, 2018 at 08:28:48PM +0530, Kashyap Desai wrote:
> > > > Ming -
> > > >
> > > > Quick testing on my setup -  Performance slightly degraded (4-5%
> > > > drop)for megaraid_sas driver with this patch. (From 1610K IOPS it
> > > > goes to
> > > > 1544K)
> > > > I confirm that after applying this patch, we have #queue = #numa
> > > > node.
> > > >
> > > > ls -l
> > > > /sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2
> > > > :23/10:
> > > > 2:23:0/block/sdy/mq
> > > > total 0
> > > > drwxr-xr-x. 18 root root 0 Feb 28 09:53 0 drwxr-xr-x. 18 root root 0
> > > > Feb 28 09:53 1
> > >
> > > OK, thanks for your test.
> > >
> > > As I mentioned to you, this patch should have improved performance on
> > > megaraid_sas, but the current slight degrade might be caused by
> > > scsi_host_queue_ready() in scsi_queue_rq(), I guess.
> > >
> > > With .host_tagset enabled and use per-numa-node hw queue, request can
> > > be queued to lld more frequently/quick than single queue, then the
> > > cost of
> > > atomic_inc_return(&host->host_busy) may be increased much meantime,
> > > think about millions of such operations, and finally slight IOPS drop
> > > is observed when the hw queue depth becomes half of .can_queue.
> > >
> > > >
> > > >
> > > > I would suggest to skip megaraid_sas driver changes using
> > > > shared_tagset until and unless there is obvious gain. If overall
> > > > interface of using shared_tagset is commit in kernel tree, we will
> > > > investigate (megaraid_sas
> > > > driver) in future about real benefit of using it.
> > >
> > > I'd suggest to not merge it until it is proved that performance can be
> > > improved in real device.
> 
> Noted.
> 
> > >
> > > I will try to work to remove the expensive atomic_inc_return(&host-
> > > >host_busy)
> > > from scsi_queue_rq(), since it isn't needed for SCSI_MQ, once it is
> > > done, will ask you to test again.
> 
> Ming - Do you mean removing host_busy stats  from scsi_queue_rq() will still
> provide correct value in host_busy whenever IO reach to LLD ?

The host queue depth has been respected by blk-mq already before calling
scsi_queue_rq(), so not necessary to do it again in scsi_queue_rq(), but this
counter is needed in error handler, so we have to figure out one way to not
break error handler.

Also megaraid_sas driver need to be checked if there is host wide lock
used in .queuecommand or completion path.

Thanks,
Ming
