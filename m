Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9C152799
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490102; cv=none; b=ccJ3hECkQDWuAIOyp+0fqpJ3unPetx0H93hjjfCNDhBf+Y0I+Ka/a99HWA7bC9mYs9yaS/E1grnqEfJIJu13tgWQqWN/kOt49j0f6riyv9M6HO46Q2zIt2/w15wo/2wmzqK8ON0lyaE27aXe05g0Mvf3wKhs4q2qh3ki1eoowKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490102; c=relaxed/simple;
	bh=0q9JnC7AtHArcwRchYNVC63YijyWNbpeWNfZqlO+Gqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/EpEmjnkOR2vvlixvF8jKsdXV1Bk59o/No61lMgAngdA56KeWuCqFvtsqPqbPDHeo8A+gP6TCN6SvTAepdh8XwO0D8FaLoM/3IHS4MkuwH1u6Ns1aCZ/FIDYrZKxliPDDo2iLwtQWJAWT4jwr5x+WQ1xeEkOuuCEfqbBdg+wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dJxwK9o4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dJxwK9o4"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dd64d6fe94so66247711fa.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714490098; x=1715094898; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj+NJgrctHbYKvlDUtiq5+hS/4hqbk09ePj0poTKl4I=;
        b=dJxwK9o41dg19i796kwWa4WUkhpF0SkvnQjcKBwEH6fXJjy6lj25JBKPmcPb/IE9oB
         k0fKQ50jwzLec7v6GAbiL30/J3y2JkGs5EXLzDRe8Jo26RuMuVH8Bk7+MIwgqN6rKdty
         QLZlwKS2y1uwUy7nNzOdFW0+SQ53Qn07z3QpBbd2/ujTw1ibIPOyGwnRT7D22IGnlBie
         y/jahfJbfFjgiQcahfyH8rIAeIV1dB1A03GF8CpiYXPurO5SU5B3jTNl7xM9Tk/wRJFR
         PssLVSrisJs6v45O/gnigWhIs2ECW1JSEyz5lpjMcmOEVqilu2ETmj96Yw2Skdhge5IW
         h9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490098; x=1715094898;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj+NJgrctHbYKvlDUtiq5+hS/4hqbk09ePj0poTKl4I=;
        b=AUwNhWTLQRzabDkgPyDonMP45iYqUd4o4C5zQHyIG9rrc+6ys4u548Wz3IZZZuHsag
         E9AFIzmwS5zvhijsNcK7yiwcoww4M7tPdgt522RAZFqLjXgBcQlPGn4rugks82u1wH3n
         b/TTnSX8SjUw2oiPdr8y1OJ6dcqxsgJYbFvuzAFW6uniow4bMmf4xwfHOY7it5nKIoFR
         7fwXm8qryxyFBDBG6hqU0q/Ir2+wornYYLcy+KVToZsftw6p01r5T/br2U7AyaK8PpqR
         aXmTKK2DB1Ntk0lF5g++GQ4iMQQC+RV96Rm9d+X7l5sk/EDZHbQlVabg8x9AqXGw7bDi
         Kekw==
X-Forwarded-Encrypted: i=1; AJvYcCUEW6D9xrJWP8yJfT+Ibn7FQRILkFWGLZJq/9CKEDwfRfpspCTfraK1OreB+z2IMfKuEKqNtjmY2h5msXbdFPusvpPQkEm5OBA9qyY=
X-Gm-Message-State: AOJu0YwmDT3vQDNzbe+L3SVcgk9Ssf3BcrSXAGuc2Kar1YDaDfhLPI9c
	m5WZ7BtsFigoTdCW1501iJkE11pJMzIuT/GXdgwHkBAAMy9yVtHK0vhE0RNI69tV9FY2PN+U7h1
	/
X-Google-Smtp-Source: AGHT+IF9v40sox6idzuZNof00mKqtsy+7kllosU/doJrGQv/BB2cC9RjYP5cJN23cV5HQfij89moNw==
X-Received: by 2002:a2e:900e:0:b0:2e0:3132:94d4 with SMTP id h14-20020a2e900e000000b002e0313294d4mr18367ljg.16.1714490097887;
        Tue, 30 Apr 2024 08:14:57 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001eb53dcf458sm6601555plg.188.2024.04.30.08.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 08:14:57 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:49 +0800
From: joeyli <jlee@suse.com>
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240430151449.GM26307@linux-l9pv.suse>
References: <20240410134858.6313-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134858.6313-1-jlee@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Justin, 

On Wed, Apr 10, 2024 at 09:48:58PM +0800, Lee, Chun-Yi wrote:
> From: Chun-Yi Lee <jlee@suse.com>
> 
> For fixing CVE-2023-6270, f98364e92662 patch moved dev_put() from
> aoecmd_cfg_pkts() to tx() to avoid that the tx() runs into use-after-free.
> 
> But Nicolai Stange found more places in aoe have potential use-after-free
> problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> packet to tx queue. So they should also use dev_hold() to increase the
> refcnt of skb->dev.
> 
> This patch adds dev_hold() to those functions and also uses dev_put()
> when the skb_clone() returns NULL.
> 
> Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
> Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in
> aoecmd_cfg_pkts")
> Reported-by: Nicolai Stange <nstange@suse.com>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

Do you have any suggestion for this patch? or I missed anything?

Thanks a lot!
Joey Lee

> ---
>  drivers/block/aoe/aoecmd.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index cc9077b588d7..fcedbad8e3be 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -361,6 +361,7 @@ ata_rw_frameinit(struct frame *f)
>  	}
>  
>  	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
> +	dev_hold(t->ifp->nd);
>  	skb->dev = t->ifp->nd;
>  }
>  
> @@ -401,7 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
>  		__skb_queue_head_init(&queue);
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
> -	}
> +	} else
> +		dev_put(f->t->ifp->nd);
>  	return 1;
>  }
>  
> @@ -483,10 +485,13 @@ resend(struct aoedev *d, struct frame *f)
>  	memcpy(h->dst, t->addr, sizeof h->dst);
>  	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
>  
> +	dev_hold(t->ifp->nd);
>  	skb->dev = t->ifp->nd;
>  	skb = skb_clone(skb, GFP_ATOMIC);
> -	if (skb == NULL)
> +	if (skb == NULL) {
> +		dev_put(t->ifp->nd);
>  		return;
> +	}
>  	f->sent = ktime_get();
>  	__skb_queue_head_init(&queue);
>  	__skb_queue_tail(&queue, skb);
> @@ -617,7 +622,8 @@ probe(struct aoetgt *t)
>  		__skb_queue_head_init(&queue);
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
> -	}
> +	} else
> +		dev_put(f->t->ifp->nd);
>  }
>  
>  static long
> @@ -1395,6 +1401,7 @@ aoecmd_ata_id(struct aoedev *d)
>  	ah->cmdstat = ATA_CMD_ID_ATA;
>  	ah->lba3 = 0xa0;
>  
> +	dev_hold(t->ifp->nd);
>  	skb->dev = t->ifp->nd;
>  
>  	d->rttavg = RTTAVG_INIT;
> @@ -1404,6 +1411,8 @@ aoecmd_ata_id(struct aoedev *d)
>  	skb = skb_clone(skb, GFP_ATOMIC);
>  	if (skb)
>  		f->sent = ktime_get();
> +	else
> +		dev_put(t->ifp->nd);
>  
>  	return skb;
>  }
> -- 
> 2.35.3
