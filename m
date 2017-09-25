Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Mon, 25 Sep 2017 18:54:31 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Steffen Maier <maier@linux.vnet.ibm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] bsg-lib: fix use-after-free under memory-pressure
References: <9040282c25a027344945e9be2c3afc3d90386909.1506016742.git.bblock@linux.vnet.ibm.com>
 <20170925155307.GA27522@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170925155307.GA27522@infradead.org>
Message-Id: <20170925165431.GA3283@bblock-ThinkPad-W530>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 08:53:07AM -0700, Christoph Hellwig wrote:
> >  	if (!q)
> >  		return ERR_PTR(-ENOMEM);
> >  	q->cmd_size = sizeof(struct bsg_job) + dd_job_size;
> > -	q->init_rq_fn = bsg_init_rq;
> > -	q->exit_rq_fn = bsg_exit_rq;
> > +	q->init_rq_fn = bsg_init_job;
> > +	q->exit_rq_fn = bsg_exit_job;
> > +	q->initialize_rq_fn = bsg_init_rq;
> 
> Please use function names that match the method names, that is keep
> the existing names and name the new helper bsg_initialize_rq;
>

OK, I can change that.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block

> 
> Except for that the patch looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
