Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <151CE8A9-D38E-45C9-BDB9-4A83A89576F2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5214616F-8811-4820-B121-583E93E5DAFE";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 08/11] ext4: add support for passing in stream information
 for buffered writes
Date: Tue, 13 Jun 2017 13:40:20 -0600
In-Reply-To: <1497374123-15286-9-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-9-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_5214616F-8811-4820-B121-583E93E5DAFE
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/page-io.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 1a82138ba739..033b5bfa4e0b 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -350,6 +350,7 @@ void ext4_io_submit(struct ext4_io_submit *io)
> 		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
> 				  REQ_SYNC : 0;
> 		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
> +		bio_set_streamid(io->io_bio, inode_streamid(io->io_end->inode));
> 		submit_bio(io->io_bio);
> 	}
> 	io->io_bio = NULL;
> @@ -396,6 +397,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
> 		ret = io_submit_init_bio(io, bh);
> 		if (ret)
> 			return ret;
> +		bio_set_streamid(io->io_bio, inode_streamid(inode));
> 	}
> 	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
> 	if (ret != bh->b_size)
> --
> 2.7.4
> 


Cheers, Andreas






--Apple-Mail=_5214616F-8811-4820-B121-583E93E5DAFE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQD+lpIg59Q01vtYRAoT2AKCOdkojG2CLeArsib5S7WbI0bSTDQCfWMJ6
zeVjDZShzwFafGBIFM1LJNk=
=MHWd
-----END PGP SIGNATURE-----

--Apple-Mail=_5214616F-8811-4820-B121-583E93E5DAFE--
