Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75373C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E17920836
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0kj9VRs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfCDHsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:48:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46143 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCDHsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 02:48:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so3394534edy.13
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Bi3BzmHvj5KN+wPad3iUAh3JEXWLTX5ILFtXnwCVYw8=;
        b=0kj9VRs58S66bv59pP4Hm8lcxBztJuJ+myLJITZrK0tzKS/B4Ho4cXr9CbtQzejHFO
         aFJ+hcaaiE4vbo0191jswuSE7UksSEZ7LHIwtL+6F32DgbDnvE3OrVFl18wRu14KweVa
         CaaXmXVKwVvA5zjujSckst4LHmCorrzzbjIUkAsiZwHqbsVoZLyeHfuA7lRMj2cCuRcV
         O308uifYpzbsoOdClz8rqARWEjaBeVRCk1R0t/DMWDjt31Gb6sZYJrE9Hz7mHn8dLtGm
         GcJE0jdMe5RCIxwICSjT/mILnOrGOzMBmmfzPZ3M41ZPQo4gKpZCPLQ9dE210ka1wHNZ
         RPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Bi3BzmHvj5KN+wPad3iUAh3JEXWLTX5ILFtXnwCVYw8=;
        b=WEdeNLgvhAZVtzjse25CmsHTFP+iVuSO5quG4oKKiqj/Fjei84jIwJC5CKlarQA31j
         IzZ7dKkURy9fVivdCtFq5CQRsSROtnwynQ6+VD1pYXa5KHv7FBov1Z4Vu71tuDXOuKHS
         gttdsk+AYUCWv8dD8T7e/hSyAPMtjBifAGS9Fre72OA0et9y29073hPqP3c3lNo4MeUI
         oOwMP1k4suj0Ffdje/w6Oj4UKOUT1+dEaGDwj9sYNYbMQUuHtPWZxsUEicW6vqXvdQHM
         SOInYNitefTDH22aGlW3jNJJAave3ksLsAJkHqyla4jwl+2mg8b7gzdrUzlRW2FTf2el
         J4rQ==
X-Gm-Message-State: APjAAAV9mdGACFajddzwA+vetVOrOddAdzJEwXRavgP+r5lccAYhBJap
        Lh9ktd9rbsFLux455OV9KkYkTryGHFA=
X-Google-Smtp-Source: APXvYqzYXLWfiVxmZCXbBStqOFcRgzx3Lqw+0hJky6rg/E2pcpovIfsvmnChLmKrY96gSuzTmedbkg==
X-Received: by 2002:a17:906:4595:: with SMTP id t21mr11269231ejq.120.1551685689628;
        Sun, 03 Mar 2019 23:48:09 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id w31sm1875194edc.46.2019.03.03.23.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 23:48:08 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E959370C-7A61-48BA-833C-8AE824857A77";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
Date:   Mon, 4 Mar 2019 08:48:08 +0100
In-Reply-To: <20190227171442.11853-7-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_E959370C-7A61-48BA-833C-8AE824857A77
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In current pblk implementation of erase command
> there is a chance tha sector bits are set to some
> random values for erase PPA. This is unexpected
> situation, since erase shall be always chunk
> aligned. This patch fixes that issue
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c | 1 +
> drivers/lightnvm/pblk-map.c  | 2 ++
> 2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index a98b2255f963..78b1eea4ab67 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct =
pblk_line *line)
>=20
> 		ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> 		ppa.a.blk =3D line->id;
> +		ppa.a.reserved =3D 0;
>=20
> 		atomic_dec(&line->left_eblks);
> 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 79df583ea709..aea46b4ec40f 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>=20
> 			*erase_ppa =3D ppa_list[i];
> 			erase_ppa->a.blk =3D e_line->id;
> +			erase_ppa->a.reserved =3D 0;
>=20
> 			spin_unlock(&e_line->lock);
>=20
> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 		atomic_dec(&e_line->left_eblks);
> 		*erase_ppa =3D pblk->luns[bit].bppa; /* set ch and lun =
*/
> 		erase_ppa->a.blk =3D e_line->id;
> +		erase_ppa->a.reserved =3D 0;
> 	}
>=20
> 	return 0;
> --
> 2.17.1

I=E2=80=99m fine with adding this, but note that there is actually no
requirement for the erase to be chunk aligned - the only bits that
should be looked at are group, PU and chunk.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>



--Apple-Mail=_E959370C-7A61-48BA-833C-8AE824857A77
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx82DgACgkQPEYBfS0l
eOACdg//VbfSVJ/HUl5083+cNSryMXJll02q4XechUfKZ1swJ/265dx0hiQaNxPv
wLTIoHcaVxYkMt8zBqGWZA+hmcIedyjPyDg0e3TCLhG8iOk8qAEW4UjnjGOU2V6g
RGBaEORNpY9Wlets14fLpgE41tB+i7jiE3L14AKQLl3oNDQPoNO8jQ189qzYHKy2
RkxAdxpZ6t2QavzNssbQvqURNnIYn6jyx5gwprgPRe1b56irqjOyrMx3uNX7S+PR
qwS62WFc3baGd7YtC1e4rLpPsN+/4wtzELH2IJAdzBRwbs6XcprrWZKlt4Amv9b1
x6t6+HXxIvPb2tTNQqmBwr2qYkkA4dwGZoG9d43a1f43Qu6nMqFrDMpqij5iaOe/
gd4sbVfWSYoMBwAfFuiOUlz0TXPQDUe+CmjAY/xqJVSayXW4w5IsPBwDl9via2XP
dJrX5LHULALRNVQDBrwcYuRHC0xzQ/HlL5f83PL2Lkpzmlr2OLH/jzfcMOXm9FLM
IeEc872KRJiyF8fdh+LRL6dm5mePC3yjjMckhtsNISwsQks9IDDZgC2zA2drzLZO
oUye/sAcO2Ls7pRJXVFjyb3PXlwuDoaHh7zBXKnNqvy1zlEvjn9JBeQ/jwL7M/R9
75sZHId+jnWwVfaz9/Jd2VANb9v9Xsan6fF2p7ikNlDBMssxFwE=
=KOLL
-----END PGP SIGNATURE-----

--Apple-Mail=_E959370C-7A61-48BA-833C-8AE824857A77--
