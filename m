Return-Path: <jthumshirn@suse.de>
Date: Wed, 11 Oct 2017 09:58:33 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171011075833.oglwgmy763r3egfy@linux-x5ow.site>
References: <20171010160050.GA1601@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171010160050.GA1601@localhost.didichuxing.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 11, 2017 at 12:00:55AM +0800, weiping zhang wrote:
> + * blkcg_policy_check_ops - check policy's operations
> + * @pol: blkcg policy to check
> + *
> + * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs.
> + * Return true on success and false on failure.
> + */
> +static bool blkcg_policy_check_ops(struct blkcg_policy *pol)
> +{
> +	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
> +		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
> +		return false;
> +
> +	if ((pol->pd_alloc_fn && !pol->pd_free_fn) ||
> +		(!pol->pd_alloc_fn && pol->pd_free_fn))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
>   * blkcg_policy_register - register a blkcg policy
>   * @pol: blkcg policy to register
>   *
> @@ -1419,6 +1439,9 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>  	if (i >= BLKCG_MAX_POLS)
>  		goto err_unlock;
>  
> +	if (!blkcg_policy_check_ops(pol))
> +		goto err_unlock;
> +

Can you merge it into the caller?

+	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
+		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
+		goto err_unlock;
+
+	if ((pol->pd_alloc_fn && !pol->pd_free_fn) ||
+		(!pol->pd_alloc_fn && pol->pd_free_fn))
+		goto err_unlock;



-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
