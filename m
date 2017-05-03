Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <C1087240-F47E-4975-849C-917FBBB9B00C@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BFF15DAE-9EA9-43DA-9350-460FD9927056";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 09/13] lightnvm/pblk-read: use bio_clone_fast()
Date: Wed, 3 May 2017 08:42:59 +0200
In-Reply-To: <8737cnq657.fsf@notabene.neil.brown.name>
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Ming Lei <tom.leiming@gmail.com>,
 linux-kernel@vger.kernel.org
To: NeilBrown <neilb@suse.com>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654558.5146.13818001419050826182.stgit@noble>
 <FC7673E1-94A3-4C93-960F-EF05A0BF09B0@lightnvm.io>
 <8737cnq657.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_BFF15DAE-9EA9-43DA-9350-460FD9927056
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 2 May 2017, at 23.51, NeilBrown <neilb@suse.com> wrote:
> 
>> 
>> Hi Neil,
>> 
>> Looks good. Thanks for fixing this. I did not know that bio_clone_bioset
>> was not supposed to be used on drivers.
> 
> Prior to my patchset, using bio_clone_bioset() wasn't wrong in drivers,
> though it was a waste when bio_clone_fast() would to just as well as is
> more efficient.
> After my patchset, using it can be problematic.  I'm wondering what I
> should do to encourage those problems to be more visible so that if
> people to us it, they'll get a warning or something.
> 
> Thanks,
> NeilBrown
> 

Thanks for the explanation Neil. In my opinion a comment on top of
bio_clone_bioset() would be hellful, as Ming suggested. But a warning
might make sense too.

Javier

--Apple-Mail=_BFF15DAE-9EA9-43DA-9350-460FD9927056
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZCXvzAAoJEGMfBTt1mRjKRL8P/0U/Xq0gq8i1E55Wg9aWtSsQ
2kJyhfYSGnVWsYGqz5iFgAq/FcmB08dpX8BbOtHpg0hAoohnqzORv3I7JGdVBsBb
NrlpowHyBAd6q81ixXcnJobCaCh0sYntKenag7o17Yas3WVpS7M6xG0JjY740mqu
yRTh3DmcJ77xLCD/80U8E5PTL10Z8+ubl6p14f+pRxP8qWc+hcxi1uGxh3bBekrL
MvTV+m5O7MRen4xEh+W7ukvvz5Sg5eb2ezvCpFKwOG7PZfpqMAKBbThUZ68bzBH3
xL3lKF4hYlkMl63qHsW4boMD3HWm7LGQwggTYUAeOB1p1ODbH6rnf0zeoSy+NeQN
767oqjm+XSYI6tWrYTNm+41Yu3ByZvzehsgTTVokoTJ0BSLs/FSNmSC3Tmw7Xwfx
Pp6cfJtrVKH8E+0oNPx//rLvqnKWQKfj9bGy6YG/zj3vkWdk5Zg6f2Op7nbbrshT
mywRwCYKuX3INjU8+/uwExdT8zZqUfFNLTwvSV3rU9uwkcQcrj25zE0uoOABKVZt
r8vp1V63osIL4zZToGmJZTmHXAdMnYuiCgp1pEIsT7WRyry9f53rekrJa1TvXqNt
BdadT1nvKPzoui7QtpjZZEMiGmjzOJoQZEZUdYSDF7KirVyHnXI3rFDdM9NH5ps/
u2sQcLt+JClKXJEZUc2w
=z8v+
-----END PGP SIGNATURE-----

--Apple-Mail=_BFF15DAE-9EA9-43DA-9350-460FD9927056--
