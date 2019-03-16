Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEBCC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708942186A
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Ltqtvp6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCPXyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 19:54:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46129 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCPXyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 19:54:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so8766489pfe.13
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=8jlikmUWGOyHK2D1++3qxInTVeLN+YIOHB0eC8qR/f0=;
        b=Ltqtvp6XBRzBb/s9nilz1y5LuEwIEWhvf43iprDUheX7WilC03YuzZmIuuxHNWUsJN
         9pP/FgmMNzzwn9W2H+170uxNpjSurxvhL3f7gV5qF+WHFQVSk+wRXVr6ZvQS1kRNxydr
         xcWNnNgKEocaBvsz1y7L7IdaURgmdHj9cbWHBzDYMfUUffb3P157t8zpdXhG74Y07udG
         UYeLQo7NA2obVvESUeTGBLPwn6POrNt0tv8qqSAEEWjnfrsmqQaE3twg36G0xtUG2BYB
         F3BcKP7o/Bx1NvWCud164LHe6kjcBVB+usdVvWvoP/cwX2DVnydRYIzLKDnvnYd+14b3
         O7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=8jlikmUWGOyHK2D1++3qxInTVeLN+YIOHB0eC8qR/f0=;
        b=HTwL0TFD2ixQKL0eJZWEHdPIRWEpF6RoMBr60zSHPMJJp7PNgk35J6Ad1rS8+a3FbV
         dInMAGFAKJmJ+UlebOdSczJA2zX6+03+Ge1LNiY60rJsldrY5Hl5q7dfV1YewH5dfy61
         WlfJRSwoqI9pPYN44sCm2LwUIjYTqOMzNoJa4vUhMGWFbzTvtrwHrVMBJ2BPJ/+DJPD7
         f24D6s37gS2AsqRk9N6zOTq6ZMiZxa5zR6yWF0iY5DUEsZiHoLzdJqniXnri90eCcFDm
         vCN28ZNZ0NKEizY2mJmKEvHKSbw9TrIHK5mh0nyHg1uWmxJxENnpEbYY1iGzMYl0RGUV
         1CNQ==
X-Gm-Message-State: APjAAAX2IEUY/n6X7bHyFztGK2GiPfPmro+1QbmThvx11rbxDlL49MKm
        2CY7zOde6HmiZSnhet9kwupsug==
X-Google-Smtp-Source: APXvYqzi3/46V1B5Ich3Zf/UErZabxIHOEmydpf2uvKmWp1BxZ33UmKhV3wM4yTU/bb3cjK3X4x1LA==
X-Received: by 2002:a63:42c4:: with SMTP id p187mr10043274pga.219.1552780443957;
        Sat, 16 Mar 2019 16:54:03 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id i23sm2671839pgh.13.2019.03.16.16.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 16:54:03 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <1DCC42C1-E6F8-49D7-80A6-C91377C8BC4D@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_821DA3BE-45C3-4BF6-ADD2-7AE91794552C";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 09/18] lightnvm: pblk: kick writer on write recovery path
Date:   Sat, 16 Mar 2019 16:54:02 -0700
In-Reply-To: <20190314160428.3559-10-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-10-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_821DA3BE-45C3-4BF6-ADD2-7AE91794552C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In case of write recovery path, there is a chance that writer thread
> is not active, so for sanity it would be good to always kick it.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-write.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 6593dea..4e63f9b 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -228,6 +228,7 @@ static void pblk_submit_rec(struct work_struct =
*work)
> 	mempool_free(recovery, &pblk->rec_pool);
>=20
> 	atomic_dec(&pblk->inflight_io);
> +	pblk_write_kick(pblk);
> }
>=20
>=20
> --
> 2.9.5

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_821DA3BE-45C3-4BF6-ADD2-7AE91794552C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNjJoACgkQPEYBfS0l
eOAvsQ/+P3nx745SOSxlhlHoW49tWvszQHVrpBdXhGcIdPgYuX0Wtd0UP/aN09yA
1b1ACk6c3o7fVja1vOj9xy1JDBanT+LXrnLWWwI+Vw3Q8XxR2XPRGk8grtQUgzTn
DTl2yOY1BNbOF7qyIv7ou6CZLwXfvVeGQfeIpU2YmrGogfyZc69khnCd6QKbIx9M
VXKnhYUMzmziu2ZDroMChlid9qjLa0HjfIGXL2q4T+TtTQWj7azSYpxWbd7Sm4Tu
gly/u9OJLoBvRxo+LYZjQXJKjJAZwz6kxvrEdKh/VWK1893JMoy0BdNrx9ow8Gze
dLuIaOTKwWL5BfYuVqEDLPokRQwdchLd2oF5DzCJ3JlyNExoFxpTPLlNOI7F8lck
LmFIWVDW4cG18aAqQkVdHsm0wZW29w+2RE/Z9Q/7DJQnf5YJxjeR+rvmBFSiwf4L
F10Upxa7s7JXZ4m7N+GlHlZhLfI9X91P8EkwX+v9bCVTdg/09WvPyhDj2dptg/2p
Tb6zRJ6d2ZLRXQJ0LVkjBg0xajdw0S9OZNelG0LBgTbFnaLDUO8IrpaGEOn5iVhp
TTDmIlMMtQ2AVhnQXCxm1MkRgVSmj/76CJQAcwxHVDEMokSlK98Lp/qEuJS98Bf4
pTgcpSAYDlq0wibS61SuXkPZTEEfdgh5WAAcURDTKMDAbbXiBaM=
=3uU2
-----END PGP SIGNATURE-----

--Apple-Mail=_821DA3BE-45C3-4BF6-ADD2-7AE91794552C--
