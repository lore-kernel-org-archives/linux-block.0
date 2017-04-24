Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@infradead.org>
Date: Mon, 24 Apr 2017 13:16:21 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/11] block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()
In-Reply-To: <CACVXFVMkX6X36=3mU7cXmbLA6HLASvk402DWL772=d7ihWNhMw@mail.gmail.com>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266673048.27388.6882396367486800999.stgit@noble> <20170421113408.GJ12523@infradead.org> <CACVXFVMkX6X36=3mU7cXmbLA6HLASvk402DWL772=d7ihWNhMw@mail.gmail.com>
Message-ID: <878tmqqyuy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Fri, Apr 21 2017, Ming Lei wrote:

> On Fri, Apr 21, 2017 at 7:34 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Apr 20, 2017 at 03:38:50PM +1000, NeilBrown wrote:
>>> blk_bio_segment_split() makes sure bios have no more than
>>> BIO_MAX_PAGES entries in the bi_io_vec.
>>> This was done because bio_clone_bioset() (when given a
>>> mempool bioset) could not handle larger io_vecs.
>>>
>>> No driver uses bio_clone_bioset() any more, they all
>>> use bio_clone_fast() if anything, and bio_clone_fast()
>>> doesn't clone the bi_io_vec.
>>
>> Hmm.  From Jens tree:
>>
>> drivers/lightnvm/pblk-read.c:           int_bio = bio_clone_bioset(bio, GFP_KERNEL, fs_bio_set);
>> drivers/md/raid1.c:                             mbio = bio_clone_bioset_partial(bio, GFP_NOIO,
>> drivers/md/raid1.c:                             mbio = bio_clone_bioset_partial(bio, GFP_NOIO,
>
> Btrfs use bio_clone_bioset() too:
>
>      fs/btrfs/extent_io.c:2703:      new = bio_clone_bioset(bio,
> gfp_mask, btrfs_bioset);
>

btrfs is a filesystem, not a driver.  So it doesn't count.
The bios it uses were not yet processed by blk_bio_segment_split(),
so changes there cannot be relevant to btrfs.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlj9bgUACgkQOeye3VZi
gbkexg//Vu0MbnyaDyQRsfjC0UmYjsGqYCtnyV6DfdpCeu4yQs3NuyVh7VdZMER8
p4h6DP58l2+ZnLCH3qEiDgfsYmkXM7dM6U9bt4Zs2bxTjYiclLTCSS7fORJihA1h
XcldClZABiHs3FntbUhEwQJshI4t7mmcKsRr5TZBEuAPYs90rFk+1dSd2zU8ZBuG
agoJBnARRCqE07aMiQdhdLucu6VsUvYwMTbQeFnpdySHvBtV//1NIakNWZgvZFeV
OdcZWyMEaSGypj9gCp3N+9DzdL8Te+vCWJS7bd7auqayg//NOW9ISlNUChGVUIFF
lluLSZQUUR76yw3pkeexYRMQ/79+16SUENiF07/2TjAQOTGwcrQRVu58cGvTdnBK
i/Y3PyuzUn2NA0GKF96j1egXNQj1cV460G9jHXbXYRmqjHwGovR0rJWc8lHlicMB
qysBYI7Qd/qYh7UNNn4MtfB26sIgaLIteWPWzxCaptD0eKwYJj4CWmD7KUy8eXEd
9xOe5Jx6lgvDOLpspG2WLZf4fH6th1X9hekjUAgvIC5ezmtcc/Sz03ey7JZDmCPD
YxFYLCfCZJJig1ygfykX4gd0fYuNhlQ/YXW7h0Bzt0wJUzjsM0PfM+EyHSKY6254
8gk2jpjx3JvtY+4OD+GWW+aKq6jXvhej8ts0CCHa6N0vxfltZcg=
=e2/g
-----END PGP SIGNATURE-----
--=-=-=--
