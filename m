Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46463 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeBAB4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jan 2018 20:56:44 -0500
Received: by mail-pl0-f67.google.com with SMTP id 36so2278453ple.13
        for <linux-block@vger.kernel.org>; Wed, 31 Jan 2018 17:56:44 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <D1CC1A53-9A57-4162-ADBF-45F0BDD519C0@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_8D242FFC-0E22-4DFB-97D2-0E4D8D7AF45B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/2] lightnvm: remove mlc pairs structure
Date: Thu, 1 Feb 2018 09:56:42 +0800
In-Reply-To: <e807b046-7d83-9cea-377c-03eb6fd1f662@lightnvm.io>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20180130132605.28635-1-m@bjorling.me>
 <E2E51BC8-63D4-40EC-9912-398BB73C9F16@lightnvm.io>
 <e807b046-7d83-9cea-377c-03eb6fd1f662@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_8D242FFC-0E22-4DFB-97D2-0E4D8D7AF45B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Jan 2018, at 16.35, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 01/31/2018 03:00 AM, Javier Gonz=C3=A1lez wrote:
>>> On 30 Jan 2018, at 21.26, Matias Bj=C3=B8rling <m@bjorling.me> =
wrote:
>>>=20
>>> The known implementations of the 1.2 specification, and upcoming 2.0
>>> implementation all expose a sequential list of pages to write.
>>> Remove the data structure, as it is no longer needed.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <m@bjorling.me>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 14 +-------------
>>> 1 file changed, 1 insertion(+), 13 deletions(-)
>> Even though the current implementations does not use the MLC pairing
>> information, this is part of the on the 1.2 identification. Until we
>> eventually remove 1.2 support (if we do), the identify structure =
should
>> reflect the specification as is.
>> Javier
>=20
> I already started on removing the MLC bits in previous patches. These
> two patches continue that trend. I don't know of any implementing
> either multiple groups or MLC, and since it has not been implemented
> before, no one is going to use it. No reason to have dead code hanging
> around. This is similar to the NVMe device driver not having
> definitions for all that is in the specification until it is used in
> the implementation.

It's ok with me - just wanted to point out that it seems weird removing
bits from the structure that describes the 1.2 identify command. Guess
these can com back if someone ever needs them...

Javier

--Apple-Mail=_8D242FFC-0E22-4DFB-97D2-0E4D8D7AF45B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlpyc9oACgkQYx8FO3WZ
GMrztQ//fXC3X4TDW4MWcyH+tX2lsgnO1utR6Ng69ulo2d1A2mWIrCEgMVhMe+Gj
G6fHBmoh6kwV8k5rOAShCwD1rObCLu7vqBhsxsNIbFtlffeEJQrf9K7Uw6nCZ8DR
fi2T7Ot9Bl9chg/o1V6F19b2aKbrW4MncTcvd5cZxi8xz+fF70vfYBNE2pF0G6fu
rb5nuuxD9ltAaVQyACbjdJ+fkPuhWphLxeGPJYcwGnY1D574bWaCm71LMqOGsDDI
WeSPhEl6beWeCjHCijplOm8/zxGbG2TidMVhbBYGpLEyeJA89oScrlYrbJeIknDQ
gSMfuoHWSCxl5xustRFX8C7COrXRwuRzsdq1kAnK+MU5JrMd4fGYx4MJz8Fo+ybw
LksYYZQp1YWf6vnKlnbVSlWconne0/u/GuW6o6sv7IC1KL263VrY4Idp+B7rWPnO
y4IeUW7oy4qzQeo+gN3mwP0vCuxoKxtP3C0wQ4PsrRYKRzRsLbw8rE65HeZV/+2g
759M18bm/VISf19yO9ZzhTxEBO74miMMQt01erZm1ga+Lh7PA5H5lM2wR7B61C+Y
SCIGIUPS8PL7giYq+glWo96XMrc5WsOuvyzfzuYsTFfiHFKxDxaXbGbS9yZEnj4n
BZNfUZgCf7CpDUXRO1ZHRm9QD4asMIGcWgUHV3JerRfuhpIfu2k=
=6GRD
-----END PGP SIGNATURE-----

--Apple-Mail=_8D242FFC-0E22-4DFB-97D2-0E4D8D7AF45B--
