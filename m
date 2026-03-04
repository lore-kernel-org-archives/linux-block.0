Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4236AB4A
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630890; cv=none; b=Re/KbPQLcorkROZ+vUS6LXDn9VHa4BvNoP2GYDwPAZ0iBe02Xjkt3WH1Tq1662lFAaxrv3seTlIGmP56eWvm1eUWEQUeioZHawHFdXsBSu02A9HSgUJlDXDwgNqUHEmxMAxAJSAVIcYhZWBekHT+efBFzP5bSK3Q8CQZ37D3TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630890; c=relaxed/simple;
	bh=aMv6Q7rF8rylp8U3RhhMMnUS3IIsKzvQISUOfqqw+6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUwN+YerjJBcrVEvlYSBIUD2jfn6ng2KacwBWgSMtUm5wdZs/W5qgsC2pobUqqtZOwhL2MGmcveNp6kS2WKppSt05IhvUBXmPqFC52FJfUECFZm8fxjiENZaH8Y+rXCZ4gJAptf3PlsrzqX3XUMdcoLdP3hap5udFX4gFzeRG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CVp1Ume7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CVp1Ume7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so78178795e9.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772630886; x=1773235686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Bi/L/oEGmHblpGPXlfivThzSUKKZWyOv3lvM0x15gg=;
        b=CVp1Ume7LYZjC4dmWgiGQS8LgRNlH2Mk05vggUZuJnsHDpibCK0rVr1+ixVsjJ5wrz
         rIDNBDRFAq0hUgO0du9BjDefpqg9yE2FHEQ+svTDO7cJwuxBn90mmuIom8y9Msr/kCXY
         /okYGnnJVV3oV38/6vihqKC6Rp4o0bwW2zDfIM2ANv+LmN8fTwbcKvBhHXde6FjQGlbS
         +/oYksObO54CBCgOQIvtdE0egq8RzSNsRz33IFKro/3KKNdd8X02/xAr/FNzV/kpKt3i
         MYYUrf+dZOA+5FxByDAtr0zORdmBUMFC2ktDjCEorzDLiClY9jReRPSE8PFcBnQM9EYg
         myMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772630886; x=1773235686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi/L/oEGmHblpGPXlfivThzSUKKZWyOv3lvM0x15gg=;
        b=utnYr+8e5DbNLhhVpBPlE5GTgRJcr816cDW15cTxhh6EIf/m272OkW8QemdrPsvQK1
         LBNZWUsPj38dSO/ead3pTjUo3C2uMALEZdxGcAIJxEBsj740cP2loiNpk0l5GJe+7ViD
         WFBU2PuvG15ltMcUODg+8MdLsew1sTrNmk4erG6Trp27TSljNQHijbU5TGu7fxLVsoZG
         YSAZpHEt/bvN8bobtyR1kYfdlzx3kuHtVOPH4nCEXXpzmiINB6OrkIYFYuZaTtNskb3M
         O93K+y7P8M7C7Bh6QW/Ds/P0Q3HHeWSBU1mHVZML2vVfIZxpJnsTm/JItW1Xu9Dt/tM+
         YcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhq/042T27KIMKCJvu0uEsReFzS+6kb5Jkaat0D3lDIu95h4jxpiB/pQixHjRAs/zrlO1qvAFChnoM/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHYuLeM9U6hAsGMeLUS1ejFvlUJ4Izt8G7Qz5q7fAW6BJRgqw
	CXalIgvmd1fv3GICnfujBi+2OyDUQxGcMXNdEupI9fvtjhJTtFqgqtfUFeYagHT7j8Y=
X-Gm-Gg: ATEYQzxRJSbMOZTVAVVy4+PNi6uyp80VkmsPqXyhu2OhL0cM63sfP2TPd1Z7Aw2dQOG
	bTUSAy87nTE4w1Q1WwOVH98XJl87p/TIEcTHTmRanjgdWA+KEM0JHtRFpUADdz39pjqvk7QGyW+
	DZs9GeRNG/23+uKV/caHYc9PuAp3z5lY0XJiEko60gFR6EvUpQNQPt/LWdfwbInE05AvpyE6HqA
	bzj4Cm5q8avYHWmSK26LtlVO4RTt6GjatHxlW+w0/A7t1tw0NghFa0OLivc24gndmn+cKSVkwO3
	NbBgFw/sQ8EDg/35U3nuHvw+bNiBYXmmbKbnlVEHLDaFjGq9bDRXw6BZhwXczxrDdW72qX3sDy2
	DOtF+bw02ZLCAMTvuzuMb6fs21YeEDVtwHbmXxn4KO7Rc0xq4jDO1y9i1kk6IMugv/S2Sp6kTRu
	M/VJC92qQl/xHvQitZcXiTw/XChQiyBBFfaqAY08byrhI=
X-Received: by 2002:a05:600c:19cb:b0:483:361b:deff with SMTP id 5b1f17b1804b1-4851986395cmr34923645e9.14.1772630886363;
        Wed, 04 Mar 2026 05:28:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884a7absm61338975e9.8.2026.03.04.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:28:05 -0800 (PST)
Date: Wed, 4 Mar 2026 14:28:03 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <poawwl44nvy4ru4mmjqi3kxfq7xqcpdeq6ghixphcrwhpv3bnz@xsltjt52rbqm>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxh74vomtnyu4pvg"
Content-Disposition: inline
In-Reply-To: <aacehv3rpO9irhEG@slm.duckdns.org>


--nxh74vomtnyu4pvg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
MIME-Version: 1.0

On Tue, Mar 03, 2026 at 07:46:46AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > has not been modularized since commit 32e380aedc3de ("blkcg: make
> > CONFIG_BLK_CGROUP bool"), making the module parameter a historical
> > artifact. Readers of the nested-keys format should be able to handle
> > additional fields.
>=20
> I'm not sure what the above para means. Module param works just fine for
> built-in modules on both boot command line and through sysfs.

Yeah, it works but BLK_CGROUP is not a module/built-in it's config
option affecting builds. I find the module_param() in blk-cgroup.c to be
a residual, I admit it's convenient way how to expose a tunable to
userspace.

(Contemporary way of implementing the option could also be a cgroupfs
mount option/feature or maybe sysctl for which tooling is available.)

Thus I was mainly motivated by bundling this change with cleanup of the
module_param().
I may have misjudged importance/usefulness of the data (not using them
myself).

On Wed, Mar 04, 2026 at 01:56:43AM -0800, Breno Leitao <leitao@debian.org> =
wrote:
> My goal is to ship a kernel that exposes these detailed io stats by   =20
> default, without requiring any runtime configuration. The stats should=20
> simply be available out of the box.

Does it mean the information is useful to you since early boot and
adjusting the param with a userspace tool in boot sequence is too late?

Michal

--nxh74vomtnyu4pvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaagzXxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjOjAEAhTokV74oTWGcohq05aqm
lfH2g5jgBuFtolA560P/M7QA/j8Q1OrUyty8NX9aYpaRVG4ly9bp4yIu6YqWFHTc
d5kO
=YCCN
-----END PGP SIGNATURE-----

--nxh74vomtnyu4pvg--
