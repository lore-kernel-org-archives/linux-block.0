Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A7C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D79B20661
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ovyPK+dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfCFH2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:28:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36236 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbfCFH2q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 02:28:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id g9so9432280eds.3
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 23:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pM3WXQfc+xw0gMs4jq1tp1DVdTrgY5eQMW+tp6NkNQ0=;
        b=ovyPK+dX7VK3OE0uBWoM6Ythc3fNmEN8vH2KYRo2lGMud76vC959sEp3PSt0AO7gO9
         G7aASnljpLofkiNbfFPF7iByK6BkH5bZb8uBcQ6jGAVFULrN6QWW/zvt5cRcALtbvawZ
         zarSxXuL3pggiy51kUmMSMzWPgXHsdaw3rler5aXeiUbY8GaEURGUe7gJ2EP/1hPvQg2
         iZo4ecxfxaXeEEZmPihSRVUG80Bqtp7MLgeukjZDgw0RFe54OPAaaV+ACHSKAY4nlbnJ
         fdR6UyMW+CmN/frp/dePz4QVWNQU9RXNOWiHkGmbCqc9z+IK17Ka8xhcKQPs6pfL6JjP
         g9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pM3WXQfc+xw0gMs4jq1tp1DVdTrgY5eQMW+tp6NkNQ0=;
        b=tFLpsjsh2iqe9QUuUYm9zBXExiba1GDvhn8xtnHYBQB1V7SbH+bEkRuAsw0KhkgXtz
         Nia0S17s3GEcbucYkNHanJ3pl9pPxEGx/wc/tJ+jMHSuoDQvtbgkwaTV6a/jIC9DKAWl
         hNx1C2Io5m+j4sKG+EYHUBOg8Vo1yQpBPdq+0umyr+6M7tp76HuAwW9+cRcpos4hIOA9
         m++adNJIHwgHgezQ+FGZ2VXNcXrzytasZWatDvwWXEuo9e1C8Dmrfwim3IHR+/49ps7W
         KVU3rjEhvGYlzLsOBhRfwkAd0S9LwAQNi3KTGkCvqbbUC2oMgETUxO1FAUXxHSYadeVJ
         HPKw==
X-Gm-Message-State: APjAAAWwD82NHtk5M2ljBJQTZDrOynwtdJcoLtZk1RH+6RGWzax7hSZ3
        /+oQK8CebhgZscgOk/YwlPT3zw==
X-Google-Smtp-Source: APXvYqzbzwPW9C6eRnv8miV/1KjqtKyTen8b+GGiP+3FkPrS7pUx9E83dT8wI4PbQfsxjSBErikONw==
X-Received: by 2002:a17:906:940d:: with SMTP id q13mr2935961ejx.160.1551857325002;
        Tue, 05 Mar 2019 23:28:45 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id v4sm188551ejj.4.2019.03.05.23.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 23:28:44 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <600DD76B-97B3-4B19-97BD-6A7962F84B63@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_30E3FFF2-4711-4DA1-A618-514665B815CA";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 4/8] lightnvm: pblk: Ensure that erase is chunk aligned
Date:   Wed, 6 Mar 2019 08:28:43 +0100
In-Reply-To: <20190305135120.29284-5-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-5-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_30E3FFF2-4711-4DA1-A618-514665B815CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Mar 2019, at 14.51, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In current pblk implementation of erase command there is a chance
> that the sector bits are set to some random values for erase PPA.
> This is unexpected situation, since erase shall be always chunk
> aligned based on OCSSD 2.0 specification. This patch fixes that issue.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-map.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 7fbc99b..5408e32 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -162,6 +162,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>=20
> 			*erase_ppa =3D ppa_list[i];
> 			erase_ppa->a.blk =3D e_line->id;
> +			erase_ppa->a.reserved =3D 0;
>=20
> 			spin_unlock(&e_line->lock);
>=20
> --
> 2.9.5

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_30E3FFF2-4711-4DA1-A618-514665B815CA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx/dqsACgkQPEYBfS0l
eODYBg//Q2wFmu7J5N7lN0Gqj6MGSW+7XpisSuJR/nWf1B3DN3cGIPkrSjUqiXEI
uJ/x1+XHHGXlVTRXE0AuVJmCRx8yvmguBfgy3tcLDfj1WM9uqUF/sCCHI1evj6ze
kl3WCd6EBX/GhTIvpDtV4KexyHs0GmEggkN0dPc5xQ3yjSjfE95ggUSGK5xz0wlI
zTURAgpYmrCgJEWvi2YtfzBAdbpPPXyUZ8bA7xvku3ceAOzhSsB4QEP/LNU0+xFA
JzdtGcwNWtOFIcYGl5BOzD+zR8dKkWq0wbOgLVd1QhDcHihgB8B/UDdz8IbSbDn6
9gdP25gbCvqDlbunHxzlrANEtndUQYJXFgAjKPNAsLxr0fkNIGj6URQsFn/UWcFw
jVwW9EnZsXh2P6/xMpyCDb66pBRwGyEf5MwMeP/VrZmC0b9jMITsorpy3kZN13fe
FMT7sVt9o8xCSkS9Iiox4jCfiqPhwwHCmi6uIH5z99g7qAd5uiMPzXZQdDXYBxL+
Zjrk3JEkp5+S1Kr6j7vX8shjqVFlHybikZ6dtCviu7Bh0tjnTfuc5t8bBHb2ZhWP
g34bRyl9wL5uwVACqCCsp3egmcadvZgtJNgfSg2dh1UGTBgW76QE9jW0OPPW8OAG
3rJv4xwOmlP5cvyttvxywWKFKRvOPmfjaN5twtY8AFBqa7xyRes=
=wFK5
-----END PGP SIGNATURE-----

--Apple-Mail=_30E3FFF2-4711-4DA1-A618-514665B815CA--
