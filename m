Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Mon, 24 Apr 2017 13:14:33 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Javier =?utf-8?Q?Gonz=C3=A1lez?= <jg@lightnvm.io>
Subject: Re: [PATCH 11/11] block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()
In-Reply-To: <20170421113408.GJ12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266673048.27388.6882396367486800999.stgit@noble> <20170421113408.GJ12523@infradead.org>
Message-ID: <87bmrmqyxy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21 2017, Christoph Hellwig wrote:

> On Thu, Apr 20, 2017 at 03:38:50PM +1000, NeilBrown wrote:
>> blk_bio_segment_split() makes sure bios have no more than
>> BIO_MAX_PAGES entries in the bi_io_vec.
>> This was done because bio_clone_bioset() (when given a
>> mempool bioset) could not handle larger io_vecs.
>>=20
>> No driver uses bio_clone_bioset() any more, they all
>> use bio_clone_fast() if anything, and bio_clone_fast()
>> doesn't clone the bi_io_vec.
>
> Hmm.  From Jens tree:
>
> drivers/lightnvm/pblk-read.c:           int_bio =3D bio_clone_bioset(bio,=
 GFP_KERNEL, fs_bio_set);

That is new and I missed it.
It should be bio_clone_fast(), and it shouldn't use fs_bio_set (as it is
not a filesystem).


> drivers/md/raid1.c:                             mbio =3D bio_clone_bioset=
_partial(bio, GFP_NOIO,
> drivers/md/raid1.c:                             mbio =3D bio_clone_bioset=
_partial(bio, GFP_NOIO,

These have since been changed to bio_clone_fast() or similar (in the md
tree) - and bio_clone_bioset_partial() is gone.

>
> I did not see your series touching either of those.  They probably
> don't matter for the code removed as the bios are controlled by the
> drivers, but the changelog still seems odd.

Depending one what base it ends up being applied to, it may or may not
be correct...  the md changes have been in -next since 28march.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlj9bZkACgkQOeye3VZi
gbk7Gw/+KUFFWi/CjQsIaPfnLo12xim8yLdJtSRPygLugXgY7k0cR09otaByK3ZI
9fOOTie54qZP/ubF+etKk+1ciLUEPEmlY2GU3cF2rTzMLSlK8B5Km079MsP3yt/b
1nXMFwUqOd8kx2l3rH9NsoxNxFzckuPqKZEOEUp/3km9xswIU/JCnOzDDspAYaRe
tIobU2Wl7tK6FplI8PyuJtqZsQjtqOMFH47lryKodafozrsb0o1wj/kBPgTWiy73
0NyatcDagyOKLlkEFUNlrG1Obw2G4mNq1yl5mjy8eHT8d14uqe6LbnsE21s0Qzqx
QGk7qe4u2Sjr+oLPyVzsyT7NaqxmgnYzjfhrHuWflA/2cZuLRz7F6Jj9oRwKGmp3
eewr2uiBKIlyJzoVLYRJt8ubGh9VO+plNjTn0Tt/cBBh7if9vlazD5JQW67xtERU
6Dash0FspFOgahUKCyYySvFGlSWDS4zqwCESc/ZPVHGi0X/UGwzJ3Q6PzIEshx3S
5kYNcCypgtGOWSrtPGj/duJQLPnuS44k3jkIHMh4gNgpvU1+9mYgGMreyuJPTkKx
TxNhbijKfXCYYSPcy34pjtRTuKg24hNCVvdRZ5RYso2Dl8BwxrV8zkbxGKN+lakn
D/lmwn+0JhlveUPLar9CTHRxrZaEuNcCjeM99ZVaYyFi3AjZRyU=
=Epjk
-----END PGP SIGNATURE-----
--=-=-=--
