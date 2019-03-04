Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC58BC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6978220823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zZdyRJaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfCDIRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:17:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35557 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDIRb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 03:17:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so3483777edp.2
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 00:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2rUwlQ9JFeezxAulHYPH4564JAl8OmtbLikGqKoIvsE=;
        b=zZdyRJaK0JrhWwKDPBs6IxXMpJXh4yrHGSxMNyO7QRh4NVDLZEiyCavSLN2r8Ljoad
         rCUuD8XTS4HCSSO1laICKbHJiAgMW+khOY6e64Dsi3iL5jHZM6dqFPqmvpGt/4H2F10B
         wNwxhwr1kOJfZQeKQQv4aAjsIbz1wZWJLRhj/Si03fjnXiY/OzLJ4P2A9ajAjOdQAleQ
         4et/zUFzcdXAallnCaiT2kx3zbKEMs+Fk0G0zJ92IxDVzARRibiaUcyZyiWCevdWfGDp
         siefBZm05feaMoG0gX/NH3IQf/8CY9j7VY5xi+mWCZljeSoNKUiBrOJ9bEYO6INAIYqv
         NP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2rUwlQ9JFeezxAulHYPH4564JAl8OmtbLikGqKoIvsE=;
        b=gnApJiPpDHZlSjtqhq+/l9SHABl+Zj5bLk2yHAnp8FXHwxOJmupAwtL3d8jFVtp4Qy
         LTwt8Fb1CU/HXBsvSX86bLn7P+LaBmA3WYEZfGsdgtXYDVrzaDFdIrogkcYbJ/Tv0iUG
         ob2dIZ32jYck8mjuay9HpekJpxS33tofSEQ/PgD4q3xUS3dwPRu8B8SGv6+quwy9Lfi3
         /my/iGMmpoOktCeV7ZoAPmJrNZEmEUpzlAvlpr4c4SeZFDzQSWQrvCZ80Xji4uQrCMFf
         KbRlEac9yiIB6CVg6KmiFZT+QubJQUOKriMtVCP/Wj+tGV2L785FXAsXfFu7ZL5kniYz
         Tcqw==
X-Gm-Message-State: APjAAAVH1v82QQv+dpqE0O8U/aaGX39JcHt3Wx275q6EVvBvLKVIpcOG
        Ht/XrbRqu4WstoOfy5qUKTuUqA==
X-Google-Smtp-Source: APXvYqzjs7xiKDSa8DlMlC/8fqwPgqT4jEe4OXYpBNG5hVqFwDFwRzBuC7VDiKlTuaPuQJdMObS9pw==
X-Received: by 2002:a50:b1b7:: with SMTP id m52mr14697498edd.18.1551687448865;
        Mon, 04 Mar 2019 00:17:28 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id y13sm1048379eje.34.2019.03.04.00.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:17:28 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <21B438F5-31C8-4500-AE2C-E41D8B7EE73F@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F57F2020-3EC1-4275-9249-809D4B4F2CD9";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 10/13] lightnvm: pblk: Reduce L2P DRAM footprint
