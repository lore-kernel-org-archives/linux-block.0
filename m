Return-Path: <ming.lei@redhat.com>
Date: Wed, 7 Mar 2018 08:00:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Laurence Oberman <loberman@redhat.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Don Brace <don.brace@microsemi.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Message-ID: <20180307000030.GA15024@ming.t460p>
References: <20180227100750.32299-2-ming.lei@redhat.com>
 <633459ac33bf49c9a3ff6e515aa790de@microsemi.com>
 <1519930884.9730.8.camel@redhat.com>
 <1519939174.15243.0.camel@redhat.com>
 <20180302021557.GC10471@ming.t460p>
 <1519999769.16293.1.camel@redhat.com>
 <d728ee1c12b14627beedcd72ce9bb4a7@microsemi.com>
 <1520027601.16293.5.camel@redhat.com>
 <20180305020706.GC27111@ming.t460p>
 <yq1efkxqa6u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1efkxqa6u.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 06, 2018 at 02:24:25PM -0500, Martin K. Petersen wrote:
> 
> Ming,
> 
> > Given both Don and Laurence have verified that patch 1 and patch 2
> > does fix IO hang, could you consider to merge the two first?
> 
> Oh, and I would still need a formal Acked-by: from Don and Tested-by:
> from Laurence.
> 
> Also, for 4.16/scsi-fixes I would prefer verification to be done with
> just patch 1/8 and none of the subsequent changes in place. Just to make
> sure we're testing the right thing.

Hi Martin,

Please consider 2/8 too since it is still a fix.

Thanks,
Ming
