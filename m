Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1CAC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0343D20879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cK5Ml9J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfCYFzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:55:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45990 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfCYFzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:55:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so6376686edd.12
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 22:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=I6IGHAe/upWv6d2po6c9JvCS2oFy5bYQSX5qwF/lz3o=;
        b=cK5Ml9J0E8X6Yq2sG8iOQx8plhYw4a8OkHQmaYcVAKOosDhLgdT1tGRzpg5PVo6LyJ
         cCVFfuAkFU7EaIRF7QUdRifa5SRL3/LcUKBiVbsMNF+Cu3Fh40gbRNUYLz0THGn6BAul
         ZYVrrba0DWM3bbUXGJiied7RNk0sBFRkV3uivdCXmKndtkiOWwJr6C5bmX//DLrnDRyS
         S1avaXrqtJNNeC6sx7pvaeF1cygrU+aw9wNk3xlAJsQ7JdupLn+reTwuci3aoSPUkPNp
         McX1X5Oy61cmmhHztt718qYfkk8Gp8VokAaOQivJXxT+qhnnGoVBXtJ+Ql4zK8A8bVGR
         5/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=I6IGHAe/upWv6d2po6c9JvCS2oFy5bYQSX5qwF/lz3o=;
        b=CjUAMhak7Zjz7VdVP7Sz1ntbDao8zbsxOwvIvnhFksBAF1Uesb1wTxtGuaT6ct6MWZ
         zddturQ2UGPo/CFGV8v95xx/r6QHfwV57ji+qyJuZvL9E6iJgdp3Uh1Va80R9nbbvrRI
         RgwhibGuIvBh8E+rPoZSFORlB3DizkTHwbatGky/TnXGSvkvtlhZ9xdnuD+djWRuszi2
         2s9UTfpX37ZjjEw/H0AEYSCG8gL+2l27r6b+gFK4u368Z+7kv8d0UL4q6fx5lzZUVSja
         pv86KXe3oIV58pEZDMPEybanMpwCw19LATBM4BFjCUHZmFBypMGzzAiHgJ7gceUf4X/h
         BsiQ==
X-Gm-Message-State: APjAAAU7kd3hSM/4+g/tuInwhdgLmHmY0nuJYcUvh9hGpAvezpJ69aDs
        /juy6ZckVmZjCnO/AE1O1K5zFd8RUC0=
X-Google-Smtp-Source: APXvYqx4wLZiOMBBOm1yE+660+cvITE9a6Uz/A7F+alm2gYNYnqK90ghfNhvTFAVcZCFBuStiavwlA==
X-Received: by 2002:a50:b13b:: with SMTP id k56mr14587706edd.89.1553493310805;
        Sun, 24 Mar 2019 22:55:10 -0700 (PDT)
Received: from [172.30.99.70] ([37.120.153.227])
        by smtp.gmail.com with ESMTPSA id j17sm3682146eda.70.2019.03.24.22.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 22:55:10 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <702309E2-13D8-4BCF-9964-552DECFA127C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CD05AB14-A821-4A7D-98A6-4A17B1A6C33E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 02/16] lightnvm: pblk: IO path reorganization
