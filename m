Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9440DC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4705B2083D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="d3rKhKWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfCRHdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:33:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34086 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfCRHdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:33:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id a16so12601724edn.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=wfHwDxTbcr22fOrobceMlXU/hKjHcDT1DGcrUuAyoek=;
        b=d3rKhKWEPA0053Lw8U81daM4c+gilBq97ik0twNDr6A6PhuLjMPjH2yiTyOrXWxoHA
         W9vP5fayTiSD6m2sdDNuQuI1QFGG+HfP3YpHYiWedlHH5xFgsG8VYvjQGWnF6B5hhXH1
         lzSVrztN3DOpAWTR+bhsS8p8g9ZVDJ+qpNV7S3nUMFlEYF22zpLOUaGgFxKkIDQUpLCR
         KZ5VhLZuDd6iPcth4ZAT1mmKiDX8WuefFM4+6ujJXBKz/XOlvIsYSrdk2HZTUCPb2lWv
         Fw6JAUS4SI3pZ1PXTZmisHYsb1Egjb9ktgfLEhtQyjwpbVYugx9L8NM7a1yQvGrjtALa
         1qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=wfHwDxTbcr22fOrobceMlXU/hKjHcDT1DGcrUuAyoek=;
        b=acHngI+qpoEQPqdB8uLU7EjuPOSb2lq7cDvjbH3p133dAJxo6Pfae5SWrDiZwjTiAC
         guyHSNPbaLcQLvYup7HrMD+tMPH6aNby7e7+ay9TvmMlgOQvBLM32AXEnHweY/CDdnIB
         Gw3mW3BT7Fs5g9AWIXxhZkgsMvXPARiPPIm9z/L/arsybS6NwbCGCw4L5z2O6qSKW9G6
         0cd/BfnlLrStCFrr9pO1Iw3G5PqZNHRtM87HINTfJwBKQdwLHn5IKU7om0H8hQKDX57e
         lMH8jBV6fJt/7sX5a31nvJmZKcAoPD6CyLC/fbV5TbEjmXuJ8WWsWj2TCpseIrIjxPiK
         mBYA==
X-Gm-Message-State: APjAAAUvbW4d3NOaaNB/eiq5k7u+fMTnkKx6vvF8YCPN5XHA5jSznexU
        KeeRQqDGGtmI62BwDRQ2O9psvQ==
X-Google-Smtp-Source: APXvYqy51N3tvL8jAlULLsvCxcZztLMUySff6uQewNfBs0ncCHlVWI08gpMALrcNCeXGYqx6tH2P7A==
X-Received: by 2002:a50:b7db:: with SMTP id i27mr12108199ede.202.1552894416495;
        Mon, 18 Mar 2019 00:33:36 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id p25sm2236525ejb.20.2019.03.18.00.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 00:33:35 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <672CA871-E146-45D9-9B8F-384A929EC933@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9E0AC1E0-3100-4375-A8E9-851987B6C771";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 13/18] lightnvm: pblk: store multiple copies of smeta
Date:   Mon, 18 Mar 2019 08:33:34 +0100
In-Reply-To: <20190314160428.3559-14-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-14-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_9E0AC1E0-3100-4375-A8E9-851987B6C771
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently there is only one copy of emeta stored per line in pblk. =
This
                                                           ^^^^^^
smeta?

