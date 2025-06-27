Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFE2E719E
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035422; cv=none; b=sTAV6U4B00YMFnScI4DJXROKxGwBxher2NV24CDj0kVhamHPUg8pj6vg5udLNmPCYXSb+npZiFqjgR6heAOmmYfyqiL8vk5STmtU98iZGFWgYz0E2TuMI65GM+wOWX0w/7NOo1VzEzCJqki+261LEz3QDiEpq5QAbovmuq7UhZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035422; c=relaxed/simple;
	bh=x0agrIragENYnRbwrVAK5jTCjlEOUfEYM572KKplvTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTqeYa5cY5PXnkW1o0s2xwWv31R1Gd++xJQR9Zy3InJfcX3pGVXuU5xvYpx9S4Kdulw5rUNRMJ5ZtUhikorLvm7xVlpC1Iu+345Q2Iz/TxgIK4t4RMqQtvNNlZe2rqGhjIT2pU3fQfE+fh/IpgYqzuqGoA5S0SUHOwyiPY5IOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XSYy968+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XSYy968+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3656401a12.2
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751035416; x=1751640216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZMsAp2kvkJnGU0nt7c/nGvhJjPhsYSyspcKkOMt09c=;
        b=XSYy968+wQJhjQEQjQwXTwmQTwGkOb54UG9cJlae56QxZmEosNK97o/UhKjLxjIXOX
         DrbdNr2JUtCx+XiC02kLQIBiNZmlc7Qpr8Qq9Y5hZuDachchii1pI2kJtbpOZLyrGD4C
         eWDqW7emc1XnwBphW5XaTl3EiwZKq4ZglEc7K5Bi6sXfO8+Oez8I9OEddQvzMoB2v8aP
         k2lW+OJkZUbqnPKRh7k1WVsx2NpiySWF6Mlmt/veYnJ3WeNvLkyq4AGwPlTC919iA6kX
         i8eOaPdxTjASkjUfa0UZJJ+9Pr6KPKT1stLhh7wkhaHBdbmotoqpdaXW1DY7Z/9HF6XI
         ihWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035416; x=1751640216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZMsAp2kvkJnGU0nt7c/nGvhJjPhsYSyspcKkOMt09c=;
        b=ruhzpNa2jPtiw7st7+3ecUlUvc7Vc5zpTWnVeg/7WMDHoXJJRY9uvEDoLS88mrGG+D
         p23HSy6hhlp20s+CzMtlLN2R/hYB9Q4lPORTw+5pMx8PCJGq3SWYeaS/zo50W6mRUUAQ
         FYK+ZOsEjEmYld1AbJQUiTQ+pbLRgIAhMyh0buGeXoZfRlNA9/41o3IMvCdosfWJzv3w
         w7iRlRvcvwVjOmwMcxjr4ol3Rd9NSkUduT1ynJcL8Mk6xpojDjGSLSddfyjKzcxqn+l5
         /hrbMv7WtBOfkLPLysDfcehe9hH0N5E5y8xZ7Uh4OPhItdY+By6UOiL3t7STm5BfklS7
         UjiA==
X-Forwarded-Encrypted: i=1; AJvYcCUDgn703wH/GxqFc5kjtG2nbtU7L6Z4Da2kVfC/2C9AvmAS9kM4T+6fJmlAjmZKiKqK2Nhmly84NDJZ+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXqGHqXDJncg0aJWbUzd3fQ20H6c59FmiT3EljCWdrEb84yWi
	I2vknELBlP0Jj0B3ioTV+t6cIaywXw9lLpw8OTGl4JT/g8p70GF+MW2aWw84zKdqQ5s=
X-Gm-Gg: ASbGncslyiWbXEmNsIbvwix8obJT3HTnpCUaILrkRKIsp5pq1ikKVqbr1+eCel2gRuM
	R+nxK6Y8M/ngO8Ad3/HAFITtq/HxbXtSqQt8/m4zywecYyP7HQeUMvt24Mp6ZrpSZ7qDAKIR7kW
	bi3d6mNI89n/3mlIiccNIY7lU6g1OWEeis8sICwywzcYq14ynWZhfd9JzzpmRb5L8wxnW/lnhvq
	Ldj6rsVQmb544DhpD1QK2i5Lz0MOXexogGhdHuvbcypZJTu8AcCSdLF5sgONJM6zFGbeRuLrjc7
	B7ftUaMBiyMmfHnJ53QCTPdFTEZC1pElUzqb6rxiPRBFaugH4e6Arxf+PUxnMpIqlz8=
