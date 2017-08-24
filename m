Return-Path: <bblock@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 15:36:50 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Steffen Maier <maier@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/1] bsg-lib: fix kernel panic resulting from missing
 allocation of reply-buffer
References: <cover.1503528302.git.bblock@linux.vnet.ibm.com>
 <4cf376032b459b7a14cdad22987177b86cc669c0.1503528302.git.bblock@linux.vnet.ibm.com>
 <20170824084556.GA19418@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170824084556.GA19418@lst.de>
Message-Id: <20170824133650.GE27001@bblock-ThinkPad-W530>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 24, 2017 at 10:45:56AM +0200, Christoph Hellwig wrote:
> >  /**
> > - * bsg_destroy_job - routine to teardown/delete a bsg job
> > + * bsg_teardown_job - routine to teardown a bsg job
> >   * @job: bsg_job that is to be torn down
> >   */
> > -static void bsg_destroy_job(struct kref *kref)
> > +static void bsg_teardown_job(struct kref *kref)
> 
> Why this rename?  The destroy name seems to be one of the most
> common patterns for the kref_put callbacks.
>

Hmm, I did it mostly so it is symmetric with bsg_prepare_job() and it
doesn't really itself destroy the job-struct anymore. If there are other
thing amiss I can change that along with them, if it bothers poeple.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block

> 
> Otherwise this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
