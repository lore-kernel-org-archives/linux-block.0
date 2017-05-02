Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Date: Wed, 03 May 2017 08:54:55 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()
In-Reply-To: <20170502102223.GB1803@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654638.5146.3067734913419940612.stgit@noble> <20170502102223.GB1803@ming.t460p>
Message-ID: <87tw52q37k.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 02 2017, Ming Lei wrote:

> On Tue, May 02, 2017 at 01:42:26PM +1000, NeilBrown wrote:
>> blk_bio_segment_split() makes sure bios have no more than
>> BIO_MAX_PAGES entries in the bi_io_vec.
>> This was done because bio_clone_bioset() (when given a
>> mempool bioset) could not handle larger io_vecs.
>>=20
>> No driver uses bio_clone_bioset() any more, they all
>> use bio_clone_fast() if anything, and bio_clone_fast()
>> doesn't clone the bi_io_vec.
>
> Maybe in future, some drivers still may try to use=20
> bio_clone_bioset() again, I suggest to add some comments
> on bio_clone_bioset() to make this usage explicitly. Also
> better to trigger a warning if a big src bio is passed to
> bio_clone_bioset().

There are now just two users for bio_clone_bioset(): bounce.c and btrfs.

Christoph wants to get rid of bounce.c, which would leave one.

I'd have to drill into the btrfs code to be sure, but it might be that
btrfs only needs bio_clone_fast().  That would leave zero users.
Then we wouldn't need a warning at all.

So I agree that we need to guard against future incorrect usage.  I'm not
yet sure what the best approach is.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkJDj8ACgkQOeye3VZi
gbkL/hAAwUZiBuC7eUPeFDfpBFvLFBO33syr9I9szLXJEqcAKx5SkdLMns+Mkfh8
EZJgqw0097aDm0t6hq+p4uMO/pSaP7dN0KziloXnRxeY2wk+UhvLUoBSfUJqGG/w
Qp6YmhbRbGXVkLvlkI5as+C7F+AVHXDb6JdRklDGqBygFoFhhjnWUsDr05dO1dYf
abbSCYSV9zDUd8tS2O1zCZGHC7vRgtXGWO/pkl/Bj3OIFz2Lzd8tt54Unch5Exae
DXM+L+KpUijgfAFbWU91g2GZjkDGUU7NLn6EPnBUlJswRJW4OtMjeZ0ZyTy4sVJI
2oEdPdO4EcpDjT1eMeqWhHeBT8fQEPOxqeD8H0qmVJGwMIhRv5CUfaxE/GrzwkyJ
NwzfNdUHuX2MTI7V0wMZcaHIGAJApuMgsrEPVkIH8/WsPpE7m4vEvqoSvGg4jAl1
8RU6xE6u2muXbHiv92hHSbEIl4F8xxpU6krTmbmiBf/ZeDtth6sOtgVFkFixTL3P
7LlO826F/EKohH4q4oRp/ebtJywHqCpy1Uz4vZ0xlWEFN2ZI55d7YKvVJwcvioBY
Lk2ECQ8E2dYsDAx6VgLuX5SkpcFdVXngo0nB4BiqfyrPwswPmHR9zIPmSR/tF3nH
iQLZfW6H0SNA5kYwBuFZ6prVHknmyZ6pCB06JgVtM9K6PpfWVDo=
=T5GJ
-----END PGP SIGNATURE-----
--=-=-=--
