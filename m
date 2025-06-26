Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2770220F33
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950773; cv=none; b=Yj88ueB4AMu7NV2SydlTfcLCZVEK0a0fV38l7nFdxWI5xf9M399rIgheUmIxmpnhTC0T+0/Go1sKWyUqituiIf7shptnLOB85A2Q7Y8UXneIaaa8kahxONBvF82g0Qpx612H1Fz4q4ZeF4EN1t9mYhVTT6JXcHSxIRM/8Ka86o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950773; c=relaxed/simple;
	bh=f8a9fNDogK3TgnNqJBtmE0nJ/JWVD68QOda/kGeBh/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VozuIL7I+AAWEyaOaiJCyyzkK1pKPwY8YF+1j1z3WEQmQLRiwubonq/vsod9rQvfIdVjY/Hvdiuw1w1oudF0PWHGWoHhqI99DtiaEAKKU67vaUzzTKgtSuJeoZthoWVMsiwIbnt30Id/h19w3T9jXgEpq68/JImJFS/okCgO9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HoCr5jGe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HoCr5jGe"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso1784120a12.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750950768; x=1751555568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+NXz6C51eaM+tbU/Je9IFf9sI8HjzT7zkhTFz225Y=;
        b=HoCr5jGeueElYL6wzdWKa7GERMsi/4Ighom0LS+BYCYemKMJXpAmtQTl8copWzeqn5
         IoCHGU1lUyga2o0vtnTcUC0VoLok3REkZ0IBv4oT7SgtaF/Kpgk8P3HjEnNb2WfT44be
         DWNOsP0nEbP63FkhW9BjQYgY+UaBj8JXZT3osfwUc9PmtEmZq3zrg/buyPJGQl5VorMy
         tVsNxdrtODu/MLkc9+frCSInjxFuNyGWo3IA8N7wi5Uyia74FUqHo0mUEkaHMNbP2pJC
         JDEXVGgkz0+Q0wNKsu40UGRZRugamij7pYr3tB1Y+RPWjC7w5aGpBLOFpqryF9uinPqk
         h1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950768; x=1751555568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu+NXz6C51eaM+tbU/Je9IFf9sI8HjzT7zkhTFz225Y=;
        b=BjjcnTO9bpMrH5xiS2E8/M+Dj2Wooee9BB7gMh8xcYW+HWnuy+GikIQRS5BeXXnYNo
         hv3+UySiRwLu83pjz2cDV0Z+xSGSBlbomK4tL/ltG8ntfSKR1fEQyfDtXIghr2QUYm8z
         WjtmHfExjPEpeWdUiPsCaOghH5B5/J20oSNvZptWjmdaHvYPIHOm/oAdZ1ZEBVnZPiuz
         YSkrXozVpFUKSRO0kNKxhpGOS1bmUhiKP7/1v14sWvSVG8DGJXw7BAG3kpx4Gpc8Hszc
         U3z9f/uJvgqXOwwiz0qFIxse6ny/ZP5TVYt4HCX9YXi48kLDduPHyK1QOu7CO76GGsFG
         7PlA==
X-Forwarded-Encrypted: i=1; AJvYcCWichqc9eT4C3uxtR6/9+entNQvso0LYogjuJ35NM8WdW+IDRZ9fAyEm7U3FfOcOoXzLspQpJg3oUTqPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNtjuBqA9pwDrJOBCg+dWGXjktupDmBS2WNKE9+mzG9Yz/DXOi
	vPy95a3eL1xDllTDyiMJsRJ51BHbveQo9rxEECDtLOINuZxzWFYu4QgaVoT4dg1YHQi+vSkPzNL
	kGi/n
