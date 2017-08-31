Return-Path: <scott.bauer@intel.com>
Date: Thu, 31 Aug 2017 14:13:21 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, jonathan.derrick@intel.com,
	david.fugate@intel.com, hch@infradead.org,
	rafael.antognolli@intel.com
Subject: Re: [PATCH] block: sed-opal: Set MBRDone on S3 resume path if TPER
 is MBREnabled
Message-ID: <20170831201320.rd4agb7jxae7xh6e@sbauer-Z170X-UD5>
References: <20170831174238.2714-1-scott.bauer@intel.com>
 <20170831201942.GA18975@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170831201942.GA18975@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 31, 2017 at 02:19:44PM -0600, Jens Axboe wrote:
> On Thu, Aug 31 2017, Scott Bauer wrote:
> > @@ -2345,6 +2371,11 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
> >  				 suspend->unlk.session.sum);
> >  			was_failure = true;
> >  		}
> > +		if (dev->mbr_enabled) {
> > +			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
> > +			if (ret)
> > +				pr_debug("Failed to set MBR Done in S3 resume\n");
> > +		}
> 
> Should ret != 0 set was_failure = true here?

I thought about that too and decided against it. The reasoning is was_failure was supposed
to designate an unlock failure, specifically on the unlock comamnd, not the new mbr_enable
command. An unlock can still succeed and the MBR set can fail under some extreme
scenario, in which case the pr_debug will let us know (maybe we should promote that to pr_warn?).

More over, it seems like none of the callers scsi/nvme are even using the return value. Since
not being able to unlock a range isn't a failure of the actual bring up of the drive everyone
ignores It, I guess. Since no one is using the return value "was_failure" perhaps I should just
refactor this to void. That is unless others think it should stay for potential future devices which
may care if something isn't unlocked and want to do something else?


> 
> -- 
> Jens Axboe
> 
