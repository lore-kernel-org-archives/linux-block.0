Return-Path: <zwp10758@gmail.com>
Return-Path: <zwp10758@gmail.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Wed, 11 Oct 2017 17:44:38 +0800
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171011094438.GA37287@localhost.didichuxing.com>
References: <20171010160050.GA1601@localhost.didichuxing.com>
 <20171011075833.oglwgmy763r3egfy@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011075833.oglwgmy763r3egfy@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 11, 2017 at 09:58:33AM +0200, Johannes Thumshirn wrote:
> On Wed, Oct 11, 2017 at 12:00:55AM +0800, weiping zhang wrote:
> > + * blkcg_policy_check_ops - check policy's operations
> > + * @pol: blkcg policy to check
> > + *
> > + * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs.
> > + * Return true on success and false on failure.
> > + */
> > +static bool blkcg_policy_check_ops(struct blkcg_policy *pol)
> > +{
> > +	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
> > +		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
> > +		return false;
> > +
> > +	if ((pol->pd_alloc_fn && !pol->pd_free_fn) ||
> > +		(!pol->pd_alloc_fn && pol->pd_free_fn))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/**
> >   * blkcg_policy_register - register a blkcg policy
> >   * @pol: blkcg policy to register
> >   *
> > @@ -1419,6 +1439,9 @@ int blkcg_policy_register(struct blkcg_policy *pol)
> >  	if (i >= BLKCG_MAX_POLS)
> >  		goto err_unlock;
> >  
> > +	if (!blkcg_policy_check_ops(pol))
> > +		goto err_unlock;
> > +
> 
> Can you merge it into the caller?
> 
> +	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
> +		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
> +		goto err_unlock;
> +
> +	if ((pol->pd_alloc_fn && !pol->pd_free_fn) ||
> +		(!pol->pd_alloc_fn && pol->pd_free_fn))
> +		goto err_unlock;
> 
> 
It's ok for me, I send V2 later.

Thanks
Weiping
