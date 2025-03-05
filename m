Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD112063D7
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169547; cv=none; b=fJ9egRrvs0IiTMfrSxj/CRR7yTsxrcZ9Wb51OIJ+5NzYeBU31sEVolWDj118oi9BEvBAYu1NqMUbOEx0TwUDI+6jNRUlZLlBj3lH+zRMX1+S7QeRUZvjpig+i0ubXRyGEsqEP2uhwSyitoZh84CK8y5k/Xj3is9pvFGaHpk9Hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169547; c=relaxed/simple;
	bh=4rA5mEK+MS4fNeVddqD3H/IjHGdBG/CHMImylytnnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6T0dm7o5rtYrw9iZuw7vM083jTD3Hoot+7dP7n0NMnBzuIFm8zARZzNE4gQG7Bui56KjiGYTDQd67PcBNbiXNUPdhS9BFaAWg4xptc/liAJiUqyj2IVvqjxEKd8+tz53Lb/xiFRWi5aTJXnTZPPpQHNzOaKX9ZQA08jmL0nodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=evPzm6hF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="evPzm6hF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390df942558so5139542f8f.2
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 02:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741169544; x=1741774344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JK8Y7F0M6yt4sxuseFTO5fZ7Aq9PRgVqCQhiIQOhMVg=;
        b=evPzm6hFp26Ik6t8XzJnpUCaz36cJSmmj9/vyllQTOqdID3VQ5DDSD63NCrNmNVLdQ
         ZNeH89PeUDjqYZRVxyGVCLpze9yMYENulKYXDeguvaqz3zUM4QLG99R205vwNIERsWcu
         BL5nNQ/ddFQwSUrtMuO3ow4ENIJajOwfOqmJb8TG/PKHVA4KjJLIBu2ZIf8eweLniTEz
         72JDBFFcODRwTahSod3o9lEav0g9DK5wPZB8mP82HSbhA3D3xEcCOFBdbHBi8JZQq+28
         4GnpKhF/lb/VJgEp4zXkRP2LU0/LZ2D8cOdcv5ilTTtkuP65AXL90bQ7w1LqfrEsQpSF
         OHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169544; x=1741774344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK8Y7F0M6yt4sxuseFTO5fZ7Aq9PRgVqCQhiIQOhMVg=;
        b=aAlDaw1pQD8nIG/oketiXkkONfcTVtQIpE/oEjiIPYJOjUrM/m2hd0vFxwC4F33oeQ
         zeVehW4GAsxD+uhf2VDWPZW2Vf3igKogB2gDTS+AFG06k458CGwS39n6EyUT/PBkU2jY
         +BHwgZTdFjhXXrVm4WO6BOz6R8gSs3R42130ZadGfPeCtITrRFyKmpHuaZa2M78C/Nto
         n/arAdnA/S+2eE7PAkOuGkE8/II9EHlSXoK49cmxeMjse5d4tqlu5On//2HkTXL6mrOY
         KmStXKWW76nuEtJIrNo6gx4lo9g+1HKmcUzrohdblyTp7HTiJikDuCQj1NIVwYmRS0IV
         nEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRBL1JzlV0m/bLXwlwrv4AVlTqmdIuug0tq/9eRVEhp6UTJs9a903twNH+WPhfQkJhKw2RPaKDDz2XIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFC0ckM5sGBA5ZapF1NeyhwdhaV4i7SzSPlUZqJiNt35pzA7AQ
	GphwPLItZqQyT2Z41ukz1nOtVIUvZNU0dtstCsrGCekf2zG8Y7sXHREOm2ii+PU=
X-Gm-Gg: ASbGncuVRNxaEjjzhdv83WfzgAYvCgF88BZDkbCEWFRR7ZpLGj0SwHRQ4gSSPQZyZkL
	2EaI5Y0+vDOZZjzIMIYUjT9AYqbskQaqHFgxOWqVXjk+IViubIlNRROJIAs4w6HOS7FUr0NsPeE
	BgNxDl/dYgLYaIDpcNot22/7P5QdupBhJM36l94158JZbC8jGECHN63r1r89DBbngJUBeLAPGxo
	7yoT/250W2bJIOr3XKxTZs/fO1FOqVquDQdy0ld5Z1XumdlroNFO6xQtYJjRWMFOyMf3d2W2OMI
	SnXDQmq7cJPsKazoCnek1XSO9p4Vh229QCJNKdeez4hCk+Y=
X-Google-Smtp-Source: AGHT+IEmna6voY68vbZUHryvS51Xec95FeWivkSUZHU6RdAxXB35kR9fsC6gZZj1O0MDgQ1mVFz4Pw==
X-Received: by 2002:a5d:64cf:0:b0:390:f552:d295 with SMTP id ffacd0b85a97d-3911f7c9ca7mr2048791f8f.53.1741169543647;
        Wed, 05 Mar 2025 02:12:23 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d8e4sm20168761f8f.85.2025.03.05.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:12:23 -0800 (PST)
Date: Wed, 5 Mar 2025 11:12:21 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <5bw7yc6bacojk2i2ikhlmf2skfiix6t3ipchbnvyfttmyh644j@iyquxeuyapd7>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
 <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
 <123839ed-f607-4374-800a-4411e87ef845@redhat.com>
 <Z8dAlvRnE28WyOGP@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kodlwgikrlg6std3"
Content-Disposition: inline
In-Reply-To: <Z8dAlvRnE28WyOGP@slm.duckdns.org>


--kodlwgikrlg6std3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 08:04:06AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I'm apprehensive about adding warning messages which may be triggered
> consistently without anything end users can do about them.

That means you'd distinguish RE (replacement exists) vs DN (dropped as
non-ideal) categories?


> I think that deprecation messages, unless such deprecation is
> immediate and would have direct consequences on how the system can be
> used, should be informational.

I could subscribe to that if there weren't so many other places to
evaluate:
  $ git grep -i "pr_warn.*deprec" torvalds/master --  | wc -l
  62
  $ git grep -i "pr_info.*deprec" torvalds/master --  | wc -l
  2

So is the disctinction worth the hassle?

Michal

--kodlwgikrlg6std3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8gjggAKCRAt3Wney77B
SRmCAPoCVnQ3mtHJRXQJXO38NpVCV2CLDqm4CBIDteO2hv5JfwEAx9LG33EQ1YVO
M4iXA2i0xMEByWsgAdo2c7ZXsyvvWQs=
=4wDE
-----END PGP SIGNATURE-----

--kodlwgikrlg6std3--
