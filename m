Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D57C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC98218AC
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="bmwkGuqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfCPWsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:48:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34615 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfCPWsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 18:48:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id v64so8742081pfb.1
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RgY7i/K4a+OMl7DhgCjblZMdmk94iOZQyD46VMI4mmQ=;
        b=bmwkGuqtEmmZglKdQXQgvlQ4tfp6fs4zm0fVfvSxnEp0+hFOMLNutrYLYSkw/dlZVM
         Hzg1w7uwys9pxmqE4ZJmUdsvn7Ss2dJxwkYEgbeBHJdeC9xCUvIJS1G7DAZn9IWJmzvw
         BEGdpt30LzSpcD8+73EBrigfafYNyah2jC/lSWrtY0AH+jeQYHzYDTYHpXv32SULNxiM
         3zrgqaVxW2euxgGl81aQwRoKuuf/fgJKniiFbcJPGdcd2SYelV3w1v0XLpqKyYYXIoXU
         fxhlenEFjgwQFkjIVCNd9GqxxoY0+kgt4DWCeairNspCHQDkruFN1o/FUnBcYFWSBsWC
         Rpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RgY7i/K4a+OMl7DhgCjblZMdmk94iOZQyD46VMI4mmQ=;
        b=qKt5jM2od1AUS4AOnwvCZmmLccCiKBnm6hubKy/FeDKfA/+tf+iNyr7W1KrHu43+vT
         aXw18Kgxs6JIK0X5u/uZJ1U+uf8Vf6B+qijhGC4fmsBAEgPu3+GQ93PUQwgqDkp9lppO
         Gk8xyI7RAApaX5ORmxts2p0lwwrXMZdNHMqkKiIY3zJp7L/aCZDgxE1vYQbHAofSFyg+
         u8CdET7esNsj+d876ml3ubsy80am3t8ShWvcVwnzOhU72Po19+wIZE5O88rC+0ch+/i+
         4SOZ8w5NOfenu0V1d2KJsV4Y9wFtI/4vuGFJOslBbksrfnTre8lWqokj8hjxmTDy+8eW
         zRlw==
X-Gm-Message-State: APjAAAULjZLaahhA1aIA/sJvIYv+c8Rqn2Nk4F7QUdB4oa/90AEwLG2y
        ZD+wmRzFq9VxZG6z9FMEhMDbog==
X-Google-Smtp-Source: APXvYqyx0uFNJmXWijiAEJveeDXy7tupDeaK7fLEWXFH4dyqAGc+U3zNgqgnWA6n03zRYpaUahPlbw==
X-Received: by 2002:a65:5142:: with SMTP id g2mr10482793pgq.149.1552776490792;
        Sat, 16 Mar 2019 15:48:10 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id r198sm6254961pfr.168.2019.03.16.15.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:48:09 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <C193E509-525F-42CC-8417-70F575A1EF2C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_95CE6F44-34E9-4E8C-AED0-47D558307629";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 05/18] lightnvm: pblk: propagate errors when reading meta
Date:   Sat, 16 Mar 2019 15:48:05 -0700
In-Reply-To: <20190314160428.3559-6-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-6-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_95CE6F44-34E9-4E8C-AED0-47D558307629
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently when smeta/emeta/oob is read errors are not always =
propagated
> correctly. This patch changes that behaviour and propagates all the
> error codes except of high ecc read warning status.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 9 +++++++--
> drivers/lightnvm/pblk-recovery.c | 2 +-
> 2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 39280c1..38e26fe 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -761,8 +761,10 @@ int pblk_line_smeta_read(struct pblk *pblk, =
struct pblk_line *line)
>=20
> 	atomic_dec(&pblk->inflight_io);
>=20
> -	if (rqd.error)
> +	if (rqd.error && rqd.error !=3D NVM_RSP_WARN_HIGHECC) {
> 		pblk_log_read_err(pblk, &rqd);
> +		ret =3D -EIO;
> +	}
>=20
> clear_rqd:
> 	pblk_free_rqd_meta(pblk, &rqd);
> @@ -916,8 +918,11 @@ int pblk_line_emeta_read(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 	atomic_dec(&pblk->inflight_io);
>=20
> -	if (rqd.error)
> +	if (rqd.error && rqd.error !=3D NVM_RSP_WARN_HIGHECC) {
> 		pblk_log_read_err(pblk, &rqd);
> +		ret =3D -EIO;
> +		goto free_rqd_dma;
> +	}
>=20
> 	emeta_buf +=3D rq_len;
> 	left_ppas -=3D rq_ppas;
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index bcd3633..688fdeb 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -450,7 +450,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	atomic_dec(&pblk->inflight_io);
>=20
> 	/* If a read fails, do a best effort by padding the line and =
retrying */
> -	if (rqd->error) {
> +	if (rqd->error && rqd->error !=3D NVM_RSP_WARN_HIGHECC) {
> 		int pad_distance, ret;
>=20
> 		if (padded) {
> --
> 2.9.5


Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_95CE6F44-34E9-4E8C-AED0-47D558307629
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNfSUACgkQPEYBfS0l
eOC1VA//U4C63T0CQkPF5epOs5suL0wpJ9W4kDX9RvCUfNTzfQ2Q/+XdnCw1T4Ph
V9+GyrD/YIfjYXGeCerBQ9mrYMYuVUVElfzmshpoOF+nbUUZ+AHZZMB6YJh6ssVt
07/VPEoXOv0B0pQLEPz0izlIJBQLCf9KBTBIIS8I7KD6AUGo1KJ3mXQHRTho1Xqr
Rf193TuAtCN8BU7idthvJtEQkoGf3neoKzZdRNhl/zoM1JsfmNAI1kqUQbt1RaDP
gMekxaX/zUMRb5FgWkaS9YAQzZkbr4NvGEP1h8txhBtoF6xVp5eV7ZxRDpw5PMR1
h2zec6d7yKkueW6F6hg205xbhWvcEnUAAPQIU/GUrTuTzGEMUnrkcE59CxcGhdI2
zLVzNz9h3Mxfqxl8wvJqmI7fArwFrbnC+AgYhgFI703thErWcbDvXYIIiyt0hWOx
V9TV1d615N6j8KJ1WLOnEYb6Am7cHFjzNXPphY4a/pWPwzF9NfSKeb7Uv5cPkmQW
4c4w/HhH6JnJAG47Lbev66+JWHIKWXnoWoJKcsmovaX+Fz3nM9cLXsRKCv08cJ+c
4ib/BKfLzQAGsh2zPpCDtWwWuvP78hTIdlJ4BMflxR3A9C4+tHrlk9ijEXv8nJ72
LujZlRyd8PfLJS0p470a2ARVtG0JYFXPAvbJsG7j2DdSuJIBCuE=
=cN9V
-----END PGP SIGNATURE-----

--Apple-Mail=_95CE6F44-34E9-4E8C-AED0-47D558307629--
