Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140F7DA7D;
	Wed,  2 Oct 2024 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727847337; cv=none; b=n45jmd3ZKLIiPkMPa390PkkbaJ1OcmOkgULEmheQG1v5P+U3pbeFBlnNUXBv6pRDMIk08C2ie0UB6sci5jYmNH7neD5O2Uv+vXQKzHxNzOB1URpylZuHQllkdXp7mZOBgHNt0M9Vgq2Bk1wO7S85es9gAWzZdumrqNGi+zigLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727847337; c=relaxed/simple;
	bh=5frUcuNeQhLDV67412OFB1uizm5LWu5khfJ2QvLJL8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL8FIm/Q2v/ZfJaovmxXB1FrxmA2UHJJANYyO8PU6W4J/b4yijBScQ9gaKZ+v5qO0bm59kyHv0tYi3UtvWPH6lftYS8trKW/wCYr1A4KA+F8vjRkGC52IaBT4EUUyaAwclJA+VgOIpwJeAVbUXc7jxIgx2fDG6gfi/HyO7wDzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2JiL94x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2JiL94x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD12C4CEC5;
	Wed,  2 Oct 2024 05:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727847336;
	bh=5frUcuNeQhLDV67412OFB1uizm5LWu5khfJ2QvLJL8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W2JiL94xL7PIn6dM1gJagZmSsIa2ocDZbfBNWgn0opvzSgwxJ0Dk5+TYipEg8/T8U
	 1YcKzJdfCs7i9vplPvAk/xhNq261nINFJboaEGSZUEPgNXgH8iZ2690z0ilAMYDWS0
	 e9spRyQAQ9fyfmdYd+3RIbufrlgH+hZgBBACAjK9I9F/yFygqKoNAgTe7TEpQQ+R0l
	 tldp6jaQ90+HCPJrG+pzoSO0mrwJUGwjqsFJf84BAeUcwAZqkc5o5CW+u+0R7UohGO
	 sK2Z8vBxlg3cFmBE5DXYg4J4cCmew46kIE36QU99eJaL36jS0ENOAB+sKHcFqzQFpl
	 7nswrJdOyHp8Q==
Message-ID: <69292789-fb92-45de-8608-185849fdd543@kernel.org>
Date: Wed, 2 Oct 2024 14:35:33 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking
 the using of net_device
To: Chun-Yi Lee <joeyli.kernel@gmail.com>, Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Emelianov <xemul@openvz.org>,
 Kirill Korotaev <dev@openvz.org>, "David S . Miller" <davem@davemloft.net>,
 Nicolai Stange <nstange@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chun-Yi Lee <jlee@suse.com>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-2-jlee@suse.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241002040616.25193-2-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 1:06 PM, Chun-Yi Lee wrote:
> This is a patch for debugging. For tracking the reference count of using
> net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
> structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
> call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
> same time.
> 
> Defined DEBUG to the top of the aoe.h can enable the tracking function.
> The nd_pcpu_refcnt will be printed to debugfs:

Why not make that a config option ? That would avoid having to edit the code to
enable debugging...

