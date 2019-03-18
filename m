Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20671C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06832133D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="j4yAuVT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCRTM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:12:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37050 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfCRTM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:12:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id m12so14516752edv.4
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WZdjRlayfJfYoFXfmvGEvkVpJ+fnJvN/a88NTkhu9Zw=;
        b=j4yAuVT6p5zBNLG9+nWy1kDvAUT1iatg8zKe0JI2vqUlizc7wA+9D3pHX/EJib8Ddb
         84HYIYno57QP6vjeqzXXu7b4LnR2Mz+mfnaBHkTEgsnM6Cl05Sr/TZkV9pM12giPapVN
         UizFNTFZ9KHj+K0Y8A4cD2Sac/bF9W4rooA1dkiidgStXNoAKeQlJugFV4iCMLXj/Sr/
         JXL5BlZT5rqvUSBEYY8qKpbRRu87B5jW90XnQTl9IgY804XKnMbY69iX8CFost0H7e3y
         F5Tg5Cd8gg9ZVHEc0Doz9bGEU92kmV3o/qGH4FEyu7CHZnNoVbk5x+knwqoECJ+HwLFo
         s7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WZdjRlayfJfYoFXfmvGEvkVpJ+fnJvN/a88NTkhu9Zw=;
        b=fBYDCZDdjvX4v4eTiQfJEeEQXrD6gx76AxCJi6Z/m+fQ7kJOsLJvdGiJznoMpOkdzU
         Fu6xrtWwLxdJimWOjyNUIB5UQuX86gnEeNaItSVpUSVrIrnuLwL1k320hoUddZp37Q7x
         KpZXwx01LzCeCUC6X8FA8O7GnmsqfbPM8OfgbeKMQVDUb3cp4dri4OciQQ/IO7AUV/vn
         2SVgO2AYt3DwM5fpPtmh1ruJ2St0pW6ud/LfovxpX+sWuUxaXuKOi8rP9KG3TW8lzrtY
         Mjo9OmZNYZIJFM2MY0a/zg6upHBGuOeFT7yTpxNnmoMicT1l0AezB1THiJqLhT78Sonx
         QfSg==
X-Gm-Message-State: APjAAAWikORjbXJLHVZ8D8MLn1wdVf4TM2Luu+9b+ivpAYEuQZEn0xUN
        CJlc+n6iXoRWB88qvwQ+djVaRQ==
X-Google-Smtp-Source: APXvYqx9jxvw0ZsL/+tsHD6RR2hf7SrmT9xmgZlRbWFPBsiZ1YcL8WukljZoJr+fNpAv4erboVoYfg==
X-Received: by 2002:a17:906:7045:: with SMTP id r5mr11658219ejj.147.1552936375259;
        Mon, 18 Mar 2019 12:12:55 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id 41sm3643540edu.85.2019.03.18.12.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 12:12:54 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <3D6438BB-0D67-4750-857A-95CC01A7BEC9@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_DA03DC38-FD5E-42DD-A363-8D0DAB811A5B";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: set propper line as data_line after gc
Date:   Mon, 18 Mar 2019 20:12:53 +0100
In-Reply-To: <1552922879-14075-1-git-send-email-marcin.dziegielewski@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1552922879-14075-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_DA03DC38-FD5E-42DD-A363-8D0DAB811A5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 18 Mar 2019, at 16.27, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
> In current implementation of l2p recovery, when we are after
> gc and we have open line, we are not setting current data line
> properly (we set last line from the device instead of last line
> ordered by seq_nr) and in consequence, kernel panic and
> data corruption. This patch fixes that issue.
>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 83b467b..017874e 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -844,6 +844,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 		spin_unlock(&l_mg->free_lock);
> 	} else {
> 		spin_lock(&l_mg->free_lock);
> +		l_mg->data_line =3D data_line;
> 		/* Allocate next line for preparation */
> 		l_mg->data_next =3D pblk_line_get(pblk);
> 		if (l_mg->data_next) {
> --
> 1.8.3.1

I think you are right. Good catch.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_DA03DC38-FD5E-42DD-A363-8D0DAB811A5B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyP7bUACgkQPEYBfS0l
eOBTFg/8DbN9bfguGlrR2tWrp02otnYgLXxAHmL7vJo2eLMh9eH6t2hGOIbYALiT
sWk/GZ/nioS8cpOZw8FbMN06Hh/iTicz9Cz7tFgcXApxLgePRXREyKbxNbZDrCYX
4ROE7xn0DF5hWFkkXV46XlUU0+kBPjPMBe7hPEdG6UJv8lyZO57X7mSgvrIwumbK
eiHNG1RsZ6myOQzUtZJFkC63cwElcuhHLsrZzdSOTYjWIliJH1NaseMOMKw+Ho61
Wz+L7NPtdVJcjEtiqVSk947tkyZlcg+SCBrvkBCDwKevpEdNxqbJN7QvT6auanCZ
62B4N2dt47cp0dy65z15Me9eUO3oRMc0TV6GIiYY06VfB2zSR8nUIJfzvghsbA2A
kpN5CgUvJE1DAIUqGAhqDWhPElQUffPz1lY2g+LNjPG0GnJsAjnytj40oXgazCpZ
I+9ve6i5kmC8ZyfOdmwcKaOEpvibnByM7GWDxl08rBdLw7bmjJbD8bbDHwvimBwo
2u8J9b8hCab9GdoXRDpPRQZHXNKv2jDs8pA74J4wPU2l08Lp0gjb4Osi1NMLmLSq
UzvuzYfWBX0cw4CSPhqW8WWq0LjTh4dVTogUaLYIMXhGzlgVBrXF8wka3SqrwdNg
1pSqo28VPgr5ogHxTKy/CnklEX9nh4IP01Ls/55jRjipN9zfzRo=
=JhaF
-----END PGP SIGNATURE-----

--Apple-Mail=_DA03DC38-FD5E-42DD-A363-8D0DAB811A5B--
