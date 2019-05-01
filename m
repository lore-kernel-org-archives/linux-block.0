Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5762CC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 06:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B0E2081C
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 06:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="X2EjMhbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfEAGUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 02:20:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33256 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAGUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 02:20:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so5569731edb.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=fu1maBgvrhEAVdK30ZzoK6wFq2fVf0t6M8vwVSzmbT8=;
        b=X2EjMhbCwH9HududXeQE/UdPUF0mgI3p7dNRaV4FVoHBU1L8hhmEzkSGVqIUtl3Mue
         dD3Ovd2tu3LZql9PuoeSHDO7x56vCPcWG4HV1rAyw645JOUMmzlhNZxerpmeKiSXZ9YF
         +PG6lu9HPi3HsP0raloOXUZRy5v7O4kV5mCigcn+S8nEvcadTsabctfIg7Nl/hhlYT3b
         U6opEJ/Y+KAGYeHr7pFZCkxJFe4hJ/rczQAcM8eyMjKMchOnIk27Gze6isqIDILvaJHr
         QqJazma8BzopZLRG71Tib5tngy9rjjBtCg509jZzKCH0yP2R/b293+6jTCdU4Wv38obw
         4r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=fu1maBgvrhEAVdK30ZzoK6wFq2fVf0t6M8vwVSzmbT8=;
        b=bXdRMjGQFf62bTmeMUXRDDmkNJsHXFKJtEyPxsJb30/P+sRJQrPeCg5Jn00LufCCfq
         vTyQ7q3tKgfFiVLMcazSpUT6GZ7qp3VBZRVHQO/74a22zFWmQFIdcDOu+u+88h7EikYh
         4reHD7CSLucHz1kYSgcHJ082RREANX0S6sgptW8Vc3GJiaCIcadn5Hrzoh5Z6JtTL5lk
         sJQ3GhIeqC653nF2tGfKyqkMCfWaltyroZ75O9hTKCR1721JjEWAAfjvkelT9UzUmmME
         jeXqgWK0q2kj/kqFP6wmRamJRubKV7LQ85tUNHBgr3agqU/el9m6+jzadxQnVeE94Fvz
         /lhA==
X-Gm-Message-State: APjAAAVG2RqcbSo3FD4JFoj8x6wVUAzcXV+vCvuaJnSk0eW+bRNwDSKX
        OfvXRnx6Giz6fljfMGGtXSsp1Q==
X-Google-Smtp-Source: APXvYqxZ9w5cD+itijjlwvJqYS2k6hKxzNP+LKeGYydZDTyu4Xn2DwLC09LjTULqECPWmOIO9gCoCA==
X-Received: by 2002:a17:906:c7c1:: with SMTP id dc1mr35757145ejb.35.1556691617211;
        Tue, 30 Apr 2019 23:20:17 -0700 (PDT)
Received: from [192.168.1.143] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id ay12sm6692373ejb.15.2019.04.30.23.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 23:20:16 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <1D0C0CFE-16A3-4061-A3E8-CA045A4C7FFA@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_FD879295-A9BE-4ADE-8BB4-4B6D5B50696F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v5 1/3] lightnvm: pblk: simplify partial read path
Date:   Wed, 1 May 2019 08:20:15 +0200
In-Reply-To: <20190426133513.23966-2-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190426133513.23966-1-igor.j.konopko@intel.com>
 <20190426133513.23966-2-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_FD879295-A9BE-4ADE-8BB4-4B6D5B50696F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Apr 2019, at 15.35, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch changes the approach to handling partial read path.
