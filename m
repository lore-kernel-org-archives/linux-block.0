Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF721A704B
	for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751138571; cv=none; b=us9pIvXiT61EvcVSyEERlhXC68grLEOn1q8RZ3a3MWnBILYUHL539si9cB1SccCbQXXLWETWvnpFERem9NFN7Uzq//wFDkFK6GG/n7LDE6wY2ncuCj9o7KV/2Uf0QQ/ipTUox1b2ASJUU3rR727L2RZj87C5LMv6wkT8jgq1z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751138571; c=relaxed/simple;
	bh=jRFzdWxrI+05iC3UOH3tctviU4ldQIzSuC0+TAMEBXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFXg2UruEcfbz0a9dzLkadp2dTrCSEZl27MKOi0NiwuJs9xjdDkQqYXldvRlkrBqBYASgHRMW1URYBy2bW4cqoGYApF/nuy7zGSeTbU1k0cXIkSyIyjkGtL7NSHBb4yr3UNGxW3kS6aAk82BkFIgK0KL9OVgYw7h8SUDSj82I/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EXAM1tLd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EXAM1tLd"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so142681466b.2
        for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751138566; x=1751743366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9Bim0YMZNZkU3LIU7oAVRjKnGb3ndRrw15USIBTsIc=;
        b=EXAM1tLd97INoBkl3vRfVfAiWueZb1UjzlYRZSyroZM8wKgylpcMG1NXxVzVS2hTI3
         SX6S1PINghr+NA4q1YOw8JLLGj0J+rUz+A5AFnWwTWbJ9+WaIJ5G1cGHXw0ZC0OhVVZJ
         cMqmwOz5az0HDnoumHvznUf+bsun4D6qgTGUX9y7uJr+kgy21pZYAxbYK54H8AsMMpEJ
         WQMJPKQTULbeWmVgq/Fbc7+akssYb/9Q0FGZkuja04BK0OCyIamASlcikGEpjvcfwbOB
         dH3aR5Dp0Ou/yl49m/v9UX47lm5dj1U28285BohLUGRo6WWxALE17NMCZiBegn6sgJxc
         omYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751138566; x=1751743366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9Bim0YMZNZkU3LIU7oAVRjKnGb3ndRrw15USIBTsIc=;
        b=rySoxunK/ARO7INeGPEpMdXcY6xXknbvrdZ9+DTqghlL0GosG5Boa/vzAix3ZhIvcL
         mgyn9lMyE+y2MyYU9f0xjRzbb6QS7qQU51kNjVTYVq0Ne+M7og1g3lg1ttBlmLAdiggd
         uZGbUa3APCSN9Syn9E7aJFvLpoS5sDimgLPVRQAZxErasPeForFRh9zF2fwlrR0XQPxi
         AdrociBiQERodcRWRli8PWqn7F5yQtyETaQ/6pZS6Jr2NI20qrSa91PZxx1809n8GpXa
         Agu7tTtPzJ8IYuZbKBiPAA6ATP3Ju92QjFwzEWVCTC1TzUOr1HHaRAdGzoNIsSD393/r
         mQFw==
X-Forwarded-Encrypted: i=1; AJvYcCWkR/BhJMbDzFCp6ia2aiG/NZhwsv8zTo4zuafohmO1DFhMXn8T02pvefXoVEIq3tOp8eTTjbsXQAyzZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YynCVpg0g1xcCHaxA5ooCW9t58GeW09r9czhF7IquQHiU686ljU
	r5ouh3dh4g9wti1bsAM4FZMfikb0dId0wH2/ex4vXWevMVKdwJIIEfhn5GrhNCUrHRU=
