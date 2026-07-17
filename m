Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6022ACEB
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299756; cv=none; b=Ib1jzK5I8j7acLOkcBtuVYOZ1sa2Hn4uis8Dx7bg9ZraavPPefjlA4o9wQWPS20gkovOzVGMi4ywTiSWafMuxdZDkgHBDa745YXfwRxzYVkF5nhypDhNEug7kgTfr5RznFO5UsDWXlkRNGZcYANMX/qjKvMMPUUioRgN5sLFOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299756; c=relaxed/simple;
	bh=n7KNhhouRJfPPKsSowjR4uhZpTB4DvWvjk1/uN1YmGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPs3s1mysUluEgtVJ2DeRca4yhfa33cBiEvqAdmdHBj6Go2wxDyeq1EdeucJps8LbQWJlMxwEDzyKQaTBGNnutMp1UoIVKhU9uqRel0M+siGaUQdURm1mm/B2AEhL906z9Prr2CMmwl5XnEIkesVhFyASR1BFdCTWw7EPXT0+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UXi5CGXv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UXi5CGXv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495437bb891so11731535e9.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784299753; x=1784904553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DQVZwUL5Yj/HZgLc5usvXd7dYSZnepBO0DvOQ94q45E=;
        b=UXi5CGXvBNbX4mxWmW/mq/8rQH7+cFHhYGTgLyWliXV0Kkj32wxB1TS++lx+Nil3kn
         QiFT6Ier1tQyrPMX0IpjjF8Y3tWbwW0uytm5HAXgoL/A1IJFmE0NzthSG6QCk81RKYwu
         Cu8pOByXCn7pmBWPNrDGE4DqMc2G8KOImPAgPks+ga/IzF3Bf7O1RFlt1JA6rixwFx8U
         Na2Y5GlrW5VRqn+YEdadZ+lzcSL1Az2wmiH6n+/qzvj2VxxfXQnhcSvx9wT/Sj7j6fmG
         Ol+GsojYPL0DeUxAv9EJCoXXvjh5ORsJr3d7XECVwWw7kzJvu9XDOo3pND4irqpKjNRt
         5JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299753; x=1784904553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DQVZwUL5Yj/HZgLc5usvXd7dYSZnepBO0DvOQ94q45E=;
        b=i0DfDJfJTCbrFZqJToGiICH8DM+j2DvBT1jZl9nYrPBYTeaf1W8cHIYATT9Otp1F2f
         HYlPLrjCViDQMkAgsNRlWEMbTOvVbJF26KBmPEPk9t8Y5BwHj2zJZPaFqsCDlEJokrpE
         /3bQJPB7V5un53zM6/h9RzW0FfpIyVBlS+bt7o9QMi6YsiXkwv4sXEc7s/eEMoxHJqLj
         NdpaG0ZK+d13lIv2nQlB96+JlfGjG+XQLeYaJ7WEZhabXv5fbY3sFI8MnSBkQRwlRpMC
         D7VJlWuC+6p4uTG0sAOevJkieOMYRbo8lyHw6mrFzMfJ1BipW3i2xCAii/Mw/SKRBN4v
         r7Sg==
X-Forwarded-Encrypted: i=1; AHgh+RpTrYKiQlFjy5INleJUKMtn40YareDPk8RgZl4M94R8nWpH+SHHFph4w1Da7gl6XfZnMk2XGAjRqeLybg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYeP2P1iaJhKARf1E5UD8EeobA0zWXZ2nYD2x6qJi3EXZxKlz
	ztnHjKjYbklsJs1GqnpP/+qONP7JbN0EfE6iL+QH2qS5xNnq3Wh47hv4wicA/KkHfBKnQ9z+G/C
	oyb70IfD4pQ==
X-Gm-Gg: AfdE7cniCGwvmnMTBTdIauGASaqMdFcLtW4yaZXwwVBXQgu++xh7aEuwLcnkm1RCMQI
	Ypy8lp2WfqMlt4jKsnYGQLUW16qnNTAdDCDkqrQPWEuKE1wcprJq8Un2/hiF5g4gYotU6iKByKj
	OisBYTfnit4fwvGaRZ3y5wJRWwgt7JsgJ2T/6/Pt8MFSuqBcQvfaq5tt07p94IwBgr1UECMJyXe
	H4obaqm4wQDxiYUnifOmS+y4UHRPPTwj1dYNgIYGa3pEYLEH4uqZZDNEixtT+1xXbZp6KIb+Ni0
	seqPbdquMZnSHrd0Wjm5z238MGaKQ7r+HuUcn8eagGeTF/0tGhwaL/oTZ2idP8Qon+QlPmepV1w
	ZcJ/Lt9akWE6ZRygHiEqYesSASFGyqVktie6rAUbpk3ktE69Qc8Aj8n6a5QocEDHYTcoAOxQOoQ
	t1Zfef+g==
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr30304385e9.5.1784299753303;
        Fri, 17 Jul 2026 07:49:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a3f07esm54400465e9.6.2026.07.17.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:49:12 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:49:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/cgroup-v2: fix delay_nsec unit
 in io.latency doc
Message-ID: <alpA0tsH2cm4029Z@localhost.localdomain>
References: <20260717060225.2019764-1-cui.tao@linux.dev>
 <20260717060225.2019764-3-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pye5sop4w5d2exnu"
Content-Disposition: inline
In-Reply-To: <20260717060225.2019764-3-cui.tao@linux.dev>


--pye5sop4w5d2exnu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/cgroup-v2: fix delay_nsec unit
 in io.latency doc
MIME-Version: 1.0

On Fri, Jul 17, 2026 at 02:02:25PM +0800, Tao Cui <cui.tao@linux.dev> wrote:
> From: Tao Cui <cuitao@kylinos.cn>
>=20
> The io.latency doc says the io.stat delay field counts microseconds.  The
> field is delay_nsec and is reported in nanoseconds.  Refer to it by its
> real name and correct the unit.
>=20
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--pye5sop4w5d2exnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCalpA4xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AixjAEA9/n0vXB3k2HvRBb083Jj
tjUEjDc1NkoJGkZKUybqmTYBAPfbVswDStpRGY75PBl6pVDE9MVPM2cN0AaEGMWW
+9IE
=K1f0
-----END PGP SIGNATURE-----

--pye5sop4w5d2exnu--
