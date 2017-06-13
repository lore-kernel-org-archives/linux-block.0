Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33438 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdFMTBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2017 15:01:09 -0400
Received: by mail-io0-f194.google.com with SMTP id j200so9534285ioe.0
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2017 12:01:08 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <F9C09313-AEAA-4BB7-B926-871DBB4A62B8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_001E9E20-CAA2-4953-B0A6-1E2D5F112CA6";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/11] block: add support for carrying stream information
 in a bio
Date: Tue, 13 Jun 2017 13:01:02 -0600
In-Reply-To: <1497374123-15286-2-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-2-git-send-email-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_001E9E20-CAA2-4953-B0A6-1E2D5F112CA6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> No functional changes in this patch, but it allows each bio to
> carry a stream ID and disallows merging of bio's with different
> stream IDs.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> block/bio.c               |  2 ++
> block/blk-merge.c         | 14 ++++++++++++++
> include/linux/blk_types.h | 17 +++++++++++++++++
> 3 files changed, 33 insertions(+)
>=20
> diff --git a/block/bio.c b/block/bio.c
> index 888e7801c638..77f4be1f7428 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -595,6 +595,7 @@ void __bio_clone_fast(struct bio *bio, struct bio =
*bio_src)
> 	bio->bi_opf =3D bio_src->bi_opf;
> 	bio->bi_iter =3D bio_src->bi_iter;
> 	bio->bi_io_vec =3D bio_src->bi_io_vec;
> +	bio->bi_stream =3D bio_src->bi_stream;
>=20
> 	bio_clone_blkcg_association(bio, bio_src);
> }
> @@ -678,6 +679,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, =
gfp_t gfp_mask,
> 	bio->bi_opf		=3D bio_src->bi_opf;
> 	bio->bi_iter.bi_sector	=3D bio_src->bi_iter.bi_sector;
> 	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
> +	bio->bi_stream		=3D bio_src->bi_stream;
>=20
> 	switch (bio_op(bio)) {
> 	case REQ_OP_DISCARD:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3990ae406341..28998acdd675 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -693,6 +693,13 @@ static struct request *attempt_merge(struct =
request_queue *q,
> 		return NULL;
>=20
> 	/*
> +	 * Don't allow merge of different streams, or for a stream with
> +	 * non-stream IO.
> +	 */
> +	if (req->bio->bi_stream !=3D next->bio->bi_stream)
> +		return NULL;
> +
> +	/*
> 	 * If we are allowed to merge, then append bio list
> 	 * from next to rq and release next. merge_requests_fn
> 	 * will have updated segment counts, update sector
> @@ -811,6 +818,13 @@ bool blk_rq_merge_ok(struct request *rq, struct =
bio *bio)
> 	    !blk_write_same_mergeable(rq->bio, bio))
> 		return false;
>=20
> +	/*
> +	 * Don't allow merge of different streams, or for a stream with
> +	 * non-stream IO.
> +	 */
> +	if (rq->bio->bi_stream !=3D bio->bi_stream)
> +		return false;
> +
> 	return true;
> }
>=20
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 61339bc44400..1940876a7fa7 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -36,6 +36,8 @@ struct bio {
> 	unsigned short		bi_flags;	/* status, etc and bvec =
pool number */
> 	unsigned short		bi_ioprio;
>=20
> +	unsigned int		bi_stream;	/* write life time hint =
*/
> +
> 	struct bvec_iter	bi_iter;
>=20
> 	/* Number of segments in this BIO after
> @@ -312,4 +314,19 @@ struct blk_rq_stat {
> 	u64 batch;
> };
>=20
> +static inline void bio_set_streamid(struct bio *bio, unsigned int =
stream)
> +{
> +	bio->bi_stream =3D stream;
> +}
> +
> +static inline bool bio_stream_valid(struct bio *bio)
> +{
> +	return bio->bi_stream !=3D 0;
> +}
> +
> +static inline unsigned int bio_stream(struct bio *bio)
> +{
> +	return bio->bi_stream;
> +}
> +
> #endif /* __LINUX_BLK_TYPES_H */
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_001E9E20-CAA2-4953-B0A6-1E2D5F112CA6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQDZupIg59Q01vtYRAqDjAJ44/bFue12S0yWUy2S26SrWv8mJTQCeP/E2
tCarc2jpQK10OHkYXV+h59Q=
=XMtM
-----END PGP SIGNATURE-----

--Apple-Mail=_001E9E20-CAA2-4953-B0A6-1E2D5F112CA6--
