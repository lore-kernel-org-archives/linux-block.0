Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB153358D0D
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469954; cv=none; b=UrdaeZmt+YevRdHabBFppwO8bk3eJLSXVRLXBCclhK2Ks0CZes7pye01fur0AEhoJH8v+DzZrUcMh2K1sQD5gvfxgS/ig5UCF8C6ed+aClUyn8n4IRsNIURXQHr0ezN7jait6NvzM7Fp/bDHsYC+nOva4Q9bYvjzR1L8G0Oi3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469954; c=relaxed/simple;
	bh=IpKdm4vm1xXiTCAlkhSwSqOJm8VYAroIug3XCsnyJgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLrZwW28K0R+RmQ0xh8UPCq9AQuGp3zs3fa5sy6REC3/n5mmB4JMdM8bFkF219CvGYtn+mMqIDd4A89+crLvPdfzfKzS7ErWSyoOvGtnETxhiT1o1YCbEvXeDJdqqU6Y7HHPx9DKuGAcF+EfzXHUHnwnliJ/tshWzULzAkQjK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dbsaX3Tv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dbsaX3Tv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso3461315e9.2
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768469951; x=1769074751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpKdm4vm1xXiTCAlkhSwSqOJm8VYAroIug3XCsnyJgo=;
        b=dbsaX3TvS3zLj/8HBTXY1PQPRgAwkuIm1De8IuyGdZDraFiJdbh0nox8oK3YZQUH7J
         ZhyNaxvbkxM+Jdk4/Difgtj5y48E3UXY1It57q8LT+Ms1WQxxLbKzevXduR2BiTbE0lf
         jgwsX/WE4lRxoDe1VjRolIIKL7rRE5EcotMw35qYTSElvTEO7HitpfBJHsJNYqmhVJnD
         1RVtunosc6TKz83erKNmHj9tuzB8p4UkLkDiuwxexIHuqJTLW8Y79jslTNXatAE4XD9f
         i2Yp2lszMWhF7Hcpi0Rik3u4twVnBzGUplW5Q+rEkrM3cFaFEHGCWozmKoS0ZOEIuNlo
         7N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469951; x=1769074751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpKdm4vm1xXiTCAlkhSwSqOJm8VYAroIug3XCsnyJgo=;
        b=FfgKxIqmiG0+diwrBmOKXzNlMeJ7oh+K8coLxidBN3sOw/L9L9rlUYNIu5LYPUtNbN
         rno+crlEg3tCjm0/3R3wn5JVghX/djwJHGzq+CgeLO+VHux3+EyJHstZnB76LE1WxTTv
         VJKuwbcLk6VdjrvIERxu7fReVh6oyMOKw7mx1mTlaRSgDxnQD49pIAIJjg4puw7C2XD2
         g5mXfhF1pcWKzkAH0cRJ8YUI9NjCLiE4svzHjJNiRoJjf0mVo2/asbBp8lmTmi06K564
         Radi9Zkb2yuXj9KZViIsnw/1f9jJWStK3ROgHBedwKamdqgNiMF3BSQpH/YpWJL0xl7O
         olCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1QRzP9evYrtRZUbfA7puf6uTUcipimCJKHFJcEeHie0eVOsLPIoEOC7IJdCLRXHbFnHgweAs/6zBsDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/S5tLAUBVsuRgPssJCbduImzicHIAwkZokXmaTK88loE33oO
	BUI6l+E/MaA+Bkjvd4OdBdeh4oEuFxiJbNSf+mARHfHPtYafIXq9sKsHvn8+uoU3V+E=
X-Gm-Gg: AY/fxX4FO7+qR3JcsgM0AjLmjo64PWcRrbouEgOqSMboJVaFDgjGSEec+GMoUUZZmch
	8loTcppj6ZX8dvBrqs+qHjosEEUkQIyx72WLNmA3gPEx5ab815HNzPtQ9/L5RmRk1qK858pEU5L
	gWVltOWsMC1oWcd9soVsvn9oE1SZtRWxwVi06eObafhDma3MDL/3nHpxo7AVwS3Ejcuf4RW96E0
	T6QDZwpsWhusPNFCQHyWQbWAcoMjEEuRl7iaLiUcnjrKEwxanNMRpcTkpMyH8BMZMtB1xOnpV9T
	OunAf3sSKTeveHsT2bR5UlHw5YR26glxAP99M1P1D/3EUMg+qZKXyxLluWPdJu9ltxFX/QUHcpu
	Q3RRLXIGqB5TMTISxq1C7SivdR14S3GZNDZeQIgYEKToR7WQpDmlsrkW1HO2/1XFv6HxHg6FZLI
	HP9zzlObtC+Y80AzzbOSOSOPeD+pYdftQ=
X-Received: by 2002:a05:600c:4750:b0:480:1c75:407c with SMTP id 5b1f17b1804b1-4801c754220mr4477325e9.2.1768469951289;
        Thu, 15 Jan 2026 01:39:11 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm37266595e9.5.2026.01.15.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 01:39:10 -0800 (PST)
Date: Thu, 15 Jan 2026 10:39:09 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: Yu Kuai <yukuai@fnnas.com>, tj@kernel.org, josef@toxicpanda.com, 
	axboe@kernel.dk, hch@infradead.org, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation
 and blkg destruction
Message-ID: <xjwdgvoc6fw65yvtuyz7ku6dtjqzpf2ipty7ei5qcrfo7brxee@slit46ljmaoz>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-2-zhengqixing@huaweicloud.com>
 <le5sjny634ffj6piswnkhkh33eq5cbclgysedyjl2bcuijiutf@f3j6ozw7zuuc>
 <edf84e44-d7e3-4a34-ad49-90ab5a4f545e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l27swnkbzqhelwte"
Content-Disposition: inline
In-Reply-To: <edf84e44-d7e3-4a34-ad49-90ab5a4f545e@huaweicloud.com>


--l27swnkbzqhelwte
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation
 and blkg destruction
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 11:27:47AM +0800, Zheng Qixing <zhengqixing@huaweicloud.com> wrote:
> Yes, this issue was discovered by injecting memory allocation failure at
> ->pd_alloc_fn(..., GFP_KERNEL) in blkcg_activate_policy().

Fair enough.

> Commit f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from
> blkg_free_workfn() and blkcg_deactivate_policy()") delays
> list_del_init(&blkg->q_node) until after pd_free_fn() in blkg_free_workfn().

IIUC, the point was to delay it from blkg_destroy until blkg_free_workfn
but then inside blkg_free_workfn it may have gone too far where it calls
pd_free_fn's before actual list removal.

(I'm Cc'ing the correct Kuai's address now.)
IOW, I'm wondering whether mere swap of these two actions (pd_free_fn
and list removal) wouldn't be a sufficient fix for the discovered issue
(instead of expanding lock coverage).

Thanks,
Michal

--l27swnkbzqhelwte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWi1uxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjBoQD+P0vwCMjZtjVGS9olloNJ
W00FAlkbpKQbdfBF2UpOw6gA/3cd7/jS+Q2klkyaKhjtBWnmlIXM9qQIMhNR6dfO
P9EA
=EJwI
-----END PGP SIGNATURE-----

--l27swnkbzqhelwte--
