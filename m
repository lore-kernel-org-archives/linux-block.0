Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319BFC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D656F2086A
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="IsZ9lBmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCPWgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:36:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41818 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCPWgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 18:36:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so8811448pgb.8
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=V7/6hG+0UxpsrxFtwAUssIIX03Wm+9y5eDhuim3MhaQ=;
        b=IsZ9lBmu4hEDqYa6OA3XDrRCLZbFv9Dy6957MhCi4MsVjMfyoaj1PU+CitY1oPirCd
         t+GxTNuugVVxvCD408Xha9eLbdqaJlyFtvS6eIv9zjCNZnsOh3dpg4scmVhvFEWFQV+/
         gQ3QZJ+ns41hu3ko/if7S38mgPzzof3oXUBo5dzcquliSRk09zY/nLIcP/uny6GlZdvU
         wB78rzSIYyqlojpwB5rTp91jHcOOsGFJOYLgmfcJWTsYjE1S6xX/x9NEbbHan8FPzNwI
         rAFY/IkCbAXr6RcZm1wDzNnAGeDo+elYVMk5Misni/Ipc3Y2HOskilcn3LmKvZv6f2jr
         21vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=V7/6hG+0UxpsrxFtwAUssIIX03Wm+9y5eDhuim3MhaQ=;
        b=UuQDW26lDWj8tzyMhJFoNaHYy8JOCxW152DxZZPtB6qAoCu7/mP59HPIHcTe9eIkq6
         41e2iPKgB+UbNLXpnR+QBU0ectSnGfqlEGlZLP+AlyZc6FRJRJjnTk2aWS6imSEDnhD2
         Ukkt36H3YSk71sdDiqsJOm26eo9MH3+Af7WKgFZpcDSzRs8OJPVWRsp4H1DoIkPUQQrb
         +kAgHdI85H3eAa2DlqankmblZidgnUqk7lffP6i1wkj+mV9E1arM32nIE0v3u2/PelSo
         hjBg5zAniQFFKchWf2jTeBIo4dKi7EHi6XbeJOdzvlcnQFyyGkZdTr91tLTOQ+I+n8KK
         8LLA==
X-Gm-Message-State: APjAAAVYpImFoJK6F700ilN5hnHa/0ThBxYWIsVKE78YGM4e91T/dGQ5
        UDu7bCg9e3lWiJs4rAxazLpdZQ==
X-Google-Smtp-Source: APXvYqyzVyescMQlw8mrkgtEcbVs+FakYatz+vkjwtzTyASvB20takiozVX9n2I5D9kq+usMi9Ovow==
X-Received: by 2002:a63:fd10:: with SMTP id d16mr10343261pgh.306.1552775802057;
        Sat, 16 Mar 2019 15:36:42 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id l63sm8063052pfc.89.2019.03.16.15.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:36:41 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <AE7FD34D-0131-4A5D-A18F-0FD75A2C954C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_217A2C5A-538A-40AA-9840-2D862FE1B7D4";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 02/18] lightnvm: pblk: warn when there are opened chunks
