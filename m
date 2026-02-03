Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C046393DCA
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109604; cv=none; b=Ev2msrCCDeV3W6A/VHe3aWKPWHv8/MuNLed2j2CciRhdqExCzpg6i5zAHftihFK4mZW840UzQvHvrimC427AIdB12VOCzc4fQuyLpabsTlh5RfKwNVyV8eo4zJdemdrOWyVuQ4sAIkSrPN62faOeZYFNnuxL5y8GcIUve8lbP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109604; c=relaxed/simple;
	bh=MOKpDNTqNF8fAwtcWjo9j4D4UG1yJPkppdfmDHB9hNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4Pg0dgzbdIaPljtizQEYDyPwIjQvuvG2np7tp8RCFAc/eA9G36zmVrtrl3E5s55G92zPg7ALhfgoTcqn//HXhWCK4k6yvF3ofcZG+SYFZQpSQrMscjcRABHSQT7+xxSGBn3vo3P69MkgmXK975J+BJN0VtHJ1WlxI9GQd8sck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZUvIt8fg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZUvIt8fg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso4184005e9.0
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770109601; x=1770714401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaA9Uux9+RofOmmDHbyRFguFePFUhjemsJOqSAyT258=;
        b=ZUvIt8fgmgGCjFssb1+TXvQeDodNR3iSAIdKeBbWit1oy4XyOESYEtL4vY3Mh9qffi
         w3jtY8i+o6fF2RXMkUjvK52LBwklyRtqVTVWjBjreG3QnlQy9PC4URcWurr9RoAfonHQ
         sVKcruz8kZDTxWQsP+q3n6kJcgB3Tpj7qAva7FzhXCFDkhtnztMHU4mMsgld+bNnnMSQ
         Ra7MThdzfjF0VUAZN0yAOVf1YTU4vBfIGCCJzNDquMhUgetPbQBJ3RxE4aOJBUdPrxLc
         lUNNj2ykc1Kms+LHbrCjJxiPX/hW++COXOP7mt+gvrp0TBUYNj0jCxLsd6L45UYgK/y4
         /LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109601; x=1770714401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaA9Uux9+RofOmmDHbyRFguFePFUhjemsJOqSAyT258=;
        b=UWI9aHd+sdpXbr5YkNo9TQF5jLraDWjN5SJuRz8GDIh4rNVOoCN2dh9Foq0LJAL85p
         h4OElU1j1hp86QXNsV0s/nZ3Ibwd1rEvCttggdWoUMrkv92YA6K3OhW8E1gIIDPds3I/
         I9DADqHUxF0LmuU+Cm14pLqlKaT1Ci8s7d08g2ItSids27JK2i6cUrYhBjHEsgtwLXHm
         9xXh61oDWiunYjjf35BqaPlwCq9ZRY/JCaHkPAgYHXqCD0HZRLuwqK2xc6UdMP++ABlJ
         qWDCULjVvpY5SdgUQbyP/ySTBbUTp2vGOXHOBfuvZ6PnC0URrf6E0vSxWZ84X7sctK+j
         BT0g==
X-Forwarded-Encrypted: i=1; AJvYcCUPDPV3WMGkgw9XQlBkYcfVxOlvYXJFPUaPfuiSUqrGVi7pQ9Z0LM1FfXQP6lm/u96iRmR6s3QM0vphlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeQwX16BH1ExWd7GrxYdUOd/c5N9u4wvm93fQoi06R96EDXmy
	wtuI1ykiWcnWn7JBWx1j4F6XdQ8Fni5lmEGVd5d0lDl0cmCWwotFxwTPa42Jd47e/40=
X-Gm-Gg: AZuq6aJbjwtE3t+cIqp5JfCEOIKPnMjHMACcAFRr6R8KPlA5jRpbkkN6OUo0FhXe6V8
	z283UwE0G8SOaliEXjt1OfIUt7f4CNttJ/GEaJazwzr7UtIfjTOjYi+mM1a0Ge6xlrN42ac2TyN
	60p6TQF8MvmchXOHUFsQqSmw49VuwQdNx9WTRbXW8EYjIv0WwrUR4ySd803gARF3lTbLoXrYYTr
	3xXMIf9nlfFg13SXobQbQihqEKkNysGYzMo9hTszcddj67jy9PDztG/KpZo9Hc3HzUJkMML49ui
	Y5Sf9Pc5B5VQPRPQVPFNjD06jw3w5hU5EHkSHeHwvJ5xees6rGW5a/X/4xmcTSY1fFHlj7VBdat
	LwWXNMuzdPjnFkF6RMWBuwJi/79DFBHeJLGnqyNpsGBMJGjv+vpmp0s4Zy6lKQTEBkzj1b4ayEB
	Ukg7J/0jf8jrMPh0LrgKR4JlPHMlNnsmK/5Ah51Hse7g==
