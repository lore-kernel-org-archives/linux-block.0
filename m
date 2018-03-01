Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com>	 <20180227100750.32299-9-ming.lei@redhat.com>
	 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>	 <20180228152124.GA28612@ming.t460p>
 <1519834930.7327.1.camel@redhat.com>
In-Reply-To: <1519834930.7327.1.camel@redhat.com>
MIME-Version: 1.0
Date: Thu, 1 Mar 2018 10:54:17 +0530
Message-ID: <9ccb507aaa8fcec81fcf83d0ee2ba4c2@mail.gmail.com>
Subject: RE: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via .host_tagset
To: Laurence Oberman <loberman@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>, Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microsemi.com>, Peter Rivera <peter.rivera@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: Laurence Oberman [mailto:loberman@redhat.com]
> Sent: Wednesday, February 28, 2018 9:52 PM
> To: Ming Lei; Kashyap Desai
> Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
> Snitzer;
> linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar Sandoval;
> Martin K . Petersen; James Bottomley; Christoph Hellwig; Don Brace; Peter
> Rivera
> Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance
> via
> .host_tagset
>
> On Wed, 2018-02-28 at 23:21 +0800, Ming Lei wrote:
> > On Wed, Feb 28, 2018 at 08:28:48PM +0530, Kashyap Desai wrote:
> > > Ming -
> > >
> > > Quick testing on my setup -  Performance slightly degraded (4-5%
> > > drop)for megaraid_sas driver with this patch. (From 1610K IOPS it
> > > goes to
> > > 1544K)
> > > I confirm that after applying this patch, we have #queue = #numa
> > > node.
> > >
> > > ls -l
> > > /sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2
> > > :23/10:
> > > 2:23:0/block/sdy/mq
> > > total 0
> > > drwxr-xr-x. 18 root root 0 Feb 28 09:53 0 drwxr-xr-x. 18 root root 0
> > > Feb 28 09:53 1
> >
> > OK, thanks for your test.
> >
> > As I mentioned to you, this patch should have improved performance on
> > megaraid_sas, but the current slight degrade might be caused by
> > scsi_host_queue_ready() in scsi_queue_rq(), I guess.
> >
> > With .host_tagset enabled and use per-numa-node hw queue, request can
> > be queued to lld more frequently/quick than single queue, then the
> > cost of
> > atomic_inc_return(&host->host_busy) may be increased much meantime,
> > think about millions of such operations, and finally slight IOPS drop
> > is observed when the hw queue depth becomes half of .can_queue.
> >
> > >
> > >
> > > I would suggest to skip megaraid_sas driver changes using
> > > shared_tagset until and unless there is obvious gain. If overall
> > > interface of using shared_tagset is commit in kernel tree, we will
> > > investigate (megaraid_sas
> > > driver) in future about real benefit of using it.
> >
> > I'd suggest to not merge it until it is proved that performance can be
> > improved in real device.

Noted.

> >
> > I will try to work to remove the expensive atomic_inc_return(&host-
> > >host_busy)
> > from scsi_queue_rq(), since it isn't needed for SCSI_MQ, once it is
> > done, will ask you to test again.

Ming - Do you mean removing host_busy stats  from scsi_queue_rq() will still
provide correct value in host_busy whenever IO reach to LLD ?

> >
> >
> > Thanks,
> > Ming
>
> I will test this here as well
> I just put the Megaraid card in to my system here
>
> Kashyap, do you have ssd's on the back-end and are you you using jbods or
> virtual devices. Let me have your config.
> I only have 6G sas shelves though.

Laurence -
I am using 12 SSD drives in JBOD mode OR single drive R0 mode.  Single SSD
is capable of ~138K IOPS (4K RR).
With all 12 SSDs performance scale linearly and goes upto ~1610K IOPS.

I think if you have 6G SAS fully loaded, you may need more number of drives
to reach 1600K IOPs (sequential load with nomerges=2 on HDD is required to
avoid IO merge at block layer.)

SSD model I am using is -  HGST  - " HUSMH8020BSS200"
Here is lscpu output of my setup -

lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                32
On-line CPU(s) list:   0-31
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 79
Model name:            Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz
Stepping:              1
CPU MHz:               1726.217
BogoMIPS:              4199.37
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              20480K
NUMA node0 CPU(s):     0-7,16-23
NUMA node1 CPU(s):     8-15,24-31

>
> Regards
> Laurence
