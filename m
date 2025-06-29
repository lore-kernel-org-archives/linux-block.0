Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E81E521D
	for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751192812; cv=none; b=GXT4ettLQulTZ0ti8GKfBwXU5ap/6XB/uhMVTuE0ee8kMn7LktuW3oqsEr7uO3Z61wvH/OaHG2T8uZmNoxS3t0AolkAyFWWMdWJyFP3+iLH1wsfV5Udvyfvk3DgcJynIGk3qRse6Wb8EC8vNpTorokBhCV33AHJV0HZmZdYEMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751192812; c=relaxed/simple;
	bh=9XVnlgONWz36TAJzro60U41QndDSuvaWNGN5JkgSymo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD6pk0HW+bLCmdZG4L26dvmS51jPC6uCVAO+RUgQU6aSP7yzvUny/KVyvttMRx6ArCMTAeZBVPu0hUmTdHltvMzBbZKy6qs37/Tj8a25M6XKDAs+lN0mIfRUKUaRW+ZP7zD/D2RWV4AG1SbRo+HRSIbaKMAa27w+Ioly77AXX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QcAeetUs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QcAeetUs"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so484695566b.2
        for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751192807; x=1751797607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JbUyDBQjiJQD0Uad1Q6aC5Set9rBMEYpyDGfZz2+uU=;
        b=QcAeetUsfXfuLPqOXWQMduczV/SnAX9KPg6v9kKXRznUbo+DigoSbnRZO6FtBVIRHk
         j+1RVWPlhdisC5OHeXeMHMGdmYvx4z3mqTbtyoydh5nFhUPFfGWB9fWyEIQuwn75kAop
         +gJYXUyZGaNvYx4yO/YxJQEhM/q+Dw1GV1iSNHC+PY6qFi9Va1VCXwRogyAhIMouxJ76
         9yJPFAg1CWM3DrZrfUTD+YChkOuEjw1HCFNSUlSE/dyvYbNm7cg+hVNiy34XzWXM/Orf
         a5CV4Un1SJlT/iYW1+JKaezpuZJg3AalWqcBzaViTESlkwbTV7VFKQuAUtcVtQEzMXN9
         Q1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751192807; x=1751797607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JbUyDBQjiJQD0Uad1Q6aC5Set9rBMEYpyDGfZz2+uU=;
        b=SXQnLByG9CUnWCs98xSF/3jq5aEqhHEF+rIBbpYawhPm34i6ulvf2hpfzk5BCQpzqL
         usgnfop4LrhQNBAEJKnFh6ujRKkRczVEhWB+S9IeC5Xds3vrJHLLFJNUHo0W4cyvowrR
         Zz+vP8+j6yuOL2inwTAagAHJkHZDP1ABzL5EvZ37wSmuz8YoNftBmJKDTFFSJFQxkAZB
         DxstgBlnrueR9EQY3bm/euvpGxs5yAwmfgHYpGdJnSYkvdHUjxg0nW9Zs+ZKUCgKIZ+3
         /Y7toL9E4lQLh0d1mlTGppmpZg/fc03T9krnqNpc4YRdh0JisZbwG2HAQA9eBy2VTJBK
         1k9w==
X-Forwarded-Encrypted: i=1; AJvYcCXfS0fzq3FV1HpnBEj0E3RsqIjr3w9vb1L5WJ7TjMG2k1RI1J2aapTSpNhdMfecX4yQSDAl9i7RpqKU0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWihd/NskKLDXVc8R3pjkivug4nAzyMKoSU1IJMjRchp1fDkc
	nXjHM/RQYuWezo/0GcKWEy3juk8dd38g3F4FW7upMjSNR9BNawqJ1VSPKNd2UGtt1TQ=
X-Gm-Gg: ASbGncvJ/NErHEuz54OWXfSIlwQV/HS+BrYAZF57g+YMNXU3g9DK2lh/LHb2AANejCf
	V6+gaiRqnPyoRZxSqioBp2b6pVi1maN0YB0tx8etsODyD2gbES5+whbzim11IfTs+9477dMlZ6R
	ApoZc+fd8F+bWCHf5NdxcPztuqPfCcwW36Ee1xiyHzjTCqKrK9pRVENIZEPST00vcmfoIPX21Np
	+pVh5/vP2xATBVmTo6spYreThWivdVBkvIiv/fEYJrM7prO4ZotbbplGUtkgvVw/GrrIFiUp0c/
	12LSocbS69YZGtNcPTRGqt4cFL+c302tfo6p48ez19W95/S54po8KAs5zh3TrFNRn28=
X-Google-Smtp-Source: AGHT+IFhiwwb/VFoQLCcFjz/dAAKhvm2Lp8O6FTJaohRwhTa0xcTjAqjWPaIt6REBm/IGYV9h9YuFg==
X-Received: by 2002:a17:907:b818:b0:ae0:14e0:1d62 with SMTP id a640c23a62f3a-ae3501e0f1emr791480566b.55.1751192806902;
        Sun, 29 Jun 2025 03:26:46 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae35365a75fsm470846166b.67.2025.06.29.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 03:26:46 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:26:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roland Sommer <r.sommer@gmx.de>
Cc: 1107479@bugs.debian.org, Chris Hofstaedtler <zeha@debian.org>, 
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
References: <zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
 <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ten6oz5uuuzunqme"
Content-Disposition: inline
In-Reply-To: <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>


--ten6oz5uuuzunqme
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
MIME-Version: 1.0

Hello Roland,

On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
> [correcting CC recipients]

Huh, how did I manage that (rhetorical question)? Thanks

> > Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
> > explicitly, the blacklist entry doesn't help for that. Without the
> > kernel module renamed, does the 2nd DVD-RAM result in the blocking
> > behaviour?
>=20
> Yes.

OK, that makes sense. So udev does in this order:

 - auto-load the module (which is suppressed with the backlist entry)
 - call blkid (which blocks if the module is loaded)
 - call pktsetup (which loads the module even in presence of the
   blacklist entry).

> > Thanks for your report and helpful testing,
>=20
> You're welcome. This is the way how OSS should be treated (at least in
> my opinion).

I fully agree, still this looks different in practise more often that
not :-\

I created
https://salsa.debian.org/kernel-team/linux/-/merge_requests/1564 now.

Best regards
Uwe

--ten6oz5uuuzunqme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhhFOEACgkQj4D7WH0S
/k7ThQf+KHc7LJFsg9byUWitxsl4WwlNITqDksDl4nqXEP/2GpZWjHVYdOHyQqVF
SFHJYQwEmblzOD5MaTAHDB7ZSwjUEYwsioBohziVIb60TXhpO4kHhFXliQCtPmho
reFZWmDnx9h2HFwgp+5grPCJHLhyps1u/+YEJA3JDrcGzEwuejNa2S5twZ27Y99k
XNA/j3dY0cSyEmYhcOhaZk3wqFTrMBm5o1ZlXG+izNabzaJw6w1AtCWjDwz7zaK0
ztdh+IBuI5ENmp0tYVIOEDjct6CFjDfKZLP7wfFyfgKcqgAk2C2duR7UjtJQw9XH
n3koBzPFsPx7CLeucc9ycLkht+Pn2Q==
=arKA
-----END PGP SIGNATURE-----

--ten6oz5uuuzunqme--
