Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Fri, 16 Jun 2017 17:30:50 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>, Javier Gonzalez <jg@lightnvm.io>
Subject: Re: [PATCH 00/13] block: assorted cleanup for bio splitting and cloning.
In-Reply-To: <20170616064246.GA2979@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble> <877f1omcpo.fsf@notabene.neil.brown.name> <87shj05vft.fsf@notabene.neil.brown.name> <20170616064246.GA2979@infradead.org>
Message-ID: <87mv985qz9.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15 2017, Christoph Hellwig wrote:

> On Fri, Jun 16, 2017 at 03:54:30PM +1000, NeilBrown wrote:
>> Hi Jens,
>>  I didn't hear back ... have you had a chance to look?
>>  In case it helps, you can pull the full set, based on a recent Linus tr=
ee,
>>  from
>>      git://neil.brown.name/linux bioset
>>=20
>>  or I can resend the patches if you like.
>
> Can yo uresend it on top of the latest for-4.13/block tree?  It has
> a lot of changes that could potentially conflict.

One trivial-to-fix conflict in xen-blkfront (a function I remove was
changed slightly).

I've pushed the new version to the same place.  Do you actually want
me to re-post all the patches?

NeilBrown



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAllDiS0ACgkQOeye3VZi
gbn1DBAAu/ukqFIP1OBmmJJ5RVzCEnq8aO1Rt/QjMnjQLT0PZ0RMrsyacTds8+JE
E/7ppdMpHQsyxpGSr+Vrw9csuLcemGt+9Il/CYH93scS0+5G9cimpGJnlH9xp8jH
uapXO/ZZD9D+xyQcMSjLW/HkwB7ToIE7fMEXuP5CdjTbFugUAesR7uqs1EEb8+sv
RNrgaav/4op8dHdzaG8TY/25PrZnrFGfG7DwDkuXoKhdWtJbFXC+0GDFJece/BCw
tityM6zq15ezUy0oTY/zVc1HzirkEQCkLS3gMtmu59TcRQ2KW/45qDGX0pjqbxuO
1FMmxpOmLukioVRLxW2du5S2yxcLSl93dCsYppIsOKgYCPpuJ1kUWgaqY687jy1z
WO3m4CCq/GkV0vRhYQz6s+ukg8jz+n4LxxbXhwE+kSth+od+g8AxRdcs86lXrBD9
wUomyoY1ije3eUydliqJe27FiG2jUyJQJFQnSA8lzRCGwwAWTK1BrLrlNOkCi0R/
SZ/BLxOg3rd5bzQO8VRi+RqzYOyqdGhRxloInL+ZniPhS7sR6pGfdTR0WUUoSVra
bgFUS9YP1bQN0y+zbq+kUxJX2X3o2Y/DOPRjybXkznPMXYxpzgQ2cx/goSfegh1z
dRSoWACYzaouidy3ONaK9Pi6eDXgo+T6F2SnoKBA5hSSS/tchuA=
=nv2n
-----END PGP SIGNATURE-----
--=-=-=--
