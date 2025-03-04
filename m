Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6732620EC
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108264; cv=none; b=RAKEzIIy9R3cYsoXHMnNReU5I1UB/fbxjAvCifEE/C6+JMrqfggVxW5j/0b+AD8WR0FMIWxuAXVsnKL/ir9no2AU7hOvdCoSaC/inowwf4bD+A55xJdVSPvdSYXSAPviGK4h5jRk6PUKqA883LQA/Y34Aqia4ZFS0T5LJlq7HKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108264; c=relaxed/simple;
	bh=BNIsmV/M1wFMJoJxKUmeED+xm/DpApiloOyzGvi1rhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAw3PmKBDldcGQqZsXM0hA3HVfLTohS9mslt7+0OnSgzuRTW+vFDMWX4HLSw7W+Ovqih33v3HHGdTKx1Y37p+K6OBYOYZCMfXiZd7Kc64fqYDOWvHO6HxbTk9PWaS4a+W1XT1fNamxh5ldyOCmj0HXbqtbGZCD5bIZ5sTuYpB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMKvqcil; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMKvqcil"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43996e95114so40407825e9.3
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741108259; x=1741713059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNIsmV/M1wFMJoJxKUmeED+xm/DpApiloOyzGvi1rhA=;
        b=VMKvqcilJiWN/SLu2HWRC79C4z1jJNs3KpF+X74a/+lxGVA5ClH8dTWLmHTdgzM/74
         ohjOn25aXY8DdqXo+gWgbKaFLeTlzR1r0xO6O9NUWca0LoqWMZP9fX8GBzrP3PDjjmOT
         MtMAM7pXYRgOpUcjoEBOnL1cfOLqFLcITMD8t2eBaYrm5AhbGSpw49facyYz1yacS+85
         Ekb/EuU7t0BS61ob2OHx6dIA5lFV02kE9684RU+5u0CxMHHXIoOJ99vuLN9jnpH0xa5/
         NQnbaA6LQTPbFzb+s1I4iFbk98THCg94xPnEGJ2FhmRns4sWCPmUU6B1dsjxYUW+foMq
         RZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108259; x=1741713059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNIsmV/M1wFMJoJxKUmeED+xm/DpApiloOyzGvi1rhA=;
        b=OhWdY1OoyA14cVE3OEHw7uQQ+gXQTVaOhPrcUCgKddkhSQUi44fzRTpDc1n5G/YNS9
         eyWFn6TIRoEkJ74F2HlvA+AVZhWoS1MNnGF1YvPE1ZxXjXnRVmQIyomZrUDffLjFakuG
         1cfN0i5pcVuzvtVzGyiS/dR4Z3oJOdf2VGW0W6Sg8dKynuFhFF04dD5X/lpjLRlSUDlJ
         iScAY+eeW388t4YiITHs7EQiOVCyMVk8ecMUDdGm/bDtfbk4rkfLDif9VqhFj9LRrfNX
         4JzZs0y833kEiIxgCXbkW8+uwbxQp+FZThVDKcUwTj2NqiPYv1U0qO6KrE7ba4SFmwhi
         rh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtQVphRhj0UVdrsctNdGFZbxLZ+ytdzVqT1EXUC5pAaqpoYcJgurfccrIm30mNovW8ql5K57g2zHE48Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwPEIMQGYBCP90fwfo2NAaIOABdTFFv1iUneqkpgpJpyBSdlt
	UaY297XRh3O6AVLqADpzriZ2J2DCqXAenP/Xr3S7VbGpsCr+bhLXjq/pXpwWRA8=
X-Gm-Gg: ASbGnct+vqLH70oQS+wXmyOOLh4eJ8IHx9KNYn4pPEx98IVkwTMBh1Tn2+GC3/XG5s4
	UWe6wrp4D4eNInpCy8aNCESdOz9o3t9RQicARouANiozLrGRB0u3opHtTobBNEQUrYqE/44QQuH
	4IpR1Jttr+1WHPM3FrzKZjfVyRMxa64/qRKGTbwcVFlYA6eUsH+qB+vipKeVMJQVWiMqywjUgU0
	4jV6Z5Jupgg40o8TKnX8QbT1Ako/9u3FKvOBnbMA6L2gqdTSYIsjg2umomJ6YTATEe0E1TlPOVE
	DETtuF9coWQPKhV2i831M+BAvqoBHsPGTYik+g==
X-Google-Smtp-Source: AGHT+IHwyTmNw7GkziQGU/grcke+J8YWNXy2qyeoEeNcQkNtnZMfPor87Z8qPAtdVAi/1sBgMwZwBQ==
X-Received: by 2002:a05:600c:4693:b0:439:8523:36cc with SMTP id 5b1f17b1804b1-43ba66e66d7mr174859195e9.11.1741108259007;
        Tue, 04 Mar 2025 09:10:59 -0800 (PST)
Received: from blackbook2 ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc8cb8c9sm25012195e9.35.2025.03.04.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:10:58 -0800 (PST)
Date: Tue, 4 Mar 2025 18:10:56 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7t5ylg5sh4ub3qc"
Content-Disposition: inline
In-Reply-To: <Z8cv2akQ_RY4uKQa@slm.duckdns.org>


--m7t5ylg5sh4ub3qc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:52:41AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Mar 04, 2025 at 11:19:00AM -0500, Waiman Long wrote:
> ...
> > I do have some concern with the use of pr_warn*() because some users may
> > attempt to use the panic_on_warn command line option.
>=20
> Yeah, let's print these as info.

The intention is _not_ to cause panic by any of this this.
Note the difference between WARN() and pr_warn() (only the former
panics).
Warn level has precedent in mm/memcontrol-v1.c already.

Michal

--m7t5ylg5sh4ub3qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8c0HgAKCRAt3Wney77B
SbexAQDwJlCeZoumG/jlue6Kzy4cUn1Ow4uQgOGmkE/7VYcugQEA0MuK4dJSSgbL
rcAd7YdHp7o0baFNH7DpxWvcmSi0Zgo=
=VnWp
-----END PGP SIGNATURE-----

--m7t5ylg5sh4ub3qc--