> 
> rttavg: 249029 rttdev: 1781043
> nskbpool: 0
> kicked: 0
> maxbcnt: 1024
> ref: 0
> falloc: 36
> ffree: 0000000013c0033f
> 52540054c48e:0:16:16
>         ssthresh:8
>         taint:0
>         r:1270
>         w:8
>         enp1s0:1	<-- the aoeif->nd_pcpu_refcnt is behind nd->name
> 
> The value of aoeif->nd_pcpu_refcnt will also be printed when 'rmmod aoe':
> 
> [23412.255237][ T2857] aoe: enp1s0->refcnt: 32, aoeif->nd_refcnt: 0
> 
> Using kernel dynamic debug can print more detail log but it causes extra
> overhead:
> 
> echo -n 'file drivers/block/aoe/* +p' > /sys/kernel/debug/dynamic_debug/control
> 
> [ 6961.938642] aoe: tx dev_put enp1s0->refcnt: 31, aoeif->nd_refcnt: 1
> [ 7023.368814] aoe: aoecmd_cfg_pkts dev_hold lo->refcnt: 30
> [ 7023.370530] aoe: aoecmd_cfg_pkts dev_hold enp1s0->refcnt: 32, aoeif->nd_refcnt: 2
> [ 7023.372977] aoe: tx dev_put lo->refcnt: 29
> [ 7023.375147] aoe: tx dev_put enp1s0->refcnt: 31, aoeif->nd_refcnt: 1
> 
> Normally, after one operation of aoe, the aoeif->nd_refcnt should be
> shown as '1' which means that calls of dev_hold(nd)/dev_put(nd) are
> balanced. The final '1' reference of net_device will be removed when
> rmmod aoe.
> 
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> ---
>  drivers/block/aoe/aoe.h    | 84 ++++++++++++++++++++++++++++++++++++++
>  drivers/block/aoe/aoeblk.c |  5 +++
>  drivers/block/aoe/aoedev.c | 20 +++++++++
>  3 files changed, 109 insertions(+)
> 
> diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
> index 749ae1246f4c..a6d954562794 100644
> --- a/drivers/block/aoe/aoe.h
> +++ b/drivers/block/aoe/aoe.h
> @@ -1,5 +1,6 @@
>  /* Copyright (c) 2013 Coraid, Inc.  See COPYING for GPL terms. */
>  #include <linux/blk-mq.h>
> +#include <linux/netdevice.h>
>  
>  #define VERSION "85"
>  #define AOE_MAJOR 152
> @@ -133,6 +134,9 @@ struct aoeif {
>  	struct net_device *nd;
>  	ulong lost;
>  	int bcnt;
> +#ifdef DEBUG
> +	int __percpu *nd_pcpu_refcnt;
> +#endif
>  };
>  
>  struct aoetgt {
> @@ -238,6 +242,7 @@ void aoedev_downdev(struct aoedev *d);
>  int aoedev_flush(const char __user *str, size_t size);
>  void aoe_failbuf(struct aoedev *, struct buf *);
>  void aoedev_put(struct aoedev *);
> +struct aoeif *get_aoeif(struct net_device *nd);
>  
>  int aoenet_init(void);
>  void aoenet_exit(void);
> @@ -246,3 +251,82 @@ int is_aoe_netif(struct net_device *ifp);
>  int set_aoe_iflist(const char __user *str, size_t size);
>  
>  extern struct workqueue_struct *aoe_wq;
> +
> +#ifdef DEBUG
> +static inline int aoeif_nd_refcnt_read(const struct aoeif *ifp)
> +{
> +       int i, refcnt = 0;
> +
> +       for_each_possible_cpu(i)
> +               refcnt += *per_cpu_ptr(ifp->nd_pcpu_refcnt, i);
> +       return refcnt;
> +}
> +
> +static inline void aoeif_nd_refcnt_free(struct aoeif *ifp)
> +{
> +	int i;
> +
> +	if(!ifp)
> +		return;
> +	if (ifp->nd)
> +		pr_info("aoe: %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> +			ifp->nd->name, netdev_refcnt_read(ifp->nd),
> +			aoeif_nd_refcnt_read(ifp));
> +	else
> +		pr_info("aoe: aoeif->nd_refcnt: %d\n", aoeif_nd_refcnt_read(ifp));
> +
> +	for_each_possible_cpu(i)
> +		*per_cpu_ptr(ifp->nd_pcpu_refcnt, i) = 0;
> +	free_percpu(ifp->nd_pcpu_refcnt);
> +	ifp->nd_pcpu_refcnt = NULL;
> +}
> +
> +/* ifi aoeif input, nb be set to aoeif or in the future will be set */
> +static inline void __nd_dev_hold(const char *str, struct net_device *nd, struct aoeif *ifi)
> +{
> +	struct aoeif *ifp;
> +
> +	if (!nd)
> +		return;
> +	dev_hold(nd);
> +	ifp = ifi? ifi:get_aoeif(nd);
> +	if (ifp) {
> +		this_cpu_inc(*ifp->nd_pcpu_refcnt);
> +		pr_debug("aoe: %s dev_hold %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> +			 str, nd->name, netdev_refcnt_read(nd),
> +			 aoeif_nd_refcnt_read(ifp));
> +	} else
> +		pr_debug("aoe: %s dev_hold %s->refcnt: %d\n",
> +			 str, nd->name, netdev_refcnt_read(nd));

Missing curly brackets around the else statement.

> +}
> +#define nd_dev_hold(msg, ifi) __nd_dev_hold(__FUNCTION__, (msg), (ifi))
> +
> +static inline void __nd_dev_put(const char *str, struct net_device *nd, struct aoeif *ifi)
> +{
> +	struct aoeif *ifp;
> +
> +	if (!nd)
> +		return;
> +	dev_put(nd);
> +	ifp = ifi? ifi:get_aoeif(nd);
> +	if (ifp) {
> +		this_cpu_dec(*ifp->nd_pcpu_refcnt);
> +		pr_debug("aoe: %s dev_put %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> +			 str, nd->name, netdev_refcnt_read(nd),
> +			 aoeif_nd_refcnt_read(ifp));
> +	} else
> +		pr_debug("aoe: %s dev_put %s->refcnt: %d\n",
> +			 str, nd->name, netdev_refcnt_read(nd));

Same here.

> +}
> +#define nd_dev_put(msg, ifi) __nd_dev_put(__FUNCTION__, (msg), (ifi))
> +#else
> +static inline void nd_dev_put(struct net_device *nd, struct aoeif *ifi)
> +{
> +	dev_hold(nd);
> +}
> +static inline void nd_dev_hold(struct net_device *nd, struct aoeif *ifi)
> +{
> +       dev_put(nd);
> +}
> +static inline void aoeif_nd_refcnt_free(const struct aoeif *ifp) {}
> +#endif // DEBUG
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index 2028795ec61c..19d62ccca1e9 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -142,7 +142,12 @@ static int aoe_debugfs_show(struct seq_file *s, void *ignored)
>  		ifp = (*t)->ifs;
>  		ife = ifp + ARRAY_SIZE((*t)->ifs);
>  		for (; ifp->nd && ifp < ife; ifp++) {
> +#ifdef DEBUG
> +			seq_printf(s, "%c%s:%d", c, ifp->nd->name,
> +					aoeif_nd_refcnt_read(ifp));

I personnally find it better looking to align the arguments instead of adding a
random tab...

> +#else
>  			seq_printf(s, "%c%s", c, ifp->nd->name);
> +#endif
>  			c = ',';
>  		}
>  		seq_puts(s, "\n");
> diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
> index 3523dd82d7a0..9781488b286b 100644
> --- a/drivers/block/aoe/aoedev.c
> +++ b/drivers/block/aoe/aoedev.c
> @@ -529,3 +529,23 @@ aoedev_init(void)
>  {
>  	return 0;
>  }
> +
> +struct aoeif *
> +get_aoeif(struct net_device *nd)

Why the line split after "*" ?

> +{
> +	struct aoedev *d;
> +	struct aoetgt *t, **tt, **te;
> +	struct aoeif *ifp;
> +
> +	for (d=devlist; d; d=d->next) {
> +		tt = d->targets;
> +		te = tt + d->ntargets;
> +		for (; tt < te && (t = *tt); tt++) {
> +			for (ifp = t->ifs; ifp < &t->ifs[NAOEIFS]; ++ifp) {
> +				if (ifp->nd && (ifp->nd == nd))
> +					return ifp;
> +			}
> +		}
> +	}
> +	return NULL;
> +}


-- 
Damien Le Moal
Western Digital Research
