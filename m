Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7DC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331C62064A
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="A3YCY+3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfCFHnq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:43:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43638 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfCFHnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 02:43:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id m35so9459250ede.10
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LIhYOXLiQBtgGEyyQ7BJMky40uyNFsyPI9yBuYmR1+k=;
        b=A3YCY+3eHK6fXBnaSo1AtGJwF/QeJ5uDluRpSP9KDA32FeqtPKIb0xj+Xjegndm7IG
         gcdYCuESeKhFrT2JWVc0gkkiAlCSeSSou16PGYH4ZZfGVlPYxrjFTk7tyz/zJYG5R7j6
         UEgjKUDRn/QFLFlQehgyCo0wzVmyi8d14FNN4j+nfZX0OsUc0RK5QGp58OGD80xAl7F4
         jgMhu1JobYmZ6MpKsKnKSdLEkC6oRXUeiC6VEPuwHQM4RQj7d2fg3wpR2Yx+fPLoaVde
         tyblupKCq48HojmAtyBLNKfJkwErQJkEUxyhROQ7QmqTJSYXUw+DV/syy+Qdhs3Aiyot
         S4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LIhYOXLiQBtgGEyyQ7BJMky40uyNFsyPI9yBuYmR1+k=;
        b=HAQd+kqX1DO6DNuJxloWmcAOGqdsKdHt/iLAuFAJoPZWdIKKy9LRrW8A76jr/ojvsl
         aaSF/R8FJDqhGwo0F5D/T4iqeWzunGz0cvOG0ca0ck+OgOnuTZSX9wU7gXa7xYmL8grJ
         pStdt6uT+0qlx6S+SM896a0dRuZcM8mZtjDHxfi3+MTQZS8eUOMlOUEhvm3TkVb672UM
         eH+ZtPogVOcXrv4Pjy0IjKOK/pAzDq3ME12RueVtKphOZf+CdPl3pmVEwNDokpES1Yak
         BHF71gmuRYkHpAOK/MNgUtZ40vIk0KtaYRwyYoYpJm1kAf/v+uDrTf1taxXfqr1UgDhf
         rojA==
X-Gm-Message-State: APjAAAVN4U8v31gVTJ1az/s5f4yDeZnh6rnjb9ycd8iOLjn/oiu76Mj1
        0AQb1mPTLP6piiJtEsJ10Cj7iQ==
X-Google-Smtp-Source: APXvYqx06BLWwAZbzfDFmgotR7PdtBpxkivrT5J/nIBnVB+Jyp0Hci97Ixlo5vrfiilvHYmaInkDsA==
X-Received: by 2002:a17:906:1fc8:: with SMTP id e8mr2935617ejt.248.1551858224041;
        Tue, 05 Mar 2019 23:43:44 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id y45sm241536edd.33.2019.03.05.23.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 23:43:43 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <2A291684-E2EB-47EC-BFF9-189DC62D388E@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_931C49DA-EB46-48FD-9C84-704600C01FFC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 7/8] lightnvm: pblk: warn about opened chunk on factory
 init
