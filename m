Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC73C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D5D218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="aYI940D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfAXOsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:48:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43865 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfAXOsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 09:48:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so4763692eds.10
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JkUya7J7mb6PwItb8j8g6qDTLWdjQ0EAK0iNiKy/kyQ=;
        b=aYI940D/9HzqEGH09GuNqZVCTTKwZiBiHJr6dOkgUiTZsM6+Yd1yvngzYoQnmBbXDE
         PcbJBlPgAxV3R0RnnaEM/8dnqwvkfDMK9TN8a+E55e9VlofNYL4TR/UZHlnHaQYaZPdW
         1CBdj3DIKKMPXwCt5C0fn7owP73N1eSaV1H5TxFbBm6TLxDI3hKRfW/5hxXKNnknOxKo
         TgJse+q2eS7AVNNCCtCoZh4MBtSi9YsSusEkP4CBXSuCBhCL89i82CBWUFkjZijJF5Ho
         MBkNA0ixZ7yVqUNy3Xt0Vaxl5fhenbwhPy92FJQ9aDxpw7kiUeOv0BH+evBY00EDx7V0
         J3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JkUya7J7mb6PwItb8j8g6qDTLWdjQ0EAK0iNiKy/kyQ=;
        b=l/sfLK2bZ9GqZOn5tdPRCr5g7pFFAlA9Xz/OUDWwB2g5ptuyywaStOpGdpYXok8K7N
         H5xLkwp47gRemx7VTb1hPRR6SPpxtnEyNRVROdy0KB+KZqUqHUzbMPSjMzYuYLq7QObt
         8OYusyLUZ4OVebAicx3WKsvl4r4+mcGBx6Ab262Ik1pK5t9aco4N7+G42w+t0LrZWK57
         2WlDhfBKuUw5Btkcb8YjG++vMsV+r6jNuFv9J8wSglwQ25iRVbLioRT1oXRHAaN9Bbv2
         jYwbTD/t3dU8SrQRVD2cUEZf59LND6BSdNLBxww6QLeGzOBhBx+sw8j7j3qN2vg02k+f
         NCOg==
X-Gm-Message-State: AJcUukdDwh7JMMqa9L2Dy2nek8p2uab4rpYZ/tyRhEur3vq+34Y5zMgk
        nygS1TylpYe6oDPdds8ZNIZVHg==
X-Google-Smtp-Source: ALg8bN4gTlLAMx/qI4OfU1hTBW065OhKxiwnyHxbMFHq1xKO64yViBmSEH+GTggH1ENeKBZdbgfJOQ==
X-Received: by 2002:a17:906:1102:: with SMTP id h2-v6mr6159991eja.18.1548341296691;
        Thu, 24 Jan 2019 06:48:16 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id cf6sm239113ejb.45.2019.01.24.06.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:48:16 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <CFF46050-060F-411D-95E7-E1D9A8E6F8B1@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_ED2BE341-6551-4FDC-94E2-596DE8A640C3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] lightnvm: pblk: Switch to use new generic UUID API
