Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A34C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 06:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76832083D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 06:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="r3octX7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfCRG4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:56:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45276 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfCRG4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 02:56:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so5948637edd.12
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Y+fCUWypa9Wa48AOjJ7DsieQeHoG5KFp1jhdxCULZuI=;
        b=r3octX7b6BNdvt7yVmH9Q4f1qoX+c7M6ODBEUJzJoh3zgE8bQrxlTYpH/GzSjnjDCu
         xe4wj8PtqUpRq7hyGvi5Dk35U4D9vUPLqdyLQfHD4qYfjrLuZOGnXQhyKRZKONto34zl
         /Pe54YeKVCZv6z0UuMLsGdnMqHQ6/hmRQeyH/SQZTTRu+XabeLhLv1sLcvNu3z/Lenus
         ALWF14dg+9o/ra5J4sdDkhcPf1JRN2MXK9lthSvzkmPpF0Le+7U7ThYCJ2Anc5wLm0x2
         Zld4hCwZ9bAGSKu3fykYFWuhV6d91L0G7S7reShtvhEuShncMM78CR+01EeQTf6qihss
         YfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Y+fCUWypa9Wa48AOjJ7DsieQeHoG5KFp1jhdxCULZuI=;
        b=q4CXxqFSv7E/YiKF9bhGgBWXGb2acgJFngfH3MsEo9nYHJqIovhcBro/hvY1MADRaT
         T4O6J5OD65hPWlcmh4HqQBQyLQzZb3omDhEBkg6IHgYsmD94hsE0+USoW6mr8eJfzTCN
         sfUY2nFQugI6AxCLejGa+Cp1Iq1HEJYdLHlojuyKEhMLMcHMkQETZAvpHs79HZLiF2B7
         QDnTf8x/EMfUiE7hZWjHAk5/GIiIU5hVd6tKxuFl+b6BBnuPcWTFHNGcs7YKe+cggQSj
         twWlyQEhJIIp98E67TuHd0YP+4APYeHoEBpkgl50g4PixpYoq0CF4iVDCWUVjAzMkTe2
         lOwg==
X-Gm-Message-State: APjAAAVFCHQCBYCARHlEQVqLMVM3bEiL9vHBhs0ZSmHzCzArvlKIkRn3
        TghU5P8g0wj36CfES3KeFYzNRxuV7WlGnw==
X-Google-Smtp-Source: APXvYqx4FNfpwBB6c9uTZKyp1GoSVcDCbE+M8weF+I097x7KhGHHMqlAmXLmfJSZxkyiHTCc4FqRHQ==
X-Received: by 2002:a17:906:289b:: with SMTP id o27mr9947989ejd.161.1552892174771;
        Sun, 17 Mar 2019 23:56:14 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id r48sm3148232edd.87.2019.03.17.23.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 23:56:13 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <13318131-0146-420D-94B9-5E771F344E2A@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4B1EF17F-6261-4535-98E7-4538FF788884";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 11/18] lightnvm: pblk: fix update line wp in OOB recovery
Date:   Mon, 18 Mar 2019 07:56:12 +0100
In-Reply-To: <20190314160428.3559-12-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-12-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_4B1EF17F-6261-4535-98E7-4538FF788884
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In case of OOB recovery, we can hit the scenario when all the data in
> line were written and some part of emeta was written too. In such
> a case pblk_update_line_wp() function will call pblk_alloc_page()
> function which will case to set left_msecs to value below zero
> (since this field does not track emeta region) and thus will lead to
> multiple kernel warnings. This patch fixes that issue.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 73d5ead..4764596 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -93,10 +93,24 @@ static int pblk_recov_l2p_from_emeta(struct pblk =
*pblk, struct pblk_line *line)
> static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line =
*line,
> 				u64 written_secs)
> {
> -	int i;
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	int i =3D 0;
>=20
> -	for (i =3D 0; i < written_secs; i +=3D pblk->min_write_pgs)
> -		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
> +	for (; i < written_secs; i +=3D pblk->min_write_pgs)

Why no i =3D 0 here?

> +		__pblk_alloc_page(pblk, line, pblk->min_write_pgs);
> +
> +	spin_lock(&l_mg->free_lock);
> +	if (written_secs > line->left_msecs) {
> +		/*
> +		 * We have all data sectors written
> +		 * and some emeta sectors written too.
> +		 */
> +		line->left_msecs =3D 0;
> +	} else {
> +		/* We have only some data sectors written. */
> +		line->left_msecs -=3D written_secs;
> +	}
> +	spin_unlock(&l_mg->free_lock);
> }
>=20
> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line =
*line)
> --
> 2.9.5

Otherwise, it looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>




--Apple-Mail=_4B1EF17F-6261-4535-98E7-4538FF788884
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPQQwACgkQPEYBfS0l
eOBrVw/6A9bxVvjvJQAyn8lWlEqtPLxrCMB6qSNH1nBT99LKfVm800TmlRNmC8NX
OTD1iLn54HV3Ma2Cjxlr5UZ4X9XNrcF3x+LInZZBj68dmHr017fnI91phTOO9hjh
j9LUGmD1isPu16Ny7DTPdLDS9u5SrHfg3Mdu9vredQ7LrYik3vJt3bG7ZqX1X1Wm
3NvnrH9BOuLVJzgqPHaX/GsQk/cKfSQee9PyoK6tRAHQ6aYUMuegOwNtYnSnBa2T
xUWiP55IVwIKWc5QIYCHhsGxZLd4o/DI1xRjVUrnRK/MQLWljlgBnDMJdkC7pppC
W8B+vqpYc9VCwH1l5lzTrbbRFNsUV55/4ggfX9x1qYbsV5dN1FX1VLrnnCz9nC+Q
c2uTo3JKBm6HTKiEGgYNYuhsimWGoTXjXgzN2pUQMSZE+ZIo45HKICmzRjubYCHE
5EO6Yn7K6nM0eBJRmbbfORh6eIYY6G3Due/+0Foycxzq0dicl8ECo7Mxd/DDBnHe
B9H0F1jkZifpQsClZ2DF7HWjdmxWJKR3wELvUnsDKOv3Cqpkx7yief0jW+lRBZ66
MCYyNBgRxHnf9ssrftA/yRKwYNXl+D7/88hUgkOjCQ+jr2EHIwRZ9mpCzf/6E8Cx
7ZWs0CEqiebOZzkLYzDjOTFvlTx7QYtInED8pWjgmCLpVVGzx4Y=
=06Hm
-----END PGP SIGNATURE-----

--Apple-Mail=_4B1EF17F-6261-4535-98E7-4538FF788884--
