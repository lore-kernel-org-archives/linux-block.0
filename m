Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <23BD0670-4097-4D74-9499-39771E69CD5F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3BF019C2-37E9-433A-81AA-ECF91B82DA29";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 06/11] fs: add O_DIRECT support for sending down bio
 stream information
Date: Tue, 13 Jun 2017 13:38:27 -0600
In-Reply-To: <1497374123-15286-7-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-7-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_3BF019C2-37E9-433A-81AA-ECF91B82DA29
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This patch is itself fine, if iocb_streamid() is fixed to pass the ID
through without selecting only a single bit of the ID.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/block_dev.c | 2 ++
> fs/direct-io.c | 2 ++
> fs/iomap.c     | 1 +
> 3 files changed, 5 insertions(+)
>=20
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 519599dddd36..284b8a786283 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -227,6 +227,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, =
struct iov_iter *iter,
> 	bio.bi_iter.bi_sector =3D pos >> 9;
> 	bio.bi_private =3D current;
> 	bio.bi_end_io =3D blkdev_bio_end_io_simple;
> +	bio.bi_stream =3D iocb_streamid(iocb);
>=20
> 	ret =3D bio_iov_iter_get_pages(&bio, iter);
> 	if (unlikely(ret))
> @@ -360,6 +361,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct =
iov_iter *iter, int nr_pages)
> 		bio->bi_iter.bi_sector =3D pos >> 9;
> 		bio->bi_private =3D dio;
> 		bio->bi_end_io =3D blkdev_bio_end_io;
> +		bio->bi_stream =3D iocb_streamid(iocb);
>=20
> 		ret =3D bio_iov_iter_get_pages(bio, iter);
> 		if (unlikely(ret)) {
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index a04ebea77de8..c9c8b9fd4329 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -386,6 +386,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit =
*sdio,
> 	else
> 		bio->bi_end_io =3D dio_bio_end_io;
>=20
> +	bio->bi_stream =3D iocb_streamid(dio->iocb);
> +
> 	sdio->bio =3D bio;
> 	sdio->logical_offset_in_bio =3D sdio->cur_page_fs_offset;
> }
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 4b10892967a5..fa7d29632fbc 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -804,6 +804,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, =
loff_t length,
>=20
> 		if (dio->flags & IOMAP_DIO_WRITE) {
> 			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | =
REQ_IDLE);
> +			bio_set_streamid(bio, inode_streamid(inode));
> 			task_io_account_write(bio->bi_iter.bi_size);
> 		} else {
> 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_3BF019C2-37E9-433A-81AA-ECF91B82DA29
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQD80pIg59Q01vtYRAlX6AJ4nYluZVK3nFgp7SQ9d4GOfkkfAaACcDjB7
6rZL+FwLoPblDS4YwKiBnb8=
=ILfx
-----END PGP SIGNATURE-----

--Apple-Mail=_3BF019C2-37E9-433A-81AA-ECF91B82DA29--
