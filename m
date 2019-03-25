Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A8CC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1734920811
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ztXYcTo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfCYGbN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:31:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34738 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfCYGbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 02:31:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id x14so3807913eds.1
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6JSfY4HEVM9+IKEAmE8SvCavHFwtSzN24n30NPj6LzI=;
        b=ztXYcTo4/E7ZXPMaU+0HxAdGVw+m/DGzOM8aBl+wVvZoN81/1+dq+pRo+5ZQ6VA9Xh
         s2Gy+RvkWF6mEFUobwMJoNtRmlnql8abOwI8Fh4rMpeGEqvRrPLHTFh+oZT1TY7O/VG3
         BLwduGb+plA1qZl9c2jSWGwIO1dYVqWl8mbLN2BAoFkqyTXGV53bHY5M1jTwme6ch8bo
         Uc/vQkUyNinbYhgYP+qXpumrLgrHRA8nFW4IaDBPqaxOBbuekvHhm9kV0ilg18Druaaw
         xTCpjH2DUArz0Rww3i8TgegxVzNerHe6+CzJA0/WDhLP58fZTjjNsh7Vd+YLq53BKASO
         GzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6JSfY4HEVM9+IKEAmE8SvCavHFwtSzN24n30NPj6LzI=;
        b=h8GTvoqrSr0ROqz9WAF26shTb5MIGwpP37rIkP+hc5G1D3kqxXYUpqpci47xffdYew
         kvH4Ad2MQKyBjgWIz96TOIN3VkO/QLHfSWaneKuUKQW7CfWp+6tpejLkgCUBSQSokoni
         XLzQRczEHhWac3mQ5FXmlkeVdJpwQW828wmVelaAtYrguYICn2Zg3ewVEuk9L60ElI5F
         KcfsXu8rnd+bagkoH7LaNuHIv5w2IGVPCs3casXguN+GkKIKF3qYjin3j454A/ib4Y3d
         aJFXiwZOgSoEipto0BqyIodIJqrelclRNJmxzx5vELuTdWLap5SR8tuamkaqFz1IbaZk
         NiqQ==
X-Gm-Message-State: APjAAAW7reAURquq0FJmgOEKNdmuktfClUHn75x/wouFyuxI8hT8MCAb
        m5CYES0enup2EklEybSH+rnMCV+Ls+0=
X-Google-Smtp-Source: APXvYqy9JJuQIHImuGSoOUcZoMYlOqzWVyseNgpQBW5Bv3YPApgJNZvsRcSNX6C284e2PApA6rgm9Q==
X-Received: by 2002:aa7:c48b:: with SMTP id m11mr2926758edq.203.1553495470612;
        Sun, 24 Mar 2019 23:31:10 -0700 (PDT)
Received: from [172.30.99.70] ([37.120.153.227])
        by smtp.gmail.com with ESMTPSA id l9sm1595630edr.48.2019.03.24.23.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:31:10 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <BA1021D5-2016-4431-A81D-BF1EDC84996A@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_562D7EB3-2914-4175-80F7-D7B005AF6529";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 13/16] lightnvm: pblk: store multiple copies of smeta
