Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <4184E669-CB34-4CBA-B0F2-39F51D1EA8E8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_391001B6-FD2D-4B1A-BACF-D0576FB7BF5A";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 04/10] fs: add support for allowing applications to pass
 in write life time hints
Date: Tue, 13 Jun 2017 22:06:18 -0600
In-Reply-To: <1497412919-19400-5-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <1497412919-19400-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_391001B6-FD2D-4B1A-BACF-D0576FB7BF5A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 10:01 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Add four flags for the pwritev2(2) system call, allowing an =
application
> to give the kernel a hint about what on-media life times can be
> expected from a given write.
>=20
> The intent is for these values to be relative to each other, no
> absolute meaning should be attached to these flag names.
>=20
> Define IOCB flags to carry this information over, and finally
> transform them into the block defined stream values.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/read_write.c         |  9 ++++++++-
> include/linux/fs.h      | 12 ++++++++++++
> include/uapi/linux/fs.h | 10 ++++++++++
> 3 files changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 47c1d4484df9..a9b0c3125e0f 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -678,7 +678,7 @@ static ssize_t do_iter_readv_writev(struct file =
*filp, struct iov_iter *iter,
> 	struct kiocb kiocb;
> 	ssize_t ret;
>=20
> -	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
> +	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | =
RWF_WRITE_LIFE_MASK))
> 		return -EOPNOTSUPP;
>=20
> 	init_sync_kiocb(&kiocb, filp);
> @@ -688,6 +688,13 @@ static ssize_t do_iter_readv_writev(struct file =
*filp, struct iov_iter *iter,
> 		kiocb.ki_flags |=3D IOCB_DSYNC;
> 	if (flags & RWF_SYNC)
> 		kiocb.ki_flags |=3D (IOCB_DSYNC | IOCB_SYNC);
> +	if (flags & RWF_WRITE_LIFE_MASK) {
> +		struct inode *inode =3D file_inode(filp);
> +
> +		inode->i_stream =3D (flags & RWF_WRITE_LIFE_MASK) >>
> +					RWF_WRITE_LIFE_SHIFT;
> +		kiocb.ki_flags |=3D inode->i_stream << =
IOCB_WRITE_LIFE_SHIFT;
> +	}
> 	kiocb.ki_pos =3D *ppos;
>=20
> 	if (type =3D=3D READ)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 771e172d23d7..751a1046e87b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -269,6 +269,12 @@ struct writeback_control;
> #define IOCB_SYNC		(1 << 5)
> #define IOCB_WRITE		(1 << 6)
>=20
> +/*
> + * Steal 4-bits for stream information, this allows 16 valid streams
> + */
> +#define IOCB_WRITE_LIFE_SHIFT	7
> +#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9) | BIT(10))
> +
> struct kiocb {
> 	struct file		*ki_filp;
> 	loff_t			ki_pos;
> @@ -292,6 +298,12 @@ static inline void init_sync_kiocb(struct kiocb =
*kiocb, struct file *filp)
> 	};
> }
>=20
> +static inline int iocb_streamid(const struct kiocb *iocb)
> +{
> +	return (iocb->ki_flags & IOCB_WRITE_LIFE_MASK) >>
> +			IOCB_WRITE_LIFE_SHIFT;
> +}
> +
> /*
>  * "descriptor" for what we're up to with a read.
>  * This allows us to use the same read code yet
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 24e61a54feaa..8a7e6f26f6f5 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -361,4 +361,14 @@ struct fscrypt_key {
> #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
> #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
>=20
> +/*
> + * Data life time write flags, steal 4 bits for that
> + */
> +#define RWF_WRITE_LIFE_SHIFT		3
> +#define RWF_WRITE_LIFE_MASK		0x000000f0 /* 4 bits of stream =
ID */
> +#define RWF_WRITE_LIFE_SHORT		(1 << RWF_WRITE_LIFE_SHIFT)
> +#define RWF_WRITE_LIFE_MEDIUM		(2 << =
RWF_WRITE_LIFE_SHIFT)
> +#define RWF_WRITE_LIFE_LONG		(3 << RWF_WRITE_LIFE_SHIFT)
> +#define RWF_WRITE_LIFE_EXTREME		(4 << =
RWF_WRITE_LIFE_SHIFT)
> +
> #endif /* _UAPI_LINUX_FS_H */
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_391001B6-FD2D-4B1A-BACF-D0576FB7BF5A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQLY6pIg59Q01vtYRAixFAKDUfV+QvkQc9MDDoj0tJiD/2HRktACgvjV8
bs9YMZyiZWYECQxTzam3DY4=
=UVFv
-----END PGP SIGNATURE-----

--Apple-Mail=_391001B6-FD2D-4B1A-BACF-D0576FB7BF5A--
