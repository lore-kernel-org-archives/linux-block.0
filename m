Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99992C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508CC20828
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="vmd/h9HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCRHsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:48:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34131 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRHsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:48:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id a16so12630115edn.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mJYcgd4S4wXTetOmPlrCYxjwd8oLLlMplmE45dwnPW4=;
        b=vmd/h9HYhTxbyPifQ5IIcI7TTgy3evQFoguFD0G+AUPaEwjfrJQn412n7ChhkO+jju
         /IYhMap7QlrdL7ff58RnQi5c0s7wOXYyaDmiIgpUcN2BCwG7tue55TnJD+AOkOYhjK0L
         lfYZ50Gzybo04xr+dvcWkrYOsIvriLEewMtAtSimmQxdlCLiv/ZOZgx2fN2Ik4SEGKPg
         EIIcfHdyDv+1ufT3pb0vNGvx53pjcorEf76fcEmrvG2EOhXU1ptmhrDB3GmKr83ma+SE
         wGB74Zr8vIwAvmh4QbXyYFeQuqwQbjfVaMccdNgw+1sgGdlQCrWscG+Ka93/rYoDSMYw
         nZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mJYcgd4S4wXTetOmPlrCYxjwd8oLLlMplmE45dwnPW4=;
        b=F1f+0NAxQwyl7RzXJQqIPOMtj56x1CY45tKTbBs2D9e8y5Az8Z20tgAPTGYzq1Q6j+
         7dFdBuXsAQ0KCxyPy6rR4IRXHptMIqmWT3cefgsRqL4gAvpM752wzU+l/gFUafH9FDMA
         T32pTlEWFtX8re7zH+wj7vezeHEVshTbAuEC3roVHk9dcwH3INZBoM6Jx7DqS4wRGthX
         8Tch4+cdNBvbZkWnJs/EeOsAOe8SuyXdfOfstymz3OoewnwLl8MBs90EXFRvzaNVJJc9
         rGSIJYNWN4ZEUTWb25hDvn/pjtPrbPM1Bqkog8bjscqpXcrswSWnaL0dC0bxf3TnZKDs
         TJuw==
X-Gm-Message-State: APjAAAVufMCpG15Mh/U2yWSZCINKM1ApnQdbzsbu0KoMh9uHA/eNeO6N
        /aEVhW08WMmN+5MrZaSi9CdUjA==
X-Google-Smtp-Source: APXvYqzi9xp7KJZZXkLJRAhQhYcMdbRP2REA8QoQFOYk8Axza2lr2yBYyocKAQ+BVKngvi7RmeCicg==
X-Received: by 2002:a17:906:5946:: with SMTP id g6mr10449385ejr.58.1552895291109;
        Mon, 18 Mar 2019 00:48:11 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id o1sm2261951eja.18.2019.03.18.00.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 00:48:10 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F540F89F-0451-4E06-B7F2-E45520FB33EA@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3EBCBD0A-A50B-416E-A60C-B6FA6F326311";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 16/18] lightnvm: pblk: use nvm_rq_to_ppa_list()
