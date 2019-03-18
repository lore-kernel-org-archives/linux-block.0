Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FBAC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F7E20828
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jjGYXGfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCRHm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:42:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42958 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfCRHm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:42:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id j89so12603390edb.9
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=dkuR4qxAhdr0qfJ8IvFzFoRHg+dVtfWqh77Lcy7DMmM=;
        b=jjGYXGfNQT++RQPhkZbtGoNvVdeqcoADDVoctZH+c4hmmTKRqYuJge6TX9JcGrCi3/
         wpLAL6DvYAIpq31eTuaxw6wRjd32Jvm4L7f2JtUKzoH0uQeoKKTI8bWTpNtCEvvFeVkF
         DOIpwpGBwdv8W5BbeKt011caBVooTFDy0DzRJJMv7E93mB6N4KXb5cJzFqkx/Hg56FnD
         Eg6nzoWyWfy7FY9wVcigYr+AYjU5CLYsnorFvZrO7IlVLojjyxY2T+GsWaGtmcGF5HYS
         uiTg0xHT3UyLaMQfPVhOoZa7XpXoZV970TyTwzoxDPp9MnUYhbeSbQg9zZKHeDKr0eIk
         HW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=dkuR4qxAhdr0qfJ8IvFzFoRHg+dVtfWqh77Lcy7DMmM=;
        b=VsypZt+3ok7gkEtN1dcI2UQybZ9rGPrG+1W5u4hmROk+3txBL1UbuLGAF8qgm2Vghk
         wPRSetihQlX0EgzVNOB7xOq97adz735bvcz9Xa7cR/YK9V8avX09/NRbOedM7+BqNHgw
         RJdBZyykB+wxrI3tDdRMANJW3GrPtQMEWQ0P4QIMRKfhqCaHy7OvXk4PELHVjLop9CEU
         jU0iWox3xmRLQC++dKhBi/smlH/AU/larscwXG8UKBPK7VgDJ8l+iE0iF4cYHa9r/+Ja
         KaPXbq48Y8jJC0u1+1g2xMV7shI7RieIsX9uWWxWGCbEGi7XTxwb8MovOnHUy4bQRP7o
         KF/A==
X-Gm-Message-State: APjAAAVoFVBckpxqm2EcxQXaVa8WXrH2461+qqsdYmuQEDLdGgJkCSQX
        osBEcf3WXOFIUCckiJrCKl2FTA==
X-Google-Smtp-Source: APXvYqyg4t8J50+nU8sk0RkZU1APh0NNusTdpHzyXyvb4ElArrzDIYotYc5J8JVmVC9SVdEBp7i0OA==
X-Received: by 2002:a50:b0c6:: with SMTP id j64mr11944847edd.204.1552894974118;
        Mon, 18 Mar 2019 00:42:54 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id d10sm3267859edk.14.2019.03.18.00.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 00:42:52 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <FFE27E31-83ED-41CB-9D6C-327C3E3BA7D9@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B064F00B-54CA-4898-B11D-1B264A6EA55D";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 15/18] lightnvm: pblk: fix in case of lack of lines
Date:   Mon, 18 Mar 2019 08:42:52 +0100
In-Reply-To: <20190314160428.3559-16-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-16-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_B064F00B-54CA-4898-B11D-1B264A6EA55D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In case when mapping fails (called from writer thread) due to lack of
> lines, currently we are calling pblk_pipeline_stop(), which waits
> for pending write IOs, so it will lead to the deadlock. Switching
> to __pblk_pipeline_stop() in that case instead will fix that.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-map.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 5408e32..afc10306 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -46,7 +46,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 		pblk_line_close_meta(pblk, prev_line);
>=20
> 		if (!line) {
> -			pblk_pipeline_stop(pblk);
> +			__pblk_pipeline_stop(pblk);
> 			return -ENOSPC;
> 		}
>=20
> --
> 2.9.5

Have you seeing this problem?

Before checking if there is a line, we are closing metadata for the
previous line, so all inflight I/Os should be clear. Can you develop on
the case in which this would happen?


--Apple-Mail=_B064F00B-54CA-4898-B11D-1B264A6EA55D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPS/wACgkQPEYBfS0l
eOAYmg//a3wRN4I/eK+wNb+WeOsTgmgpR7crXwmQJe+tjtI5ypnPbf8GB7LWykIL
AMw5x3lus1x37CNY5UF8piFEg2tfD3OutjERIu6WOZfbtOj9wCWaFyx4HhyUaA4w
nKXlyKuHIcyUcL372sNJvWPl8dq6boY6iJRsL1XA7OB+YUp2XCqV7o0qkPrHiAEx
cuDnHM828IvTcv333PvF3Udud6CddwqjmCDgs+ZyLSyuhZpGq/SkDUjqN+I1kcg3
9F4P+LhFMWanI0Zv8XgP4xCkxgH3F595PoUYu2jZ6J9AFiRrm8N+mnmokRbxbley
jJg3bA9l00LwypFMYqq+YvFofC+ZigcH7+JvZegm2B2sb3hyGEmYemESG4gwp1kt
DbdyGG+xKVa+TpmOTUFKsErEEctPzcke7sjTtnNpqzYPQl+XJ78Znari6zWwtDru
h+V5dBB83a57Jmg2PBp8IeUis2gR3F8inNutMTIrfspe0JsvUS16DJnzMo50D8Hl
mET6ktAbn5c/bSmthmusosyNWE/YQ8ZQicF0EgZAgFLajgbqQr4peGyVs8Fcc6d1
ZL/WWO6iNn8tMLEiscwS+DCZuBRzdU8z343Ai4dFy+rpgxvjXcidIQKfd3aETba3
XsKxYzESE6RU1l7n2GzDDWCC7Jla9Xu+CA59OiM8d7eJW0j8iuk=
=O8+Z
-----END PGP SIGNATURE-----

--Apple-Mail=_B064F00B-54CA-4898-B11D-1B264A6EA55D--
