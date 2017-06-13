Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9558EB67-454B-4D1E-8353-D56573BB189C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B36EE35E-DC91-4FE4-A1ED-C61D8614853F";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 07/11] add support for buffered writeback to pass down
 stream information
Date: Tue, 13 Jun 2017 13:39:21 -0600
In-Reply-To: <1497374123-15286-8-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-8-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_B36EE35E-DC91-4FE4-A1ED-C61D8614853F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/buffer.c | 14 +++++++++-----
> fs/mpage.c  |  1 +
> 2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 161be58c5cb0..8324c24751ca 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -49,7 +49,7 @@
>=20
> static int fsync_buffers_list(spinlock_t *lock, struct list_head =
*list);
> static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> -			 struct writeback_control *wbc);
> +			 unsigned int stream, struct writeback_control =
*wbc);
>=20
> #define BH_ENTRY(list) list_entry((list), struct buffer_head, =
b_assoc_buffers)
>=20
> @@ -1829,7 +1829,8 @@ int __block_write_full_page(struct inode *inode, =
struct page *page,
> 	do {
> 		struct buffer_head *next =3D bh->b_this_page;
> 		if (buffer_async_write(bh)) {
> -			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, =
wbc);
> +			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
> +					inode_streamid(inode), wbc);
> 			nr_underway++;
> 		}
> 		bh =3D next;
> @@ -1883,7 +1884,8 @@ int __block_write_full_page(struct inode *inode, =
struct page *page,
> 		struct buffer_head *next =3D bh->b_this_page;
> 		if (buffer_async_write(bh)) {
> 			clear_buffer_dirty(bh);
> -			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, =
wbc);
> +			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
> +					inode_streamid(inode), wbc);
> 			nr_underway++;
> 		}
> 		bh =3D next;
> @@ -3091,7 +3093,7 @@ void guard_bio_eod(int op, struct bio *bio)
> }
>=20
> static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> -			 struct writeback_control *wbc)
> +			 unsigned int stream, struct writeback_control =
*wbc)
> {
> 	struct bio *bio;
>=20
> @@ -3130,6 +3132,8 @@ static int submit_bh_wbc(int op, int op_flags, =
struct buffer_head *bh,
> 	/* Take care of bh's that straddle the end of the device */
> 	guard_bio_eod(op, bio);
>=20
> +	bio_set_streamid(bio, stream);
> +
> 	if (buffer_meta(bh))
> 		op_flags |=3D REQ_META;
> 	if (buffer_prio(bh))
> @@ -3142,7 +3146,7 @@ static int submit_bh_wbc(int op, int op_flags, =
struct buffer_head *bh,
>=20
> int submit_bh(int op, int op_flags, struct buffer_head *bh)
> {
> -	return submit_bh_wbc(op, op_flags, bh, NULL);
> +	return submit_bh_wbc(op, op_flags, bh, 0, NULL);
> }
> EXPORT_SYMBOL(submit_bh);
>=20
> diff --git a/fs/mpage.c b/fs/mpage.c
> index baff8f820c29..a9d40c0c053e 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -614,6 +614,7 @@ static int __mpage_writepage(struct page *page, =
struct writeback_control *wbc,
> 			goto confused;
>=20
> 		wbc_init_bio(wbc, bio);
> +		bio_set_streamid(bio, inode_streamid(inode));
> 	}
>=20
> 	/*
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_B36EE35E-DC91-4FE4-A1ED-C61D8614853F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQD9ppIg59Q01vtYRAkWaAJ95dZWVHziVC/m5BAXIgQV3/es49ACfRmJb
VzaUa3U2a7wR3P/EOy1B38g=
=Ehq6
-----END PGP SIGNATURE-----

--Apple-Mail=_B36EE35E-DC91-4FE4-A1ED-C61D8614853F--