Date:   Mon, 25 Mar 2019 14:31:04 +0800
In-Reply-To: <20190322144843.9602-14-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-14-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_562D7EB3-2914-4175-80F7-D7B005AF6529
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently there is only one copy of smeta stored per line in pblk. =
This
> is risky, because in case of read error on such a chunk, we are losing
> all the data from whole line, what leads to silent data corruption.
>=20
> This patch changes this behaviour and allows to store more then one
> copy of the smeta (specified by module parameter) in order to provide
> higher reliability by storing mirrored copies of smeta struct and
> providing possibility to failover to another copy of that struct in
> case of read error. Such an approach ensures that copies of that
> critical structures will be stored on different dies and thus =
predicted
> UBER is multiple times higher
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 124 =
++++++++++++++++++++++++++++++++-------
> drivers/lightnvm/pblk-init.c     |  23 ++++++--
> drivers/lightnvm/pblk-recovery.c |  14 +++--
> drivers/lightnvm/pblk-rl.c       |   3 +-
> drivers/lightnvm/pblk.h          |   1 +
> 5 files changed, 132 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 06ac3f0..9d9a9e2 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -720,13 +720,14 @@ u64 pblk_line_smeta_start(struct pblk *pblk, =
struct pblk_line *line)
> 	return bit * geo->ws_opt;
> }
>=20
> -int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
> +static int pblk_line_smeta_read_copy(struct pblk *pblk,
> +				     struct pblk_line *line, u64 paddr)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct bio *bio;
> 	struct nvm_rq rqd;
> -	u64 paddr =3D pblk_line_smeta_start(pblk, line);
> 	int i, ret;
>=20
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
> @@ -749,8 +750,20 @@ int pblk_line_smeta_read(struct pblk *pblk, =
struct pblk_line *line)
> 	rqd.nr_ppas =3D lm->smeta_sec;
> 	rqd.is_seq =3D 1;
>=20
> -	for (i =3D 0; i < lm->smeta_sec; i++, paddr++)
> -		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> +	for (i =3D 0; i < rqd.nr_ppas; i++, paddr++) {
> +		struct ppa_addr ppa =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> +		int pos =3D pblk_ppa_to_pos(geo, ppa);
> +
> +		while (test_bit(pos, line->blk_bitmap)) {
> +			paddr +=3D pblk->min_write_pgs;
> +			ppa =3D addr_to_gen_ppa(pblk, paddr, line->id);
> +			pos =3D pblk_ppa_to_pos(geo, ppa);
> +		}
> +
> +		rqd.ppa_list[i] =3D ppa;
> +		pblk_get_meta(pblk, rqd.meta_list, i)->lba =3D
> +				  cpu_to_le64(ADDR_EMPTY);
> +	}
>=20
> 	ret =3D pblk_submit_io_sync(pblk, &rqd);
> 	if (ret) {
> @@ -771,16 +784,63 @@ int pblk_line_smeta_read(struct pblk *pblk, =
struct pblk_line *line)
> 	return ret;
> }
>=20
> -static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line =
*line,
> -				 u64 paddr)
> +int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
> +{
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> +	int i, ret =3D 0;
> +	u64 paddr =3D pblk_line_smeta_start(pblk, line);
> +
> +	for (i =3D 0; i < lm->smeta_copies; i++) {
> +		ret =3D pblk_line_smeta_read_copy(pblk, line,
> +						paddr + (i * =
lm->smeta_sec));
> +		if (!ret) {
> +			/*
> +			 * Just one successfully read copy of smeta is
> +			 * enough for us for recovery, don't need to
> +			 * read another one.
> +			 */
> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line =
*line)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct bio *bio;
> 	struct nvm_rq rqd;
> 	__le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> 	__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> -	int i, ret;
> +	u64 paddr =3D 0;
> +	int smeta_wr_len =3D lm->smeta_len;
> +	int smeta_wr_sec =3D lm->smeta_sec;
> +	int i, ret, rq_writes;
> +
> +	/*
> +	 * Check if we can write all the smeta copies with
> +	 * a single write command.
> +	 * If yes -> copy smeta sector into multiple copies
> +	 * in buffer to write.
> +	 * If no -> issue writes one by one using the same
> +	 * buffer space.
> +	 * Only if all the copies are written correctly
> +	 * we are treating this line as valid for proper
> +	 * UBER reliability.
> +	 */
> +	if (lm->smeta_sec * lm->smeta_copies > pblk->max_write_pgs) {
> +		rq_writes =3D lm->smeta_copies;
> +	} else {
> +		rq_writes =3D 1;
> +		for (i =3D 1; i < lm->smeta_copies; i++) {
> +			memcpy(line->smeta + i * lm->smeta_len,
> +			       line->smeta, lm->smeta_len);
> +		}
> +		smeta_wr_len *=3D lm->smeta_copies;
> +		smeta_wr_sec *=3D lm->smeta_copies;
> +	}
>=20
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>=20
> @@ -788,7 +848,8 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 	if (ret)
> 		return ret;
>=20
> -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
> +next_rq:
> +	bio =3D bio_map_kern(dev->q, line->smeta, smeta_wr_len, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> 		ret =3D PTR_ERR(bio);
> 		goto clear_rqd;
> @@ -799,15 +860,23 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
>=20
> 	rqd.bio =3D bio;
> 	rqd.opcode =3D NVM_OP_PWRITE;
> -	rqd.nr_ppas =3D lm->smeta_sec;
> +	rqd.nr_ppas =3D smeta_wr_sec;
> 	rqd.is_seq =3D 1;
>=20
> -	for (i =3D 0; i < lm->smeta_sec; i++, paddr++) {
> -		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk,
> -							   =
rqd.meta_list, i);
> +	for (i =3D 0; i < rqd.nr_ppas; i++, paddr++) {
> +		void *meta_list =3D rqd.meta_list;
> +		struct ppa_addr ppa =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> +		int pos =3D pblk_ppa_to_pos(geo, ppa);
>=20
> -		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> -		meta->lba =3D lba_list[paddr] =3D addr_empty;
> +		while (test_bit(pos, line->blk_bitmap)) {
> +			paddr +=3D pblk->min_write_pgs;
> +			ppa =3D addr_to_gen_ppa(pblk, paddr, line->id);
> +			pos =3D pblk_ppa_to_pos(geo, ppa);
> +		}
> +
> +		rqd.ppa_list[i] =3D ppa;
> +		pblk_get_meta(pblk, meta_list, i)->lba =3D addr_empty;
> +		lba_list[paddr] =3D addr_empty;
> 	}
>=20
> 	ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> @@ -822,8 +891,13 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 	if (rqd.error) {
> 		pblk_log_write_err(pblk, &rqd);
> 		ret =3D -EIO;
> +		goto clear_rqd;
> 	}
>=20
> +	rq_writes--;
> +	if (rq_writes > 0)
> +		goto next_rq;
> +
> clear_rqd:
> 	pblk_free_rqd_meta(pblk, &rqd);
> 	return ret;
> @@ -1020,7 +1094,7 @@ static void pblk_line_setup_metadata(struct =
pblk_line *line,
> 	line->smeta =3D l_mg->sline_meta[meta_line];
> 	line->emeta =3D l_mg->eline_meta[meta_line];
>=20
> -	memset(line->smeta, 0, lm->smeta_len);
> +	memset(line->smeta, 0, lm->smeta_len * lm->smeta_copies);
> 	memset(line->emeta->buf, 0, lm->emeta_len[0]);
>=20
> 	line->emeta->mem =3D 0;
> @@ -1147,7 +1221,7 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	u64 off;
> 	int bit =3D -1;
> -	int emeta_secs;
> +	int emeta_secs, smeta_secs;
>=20
> 	line->sec_in_line =3D lm->sec_per_line;
>=20
> @@ -1163,13 +1237,19 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
> 	}
>=20
> 	/* Mark smeta metadata sectors as bad sectors */
> -	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
> -	off =3D bit * geo->ws_opt;
> -	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
> -	line->sec_in_line -=3D lm->smeta_sec;
> -	line->cur_sec =3D off + lm->smeta_sec;
> +	smeta_secs =3D lm->smeta_sec * lm->smeta_copies;
> +	bit =3D -1;
> +	while (smeta_secs) {
> +		bit =3D find_next_zero_bit(line->blk_bitmap, =
lm->blk_per_line,
> +					bit + 1);
> +		off =3D bit * geo->ws_opt;
> +		bitmap_set(line->map_bitmap, off, geo->ws_opt);
> +		line->cur_sec =3D off + geo->ws_opt;
> +		smeta_secs -=3D lm->smeta_sec;
> +	}
> +	line->sec_in_line -=3D (lm->smeta_sec * lm->smeta_copies);
>=20
> -	if (init && pblk_line_smeta_write(pblk, line, off)) {
> +	if (init && pblk_line_smeta_write(pblk, line)) {
> 		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
> 		return 0;
> 	}
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 4211cd1..5717ad4 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -27,6 +27,11 @@ static unsigned int write_buffer_size;
> module_param(write_buffer_size, uint, 0644);
> MODULE_PARM_DESC(write_buffer_size, "number of entries in a write =
buffer");
>=20
> +static unsigned int smeta_copies =3D 1;
> +
> +module_param(smeta_copies, int, 0644);
> +MODULE_PARM_DESC(smeta_copies, "number of smeta copies");
> +
> struct pblk_global_caches {
> 	struct kmem_cache	*ws;
> 	struct kmem_cache	*rec;
> @@ -867,7 +872,8 @@ static int pblk_line_mg_init(struct pblk *pblk)
> 	 * emeta depends on the number of LUNs allocated to the pblk =
instance
> 	 */
> 	for (i =3D 0; i < PBLK_DATA_LINES; i++) {
> -		l_mg->sline_meta[i] =3D kmalloc(lm->smeta_len, =
GFP_KERNEL);
> +		l_mg->sline_meta[i] =3D kmalloc(lm->smeta_len
> +						* lm->smeta_copies, =
GFP_KERNEL);
> 		if (!l_mg->sline_meta[i])
> 			goto fail_free_smeta;
> 	}
> @@ -967,6 +973,12 @@ static int pblk_line_meta_init(struct pblk *pblk)
> 	lm->mid_thrs =3D lm->sec_per_line / 2;
> 	lm->high_thrs =3D lm->sec_per_line / 4;
> 	lm->meta_distance =3D (geo->all_luns / 2) * pblk->min_write_pgs;
> +	lm->smeta_copies =3D smeta_copies;
> +
> +	if (lm->smeta_copies < 1 || lm->smeta_copies > geo->all_luns) {
> +		pblk_err(pblk, "unsupported smeta copies parameter\n");
> +		return -EINVAL;
> +	}
>=20
> 	/* Calculate necessary pages for smeta. See comment over struct
> 	 * line_smeta definition
> @@ -998,10 +1010,11 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
>=20
> 	lm->emeta_bb =3D geo->all_luns > i ? geo->all_luns - i : 0;
>=20
> -	lm->min_blk_line =3D 1;
> -	if (geo->all_luns > 1)
> -		lm->min_blk_line +=3D DIV_ROUND_UP(lm->smeta_sec +
> -					lm->emeta_sec[0], geo->clba);
> +	lm->min_blk_line =3D lm->smeta_copies;
> +	if (geo->all_luns > lm->smeta_copies) {
> +		lm->min_blk_line +=3D DIV_ROUND_UP((lm->smeta_sec
> +			* lm->smeta_copies) + lm->emeta_sec[0], =
geo->clba);
> +	}
>=20
> 	if (lm->min_blk_line > lm->blk_per_line) {
> 		pblk_err(pblk, "config. not supported. Min. LUN in =
line:%d\n",
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 74e5b17..038931d 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -51,7 +51,8 @@ static int pblk_recov_l2p_from_emeta(struct pblk =
*pblk, struct pblk_line *line)
> 	if (!lba_list)
> 		return 1;
>=20
> -	data_start =3D pblk_line_smeta_start(pblk, line) + =
lm->smeta_sec;
> +	data_start =3D pblk_line_smeta_start(pblk, line)
> +					+ (lm->smeta_sec * =
lm->smeta_copies);
> 	data_end =3D line->emeta_ssec;
> 	nr_valid_lbas =3D le64_to_cpu(emeta_buf->nr_valid_lbas);
>=20
> @@ -140,7 +141,8 @@ static u64 pblk_sec_in_open_line(struct pblk =
*pblk, struct pblk_line *line)
> 	if (lm->blk_per_line - nr_bb !=3D valid_chunks)
> 		pblk_err(pblk, "recovery line %d is bad\n", line->id);
>=20
> -	pblk_update_line_wp(pblk, line, written_secs - lm->smeta_sec);
> +	pblk_update_line_wp(pblk, line, written_secs -
> +					(lm->smeta_sec * =
lm->smeta_copies));
>=20
> 	return written_secs;
> }
> @@ -383,12 +385,14 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
> 	void *data;
> 	dma_addr_t dma_ppa_list, dma_meta_list;
> 	__le64 *lba_list;
> -	u64 paddr =3D pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
> +	u64 paddr =3D pblk_line_smeta_start(pblk, line) +
> +					(lm->smeta_sec * =
lm->smeta_copies);
> 	bool padded =3D false;
> 	int rq_ppas, rq_len;
> 	int i, j;
> 	int ret;
> -	u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - =
lm->smeta_sec;
> +	u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) -
> +					(lm->smeta_sec * =
lm->smeta_copies);
>=20
> 	if (pblk_line_wps_are_unbalanced(pblk, line))
> 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", =
line->id);
> @@ -722,7 +726,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>=20
> 		line =3D &pblk->lines[i];
>=20
> -		memset(smeta, 0, lm->smeta_len);
> +		memset(smeta, 0, lm->smeta_len * lm->smeta_copies);
> 		line->smeta =3D smeta;
> 		line->lun_bitmap =3D ((void *)(smeta_buf)) +
> 						sizeof(struct =
line_smeta);
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index b014957..944372c 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -218,7 +218,8 @@ void pblk_rl_init(struct pblk_rl *rl, int budget, =
int threshold)
> 	unsigned int rb_windows;
>=20
> 	/* Consider sectors used for metadata */
> -	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
> +	sec_meta =3D ((lm->smeta_sec * lm->smeta_copies)
> +			+ lm->emeta_sec[0]) * l_mg->nr_free_lines;
> 	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
>=20
> 	rl->high =3D pblk->op_blks - blk_meta - lm->blk_per_line;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 3a84c8a..0999245 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -547,6 +547,7 @@ struct pblk_line_mgmt {
> struct pblk_line_meta {
> 	unsigned int smeta_len;		/* Total length for smeta */
> 	unsigned int smeta_sec;		/* Sectors needed for smeta */
> +	unsigned int smeta_copies;	/* Number of smeta copies */
>=20
> 	unsigned int emeta_len[4];	/* Lengths for emeta:
> 					 *  [0]: Total
> --
> 2.9.5

Looks good.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_562D7EB3-2914-4175-80F7-D7B005AF6529
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyYdagACgkQPEYBfS0l
eOBZdQ/8CBFFeu9/4a8xcU8nhHb6RQQFJ9Z9DOsvKPtv6KPqTbE0MRzGDfpriHc9
xQ5iCtW0+puutGV9t/ypoY/sCieijuUt+oLgw/n2XdoVfs9cpJ9sjtc3zk34j6Cw
6Hl3E5sVivfUWfNqqZ6QbDoNz3aK7d2aBnlGrp12wGD1qBTha1URG6jjaHxjgRS+
UF4Gt3mrlEcGOp9E+T/UINfSAXA0HS1EFVIuDI2c7EXt+K4foUrCtFwOdhhbUrAp
BjQDRD1Z2yPWhytjyMZa5wOpaZg7yR9hO8XXUzRJ/W3eF+FRAQwHNWT4UPWgp8AZ
PDohMhs77N3UAFNgrA+xf3pLDnFaD7g9DldY5JWM6dcZvobt4WdlI9G9HYeJAFH4
IlUo5LptbDZXGPYmxSXMZGj4N9aiWx4KKX1R46qy3nSKwdDbrORs5ciJltIWv2+n
mghq4PzRb31ri5llkdJoFMGVOuvVX0zEVs4RNWyf2TrM5brHgXzUtGGbpGKBs1Aa
6YQ/stR7O1L8K2Z0FC9nYnQtrW6a96w7jtgvkOQeVW7x1FX5MnpmVTfvxQvC5Fpi
vNjJjtn8o5XJdzVQLQnCe9f+N6dNCW/1t+o2USl1Va96Z1vxtf2prNKqvWjevMXd
C871OQ/pkDEdLAT2S+zuXl+PxZ8aS72SPLMhONOlFgcesTyLpr0=
=8aGt
-----END PGP SIGNATURE-----

--Apple-Mail=_562D7EB3-2914-4175-80F7-D7B005AF6529--
