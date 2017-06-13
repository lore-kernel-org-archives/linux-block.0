Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <6B980DF8-E869-49A5-AECC-EF2F27EE4842@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7B012E7B-2122-40E3-8D63-81D47A37E822";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 10/11] btrfs: add support for passing in stream
 information for buffered writes
Date: Tue, 13 Jun 2017 13:41:16 -0600
In-Reply-To: <1497374123-15286-11-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-11-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_7B012E7B-2122-40E3-8D63-81D47A37E822
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/btrfs/extent_io.c | 1 +
> fs/btrfs/inode.c     | 1 +
> 2 files changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d3619e010005..b245085e8f10 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2827,6 +2827,7 @@ static int submit_extent_page(int op, int =
op_flags, struct extent_io_tree *tree,
> 	bio->bi_end_io =3D end_io_func;
> 	bio->bi_private =3D tree;
> 	bio_set_op_attrs(bio, op, op_flags);
> +	bio_set_streamid(bio, inode_streamid(page->mapping->host));
> 	if (wbc) {
> 		wbc_init_bio(wbc, bio);
> 		wbc_account_io(wbc, page, page_size);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ef3c98c527c1..db0558a19f65 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8608,6 +8608,7 @@ static void btrfs_submit_direct(struct bio =
*dio_bio, struct inode *inode,
> 	atomic_set(&dip->pending_bios, 0);
> 	btrfs_bio =3D btrfs_io_bio(io_bio);
> 	btrfs_bio->logical =3D file_offset;
> +	bio_set_streamid(io_bio, bio_stream(dio_bio));
>=20
> 	if (write) {
> 		io_bio->bi_end_io =3D btrfs_endio_direct_write;
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_7B012E7B-2122-40E3-8D63-81D47A37E822
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQD/cpIg59Q01vtYRArhwAJ9jVGForteUuQ0Y3v9kV077qY0O+wCgiR8B
ugj8DiY7IZPYfhcyOWVVXCM=
=ausP
-----END PGP SIGNATURE-----

--Apple-Mail=_7B012E7B-2122-40E3-8D63-81D47A37E822--
