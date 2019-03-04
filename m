Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701FC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D69620863
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="vl/O09A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbfCDHWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:22:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38926 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDHWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 02:22:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so3352782edc.6
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 23:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=e8qR4ZuQcKIWGKRrDBfFTVdpX4pv3vVLyIjiZIVM3EM=;
        b=vl/O09A8a01r7RdRJq2HOeYQpH6EpLA6daum9Yhh4abfE6LvJn5LnO2GFFIX69ewfc
         XI15hTb7IcO8066PEkzpX010HVzqIAQpVZOZ9SX5+DkUiG+oNGo620y09KEoVhAaHdGd
         OiE4jFIqb+9D5MZzpI6BeTk+X/DtJhWksaoMowAp+KQKHbZnodZpCQy7riGfOI0XVZ38
         HJVQBtC0Vh7uUxAR7Q9eqSBbLOiTyyMdtHmSxHZ2AsU+Sk0iTBGF2Ut8rx5sZA/ajNVW
         hErSffOfIKy+GxmLgnYN3MncERGlnZ9c12++lCwKDCTeUJgREx751dRGcrwnsyfb78SO
         5IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=e8qR4ZuQcKIWGKRrDBfFTVdpX4pv3vVLyIjiZIVM3EM=;
        b=SWTKuZpe8wgm2NlvoFKRJtCIezxXwttBihAEldAnVSEXOSIcXLDul5/FJN2BoPfZY2
         dVNeyHKcwTidO4h1mk2ei+B/O1zzkLjbHnVG9jUhDfTiQKqaNKYGSUI67gkSuxGMDGzb
         4VLR6c5ZMRkydyGM9TTfqeJ+QSZ0Lj3y48cgmZgYSZLlgrD4yq5pEyPU5s26LAugbwaX
         NreK4qUwYYrTBINHHPnZJxRT0fwctbEDLOUtUrpin+cnNW8e8ZWh/EQ9tGVq8LKaYwbZ
         NC5xKy6LWdfXD0RG+HkeNoH+lVTPm53dN9I5y1i9wM2XfGOIHZ4VpxcqDM23l6ho+2yQ
         YD3g==
X-Gm-Message-State: APjAAAUg58pupmpKBeHvpUYyQ3vIM17qQvCbe9q2+Rsgi1mgDiE/7y1D
        VFMBQ30womKwS81sQDbWOdPTmg==
X-Google-Smtp-Source: APXvYqzeaZ+DbaKzxO9e6vFCL4H6UF5EHHKe6nX3/HMiZZ0kTMXhUxEzh3veUM10mAtb4FxDyUjRig==
X-Received: by 2002:a17:906:b350:: with SMTP id cd16mr11802303ejb.203.1551684172513;
        Sun, 03 Mar 2019 23:22:52 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id b5sm1028034eju.74.2019.03.03.23.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 23:22:51 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <4D377F9A-B347-43B1-B5BA-1F89B2631BDA@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_01288DA7-6091-4059-8D7E-CBCE0E287C65";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 03/13] lightnvm: pblk: Fix put line back behaviour
Date:   Mon, 4 Mar 2019 08:22:50 +0100
In-Reply-To: <20190227171442.11853-4-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-4-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_01288DA7-6091-4059-8D7E-CBCE0E287C65
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In current implementation of pblk_put_line_back behaviour
> there are two cases which are not handled.
>=20
> First one is the race condition with __pblk_map_invalidate in
> which function we check for line state, which might be closed,
> but still not added to any list and thus explode in list_move_tail.
> This is due to lack of locking both gc_lock and line lock
> in pblk_put_line_back current implementation.
>=20
> The second issue is that when we are in that function, line
> is not on any list and pblk_line_gc_list might hit the same
> gc group and thus not return any move_list. Then our line
> will stuck forever unassigned to any list. Simply resetting
> gc_list to none will fix that.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-gc.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 31fc1339faa8..511ed0d5333c 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -64,19 +64,23 @@ static void pblk_put_line_back(struct pblk *pblk, =
struct pblk_line *line)
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct list_head *move_list;
>=20
> +	spin_lock(&l_mg->gc_lock);
> 	spin_lock(&line->lock);
> 	WARN_ON(line->state !=3D PBLK_LINESTATE_GC);
> 	line->state =3D PBLK_LINESTATE_CLOSED;
> 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
> 					line->state);
> +
> +	/* We need to reset gc_group in order to ensure that
> +	 * pblk_line_gc_list will return proper move_list
> +	 * since right now current line is not on any of the
> +	 * gc lists.
> +	 */
> +	line->gc_group =3D PBLK_LINEGC_NONE;
> 	move_list =3D pblk_line_gc_list(pblk, line);
> 	spin_unlock(&line->lock);
> -
> -	if (move_list) {
> -		spin_lock(&l_mg->gc_lock);
> -		list_add_tail(&line->list, move_list);
> -		spin_unlock(&l_mg->gc_lock);
> -	}
> +	list_add_tail(&line->list, move_list);
> +	spin_unlock(&l_mg->gc_lock);
> }
>=20
> static void pblk_gc_line_ws(struct work_struct *work)
> --
> 2.17.1

This comes back from the time where GC was single threaded - I left out
this when reimplementing the locking. Good catch.

Please, add a fixes tag for this to be back ported.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_01288DA7-6091-4059-8D7E-CBCE0E287C65
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx80koACgkQPEYBfS0l
eOC/SBAAlFd0cwm/ufVmGWhc6ZQS2EFEAkxsJ1CtpN+hSaZF/RALpaY6fm6apyDV
c5gpcRH7hxsrp6Ymhq9u/ta/GlEFnuBFrqhy3z72jN+jF4yQFhfGUkSsozuxeqjS
2fNyackLiLs6nsCMuYycxbvKFs2fW3U0dFsFnAtlykvDwf10yLHlhoCD6yxG7mS8
407V3PsU8mxiEP9iUN+60C8FWQS3yJ/tvtjt8xk+P9kC95YnIZipWh7knmeep2GD
C0fAp2IONwrJ9C0QdjE8kRDFebQy4Uf1LhCP6UwaQgNtMQ9apXyRLsDzE+uUe6rA
3XNSGOdJtN+nHuWl01V62tjXepppMmxZVE/sROiLpvtwAD7396IqLRgqYwBiT4S3
iN+rGzOnTo++HBxLs+0LEsonUB3v8Z/tNJrb4HW+pO8If7YVJ+kRRN2KO+pp/2VW
HEU/J3BqXjGayxMRAOXyTD9ewEpPInE8kZm+Qhjwe6B9ndpNY3M9GAXJ19vPOWeh
1QIJnU+bLZHrvrssUT18VTLTvvVnY3XtjmMHPcOabbEeTW8/WDUz7B19qUaz3KGF
O3xKlTgWMNaDQ6OwZcCo11emTRLXcDxOKV6ihvmYzMZl9fPx5ZbXU+rIjoHFT3Vd
kJH+fUCmMCiX65HusE7FekALrqjLMhPOeBYGtA/O7ovKqotfyvA=
=xujx
-----END PGP SIGNATURE-----

--Apple-Mail=_01288DA7-6091-4059-8D7E-CBCE0E287C65--
