Return-Path: <martin.petersen@oracle.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Don Brace <don.brace@microsemi.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Peter Rivera <peter.rivera@broadcom.com>, Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180227100750.32299-1-ming.lei@redhat.com>
	<20180227100750.32299-2-ming.lei@redhat.com>
	<633459ac33bf49c9a3ff6e515aa790de@microsemi.com>
	<1519930884.9730.8.camel@redhat.com>
	<1519939174.15243.0.camel@redhat.com>
	<20180302021557.GC10471@ming.t460p>
	<1519999769.16293.1.camel@redhat.com>
	<d728ee1c12b14627beedcd72ce9bb4a7@microsemi.com>
	<1520027601.16293.5.camel@redhat.com>
	<20180305020706.GC27111@ming.t460p>
Date: Tue, 06 Mar 2018 12:55:14 -0500
In-Reply-To: <20180305020706.GC27111@ming.t460p> (Ming Lei's message of "Mon,
	5 Mar 2018 10:07:07 +0800")
Message-ID: <yq1d10hrsvx.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Hi Ming,

> Given both Don and Laurence have verified that patch 1 and patch 2
> does fix IO hang, could you consider to merge the two first?

I'm not going to merge the MR patch until Kashyap acks it.

-- 
Martin K. Petersen	Oracle Linux Engineering
