Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F68C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E4920693
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ZMF7BegI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbfGaN7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:59:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38554 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbfGaN7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 09:59:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so65709013ljg.5
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lzuXIovE4SgJJI7GhnuxhRIMg6ShQoxBCoow/xgDIJQ=;
        b=ZMF7BegIieHg3ZhF3agP3xlgbyjWdlRZ70IQ7mHfuLStvJAF293PiiwLWcgPHhJW9a
         Y1mLz6ps4/8Ai/SGRFaQ01tkkWMSYE0b/9OI0oWq84315PivbBitai1lUK9g1Jnzcz/E
         8G9Uu1txQ/HwWdOdKawl2WZfia41EXaJzVzYgcJ66qBmJ2DWCWY2RoKKEa33u5VgH8il
         TZR2/kSx0nvJhELvJ93NkdyLilflLVON2STgF7PH/fTv1ZvrnD4UqCoic2FYs3fDbCqe
         1aVb/b4PV+7uQCyT3kQxJvulGQwilEK3HBcLYjjPyHr44EgeMVXU63bxp3/aqzoKOnGD
         KzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lzuXIovE4SgJJI7GhnuxhRIMg6ShQoxBCoow/xgDIJQ=;
        b=SsKcFawPJuyzgDCK1D3zJMHvf4I67r2cc6IqBVhSt/rbW0+dn8brUW/Bo3X6oUF6je
         K9LNxN/ZrShF7y3R327dd/d/3uTSIEOFeZPpCfjy57H1ud2dXh8b8ImwCrACDrstdyGM
         70j9llzC738STqtakShIPwjoKo5cAlYeD5YkxScbmYjnF4/QdA5o7uV92IUydD9HuMSU
         rBDpeOPprP8WPRYde9/UTBpMlHSmy7Kr7WmRTANmWpD5QHd96bNod560NcZWYqVDIeUK
         PTf2PnBYdfuNp/2uXKR9LBEAJuFi9eUXMQmgXVXF3T9wOs8a42PO5EHwnL6YGyuG/Pn/
         sVHg==
X-Gm-Message-State: APjAAAV4taMiAQZ0vh0QGLvOPG3hepugpdGNHW5XUYTDcNHKthrIS8GG
        i+pzQzhVasJ+sXFfeHW7O/8=
X-Google-Smtp-Source: APXvYqwHwwjHPDZFkkQP3XkoBZuUb13awhLWA3B3S5HP5kDXd33hrp4mqwa3zTNFWV1Ob0opi9toiQ==
X-Received: by 2002:a2e:9a13:: with SMTP id o19mr66127603lji.102.1564581541095;
        Wed, 31 Jul 2019 06:59:01 -0700 (PDT)
Received: from [172.20.10.13] (212.27.19.10.bredband.3.dk. [212.27.19.10])
        by smtp.gmail.com with ESMTPSA id m25sm11759404lfc.83.2019.07.31.06.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:58:59 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <69EAD2D8-72B5-4EC1-99EE-1436D1FF9241@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5C669773-B3C6-4E3A-B374-51EB615AB774";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/4] lightnvm: move metadata mapping to lower level driver