X-Gm-Gg: ASbGncvopnaD041XKRw2W8YdUf5E9HW0k/KqO9igNMu0ox3Sh2BRUF6ZeWDEjhmBze5
	qAGSMRMBn4b4gKSr2O3qvXZsfu1Ig78tejlQyfuDEMqgC6plpBIovJwV+8C7CG1SeRCoQnh7+k0
	KH5e+DqwOj3vU3Yr7Jlnl8rvlPNAn9krRqUR8cJC2dYCVkBaa6DFLZBAPW/Kjbazny0hbeMgqW1
	zpLe1E2MeUVfBvtKGjr0rZ5bxV8Y8U7MUq1F1oooUA37wT63ZTq+3UbjeEwuiFExx9B697Fm1L8
	oykcZEI8j0tk6o7/PWfAPT9czmOi042QTIaBi41vE/vxLoY2zaX96W54aSnF2aLXN9o=
X-Google-Smtp-Source: AGHT+IG4p6IOQJNUu4XGm5k/7fPnSyhBhCRmCN9z+y75GlbfLh4HYm5CfIY9WkwLizRmBXYiXvHCig==
X-Received: by 2002:a17:907:6d28:b0:ad8:8621:924f with SMTP id a640c23a62f3a-ae350172c45mr724302166b.56.1751138565980;
        Sat, 28 Jun 2025 12:22:45 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353c013cdsm364209466b.93.2025.06.28.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 12:22:45 -0700 (PDT)
Date: Sat, 28 Jun 2025 21:22:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roland Sommer <r.sommer@gmx.de>
Cc: "1107479@bugs.debian.org Salvatore Bonaccorso" <carnil@debian.org>, 
	Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
References: <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
 <zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
 <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5bqsnr3nvejil33"
Content-Disposition: inline
In-Reply-To: <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>


--v5bqsnr3nvejil33
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
MIME-Version: 1.0

On Sat, Jun 28, 2025 at 10:52:26AM +0200, Roland Sommer wrote:
> Hello Uwe,
>=20
> > That is surprising. I would have expected that the only effect of that
> > blacklist entry is that the module is not loaded. I don't understand
> > how that entry makes a difference if it doesn't prevent the module
> > being loaded.
> >=20
> > You can try
> >=20
> > 	update-initramfs -u -k all
> >=20
> > maybe then the module isn't loaded any more on the next boot.
>=20
> I'm sorry, it is.
>=20
> > The sr module might be enough to handle a DVD-RAM.
>=20
> Ok, then lets try it the hard way: rename
> /usr/lib/modules/6.1.0-37-amd64/kernel/drivers/block/pktcdvd.ko and
> reboot.
>=20
> -> dmesg reports
>=20
> Jun 28 10:38:06 nb06 (udev-worker)[2081]: sr0: Process '/usr/sbin/pktsetu=
p -i 11:0' failed with exit code 1.

Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
explicitly, the blacklist entry doesn't help for that. Without the
kernel module renamed, does the 2nd DVD-RAM result in the blocking
behaviour?

> -> lsmod reports pktcdvd not loaded
>=20
> -> And most important: DVD-RAM fully operational
>=20
> > Puzzled!
>=20
> And now? ;-)

It's a tad better now :-)

Given the lack of upstream response, the driver being orphaned, a
working setup even without the module I think we'll go with disabling
that module.

Thanks for your report and helpful testing,
Uwe

--v5bqsnr3nvejil33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhgQP8ACgkQj4D7WH0S
/k6Slwf/W6KYOvZCJ5oBHU7Y+T3YweCIM9CUB3/abxKsixCqSjZfRu9IFJEItXof
iguQPRBPDsPRGTGYz8Xh1i6v4kbBQJqHrkCkp8vIW1wZcC+I2PmXQ4JfBD6sMFf7
MlXB6RuJJ/PTqNEO9vFVaQKwzLa2QEF3baZ67o9dAXdaaWDsXUpXBYVHrwZCC07P
NORy2Iqo3n03cp9R2uaaOnidiNcLzRkEfe+cNAy5aodia7Nrnk0BpquEXnqnE0on
RVOHtVpn7t40cLrW5mqtWeTY94p7CqE4rYDVAxGTvOImU5vK6JAUdrMK0A8/wYlo
mmXeR8qhsEJlA2Zb89YM4JKZ/zj0kg==
=saz3
-----END PGP SIGNATURE-----

--v5bqsnr3nvejil33--
