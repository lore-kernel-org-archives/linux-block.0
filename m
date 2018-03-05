Return-Path: <msnitzer@redhat.com>
Date: Mon, 5 Mar 2018 10:19:38 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>,
	Don Brace <don.brace@microsemi.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Message-ID: <20180305151938.GA16185@redhat.com>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-2-ming.lei@redhat.com>
 <633459ac33bf49c9a3ff6e515aa790de@microsemi.com>
 <1519930884.9730.8.camel@redhat.com>
 <1519939174.15243.0.camel@redhat.com>
 <20180302021557.GC10471@ming.t460p>
 <1519999769.16293.1.camel@redhat.com>
 <d728ee1c12b14627beedcd72ce9bb4a7@microsemi.com>
 <1520027601.16293.5.camel@redhat.com>
 <415904b102f8c65bf8e6915fd7cd4d7f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <415904b102f8c65bf8e6915fd7cd4d7f@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 05 2018 at  2:23am -0500,
Kashyap Desai <kashyap.desai@broadcom.com> wrote:

> > -----Original Message-----
> > From: Laurence Oberman [mailto:loberman@redhat.com]
> > Sent: Saturday, March 3, 2018 3:23 AM
> > To: Don Brace; Ming Lei
> > Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
> > Snitzer;
> > linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar Sandoval;
> > Martin K . Petersen; James Bottomley; Christoph Hellwig; Kashyap Desai;
> > Peter
> > Rivera; Meelis Roos
> > Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
> >
...
> > Unless Kashyap is not happy we need to consider getting this in to Linus
> > now
> > because we are seeing HPE servers that keep hanging now with the original
> > commit now upstream.
> >
> > Kashyap, are you good with the v3 patchset or still concerned with
> > performance. I was getting pretty good IOPS/sec to individual SSD drives
> > set
> > up as jbod devices on the megaraid_sas.
> 
> Laurence -
> Did you find difference with/without the patch ? What was IOPs number with
> and without patch.
> It is not urgent feature, so I would like to take some time to get BRCM's
> performance team involved and do full analysis of performance run and find
> pros/cons.

Performance doesn't matter if the system cannot even boot (e.g. HPE
servers with hpsa using the latest linus tree).

Have you tried your testbed with just applying the first 2 patches?  Or
do those cause the performance hit and the follow-on patches in the
series attempt to recover from it?

Mike
