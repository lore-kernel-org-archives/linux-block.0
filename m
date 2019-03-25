Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB695C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883D320811
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="RJuELMZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfCYGXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:23:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42267 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbfCYGXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 02:23:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so774421edc.9
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=oYyT1giGHANTj5w0IhdR2wPB2a6S5g8j2bY/MTeoNbE=;
        b=RJuELMZlcR1dkbLdgqULhxlqZQSf9Khvqn9mdJHFgycujJRK3Y9kebaM8cFPPclvaX
         h8mmqS9nRs6nVNiXhWGr13zOTd5UV+kD6rE4rxM/Gurqt7eNvn/JXCrQaohqzpgai4u+
         TJBXud49u99V0Z38Reu5XMyKg29J8cKyRGsoCNcq4EtC2K+9FbxtLRzT8mT7ADTrHyn1
         4oR2AsHfpPzwQ6EHL7L2vxj8VOpcyfu8whfqDpOVdmxtIL9GKHxA8VtQDM1xsHO4VkWc
         1y2cyh/d/g3FiOSuE8JUCiXK1YQmfhoww1/gcJieBHfugufTc7QC1Rs7YMyDx7oQWGmj
         L9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=oYyT1giGHANTj5w0IhdR2wPB2a6S5g8j2bY/MTeoNbE=;
        b=T+PbJNu/+r1Ej9pddWCpRqhnyvTYm3DoQWfNS/Kq6ievO+HPUIT97zqDnwy9q0oBOL
         q4dYGswLDgt7crmF0r7WCvHRhj+3KegN9kqBca+E8m/WayhXqiKNVWgqV0ZapPJ2FB0n
         1zkXX9yytfdGGsC6l3PdWbNpisMspFAl51dlofCfrw+ikyyDTc9cMVKw+eXyNYQH3SSU
         4hNJoTQkdWTypfDBHjvmV4uItuD5I80xeLCadaGp5Me7UXxLngc9xDmGi+T7SxtW+bkn
         Y3QpNvAz3qAbqpKd4Bq/telTaI2iiPdJ1Y2mRtOEa+4jSlXyOY1WWmh2JL2i+2GMoEWL
         7mvA==
X-Gm-Message-State: APjAAAWumSAn2geWwL3FKanH1zts++JAsJMZLktE8CgTmBy2rvPBg8xU
        lSu4v+u5m1138APBaa6QKJztEsKKH5k=
X-Google-Smtp-Source: APXvYqzVMGNulIpws7yO8IxAKIDY1KI1OaEeW/rgGT9JaHKPddPoiwMylmG+QP9Y5O+AtsyWCCYDpg==
X-Received: by 2002:a50:fe14:: with SMTP id f20mr14785468edt.187.1553494993989;
        Sun, 24 Mar 2019 23:23:13 -0700 (PDT)
Received: from [172.30.99.70] ([37.120.153.227])
        by smtp.gmail.com with ESMTPSA id e17sm517823eja.33.2019.03.24.23.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:23:13 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <771CAB97-E48D-481A-90E7-310D2ADD85E4@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_DD798A92-2EFE-4E7D-98F2-9254BF6D5359";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 12/16] lightnvm: pblk: do not read OOB from emeta
 region
Date:   Mon, 25 Mar 2019 14:23:10 +0800
In-Reply-To: <20190322144843.9602-13-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-13-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_DD798A92-2EFE-4E7D-98F2-9254BF6D5359
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Emeta does not have corresponding OOB metadata mapping valid, so there
> is no need to try to recover L2P mapping from it.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 4e8f382..74e5b17 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -479,6 +479,15 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 		goto retry_rq;
> 	}
>=20
> +	if (paddr >=3D line->emeta_ssec) {
> +		/*
> +		 * We reach emeta region and we don't want
> +		 * to recover oob from emeta region.
> +		 */
> +		bio_put(bio);
> +		goto completed;
> +	}
> +
>=20

This recovery path is supposed to be a last resource to recover an open
line. Since emeta_ssec is calculated based on the new state after
recovery, it is not guaranteed that the bad blocks are the same as when
the last pblk instance was interrupted. Thus, emeta_ssec is not to be
trusted.

I would rather do the full scan at this point.

Javier


--Apple-Mail=_DD798A92-2EFE-4E7D-98F2-9254BF6D5359
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyYc84ACgkQPEYBfS0l
eOB+ZRAAhQC0uoR4mBxstlQZGYuJ+MaKV9cy+fJpP6l4Tu2nEMW4TuXrPLyWqbJZ
zC8c7f6nkteNMQsGCx67SId4iemkge9ICz0P9p2fW++mIvTjNxDJBLWmU28OZYgV
e4fqeX9aoVY2UHIlxDtfDFRkWBiPf6smFhglKaxNXEK9d/QqYkQtjR4D12RBcHtP
camiUmka+oF5zC1MMC9xoC7ShUlr8NzEYjSFrbbuGHFnnP1FvKxHJqmhNDUSpnOf
vHr35fF41+GfKbGl5hOH0YQM8qPvhWp+fzz/vRXAX0Eft6pBrEzyX1IrzYWBg4S2
pAs0vwbLm9zcqNPSdhKQkLRa0i733FBVaxxoEk8T4DhJkMW9t/dDmBzucNWcoqV6
WhTvwnxVzXcETdYklUDFCQrrmjaQtcau3w+0NSdOShPIUN8//MFCLu/lVQ6Cfjoz
Hjj7Cmq2CfWnQRzAiMUi4ROP4Ww7vxvvpW7Ffw04ey8yBuFaaJWzKDWpRVJmxkVc
RYl5m9nsBatMWvi6atO0s7pnR6FF3wsU58dSNlSZMQj4eyPOdWkKzmSpXpbrekso
yRg2OiQbj1gLCzQ/tYE8OjNIiCEPNBD9lqozzDq6AaTo4A5uR4vB0yDg52XqGiK2
FrNYXrasbP1ROdtKgjnHspS+YmrmUdjrn1bb8/1dRPiPe6WlC64=
=utuS
-----END PGP SIGNATURE-----

--Apple-Mail=_DD798A92-2EFE-4E7D-98F2-9254BF6D5359--
