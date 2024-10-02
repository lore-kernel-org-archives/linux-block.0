Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0F2C6A3;
	Wed,  2 Oct 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727847435; cv=none; b=U72B41bYVChFc3DFut3EVUyNKWqgSlpyWZxnzHb/BVAMm5hnlMt7gqnmnucq8T0oc3aA24e5alTTm0GLWRTgCf7T5pFgslD7NwBkSmLNSN4xqkCkA0/6CrhPUF5NuRwkSMhV+wMZ2G6E+4XQbafwekgq8Wx1kgDUlhhC/NSjd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727847435; c=relaxed/simple;
	bh=mkpPzh6F0UskRDMs7KY5bB2zQ2NUZ7fT5xaqtGryN4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx7La7pO/B03PLBMYWZCPD0VRBOpSl57S9D8YhKWo0KJGgnkHK1J79/zu51+mI/4z55QAAg9J1YX8G6pNMeVRyfEqP25jJf1cJjZUYe2RkRsQgfYBi4YjyBuYn0gLpAryUZxuvBydSAWdjAF+G/Rkp1ppfNwP7AugpRFMoCPkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ongfvmnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ongfvmnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28E2C4CEC5;
	Wed,  2 Oct 2024 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727847435;
	bh=mkpPzh6F0UskRDMs7KY5bB2zQ2NUZ7fT5xaqtGryN4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ongfvmnBAE4A77tC4y9gamiVSRVW0gEcVohuWKBRnuwlmvHo/tDXltdru0UcjEBLZ
	 L8rnmvTSz25N6MprWbJx08aiuOK01sCqmGYb028UL3XitLRLA8vkz4mlXmA4RTzBmh
	 OIUi07kM+b2oYmeepVDyfkI+gI66R9epP84ldS2GCuY3tbWx6NXQ9y9EYJ1OiBOSET
	 6leCMjsZL8GzWfKD3B+dAvunRyovHI/P/CSoceFUCSls1CfqzhSRJywJVy51pnvWxx
	 FyEVURdMbWZwyiCbaRilebBEz7TShT0Qm+aUDeeRkgXbg+YROwWUdb+07OwtVCSvw7
	 XkRbrC8aW2QvQ==
Message-ID: <bee9261e-1d8d-41d3-a600-da962aa4cf0f@kernel.org>
Date: Wed, 2 Oct 2024 14:37:12 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] aoe: using wrappers instead of dev_hold/dev_put
 for tracking the references of net_device in aoeif
To: Chun-Yi Lee <joeyli.kernel@gmail.com>, Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Emelianov <xemul@openvz.org>,
 Kirill Korotaev <dev@openvz.org>, "David S . Miller" <davem@davemloft.net>,
 Nicolai Stange <nstange@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chun-Yi Lee <jlee@suse.com>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-3-jlee@suse.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241002040616.25193-3-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 1:06 PM, Chun-Yi Lee wrote:
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

The wrappers where introduced in patch 1 without any user. So it seems that
this patch should be squashed together with patch 1.