Date:   Sat, 16 Mar 2019 15:36:40 -0700
In-Reply-To: <20190314160428.3559-3-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-3-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_217A2C5A-538A-40AA-9840-2D862FE1B7D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In case of factory pblk init, we might have a situation when there are
> some opened chunks. Based on OCSSD spec we are not allowed to =
transform
> chunks from the open state directly to the free state, so such a reset
> can lead to IO error (even that most of the controller will allow for
> for such a operation anyway), so we would like to warn users about =
such
> a situation at least.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-init.c | 23 ++++++++++++++++-------
> 1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 1e227a0..b7845f6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -712,7 +712,7 @@ static int pblk_set_provision(struct pblk *pblk, =
int nr_free_chks)
> }
>=20
> static int pblk_setup_line_meta_chk(struct pblk *pblk, struct =
pblk_line *line,
> -				   struct nvm_chk_meta *meta)
> +				   struct nvm_chk_meta *meta, int =
*opened)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> @@ -748,6 +748,9 @@ static int pblk_setup_line_meta_chk(struct pblk =
*pblk, struct pblk_line *line,
> 			continue;
> 		}
>=20
> +		if (chunk->state & NVM_CHK_ST_OPEN)
> +			(*opened)++;
> +
> 		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
> 			continue;
>=20
> @@ -759,7 +762,7 @@ static int pblk_setup_line_meta_chk(struct pblk =
*pblk, struct pblk_line *line,
> }
>=20
> static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line =
*line,
> -				 void *chunk_meta, int line_id)
> +				 void *chunk_meta, int line_id, int =
*opened)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> @@ -773,7 +776,7 @@ static long pblk_setup_line_meta(struct pblk =
*pblk, struct pblk_line *line,
> 	line->vsc =3D &l_mg->vsc_list[line_id];
> 	spin_lock_init(&line->lock);
>=20
> -	nr_bad_chks =3D pblk_setup_line_meta_chk(pblk, line, =
chunk_meta);
> +	nr_bad_chks =3D pblk_setup_line_meta_chk(pblk, line, chunk_meta, =
opened);
>=20
> 	chk_in_line =3D lm->blk_per_line - nr_bad_chks;
> 	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
> @@ -1019,12 +1022,12 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
> 	return 0;
> }
>=20
> -static int pblk_lines_init(struct pblk *pblk)
> +static int pblk_lines_init(struct pblk *pblk, bool factory)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line *line;
> 	void *chunk_meta;
> -	int nr_free_chks =3D 0;
> +	int nr_free_chks =3D 0, nr_opened_chks =3D 0;
> 	int i, ret;
>=20
> 	ret =3D pblk_line_meta_init(pblk);
> @@ -1059,7 +1062,8 @@ static int pblk_lines_init(struct pblk *pblk)
> 		if (ret)
> 			goto fail_free_lines;
>=20
> -		nr_free_chks +=3D pblk_setup_line_meta(pblk, line, =
chunk_meta, i);
> +		nr_free_chks +=3D pblk_setup_line_meta(pblk, line, =
chunk_meta, i,
> +							=
&nr_opened_chks);
>=20
> 		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
> 								=
line->state);
> @@ -1071,6 +1075,11 @@ static int pblk_lines_init(struct pblk *pblk)
> 		goto fail_free_lines;
> 	}
>=20
> +	if (factory && nr_opened_chks) {
> +		pblk_warn(pblk, "%d opened chunks during factory =
creation\n",
> +				nr_opened_chks);
> +	}
> +

nip: no need for braces here.

Otherwise it looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_217A2C5A-538A-40AA-9840-2D862FE1B7D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNengACgkQPEYBfS0l
eOAUUhAAzWk+h5/lQqMO+s56OaBrw9/S0nd05weKcuXiaY051OB7TdoEWOlgenHS
AFrBZgWTirtKXbxlx0XnpFHBlSozhp+BENvYRxXfLrKpJiBnkzUAZ2vpdLXoTajN
7PrfSXAHz6zIBCPJ7Bvb0xir+WMaIyfMznFWrguJXtg/VxX0+dd3IlwZPK8emBU5
jxke/9zCz7tuIgM+YWjH+3JLqHRWC5sSLWnSGQ2l8U3XjBcNz5sud4/irIvlraaZ
XGVzfk1U86OAdX1+aoh7aaE9XiOjSwQM/sHZ741xt9DhKXWLmMRYqjd8kdtyZctB
Xt9VEMgkUwa7IPItrxrqo8vA8WndIEb6BPYJOe3DMBwK74tDw6o5gxQYY37b7A2L
7mj0JhfeFrq6pOJfYk1tqXXY/RAESsLqEaWRJj+gwSiqGZ+KARadZd1LWoTdTZ5z
r28L7P5LS3JQfpwC1puyT0mqWdKfTKDrqL8/oEUjAmRvrd7ybSQ2N9QgURkvKlZm
Nbwj2grCA6M4L3jErefcTAtyx7TnDQXqMyqSADUdAnnU1dpou8paGYGgacU0DVgu
fdNmCl8v6V0PtD7mwU9zNCFx+M2OXfRpVVm4YfCykXEnX1p5kdXt4mVCSIl4kH1K
4ahnGSbMxhRSBES8uUg5IwqhWb9E1suOIG+DWKfu7ptW4vKqTMk=
=FBXh
-----END PGP SIGNATURE-----

--Apple-Mail=_217A2C5A-538A-40AA-9840-2D862FE1B7D4--
