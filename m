Return-Path: <axboe@kernel.dk>
Date: Thu, 31 Aug 2017 14:19:44 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-block@vger.kernel.org, jonathan.derrick@intel.com,
	david.fugate@intel.com, hch@infradead.org,
	rafael.antognolli@intel.com
Subject: Re: [PATCH] block: sed-opal: Set MBRDone on S3 resume path if TPER
 is MBREnabled
Message-ID: <20170831201942.GA18975@kernel.dk>
References: <20170831174238.2714-1-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170831174238.2714-1-scott.bauer@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 31 2017, Scott Bauer wrote:
> @@ -2345,6 +2371,11 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  				 suspend->unlk.session.sum);
>  			was_failure = true;
>  		}
> +		if (dev->mbr_enabled) {
> +			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
> +			if (ret)
> +				pr_debug("Failed to set MBR Done in S3 resume\n");
> +		}

Should ret != 0 set was_failure = true here?

-- 
Jens Axboe
