Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD056F305
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026269; cv=none; b=WZNW5r6HvXxOD1/tnYSz4Xr452kMonXJ/F2OnxQIW3g4b9dAFm/ak8sAWGau7H310b7bhCOQutfumFB4+UekqrUX+T6k+MQWwSPqKyzulzV4IyNsxtuUSEC4icIhHvoqibjbrARffvXnSvJuGXQXswg3zHsnCSE+EL0n+ZZRjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026269; c=relaxed/simple;
	bh=RvLQ3hgcxffhJ/7j4iwbdSErN0H5G+6+jvVLjwMWyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prgT6uWZmLANdSAhmRq5/487y8xi2NyQHmbp52aQowhVg5VZp8+/jB66kr3W/8IAtqjWpq0/+0JiCFXGhlPhKojkC4laWCnQfJ3gU3BShV5Va1ABxk+8Ih8xDIaVidbJULnnJfRkNJxlY4MtjrjkwW4ZbBjnxhrR1H/D+p1/OO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TptPJz7x; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TptPJz7x"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fadb636abaso19123491fa.3
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728026266; x=1728631066; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuULKTHuresw0Zy6wICe+A8Q6rp+HpZuWrQucEn75pE=;
        b=TptPJz7xY+vSN6OspgJRFgjv2YZaKyoB1t7PyvqGg/8MgigbpgoLvQ/OmUTjbMrpkM
         ArQg5szag3tgzjRsGEXFF/GSbcYOEWsvFkYDw+q0y6OiLcb6ohDPfoPechI+lTzjFWNh
         T9TwN4O2t4OdCaz2AJA7GIDK5Lq7nnRGrvz6Q/eLq3HgH9U/yiX+oIlcNw/xl6dYFsOc
         YBV01junQ0SB6tJMoq3Vn0a2sy3Qc8ZVv0RaSio5b0H7amPndjLI1X5rvjyet2/ytiqZ
         mJnpceSiOd+HOQoB0RwMktnjEquc7IWKmCG7gAg/9h95+RxR3Nf2JgVGsXbxLNZVCKD1
         aahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728026266; x=1728631066;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuULKTHuresw0Zy6wICe+A8Q6rp+HpZuWrQucEn75pE=;
        b=AZrJvxK1hsR3Po5fOS3SIPhmx0f0VHuXeCvZ7dAtlQuMXJrQUMc3ipIRL8zW2je7B1
         vTjO+WdC9lDPu+z6q8vZ1pfz1DCgAzPzBLaF1G5Q6ayw2ncBsuGNLMGS7UF3VPUrC/hX
         IvxwzqugNhJ/54qiTxKiyjG2CjuuXpsgz6PFfs/HPpBmWcBT+6o1WZgQ+VlNuIveb5MF
         dX9CszC7c+FmeH25Pl/WB7N2a04KhdRg7DipkaLQ9rsXCEj+Y6re5a00zRXurw8oTcs4
         jxOO95EGEYxj+m5nt0HXiPk6n4u6HHEVthhVnteuZMVtior+qTdp/zmoFi4uAhKeN6Gr
         KQig==
X-Forwarded-Encrypted: i=1; AJvYcCX9BPd/o4xyEgr4sKH5GyQu2iFHimRIVvyTWz8Jzcbqkr3/vHVAYSmgCJFCK4N2drfZYPZsmZ5Oa//01Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQusZ3IM76BBe4j8sXIRFS/jDgydtNRV/LUqcmlO8DZYHfMES
	ZPjNyTeULhqElTO9uE94AP7anaihfwsr8c8Mph0vj0AmHBRDBuN9JyhEzkZAaoZcjm90TQMX6Ta
	U
X-Google-Smtp-Source: AGHT+IH3FPLJ9NczEQNZcKAcDolBttBYKumyjdxeNCDK5IlZy+i6GBGjeqGjF6YI6L6mnh9DGpCO9w==
X-Received: by 2002:a05:651c:19a3:b0:2f9:cf21:b9f with SMTP id 38308e7fff4ca-2faf3c41fb1mr7646541fa.22.1728026265293;
        Fri, 04 Oct 2024 00:17:45 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86ac41csm800085a91.55.2024.10.04.00.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:17:44 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:17:40 +0800
From: joeyli <jlee@suse.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking
 the using of net_device
Message-ID: <20241004071740.GJ3296@linux-l9pv.suse>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-2-jlee@suse.com>
 <69292789-fb92-45de-8608-185849fdd543@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69292789-fb92-45de-8608-185849fdd543@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Damien, 

Thanks for your review, first!