Date:   Mon, 4 Mar 2019 09:17:27 +0100
In-Reply-To: <20190227171442.11853-11-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-11-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_F57F2020-3EC1-4275-9249-809D4B4F2CD9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently L2P map size is calculated based on
> the total number of available sectors, which is
> redundant, since it contains some number of
> over provisioning (11% by default).
>=20
> The goal of this patch is to change this size
> to the real capacity and thus reduce the DRAM
> footprint significantly - with default op value
> it is approx. 110MB of DRAM less for every 1TB
> of pblk drive.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 8 ++++----
> drivers/lightnvm/pblk-init.c     | 7 +++----
> drivers/lightnvm/pblk-read.c     | 2 +-
> drivers/lightnvm/pblk-recovery.c | 2 +-
> drivers/lightnvm/pblk.h          | 1 -
> 5 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index f48f2e77f770..2e424c0275c1 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -2024,7 +2024,7 @@ void pblk_update_map(struct pblk *pblk, sector_t =
lba, struct ppa_addr ppa)
> 	struct ppa_addr ppa_l2p;
>=20
> 	/* logic error: lba out-of-bounds. Ignore update */
> -	if (!(lba < pblk->rl.nr_secs)) {
> +	if (!(lba < pblk->capacity)) {
> 		WARN(1, "pblk: corrupted L2P map request\n");
> 		return;
> 	}
> @@ -2064,7 +2064,7 @@ int pblk_update_map_gc(struct pblk *pblk, =
sector_t lba, struct ppa_addr ppa_new,
> #endif
>=20
> 	/* logic error: lba out-of-bounds. Ignore update */
> -	if (!(lba < pblk->rl.nr_secs)) {
> +	if (!(lba < pblk->capacity)) {
> 		WARN(1, "pblk: corrupted L2P map request\n");
> 		return 0;
> 	}
> @@ -2110,7 +2110,7 @@ void pblk_update_map_dev(struct pblk *pblk, =
sector_t lba,
> 	}
>=20
> 	/* logic error: lba out-of-bounds. Ignore update */
> -	if (!(lba < pblk->rl.nr_secs)) {
> +	if (!(lba < pblk->capacity)) {
> 		WARN(1, "pblk: corrupted L2P map request\n");
> 		return;
> 	}
> @@ -2168,7 +2168,7 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, =
struct ppa_addr *ppas,
> 		lba =3D lba_list[i];
> 		if (lba !=3D ADDR_EMPTY) {
> 			/* logic error: lba out-of-bounds. Ignore update =
*/
> -			if (!(lba < pblk->rl.nr_secs)) {
> +			if (!(lba < pblk->capacity)) {
> 				WARN(1, "pblk: corrupted L2P map =
request\n");
> 				continue;
> 			}
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index e553105b7ba1..9913a4514eb6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -105,7 +105,7 @@ static size_t pblk_trans_map_size(struct pblk =
*pblk)
> 	if (pblk->addrf_len < 32)
> 		entry_size =3D 4;
>=20
> -	return entry_size * pblk->rl.nr_secs;
> +	return entry_size * pblk->capacity;
> }
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -175,7 +175,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool =
factory_init)
>=20
> 	pblk_ppa_set_empty(&ppa);
>=20
> -	for (i =3D 0; i < pblk->rl.nr_secs; i++)
> +	for (i =3D 0; i < pblk->capacity; i++)
> 		pblk_trans_map_set(pblk, i, ppa);
>=20
> 	ret =3D pblk_l2p_recover(pblk, factory_init);
> @@ -706,7 +706,6 @@ static int pblk_set_provision(struct pblk *pblk, =
int nr_free_chks)
> 	 * on user capacity consider only provisioned blocks
> 	 */
> 	pblk->rl.total_blocks =3D nr_free_chks;
> -	pblk->rl.nr_secs =3D nr_free_chks * geo->clba;
>=20
> 	/* Consider sectors used for metadata */
> 	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
> @@ -1289,7 +1288,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
>=20
> 	pblk_info(pblk, "luns:%u, lines:%d, secs:%llu, buf =
entries:%u\n",
> 			geo->all_luns, pblk->l_mg.nr_lines,
> -			(unsigned long long)pblk->rl.nr_secs,
> +			(unsigned long long)pblk->capacity,
> 			pblk->rwb.nr_entries);
>=20
> 	wake_up_process(pblk->writer_ts);
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 39c1d6ccaedb..65697463def8 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -561,7 +561,7 @@ static int read_rq_gc(struct pblk *pblk, struct =
nvm_rq *rqd,
> 		goto out;
>=20
> 	/* logic error: lba out-of-bounds */
> -	if (lba >=3D pblk->rl.nr_secs) {
> +	if (lba >=3D pblk->capacity) {
> 		WARN(1, "pblk: read lba out of bounds\n");
> 		goto out;
> 	}
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index d86f580036d3..83b467b5edc7 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -474,7 +474,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 		lba_list[paddr++] =3D cpu_to_le64(lba);
>=20
> -		if (lba =3D=3D ADDR_EMPTY || lba > pblk->rl.nr_secs)
> +		if (lba =3D=3D ADDR_EMPTY || lba >=3D pblk->capacity)
> 			continue;
>=20
> 		line->nr_valid_lbas++;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index a6386d5acd73..a92377530930 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -305,7 +305,6 @@ struct pblk_rl {
>=20
> 	struct timer_list u_timer;
>=20
> -	unsigned long long nr_secs;
> 	unsigned long total_blocks;
>=20
> 	atomic_t free_blocks;		/* Total number of free blocks =
(+ OP) */
> --
> 2.17.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_F57F2020-3EC1-4275-9249-809D4B4F2CD9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx83xcACgkQPEYBfS0l
eOCUpA/6AvRwT1LG18RDoqdKDqgOmM7SKvWVic7XBf77PyJRIaHqSBo4mzxf3CoG
aq8hDfSl2av/3/TwvNEIxZQ1jxM2Z/c+LhfqfsLaHvef0qqc7O8Bpxxyf4xGWnMP
Yd+lAwlZidmCPuYg6c35RTWcyUrkdYHW12vrpLKH1qiAp3gnEfCdyXuyuttTJkQg
FB3zefJbveNNUWSS1M54xtCh4KJO938AWalAGjDCHMhsu803qmy3Dp7U15uj/s8B
O4GlaDICoC5vu5HXJqR7EK3dtol/xe8gNitDfufXZfV+yUT5XamfAQXRO4jUPj6n
+kcNHyqvECKdpgTiyyhVcS8n/HDGDXkyhvXnnrs0gkpOH56CxPZntYd75oyuGYXY
U15Epu8ffmKIGtCa3CpfWXPP6k/1WnCaRHJCHc5Tut6AykJ8HbhrvvpipFYO6ywf
o+n1eVeZ4WEHrz0cRNlJzOTq1f7CaCMeYi741pdgUCaDp8SjhZ/UEr+mTlLGtoLW
sbEVNki8AkxKGBgTzM4Vert7ujhuvV9ldmxPkAZyD0nlHNs92erV90ZFmNdms81o
01ce26lu5lxz3YacEBHh+PJIzn73LM0bAC543ZneG7dM6Djq5ckvtrQWZBJ3zp1c
UgX6PoX6Se3aLmmPa+Qnv8L69wqDE1wpLgjgpxeHSpBRQiBO3k8=
=ZRAe
-----END PGP SIGNATURE-----

--Apple-Mail=_F57F2020-3EC1-4275-9249-809D4B4F2CD9--
