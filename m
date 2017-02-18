Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Sat, 18 Feb 2017 09:36:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv2 4/5] block/sed: Embed function data into the function
 sequence
Message-ID: <20170218083605.GB11798@lst.de>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
 <1487376029-22662-5-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
In-Reply-To: <1487376029-22662-5-git-send-email-jonathan.derrick@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Rafael Antognolli <rafael.antognolli@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Scott Bauer <scott.bauer@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi Jon,

I think this is a great cleanup!

A few nitpicky comments below:

> -typedef int (*opal_step)(struct opal_dev *dev);
> +typedef struct opal_step {
> +	int (*fn)(struct opal_dev *dev, void *data);
> +	void *data;
> +} opal_step;

no typedefs for structure types, please.

> +	opal_step *funcs;

maybe calls this member steps?

> +static int set_mbr_done(struct opal_dev *dev, void *data)
>  {
> -	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state];
> +	u8 mbr_done_tf = *(u8 *)data;

No need for casts when going from void * to any pointer type.  There are
a couple more instance below where the cast should be removed as well.

> +static int __opal_lock_unlock(struct opal_dev *dev,
> +			      struct opal_lock_unlock *lk_unlk)
>  {
> +	opal_step _unlock_funcs[] = {
> +		{ opal_discovery0, },
> +		{ start_auth_opal_session, &lk_unlk->session },
> +		{ NULL, lk_unlk },
> +		{ end_opal_session, },
> +		{ NULL, }
>  	};
>  
> +	if (lk_unlk->session.sum)
> +		_unlock_funcs[2].fn = lock_unlock_locking_range_sum;
> +	else
> +		_unlock_funcs[2].fn = lock_unlock_locking_range;
>  
>  	dev->funcs = _unlock_funcs;

I would suggest to just have two different arrays, and merge
__opal_lock_unlock into opal_lock_unlock.  E.g. something like:

static int opal_lock_unlock(struct opal_dev *dev,
		struct opal_lock_unlock *lk_unlk)
{
	const struct opal_step unlock_funcs[] = {
		{ opal_discovery0, },
		{ start_auth_opal_session, &lk_unlk->session },
		{ lock_unlock_locking_range, lk_unlk },
		{ end_opal_session, },
		{ NULL, }
	};
	const struct opal_step unlock_sun_funcs[] = {
		{ opal_discovery0, },
		{ start_auth_opal_session, &lk_unlk->session },
		{ lock_unlock_locking_range_sum, lk_unlk },
		{ end_opal_session, },
		{ NULL, }
	};
	int ret;

	if (lk_unlk->session.who < OPAL_ADMIN1 ||
	    lk_unlk->session.who > OPAL_USER9)
		return -EINVAL;

	mutex_lock(&dev->dev_lock);
	setup_opal_dev(dev, lk_unlk->session.sum ?
			unlock_sum_funcs : unlock_funcs);
	ret = next(dev);
	mutex_unlock(&dev->dev_lock);
	return ret;
}

and yes, I noticed that all the opal_step structures really should
be marked const, especially given that they contain function pointers
and are potential exploit targets.  Please apply that everywhere.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
