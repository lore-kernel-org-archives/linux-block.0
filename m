Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <C0001DC5-23C6-4B1E-B369-B72D1B631D5C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A54F8C68-4F94-4037-952F-ED05CB13C621";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 04/11] add support for an inode to carry stream related
 data
Date: Tue, 13 Jun 2017 13:24:20 -0600
In-Reply-To: <1497374123-15286-5-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_A54F8C68-4F94-4037-952F-ED05CB13C621
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> No functional changes in this patch, just in preparation for
> allowing applications to pass in hints about data life times
> for writes.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This is fine from the POV of passing the stream ID unchanged down the =
stack.
If we really wanted to limit the ID to a 16-bit value, the i_stream =
could fit
into a few 16-bit holes in struct inode, to avoid increasing its size.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/inode.c         |  1 +
> include/linux/fs.h | 10 ++++++++++
> 2 files changed, 11 insertions(+)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index db5914783a71..c911a2b9b5a4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -149,6 +149,7 @@ int inode_init_always(struct super_block *sb, =
struct inode *inode)
> 	inode->i_blocks =3D 0;
> 	inode->i_bytes =3D 0;
> 	inode->i_generation =3D 0;
> +	inode->i_stream =3D WRITE_LIFE_UNKNOWN;
> 	inode->i_pipe =3D NULL;
> 	inode->i_bdev =3D NULL;
> 	inode->i_cdev =3D NULL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 803e5a9b2654..bb8c246eeda8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -30,6 +30,7 @@
> #include <linux/percpu-rwsem.h>
> #include <linux/workqueue.h>
> #include <linux/delayed_call.h>
> +#include <linux/blk_types.h>
>=20
> #include <asm/byteorder.h>
> #include <uapi/linux/fs.h>
> @@ -629,6 +630,7 @@ struct inode {
> #ifdef CONFIG_IMA
> 	atomic_t		i_readcount; /* struct files open RO */
> #endif
> +	unsigned int		i_stream;
> 	const struct file_operations	*i_fop;	/* former =
->i_op->default_file_ops */
> 	struct file_lock_context	*i_flctx;
> 	struct address_space	i_data;
> @@ -655,6 +657,14 @@ struct inode {
> 	void			*i_private; /* fs or device private =
pointer */
> };
>=20
> +static inline unsigned int inode_streamid(struct inode *inode)
> +{
> +	if (inode)
> +		return inode->i_stream;
> +
> +	return 0;
> +}
> +
> static inline unsigned int i_blocksize(const struct inode *node)
> {
> 	return (1 << node->i_blkbits);
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_A54F8C68-4F94-4037-952F-ED05CB13C621
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQDvkpIg59Q01vtYRAkm4AJ9dIrmgtn53S/0DmX5gD4A1MMo+3gCdGYKq
KLny0tPm3xT36cad32SRNxM=
=JxHZ
-----END PGP SIGNATURE-----

--Apple-Mail=_A54F8C68-4F94-4037-952F-ED05CB13C621--