On Wed, Oct 02, 2024 at 02:35:33PM +0900, Damien Le Moal wrote:
> On 10/2/24 1:06 PM, Chun-Yi Lee wrote:
> > This is a patch for debugging. For tracking the reference count of using
> > net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
> > structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
> > call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
> > same time.
> > 
> > Defined DEBUG to the top of the aoe.h can enable the tracking function.
> > The nd_pcpu_refcnt will be printed to debugfs:
> 
> Why not make that a config option ? That would avoid having to edit the code to
> enable debugging...
>

This debug patch is only for tracking the reference count of net_device but
no other debugging feature. I don't want to add one more config option for
this small feature. On the other hand, the tracking requirment of reference
count is more for developer but not for administrator. That's why I did not
add a new option.
 
> > 
> > rttavg: 249029 rttdev: 1781043
> > nskbpool: 0
> > kicked: 0
> > maxbcnt: 1024
> > ref: 0
> > falloc: 36
> > ffree: 0000000013c0033f
> > 52540054c48e:0:16:16
> >         ssthresh:8
> >         taint:0
> >         r:1270
> >         w:8
> >         enp1s0:1	<-- the aoeif->nd_pcpu_refcnt is behind nd->name
> > 
[...snip]
> > +	ifp = ifi? ifi:get_aoeif(nd);
> > +	if (ifp) {
> > +		this_cpu_inc(*ifp->nd_pcpu_refcnt);
> > +		pr_debug("aoe: %s dev_hold %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd),
> > +			 aoeif_nd_refcnt_read(ifp));
> > +	} else
> > +		pr_debug("aoe: %s dev_hold %s->refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd));
> 
> Missing curly brackets around the else statement.
>

Thanks for your reminder! I will add it in next version.
 
> > +}
> > +#define nd_dev_hold(msg, ifi) __nd_dev_hold(__FUNCTION__, (msg), (ifi))
> > +
> > +static inline void __nd_dev_put(const char *str, struct net_device *nd, struct aoeif *ifi)
> > +{
> > +	struct aoeif *ifp;
> > +
> > +	if (!nd)
> > +		return;
> > +	dev_put(nd);
> > +	ifp = ifi? ifi:get_aoeif(nd);
> > +	if (ifp) {
> > +		this_cpu_dec(*ifp->nd_pcpu_refcnt);
> > +		pr_debug("aoe: %s dev_put %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd),
> > +			 aoeif_nd_refcnt_read(ifp));
> > +	} else
> > +		pr_debug("aoe: %s dev_put %s->refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd));
> 
> Same here.
>

Thanks! I will add it.
 
> > +}
> > +#define nd_dev_put(msg, ifi) __nd_dev_put(__FUNCTION__, (msg), (ifi))
> > +#else
> > +static inline void nd_dev_put(struct net_device *nd, struct aoeif *ifi)
> > +{
> > +	dev_hold(nd);
> > +}
> > +static inline void nd_dev_hold(struct net_device *nd, struct aoeif *ifi)
> > +{
> > +       dev_put(nd);
> > +}
> > +static inline void aoeif_nd_refcnt_free(const struct aoeif *ifp) {}
> > +#endif // DEBUG
> > diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> > index 2028795ec61c..19d62ccca1e9 100644
> > --- a/drivers/block/aoe/aoeblk.c
> > +++ b/drivers/block/aoe/aoeblk.c
> > @@ -142,7 +142,12 @@ static int aoe_debugfs_show(struct seq_file *s, void *ignored)
> >  		ifp = (*t)->ifs;
> >  		ife = ifp + ARRAY_SIZE((*t)->ifs);
> >  		for (; ifp->nd && ifp < ife; ifp++) {
> > +#ifdef DEBUG
> > +			seq_printf(s, "%c%s:%d", c, ifp->nd->name,
> > +					aoeif_nd_refcnt_read(ifp));
> 
> I personnally find it better looking to align the arguments instead of adding a
> random tab...
>

Thanks! I will modify the second line to align with the first argument.
 
> > +#else
> >  			seq_printf(s, "%c%s", c, ifp->nd->name);
> > +#endif
> >  			c = ',';
> >  		}
> >  		seq_puts(s, "\n");
> > diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
> > index 3523dd82d7a0..9781488b286b 100644
> > --- a/drivers/block/aoe/aoedev.c
> > +++ b/drivers/block/aoe/aoedev.c
> > @@ -529,3 +529,23 @@ aoedev_init(void)
> >  {
> >  	return 0;
> >  }
> > +
> > +struct aoeif *
> > +get_aoeif(struct net_device *nd)
> 
> Why the line split after "*" ?
> 

I followed the same coding style in aoedev.c:

/* find it or allocate it */
struct aoedev *
aoedev_by_aoeaddr(ulong maj, int min, int do_alloc)
{
        struct aoedev *d;
...

If kernel coding style does not specify this. I prefer follow the original
style in the same driver.

Let me know if I missed anything, please. Then I will change the style. 


Thanks a lot!
Joey Lee