>=20
> In old approach merging of data from round buffer and drive was fully
> made by drive. This had some disadvantages - code was complex and
> relies on bio internals, so it was hard to maintain and was strongly
> dependent on bio changes.
>=20
> In new approach most of the handling is done mostly by block layer
> functions such as bio_split(), bio_chain() and generic_make request()
> and generally is less complex and easier to maintain. Below some more
> details of the new approach.
>=20
> When read bio arrives, it is cloned for pblk internal purposes. All
> the L2P mapping, which includes copying data from round buffer to bio
> and thus bio_advance() calls is done on the cloned bio, so the =
original
> bio is untouched. If we found that we have partial read case, we
> still have original bio untouched, so we can split it and continue to
> process only first part of it in current context, when the rest will =
be
> called as separate bio request which is passed to =
generic_make_request()
> for further processing.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c |  13 +-
> drivers/lightnvm/pblk-rb.c   |  11 +-
> drivers/lightnvm/pblk-read.c | 339 =
+++++++++++--------------------------------
> drivers/lightnvm/pblk.h      |  18 +--
> 4 files changed, 100 insertions(+), 281 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 73be3a0..07270ba 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -2147,8 +2147,8 @@ void pblk_update_map_dev(struct pblk *pblk, =
sector_t lba,
> 	spin_unlock(&pblk->trans_lock);
> }
>=20
> -void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
> -			 sector_t blba, int nr_secs)
> +int pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
> +			 sector_t blba, int nr_secs, bool *from_cache)
> {
> 	int i;
>=20
> @@ -2162,10 +2162,19 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, =
struct ppa_addr *ppas,
> 		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
> 			struct pblk_line *line =3D =
pblk_ppa_to_line(pblk, ppa);
>=20
> +			if (i > 0 && *from_cache)
> +				break;
> +			*from_cache =3D false;
> +
> 			kref_get(&line->ref);
> +		} else {
> +			if (i > 0 && !*from_cache)
> +				break;
> +			*from_cache =3D true;
> 		}
> 	}
> 	spin_unlock(&pblk->trans_lock);
> +	return i;
> }
>=20
> void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 3555014..5abb170 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -642,7 +642,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb =
*rb, struct nvm_rq *rqd,
>  * be directed to disk.
>  */
> int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t =
lba,
> -			struct ppa_addr ppa, int bio_iter, bool =
advanced_bio)
> +			struct ppa_addr ppa)
> {
> 	struct pblk *pblk =3D container_of(rb, struct pblk, rwb);
> 	struct pblk_rb_entry *entry;
> @@ -673,15 +673,6 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, =
struct bio *bio, sector_t lba,
> 		ret =3D 0;
> 		goto out;
> 	}
> -
> -	/* Only advance the bio if it hasn't been advanced already. If =
advanced,
> -	 * this bio is at least a partial bio (i.e., it has partially =
been
> -	 * filled with data from the cache). If part of the data resides =
on the
> -	 * media, we will read later on
> -	 */
> -	if (unlikely(!advanced_bio))
> -		bio_advance(bio, bio_iter * PBLK_EXPOSED_PAGE_SIZE);
> -
> 	data =3D bio_data(bio);
> 	memcpy(data, entry->data, rb->seg_size);
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index f5f155d..d98ea39 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -26,8 +26,7 @@
>  * issued.
>  */
> static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
> -				sector_t lba, struct ppa_addr ppa,
> -				int bio_iter, bool advanced_bio)
> +				sector_t lba, struct ppa_addr ppa)
> {
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	/* Callers must ensure that the ppa points to a cache address */
> @@ -35,73 +34,75 @@ static int pblk_read_from_cache(struct pblk *pblk, =
struct bio *bio,
> 	BUG_ON(!pblk_addr_in_cache(ppa));
> #endif
>=20
> -	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa,
> -						bio_iter, advanced_bio);
> +	return pblk_rb_copy_to_bio(&pblk->rwb, bio, lba, ppa);
> }
>=20
> -static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq =
*rqd,
> +static int pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq =
*rqd,
> 				 struct bio *bio, sector_t blba,
> -				 unsigned long *read_bitmap)
> +				 bool *from_cache)
> {
> 	void *meta_list =3D rqd->meta_list;
> -	struct ppa_addr ppas[NVM_MAX_VLBA];
> -	int nr_secs =3D rqd->nr_ppas;
> -	bool advanced_bio =3D false;
> -	int i, j =3D 0;
> +	int nr_secs, i;
>=20
> -	pblk_lookup_l2p_seq(pblk, ppas, blba, nr_secs);
> +retry:
> +	nr_secs =3D pblk_lookup_l2p_seq(pblk, rqd->ppa_list, blba, =
rqd->nr_ppas,
> +					from_cache);
> +
> +	if (!*from_cache)
> +		goto end;
>=20
> 	for (i =3D 0; i < nr_secs; i++) {
> -		struct ppa_addr p =3D ppas[i];
> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
> 		sector_t lba =3D blba + i;
>=20
> -retry:
> -		if (pblk_ppa_empty(p)) {
> +		if (pblk_ppa_empty(rqd->ppa_list[i])) {
> 			__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
>=20
> -			WARN_ON(test_and_set_bit(i, read_bitmap));
> 			meta->lba =3D addr_empty;
> -
> -			if (unlikely(!advanced_bio)) {
> -				bio_advance(bio, (i) * =
PBLK_EXPOSED_PAGE_SIZE);
> -				advanced_bio =3D true;
> +		} else if (pblk_addr_in_cache(rqd->ppa_list[i])) {
> +			/*
> +			 * Try to read from write buffer. The address is =
later
> +			 * checked on the write buffer to prevent =
retrieving
> +			 * overwritten data.
> +			 */
> +			if (!pblk_read_from_cache(pblk, bio, lba,
> +							=
rqd->ppa_list[i])) {
> +				if (i =3D=3D 0) {
> +					/*
> +					 * We didn't call with =
bio_advance()
> +					 * yet, so we can just retry.
> +					 */
> +					goto retry;
> +				} else {
> +					/*
> +					 * We already call bio_advance()
> +					 * so we cannot retry and we =
need
> +					 * to quit that function in =
order
> +					 * to allow caller to handle the =
bio
> +					 * splitting in the current =
sector
> +					 * position.
> +					 */
> +					nr_secs =3D i;
> +					goto end;
> +				}
> 			}
> -
> -			goto next;
> -		}
> -
> -		/* Try to read from write buffer. The address is later =
checked
> -		 * on the write buffer to prevent retrieving overwritten =
data.
> -		 */
> -		if (pblk_addr_in_cache(p)) {
> -			if (!pblk_read_from_cache(pblk, bio, lba, p, i,
> -								=
advanced_bio)) {
> -				pblk_lookup_l2p_seq(pblk, &p, lba, 1);
> -				goto retry;
> -			}
> -			WARN_ON(test_and_set_bit(i, read_bitmap));
> 			meta->lba =3D cpu_to_le64(lba);
> -			advanced_bio =3D true;
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 			atomic_long_inc(&pblk->cache_reads);
> #endif
> -		} else {
> -			/* Read from media non-cached sectors */
> -			rqd->ppa_list[j++] =3D p;
> 		}
> -
> -next:
> -		if (advanced_bio)
> -			bio_advance(bio, PBLK_EXPOSED_PAGE_SIZE);
> +		bio_advance(bio, PBLK_EXPOSED_PAGE_SIZE);
> 	}
>=20
> +end:
> 	if (pblk_io_aligned(pblk, nr_secs))
> 		rqd->is_seq =3D 1;
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	atomic_long_add(nr_secs, &pblk->inflight_reads);
> #endif
> +
> +	return nr_secs;
> }
>=20
>=20
> @@ -197,9 +198,7 @@ static void __pblk_end_io_read(struct pblk *pblk, =
struct nvm_rq *rqd,
> 		pblk_log_read_err(pblk, rqd);
>=20
> 	pblk_read_check_seq(pblk, rqd, r_ctx->lba);
> -
> -	if (int_bio)
> -		bio_put(int_bio);
> +	bio_put(int_bio);
>=20
> 	if (put_line)
> 		pblk_rq_to_line_put(pblk, rqd);
> @@ -223,183 +222,13 @@ static void pblk_end_io_read(struct nvm_rq =
*rqd)
> 	__pblk_end_io_read(pblk, rqd, true);
> }
>=20
> -static void pblk_end_partial_read(struct nvm_rq *rqd)
> -{
> -	struct pblk *pblk =3D rqd->private;
> -	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> -	struct pblk_pr_ctx *pr_ctx =3D r_ctx->private;
> -	struct pblk_sec_meta *meta;
> -	struct bio *new_bio =3D rqd->bio;
> -	struct bio *bio =3D pr_ctx->orig_bio;
> -	void *meta_list =3D rqd->meta_list;
> -	unsigned long *read_bitmap =3D pr_ctx->bitmap;
> -	struct bvec_iter orig_iter =3D BVEC_ITER_ALL_INIT;
> -	struct bvec_iter new_iter =3D BVEC_ITER_ALL_INIT;
> -	int nr_secs =3D pr_ctx->orig_nr_secs;
> -	int nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> -	void *src_p, *dst_p;
> -	int bit, i;
> -
> -	if (unlikely(nr_holes =3D=3D 1)) {
> -		struct ppa_addr ppa;
> -
> -		ppa =3D rqd->ppa_addr;
> -		rqd->ppa_list =3D pr_ctx->ppa_ptr;
> -		rqd->dma_ppa_list =3D pr_ctx->dma_ppa_list;
> -		rqd->ppa_list[0] =3D ppa;
> -	}
> -
> -	for (i =3D 0; i < nr_secs; i++) {
> -		meta =3D pblk_get_meta(pblk, meta_list, i);
> -		pr_ctx->lba_list_media[i] =3D le64_to_cpu(meta->lba);
> -		meta->lba =3D cpu_to_le64(pr_ctx->lba_list_mem[i]);
> -	}
> -
> -	/* Fill the holes in the original bio */
> -	i =3D 0;
> -	for (bit =3D 0; bit < nr_secs; bit++) {
> -		if (!test_bit(bit, read_bitmap)) {
> -			struct bio_vec dst_bv, src_bv;
> -			struct pblk_line *line;
> -
> -			line =3D pblk_ppa_to_line(pblk, =
rqd->ppa_list[i]);
> -			kref_put(&line->ref, pblk_line_put);
> -
> -			meta =3D pblk_get_meta(pblk, meta_list, bit);
> -			meta->lba =3D =
cpu_to_le64(pr_ctx->lba_list_media[i]);
> -
> -			dst_bv =3D bio_iter_iovec(bio, orig_iter);
> -			src_bv =3D bio_iter_iovec(new_bio, new_iter);
> -
> -			src_p =3D kmap_atomic(src_bv.bv_page);
> -			dst_p =3D kmap_atomic(dst_bv.bv_page);
> -
> -			memcpy(dst_p + dst_bv.bv_offset,
> -				src_p + src_bv.bv_offset,
> -				PBLK_EXPOSED_PAGE_SIZE);
> -
> -			kunmap_atomic(src_p);
> -			kunmap_atomic(dst_p);
> -
> -			flush_dcache_page(dst_bv.bv_page);
> -			mempool_free(src_bv.bv_page, =
&pblk->page_bio_pool);
> -
> -			bio_advance_iter(new_bio, &new_iter,
> -					PBLK_EXPOSED_PAGE_SIZE);
> -			i++;
> -		}
> -		bio_advance_iter(bio, &orig_iter, =
PBLK_EXPOSED_PAGE_SIZE);
> -	}
> -
> -	bio_put(new_bio);
> -	kfree(pr_ctx);
> -
> -	/* restore original request */
> -	rqd->bio =3D NULL;
> -	rqd->nr_ppas =3D nr_secs;
> -
> -	pblk_end_user_read(bio, rqd->error);
> -	__pblk_end_io_read(pblk, rqd, false);
> -}
> -
> -static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq =
*rqd,
> -			    unsigned int bio_init_idx,
> -			    unsigned long *read_bitmap,
> -			    int nr_holes)
> -{
> -	void *meta_list =3D rqd->meta_list;
> -	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> -	struct pblk_pr_ctx *pr_ctx;
> -	struct bio *new_bio, *bio =3D r_ctx->private;
> -	int nr_secs =3D rqd->nr_ppas;
> -	int i;
> -
> -	new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
> -
> -	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
> -		goto fail_bio_put;
> -
> -	if (nr_holes !=3D new_bio->bi_vcnt) {
> -		WARN_ONCE(1, "pblk: malformed bio\n");
> -		goto fail_free_pages;
> -	}
> -
> -	pr_ctx =3D kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
> -	if (!pr_ctx)
> -		goto fail_free_pages;
> -
> -	for (i =3D 0; i < nr_secs; i++) {
> -		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
> -
> -		pr_ctx->lba_list_mem[i] =3D le64_to_cpu(meta->lba);
> -	}
> -
> -	new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> -
> -	rqd->bio =3D new_bio;
> -	rqd->nr_ppas =3D nr_holes;
> -
> -	pr_ctx->orig_bio =3D bio;
> -	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
> -	pr_ctx->bio_init_idx =3D bio_init_idx;
> -	pr_ctx->orig_nr_secs =3D nr_secs;
> -	r_ctx->private =3D pr_ctx;
> -
> -	if (unlikely(nr_holes =3D=3D 1)) {
> -		pr_ctx->ppa_ptr =3D rqd->ppa_list;
> -		pr_ctx->dma_ppa_list =3D rqd->dma_ppa_list;
> -		rqd->ppa_addr =3D rqd->ppa_list[0];
> -	}
> -	return 0;
> -
> -fail_free_pages:
> -	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
> -fail_bio_put:
> -	bio_put(new_bio);
> -
> -	return -ENOMEM;
> -}
> -
> -static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq =
*rqd,
> -				 unsigned int bio_init_idx,
> -				 unsigned long *read_bitmap, int =
nr_secs)
> -{
> -	int nr_holes;
> -	int ret;
> -
> -	nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> -
> -	if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, =
read_bitmap,
> -				    nr_holes))
> -		return NVM_IO_ERR;
> -
> -	rqd->end_io =3D pblk_end_partial_read;
> -
> -	ret =3D pblk_submit_io(pblk, rqd);
> -	if (ret) {
> -		bio_put(rqd->bio);
> -		pblk_err(pblk, "partial read IO submission failed\n");
> -		goto err;
> -	}
> -
> -	return NVM_IO_OK;
> -
> -err:
> -	pblk_err(pblk, "failed to perform partial read\n");
> -
> -	/* Free allocated pages in new bio */
> -	pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
> -	return NVM_IO_ERR;
> -}
> -
> static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct =
bio *bio,
> -			 sector_t lba, unsigned long *read_bitmap)
> +			 sector_t lba, bool *from_cache)
> {
> 	struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
rqd->meta_list, 0);
> 	struct ppa_addr ppa;
>=20
> -	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
> +	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1, from_cache);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	atomic_long_inc(&pblk->inflight_reads);
> @@ -409,7 +238,6 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> 	if (pblk_ppa_empty(ppa)) {
> 		__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
>=20
> -		WARN_ON(test_and_set_bit(0, read_bitmap));
> 		meta->lba =3D addr_empty;
> 		return;
> 	}
> @@ -418,12 +246,11 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
> 	 * write buffer to prevent retrieving overwritten data.
> 	 */
> 	if (pblk_addr_in_cache(ppa)) {
> -		if (!pblk_read_from_cache(pblk, bio, lba, ppa, 0, 1)) {
> -			pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
> +		if (!pblk_read_from_cache(pblk, bio, lba, ppa)) {
> +			pblk_lookup_l2p_seq(pblk, &ppa, lba, 1, =
from_cache);
> 			goto retry;
> 		}
>=20
> -		WARN_ON(test_and_set_bit(0, read_bitmap));
> 		meta->lba =3D cpu_to_le64(lba);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -440,17 +267,14 @@ void pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 	struct request_queue *q =3D dev->q;
> 	sector_t blba =3D pblk_get_lba(bio);
> 	unsigned int nr_secs =3D pblk_get_secs(bio);
> +	bool from_cache;
> 	struct pblk_g_ctx *r_ctx;
> 	struct nvm_rq *rqd;
> -	struct bio *int_bio;
> -	unsigned int bio_init_idx;
> -	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
> +	struct bio *int_bio, *split_bio;
>=20
> 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
> 			      &pblk->disk->part0);
>=20
> -	bitmap_zero(read_bitmap, nr_secs);
> -
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_READ);
>=20
> 	rqd->opcode =3D NVM_OP_PREAD;
> @@ -462,11 +286,6 @@ void pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 	r_ctx->start_time =3D jiffies;
> 	r_ctx->lba =3D blba;
>=20
> -	/* Save the index for this bio's start. This is needed in case
> -	 * we need to fill a partial read.
> -	 */
> -	bio_init_idx =3D pblk_get_bi_idx(bio);
> -
> 	if (pblk_alloc_rqd_meta(pblk, rqd)) {
> 		bio_io_error(bio);
> 		pblk_free_rqd(pblk, rqd, PBLK_READ);
> @@ -475,46 +294,58 @@ void pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
>=20
> 	/* Clone read bio to deal internally with:
> 	 * -read errors when reading from drive
> -	 * -bio_advance() calls during l2p lookup and cache reads
> +	 * -bio_advance() calls during cache reads
> 	 */
> 	int_bio =3D bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
>=20
> 	if (nr_secs > 1)
> -		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
> +		nr_secs =3D pblk_read_ppalist_rq(pblk, rqd, int_bio, =
blba,
> +						&from_cache);
> 	else
> -		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
> +		pblk_read_rq(pblk, rqd, int_bio, blba, &from_cache);
>=20
> +split_retry:
> 	r_ctx->private =3D bio; /* original bio */
> 	rqd->bio =3D int_bio; /* internal bio */
>=20
> -	if (bitmap_full(read_bitmap, nr_secs)) {
> +	if (from_cache && nr_secs =3D=3D rqd->nr_ppas) {
> +		/* All data was read from cache, we can complete the IO. =
*/
> 		pblk_end_user_read(bio, 0);
> 		atomic_inc(&pblk->inflight_io);
> 		__pblk_end_io_read(pblk, rqd, false);
> -		return;
> -	}
> -
> -	if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
> +	} else if (nr_secs !=3D rqd->nr_ppas) {
> 		/* The read bio request could be partially filled by the =
write
> 		 * buffer, but there are some holes that need to be read =
from
> -		 * the drive.
> +		 * the drive. In order to handle this, we will use block =
layer
> +		 * mechanism to split this request in to smaller ones =
and make
> +		 * a chain of it.
> 		 */
> -		bio_put(int_bio);
> -		rqd->bio =3D NULL;
> -		if (pblk_partial_read_bio(pblk, rqd, bio_init_idx, =
read_bitmap,
> -					    nr_secs)) {
> -			pblk_err(pblk, "read IO submission failed\n");
> -			bio_io_error(bio);
> -			__pblk_end_io_read(pblk, rqd, false);
> -		}
> -		return;
> -	}
> +		split_bio =3D bio_split(bio, nr_secs * NR_PHY_IN_LOG, =
GFP_KERNEL,
> +					&pblk_bio_set);
> +		bio_chain(split_bio, bio);
> +		generic_make_request(bio);
> +
> +		/* New bio contains first N sectors of the previous one, =
so
> +		 * we can continue to use existing rqd, but we need to =
shrink
> +		 * the number of PPAs in it. New bio is also guaranteed =
that
> +		 * it contains only either data from cache or from =
drive, newer
> +		 * mix of them.
> +		 */
> +		bio =3D split_bio;
> +		rqd->nr_ppas =3D nr_secs;
> +		if (rqd->nr_ppas =3D=3D 1)
> +			rqd->ppa_addr =3D rqd->ppa_list[0];
>=20
> -	/* All sectors are to be read from the device */
> -	if (pblk_submit_io(pblk, rqd)) {
> -		pblk_err(pblk, "read IO submission failed\n");
> -		bio_io_error(bio);
> -		__pblk_end_io_read(pblk, rqd, false);
> +		/* Recreate int_bio - existing might have some needed =
internal
> +		 * fields modified already.
> +		 */
> +		bio_put(int_bio);
> +		int_bio =3D bio_clone_fast(bio, GFP_KERNEL, =
&pblk_bio_set);
> +		goto split_retry;
> +	} else if (pblk_submit_io(pblk, rqd)) {
> +		/* Submitting IO to drive failed, let's report an error =
*/
> +		rqd->error =3D -ENODEV;
> +		pblk_end_io_read(rqd);
> 	}
> }
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 17ced12..a678553 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -121,18 +121,6 @@ struct pblk_g_ctx {
> 	u64 lba;
> };
>=20
> -/* partial read context */
> -struct pblk_pr_ctx {
> -	struct bio *orig_bio;
> -	DECLARE_BITMAP(bitmap, NVM_MAX_VLBA);
> -	unsigned int orig_nr_secs;
> -	unsigned int bio_init_idx;
> -	void *ppa_ptr;
> -	dma_addr_t dma_ppa_list;
> -	u64 lba_list_mem[NVM_MAX_VLBA];
> -	u64 lba_list_media[NVM_MAX_VLBA];
> -};
> -
> /* Pad context */
> struct pblk_pad_rq {
> 	struct pblk *pblk;
> @@ -759,7 +747,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb =
*rb, struct nvm_rq *rqd,
> 				 unsigned int pos, unsigned int =
nr_entries,
> 				 unsigned int count);
> int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t =
lba,
> -			struct ppa_addr ppa, int bio_iter, bool =
advanced_bio);
> +			struct ppa_addr ppa);
> unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int =
entries);
>=20
> unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long =
*flags);
> @@ -859,8 +847,8 @@ int pblk_update_map_gc(struct pblk *pblk, sector_t =
lba, struct ppa_addr ppa,
> 		       struct pblk_line *gc_line, u64 paddr);
> void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
> 			  u64 *lba_list, int nr_secs);
> -void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
> -			 sector_t blba, int nr_secs);
> +int pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
> +			 sector_t blba, int nr_secs, bool *from_cache);
> void *pblk_get_meta_for_writes(struct pblk *pblk, struct nvm_rq *rqd);
> void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
>=20
> --
> 2.9.5