Date:   Thu, 24 Jan 2019 15:48:15 +0100
In-Reply-To: <20190124143137.13880-1-andriy.shevchenko@linux.intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190124143137.13880-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_ED2BE341-6551-4FDC-94E2-596DE8A640C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Jan 2019, at 15.31, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>=20
> There are new types and helpers that are supposed to be used in new =
code.
>=20
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> v2:
> - convert instance_uuid to guid_t and get rid of pblk_setup_uuid()
> - fix subject line to show subsystem
>=20
> drivers/lightnvm/pblk-core.c     |  4 ++--
> drivers/lightnvm/pblk-init.c     |  2 +-
> drivers/lightnvm/pblk-recovery.c |  8 +++++---
> drivers/lightnvm/pblk.h          | 10 +---------
> 4 files changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 1ff165351180..189339965957 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1065,7 +1065,7 @@ static int pblk_line_init_metadata(struct pblk =
*pblk, struct pblk_line *line,
> 	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
>=20
> 	smeta_buf->header.identifier =3D cpu_to_le32(PBLK_MAGIC);
> -	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
> +	guid_copy((guid_t *)&smeta_buf->header.uuid, =
&pblk->instance_uuid);
> 	smeta_buf->header.id =3D cpu_to_le32(line->id);
> 	smeta_buf->header.type =3D cpu_to_le16(line->type);
> 	smeta_buf->header.version_major =3D SMETA_VERSION_MAJOR;
> @@ -1874,7 +1874,7 @@ void pblk_line_close_meta(struct pblk *pblk, =
struct pblk_line *line)
>=20
> 	if (le32_to_cpu(emeta_buf->header.identifier) !=3D PBLK_MAGIC) {
> 		emeta_buf->header.identifier =3D =
cpu_to_le32(PBLK_MAGIC);
> -		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
> +		guid_copy((guid_t *)&emeta_buf->header.uuid, =
&pblk->instance_uuid);
> 		emeta_buf->header.id =3D cpu_to_le32(line->id);
> 		emeta_buf->header.type =3D cpu_to_le16(line->type);
> 		emeta_buf->header.version_major =3D EMETA_VERSION_MAJOR;
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index f9a3e47b6a93..5768333d103f 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -130,7 +130,7 @@ static int pblk_l2p_recover(struct pblk *pblk, =
bool factory_init)
> 	struct pblk_line *line =3D NULL;
>=20
> 	if (factory_init) {
> -		pblk_setup_uuid(pblk);
> +		guid_gen(&pblk->instance_uuid);
> 	} else {
> 		line =3D pblk_recov_l2p(pblk);
> 		if (IS_ERR(line)) {
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 5ee20da7bdb3..6761d2afa4d0 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -703,11 +703,13 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>=20
> 		/* The first valid instance uuid is used for =
initialization */
> 		if (!valid_uuid) {
> -			memcpy(pblk->instance_uuid, =
smeta_buf->header.uuid, 16);
> +			guid_copy(&pblk->instance_uuid,
> +				  (guid_t *)&smeta_buf->header.uuid);
> 			valid_uuid =3D 1;
> 		}
>=20
> -		if (memcmp(pblk->instance_uuid, smeta_buf->header.uuid, =
16)) {
> +		if (!guid_equal(&pblk->instance_uuid,
> +				(guid_t *)&smeta_buf->header.uuid)) {
> 			pblk_debug(pblk, "ignore line %u due to uuid =
mismatch\n",
> 					i);
> 			continue;
> @@ -737,7 +739,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 	}
>=20
> 	if (!found_lines) {
> -		pblk_setup_uuid(pblk);
> +		guid_gen(&pblk->instance_uuid);
>=20
> 		spin_lock(&l_mg->free_lock);
> 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 85e38ed62f85..12bf02df4204 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -646,7 +646,7 @@ struct pblk {
>=20
> 	int sec_per_write;
>=20
> -	unsigned char instance_uuid[16];
> +	guid_t instance_uuid;
>=20
> 	/* Persistent write amplification counters, 4kb sector I/Os */
> 	atomic64_t user_wa;		/* Sectors written by user */
> @@ -1360,14 +1360,6 @@ static inline unsigned int pblk_get_secs(struct =
bio *bio)
> 	return  bio->bi_iter.bi_size / PBLK_EXPOSED_PAGE_SIZE;
> }
>=20
> -static inline void pblk_setup_uuid(struct pblk *pblk)
> -{
> -	uuid_le uuid;
> -
> -	uuid_le_gen(&uuid);
> -	memcpy(pblk->instance_uuid, uuid.b, 16);
> -}
> -
> static inline char *pblk_disk_name(struct pblk *pblk)
> {
> 	struct gendisk *disk =3D pblk->disk;
> --
> 2.20.1

Looks good to me. Thanks Andy.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_ED2BE341-6551-4FDC-94E2-596DE8A640C3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJ0C8ACgkQPEYBfS0l
eOA/rw//dJAadFjxb/daXk5sHgXRe82U2KrYnVvpDKvS3axFm5EXYrDRybxqhLrd
Ibpa4lZSvYVTs4TsZclHT2QeKaFxgPZ/f3rSAj4EK/wcM1HA5QOS9wy2fTOXBHdJ
DCKlbzduFYo9MGdGsjLhkc24tlU8DqqFUG1HpdPvhJSOMVmtdioszjb1gNOMub4K
M6+DHvO3xlHFGbaon6BKsCTjPNMi8Cme1Dmbb0iPOw7d7eOBbSxWwZ2baNL1jazm
J1lhfsLn3oYTrCp07lUAjLrUM5ga3r5N8tMOAiUVRKnEqo0QEvOFpdYMy/X6bA0x
RqoPii5Je7MiomyKo//sRecJwiGsHgw1jTauHOhvxaPaGjFmSNKnRzZlFsoNfciq
bz28Ut/L1dLVEuaZupBirOV06ftmqCiQO3figBDhpOV/R1yzB5ICCqxXHsJVdRjM
7ahAR2T/gvPLs5cA+dVSEieM/loe2mAPcxT9VMlfjZd2y5BIO4x8nIbFOK6SjWAN
UmJyjFkj02FmTxxCOW/6kVqE91JoRdVjPg8xJrWTYljfRQLUjnwxuEF2wDgPTSRq
IveuP07x0uH4yRYQPvcknOXVuIt0/BZHUe5T6abpZsovoWLG2bJb/3+Si86uuBuv
jQcRdBXuQLYDud7cnPq2lqHNpw2UqH8zcWREYa9p/mFhO8vAbmo=
=ZIxO
-----END PGP SIGNATURE-----

--Apple-Mail=_ED2BE341-6551-4FDC-94E2-596DE8A640C3--
