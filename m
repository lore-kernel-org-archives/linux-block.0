Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF67462
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520713; cv=none; b=AkAZm7mwuMNnoupqvaAKkcOwrZarVwqro0LvShQeQFkMuJcflNYlEuNZqnif+yOnOZhVDBsgYUmUgna+jshx2D+3YDmKacizszfyKT5mqgJUf+2Y0+9XH7feOrURLT23ur0nqipHaQXgOrBv1jD8OVmq2wFIiS5RBIxOnU8RYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520713; c=relaxed/simple;
	bh=DMoo2R0vrU64cwjgXLHGYPnRYzFErXqCaBvzTsgusA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZRadN9XDU756t0F0BPdyN51tGnI8VExbJcH/x4RPLzmEUI60DsXJ+JipNVzwIbEnxrQqpUlT3Mq0giJtENoqdRHYI2IspAA/+hfzHatlmY23bntNldgg4TYZV0zLX24z5vREC65Q/tssixbfkQ2bbdIlj0RZlV5ydNvA4lP7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eyxcnUGX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eyxcnUGX"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so10922660a12.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751520708; x=1752125508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMoo2R0vrU64cwjgXLHGYPnRYzFErXqCaBvzTsgusA0=;
        b=eyxcnUGXHuk3ptN5EYpgzwQbx3J4GGBo4xECziB9FrHs0LRcvJhcapFTjvBR1gjRvd
         QozCgHBhxcmNF9TbcoWIOTJR9WmeHvO0q6+3mkSM3nIJs5gtS5projoTRioN8Nml+t1p
         dXYgEWIgFoEnYfUicUMIVpqk9EJgzKgVR8+Fd7fsD9CbDvXutBlyHAIxo8STsg+1AXt6
         5bfs+cERZHwVQC2ijz1kSWeM2H6wNwWEiwnaeyVT4/+1WueS58/rxQXKXG0YdB21ZJaf
         RWQlsEAeQ505ghzRHDJppjudG9iPc8cCU2e+9HRqLw26o0DU/Ef6oDH2pHPdW6oOECKK
         PCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751520708; x=1752125508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMoo2R0vrU64cwjgXLHGYPnRYzFErXqCaBvzTsgusA0=;
        b=fvDSmdBKiIa2UY+YL1a0KBb7UQS0wKh0pc62xzssh4zYxVVTrwoQMXdrWyCnYWwiqJ
         py4d5c7qOEDuCxI8DOpDVrKNhxll7xFCKJAi0soinqYbOdWi3YkqDTP+6bA+M/feBvsk
         6wN5YDG2c1S3tcge9MkDoGze0bGSn7CJ1ZXdDp2OQA+B6LsEMCuLtgEt2O136d3o8sjz
         gDXkGbuj/qm1DhaigDEdCoMjPkTves175ecrykNZCdHQ/O3Bd4BgRiEmL+HRJFQ5/kUV
         XlR0sVUAGTlAb9xKIik+tmhwBsjT49N1ghjecv4TV8d9+neB0gzkuUYQTNUj8GOmYvZW
         atCg==
X-Forwarded-Encrypted: i=1; AJvYcCXg/oWuXKA7cecYKC2Kzp4BhW7rQehHdbLk8qSCzAh31w4Ew+GjEsIcTx1zoYoxQF+isV9V0jM5gOYt2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwFRGv8M1MYElQ9ClUVjTaouLF3td9oUKXSz5LAKR51TmiYqj
	4YOt1sVlmt1UbG9k+aX+OJDT+ZtarXx5tzU9AkmmhaT4yAqoa0D/g3VBKuaLSB5M5QU=
X-Gm-Gg: ASbGncv3zM+HZAALZpgrSW7Jus/pOrP0Htm7YaxVvZPZBYVUZNiOSkyC5q9nePLZGJi
	SWC8MO+58oFI3VJppiKq5Z5IaKjUQ6mUiE1fVIw8dNFUVqZIqr7hugUNKZEK+EMEnWjib6m+33j
	JHfBeGpmJ02BlrivrQ+6/Eo9eLtmz1cLmZsP03i3CNsj0LILIqcx1dsQvp6KRLkM+00cuWmQ9Iz
	2S9JMO4UhGtz254RfDrY4ItP9f+w1m1quANmxfJQKzo58lL1s8cZrK6V5jk/tKv1SILAAhSn8OR
	4NGhQQcop7+7DsfdR6Se7PxvP7z1K8ppHqcib7fh2lDBwUNFB4LP/PTdy1fRCmAlxjwbPPjdX2v
	vnw==
X-Google-Smtp-Source: AGHT+IEOjmqy0fY94Em0odsZyBPcQiHwkH/miqzLmABl6CrUTUeJ+up2xEDe5GBHm3genJlLJ/0hXA==
X-Received: by 2002:a17:906:ef04:b0:ae3:63b2:dfb4 with SMTP id a640c23a62f3a-ae3d83f83d4mr177648366b.27.1751520708046;
        Wed, 02 Jul 2025 22:31:48 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353639be0sm1180181566b.6.2025.07.02.22.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 22:31:47 -0700 (PDT)
Date: Thu, 3 Jul 2025 07:31:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <benh@debian.org>, 1107479@bugs.debian.org, 
	Roland Sommer <r.sommer@gmx.de>, Chris Hofstaedtler <zeha@debian.org>, 
	linux-block@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <h4bhmhv5nwtas3bylidfrf4qfb6k55cg2dmcux4426ifsuahce@g5wiqjsyfn4n>
References: <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
 <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
 <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aodn7ncszxoxrysx"
Content-Disposition: inline
In-Reply-To: <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>


--aodn7ncszxoxrysx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
MIME-Version: 1.0

Hello,

On Wed, Jul 02, 2025 at 05:13:45PM -0600, Jens Axboe wrote:
> On 7/2/25 5:08 PM, Ben Hutchings wrote:
> > My conslusion is that pktcdvd is eqaully broken for CD-RWs.
>=20
> Not surprising. Maybe we should take another stab at killing it
> from the kernel.

Sounds reasonable. With Ben's and Roland's user experience it seems
there can be noone left who has a benefit from that module.

Best regards
Uwe

--aodn7ncszxoxrysx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhmFb4ACgkQj4D7WH0S
/k7wegf/bIacIfWOaXBDLL2gAvahW2Zo63BwTIvHtkhvv2biwoNqXMFCTT+bOfsP
4NBjSrpCWOjPrKtPh4hWDRtYo851HpStfgB3+cL+hh0541viEQIhFds/V07pt6yB
5b5gZXCVS+Bgel2DHaGR4m2jDaq2bh2H1dP9Z+AslBCoRikstNro0c/PBpALnTo0
V2WB/VoUW1znxTmPEByjuf9gG8qLX6XtDD3yPvsb+EYlrzmlPd2zCt7jUjjfeWVx
b6Uy1YgNSxS/9Mwet5Jv38n1H5WRfWyQC9EGKc+ZECbhvSLnqe+ezGUTJl5DrW8j
pxIHN3wW3CL/44/m3P6PKDqqxzxRVw==
=mk8u
-----END PGP SIGNATURE-----

--aodn7ncszxoxrysx--