X-Google-Smtp-Source: AGHT+IFp/KuOyeE5Ufq0so/blExd6IFaN01P9tvzAEoTf7fWiGBRkJlreJTyEePkQBnFRa5jnm3v6g==
X-Received: by 2002:a05:6402:50cf:b0:607:2d8a:9b2a with SMTP id 4fb4d7f45d1cf-60c88ed9d2bmr3033453a12.31.1751035416149;
        Fri, 27 Jun 2025 07:43:36 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c8290eaefsm1547978a12.34.2025.06.27.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:43:35 -0700 (PDT)
Date: Fri, 27 Jun 2025 16:43:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roland Sommer <r.sommer@gmx.de>
Cc: "1107479@bugs.debian.org Salvatore Bonaccorso" <carnil@debian.org>, 
	Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
References: <1M9Wyy-1uRqo614XE-00Glyf@mail.gmx.net>
 <gbw7aejkbspiltkswpdtjimuzaujmzhdqpjir2t4rbvft5o777@faodorf33bev>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
 <zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
 <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fwcv5ywwk254lye"
Content-Disposition: inline
In-Reply-To: <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>


--5fwcv5ywwk254lye
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
MIME-Version: 1.0

Hello Roland,

On Fri, Jun 27, 2025 at 12:32:33PM +0200, Roland Sommer wrote:
> > The pktcdvd driver is essentially unmaintained and there is a chance
> > that you don't need it.=20
> >=20
> > Can you please try:
> >=20
> > 	echo > /etc/modprobe.d/debian-bug1107479.conf blacklist
> > pktcdvd
> >=20
> > reboot and then test again? Please report back if any functionallity
> > related to the DVD-RAM is missing without that module.
>=20
> With that blacklist entry everthing works as expected, even blkid.
>=20
> > My guess is that it's fine and the resolution is to stop building that
> > module for Debian.
>=20
> Hmm, it's still loaded

That is surprising. I would have expected that the only effect of that
blacklist entry is that the module is not loaded. I don't understand how
that entry makes a difference if it doesn't prevent the module being
loaded.

You can try

	update-initramfs -u -k all

maybe then the module isn't loaded any more on the next boot.

> and I'd assume DVD-RAM will not be accessible
> without it:
>=20
> [  168.063968] pktcdvd: pktcdvd0: writer mapped to sr0
> [  168.091270] sr0: detected capacity change from 8946816 to 8946812

The sr module might be enough to handle a DVD-RAM.
=20
> lsmod | grep pkt
> pktcdvd                49152  1
> cdrom                  81920  3 udf,pktcdvd,sr_mod
> scsi_mod              286720  5 sd_mod,pktcdvd,libata,sg,sr_mod
> scsi_common            16384  5 scsi_mod,pktcdvd,libata,sg,sr_mod

Puzzled!
Uwe

--5fwcv5ywwk254lye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmherhMACgkQj4D7WH0S
/k6thAgAm448WVdaIfzgvQi5K9wrdFZUGLA3eNMBCJJZODVHWtel4uGDx0Z2by0l
RK0/6uictJTxsRuuAJDowqbIPlqFZpTDSRwxFwq1sHxNSe2Vb7XK+UWFcozOwWVy
iO36g7bYvNOrI1R8pkKhlo8pegPqmdgVYAybfv6/6IAQfi1KmV/HrD4HnR2BUPXr
ydDiPGYVsXqIG5sG9OFlR8h7FzYEMtDfxNz23hpc+QslfafjVUL4423T88PoDfLe
Au8BzH/8lQm22IAVeq56L1BbZ4AUxu54ydGoRPeN9xNgF5FhNgpUlxcH9J5Q4fe5
Svjjj4QeypFmxxPQqG0pYO59GJ8dDQ==
=jbAk
-----END PGP SIGNATURE-----

--5fwcv5ywwk254lye--
