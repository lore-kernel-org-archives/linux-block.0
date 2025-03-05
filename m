Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFF2066CF
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169848; cv=none; b=Ci0EBJZPM+zQK2zPxf5SUVgD2PqmlTMD+T/O+vMahgiTJuyu3fMsSWvYtxjq2ppJIe6ez9AjB7p3XpcaxozIbKUUcthc9bTbOPDtwDfvqskEgQzYXX8kVssuJ3DU5s7dRXFgQqaPk9UTPpMfQUEKUxxwtvJpNLyZ3MjvXKRazek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169848; c=relaxed/simple;
	bh=9VFnpLzeqiLEQnzyxmwLAEeQdzPt+zBgO7BAKw0gcDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EITOw9xdicx5lZlKyj3mJVTorgmWSqGosyAWzAMNqJW7TRNC8XriqStQAgM/lxvrGwTlZvhfTrV7L2lZnzKxEn9NcgkSWGJBpl6Vm9OJOXQeRHJhXZxuRL4Fky3Uiph/by5O/DreOIjI260P3NluU8pPAXo6Y247vdRr3669ayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dvu6ByZl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dvu6ByZl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so3254425e9.3
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741169844; x=1741774644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VFnpLzeqiLEQnzyxmwLAEeQdzPt+zBgO7BAKw0gcDw=;
        b=dvu6ByZlNsq3YJAF3nkethVOu1W07Yic9t4IqZ7F4J+Y8ig4MFYN9GPA/ZZe+SxdNr
         NLbEKSF5g2pOhPAtcNYat1jwOtsXkdfTe0wF0/c6JSpeKH0WuLpsd4kRIYABWqu5P5iP
         J640KjGwh8jY2MKNAkERRQ4c7kQ8T3665diZ7Tv36vJtVzRsfozS+4e9g8X6lqXIJcxS
         EkZSZrNSAEsz3ktnhcTisT/yllZplI0HaBTS/HguTLdqFWL2obza1+R6Nk9TQJGumZJA
         xfyrE/kmiUQtbGvDkeDL8cC1OG1auWMszs9lTdqe59cJ2dAjXpCkC0ehQvU/0CBNdqQQ
         HDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169844; x=1741774644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VFnpLzeqiLEQnzyxmwLAEeQdzPt+zBgO7BAKw0gcDw=;
        b=ZbUleBmwmYw0WguvYQ2LOnB4UbPmfRSIc2NQaxKY8TzoSylfIlIGVUuZW6qxoI2fTc
         HW1zykMoSVsQ5pByQ4/zkKCMQvxcYQSbHBAuDxbByXm3CHl87KzUN+qrlqPdmVJsCin/
         wHLt/VOoHFQei04W2NjwoqLoMvUlKwQaY1SRWcLYv5ubXngYcEf680rT1TwCLTiQr/DA
         RjAhBt1BJuDJ6NodLb9ckp54ANUFG9BADszKlEQlTirzDjPt+U9zFYQufhGWWSmKShbp
         V9wrK4+HP2HHpboW0XewYFM0faft/uQaAdu1haFVjnf+dya4kNj7y8vV4m21nKZ1jwK4
         wRJw==
X-Forwarded-Encrypted: i=1; AJvYcCUV74D3XvzyBQROCTbGXXLdOPAMlSRmPwpgHBm/JY8MMW2DUPFyvyAtjGXhLKcgk30/tG/HVztGv7x9AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxklrDkOJ1lsdTaFegPVWDuoHvwdJ5K4np1C9XJiplfrCQ6OCOe
	E8s1HAQodmiXLoujSMzLv9aXkpZsXWzIjXPYeWCt3hAxoLdhX+UbMkYaNQsrbsg=
X-Gm-Gg: ASbGncuGdURTEmx897/vrDKXi1qJ7/YLjXunmF9hnVvbF4nEN1ZCc54ddUHo1ufLnYB
	DUDE3Cgr/uGkHfCN492HRnWL1v+ZIjr4bUIKCbfpaKHZTAf6MhS836EYXVUO5CZAxDaEWHI3hYz
	tIOG7t8Mm1F3L56RZlUKmV+sbl1UpFDvgMGqKScRpCXnW750twrPn7IP4fSqjDdi2d2Pq6WHeFi
	aKCb3yrlyAaQOZG/7HTFBPTWPXrt4e+hdbyiIPuAcDT2dPFUAoiqkpWr5AAADRv1mZ7AezldmJr
	OGe0Q/6DGQgSz8qA5xEN8Wlhve7TgBuvjpZ2oaUdezX/q0c=
X-Google-Smtp-Source: AGHT+IELkfto1B3InHIV9XHTEiZ3UPQqTL8SpSgi8S+aMDMwNuHKEJeXQooPvFBqukLw7JdjT+ZyXA==
X-Received: by 2002:a05:6000:1a8a:b0:391:13d6:c9e5 with SMTP id ffacd0b85a97d-3911f7403e8mr2072408f8f.19.1741169844335;
        Wed, 05 Mar 2025 02:17:24 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm20945766f8f.58.2025.03.05.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:17:23 -0800 (PST)
Date: Wed, 5 Mar 2025 11:17:22 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
Message-ID: <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-5-mkoutny@suse.com>
 <Z8cwZluJooqbO7uZ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ofgmq3xmxytwmxs"
Content-Disposition: inline
In-Reply-To: <Z8cwZluJooqbO7uZ@slm.duckdns.org>


--6ofgmq3xmxytwmxs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:55:02AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I'm hoping that we could deprecate /proc/cgroups entirely. Maybe we can just
> warn whenever the file is accessed?

I added the guard with legacy systems (i.e. make this backportable) in
mind which start with no cgroupfs mounted at all and until they decide
to continue either v1 or v2 way, looking at /proc/cgroups is fine.
It should warn users that look at /proc/cgroups in cases when it bears
no valid information.

Michal

--6ofgmq3xmxytwmxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8gksAAKCRAt3Wney77B
SZviAQDogAzaKM/NodQpleghspQ8p1cKGWmOtSjRgWhYW60iIQD9EI4pdnCLmyC6
WOgtU2xvERdR1ff2o77F39wQh+Dh7QM=
=z6i3
-----END PGP SIGNATURE-----

--6ofgmq3xmxytwmxs--
