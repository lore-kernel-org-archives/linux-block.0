Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37056C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00898218AE
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="dgt4glVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfAXNT4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:19:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41398 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAXNT4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 08:19:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so4531438edc.8
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qcC1rYfqoDq/mo5Jqc1k0GDYYCSCIlZEfEp1LZS+1xU=;
        b=dgt4glVkJEQsu+eWop2bK+7ADLA+txesL9VfFOyDZaJ+rYGvsWpEuQTxxubxgKAIE8
         LNHN9kfRvUFHVDEESyQarvnLGajKcKQTI1h25NpGR5/f8h+vke6zIUbbFfXBBWHY0rad
         bcydGuGMfvqoTAvpZiheDM/ykjqRiW+npaHDUNPv67PKlQL4gehAuJjPTH191c8oTlep
         SqTegPTEXiF75KUBrztaB7FiblvB+8W5p45sZaocYUJDtlwmPhQwSwNHMOM4htqxA+aN
         lVLro5KQclBvleQL49kqQGwop/m5aEjjzTIEe/KNV/kGgQHxJvG2NkKKoZyIkDqlJwJK
         UYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qcC1rYfqoDq/mo5Jqc1k0GDYYCSCIlZEfEp1LZS+1xU=;
        b=NyEfKvAQO8uCrYXLRu3P8YGxSS5INeHXiY6GW+Zbqrd23JWq5FjKlBCil2p9v5fa74
         0my7g+hJezbCwsUl4FXIHHvR8AISlW1j2S9RmT37Lkzr8O5rULxpyPt5+PxlGws2RxQw
         wr/ALgxa95UO/PTwqLMp4iwp6LDuaWe2H2gt91iht6D5daEVylfumhEGpSRyQWsXyN7p
         tgYS1KQrXbd9mUe2QeZHjd2ljJjCeT+GhMY7JU6AaTitr/k5bSrTtwQ1bv4o6xW702P0
         vfVa5suNiDpDYlrFYcYKrKrn3CzFhtBMKO5VCwcfTwS5yDbumfRxULl9z7P52Pnz14da
         XOIQ==
X-Gm-Message-State: AJcUuke6CsBjLPrl2rl3WHhnj8bPfGdGjjSTe6kuWnCXK75VLJqPxEyt
        vzev95JdyD9u93ptWhK2SEMUXg==
X-Google-Smtp-Source: ALg8bN6D3aOnhKXy9/XVZkdGTihD6TaxMRml+ojPPnmdIpm+EK6uqjuK9rjxU1o6X1kDhlgdOWyalg==
X-Received: by 2002:a50:ca86:: with SMTP id x6mr6449388edh.287.1548335994205;
        Thu, 24 Jan 2019 05:19:54 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id n3-v6sm5894572ejd.35.2019.01.24.05.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 05:19:53 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <251D7CB9-A9B0-4474-85A0-B0C23DB31272@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4C7134AD-2365-491B-AABD-B50DFF810C0F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: stop taking the free lock in in
 pblk_lines_free
Date:   Thu, 24 Jan 2019 14:19:52 +0100
In-Reply-To: <20190122101531.30893-1-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190122101531.30893-1-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_4C7134AD-2365-491B-AABD-B50DFF810C0F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Jan 2019, at 11.15, hans@owltronix.com wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> pblk_line_meta_free might sleep (it can end up calling vfree, =
depending
> on how we allocate lba lists), and this can lead to a BUG()
> if we wake up on a different cpu and release the lock.
>=20
> As there is no point of grabbing the free lock when pblk has shut =
down,
> remove the lock.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-init.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index f9a3e47b6a93..eb0135c77805 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -584,14 +584,12 @@ static void pblk_lines_free(struct pblk *pblk)
> 	struct pblk_line *line;
> 	int i;
>=20
> -	spin_lock(&l_mg->free_lock);
> 	for (i =3D 0; i < l_mg->nr_lines; i++) {
> 		line =3D &pblk->lines[i];
>=20
> 		pblk_line_free(line);
> 		pblk_line_meta_free(l_mg, line);
> 	}
> -	spin_unlock(&l_mg->free_lock);
>=20
> 	pblk_line_mg_free(pblk);
>=20
> --
> 2.17.1

Can you add a comment too indicating that this is only safe on a single
threaded shutdown?

Otherwise the patch looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_4C7134AD-2365-491B-AABD-B50DFF810C0F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJu3gACgkQPEYBfS0l
eOCuyhAArRVmwaa/qPpO2zswbdvgVTEmrp70HuE9YScahKYV2mMZ20diMV7wQeLd
7OHbHItSsKVi022iVxXtPd1qsbQw749XWiEYWCmiYWeR+Yu0CP3vEp2EAQgUYFq5
7zq+0ynaONgNJr9ExC/IQtkqh93xHg6Hfq0+wbm+UvXOHLCAd8DDKsz7PZHiyJHj
gwVDdWGkaYTvQg7jj18i7O97J35s0fB2nsVZRN4MEQ4arT10Hi4IzeaBCKGmyXvf
NdclQ5l+1z66cqsKkudtdUKY5VVSGBFmvJJ+ji8tjfG9mLYo1aMKrLj7/8V2RJG+
MFgR6dUNpiLLBN2+B1ZebeMuMSwMmIy6K8dOdUK+eiWtDBwut9Y+0h4ECdB29six
g+7ejOCkmTRJaG0rEDmBKDEGADxOFmn8nyxG8+oTwVlQtfktsP8hMvm3INVUql9G
okFZPQvoyViRwGJrckReFkre4CeV1SrynF0j/12Z0/BPcG4nxdmmId6MwTlsRtXc
xknVCxGtt46A0bVRuAVnZ7nfZFugdbKxbIRv0JQM9RePI9ocFhY7Rr4gjqlC6tAN
BmZbNf1/8uFXVWypRzoD7+EkkyJ282gBDHahHvCMyrMdAAEG7ykfLEZpMT3cQRXv
8b7y6FboTnpWfvsHMqpsw8cpxQjZ26EbopGziVo91/nsX3dOWNg=
=0m2r
-----END PGP SIGNATURE-----

--Apple-Mail=_4C7134AD-2365-491B-AABD-B50DFF810C0F--
