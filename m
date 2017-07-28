Return-Path: <javier@javigon.com>
Return-Path: <javier@javigon.com>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <51587202-78AE-49EB-A1D4-25156447E32F@javigon.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0511E29E-8E8F-41E5-9716-D6988D927BD3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] lightnvm: pblk fix for 4.13
Date: Fri, 28 Jul 2017 16:09:37 +0200
In-Reply-To: <924b7b4b-78ee-80d8-ed35-7f41b4d60a91@kernel.dk>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1501247596-23999-1-git-send-email-javier@javigon.com>
 <924b7b4b-78ee-80d8-ed35-7f41b4d60a91@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_0511E29E-8E8F-41E5-9716-D6988D927BD3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Jul 2017, at 16.06, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 07/28/2017 07:13 AM, Javier Gonz=C3=A1lez wrote:
>> Hi Jens,
>>=20
>> Can you pick up this fix for 4.13? It is a fix to a read corruption =
in
>> pblk that has been there form the beginning. It is due to a bad bio
>> manipulation in the case that an I/O containing lbas that are =
invalid,
>> point to data in the host cache and point to data on the device, all
>> three in a single bio.
>>=20
>> The patch applies on top of you for-4.13/block and is available too =
at:
>>  - https://github.com/OpenChannelSSD/linux/tree/pblk.for-4.13
>>=20
>> I marked the patch to fix the original pblk commit, but it does not
>> apply anymore on the original 4.12 code. How do we handle these
>> situations? We make a backport when Greg makes 4.12 stable?
>=20
> Greg will email you if it doesn't apply, then you can reply back
> with a version that does apply against 4.12.

Makes sense. Thanks for explaining :)

Javier

--Apple-Mail=_0511E29E-8E8F-41E5-9716-D6988D927BD3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZe0WhAAoJEDxGAX0tJXjgMZoP/1Nyg2EwXvtaZuvVPmnMCQiR
gfP84zg5FXGscKu1joL2Ua3HCjSOtwu4XNZaQ+6iCPpU78nvoD8ZfnwPfko7I24M
5diAmEXdBzH2XQgnJQT/8LMfYdi487EOj7GV9yxv0Kq3sVPRTz/Yz6cG/po6LuhO
JOdh7tbUnketGSU1sBYLLl38F12x28yABR6LI2g5DKOleunvDDZBAv7bDCIuJXZL
hqTQcW+8IALI3jcNgoKgO/jBUhQxwdWyAqLHtyrnkl+nFb1iGxd5Zqikc7tSK3Jj
P0YriiuP6FS96kJE0FIcPaYJ1gVDN/MF1UUDmeAGgRaUIsu9a5xtmFXctA5obXFb
+6tCogr7Y9Cg5CUl8gHGyRwXOe9G36mHC4zWwQu5RkG09kDSf1CK+jGah52Y7hJZ
iuZBD+3fvBTBAUK6pr3jQY147nuuUFpUA0oAxVbcZItneQmY2lkY4yY12EzOs0Pr
0Vre5rYsvx3zORVVLfbTuuzJha7YWtCSJnWf488Fo709U3Cm+xJ1F2i/cj0RwLO3
3J/cKPRtY8Idvboj+lyz8j1cdBt2iBjlIGDnVtHIKDO6HNYnJNA8804YQxYf6acx
oU11DjcD0GE3POZWqn8acDJhsI/+Cuyy4JzFuyKkrvZs9L3J8C+XQOV1JfhGC2Ng
V/NfWGt7Rv6S35648SOv
=spD2
-----END PGP SIGNATURE-----

--Apple-Mail=_0511E29E-8E8F-41E5-9716-D6988D927BD3--
