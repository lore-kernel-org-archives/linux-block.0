Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <73C2B2DD-612C-451B-BDD9-B7BAAD497D28@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1FB7207D-4964-46DF-A862-4AC612918B2C";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 05/11] add support for allowing applications to pass in
 write life time hints
Date: Tue, 13 Jun 2017 13:36:36 -0600
In-Reply-To: <1497374123-15286-6-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-6-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_1FB7207D-4964-46DF-A862-4AC612918B2C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
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
> ---
> fs/read_write.c         | 17 ++++++++++++++++-
> include/linux/fs.h      | 18 ++++++++++++++++++
> include/uapi/linux/fs.h |  4 ++++
> 3 files changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 47c1d4484df9..1734728aa48b 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -678,7 +678,9 @@ static ssize_t do_iter_readv_writev(struct file =
*filp, struct iov_iter *iter,
> 	struct kiocb kiocb;
> 	ssize_t ret;
>=20
> -	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
> +	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | =
RWF_WRITE_LIFE_SHORT |
> +			RWF_WRITE_LIFE_MEDIUM | RWF_WRITE_LIFE_LONG |
> +			RWF_WRITE_LIFE_EXTREME))
> 		return -EOPNOTSUPP;

Since this is essentially just a 4-bit mask, which also works fine if =
the stream
ID is an arbitrary value, it would be more clear to just define a mask =
like
RWF_WRITE_LIFE_MASK that covers these bits instead of spelling out =
individual bits.

>=20
> 	init_sync_kiocb(&kiocb, filp);
> @@ -688,6 +690,19 @@ static ssize_t do_iter_readv_writev(struct file =
*filp, struct iov_iter *iter,
> 		kiocb.ki_flags |=3D IOCB_DSYNC;
> 	if (flags & RWF_SYNC)
> 		kiocb.ki_flags |=3D (IOCB_DSYNC | IOCB_SYNC);
> +	if (flags & RWF_WRITE_LIFE_SHORT) {
> +		kiocb.ki_flags |=3D IOCB_WRITE_LIFE_SHORT;
> +		file_inode(filp)->i_stream =3D WRITE_LIFE_SHORT;
> +	} else if (flags & RWF_WRITE_LIFE_MEDIUM) {
> +		kiocb.ki_flags |=3D IOCB_WRITE_LIFE_MEDIUM;
> +		file_inode(filp)->i_stream =3D WRITE_LIFE_MEDIUM;
> +	} else if (flags & RWF_WRITE_LIFE_LONG) {
> +		kiocb.ki_flags |=3D IOCB_WRITE_LIFE_LONG;
> +		file_inode(filp)->i_stream =3D WRITE_LIFE_LONG;
> +	} else if (flags & RWF_WRITE_LIFE_EXTREME) {
> +		kiocb.ki_flags |=3D IOCB_WRITE_LIFE_EXTREME;
> +		file_inode(filp)->i_stream =3D WRITE_LIFE_EXTREME;
> +	}

This should just pass all of the bits through:

	if (flags & RWF_WRITE_LIFE_MASK) {
		file_inode(filp)->i_stream =3D
			((flags & RWF_WRITE_LIFE_MASK) >> =
RWF_WRITE_LIFE_SHIFT;
		kiocb.ki_flags |=3D
			file_inode(filp)->i_stream << =
IOCB_WRITE_LIFE_SHIFT;
	}

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bb8c246eeda8..7f542e0b0e17 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -269,6 +269,10 @@ struct writeback_control;
> #define IOCB_DSYNC		(1 << 4)
> #define IOCB_SYNC		(1 << 5)
> #define IOCB_WRITE		(1 << 6)
> +#define IOCB_WRITE_LIFE_SHORT	(1 << 7)
> +#define IOCB_WRITE_LIFE_MEDIUM	(1 << 8)
> +#define IOCB_WRITE_LIFE_LONG	(1 << 9)
> +#define IOCB_WRITE_LIFE_EXTREME	(1 << 10)

#define IOCB_WRITE_LIFE_SHIFT	7
#define IOCB_WRITE_LIFE_MASK	(0xf << IOCB_WRITE_LIFE_SHIFT)

or if you want to make it clear which bits are actually used, either:

#define IOCB_WRITE_LIFE_MASK	((1 << 7) | (1 << 8) | (1 << 9) | (1 =
<<10))

or

#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9) | BIT(10))

> @@ -293,6 +297,20 @@ static inline void init_sync_kiocb(struct kiocb =
*kiocb, struct file *filp)
> 	};
> }
>=20
> +static inline int iocb_streamid(const struct kiocb *iocb)
> +{
> +	if (iocb->ki_flags & IOCB_WRITE_LIFE_SHORT)
> +		return WRITE_LIFE_SHORT;
> +	else if (iocb->ki_flags & IOCB_WRITE_LIFE_MEDIUM)
> +		return WRITE_LIFE_MEDIUM;
> +	else if (iocb->ki_flags & IOCB_WRITE_LIFE_LONG)
> +		return WRITE_LIFE_LONG;
> +	else if (iocb->ki_flags & IOCB_WRITE_LIFE_EXTREME)
> +		return WRITE_LIFE_EXTREME;
> +
> +	return WRITE_LIFE_UNKNOWN;
> +}
> +
> /*
>  * "descriptor" for what we're up to with a read.
>  * This allows us to use the same read code yet
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 24e61a54feaa..34145b29657e 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -360,5 +360,9 @@ struct fscrypt_key {
> #define RWF_HIPRI			0x00000001 /* high priority =
request, poll if possible */
> #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
> #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
> +#define RWF_WRITE_LIFE_SHORT		0x00000008 /* short life time =
write */
> +#define RWF_WRITE_LIFE_MEDIUM		0x00000010 /* medium =
life time write */
> +#define RWF_WRITE_LIFE_LONG		0x00000020 /* long life time =
write */
> +#define RWF_WRITE_LIFE_EXTREME		0x00000040 /* extremely =
long life time write */

#define RWF_WRITE_LIFE_SHIFT		3
#define RWF_WRITE_LIFE_MASK		(0xf << RWF_WRITE_LIFE_SHIFT)

or

#define RWF_WRITE_LIFE_MASK		0x00000078

Alternately, just leave a hole in the RWF flags and use

#define RWF_WRITE_LIFE_SHIFT		4
#define	RWF_WRITE_LIFE_MASK		0x000000f0

>=20
> #endif /* _UAPI_LINUX_FS_H */
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_1FB7207D-4964-46DF-A862-4AC612918B2C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQD7EpIg59Q01vtYRArJoAKC9OpTwUa9NWwjmUdLailAil6jpFQCgs64W
cOI3mATcE/f3UddwcWfkYG4=
=p9uK
-----END PGP SIGNATURE-----

--Apple-Mail=_1FB7207D-4964-46DF-A862-4AC612918B2C--
