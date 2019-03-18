Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2442C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE1E20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="UQ4AjzlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfCRMO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:14:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45085 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfCRMO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:14:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id n14so9249830vsp.12
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziyTZr6jcVoH5yaHGWK8ndiIGUlDm3Wv3hCwrLVKpTg=;
        b=UQ4AjzlIu1FhK4Lt6o0njEce7OvQUfqf7KLDMehNFBYWmvhJU3YyOPjXwxhGoRFv7L
         2zO5Hv/4qq77UJhpNU89jr3bUm58PunX2yaTOVdYzr2/jvm3fuUNFJ44Cc1hrzcZVO+W
         zGcfGDRSr330VAESvJOu2+DSeW/PgdPymVvg238/hzkPfvN068DdiwVO/XE0xmuabGMY
         OR5GLR/bVxJ5X3UhhjbiyXu61ls0Jr2Fu1pvxvDCNV2FZKLOxXJ2/HlS3Pm6MycCT2/c
         5iC/+drP3RRHMNF9iGcYI+Jiy2oqfBCnM5K+aM2WD0Fix6pVeMyGACO5vrtfRWJs9wfR
         Ye6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziyTZr6jcVoH5yaHGWK8ndiIGUlDm3Wv3hCwrLVKpTg=;
        b=SVwBcMmnw73kfs7xMIrzPECPfz+DHDd+hfyilJYzr8Vhh06ssYqOSZszpvkZ3iT1Jj
         O8yc008sJ7FiQjEFnGOkmthW5LkU+8dJKQGGJKjUkH4XudskH504bYjgLdcLf9aQboWe
         B2b9rKqxPquWXdeK9QsjeSgZ4PZ97uExYhm94OuZscg0z+31vSPvP5ox2VZ2oFsSQ1+D
         cKuwaviTcFzvzvv1gcBPQsA0x+3S1kA9gnIdVkYBhS6Czgs5h1iUCRc1mEwwrixR3SkW
         sGaXdxbVfymYswNTLisQCstSRs49qmRJkPwlwW5bdGEerxNF1CULtEqLOkdmKLlB4iRF
         BtCQ==
X-Gm-Message-State: APjAAAVBYYa9RotqTQQh5B3CDva1ugsq7CUOWBlRd+mh6lI/ASM9zuJu
        +BRZbidB/Gz0uwjK3zMMi6BN1iCY6fjrV21cHFfV9A==
X-Google-Smtp-Source: APXvYqxiL+hgZJIM1f2xX49dnfsoInGa4YBsk4PMfja45h6+jRNOAnkmoR9INHTPwJnTaaD/XyngnMN+NJU5Ja2m7yk=
X-Received: by 2002:a67:ea4b:: with SMTP id r11mr8873211vso.184.1552911295991;
 Mon, 18 Mar 2019 05:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com> <20190314160428.3559-15-igor.j.konopko@intel.com>
In-Reply-To: <20190314160428.3559-15-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 13:14:45 +0100
Message-ID: <CANr-nt2XeD=xrvRt5xoiJpzN1SB54KCp5gbOJ-dm9_LRx4Dh3w@mail.gmail.com>
Subject: Re: [PATCH 14/18] lightnvm: pblk: GC error handling
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 5:09 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> Currently when there is an IO error (or similar) on GC read path, pblk
> still moves this line to free state, what leads to data mismatch issue.
>
> This patch adds a handling for such an error - after that changes this
> line will be returned to closed state so it can be still in use
> for reading - at least we will be able to return error status to user
> when user tries to read such a data.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-core.c | 8 ++++++++
>  drivers/lightnvm/pblk-gc.c   | 5 ++---
>  drivers/lightnvm/pblk-read.c | 1 -
>  drivers/lightnvm/pblk.h      | 2 ++
>  4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 4d5cd99..6817f8f 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1786,6 +1786,14 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
>
>         spin_lock(&line->lock);
>         WARN_ON(line->state != PBLK_LINESTATE_GC);
> +       if (line->w_err_gc->has_gc_err) {
> +               spin_unlock(&line->lock);
> +               pblk_err(pblk, "line %d had errors during GC\n", line->id);
> +               pblk_put_line_back(pblk, line);
> +               line->w_err_gc->has_gc_err = 0;

In a real bummer corner case, the line might have had a write error as well
(line->w_err_gc->has_write_err == true)

In that case we need to inform the rate limiter:
pblk_rl_werr_line_out(&pblk->rl);

> +               return;
> +       }
> +
>         line->state = PBLK_LINESTATE_FREE;
>         trace_pblk_line_state(pblk_disk_name(pblk), line->id,
>                                         line->state);
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index e23b192..63ee205 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
>         wake_up_process(gc->gc_writer_ts);
>  }
>
> -static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
>  {
>         struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>         struct list_head *move_list;
> @@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
>         /* Read from GC victim block */
>         ret = pblk_submit_read_gc(pblk, gc_rq);
>         if (ret) {
> -               pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
> -                                                               line->id, ret);
> +               line->w_err_gc->has_gc_err = 1;
>                 goto out;
>         }
>
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 54422a2..6a77c24 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -475,7 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>
>         if (pblk_submit_io_sync(pblk, &rqd)) {
>                 ret = -EIO;
> -               pblk_err(pblk, "GC read request failed\n");
>                 goto err_free_bio;
>         }
>
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 5d1040a..52002f5 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -427,6 +427,7 @@ struct pblk_smeta {
>
>  struct pblk_w_err_gc {
>         int has_write_err;
> +       int has_gc_err;
>         __le64 *lba_list;
>  };
>
> @@ -909,6 +910,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
>  void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
>                               int *gc_active);
>  int pblk_gc_sysfs_force(struct pblk *pblk, int force);
> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
>
>  /*
>   * pblk rate limiter
> --
> 2.9.5
>