Date:   Wed, 31 Jul 2019 15:58:55 +0200
In-Reply-To: <1564566096-28756-3-git-send-email-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Hans Holmberg <hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
 <1564566096-28756-3-git-send-email-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_5C669773-B3C6-4E3A-B374-51EB615AB774
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Jul 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> Now that blk_rq_map_kern can map both kmem and vmem, move
> internal metadata mapping down to the lower level driver.
>=20
> Signed-off-by: Hans Holmberg <hans@owltronix.com>
> ---
> drivers/lightnvm/core.c          |  16 +++---
> drivers/lightnvm/pblk-core.c     | 113 =
+++++----------------------------------
> drivers/lightnvm/pblk-read.c     |  22 ++------
> drivers/lightnvm/pblk-recovery.c |  39 ++------------
> drivers/lightnvm/pblk-write.c    |  20 ++-----
> drivers/lightnvm/pblk.h          |   8 +--
> drivers/nvme/host/lightnvm.c     |  20 +++++--
> include/linux/lightnvm.h         |   6 +--
> 8 files changed, 54 insertions(+), 190 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 01d098fb96ac..3cd03582a2ed 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -731,7 +731,7 @@ static int nvm_set_flags(struct nvm_geo *geo, =
struct nvm_rq *rqd)
> 	return flags;
> }
>=20
> -int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
> +int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd, =
void *buf)
> {
> 	struct nvm_dev *dev =3D tgt_dev->parent;
> 	int ret;
> @@ -745,7 +745,7 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, =
struct nvm_rq *rqd)
> 	rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
>=20
> 	/* In case of error, fail with right address format */
> -	ret =3D dev->ops->submit_io(dev, rqd);
> +	ret =3D dev->ops->submit_io(dev, rqd, buf);
> 	if (ret)
> 		nvm_rq_dev_to_tgt(tgt_dev, rqd);
> 	return ret;
> @@ -759,7 +759,8 @@ static void nvm_sync_end_io(struct nvm_rq *rqd)
> 	complete(waiting);
> }
>=20
> -static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> +static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq =
*rqd,
> +			      void *buf)
> {
> 	DECLARE_COMPLETION_ONSTACK(wait);
> 	int ret =3D 0;
> @@ -767,7 +768,7 @@ static int nvm_submit_io_wait(struct nvm_dev *dev, =
struct nvm_rq *rqd)
> 	rqd->end_io =3D nvm_sync_end_io;
> 	rqd->private =3D &wait;
>=20
> -	ret =3D dev->ops->submit_io(dev, rqd);
> +	ret =3D dev->ops->submit_io(dev, rqd, buf);
> 	if (ret)
> 		return ret;
>=20
> @@ -776,7 +777,8 @@ static int nvm_submit_io_wait(struct nvm_dev *dev, =
struct nvm_rq *rqd)
> 	return 0;
> }
>=20
> -int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd)
> +int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd,
> +		       void *buf)
> {
> 	struct nvm_dev *dev =3D tgt_dev->parent;
> 	int ret;
> @@ -789,7 +791,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev =
*tgt_dev, struct nvm_rq *rqd)
> 	rqd->dev =3D tgt_dev;
> 	rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
>=20
> -	ret =3D nvm_submit_io_wait(dev, rqd);
> +	ret =3D nvm_submit_io_wait(dev, rqd, buf);
>=20
> 	return ret;
> }
> @@ -816,7 +818,7 @@ static int nvm_submit_io_sync_raw(struct nvm_dev =
*dev, struct nvm_rq *rqd)
> 	rqd->dev =3D NULL;
> 	rqd->flags =3D nvm_set_flags(&dev->geo, rqd);
>=20
> -	return nvm_submit_io_wait(dev, rqd);
> +	return nvm_submit_io_wait(dev, rqd, NULL);
> }
>=20
> static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr =
ppa)
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index f546e6f28b8a..a58d3c84a3f2 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -507,7 +507,7 @@ void pblk_set_sec_per_write(struct pblk *pblk, int =
sec_per_write)
> 	pblk->sec_per_write =3D sec_per_write;
> }
>=20
> -int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
> +int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd, void *buf)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>=20
> @@ -518,7 +518,7 @@ int pblk_submit_io(struct pblk *pblk, struct =
nvm_rq *rqd)
> 		return NVM_IO_ERR;
> #endif
>=20
> -	return nvm_submit_io(dev, rqd);
> +	return nvm_submit_io(dev, rqd, buf);
> }
>=20
> void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq =
*rqd)
> @@ -541,7 +541,7 @@ void pblk_check_chunk_state_update(struct pblk =
*pblk, struct nvm_rq *rqd)
> 	}
> }
>=20
> -int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
> +int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd, void =
*buf)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	int ret;
> @@ -553,7 +553,7 @@ int pblk_submit_io_sync(struct pblk *pblk, struct =
nvm_rq *rqd)
> 		return NVM_IO_ERR;
> #endif
>=20
> -	ret =3D nvm_submit_io_sync(dev, rqd);
> +	ret =3D nvm_submit_io_sync(dev, rqd, buf);
>=20
> 	if (trace_pblk_chunk_state_enabled() && !ret &&
> 	    rqd->opcode =3D=3D NVM_OP_PWRITE)
> @@ -562,65 +562,19 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
> 	return ret;
> }
>=20
> -int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +static int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq =
*rqd,
> +				   void *buf)
> {
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	int ret;
>=20
> 	pblk_down_chunk(pblk, ppa_list[0]);
> -	ret =3D pblk_submit_io_sync(pblk, rqd);
> +	ret =3D pblk_submit_io_sync(pblk, rqd, buf);
> 	pblk_up_chunk(pblk, ppa_list[0]);
>=20
> 	return ret;
> }
>=20
> -static void pblk_bio_map_addr_endio(struct bio *bio)
> -{
> -	bio_put(bio);
> -}
> -
> -struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
> -			      unsigned int nr_secs, unsigned int len,
> -			      int alloc_type, gfp_t gfp_mask)
> -{
> -	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	void *kaddr =3D data;
> -	struct page *page;
> -	struct bio *bio;
> -	int i, ret;
> -
> -	if (alloc_type =3D=3D PBLK_KMALLOC_META)
> -		return bio_map_kern(dev->q, kaddr, len, gfp_mask);
> -
> -	bio =3D bio_kmalloc(gfp_mask, nr_secs);
> -	if (!bio)
> -		return ERR_PTR(-ENOMEM);
> -
> -	for (i =3D 0; i < nr_secs; i++) {
> -		page =3D vmalloc_to_page(kaddr);
> -		if (!page) {
> -			pblk_err(pblk, "could not map vmalloc bio\n");
> -			bio_put(bio);
> -			bio =3D ERR_PTR(-ENOMEM);
> -			goto out;
> -		}
> -
> -		ret =3D bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, =
0);
> -		if (ret !=3D PAGE_SIZE) {
> -			pblk_err(pblk, "could not add page to bio\n");
> -			bio_put(bio);
> -			bio =3D ERR_PTR(-ENOMEM);
> -			goto out;
> -		}
> -
> -		kaddr +=3D PAGE_SIZE;
> -	}
> -
> -	bio->bi_end_io =3D pblk_bio_map_addr_endio;
> -out:
> -	return bio;
> -}
> -
> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> 		   unsigned long secs_to_flush, bool skip_meta)
> {
> @@ -722,9 +676,7 @@ u64 pblk_line_smeta_start(struct pblk *pblk, =
struct pblk_line *line)
>=20
> int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
> {
> -	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct bio *bio;
> 	struct ppa_addr *ppa_list;
> 	struct nvm_rq rqd;
> 	u64 paddr =3D pblk_line_smeta_start(pblk, line);
> @@ -736,16 +688,6 @@ int pblk_line_smeta_read(struct pblk *pblk, =
struct pblk_line *line)
> 	if (ret)
> 		return ret;
>=20
> -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
> -	if (IS_ERR(bio)) {
> -		ret =3D PTR_ERR(bio);
> -		goto clear_rqd;
> -	}
> -
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -
> -	rqd.bio =3D bio;
> 	rqd.opcode =3D NVM_OP_PREAD;
> 	rqd.nr_ppas =3D lm->smeta_sec;
> 	rqd.is_seq =3D 1;
> @@ -754,10 +696,9 @@ int pblk_line_smeta_read(struct pblk *pblk, =
struct pblk_line *line)
> 	for (i =3D 0; i < lm->smeta_sec; i++, paddr++)
> 		ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, line->id);
>=20
> -	ret =3D pblk_submit_io_sync(pblk, &rqd);
> +	ret =3D pblk_submit_io_sync(pblk, &rqd, line->smeta);
> 	if (ret) {
> 		pblk_err(pblk, "smeta I/O submission failed: %d\n", =
ret);
> -		bio_put(bio);
> 		goto clear_rqd;
> 	}
>=20
> @@ -776,9 +717,7 @@ int pblk_line_smeta_read(struct pblk *pblk, struct =
pblk_line *line)
> static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line =
*line,
> 				 u64 paddr)
> {
> -	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct bio *bio;
> 	struct ppa_addr *ppa_list;
> 	struct nvm_rq rqd;
> 	__le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> @@ -791,16 +730,6 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 	if (ret)
> 		return ret;
>=20
> -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
> -	if (IS_ERR(bio)) {
> -		ret =3D PTR_ERR(bio);
> -		goto clear_rqd;
> -	}
> -
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> -
> -	rqd.bio =3D bio;
> 	rqd.opcode =3D NVM_OP_PWRITE;
> 	rqd.nr_ppas =3D lm->smeta_sec;
> 	rqd.is_seq =3D 1;
> @@ -814,10 +743,9 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 		meta->lba =3D lba_list[paddr] =3D addr_empty;
> 	}
>=20
> -	ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> +	ret =3D pblk_submit_io_sync_sem(pblk, &rqd, line->smeta);
> 	if (ret) {
> 		pblk_err(pblk, "smeta I/O submission failed: %d\n", =
ret);
> -		bio_put(bio);
> 		goto clear_rqd;
> 	}
>=20
> @@ -838,10 +766,8 @@ int pblk_line_emeta_read(struct pblk *pblk, =
struct pblk_line *line,
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	void *ppa_list_buf, *meta_list;
> -	struct bio *bio;
> 	struct ppa_addr *ppa_list;
> 	struct nvm_rq rqd;
> 	u64 paddr =3D line->emeta_ssec;
> @@ -867,17 +793,6 @@ int pblk_line_emeta_read(struct pblk *pblk, =
struct pblk_line *line,
> 	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	rq_len =3D rq_ppas * geo->csecs;
>=20
> -	bio =3D pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
> -					l_mg->emeta_alloc_type, =
GFP_KERNEL);
> -	if (IS_ERR(bio)) {
> -		ret =3D PTR_ERR(bio);
> -		goto free_rqd_dma;
> -	}
> -
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -
> -	rqd.bio =3D bio;
> 	rqd.meta_list =3D meta_list;
> 	rqd.ppa_list =3D ppa_list_buf;
> 	rqd.dma_meta_list =3D dma_meta_list;
> @@ -896,7 +811,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> 		while (test_bit(pos, line->blk_bitmap)) {
> 			paddr +=3D min;
> 			if (pblk_boundary_paddr_checks(pblk, paddr)) {
> -				bio_put(bio);
> 				ret =3D -EINTR;
> 				goto free_rqd_dma;
> 			}
> @@ -906,7 +820,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> 		}
>=20
> 		if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
> -			bio_put(bio);
> 			ret =3D -EINTR;
> 			goto free_rqd_dma;
> 		}
> @@ -915,10 +828,9 @@ int pblk_line_emeta_read(struct pblk *pblk, =
struct pblk_line *line,
> 			ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line_id);
> 	}
>=20
> -	ret =3D pblk_submit_io_sync(pblk, &rqd);
> +	ret =3D pblk_submit_io_sync(pblk, &rqd, emeta_buf);
> 	if (ret) {
> 		pblk_err(pblk, "emeta I/O submission failed: %d\n", =
ret);
> -		bio_put(bio);
> 		goto free_rqd_dma;
> 	}
>=20
> @@ -963,7 +875,7 @@ static int pblk_blk_erase_sync(struct pblk *pblk, =
struct ppa_addr ppa)
> 	/* The write thread schedules erases so that it minimizes =
disturbances
> 	 * with writes. Thus, there is no need to take the LUN =
semaphore.
> 	 */
> -	ret =3D pblk_submit_io_sync(pblk, &rqd);
> +	ret =3D pblk_submit_io_sync(pblk, &rqd, NULL);
> 	rqd.private =3D pblk;
> 	__pblk_end_io_erase(pblk, &rqd);
>=20
> @@ -1792,7 +1704,7 @@ int pblk_blk_erase_async(struct pblk *pblk, =
struct ppa_addr ppa)
> 	/* The write thread schedules erases so that it minimizes =
disturbances
> 	 * with writes. Thus, there is no need to take the LUN =
semaphore.
> 	 */
> -	err =3D pblk_submit_io(pblk, rqd);
> +	err =3D pblk_submit_io(pblk, rqd, NULL);
> 	if (err) {
> 		struct nvm_tgt_dev *dev =3D pblk->dev;
> 		struct nvm_geo *geo =3D &dev->geo;
> @@ -1923,7 +1835,6 @@ void pblk_line_close_meta(struct pblk *pblk, =
struct pblk_line *line)
> static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line =
*line)
> {
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	unsigned int lba_list_size =3D lm->emeta_len[2];
> 	struct pblk_w_err_gc *w_err_gc =3D line->w_err_gc;
> 	struct pblk_emeta *emeta =3D line->emeta;
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index d98ea392fe33..d572d4559e4e 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -342,7 +342,7 @@ void pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 		bio_put(int_bio);
> 		int_bio =3D bio_clone_fast(bio, GFP_KERNEL, =
&pblk_bio_set);
> 		goto split_retry;
> -	} else if (pblk_submit_io(pblk, rqd)) {
> +	} else if (pblk_submit_io(pblk, rqd, NULL)) {
> 		/* Submitting IO to drive failed, let's report an error =
*/
> 		rqd->error =3D -ENODEV;
> 		pblk_end_io_read(rqd);
> @@ -419,7 +419,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	struct bio *bio;
> 	struct nvm_rq rqd;
> 	int data_len;
> 	int ret =3D NVM_IO_OK;
> @@ -447,25 +446,12 @@ int pblk_submit_read_gc(struct pblk *pblk, =
struct pblk_gc_rq *gc_rq)
> 		goto out;
>=20
> 	data_len =3D (gc_rq->secs_to_gc) * geo->csecs;
> -	bio =3D pblk_bio_map_addr(pblk, gc_rq->data, gc_rq->secs_to_gc, =
data_len,
> -						PBLK_VMALLOC_META, =
GFP_KERNEL);
> -	if (IS_ERR(bio)) {
> -		pblk_err(pblk, "could not allocate GC bio (%lu)\n",
> -								=
PTR_ERR(bio));
> -		ret =3D PTR_ERR(bio);
> -		goto err_free_dma;
> -	}
> -
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -
> 	rqd.opcode =3D NVM_OP_PREAD;
> 	rqd.nr_ppas =3D gc_rq->secs_to_gc;
> -	rqd.bio =3D bio;
>=20
> -	if (pblk_submit_io_sync(pblk, &rqd)) {
> +	if (pblk_submit_io_sync(pblk, &rqd, gc_rq->data)) {
> 		ret =3D -EIO;
> -		goto err_free_bio;
> +		goto err_free_dma;
> 	}
>=20
> 	pblk_read_check_rand(pblk, &rqd, gc_rq->lba_list, =
gc_rq->nr_secs);
> @@ -489,8 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
> 	pblk_free_rqd_meta(pblk, &rqd);
> 	return ret;
>=20
> -err_free_bio:
> -	bio_put(bio);
> err_free_dma:
> 	pblk_free_rqd_meta(pblk, &rqd);
> 	return ret;
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index e6dda04de144..d5e210c3c5b7 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -178,12 +178,11 @@ static int pblk_recov_pad_line(struct pblk =
*pblk, struct pblk_line *line,
> 	void *meta_list;
> 	struct pblk_pad_rq *pad_rq;
> 	struct nvm_rq *rqd;
> -	struct bio *bio;
> 	struct ppa_addr *ppa_list;
> 	void *data;
> 	__le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> 	u64 w_ptr =3D line->cur_sec;
> -	int left_line_ppas, rq_ppas, rq_len;
> +	int left_line_ppas, rq_ppas;
> 	int i, j;
> 	int ret =3D 0;
>=20
> @@ -212,28 +211,15 @@ static int pblk_recov_pad_line(struct pblk =
*pblk, struct pblk_line *line,
> 		goto fail_complete;
> 	}
>=20
> -	rq_len =3D rq_ppas * geo->csecs;
> -
> -	bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
> -						PBLK_VMALLOC_META, =
GFP_KERNEL);
> -	if (IS_ERR(bio)) {
> -		ret =3D PTR_ERR(bio);
> -		goto fail_complete;
> -	}
> -
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> -
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
>=20
> 	ret =3D pblk_alloc_rqd_meta(pblk, rqd);
> 	if (ret) {
> 		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> -		bio_put(bio);
> 		goto fail_complete;
> 	}
>=20
> -	rqd->bio =3D bio;
> +	rqd->bio =3D NULL;
> 	rqd->opcode =3D NVM_OP_PWRITE;
> 	rqd->is_seq =3D 1;
> 	rqd->nr_ppas =3D rq_ppas;
> @@ -275,13 +261,12 @@ static int pblk_recov_pad_line(struct pblk =
*pblk, struct pblk_line *line,
> 	kref_get(&pad_rq->ref);
> 	pblk_down_chunk(pblk, ppa_list[0]);
>=20
> -	ret =3D pblk_submit_io(pblk, rqd);
> +	ret =3D pblk_submit_io(pblk, rqd, data);
> 	if (ret) {
> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> 		pblk_up_chunk(pblk, ppa_list[0]);
> 		kref_put(&pad_rq->ref, pblk_recov_complete);
> 		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> -		bio_put(bio);
> 		goto fail_complete;
> 	}
>=20
> @@ -375,7 +360,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	struct ppa_addr *ppa_list;
> 	void *meta_list;
> 	struct nvm_rq *rqd;
> -	struct bio *bio;
> 	void *data;
> 	dma_addr_t dma_ppa_list, dma_meta_list;
> 	__le64 *lba_list;
> @@ -407,15 +391,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	rq_len =3D rq_ppas * geo->csecs;
>=20
> retry_rq:
> -	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> -	if (IS_ERR(bio))
> -		return PTR_ERR(bio);
> -
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -	bio_get(bio);
> -
> -	rqd->bio =3D bio;
> +	rqd->bio =3D NULL;
> 	rqd->opcode =3D NVM_OP_PREAD;
> 	rqd->meta_list =3D meta_list;
> 	rqd->nr_ppas =3D rq_ppas;
> @@ -445,10 +421,9 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 				addr_to_gen_ppa(pblk, paddr + j, =
line->id);
> 	}
>=20
> -	ret =3D pblk_submit_io_sync(pblk, rqd);
> +	ret =3D pblk_submit_io_sync(pblk, rqd, data);
> 	if (ret) {
> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> -		bio_put(bio);
> 		return ret;
> 	}
>=20
> @@ -460,24 +435,20 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>=20
> 		if (padded) {
> 			pblk_log_read_err(pblk, rqd);
> -			bio_put(bio);
> 			return -EINTR;
> 		}
>=20
> 		pad_distance =3D pblk_pad_distance(pblk, line);
> 		ret =3D pblk_recov_pad_line(pblk, line, pad_distance);
> 		if (ret) {
> -			bio_put(bio);
> 			return ret;
> 		}
>=20
> 		padded =3D true;
> -		bio_put(bio);
> 		goto retry_rq;
> 	}
>=20
> 	pblk_get_packed_meta(pblk, rqd);
> -	bio_put(bio);
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 4e63f9b5954c..b9a2aeba95ab 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -373,7 +373,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 	struct pblk_emeta *emeta =3D meta_line->emeta;
> 	struct ppa_addr *ppa_list;
> 	struct pblk_g_ctx *m_ctx;
> -	struct bio *bio;
> 	struct nvm_rq *rqd;
> 	void *data;
> 	u64 paddr;
> @@ -391,20 +390,9 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 	rq_len =3D rq_ppas * geo->csecs;
> 	data =3D ((void *)emeta->buf) + emeta->mem;
>=20
> -	bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
> -					l_mg->emeta_alloc_type, =
GFP_KERNEL);
> -	if (IS_ERR(bio)) {
> -		pblk_err(pblk, "failed to map emeta io");
> -		ret =3D PTR_ERR(bio);
> -		goto fail_free_rqd;
> -	}
> -	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> -	rqd->bio =3D bio;
> -
> 	ret =3D pblk_alloc_w_rq(pblk, rqd, rq_ppas, =
pblk_end_io_write_meta);
> 	if (ret)
> -		goto fail_free_bio;
> +		goto fail_free_rqd;
>=20
> 	ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	for (i =3D 0; i < rqd->nr_ppas; ) {
> @@ -423,7 +411,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
>=20
> 	pblk_down_chunk(pblk, ppa_list[0]);
>=20
> -	ret =3D pblk_submit_io(pblk, rqd);
> +	ret =3D pblk_submit_io(pblk, rqd, data);
> 	if (ret) {
> 		pblk_err(pblk, "emeta I/O submission failed: %d\n", =
ret);
> 		goto fail_rollback;
> @@ -437,8 +425,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
> 	list_add(&meta_line->list, &meta_line->list);
> 	spin_unlock(&l_mg->close_lock);
> -fail_free_bio:
> -	bio_put(bio);
> fail_free_rqd:
> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> 	return ret;
> @@ -523,7 +509,7 @@ static int pblk_submit_io_set(struct pblk *pblk, =
struct nvm_rq *rqd)
> 	meta_line =3D pblk_should_submit_meta_io(pblk, rqd);
>=20
> 	/* Submit data write for current data line */
> -	err =3D pblk_submit_io(pblk, rqd);
> +	err =3D pblk_submit_io(pblk, rqd, NULL);
> 	if (err) {
> 		pblk_err(pblk, "data I/O submission failed: %d\n", err);
> 		return NVM_IO_ERR;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index a67855387f53..d515d3409a74 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -783,14 +783,10 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct =
pblk *pblk,
> 					      struct ppa_addr ppa);
> void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
> void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
> -int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
> -int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> -int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd, void *buf);
> +int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd, void =
*buf);
> int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line =
*meta_line);
> void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq =
*rqd);
> -struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
> -			      unsigned int nr_secs, unsigned int len,
> -			      int alloc_type, gfp_t gfp_mask);
> struct pblk_line *pblk_line_get(struct pblk *pblk);
> struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
> struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index d6f121452d5d..ec46693f6b64 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -667,11 +667,14 @@ static struct request =
*nvme_nvm_alloc_request(struct request_queue *q,
> 	return rq;
> }
>=20
> -static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> +static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq =
*rqd,
> +			      void *buf)
> {
> +	struct nvm_geo *geo =3D &dev->geo;
> 	struct request_queue *q =3D dev->q;
> 	struct nvme_nvm_command *cmd;
> 	struct request *rq;
> +	int ret;
>=20
> 	cmd =3D kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
> 	if (!cmd)
> @@ -679,8 +682,15 @@ static int nvme_nvm_submit_io(struct nvm_dev =
*dev, struct nvm_rq *rqd)
>=20
> 	rq =3D nvme_nvm_alloc_request(q, rqd, cmd);
> 	if (IS_ERR(rq)) {
> -		kfree(cmd);
> -		return PTR_ERR(rq);
> +		ret =3D PTR_ERR(rq);
> +		goto err_free_cmd;
> +	}
> +
> +	if (buf) {
> +		ret =3D blk_rq_map_kern(q, rq, buf, geo->csecs * =
rqd->nr_ppas,
> +				GFP_KERNEL);
> +		if (ret)
> +			goto err_free_cmd;
> 	}
>=20
> 	rq->end_io_data =3D rqd;
> @@ -688,6 +698,10 @@ static int nvme_nvm_submit_io(struct nvm_dev =
*dev, struct nvm_rq *rqd)
> 	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
>=20
> 	return 0;
> +
> +err_free_cmd:
> +	kfree(cmd);
> +	return ret;
> }
>=20
> static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char =
*name,
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 8891647b24b1..ee8ec2e68055 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -88,7 +88,7 @@ typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, =
struct ppa_addr, u8 *);
> typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, =
int, int);
> typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
> 							struct =
nvm_chk_meta *);
> -typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
> +typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *, =
void *);
> typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
> typedef void (nvm_destroy_dma_pool_fn)(void *);
> typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
> @@ -680,8 +680,8 @@ extern int nvm_get_chunk_meta(struct nvm_tgt_dev =
*, struct ppa_addr,
> 			      int, struct nvm_chk_meta *);
> extern int nvm_set_chunk_meta(struct nvm_tgt_dev *, struct ppa_addr *,
> 			      int, int);
> -extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
> -extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *);
> +extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *, void =
*);
> +extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *, =
void *);
> extern void nvm_end_io(struct nvm_rq *);
>=20
> #else /* CONFIG_NVM */
> --
> 2.7.4

