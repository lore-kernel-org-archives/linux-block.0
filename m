Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E1C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC8520661
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="og5HRY4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfCFOJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:09:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43359 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCFOJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:09:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id i15so2268700vsd.10
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EN1uh6wiZUda6oC9SYI+pjZcdgxLmZ4GgeqCnlbeqjU=;
        b=og5HRY4hyuBe5BCJ47/Ru0DLcg6nJyIIVEfheyS/wfuw4VUXiqZWRYDRifVLaqZTyM
         zZe0ytQmO0bNoIEUSMrfWFAV4CYzPxiV/ryrn1NVkwJnPi2QIyPs0f5t1H1bg3ORWRdZ
         lKalXON311MUolgyFi+gC7ngIMbIA0uf9ScBHVPfu5t+cE1lmFqHVwyrjqF/TsS2/BpS
         BoaF1Rs6QW0RQ6nys8NqYuJYnnuC9lnpi+6LEJZoYH8i6CAcqcu7R0esBMSTzYa3y2Jg
         A4zTxle+vr3L33b1KUrZRmjSaVFlV02LqtHJgYiqUXVj0e5XJaUUfr+3xHYqnV/oUH4R
         5SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EN1uh6wiZUda6oC9SYI+pjZcdgxLmZ4GgeqCnlbeqjU=;
        b=AhjNygblfWW3t8KSalI19NbYXlM65dpO3NYkqKlfeddS4Q0Ip6Fa14zobD+9m42P6b
         ieQKCbs9hPrXinvrzil+PDJNubjPDPQxOSh89GQ6wI8YlPD/V/juDi5PlAcfe4CW8IHD
         ixlbz+DBPuyU6BWmo3wDZIzgnU29lQiULhDNmydt4ji5NhCdoyr/rgKn5ogi6wrjne2m
         So685xITc3ra1WJCs9dxEb7TLmk3GUGmgHLs1RFwVIi3vIKVksJz3Xc4z7+1oZ3KW7NH
         5Fk6lfkk7098q4nc1kZwZrQC3ARM6U0MNQwu4CfJRggDVb4e6Vubslf8kNoWI4XrDwsL
         WiDQ==
X-Gm-Message-State: APjAAAV8WxV98UkHzOKKyiarT9dDDXaMSt1EIw/xEuoJ+lJP6RwXFNqG
        h+mdXJe9A8YmcxZNa0E72ExxNiCWfnLa9IrkkZP43A==
X-Google-Smtp-Source: APXvYqwidtGDSEsyP0RCCKsgE7ZDaCvexHpSGu9gm/IavYgv9dqSnysrJMgb2pmvlAGj5tvyy9uI6jS8s1Zxp7BJoT0=
X-Received: by 2002:a67:bb16:: with SMTP id m22mr3929527vsn.153.1551881361464;
 Wed, 06 Mar 2019 06:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com> <20190305135120.29284-2-igor.j.konopko@intel.com>
In-Reply-To: <20190305135120.29284-2-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:09:10 +0100
Message-ID: <CANr-nt3PM90un=cLMN1pZj-Ja0qOwbHc1jJf5X1hJjp=o_kX+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] lightnvm: pblk: Gracefully handle GC vmalloc fail
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Tue, Mar 5, 2019 at 2:54 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
> Currently when we fail on gc rq data allocation we simply skip the data
> which we wanted to move and finally move the line to free state and
> lose that data due to that. This patch move the data allocation to some
> earlier phase of GC, where we can still fail gracefully by moving line
> back to closed state.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
> ---
>  drivers/lightnvm/pblk-gc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 65692e6..ea9f392 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -84,8 +84,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
>         struct pblk_line_ws *gc_rq_ws =3D container_of(work,
>                                                 struct pblk_line_ws, ws);
>         struct pblk *pblk =3D gc_rq_ws->pblk;
> -       struct nvm_tgt_dev *dev =3D pblk->dev;
> -       struct nvm_geo *geo =3D &dev->geo;
>         struct pblk_gc *gc =3D &pblk->gc;
>         struct pblk_line *line =3D gc_rq_ws->line;
>         struct pblk_gc_rq *gc_rq =3D gc_rq_ws->priv;
> @@ -93,13 +91,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
>
>         up(&gc->gc_sem);
>
> -       gc_rq->data =3D vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
> -       if (!gc_rq->data) {
> -               pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
> -                                       line->id, *line->vsc, gc_rq->nr_s=
ecs);
> -               goto out;
> -       }
> -
>         /* Read from GC victim block */
>         ret =3D pblk_submit_read_gc(pblk, gc_rq);
>         if (ret) {
> @@ -189,6 +180,8 @@ static void pblk_gc_line_prepare_ws(struct work_struc=
t *work)
>         struct pblk_line *line =3D line_ws->line;
>         struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>         struct pblk_line_meta *lm =3D &pblk->lm;
> +       struct nvm_tgt_dev *dev =3D pblk->dev;
> +       struct nvm_geo *geo =3D &dev->geo;
>         struct pblk_gc *gc =3D &pblk->gc;
>         struct pblk_line_ws *gc_rq_ws;
>         struct pblk_gc_rq *gc_rq;
> @@ -247,9 +240,13 @@ static void pblk_gc_line_prepare_ws(struct work_stru=
ct *work)
>         gc_rq->nr_secs =3D nr_secs;
>         gc_rq->line =3D line;
>
> +       gc_rq->data =3D vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
> +       if (!gc_rq->data)
> +               goto fail_free_gc_rq;
> +
>         gc_rq_ws =3D kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
>         if (!gc_rq_ws)
> -               goto fail_free_gc_rq;
> +               goto fail_free_gc_data;
>
>         gc_rq_ws->pblk =3D pblk;
>         gc_rq_ws->line =3D line;
> @@ -281,6 +278,8 @@ static void pblk_gc_line_prepare_ws(struct work_struc=
t *work)
>
>         return;
>
> +fail_free_gc_data:
> +       vfree(gc_rq->data);
>  fail_free_gc_rq:
>         kfree(gc_rq);
>  fail_free_lba_list:
> --
> 2.9.5
>
