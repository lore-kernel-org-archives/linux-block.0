Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC97260580
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998164; cv=none; b=lnTRuQgaAmuw17SGfar2ijLvA3if+aGNM4DLTA5OsDnPrPJ6efdY6suueTwvkjDjyr4FR111MPku/G6+pwdac7S5L4PyhwQNe4WimC/JBTNTC5/4nCsUBAYXYm6jbtuDo/PQjoKTthjHndw0UevuYavlYPSDGNyQhTbC1dFnbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998164; c=relaxed/simple;
	bh=ioRMY7E5RbGxkWFGQhuvd5E46wuroq12yFc8qIrYi2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9FvdqTJw9m4u9zGMu6+wdr9XHdzveaGrAuUvY4RU4CH768nM/PX/xrbMJ4zSXAftK7Ze+AVpwBdSVl4vUt3ouuhapL1x5O3XUAMw/zUDpUldIEGXEL4VGTr+1ONX37iCf0aSOyJR75RNtqmfpPR9OU8TBTT3kVoNmORAGvM0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hdpj+mq7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hdpj+mq7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so11494559a12.2
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765998161; x=1766602961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioRMY7E5RbGxkWFGQhuvd5E46wuroq12yFc8qIrYi2g=;
        b=Hdpj+mq7s78K5KGIl//aCOfdRhU3PmRC0y29CG1XdylPIio6Fl/dkTTYusYSKSNRcd
         t3snz+dbj0+aJxVcx45+7+VNgqeyp83HunYc8Bi9JduFDs6L8aAOa9oQ2Ymoada1GV5e
         H95xJmLdWedra7mqUIWiHeX8rlF30qRwhaKtuyqK9k1S6Zm1iOgVLKoZbN4KrGzlG6EC
         xh2Z3cs2avO/32fOMllIwip4tP0AeBdRSGvv7oqskSgHZrMROK0Hsyzu7wbofZ2EKxQ8
         35K2esWbUyRhGO/u5X7VWRvusFOElA+Pmf+pnn5LNg5bE2E7h7CEBHnnbGofPukxw0Wp
         HefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765998161; x=1766602961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioRMY7E5RbGxkWFGQhuvd5E46wuroq12yFc8qIrYi2g=;
        b=nhTLcRBhI0DbRWkbaWBJ/iAhcHxnls63P40UVwpJZZbTnwDhYIFQOQj3wnSFCeuwPv
         GilOS6phlt9Lp8atsVKeMhvi41yK9iIJ8+vToymLhgMz4/kg/x+sPk7Y9qpwU5hhcb2p
         iLeM05EZAOUoSjTm49t9L4s9fhlfp3IZOKRyyV6IIXjI/M6N4GROsWjnNEK6cSI/Ywgr
         5f5sZlHwkOuvwGLNHm7KzzRjJGLncKVNL/mCki0eduMKiTQcrkU3DJdTsYFRNCxHz/Bn
         XZ4g4dIP95YkQr7gwMOhFuJ2jJqDBxRlJEgx2e41pdvncS692PHMlkBTZek9VY8nDS69
         8PEg==
X-Forwarded-Encrypted: i=1; AJvYcCVAlSBLvOrox8+1jbuZd3jSUW0zYQ4QrhpnuY6cglmUFE9fgumB5gXGYyQrY+XBuM6pk7er+VOft8F5VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlR48PgHtIyuVhBrT3Qv717ImxsyX91eTGiuKZE1aVbowQkRGI
	RrjQFnani7ETx+crjSAHzKF+p0Ss60iDk7nzv9Wo55jGo2QqO7vtNpvc3042jJj+SP7Tu26uTaV
	OuTrK
X-Gm-Gg: AY/fxX6gyI9uMZ4Y9hsWNa1NtUp1cJN2rOfRIpICCC0V3NVTxbyxn1DtSjnjK1u4qnS
	i7XxTvsI0OGbn2S3/J2VmL5dqSOx++qzfdN7Ie4nJZ2dv3oDkaCvvcy52c5Op9POpur5cadaV4P
	OqRNoYXIQdJDFS5CuNtKPjdjhyMHuXicRzumexJbH2vur1VExIyqpjfuMWn292kdZb3L+3zyKA0
	hQmWO52dN8SWyWCvXHB8he0QSV/lm5/IdisIkSrzeyHUlM2acL95ilgBukrg8h8EZWezNyF6JcG
	T+TlraPpJ8sykpKE5r1ZwxZzg5VlsaLwOcLEJANE78ZBLO6yfOP16gjcvqVISNqaHgOiFDfuyuI
	/Q4j5OQA7yW6txauLXLEZT8e2EBa9IfM5s8gwvQYvyGRN6x05d6qvHHhsamEV0Bw8SJczXylQBC
	zYpA==
X-Google-Smtp-Source: AGHT+IE+H6U9g+bxlFfZOH3RW+nxi5NOuoDQRCzFkGA8h6dP85Lef0stKzOXNmQ2/6VOXFHJ05uipA==
X-Received: by 2002:a17:907:94c4:b0:b72:5e2c:9e97 with SMTP id a640c23a62f3a-b7d23c1b851mr1902966766b.36.1765998160748;
        Wed, 17 Dec 2025 11:02:40 -0800 (PST)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8020c0d40fsm23827966b.49.2025.12.17.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:02:40 -0800 (PST)
Date: Wed, 17 Dec 2025 20:02:37 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
Message-ID: <hqryjrdf4mfcpsfa46hptj6j7ygkjrcahb5tdsa73nxrlngffx@2l6cs5cefi45>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-5-mkoutny@suse.com>
 <aULg4f_nxLTbXvMh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vblk75m2hqwjzgdg"
Content-Disposition: inline
In-Reply-To: <aULg4f_nxLTbXvMh@slm.duckdns.org>


--vblk75m2hqwjzgdg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
MIME-Version: 1.0

On Wed, Dec 17, 2025 at 06:57:05AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Dec 17, 2025 at 05:27:36PM +0100, Michal Koutn=FD wrote:
> > This comment is simpler than reworking level users for possible
> > ioc_gq::ancestors __counted_by annotation.
>=20
> I don't understand the change here. Can you please elaborate a bit more?

ioc_gq::ancestors includes self but ioc_gq::level doesn't count it in
(level=3D0 is root, that's like cgroup's level, from which it's copied in
ioc_pd_init()). Therefore ioc_gq::level cannot be used as size hint of
the ancestors array :-/ (The comment in the original form tempted to
simply use __counted_by(level). I see a comment for each member would be
the clearest.)

I'm open to more remarks or questions.

Michal

--vblk75m2hqwjzgdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUL+SxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgW/wD8CddgVSxey23Qt5ED638i
lD/tTf0uWiVaRFTzwDwf/D0BAM7SnPN0437Gak1dppG6RH7Wlkxsu1F2lDC7R34h
JkUG
=BxIi
-----END PGP SIGNATURE-----

--vblk75m2hqwjzgdg--