X-Gm-Gg: ASbGncsvNJ+V930UG20CgBQPn/35v1uVlJAPH9XI2Ogy12T1uxMOBOricfpmOg+rbVU
	O0c/Sip01vMPL0Un9FGbElkJLW2GdV/n2ALTDCmdIJP7sV7Neg7ATHtF4ZjqIqwD54nnvE9et00
	4Ur/NubqTDY6VoBC1w19rZW6o/LB43qsL7il0J7V6i046+1DPAhR89qUsMLyQ4S1DzDP50+dHqh
	vuWjKzhdHuNqZIjm9T316ptd9b6CatgmO7XxpEWWMLFLrAMsNQI6MIL3H3CSR2Aach5C+fjmD6E
	Nw/7WJtqzKASR14xUf7znDQ1NJn9HaoPmiwiIdVPBjYhZyEk1R4eQabTrOWsmtbCuIp8AYbdt8j
	S+iHrcDiO35xzAkBOCE2jcNBZY/AC
X-Google-Smtp-Source: AGHT+IFaq8tDcu6YZWZmnXTcI2TYBcNiHfsgvqiQfe+19MQzYtdLeuKVDBalblEZgeisw/BAvY2l/g==
X-Received: by 2002:a05:6402:3495:b0:601:fcc7:4520 with SMTP id 4fb4d7f45d1cf-60c4d317780mr6628481a12.4.1750950768102;
        Thu, 26 Jun 2025 08:12:48 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c831f05e4sm106764a12.66.2025.06.26.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:12:47 -0700 (PDT)
Date: Thu, 26 Jun 2025 17:12:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roland Sommer <r.sommer@gmx.de>
Cc: "1107479@bugs.debian.org Salvatore Bonaccorso" <carnil@debian.org>, 
	Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
References: <aEaMawE-Nn8QSjgS@eldamar.lan>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <1M9Wyy-1uRqo614XE-00Glyf@mail.gmx.net>
 <gbw7aejkbspiltkswpdtjimuzaujmzhdqpjir2t4rbvft5o777@faodorf33bev>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
 <zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uef7rsrvej5yoebo"
Content-Disposition: inline
In-Reply-To: <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>


--uef7rsrvej5yoebo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
MIME-Version: 1.0

Hello Roland,

On Fri, Jun 20, 2025 at 01:26:31AM +0200, Uwe Kleine-K=F6nig wrote:
> In Debian bug #1107479 you report that inserting a DVD-RAM reliably
> makes blkid (which is triggered by udev) result in a process hang.
>=20
> On Thu, Jun 19, 2025 at 05:05:07PM +0200, Roland Sommer wrote:
> > > Can you easily tell if this happens for several DVD-RAMs or just a
> > > single one? (That might affect how good this is reproducible for
> > > upstream.)
> >=20
> > I've tested 3 different DVD-RAMs, thus, 3 traces below.
> >=20
> > > Usually only the first one is interesting. After that the state of the
> > > system is broken and the info from later traces is unreliable.
> > >=20
> > > So yes, please provide (at least) the first trace output.
> >=20
> > [  330.049632] pktcdvd: pktcdvd0: writer mapped to sr0
> > [...]
> > [  484.389280]  </TASK>

The pktcdvd driver is essentially unmaintained and there is a chance
that you don't need it.=20

Can you please try:

	echo > /etc/modprobe.d/debian-bug1107479.conf blacklist pktcdvd

reboot and then test again? Please report back if any functionallity
related to the DVD-RAM is missing without that module.

My guess is that it's fine and the resolution is to stop building that
module for Debian.

Best regards
Uwe

--uef7rsrvej5yoebo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhdY2sACgkQj4D7WH0S
/k6GgQf/d4sb43LT9U8aQkMwEYnZrDqwHH9gP8z5qVrL7bolq+m04hYqWwobd5SQ
qVicnJ3c+rzeIml+y31SyJHE21JpY02FojC1X9ydwR8NIyLu3pijBpUaNiQXFxl+
VeZPQqH8PtKPF774OC2aSSv3Efz/l0DyPANw6T+Pn314pF5kKKmkCU60nQL/+P/O
E2JZ5A3TvaAtjyFeCPBC2Ma6yRwhv2qcDIR769LsJNOq/plqitGm1DR+k/FW+cQF
fOlt012V9tl9P7TtOxkA9nBaqV8IJo4TrOOraKeQfQTE5dQqUIDFrKzGR1naSNVA
tj32rEXOu4nXYaHaLf053MHQ0KTK4Q==
=77/f
-----END PGP SIGNATURE-----

--uef7rsrvej5yoebo--
