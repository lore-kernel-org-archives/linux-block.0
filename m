Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8387DC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342B8218C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="aTjQBprf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfB1RJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:09:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35494 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1RJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 12:09:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id z13so12529946qki.2
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 09:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=uYLRq+eCaFR2RTILpiD+HRDLniTlkGHhkxSPDc7AZqg=;
        b=aTjQBprfibZ480XJ6JzS4JAiCdg673Dpz9BuIssn1rLmGXIp7lHCBc0ruIzoUTk+o2
         KKhApeCLpUUhuqF5ur4u8mOUwcOk3u/2DDOONuUn7dKXpTYsD7TICI4l61gSzlH8Cadl
         NdyxPzg/1eRhkxvZ4PqOhIVdVGfQ0R5WVBse1Hhtb3mL8ido3MIgJjRb6IJpznBTCtnC
         v/2xDX3zdC0a6ar2TmaOhd7CX0urmo2xJKJ0OzUsDYRvTb6oB/QXTGO+Xm107VbIwOEX
         16AqoU3GmFUnMuPAsuIWP8dUfLlh7wrk5z04SsTMz3z87tlei6HYY/jk6lCbBPXJYnR/
         gDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=uYLRq+eCaFR2RTILpiD+HRDLniTlkGHhkxSPDc7AZqg=;
        b=aGmsR7CbVKDTSL8rbb4QXPxWUY0MDfwaa4De3bJ8h1G6cN7dWCMVixnYNUwS9sPUrB
         TjjPwjR5hqUf/cQGTVI7W0qyTVwgJOAkBNruyTpKEQYcW23R+1cwboo1N8h0tzae8Hpx
         S8HS9Mq8nrs+Jjg5yh20Cjl1BGn3O97KLiTmk3nRBpaY4ErDellHAyYL+GXmoyFHhea2
         hWX4W4Q8fP4D32PKOog5aZvSzV9QRymUuZsLGoCE2gS6klKKMvScr1ExKoD7I6BpzRIP
         4EeZg/dI51toykEVkwDtXH2Jh2o9aTbmFYOTMVnHNd+za86PK8hQi8qj54RcaNV/jvna
         h/iQ==
X-Gm-Message-State: APjAAAUWEc8moWeyy1kYha8ACL/zKBMspC8QJ4J/N8hGXX72+zOn/kPe
        Blat22AOwTKdQBoNzCfTHzoWwA==
X-Google-Smtp-Source: APXvYqzTYntq7PQVcyDq/efiQkj62XV8JIi01d8ps0BC6If3EqecSGG1zz73j8cbYvjF2mQ/KEVkGQ==
X-Received: by 2002:a37:a20d:: with SMTP id l13mr354934qke.253.1551373740036;
        Thu, 28 Feb 2019 09:09:00 -0800 (PST)
Received: from [192.168.12.17] ([72.166.42.242])
        by smtp.gmail.com with ESMTPSA id p17sm12550149qtk.39.2019.02.28.09.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 09:08:57 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <7EEAD803-201C-477E-8ACA-7F152BC3C455@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C763DA58-98AD-447B-B721-E26FE126F0FB";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 02/13] lightnvm: pblk: Gracefully handle GC data malloc
 fail
