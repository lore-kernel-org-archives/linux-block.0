Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <A255A993-9FD8-401E-A245-CAEA512D3538@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_71ECD0AB-E959-4B11-98A4-A576F3858C91";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 09/11] xfs: add support for passing in stream information
 for buffered writes
Date: Tue, 13 Jun 2017 13:40:49 -0600
In-Reply-To: <1497374123-15286-10-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-10-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_71ECD0AB-E959-4B11-98A4-A576F3858C91
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/xfs/xfs_aops.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 09af0f7cd55e..9770be0140ad 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -505,6 +505,7 @@ xfs_submit_ioend(
> 		return status;
> 	}
> 
> +	bio_set_streamid(ioend->io_bio, inode_streamid(ioend->io_inode));
> 	submit_bio(ioend->io_bio);
> 	return 0;
> }
> @@ -564,6 +565,7 @@ xfs_chain_bio(
> 	bio_chain(ioend->io_bio, new);
> 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
> 	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
> +	bio_set_streamid(ioend->io_bio, inode_streamid(ioend->io_inode));
> 	submit_bio(ioend->io_bio);
> 	ioend->io_bio = new;
> }
> --
> 2.7.4
> 


Cheers, Andreas






--Apple-Mail=_71ECD0AB-E959-4B11-98A4-A576F3858C91
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQD/BpIg59Q01vtYRAu+cAKDXMRbLR9TTcGJKjABGm6EO5V/diQCgmH4Q
BlwwTrFJcDl41nvIMpS7rf0=
=/pUT
-----END PGP SIGNATURE-----

--Apple-Mail=_71ECD0AB-E959-4B11-98A4-A576F3858C91--
