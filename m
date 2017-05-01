Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Mon, 01 May 2017 15:00:51 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
In-Reply-To: <20170424151013.GA17867@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266672858.27388.11409778158413625707.stgit@noble> <20170421112458.GB12523@infradead.org> <87h91er2t6.fsf@notabene.neil.brown.name> <20170424151013.GA17867@infradead.org>
Message-ID: <87tw55qigs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24 2017, Christoph Hellwig wrote:

> On Mon, Apr 24, 2017 at 11:51:01AM +1000, NeilBrown wrote:
>>=20
>> I was following the existing practice exemplified by
>> bioset_create_nobvec().
>
> Which is pretty ugly to start with..

That is a matter of personal taste.
As such, it is up to the maintainer to change it if they want it
changed.

>
>> By not changing the signature of the function, I can avoid touching
>> quite a few places where it is called.
>
> There are 13 callers of bioset_create and one caller of
> bioset_create_nobvec, and your series touches many of those.
>
> So just adding a flags argument to bioset_create and passing
> BIOSET_NEED_BVECS and BIOSET_NEED_RESUER flags to it doesn't seem
> to much of an effort, and it's going to create a much nicer and easier
> to extend interface.

If someone else submitted a patch to discard bioset_create_nobvec in
favour of BIOSET_NEED_BVECS and got it accepted, then I would rebase my
series on that.  As it is, I'm basing my patches on the style currently
present in the tree.

Of course, if Jens says he'll only take my patches if I change to style
to match your preference, I'll do that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkGwQQACgkQOeye3VZi
gbk2pg/+PSGKrhX4uimNwWrSsHuwTJxgoby5XGC9N/dpe7xXEFC9hwMY35xq6za7
t8OTLLmhta6T5PITLm4gPDZzZpyW6M1E5CJr4U7EGgiD04XrD8vRFK96rmOv+hd0
g7iYLrqhdqsMZstkUKcR7si/3HyE9XVKzvgfqJ4FiQBFduLk7G209yMtyWtEVY0z
F/uBzdd3bDTVQFxlOZhQA+9UvjbgCq++93Y6CgA7YX97caHTBDe0wcP5CCvt4Pa6
dETFSSE/9upXdMUuCWtM2Xdq4ar5XeNSBsYsX/hHsaHsBb6Wcd04ifgcBm9dRoXZ
JTrFSPNNYsQ8PgWt2ucwJ6XrOGGImQnDXdGRjiJyM9Iu03WHM8xM3hkfsZ9fWCzT
o7gm2ee+ZBD90LPXbSaCNTe5NFh6dnvmiC+UU4+Uv29N2FlJIuHOBLjI59bZ9ZFF
bxleq594CP1apTY/sZ3OUdbRqEpbU/LayAJdxuUJBn30N/SeyEkNUluuZw2oxRFu
gXzTIezxdRkSSu3e7Xk1iltnErXIhLHHMSyP5r6UmAYxX20jsBPScQ4SrSJs98qm
EbLCcTIxux4g9owj2oRRpwYABByz3mDREnqZ4TcMnbVfFQ9JPII/TpnqDWAOm4so
PAoCpWpvsyk/LymkKWqjMp3i/rSBS5sm4TsopN4rfBCpqXC8v8Q=
=5eIb
-----END PGP SIGNATURE-----
--=-=-=--
