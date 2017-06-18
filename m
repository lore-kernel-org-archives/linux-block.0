Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Date: Sun, 18 Jun 2017 14:40:54 +1000
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>, Javier Gonzalez <jg@lightnvm.io>
Subject: Re: [PATCH 00/13] block: assorted cleanup for bio splitting and cloning.
In-Reply-To: <40fcfd98-3dfa-8fca-5f06-ad26467dc128@kernel.dk>
References: <149369628671.5146.4865312503373040039.stgit@noble> <877f1omcpo.fsf@notabene.neil.brown.name> <87shj05vft.fsf@notabene.neil.brown.name> <20170616064246.GA2979@infradead.org> <87mv985qz9.fsf@notabene.neil.brown.name> <20170616073425.GA20326@infradead.org> <40fcfd98-3dfa-8fca-5f06-ad26467dc128@kernel.dk>
Message-ID: <877f096h7t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16 2017, Jens Axboe wrote:

> On 06/16/2017 01:34 AM, Christoph Hellwig wrote:
>> On Fri, Jun 16, 2017 at 05:30:50PM +1000, NeilBrown wrote:
>>> I've pushed the new version to the same place.  Do you actually want
>>> me to re-post all the patches?
>>=20
>> I personally prefer to always have patches on the list, but I can't
>> speak for Jens of course.
>
> Yes please, I'd prefer them posted again as well.

Done - to lkml and linux-block.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAllGBFYACgkQOeye3VZi
gbkxGg//UVBZn8ezMpZlonc5wUQw04PExr0zeS/G1U5pzuaVSgKJkT/s7RBX4F6B
SXF2p0+43ogqBb2Igf3RGk8yc1W22kSznpJg+Okj24gke0JhkXKHU1ze6dhArBeC
SzozovXHusykzYodIKNCkI+L/mjVUyXlByBebMf+/Ea8xJyzen/PsW7OyBFSy9Rb
N16UXY1K4l8mYk3KtfiSZZnhW3LsY+6DILaDJYs9oNF0o9tGOOCWsaoPjPnto0RY
7xprzSoiwQveKOx8kM7iRwfDYb3hjYrL/XKnMIX55nCQLlYdZ4mX6VS0XC/izdq8
TWVC1q1J1M25aEF9t/UFnxISHXRXdBrTEDLFgKBNeKsatNFW6v2/m6I2Gi3rVRgB
ydCMN6+gapRfK8IV86gsWeBTruvHRzlyOA/VXaz8qL3UPZZTB8N+khWw7vRPnn2D
33aOcNBoxEPicJy7c1fl6esWujfMSk5eMqn5s8sRoJ8kVnm1q1/uqJ/VLh3ZTzCa
/REf17myT60I2iFQNYs4WXIN4s0B1vn51/JxyaP4qWX+chHH4n0oMFZwHJBWfhxV
HvqcppOG+m0Eo8aN8qw93I4VZKis8WC1AKuLVUAWqvlCClR3mmHlNPbd4lUSDO7W
KZbDu/Hez9YfQrdNV0tcj1JaDiqkd1iVd5xO3+5e/yckQ9/wGEc=
=l4hY
-----END PGP SIGNATURE-----
--=-=-=--