It=E2=80=99s very good to get rid of pblk_bio_map_addr(). Need to look =
at this
closer because I remember a number of corner cases due to the metadata
allocation. Have you tested the vmalloc allocation path? Note that you
need big lines for this to happen as it will try to do kmalloc if
possible.

Javier

--Apple-Mail=_5C669773-B3C6-4E3A-B374-51EB615AB774
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl1Bnp8ACgkQPEYBfS0l
eOCQ2xAA48uDsIkP9AdJoCth284zw0RI8Yn0AzMZ4+oBadaxijNPsW5wxo/9gfF4
jem56BqdAY4h4KW96C3fpARRxAo50zKlTIQTENek5iVywJDU12XG2X8Ql862YULm
mrHUWzwmE/nHTosdBHmmgvldnNDJTUsI/ewMoIX09F4wtHLFlFwXv1LZPF3czvzL
9DfMpvzf7ik0hVsftKa3tLePjVbwpZS0o0kfLoE0UxtYCcZfuOvuu3CnRGteoK8E
c1L0kNsJ1k5wdjpeZKuii81xj7uv6ujB4+5R4CrvZvYbPaie4dGPgimZEdxucvCD
jgup7r3Kva/1YAKa1BiqyqcX94gZtuj5FDcuUW1hYcjROoivHba5rXx5B/6+9pcJ
D87gJfs4t2/hOiOSWNnYfo34oDPqxMNj23xduk+nQsfgZvqk2vZkPTwHZHzrXUsN
9mc5YQwENAkYlZ7Iw44RtwkIvcx6sqwwfajBHekUwGc6h2nDggrVFIiNMrPnIOtV
gOGwUWhL4NhbwttOxKW/Io2Kq9WeMBs3Y0jZJYHdqljCJHt2KwQrgiWqrPI36zjB
rosPDY2egGtV4fF62jffg/gQuApzVo7l6GJY5MnYCUb7gIC+nljZR2CmosnjReal
zCrZ+S70uQjp71vUD+WyY3SFYU6LSNjyhQ4PNyQK+4v3CUWlQ+0=
=GODo
-----END PGP SIGNATURE-----

--Apple-Mail=_5C669773-B3C6-4E3A-B374-51EB615AB774--
