Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com>	 <20180227100750.32299-2-ming.lei@redhat.com>
	 <633459ac33bf49c9a3ff6e515aa790de@microsemi.com>	 <1519930884.9730.8.camel@redhat.com>
 <1519939174.15243.0.camel@redhat.com>	 <20180302021557.GC10471@ming.t460p>
 <1519999769.16293.1.camel@redhat.com>	 <d728ee1c12b14627beedcd72ce9bb4a7@microsemi.com>
 <1520027601.16293.5.camel@redhat.com>
In-Reply-To: <1520027601.16293.5.camel@redhat.com>
MIME-Version: 1.0
Date: Mon, 5 Mar 2018 12:53:35 +0530
Message-ID: <415904b102f8c65bf8e6915fd7cd4d7f@mail.gmail.com>
Subject: RE: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
To: Laurence Oberman <loberman@redhat.com>, Don Brace <don.brace@microsemi.com>,
	Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>, Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>,
	Peter Rivera <peter.rivera@broadcom.com>, Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: Laurence Oberman [mailto:loberman@redhat.com]
> Sent: Saturday, March 3, 2018 3:23 AM
> To: Don Brace; Ming Lei
> Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
> Snitzer;
> linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar Sandoval;
> Martin K . Petersen; James Bottomley; Christoph Hellwig; Kashyap Desai;
> Peter
> Rivera; Meelis Roos
> Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
>
> On Fri, 2018-03-02 at 15:03 +0000, Don Brace wrote:
> > > -----Original Message-----
> > > From: Laurence Oberman [mailto:loberman@redhat.com]
> > > Sent: Friday, March 02, 2018 8:09 AM
> > > To: Ming Lei <ming.lei@redhat.com>
> > > Cc: Don Brace <don.brace@microsemi.com>; Jens Axboe <axboe@kernel.d
> > > k>;
> > > linux-block@vger.kernel.org; Christoph Hellwig <hch@infradead.org>;
> > > Mike Snitzer <snitzer@redhat.com>; linux-scsi@vger.kernel.org;
> > > Hannes Reinecke <hare@suse.de>; Arun Easi <arun.easi@cavium.com>;
> > > Omar Sandoval <osandov@fb.com>; Martin K . Petersen
> > > <martin.petersen@oracle.com>; James Bottomley
> > > <james.bottomley@hansenpartnership.com>; Christoph Hellwig
> > > <hch@lst.de>; Kashyap Desai <kashyap.desai@broadcom.com>; Peter
> > > Rivera <peter.rivera@broadcom.com>; Meelis Roos <mroos@linux.ee>
> > > Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
> > >
> > > EXTERNAL EMAIL
> > >
> > >
> > > On Fri, 2018-03-02 at 10:16 +0800, Ming Lei wrote:
> > > > On Thu, Mar 01, 2018 at 04:19:34PM -0500, Laurence Oberman wrote:
> > > > > On Thu, 2018-03-01 at 14:01 -0500, Laurence Oberman wrote:
> > > > > > On Thu, 2018-03-01 at 16:18 +0000, Don Brace wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: Ming Lei [mailto:ming.lei@redhat.com]
> > > > > > > > Sent: Tuesday, February 27, 2018 4:08 AM
> > > > > > > > To: Jens Axboe <axboe@kernel.dk>; linux-block@vger.kernel
> > > > > > > > .org ; Christoph Hellwig <hch@infradead.org>; Mike Snitzer
> > > > > > > > <snitzer@redhat .com
> > > > > > > > >
> > > > > > > >
> > > > > > > > Cc: linux-scsi@vger.kernel.org; Hannes Reinecke <hare@sus
> > > > > > > > e.de
> > > > > > > > > ;
> > > > > > > >
> > > > > > > > Arun Easi
> > > > > > > > <arun.easi@cavium.com>; Omar Sandoval <osandov@fb.com>;
> > > > > > > > Martin K .
> > > > > > > > Petersen <martin.petersen@oracle.com>; James Bottomley
> > > > > > > > <james.bottomley@hansenpartnership.com>; Christoph Hellwig
> > > > > > > > <h ch@l st .de>; Don Brace <don.brace@microsemi.com>;
> > > > > > > > Kashyap Desai <kashyap.desai@broadcom.com>; Peter Rivera
> > > > > > > > <peter.rivera@ broa dcom .c
> > > > > > > > om>;
> > > > > > > > Laurence Oberman <loberman@redhat.com>; Ming Lei
> > > > > > > > <ming.lei@redhat.com>; Meelis Roos <mroos@linux.ee>
> > > > > > > > Subject: [PATCH V3 1/8] scsi: hpsa: fix selection of reply
> > > > > > > > queue
> > > > > > > >
> > > >
> > > > Seems Don run into IO failure without blk-mq, could you run your
> > > > tests again in legacy mode?
> > > >
> > > > Thanks,
> > > > Ming
> > >
> > > Hello Ming
> > > I ran multiple passes on Legacy and still see no issues in my test
> > > bed
> > >
> > > BOOT_IMAGE=/vmlinuz-4.16.0-rc2.ming+ root=UUID=43f86d71-b1bf-4789-
> > > a28e-
> > > 21c6ddc90195 ro crashkernel=256M@64M log_buf_len=64M
> > > console=ttyS1,115200n8
> > >
> > > HEAD of the git kernel I am using
> > >
> > > 694e16f scsi: megaraid: improve scsi_mq performance via .host_tagset
> > > 793686c scsi: hpsa: improve scsi_mq performance via .host_tagset
> > > 60d5b36 block: null_blk: introduce module parameter of 'g_host_tags'
> > > 8847067 scsi: Add template flag 'host_tagset'
> > > a8fbdd6 blk-mq: introduce BLK_MQ_F_HOST_TAGS 4710fab blk-mq:
> > > introduce 'start_tag' field to 'struct blk_mq_tags'
> > > 09bb153 scsi: megaraid_sas: fix selection of reply queue
> > > 52700d8 scsi: hpsa: fix selection of reply queue
> >
> > I checkout out Linus's tree (4.16.0-rc3+) and re-applied the above
> > patches.
> > I  and have been running 24 hours with no issues.
> > Evidently my forked copy was corrupted.
> >
> > So, my I/O testing has gone well.
> >
> > I'll run some performance numbers next.
> >
> > Thanks,
> > Don
>
> Unless Kashyap is not happy we need to consider getting this in to Linus
> now
> because we are seeing HPE servers that keep hanging now with the original
> commit now upstream.
>
> Kashyap, are you good with the v3 patchset or still concerned with
> performance. I was getting pretty good IOPS/sec to individual SSD drives
> set
> up as jbod devices on the megaraid_sas.

Laurence -
Did you find difference with/without the patch ? What was IOPs number with
and without patch.
It is not urgent feature, so I would like to take some time to get BRCM's
performance team involved and do full analysis of performance run and find
pros/cons.

Kashyap
>
> With larger I/O sizes like 1MB I was getting good MB/sec and not seeing a
> measurable performance impact.
>
> I dont have the hardware you have to mimic your configuration.
>
> Thanks
> Laurence
