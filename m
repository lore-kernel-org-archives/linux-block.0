Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A09C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0477E20836
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="OkPMEsGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfCDHxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:53:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDHxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 02:53:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so3413386edc.6
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 23:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LXgy6mKgiywajENFHQo+qsgRjz7Wb4xqiYCrJXNFhFs=;
        b=OkPMEsGXf7gQ06Sqi47MnYeTKTgUFZfOAB25x7f5wK86vLn0rZE43i7pW8lMRbJepH
         632AzNwMRA/DBGhPjJx+TG0uMJW7RdBT7KlA9zXAUHPqX8ocUwOARq/8mh4fwQkndkM7
         dwryH3Qu/XqyqoPpIBEmF6GzSsTyMDPxp10flIvN2KVFP4nlKq/Un7Nv3wI5CCmYKyv4
         I90YeYyZMoBhBUj5PFygZqKVrZRGhQRycPgbEdPCOhRXvWX41qX0H/kGPkE18nYpWBWQ
         c+EFwsCQWi79ExsJjNMcsS4vBswRZWjfwiOSwbMw2U5+N0qBm7PFFk6V0mIH0vQ2x00g
         PzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LXgy6mKgiywajENFHQo+qsgRjz7Wb4xqiYCrJXNFhFs=;
        b=OQXi3aTw/sgiIl2UtAwJZtgD7rYIKdCr78aFkh+B3PRtl//m/A9m/j+vvuKtiUOP5u
         oOwoRNNUF5jQhxlW/tHlLpLmA3GF7+ku4RgGZ2bPN6OJOMGg7HyWWxZQW9uyrU5oJwRs
         D82UxxkjH+6FEwJRFYIWOumdBRh/s0K0Q+LM9Bn0YWbkLBQTOgvlloJvALC8HpbL9p7i
         Nsh56GPYK3ccYjWt7NkoYeEvmbq1UqLoHIczZa81z3zKHUa4G0H/qWPtdz1NZw83eAED
         Uv3Oc0Ga6En0rZjnq1buI5yV+3Ms99QOGtknojAI+TEyQn2xTkIkUYx2kT1J95rPjTgU
         kBaA==
X-Gm-Message-State: APjAAAUvPhjp8/tLo32Gg6gC3RqPH1g9ia1bXknrzBv372AJQnzvLP59
        Z49HpoBtIHn3kWQAu01++HWexg==
X-Google-Smtp-Source: APXvYqyj3907R012cdAjSeLCH6Y+0ewSuUpRCmXxcGuftGUTzHDbQ6ooF7BsTGKNFHuYHqOCFkp5hg==
X-Received: by 2002:a17:906:66d8:: with SMTP id k24mr11638580ejp.141.1551686002312;
        Sun, 03 Mar 2019 23:53:22 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id f2sm1864674ede.97.2019.03.03.23.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 23:53:21 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <02F6919F-62BE-4501-BD6E-406E32DB9ABB@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C28CED37-07F4-4718-A93A-767F19A1A7EC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 07/13] lightnvm: pblk: Cleanly fail when there is not
 enough memory
Date:   Mon, 4 Mar 2019 08:53:20 +0100
In-Reply-To: <20190227171442.11853-8-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-8-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_C28CED37-07F4-4718-A93A-767F19A1A7EC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> L2P table can be huge in many cases, since
> it typically requires 1GB of DRAM for 1TB
> of drive. When there is not enough memory
> available, OOM killer turns on and kills
> random processes, which can be very annoying
> for users. This patch changes the flag for
> L2P table allocation on order to handle this
> situation in more user friendly way
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-init.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 8b643d0bffae..e553105b7ba1 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -164,9 +164,14 @@ static int pblk_l2p_init(struct pblk *pblk, bool =
factory_init)
> 	int ret =3D 0;
>=20
> 	map_size =3D pblk_trans_map_size(pblk);
> -	pblk->trans_map =3D vmalloc(map_size);
> -	if (!pblk->trans_map)
> +	pblk->trans_map =3D __vmalloc(map_size, GFP_KERNEL | =
__GFP_NOWARN
> +					| __GFP_RETRY_MAYFAIL | =
__GFP_HIGHMEM,
> +					PAGE_KERNEL);
> +	if (!pblk->trans_map) {
> +		pblk_err(pblk, "failed to allocate L2P (need %ld of =
memory)\n",
> +				map_size);
> 		return -ENOMEM;
> +	}
>=20
> 	pblk_ppa_set_empty(&ppa);
>=20
> --
> 2.17.1

Is there any extra consideration we should take when enabling high
memory for the L2P table? If not, looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_C28CED37-07F4-4718-A93A-767F19A1A7EC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx82XAACgkQPEYBfS0l
eOCJgxAAjsGy1TahbxiNRtLfMjASKGfp4fjtQDWYhdjVdj4WAaIjTJkhyCWaZ6ld
x9uQZDZKhJChRjjUUFtUt2nxzbAYroOo9iGA6anaJ7MwI4ViUIhHNipqz9yfOZBv
HgzHH3JA437+g1eJUL+yS+clKFxSpqyGwdpEXtKil2YA1aXPBvZhvodcif1tfatX
eQCJs2590DPV8GTz/aiYlybyHRbFnPIRVolU3GuY55Ogvh+iL7rNR6xlRF1oO4U9
toaXkpdQUK5A18QqicQnVR0AfZF1OSjT8MZSObSfbNGVvjf7dSgTNnbDQJoNbyR/
N8VUlL5eznR56ZdF6h5692fB6YSIt2mBED3NTTXW6XPDrzWxnaRqY2VrWxLCatZl
VYa0rR30T4D4sfuqkeInnav9aF/jQg2BCfwtjjn0/I1+HZiRPz21iCRGq2vXHdsU
93pAs4GQ0tXsgN+ztdKFcgSp2p+zSUruWPjkvaHyPV0rerCNDuWdBwSsLGW+kTki
VsGS5kkAAQVB0Cvuil19qxwW3fmscP5DARXw5xjltxKecejPqOI7bQI1YAdVNPMR
97LBdW+0zHDov9XmZ5MflD7h2MQhkMtprRWGqDYuf9koAZt8MQkQuvjWVNcJ385a
Ox9lQLcEOQnC6nB5xgntrjRGgqEVlNnCtawt6n9Mf/9Vv5LShj0=
=ZYjJ
-----END PGP SIGNATURE-----

--Apple-Mail=_C28CED37-07F4-4718-A93A-767F19A1A7EC--
