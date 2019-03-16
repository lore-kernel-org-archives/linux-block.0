Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC0DC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5727218D4
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cK5+EqKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfCPW3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:29:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34201 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfCPW3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 18:29:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so8848411pgq.1
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7f6WVTHQJ3cnFXyidhLlF0eZwg9RKiaRuZT4v2ju23A=;
        b=cK5+EqKcVP8uw//uhg7icaJL9xhreNiOat65orIOrPkfHMTWY5NvEijdUk0cvCVpyA
         9sYRs11wEHK4DHAJPdTmqvhIvfz5Rp+tqlE73pg+BbYgJ8aY5flJBWE46cqii5FxgzNo
         bqDYZKO/8YYVxAcfLi0bbukGMvmxNASHVGxsSDf3SjxTcT5AU1u69+odAizc0vUgHH4G
         unZufRFCOnDYja8zbIhdQs2I2Hm980/gs2faKv0V78oM4acf4yIQ+044YulVNA8JOtCQ
         WHhsUZlPDjkA6a8olwarvC3LOqKUtfB9SCkQomw+qHImLc4S4PaNMtwlAUIAWIZaEysg
         4pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7f6WVTHQJ3cnFXyidhLlF0eZwg9RKiaRuZT4v2ju23A=;
        b=tOTaMp3RpW17lBGqO0RMepsz4SHYCysUpFfTZmzYhFXbEK/mRyY2EqrvMWXHg8DZh8
         Gc//6ndDCP9HYbFnYecbfrMvPIddZ10peUA+iW5nUT1yGYUMhmdHKait2tPB5mHbBH36
         kMK5UgIWQZ0x25kP+OheDVilq5s+Trc4ztF3zxfge/t4zjRFGSJ7zqZ4mUVd8/hRvW6z
         5msO53n64vPn8iRe4wSwhj9XMpNTTVO7cKpi1cRTsUUyjP7uCFaxLDoHPZM4pLHZHAKQ
         /6nXcCFbB/5fz799d1R61KjQaB9JjlN/ohHmqCJ5bh2rj4NKDVS1Z9UpRRgMQeEFRVd4
         btZA==
X-Gm-Message-State: APjAAAWCCaSDW2P6MN9m8phxgfIwvggia3t5c8Ww8tYHuWQITvC7Nckq
        vWILcorn0tvVBlTeMGd2fplpTg==
X-Google-Smtp-Source: APXvYqyFWmFoTU0CldiaN893BbqGsXJ5BOou8+cBnV08RxwwZG7Vl2t2IF7aeNdbhCrCEykzP9SO8Q==
X-Received: by 2002:a17:902:8c8b:: with SMTP id t11mr11637959plo.148.1552775362398;
        Sat, 16 Mar 2019 15:29:22 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id x19sm7694829pfm.108.2019.03.16.15.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:29:21 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <47F1D515-DE64-443A-9569-DBA611D21066@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_94AC2AF9-6F5A-415F-B80B-0FF153B6FA0B";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 01/18] lightnvm: pblk: fix warning in pblk_l2p_init()
Date:   Sat, 16 Mar 2019 15:29:21 -0700
In-Reply-To: <20190314160428.3559-2-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-2-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_94AC2AF9-6F5A-415F-B80B-0FF153B6FA0B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch fixes a compilation warning caused by improper format
> specifier provided in pblk_l2p_init().
>=20
> Fixes: fe0c220 ("lightnvm: pblk: cleanly fail when there is not enough =
memory")
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 1940f89..1e227a0 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -159,7 +159,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool =
factory_init)
> 					| __GFP_RETRY_MAYFAIL | =
__GFP_HIGHMEM,
> 					PAGE_KERNEL);
> 	if (!pblk->trans_map) {
> -		pblk_err(pblk, "failed to allocate L2P (need %ld of =
memory)\n",
> +		pblk_err(pblk, "failed to allocate L2P (need %zu of =
memory)\n",
> 				map_size);
> 		return -ENOMEM;
> 	}
> --
> 2.9.5

Looks food to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_94AC2AF9-6F5A-415F-B80B-0FF153B6FA0B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNeMEACgkQPEYBfS0l
eOAHDw/9Hi4WhdO0ri1+7a9nK9HE4RAWg4aqvQLsBjTW5OdE2kUcAOIE5EH0Q0Al
MLuPZbwb55Uj6X0U1bbsnwfM73QAFU1Yg+541R6OPAcMLkQm3zTCVWAKRviL2ORz
yXmA5sDc29OcQDe7aGQQNPR7jl9rfwwTbPa0FlCBQzgVAHsIXEpQsn+4iLs/9GOB
ARDmcVdBXi4jTc6yzqgmM9eRtzMGpShjQj41ReBbSml8xB3ql5WVRvf84C3y88uI
omapWAFQVr8lGWkAvqweTifSNx4ua9epiCC8akRiRHkxwH/sQFAsVbseGKui31t1
6PCjbf3rByn8oU718u2yJU/3MjZKLI197x1UDnXAiOYrOCF14bHxYRuSTPpYqiWw
VTz8myJGpEMZFOkwnNZFXe7FzdijYAudTbYso9Niw5o7+yp2zbEQYSwKtU/gQktj
jvvW3/DJE5g1Ni+vA3ROKWt1Kpnt1jX3AdF4wWF2ee1F9P0J95vNp5UN81xhSHBL
ZW6phSTJD4beGkiQnn0CTARuZJir9R/WoV4m0+tXyT+dbIxx4Ol6TrnSyonxZ12y
1s81SAzA5DPt2vNIfaJxzftc9w5HN2kdWB9k8FMO1beMQGPx1ria/LZ69ANqbK1k
hZIHQ4UNhImKo2IAZ6Xg83WBk/VUY9rvqT7Gm5FoUJH5Z6T9Y8s=
=O2xd
-----END PGP SIGNATURE-----

--Apple-Mail=_94AC2AF9-6F5A-415F-B80B-0FF153B6FA0B--