Date:   Mon, 25 Mar 2019 13:55:03 +0800
In-Reply-To: <20190322144843.9602-3-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-3-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_CD05AB14-A821-4A7D-98A6-4A17B1A6C33E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch is made in order to prepare read path for new approach to
> partial read handling (which is needed for multi-page bvec handling)
> The most important change is to move the handling of completed and
> failed bio from the pblk_make_rq() to particular read and write
> functions. This is needed, since after partial read path changes,
> sometimes completed/failed bio will be different from original one, so
> we cannot do this any longer in pblk_make_rq(). Other changes are
> small read path refactor in order to reduce the size of another patch
> with partial read changes. Generally the goal of this patch is not to
> change the functionality, but just to prepare the code for the
> following changes.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-cache.c |  7 ++--
> drivers/lightnvm/pblk-init.c  | 14 ++------
> drivers/lightnvm/pblk-read.c  | 83 =
++++++++++++++++++++-----------------------
> drivers/lightnvm/pblk.h       |  4 +--
> 4 files changed, 47 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-cache.c =
b/drivers/lightnvm/pblk-cache.c
> index c9fa26f..d2a3683 100644
> --- a/drivers/lightnvm/pblk-cache.c
> +++ b/drivers/lightnvm/pblk-cache.c
> @@ -18,7 +18,7 @@
>=20
> #include "pblk.h"
>=20
> -int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned =
long flags)
> +void pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned =
long flags)
> {
> 	struct request_queue *q =3D pblk->dev->q;
> 	struct pblk_w_ctx w_ctx;
> @@ -43,6 +43,7 @@ int pblk_write_to_cache(struct pblk *pblk, struct =
bio *bio, unsigned long flags)
> 		goto retry;
> 	case NVM_IO_ERR:
> 		pblk_pipeline_stop(pblk);
> +		bio_io_error(bio);
> 		goto out;
> 	}
>=20
> @@ -79,7 +80,9 @@ int pblk_write_to_cache(struct pblk *pblk, struct =
bio *bio, unsigned long flags)
> out:
> 	generic_end_io_acct(q, REQ_OP_WRITE, &pblk->disk->part0, =
start_time);
> 	pblk_write_should_kick(pblk);
> -	return ret;
> +
> +	if (ret =3D=3D NVM_IO_DONE)
> +		bio_endio(bio);
> }
>=20
> /*
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index e2e1193..4211cd1 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -50,7 +50,6 @@ struct bio_set pblk_bio_set;
> static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
> {
> 	struct pblk *pblk =3D q->queuedata;
> -	int ret;
>=20
> 	if (bio_op(bio) =3D=3D REQ_OP_DISCARD) {
> 		pblk_discard(pblk, bio);
> @@ -65,7 +64,7 @@ static blk_qc_t pblk_make_rq(struct request_queue =
*q, struct bio *bio)
> 	 */
> 	if (bio_data_dir(bio) =3D=3D READ) {
> 		blk_queue_split(q, &bio);
> -		ret =3D pblk_submit_read(pblk, bio);
> +		pblk_submit_read(pblk, bio);
> 	} else {
> 		/* Prevent deadlock in the case of a modest LUN =
configuration
> 		 * and large user I/Os. Unless stalled, the rate limiter
> @@ -74,16 +73,7 @@ static blk_qc_t pblk_make_rq(struct request_queue =
*q, struct bio *bio)
> 		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
> 			blk_queue_split(q, &bio);
>=20
> -		ret =3D pblk_write_to_cache(pblk, bio, =
PBLK_IOTYPE_USER);
> -	}
> -
> -	switch (ret) {
> -	case NVM_IO_ERR:
> -		bio_io_error(bio);
> -		break;
> -	case NVM_IO_DONE:
> -		bio_endio(bio);
> -		break;
> +		pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
> 	}
>=20
> 	return BLK_QC_T_NONE;
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 6569746..597fe6d 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -179,7 +179,8 @@ static void pblk_end_user_read(struct bio *bio, =
int error)
> {
> 	if (error && error !=3D NVM_RSP_WARN_HIGHECC)
> 		bio_io_error(bio);
> -	bio_endio(bio);
> +	else
> +		bio_endio(bio);
> }
>=20
> static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
> @@ -383,7 +384,6 @@ static int pblk_partial_read_bio(struct pblk =
*pblk, struct nvm_rq *rqd,
>=20
> 	/* Free allocated pages in new bio */
> 	pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
> -	__pblk_end_io_read(pblk, rqd, false);
> 	return NVM_IO_ERR;
> }
>=20
> @@ -428,7 +428,7 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> 	}
> }
>=20
> -int pblk_submit_read(struct pblk *pblk, struct bio *bio)
> +void pblk_submit_read(struct pblk *pblk, struct bio *bio)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct request_queue *q =3D dev->q;
> @@ -436,9 +436,9 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	unsigned int nr_secs =3D pblk_get_secs(bio);
> 	struct pblk_g_ctx *r_ctx;
> 	struct nvm_rq *rqd;
> +	struct bio *int_bio;
> 	unsigned int bio_init_idx;
> 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
> -	int ret =3D NVM_IO_ERR;
>=20
> 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
> 			      &pblk->disk->part0);
> @@ -449,74 +449,67 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
>=20
> 	rqd->opcode =3D NVM_OP_PREAD;
> 	rqd->nr_ppas =3D nr_secs;
> -	rqd->bio =3D NULL; /* cloned bio if needed */
> 	rqd->private =3D pblk;
> 	rqd->end_io =3D pblk_end_io_read;
>=20
> 	r_ctx =3D nvm_rq_to_pdu(rqd);
> 	r_ctx->start_time =3D jiffies;
> 	r_ctx->lba =3D blba;
> -	r_ctx->private =3D bio; /* original bio */
>=20
> 	/* Save the index for this bio's start. This is needed in case
> 	 * we need to fill a partial read.
> 	 */
> 	bio_init_idx =3D pblk_get_bi_idx(bio);
>=20
> -	if (pblk_alloc_rqd_meta(pblk, rqd))
> -		goto fail_rqd_free;
> +	if (pblk_alloc_rqd_meta(pblk, rqd)) {
> +		bio_io_error(bio);
> +		pblk_free_rqd(pblk, rqd, PBLK_READ);
> +		return;
> +	}
> +
> +	/* Clone read bio to deal internally with:
> +	 * -read errors when reading from drive
> +	 * -bio_advance() calls during l2p lookup and cache reads
> +	 */
> +	int_bio =3D bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
>=20
> 	if (nr_secs > 1)
> 		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
> 	else
> 		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
>=20
> +	r_ctx->private =3D bio; /* original bio */
> +	rqd->bio =3D int_bio; /* internal bio */
> +
> 	if (bitmap_full(read_bitmap, nr_secs)) {
> +		pblk_end_user_read(bio, 0);
> 		atomic_inc(&pblk->inflight_io);
> 		__pblk_end_io_read(pblk, rqd, false);
> -		return NVM_IO_DONE;
> +		return;
> 	}
>=20
> -	/* All sectors are to be read from the device */
> -	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
> -		struct bio *int_bio =3D NULL;
> -
> -		/* Clone read bio to deal with read errors internally */
> -		int_bio =3D bio_clone_fast(bio, GFP_KERNEL, =
&pblk_bio_set);
> -		if (!int_bio) {
> -			pblk_err(pblk, "could not clone read bio\n");
> -			goto fail_end_io;
> -		}
> -
> -		rqd->bio =3D int_bio;
> -
> -		if (pblk_submit_io(pblk, rqd)) {
> +	if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
> +		/* The read bio request could be partially filled by the =
write
> +		 * buffer, but there are some holes that need to be read =
from
> +		 * the drive.
> +		 */
> +		bio_put(int_bio);
> +		rqd->bio =3D NULL;
> +		if (pblk_partial_read_bio(pblk, rqd, bio_init_idx, =
read_bitmap,
> +					    nr_secs)) {
> 			pblk_err(pblk, "read IO submission failed\n");
> -			ret =3D NVM_IO_ERR;
> -			goto fail_end_io;
> +			bio_io_error(bio);
> +			__pblk_end_io_read(pblk, rqd, false);
> 		}
> -
> -		return NVM_IO_OK;
> +		return;
> 	}
>=20
> -	/* The read bio request could be partially filled by the write =
buffer,
> -	 * but there are some holes that need to be read from the drive.
> -	 */
> -	ret =3D pblk_partial_read_bio(pblk, rqd, bio_init_idx, =
read_bitmap,
> -				    nr_secs);
> -	if (ret)
> -		goto fail_meta_free;
> -
> -	return NVM_IO_OK;
> -
> -fail_meta_free:
> -	nvm_dev_dma_free(dev->parent, rqd->meta_list, =
rqd->dma_meta_list);
> -fail_rqd_free:
> -	pblk_free_rqd(pblk, rqd, PBLK_READ);
> -	return ret;
> -fail_end_io:
> -	__pblk_end_io_read(pblk, rqd, false);
> -	return ret;
> +	/* All sectors are to be read from the device */
> +	if (pblk_submit_io(pblk, rqd)) {
> +		pblk_err(pblk, "read IO submission failed\n");
> +		bio_io_error(bio);
> +		__pblk_end_io_read(pblk, rqd, false);
> +	}
> }
>=20
> static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 381f074..a3c925d 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -868,7 +868,7 @@ void pblk_get_packed_meta(struct pblk *pblk, =
struct nvm_rq *rqd);
> /*
>  * pblk user I/O write path
>  */
> -int pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
> +void pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
> 			unsigned long flags);
> int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq =
*gc_rq);
>=20
> @@ -894,7 +894,7 @@ void pblk_write_kick(struct pblk *pblk);
>  * pblk read path
>  */
> extern struct bio_set pblk_bio_set;
> -int pblk_submit_read(struct pblk *pblk, struct bio *bio);
> +void pblk_submit_read(struct pblk *pblk, struct bio *bio);
> int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
> /*
>  * pblk recovery
> --
> 2.9.5

The patch looks sane.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_CD05AB14-A821-4A7D-98A6-4A17B1A6C33E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyYbTcACgkQPEYBfS0l
eOB1yw//eGpD8vJxFFrR6IQLccvwtAnShpOMPHwThr5Bgqy3ZLL+3TgZpGqmksYb
u/g5501uFI2S9nDgJEIsrScqz0bUzCknm3xQdO0KNpGGUPmTJbeYWRRP8PoaLK8J
tk+Q2IBtjZCqK7PqiNcKaFhPrtu2AULEi+ykPM53Jxop0B4unyz5J2mVx+FG8Lnd
9oJAY7F6z8IwRpXbcl+tZdY9liVssfps9qCLUzP1PyO9i0BxDlPdltdTJ+vbSMiz
RMNdEKvDGi4Q7i2ZHn6zDfYmni75bs3y+bWOkxTVegh698LgfkMA/YEZQwLWgQIM
Xe/UFHIeCRMkP3lpUzQ0M4eLXkx9TWgUpByKLO7KifQrUhn3j7He+dbzk2v5Pqi5
XMUQc78mMKg0rJnXgAjkm2b/r36Qbx3fvbKANet1KZQGU7CTuucAL1QNsLIMVt2C
Tn3r70q65DdBJLy2k4mrvVHKzb+FwHFttX2tUTDqeeDRDfFXRPOrl0G1igPbNtfe
mxzM0Rk5XydMW9HYxPCx+MXLpm43ckDDP2wKGkitIqIB++LznQivvggJtjZTLYDX
m5UctgAnUpJfN/uyADo632t9MTQfIhPVl4Kj8c226VKY9YK8ZZuzDGb0lvjyCKNY
xITDyXptolaSkhOaixpx+Y5Z64W4N2i/O3zGYtWmE7ozxz2nUJA=
=9KSF
-----END PGP SIGNATURE-----

--Apple-Mail=_CD05AB14-A821-4A7D-98A6-4A17B1A6C33E--
