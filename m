Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750720F078
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313118; cv=none; b=Lb5bpe4jlg/80qZ16AJ8qxB2HGLYPapVCjA97Cm+TpsQ6PP4tGmJS2pPBV0EqoWZSRHgy+oXlJzQfcJ3kEBfPb6kviw5sUKTWgAQVqdIUWE92Ap2mL8oTcMWMnJJo1q1Rrkk5gbQ/WHkDFDqh7o/ZTEKm2SfnLB62Fh8aLzU9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313118; c=relaxed/simple;
	bh=DGxt/C9Irx935A9Pm++nZrOSxRQnuPRkq/va9N8kXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH2P4gSOypw94Ytxr9UbQLFVPkv0wfXGD+KlELASJGgJq0hQM6PPprCqQTTopFGZVU5NWq2DUk8RQU2N11BZpD/0ct/d+X3JdIbN7ayhmIb5A24zNa+mqwLLvDJ4GPZfGl30nnpnKGubpsiwEdPiQj1srCJ5yKsQ7AgLkYrrPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Et/URCv9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Et/URCv9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso24819415e9.3
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742313114; x=1742917914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LC+nF3SpDbrztDI/MPmvjDr2ML72AXfztVInSF11ZLQ=;
        b=Et/URCv9VUqhbbCuh2OiA40TUlZTJKIo4NrqYpYx4anoeTsHY693SRXZrI+o0+4Aru
         0730BET89aTdA0xl/EQaqbOvGYDIGvQQ7Bi7ukSpTdvXpedOokPNitrbfsLT7uVCFa3n
         FV5GUuywMYOqMHK8kKxQU0Deti3eYEBktIcRRt3ThEaOm33VqoFlr1O0klqggcYqNwJk
         OcVVUoMgGOF2p3qMHxX7pHccKlUhyqWjiun5mV3DPnbo6UxYeOjph8BD7F/kB3mejYxi
         gotEDBILVR95etF0e6Biwar+7wcpe9dsSZCzoY4RtOz276QoMAAheIT8xZZ9TnYimZ1U
         CmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313114; x=1742917914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC+nF3SpDbrztDI/MPmvjDr2ML72AXfztVInSF11ZLQ=;
        b=ISiw4PWHBM9Ut46jvY+pKj2mGPfshIpuq6ifcNjh5hxZmxTE0kIXj2VXPwFhTp0Muc
         Lcy8gJSJ4CuD5j0jURg7zie7aef+whAJJ9QUzDiH/ir1H7d3101TeTEOCUhOeaBO5jxM
         Y/niTSCK3/EInDqZw0fRAW1x7l8pnY+vqdzHRSBCIoeRIuxae38Lg6mPrVCvmZOD38nm
         zY7tj7J/AN3YR8HD5MqA1AQ2yiYYahcCUByxuU+Qx3UTE4EVyBq3D5RtQgRusCKrEgSR
         zOHX6aAzKeOysaXsw5x81Iy0exRVE7m63U0bx+RyvFg7UQdkW8LtUCIDfERjD2Hgd73F
         kApQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf2WBHe4NuwjqRE6JXxI6KeTiSlXHyM+q0vg4MLZCfDoHk7KwnweQu+ShJn8k5jdQbXCzKaVltAVYzIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylVhvVqTD1v/2ja0Zi87gKxl1celMR3+a8wlSltuVVTVU+dnWA
	EtWtv+fDcURBIyA/+vTBGhlFi6pcnrKLca673sRAgGU4mOx/6weWsrzshEQNHBU=
X-Gm-Gg: ASbGnctCQTOFlI6kGhBuzLWvqD7x0BreF1m7dPkfRDcAAO7dlEA1n2wV+GNtKnQMzKq
	QFzYr+Dm5Q+I+tES4z+C8vwlm/0b+rBVmw8X0j/LyJNiAU63OWHaHrAUXeX7gupxPPJ1oNIYxTU
	r/pkRlf/Zb4ap1XhqHkDmPRM2zeIp5/Z6lbb90mY2vrPYAdua4oQbfSHK27en1/E2CxMmo8pEi1
	YcYdblo7ChTiGaT6o667L5eOwZ78ec1x7B8r3fpJ2IhRZ8wzcp5exh/oQTQ2y9RyVuK6fvaIaX8
	ZWpOVLMCRjmOSftduNCvDZgQcY3kZcqcvWaxZwqzKjbEG9M=
X-Google-Smtp-Source: AGHT+IGue5dNi02epZqdFwISRO2DqY6eSFTBAINSLQ09pyo7v2ItFYvRcQhhbHm998Hg1ISsTrUK4Q==
X-Received: by 2002:a05:600c:1da4:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-43d3b950035mr32588205e9.5.1742313114536;
        Tue, 18 Mar 2025 08:51:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda2dbsm138960905e9.2.2025.03.18.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:51:54 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:51:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration error
 handling
Message-ID: <sb7dgl6e22jsskvtiqvfny64pdxfxuyijcj2zxc46s27kwecfw@xqyutig7nlem>
References: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezfht26i7an4lh3x"
Content-Disposition: inline
In-Reply-To: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>


--ezfht26i7an4lh3x
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration error
 handling
MIME-Version: 1.0

On Mon, Mar 17, 2025 at 10:29:24AM +0800, Chen Linxuan <chenlinxuan@unionte=
ch.com> wrote:
> This patch improve the returned error code of blkcg_policy_register().
>=20
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>    function pairs to the start of blkcg_policy_register(). This ensures
>    we immediately return -EINVAL if the function pairs are not correctly
>    provided, rather than returning -ENOSPC after locking and unlocking
>    mutexes unnecessarily.
>=20
>    Those locks should not contention any problems, as error of policy
>    registration is a super cold path.
>=20
> 2. Return -ENOMEM when cpd_alloc_fn() failed.
>=20
> Co-authored-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  block/blk-cgroup.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--ezfht26i7an4lh3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9mWlgAKCRAt3Wney77B
SVbeAP0R3rvFXNGUuUa13r5copvUVvPw7HFAvwgRKTH+2St7xwEAnNOyY8KO5Bq3
vaXcX0HdBl1zK/D6EeT9tE9kZc1RHQ8=
=Rk6K
-----END PGP SIGNATURE-----

--ezfht26i7an4lh3x--