It looks good to me. Thanks for this Igor!

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_FD879295-A9BE-4ADE-8BB4-4B6D5B50696F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzJOp8ACgkQPEYBfS0l
eOBJ+xAAqfd6pru2esYnAyeR05/PvPUjLB/EZBP+PkMs3u7kJiiRLROU7hYAx5WW
wstvzZbLg4EaKug5t1bfu9u/J2ciGzSzceFfuxrZWSJof7Lo7Td5afNfl33MttaQ
uHixvwHVE63K5R4ce2+wn3dHGCJL5bvz2cefKX5mLUgyrUCZ2X0CjN4DQf2K1br5
EqSfFpL6PiyOHces4OQAZZJzb8YmeaqpJQ5ZP1I0tLlnKFNKAeGQDBNWFshGqbxB
1tgCga3gEiwT0UJFdHy1++yD8+UXBzJ3MP5AGEBoCZAvfnMzDI7oUsMTpwgd0PjB
ZiycGUpiQT6INRMLOq2ly3O27j3WqZcHPXSPjmntHS9jw9mjUlTsKbftZt/Sr7f0
VNb9bSjD4kNyw1gV7Jn+/1o3o82NMUlmnGBG8egsLp4eHobLPrqEfJsjCjcDEYPF
XNg5MuVtSbkbEV8dNGQbEYXmHzgvFZ05dI8eNji/I1qScPGPv75ifH3ZqrUTlum3
yD9OWkX5Oe7iRI7PfCFqq6z9dhoeZMABFbpGniTPRNejWUbs4wpGCbiWCvls7bjl
omp0Ttum5gc7AbYOwujFYQNCMdGzV+OKdR7qaDNK2tcg9N4JrOguJqOPaiXYIcbX
96Nf0qJKHeAeLqydnLqu8jGi25Q2/2TTJ/PXYD0oYBcJL+dgaOU=
=EtZ9
-----END PGP SIGNATURE-----

--Apple-Mail=_FD879295-A9BE-4ADE-8BB4-4B6D5B50696F--