Date:   Thu, 28 Feb 2019 12:08:55 -0500
In-Reply-To: <20190227171442.11853-3-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-3-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_C763DA58-98AD-447B-B721-E26FE126F0FB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 27 Feb 2019, at 12.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently when we fail on gc rq data allocation
> we simply skip the data which we wanted to move
> and finally move the line to free state and lose
> that data due to that. This patch move the data
> allocation to some earlier phase of GC, where we
> can still fail gracefully by moving line back
> to closed state.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-gc.c | 19 +++++++++----------
> 1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 3feadfd9418d..31fc1339faa8 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -84,8 +84,6 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
> 	struct pblk_line_ws *gc_rq_ws =3D container_of(work,
> 						struct pblk_line_ws, =
ws);
> 	struct pblk *pblk =3D gc_rq_ws->pblk;
> -	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_gc *gc =3D &pblk->gc;
> 	struct pblk_line *line =3D gc_rq_ws->line;
> 	struct pblk_gc_rq *gc_rq =3D gc_rq_ws->priv;
> @@ -93,13 +91,6 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
>=20
> 	up(&gc->gc_sem);
>=20
> -	gc_rq->data =3D vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
> -	if (!gc_rq->data) {
> -		pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
> -					line->id, *line->vsc, =
gc_rq->nr_secs);
> -		goto out;
> -	}
> -
> 	/* Read from GC victim block */
> 	ret =3D pblk_submit_read_gc(pblk, gc_rq);
> 	if (ret) {
> @@ -189,6 +180,8 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 	struct pblk_line *line =3D line_ws->line;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_gc *gc =3D &pblk->gc;
> 	struct pblk_line_ws *gc_rq_ws;
> 	struct pblk_gc_rq *gc_rq;
> @@ -247,9 +240,13 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 	gc_rq->nr_secs =3D nr_secs;
> 	gc_rq->line =3D line;
>=20
> +	gc_rq->data =3D vmalloc(gc_rq->nr_secs * geo->csecs);
> +	if (!gc_rq->data)
> +		goto fail_free_gc_rq;
> +
> 	gc_rq_ws =3D kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
> 	if (!gc_rq_ws)
> -		goto fail_free_gc_rq;
> +		goto fail_free_gc_data;
>=20
> 	gc_rq_ws->pblk =3D pblk;
> 	gc_rq_ws->line =3D line;
> @@ -281,6 +278,8 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>=20
> 	return;
>=20
> +fail_free_gc_data:
> +	vfree(gc_rq->data);
> fail_free_gc_rq:
> 	kfree(gc_rq);
> fail_free_lba_list:
> --
> 2.17.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_C763DA58-98AD-447B-B721-E26FE126F0FB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx4FagACgkQPEYBfS0l
eODJvxAA4547eq7ixcyIZTB5g8gxQ3YvQ5OnE8kQM60vUk3V1jEAUtUPTbIkJK2R
aGzDdx2MejLe902OGG3X8PINgn9Shngu1HmmVMsFr624K9rVLAjQfebGlF4fL7sJ
qRMS+PPOcXRIbhxQr3Y80AsK6Fq67ApXZJdHsiST29YGkeN7Sgs1VvhiySFslynl
tsRb3Qhur36MBmFFwdSv9FB0cOq/rte65d8MPRrgIvtQKaV/gsFXRLi2JfsGkwmr
vJS3Cj4MQdlCOyb7kjXdbDJVOtwehH6R/z96sNM4RBgC09Z8jZMH/obuB+zElVZY
NjYF7IpqyQa9kU6IMXDhHLNtSccHjSJUxCze+bu8ogMgmi7P0Ntiv83BqGgWQWqd
AQUIz489NEey1+4HnidfOSA6BodMi35zYBsBp0vTu2L0PQFpeAxLgzIT+HunNAHj
LwiaaqT+uk9oM8xv8FEFEnnIhjW9xCPzCrSYAbKPQyrZR3GGA6ThBSOG/4QmPfbj
ZN6sCHQT2CXhL2AUklYyydD8nld7SfOcEoW9G3pc/zBDS1RZWh2mZEiFMtY5RmJ8
6yasCg5Bn6D9sZ+i6s+QYVjh0tZYlouIjsaSwHtXS5PvjUqrkgRDhSLHNbTDmTUl
L7k930s+JHqLg4GfDpzFIUwK+kaZ95N/igUpwDrrRqgHDnbU7Q8=
=2kOL
-----END PGP SIGNATURE-----

--Apple-Mail=_C763DA58-98AD-447B-B721-E26FE126F0FB--