Date:   Wed, 6 Mar 2019 08:43:42 +0100
In-Reply-To: <20190305135120.29284-8-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-8-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_931C49DA-EB46-48FD-9C84-704600C01FFC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 5 Mar 2019, at 14.51, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> When we creating pblk instance with factory flag, there is a
> possibility that some chunks are in open state, which does not allow
> to issue erase request to them directly, based on OCSSD 2.0 spec.
> Still most of the controllers allows for such a transition, but it is
> not guaranteed that the particular drive will do so. This patch adds
> the proper warning during pblk factory creation to let user know about
> number of chunks in such a state, which can potentially be a reason
> of erase failures.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c | 14 ++++++++++++++
> drivers/lightnvm/pblk-init.c | 14 +++++++++++---
> drivers/lightnvm/pblk.h      |  1 +
> 3 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 64280e6..4f16596 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -161,6 +161,20 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct =
pblk *pblk,
> 	return meta + ch_off + lun_off + chk_off;
> }
>=20
> +int pblk_count_opened_chunks(struct pblk *pblk, struct nvm_chk_meta =
*meta)
> +{
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +	int i, cnt =3D 0;
> +
> +	for (i =3D 0; i < geo->all_luns; i++) {
> +		if (meta[i].state =3D=3D NVM_CHK_ST_OPEN)
> +			cnt++;
> +	}
> +
> +	return cnt;
> +}
> +
> void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
> 			   u64 paddr)
> {
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 97b4c6e..f590f62 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1028,12 +1028,12 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
> 	return 0;
> }
>=20
> -static int pblk_lines_init(struct pblk *pblk)
> +static int pblk_lines_init(struct pblk *pblk, bool factory_init)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line *line;
> 	void *chunk_meta;
> -	int nr_free_chks =3D 0;
> +	int nr_free_chks =3D 0, nr_opened_chks;
> 	int i, ret;
>=20
> 	ret =3D pblk_line_meta_init(pblk);
> @@ -1054,6 +1054,14 @@ static int pblk_lines_init(struct pblk *pblk)
> 		goto fail_free_luns;
> 	}
>=20
> +	if (factory_init) {
> +		nr_opened_chks =3D pblk_count_opened_chunks(pblk, =
chunk_meta);
> +		if (nr_opened_chks) {
> +			pblk_warn(pblk, "There are %d opened chunks\n",
> +				  nr_opened_chks);
> +		}
> +	}
> +
> 	pblk->lines =3D kcalloc(l_mg->nr_lines, sizeof(struct =
pblk_line),
> 								=
GFP_KERNEL);
> 	if (!pblk->lines) {
> @@ -1245,7 +1253,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 		goto fail;
> 	}
>=20
> -	ret =3D pblk_lines_init(pblk);
> +	ret =3D pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
> 	if (ret) {
> 		pblk_err(pblk, "could not initialize lines\n");
> 		goto fail_free_core;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 6c82776..c2f07ec 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -795,6 +795,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct =
pblk *pblk);
> struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
> 					      struct nvm_chk_meta *lp,
> 					      struct ppa_addr ppa);
> +int pblk_count_opened_chunks(struct pblk *pblk, struct nvm_chk_meta =
*_meta);
> void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
> void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
> int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
> --
> 2.9.5

I think the warning is a good tradeoff.

If you want to avoid looping again across all chunks, note that we are
already doing this in pblk_setup_line_meta_chk(). It should be easy to
refactor it, check here for NVM_CHK_ST_OPEN and then return the counter.



--Apple-Mail=_931C49DA-EB46-48FD-9C84-704600C01FFC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx/ei4ACgkQPEYBfS0l
eOAFtQ//XtHgykpJLm2SLkQzBx4xhjR4dBWmPd8xeM1n05pwJMgoKItG0hgeaAT8
12b55lW5YdtgkZNF6pvvBZRl2RqI+2PWr+KCeGCWLQ8uGC9CGzzMtcaRXC5z+EA2
Zk7iQ9YeybaL1Ykmrc8Sf1YEWPRG3RjNU5z/mUEwQ3xwg8BSnf29O6bQ1+xGkWbb
DII8W2J4sukqFCKizYN4QmlL2ixpRxZJ3j0xgwmJd9arAjkK5eSpAQ5QHg9461HF
nLKf6WwCozmXBTQ4v2ZCUYxhf/IgRAyx0HEw65mFUTSoQkEfIAiCxrXWgrSGjs3O
pnf/TH4vjt8/pNP+xPe2xo5TTy5ved1d7srSQ1o3BRbL7xAS5sD9eXP9zyzkd60n
RPVy4KcphVdpF6j0x6FID0OlCXZB/cG5gfb7qNMUxTASHBtueMuGowDPBbpIk4Db
zg3PlDKypIo5N4qa2olkImLPFywvKx1YcTO4zx5oLwKd+8diHftpRkdc3rT5NuWU
6RHf0QP7C91WARau65tmwBd5Zw9a40qMdQaE7mGUCfoL0nfxiUovJ7Vbg5BLbEnf
YfIV9pDjtM5jMrOKiUb9sbLARQ5FV6ExhPCUuI1h3+hc0l1RKMz/RzLhrjsrvbcy
dzegjBB2urFeKfLn+t5XIJ5n5T4tr/6KPWNI3rUPJ1MCA+hwq7g=
=jD2O
-----END PGP SIGNATURE-----

--Apple-Mail=_931C49DA-EB46-48FD-9C84-704600C01FFC--
