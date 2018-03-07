Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 00:05:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
 .host_tagset
Message-ID: <20180307160509.GA10572@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
 <20180307052725.GB15024@ming.t460p>
 <659dc50c3814c8c5b69abb20c3cc39c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <659dc50c3814c8c5b69abb20c3cc39c8@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 07, 2018 at 08:31:31PM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Wednesday, March 7, 2018 10:58 AM
> > To: Kashyap Desai
> > Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
> Snitzer;
> > linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar Sandoval;
> > Martin K . Petersen; James Bottomley; Christoph Hellwig; Don Brace;
> Peter
> > Rivera; Laurence Oberman
> > Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance
> via
> > .host_tagset
> >
> > On Wed, Feb 28, 2018 at 08:28:48PM +0530, Kashyap Desai wrote:
> > > Ming -
> > >
> > > Quick testing on my setup -  Performance slightly degraded (4-5%
> > > drop)for megaraid_sas driver with this patch. (From 1610K IOPS it goes
> > > to 1544K) I confirm that after applying this patch, we have #queue =
> #numa
> > node.
> > >
> > > ls -l
> > >
> >
> /sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2:23/10:
> > > 2:23:0/block/sdy/mq
> > > total 0
> > > drwxr-xr-x. 18 root root 0 Feb 28 09:53 0 drwxr-xr-x. 18 root root 0
> > > Feb 28 09:53 1
> > >
> > >
> > > I would suggest to skip megaraid_sas driver changes using
> > > shared_tagset until and unless there is obvious gain. If overall
> > > interface of using shared_tagset is commit in kernel tree, we will
> > > investigate (megaraid_sas
> > > driver) in future about real benefit of using it.
> >
> > Hi Kashyap,
> >
> > Now I have put patches for removing operating on scsi_host->host_busy in
> > V4[1], especially which are done in the following 3 patches:
> >
> > 	9221638b9bc9 scsi: avoid to hold host_busy for scsi_mq
> > 	1ffc8c0ffbe4 scsi: read host_busy via scsi_host_busy()
> > 	e453d3983243 scsi: introduce scsi_host_busy()
> >
> >
> > Could you run your test on V4 and see if IOPS can be improved on
> > megaraid_sas?
> >
> >
> > [1] https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v4
> 
> I will be doing testing soon.

Today I revisit your previous perf trace too, seems the following samples take
a bit more CPU:

   4.64%  [megaraid_sas]           [k] complete_cmd_fusion
   ...
   2.22%  [megaraid_sas]           [k] megasas_build_io_fusion
   ...
   1.33%  [megaraid_sas]           [k] megasas_build_and_issue_cmd_fusion

But V4 should get a bit improvement in theory.

And if some host-wide resource of megaraid_sas can be partitioned to
per-node hw queue, I guess some of improvement can be got too.

> 
> BTW - Performance impact is due below patch only -
> "[PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
> .host_tagset"
> 
> Below patch is really needed -
> "[PATCH V3 2/8] scsi: megaraid_sas: fix selection of reply queue"
> 
> I am currently doing review on my setup.  I think above patch is fixing
> real issue of performance (for megaraid_sas) as driver may not be sending
> IO to optimal reply queue.

The ideal way is to map reply queue to blk-mq's hw queue, but seems
SCSI/driver's IO path is too slow so that high enough hw queue
depth(from device internal view, for example 256) still can't reach good
performance, as you observed.

> Having CPU to MSIx mapping will solve that. Megaraid_sas driver always
> create max MSIx as min (online CPU, # MSIx HW support).
> I will do more review and testing for that particular patch as well.

OK, thanks!

> 
> Also one observation using V3 series patch. I am seeing below Affinity
> mapping whereas I have only 72 logical CPUs.  It means we are really not
> going to use all reply queues.
> e.a If I bind fio jobs on CPU 18-20, I am seeing only one reply queue is
> used and that may lead to performance drop as well.

If the mapping is in such shape, I guess it should be quite difficult to
figure out one perfect way to solve this situation because one reply
queue has to handle IOs submitted from 4~5 CPUs at average.

The application should have the knowledge to avoid this kind of usage.


Thanks,
Ming