Date:   Mon, 18 Mar 2019 08:48:09 +0100
In-Reply-To: <20190314160428.3559-17-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-17-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_3EBCBD0A-A50B-416E-A60C-B6FA6F326311
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch replaces few remaining usages of rqd->ppa_list[] with
> existing nvm_rq_to_ppa_list() helpers. This is needed for theoretical
> devices with ws_min/ws_opt equal to 1.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 26 ++++++++++++++------------
> drivers/lightnvm/pblk-recovery.c | 13 ++++++++-----
> 2 files changed, 22 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 6817f8f..7338a44 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -562,11 +562,9 @@ int pblk_submit_io_sync(struct pblk *pblk, struct =
nvm_rq *rqd)
>=20
> int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> {
> -	struct ppa_addr *ppa_list;
> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	int ret;
>=20
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> -
> 	pblk_down_chunk(pblk, ppa_list[0]);
> 	ret =3D pblk_submit_io_sync(pblk, rqd);
> 	pblk_up_chunk(pblk, ppa_list[0]);
> @@ -727,6 +725,7 @@ static int pblk_line_smeta_read_copy(struct pblk =
*pblk,
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct bio *bio;
> +	struct ppa_addr *ppa_list;
> 	struct nvm_rq rqd;
> 	int i, ret;
>=20
> @@ -750,6 +749,7 @@ static int pblk_line_smeta_read_copy(struct pblk =
*pblk,
> 	rqd.opcode =3D NVM_OP_PREAD;
> 	rqd.nr_ppas =3D lm->smeta_sec / lm->smeta_copies;
> 	rqd.is_seq =3D 1;
> +	ppa_list =3D nvm_rq_to_ppa_list(&rqd);
>=20
> 	for (i =3D 0; i < rqd.nr_ppas; i++, paddr++) {
> 		struct ppa_addr ppa =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> @@ -761,7 +761,7 @@ static int pblk_line_smeta_read_copy(struct pblk =
*pblk,
> 			pos =3D pblk_ppa_to_pos(geo, ppa);
> 		}
>=20
> -		rqd.ppa_list[i] =3D ppa;
> +		ppa_list[i] =3D ppa;
> 		pblk_get_meta(pblk, rqd.meta_list, i)->lba =3D
> 				  cpu_to_le64(ADDR_EMPTY);
> 	}
> @@ -812,6 +812,7 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line)
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct bio *bio;
> +	struct ppa_addr *ppa_list;
> 	struct nvm_rq rqd;
> 	__le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> 	__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> @@ -863,6 +864,7 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line)
> 	rqd.opcode =3D NVM_OP_PWRITE;
> 	rqd.nr_ppas =3D smeta_cpy_sec;
> 	rqd.is_seq =3D 1;
> +	ppa_list =3D nvm_rq_to_ppa_list(&rqd);
>=20
> 	for (i =3D 0; i < rqd.nr_ppas; i++, paddr++) {
> 		void *meta_list =3D rqd.meta_list;
> @@ -875,7 +877,7 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line)
> 			pos =3D pblk_ppa_to_pos(geo, ppa);
> 		}
>=20
> -		rqd.ppa_list[i] =3D ppa;
> +		ppa_list[i] =3D ppa;
> 		pblk_get_meta(pblk, meta_list, i)->lba =3D addr_empty;
> 		lba_list[paddr] =3D addr_empty;
> 	}
> @@ -911,8 +913,9 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	void *ppa_list, *meta_list;
> +	void *ppa_list_buf, *meta_list;
> 	struct bio *bio;
> +	struct ppa_addr *ppa_list;
> 	struct nvm_rq rqd;
> 	u64 paddr =3D line->emeta_ssec;
> 	dma_addr_t dma_ppa_list, dma_meta_list;
> @@ -928,7 +931,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> 	if (!meta_list)
> 		return -ENOMEM;
>=20
> -	ppa_list =3D meta_list + pblk_dma_meta_size(pblk);
> +	ppa_list_buf =3D meta_list + pblk_dma_meta_size(pblk);
> 	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size(pblk);
>=20
> next_rq:
> @@ -949,11 +952,12 @@ int pblk_line_emeta_read(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 	rqd.bio =3D bio;
> 	rqd.meta_list =3D meta_list;
> -	rqd.ppa_list =3D ppa_list;
> +	rqd.ppa_list =3D ppa_list_buf;
> 	rqd.dma_meta_list =3D dma_meta_list;
> 	rqd.dma_ppa_list =3D dma_ppa_list;
> 	rqd.opcode =3D NVM_OP_PREAD;
> 	rqd.nr_ppas =3D rq_ppas;
> +	ppa_list =3D nvm_rq_to_ppa_list(&rqd);
>=20
> 	for (i =3D 0; i < rqd.nr_ppas; ) {
> 		struct ppa_addr ppa =3D addr_to_gen_ppa(pblk, paddr, =
line_id);
> @@ -981,7 +985,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> 		}
>=20
> 		for (j =3D 0; j < min; j++, i++, paddr++)
> -			rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line_id);
> +			ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line_id);
> 	}
>=20
> 	ret =3D pblk_submit_io_sync(pblk, &rqd);
> @@ -1608,11 +1612,9 @@ void pblk_ppa_to_line_put(struct pblk *pblk, =
struct ppa_addr ppa)
>=20
> void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
> {
> -	struct ppa_addr *ppa_list;
> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	int i;
>=20
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> -
> 	for (i =3D 0; i < rqd->nr_ppas; i++)
> 		pblk_ppa_to_line_put(pblk, ppa_list[i]);
> }
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 4e4db38..4051b93 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -185,6 +185,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	struct pblk_pad_rq *pad_rq;
> 	struct nvm_rq *rqd;
> 	struct bio *bio;
> +	struct ppa_addr *ppa_list;
> 	void *data;
> 	__le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> 	u64 w_ptr =3D line->cur_sec;
> @@ -245,6 +246,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	rqd->end_io =3D pblk_end_io_recov;
> 	rqd->private =3D pad_rq;
>=20
> +	ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	meta_list =3D rqd->meta_list;
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; ) {
> @@ -272,17 +274,17 @@ static int pblk_recov_pad_line(struct pblk =
*pblk, struct pblk_line *line,
> 			lba_list[w_ptr] =3D addr_empty;
> 			meta =3D pblk_get_meta(pblk, meta_list, i);
> 			meta->lba =3D addr_empty;
> -			rqd->ppa_list[i] =3D dev_ppa;
> +			ppa_list[i] =3D dev_ppa;
> 		}
> 	}
>=20
> 	kref_get(&pad_rq->ref);
> -	pblk_down_chunk(pblk, rqd->ppa_list[0]);
> +	pblk_down_chunk(pblk, ppa_list[0]);
>=20
> 	ret =3D pblk_submit_io(pblk, rqd);
> 	if (ret) {
> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> -		pblk_up_chunk(pblk, rqd->ppa_list[0]);
> +		pblk_up_chunk(pblk, ppa_list[0]);
> 		kref_put(&pad_rq->ref, pblk_recov_complete);
> 		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> 		bio_put(bio);
> @@ -426,6 +428,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	rqd->ppa_list =3D ppa_list;
> 	rqd->dma_ppa_list =3D dma_ppa_list;
> 	rqd->dma_meta_list =3D dma_meta_list;
> +	ppa_list =3D nvm_rq_to_ppa_list(rqd);
>=20
> 	if (pblk_io_aligned(pblk, rq_ppas))
> 		rqd->is_seq =3D 1;
> @@ -444,7 +447,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 		}
>=20
> 		for (j =3D 0; j < pblk->min_write_pgs; j++, i++)
> -			rqd->ppa_list[i] =3D
> +			ppa_list[i] =3D
> 				addr_to_gen_ppa(pblk, paddr + j, =
line->id);
> 	}
>=20
> @@ -500,7 +503,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 			continue;
>=20
> 		line->nr_valid_lbas++;
> -		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
> +		pblk_update_map(pblk, lba, ppa_list[i]);
> 	}
>=20
> 	left_ppas -=3D rq_ppas;
> --
> 2.9.5