X-Received: by 2002:a05:600c:5394:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-483050f3f03mr32702305e9.0.1770109600817;
        Tue, 03 Feb 2026 01:06:40 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830515381esm52449765e9.11.2026.02.03.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:06:40 -0800 (PST)
Date: Tue, 3 Feb 2026 10:06:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhengqixing@huawei.com, hch@infradead.org, ming.lei@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 6/7] blk-cgroup: allocate pds before freezing queue in
 blkcg_activate_policy()
Message-ID: <gq45vl55n2gucipjc5jk5e5kp7ups3nw672ua6nvksooycezv5@lfr62hy5br4f>
References: <20260203080602.726505-1-yukuai@fnnas.com>
 <20260203080602.726505-7-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg37qi5glisvi4nl"
Content-Disposition: inline
In-Reply-To: <20260203080602.726505-7-yukuai@fnnas.com>


--dg37qi5glisvi4nl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/7] blk-cgroup: allocate pds before freezing queue in
 blkcg_activate_policy()
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 04:06:01PM +0800, Yu Kuai <yukuai@fnnas.com> wrote:
> Some policies like iocost and iolatency perform percpu allocation in
> pd_alloc_fn(). Percpu allocation with queue frozen can cause deadlock
> because percpu memory reclaim may issue IO.
>=20
> Now that q->blkg_list is protected by blkcg_mutex,

With this ^^^

=2E..
> restructure
> blkcg_activate_policy() to allocate all pds before freezing the queue:
> 1. Allocate all pds with GFP_KERNEL before freezing the queue
> 2. Freeze the queue
> 3. Initialize and online all pds
>=20
> Note: Future work is to remove all queue freezing before
> blkcg_activate_policy() to fix the deadlocks thoroughly.
>=20
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-cgroup.c | 90 +++++++++++++++++-----------------------------
>  1 file changed, 32 insertions(+), 58 deletions(-)
>=20
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 0206050f81ea..7fcb216917d0 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1606,8 +1606,7 @@ static void blkcg_policy_teardown_pds(struct reques=
t_queue *q,
>  int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_polic=
y *pol)
>  {
>  	struct request_queue *q =3D disk->queue;
> -	struct blkg_policy_data *pd_prealloc =3D NULL;
> -	struct blkcg_gq *blkg, *pinned_blkg =3D NULL;
> +	struct blkcg_gq *blkg;
>  	unsigned int memflags;
>  	int ret;
> =20
> @@ -1622,90 +1621,65 @@ int blkcg_activate_policy(struct gendisk *disk, c=
onst struct blkcg_policy *pol)
=2E..

> +	/* Now freeze queue and initialize/online all pds */
> +	if (queue_is_mq(q))
> +		memflags =3D blk_mq_freeze_queue(q);
> +
> +	spin_lock_irq(&q->queue_lock);
> +	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
> +		struct blkg_policy_data *pd =3D blkg->pd[pol->plid];
> +
> +		/* Skip dying blkg */
> +		if (hlist_unhashed(&blkg->blkcg_node))
> +			continue;
> +
> +		spin_lock(&blkg->blkcg->lock);
>  		if (pol->pd_init_fn)
>  			pol->pd_init_fn(pd);
> -
>  		if (pol->pd_online_fn)
>  			pol->pd_online_fn(pd);
>  		pd->online =3D true;
> -
>  		spin_unlock(&blkg->blkcg->lock);
>  	}
> =20
>  	__set_bit(pol->plid, q->blkcg_pols);
> -	ret =3D 0;
> -
>  	spin_unlock_irq(&q->queue_lock);
> -out:
> -	mutex_unlock(&q->blkcg_mutex);
> +
>  	if (queue_is_mq(q))
>  		blk_mq_unfreeze_queue(q, memflags);
> -	if (pinned_blkg)
> -		blkg_put(pinned_blkg);
> -	if (pd_prealloc)
> -		pol->pd_free_fn(pd_prealloc);
> -	return ret;
> +	mutex_unlock(&q->blkcg_mutex);
> +	return 0;

Why is q->queue_lock still needed here?

Thanks,
Michal

--dg37qi5glisvi4nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYG6kBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjEEQD/S6QTA3Md9Aw4rFLx2TGh
sAf5TpmWFXBsYFlAeJMSE9kBALzTT27YQL8oCWii6gU0StNOW5kiSEH01UyxNckM
+9UN
=BbWt
-----END PGP SIGNATURE-----

--dg37qi5glisvi4nl--