> is risky, because in case of read error on such a chunk, we are losing
> all the data from whole line, what leads to silent data corruption.
>=20
> This patch changes this behaviour and stores 2 copies of smeta (but
> can be easily increased with kernel parameter to different value) in
> order to provide higher reliability by storing mirrored copies of
> smeta struct and providing possibility to failover to another copy of
> that struct in case of read error. Such an approach ensures that =
copies
> of that critical structures will be stored on different dies and thus
> predicted UBER is multiple times higher
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 125 =
++++++++++++++++++++++++++++++++-------
> drivers/lightnvm/pblk-init.c     |  23 +++++--
> drivers/lightnvm/pblk-recovery.c |   2 +-
> drivers/lightnvm/pblk.h          |   1 +
> 4 files changed, 123 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index a683d1f..4d5cd99 100644
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
> @@ -735,7 +736,8 @@ int pblk_line_smeta_read(struct pblk *pblk, struct =
pblk_line *line)
> 	if (ret)
> 		return ret;
>=20
> -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
> +	bio =3D bio_map_kern(dev->q, line->smeta,
> +			   lm->smeta_len / lm->smeta_copies, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> 		ret =3D PTR_ERR(bio);
> 		goto clear_rqd;
> @@ -746,11 +748,23 @@ int pblk_line_smeta_read(struct pblk *pblk, =
struct pblk_line *line)
>=20
> 	rqd.bio =3D bio;
> 	rqd.opcode =3D NVM_OP_PREAD;
> -	rqd.nr_ppas =3D lm->smeta_sec;
> +	rqd.nr_ppas =3D lm->smeta_sec / lm->smeta_copies;
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
> @@ -771,16 +785,63 @@ int pblk_line_smeta_read(struct pblk *pblk, =
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
> +	int i, ret =3D 0, smeta_sec =3D lm->smeta_sec / =
lm->smeta_copies;
> +	u64 paddr =3D pblk_line_smeta_start(pblk, line);
> +
> +	for (i =3D 0; i < lm->smeta_copies; i++) {
> +		ret =3D pblk_line_smeta_read_copy(pblk, line,
> +						paddr + (i * =
smeta_sec));
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
> +	int smeta_cpy_len =3D lm->smeta_len / lm->smeta_copies;
> +	int smeta_cpy_sec =3D lm->smeta_sec / lm->smeta_copies;
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
> +	if (lm->smeta_sec > pblk->max_write_pgs) {
> +		rq_writes =3D lm->smeta_copies;
> +	} else {
> +		rq_writes =3D 1;
> +		for (i =3D 1; i < lm->smeta_copies; i++) {
> +			memcpy(line->smeta + i * smeta_cpy_len,
> +			       line->smeta, smeta_cpy_len);
> +		}
> +		smeta_cpy_len =3D lm->smeta_len;
> +		smeta_cpy_sec =3D lm->smeta_sec;
> +	}

smeta writes are synchronous, so you can just populate 2 entries in the
vector command. This will help you minimizing the BW spikes with storing
multiple copies. When doing this, you can remove the comment too.

In fact, smeta=E2=80=99s length is calculated so that it takes whole =
writable
pages to avoid mixing it with user data, so with this logic you will
always send 1 commands per smeta copy.

>=20
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>=20
> @@ -788,7 +849,8 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 	if (ret)
> 		return ret;
>=20
> -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
> +next_rq:
> +	bio =3D bio_map_kern(dev->q, line->smeta, smeta_cpy_len, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> 		ret =3D PTR_ERR(bio);
> 		goto clear_rqd;
> @@ -799,15 +861,23 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
>=20
> 	rqd.bio =3D bio;
> 	rqd.opcode =3D NVM_OP_PWRITE;
> -	rqd.nr_ppas =3D lm->smeta_sec;
> +	rqd.nr_ppas =3D smeta_cpy_sec;
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
> +
> +		while (test_bit(pos, line->blk_bitmap)) {
> +			paddr +=3D pblk->min_write_pgs;
> +			ppa =3D addr_to_gen_ppa(pblk, paddr, line->id);
> +			pos =3D pblk_ppa_to_pos(geo, ppa);
> +		}
>=20
> -		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> -		meta->lba =3D lba_list[paddr] =3D addr_empty;
> +		rqd.ppa_list[i] =3D ppa;
> +		pblk_get_meta(pblk, meta_list, i)->lba =3D addr_empty;
> +		lba_list[paddr] =3D addr_empty;
> 	}
>=20
> 	ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> @@ -822,8 +892,13 @@ static int pblk_line_smeta_write(struct pblk =
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
> @@ -1149,7 +1224,7 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	u64 off;
> 	int bit =3D -1;
> -	int emeta_secs;
> +	int emeta_secs, smeta_secs;
>=20
> 	line->sec_in_line =3D lm->sec_per_line;
>=20
> @@ -1165,13 +1240,19 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
> 	}
>=20
> 	/* Mark smeta metadata sectors as bad sectors */
> -	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
> -	off =3D bit * geo->ws_opt;
> -	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
> +	smeta_secs =3D lm->smeta_sec;
> +	bit =3D -1;
> +	while (smeta_secs) {
> +		bit =3D find_next_zero_bit(line->blk_bitmap, =
lm->blk_per_line,
> +					bit + 1);
> +		off =3D bit * geo->ws_opt;
> +		bitmap_set(line->map_bitmap, off, geo->ws_opt);
> +		line->cur_sec =3D off + geo->ws_opt;
> +		smeta_secs -=3D geo->ws_opt;
> +	}

The idea with lm->smeta_sec was to abstract the sectors used for smeta
from ws_opt, as this could change in the future.

What do you think about leaving lm->smeta_sec as the sectors needed for
each copy of smeta and then used the lm->smeta_copies to calculate the
total? (This is done in pblk_line_meta_init(), not here). This way, you
can keep the code here without using ws_opt.

> 	line->sec_in_line -=3D lm->smeta_sec;
> -	line->cur_sec =3D off + lm->smeta_sec;
>=20
> -	if (init && pblk_line_smeta_write(pblk, line, off)) {
> +	if (init && pblk_line_smeta_write(pblk, line)) {
> 		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
> 		return 0;
> 	}
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index b7845f6..e771df6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -27,6 +27,11 @@ static unsigned int write_buffer_size;
> module_param(write_buffer_size, uint, 0644);
> MODULE_PARM_DESC(write_buffer_size, "number of entries in a write =
buffer");
>=20
> +static unsigned int smeta_copies =3D 2;

Can we default to 1?

> [=E2=80=A6]


--Apple-Mail=_9E0AC1E0-3100-4375-A8E9-851987B6C771
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPSc4ACgkQPEYBfS0l
eOBodA//U5n7VsceTbFf/Pn6y+iE6ahXfOQRgxTrwfWWWFO5CJtcerJUk7Z3+1FA
NE2/WeSSNtBZ2Ki4Hh+AH0svrAnoseFB+greffTrA1pFvt/ceeX6pfwBhoo3Pa/i
gHyTycN53JyIGG20fP26AX7V4M1dwxpapavP/RSTQdKnBnY/eOOXT1GRL6itvyOO
3e1gwyFJTYw/ujpe23MxDqHtjnmyz1OFKAWXP4FBFRWLfZ0W9TSw6H+kClYnSRdE
jwK4ch7FmfhXhXlKl+16gGcolqGCwPY+CtUmTHs0u94X/VYGnbS21a7kVMjpkn9D
XoaImeS33EgpMJmX5DZQN1Vc6iuC08DoLQzuZ7U91QrpvF5vCcsCJdkqejK0dssY
raj+z+cLeXYTPTqczL4MzBictGQsRnFkfttAwTq8Br9Mu3IvFho6VCRzkcy0vesJ
Ysbmn5eniJ952qtem0KsfzPH3se+D6f7TlVIHtoA06FKBuicDrdAnTq9XVgJSZbv
V+TpdUgfuL0SxLylThrsNZLw9qdv6v9sni3JCOC0TzXWjdeg0mFgypiH6KFO1Tnh
Dy184IyRBt+TmRCnac/Sb7NL6+u6If1Em4fSQlgKINfQm6gDu73CUX2akwtWYXxv
kCm+iyHub8Mjveuzm3MUD8QxXZg10gT4GupHw11NwdeeAC240h4=
=CfXm
-----END PGP SIGNATURE-----

--Apple-Mail=_9E0AC1E0-3100-4375-A8E9-851987B6C771--