This is a good fix. Thanks!

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_3EBCBD0A-A50B-416E-A60C-B6FA6F326311
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPTTkACgkQPEYBfS0l
eOBuLw/7BhTi5SI1zONzx4iNOtsAUAhirOxBvO2YJMJJHXjmx+w+pmcHT6ofBd5y
rYb4rZMprJCgdL5kk7UOCgnYgyFigNTXEMWQ4DPoSDna0AhuSSco5doQsXWd0VEb
XLlOZIFhQ4jL0aIaQAoakGz7ESGr8y7SLNUeHsw0xl97PHel+TgCe8KRIGZxJtvh
1Xjbnm2jPo8WDT8a7mcraPi0yb6prScmsMo5SrbAIzKtUwIYmkEEnfZHM8UzDqhv
i7pyyCsCC9Vk98W+L2a3yayrr1vCxoytGynshV8zIH6C1HsALqdaIc7fU+fVF81X
qiupocgMqxBnxyfX/bcsaAfq3Fn/bUG8Nm9yw0qg+2iisU8b1nV28eyIn8zHgCuV
zPX+rZDofxd9VA6zoArxu2+8L4lYXs1QrjdEisDAzlzqAFalQWwdrVp2+zXFnTmI
aBSsmD/2YF6agE/+jUWlskCyZ3xtyY7Xnzk6VyzSjdIRVOk8BMT31VXiq2Z3VIv2
c4brzNyw1CdLNQKAKbY+EEsf6/XM5c5aH8rlif0GUaYjaR3slzmkZPrxSHBe9Eb4
K+O9Rcno084WL8rGmEoXR7TfBXM0QTszjtTrj+z9Zn54KGt9ZctNXB1q6xVzoQ0t
RI97bOYt1Ib2G1AHrtQQPCSV7O5DefPDpP4tYGisbooXHOm+sWU=
=q4Cg
-----END PGP SIGNATURE-----

--Apple-Mail=_3EBCBD0A-A50B-416E-A60C-B6FA6F326311--
