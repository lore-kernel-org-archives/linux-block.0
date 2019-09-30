Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE471C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7312075D
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="mGLIO9Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfI3IGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:06:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44504 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3IGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 04:06:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id r16so7710288edq.11
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bhCXeT1pshCRnI3I3+5YHaCRK9iqpcuDUzbtYhTbd4U=;
        b=mGLIO9MtSZzET0J2dkj6BX7WiaA+H8UOryLnIZ8LRTuL33kaTEgD6QBTxfBCcInVHq
         M60usB/UBo5muGPMTGCtS+yL9sFKs4J+BMYSQBLhHeD6LzT8JAKAc5qvCoAa2EcTFnMH
         MIlu6EcdLp7NfHf3QyVIKo0dfjSAa2VqzN2k78dUo1jotuBqNRo9xWtj7hsVYGmNbiBB
         ecAQIQoopM3/4cBHCoV99ro8ukLsA4/pGYstUJJrqghPNWjovQeuH3jpDWtVinTfLdmC
         j8G4nYZEm4EsjcyYNQJrThnfOwjK0k9rjOMHKCSRxVDzs9kEQ5TnEOJczeVTVWNMS4o7
         RPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bhCXeT1pshCRnI3I3+5YHaCRK9iqpcuDUzbtYhTbd4U=;
        b=pzVPkt9mUIWI13pwuAQsZ9xU7A8RfoK5qfqcykPoYsCYHNFwY2/zo0EbvncAM3vgJW
         Sp67Pd+JO1JTNZsZYvgvSQBPy/LyRGE9bL/5BxTam9b+2weTjQ1SFBWssoEmoefUVnYu
         X+n4UXIzWVCVPEw06DPNEZYc1woAJsIVnIquJVqDE3dBAXQ3pTouNv33hSnkLsk/k4G3
         9P78bDC34n0JdDHfCY9hlyruZvfXTgxFOS69Wi4Wpjqeq8VeLDcZF/53upMEADmRD8tg
         fWW2qJXd1vrH0TjA9FGjttptQylP2AVOARTdP0AKuWoKb4natc4vq0TF1TtuF322Sh6z
         w5Jw==
X-Gm-Message-State: APjAAAWcS+3NMDkY+6kYoOdyHET4HbrLcWOn8ZdLeVbbbKLQjsDfCldq
        GC0kdNX+gk0Ih1rv/gG6fAwZeA==
X-Google-Smtp-Source: APXvYqzUval9YSx3UeU/+Slzvv3oSjw3iUYNLM8IAgaPtThFyeF46KNKpQMdJlZPbz/tiHzGlOqs0g==
X-Received: by 2002:a17:907:11c8:: with SMTP id va8mr18016520ejb.111.1569830801252;
        Mon, 30 Sep 2019 01:06:41 -0700 (PDT)
Received: from macbook-pro.gnusmas ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id d4sm1351963ejm.24.2019.09.30.01.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 01:06:39 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <8FE3FFB7-4FF5-4BF5-B95E-2FECC003702D@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1E4C8571-4692-42FD-921C-8B9C2894E5EF";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] lightnvm: prevent memory leak in nvm_bb_chunk_sense
Date:   Mon, 30 Sep 2019 10:06:38 +0200
In-Reply-To: <20190930023415.24171-1-navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
References: <20190930023415.24171-1-navid.emamdoost@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_1E4C8571-4692-42FD-921C-8B9C2894E5EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 30 Sep 2019, at 04.34, Navid Emamdoost <navid.emamdoost@gmail.com> =
wrote:
>=20
> In nvm_bb_chunk_sense alloc_page allocates memory which is released at
> the end of the function. But if nvm_submit_io_sync_raw fails the error
> check skips the release and leaks the allocated page. To fix this =
issue
> I moved the __free_page call before error check.
>=20
> Fixes: aff3fb18f957 ("lightnvm: move bad block and chunk state logic =
to core")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> drivers/lightnvm/core.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 7543e395a2c6..5fdae518f6c9 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -849,11 +849,12 @@ static int nvm_bb_chunk_sense(struct nvm_dev =
*dev, struct ppa_addr ppa)
> 	rqd.ppa_addr =3D generic_to_dev_addr(dev, ppa);
>=20
> 	ret =3D nvm_submit_io_sync_raw(dev, &rqd);
> -	if (ret)
> -		return ret;
>=20
> 	__free_page(page);
>=20
> +	if (ret)
> +		return ret;
> +
> 	return rqd.error;
> }
>=20
> --
> 2.17.1

You=E2=80=99re right, there is a leak here. Fix looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_1E4C8571-4692-42FD-921C-8B9C2894E5EF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl2Rt44ACgkQPEYBfS0l
eOB5Mw/7Bs1F12y0gPbgfKsKy3amWsMxtOGXL3dshCtaaoaIKHQv6oQtXxIVndDZ
km4Dj72xLh8UpgCy/jDTo2MCkGRWrBqBbvXkE3YSh+cYz5n5IyfJIn3VohuQV0hW
bJkW37nBTFeRok7tUEauNQDthida+/mNvxpq4w0+8JVDBOK7RW0URrmRJ0sC/CVQ
NTEjCwetQOskXa0qwIjDldGxeMGf/ZuaRZDKFRjWpBkncadGvq5dsW+L9ApQ4UDD
SD6Vi3HX2l0KCpydFd9QPKuYJUn85AIO3FVwdj7A58ZzLtC51A3BpN5kawtY/H5S
860bCRGLJXiAsIO1F0JTl8ThoiDbX3PqY121tJzicTBWSP8GBft44DpiFsi+89+h
Z6UL/bw8xSTN9ee29SAijfD1T/a+3pY0rHoXkmEYwu1o8OgI1DPjPpLMVrCktUZQ
bxy9IhVzaap1vdaJuGGbKS88HryhCyXGfoOLrgeEKn7TOlfGkfQPPzW7Rhnu6e8N
8jdTQG36OFz4mLDd7CSFFLtFJk2gq5wLllhivQT1ihkOwc4LYGi68Bp5OMEDgCbV
JRVHbpuvwE7hco/iIMVVZtKmTz/KfdXBjYANNYZDL1e5FQBohFrdVK+f/S0dLzSE
s6uBG3sV/3iINDLHy65MUQw03sXVGfB3nAd/jIra6PF2Hk4oRT0=
=CGOW
-----END PGP SIGNATURE-----

--Apple-Mail=_1E4C8571-4692-42FD-921C-8B9C2894E5EF--