> ---
>  drivers/block/aoe/aoecmd.c | 24 ++++++++++++------------
>  drivers/block/aoe/aoedev.c |  3 ++-
>  drivers/block/aoe/aoenet.c |  2 +-
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index d1f4ddc57645..2bae364fc5ef 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -361,7 +361,7 @@ ata_rw_frameinit(struct frame *f)
>  	}
>  
>  	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
> -	dev_hold(t->ifp->nd);
> +	nd_dev_hold(t->ifp->nd, t->ifp);
>  	skb->dev = t->ifp->nd;
>  }
>  
> @@ -403,7 +403,7 @@ aoecmd_ata_rw(struct aoedev *d)
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
>  	} else {
> -		dev_put(f->t->ifp->nd);
> +		nd_dev_put(f->t->ifp->nd, f->t->ifp);
>  	}
>  	return 1;
>  }
> @@ -421,16 +421,16 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
>  
>  	rcu_read_lock();
>  	for_each_netdev_rcu(&init_net, ifp) {
> -		dev_hold(ifp);
> +		nd_dev_hold(ifp, NULL);
>  		if (!is_aoe_netif(ifp)) {
> -			dev_put(ifp);
> +			nd_dev_put(ifp, NULL);
>  			continue;
>  		}
>  
>  		skb = new_skb(sizeof *h + sizeof *ch);
>  		if (skb == NULL) {
>  			printk(KERN_INFO "aoe: skb alloc failure\n");
> -			dev_put(ifp);
> +			nd_dev_put(ifp, NULL);
>  			continue;
>  		}
>  		skb_put(skb, sizeof *h + sizeof *ch);
> @@ -486,11 +486,11 @@ resend(struct aoedev *d, struct frame *f)
>  	memcpy(h->dst, t->addr, sizeof h->dst);
>  	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
>  
> -	dev_hold(t->ifp->nd);
> +	nd_dev_hold(t->ifp->nd, t->ifp);
>  	skb->dev = t->ifp->nd;
>  	skb = skb_clone(skb, GFP_ATOMIC);
>  	if (skb == NULL) {
> -		dev_put(t->ifp->nd);
> +		nd_dev_put(t->ifp->nd, t->ifp);
>  		return;
>  	}
>  	f->sent = ktime_get();
> @@ -552,7 +552,7 @@ ejectif(struct aoetgt *t, struct aoeif *ifp)
>  	n = (e - ifp) * sizeof *ifp;
>  	memmove(ifp, ifp+1, n);
>  	e->nd = NULL;
> -	dev_put(nd);
> +	nd_dev_put(nd, NULL);
>  }
>  
>  static struct frame *
> @@ -624,7 +624,7 @@ probe(struct aoetgt *t)
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
>  	} else {
> -		dev_put(f->t->ifp->nd);
> +		nd_dev_put(f->t->ifp->nd, f->t->ifp);
>  	}
>  }
>  
> @@ -1403,7 +1403,7 @@ aoecmd_ata_id(struct aoedev *d)
>  	ah->cmdstat = ATA_CMD_ID_ATA;
>  	ah->lba3 = 0xa0;
>  
> -	dev_hold(t->ifp->nd);
> +	nd_dev_hold(t->ifp->nd, t->ifp);
>  	skb->dev = t->ifp->nd;
>  
>  	d->rttavg = RTTAVG_INIT;
> @@ -1414,7 +1414,7 @@ aoecmd_ata_id(struct aoedev *d)
>  	if (skb)
>  		f->sent = ktime_get();
>  	else
> -		dev_put(t->ifp->nd);
> +		nd_dev_put(t->ifp->nd, t->ifp);
>  
>  	return skb;
>  }
> @@ -1514,7 +1514,7 @@ setifbcnt(struct aoetgt *t, struct net_device *nd, int bcnt)
>  			pr_err("aoe: device setifbcnt failure; too many interfaces.\n");
>  			return;
>  		}
> -		dev_hold(nd);
> +		nd_dev_hold(nd, p);
>  		p->nd = nd;
>  		p->bcnt = bcnt;
>  	}
> diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
> index 9781488b286b..48c936dbb9e5 100644
> --- a/drivers/block/aoe/aoedev.c
> +++ b/drivers/block/aoe/aoedev.c
> @@ -504,7 +504,8 @@ freetgt(struct aoedev *d, struct aoetgt *t)
>  	for (ifp = t->ifs; ifp < &t->ifs[NAOEIFS]; ++ifp) {
>  		if (!ifp->nd)
>  			break;
> -		dev_put(ifp->nd);
> +		nd_dev_put(ifp->nd, ifp);
> +		aoeif_nd_refcnt_free(ifp);
>  	}
>  
>  	head = &t->ffree;
> diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
> index 923a134fd766..3565042b567f 100644
> --- a/drivers/block/aoe/aoenet.c
> +++ b/drivers/block/aoe/aoenet.c
> @@ -63,7 +63,7 @@ tx(int id) __must_hold(&txlock)
>  			pr_warn("aoe: packet could not be sent on %s.  %s\n",
>  				ifp ? ifp->name : "netif",
>  				"consider increasing tx_queue_len");
> -		dev_put(ifp);
> +		nd_dev_put(ifp, NULL);
>  		spin_lock_irq(&txlock);
>  	}
>  	return 0;


-- 
Damien Le Moal
Western Digital Research
