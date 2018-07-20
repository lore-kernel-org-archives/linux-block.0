Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 20 Jul 2018 09:56:47 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720155646.GE4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 03:12:59PM +0000, Bart Van Assche wrote:
> On Thu, 2018-07-19 at 15:26 -0600, Keith Busch wrote:
> > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > index 8932ae81a15a..86ee10b2c775 100644
> > --- a/drivers/scsi/scsi_error.c
> > +++ b/drivers/scsi/scsi_error.c
> > @@ -286,6 +286,9 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
> >  	enum blk_eh_timer_return rtn = BLK_EH_DONE;
> >  	struct Scsi_Host *host = scmd->device->host;
> >  
> > +	if (req->q->mq_ops && blk_mq_mark_complete(req))
> > +		return rtn;
> > +
> >  	trace_scsi_dispatch_cmd_timeout(scmd);
> >  	scsi_log_completion(scmd, TIMEOUT_ERROR);
> >  
> > @@ -300,7 +303,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
> >  			set_host_byte(scmd, DID_TIME_OUT);
> >  			scsi_eh_scmd_add(scmd);
> >  		}
> > -	}
> > +	} else if (req->q->mq_ops)
> > +		WRITE_ONCE(req->state, MQ_RQ_IN_FLIGHT);
> >  
> >  	return rtn;
> >  }
> 
> Modifying the completion state and req->state from the SCSI core are layering
> violations. Have you considered to move the above changes into blk_mq_rq_timed_out()?
> An additional benefit of that approach is that the req->q->mq_ops checks can be
> left out.

SCSI is the only block driver that wants this behavior. Moving it back
to generic where it used to be breaks other block drivers.
