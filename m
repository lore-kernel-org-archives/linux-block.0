Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4DCC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90AC20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="EbIjMbC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCROOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:14:33 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45093 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCROOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:14:33 -0400
Received: by mail-ua1-f67.google.com with SMTP id c13so3261102uao.12
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qVHRGeytEN/wqJVeWdX4BgiePmoH42TcbhJUgnJCsg=;
        b=EbIjMbC5WafEozqqB1ERoc56H098LbBS5fe0zi3qaoEAGS3KAoav3hbCSkKjYe8gDg
         bH4EQEYu5j3DfNU1K5cjMz3E9ZsuGjoGxKrWPazGzglIA1S5ZHwFYNsDgJBuqNq6CFqp
         NaSgly8ZueeBpFaqE6SAL7VjyEsKK0BnTZgvptF+FPIpgaiCo0gU43RSZLY3QmvfCMll
         wOX1RotGmUh/qyIAHn5aDy30t3LqxO95K+j8/EzAdXkQcpTYfHBULBJlsbaKEVAEn6eK
         y6zIuH0Qja27IGGM5ACYTCq9O3Ri2zCekr7A6LYbokHviMuLhkjiYGk8XljYQcV/H5Kk
         +NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qVHRGeytEN/wqJVeWdX4BgiePmoH42TcbhJUgnJCsg=;
        b=svtuSepd71fON8rz4yuQMwo7mfdNwiC4PKPGqEbj101Sn/WkMkI6GP3QeZtSdC8/Hn
         UdqBCSJtBisCrQFZrSsyY7dVZ4TuVH8OGFtEHW8VqNJCirUK4GJmrKj27Lv+tbqh0WkW
         RXLlpnRJb/0JdRusuymhkgg84uupL/uyg5K2nMKO33eGxdQf+XmCQISyAfFOq+sVd/B2
         2TA6uity95vIpN5qw4sXqN5tC7KyV0+n7Oa/GZQf6fSZTBclHDe5md+c0JzkRfOo20iq
         3OTuKftOHuscClQlSP0U8+S2xkJUmakPhuFFt243Xq0+w9qY2VTnozqzqqWWpwQsM8fo
         sLFQ==
X-Gm-Message-State: APjAAAVUIQjF7NyjgIxNW9c/8543fGNIaKl3bS3SYj1/nMi2zNGIcGlo
        8ySmfCxQ2Fp6r+g2/yMbrBRyJh9k3rMhCdhRhX/Wag==
X-Google-Smtp-Source: APXvYqwTMZ42xgWJUhskeb7Adph1FR5NRKdjHzMmM3uPSbfF0Z4vgTnp9AZt1UoX2gHl/OcLizirHvWGuBPtwcJcTkQ=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr885788uap.121.1552918472000;
 Mon, 18 Mar 2019 07:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-15-igor.j.konopko@intel.com> <CANr-nt2XeD=xrvRt5xoiJpzN1SB54KCp5gbOJ-dm9_LRx4Dh3w@mail.gmail.com>
 <c97739cf-df61-f6d4-7735-78e5743d0c1f@intel.com>
In-Reply-To: <c97739cf-df61-f6d4-7735-78e5743d0c1f@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 15:14:21 +0100
Message-ID: <CANr-nt0CRVfWzJBDJD8P6zmC9VRPFDWKs-1Ueem64mN2cNFePA@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 2:22 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
>
>
> On 18.03.2019 13:14, Hans Holmberg wrote:
> > On Thu, Mar 14, 2019 at 5:09 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
> >>
> >> Currently when there is an IO error (or similar) on GC read path, pblk
> >> still moves this line to free state, what leads to data mismatch issue.
> >>
> >> This patch adds a handling for such an error - after that changes this
> >> line will be returned to closed state so it can be still in use
> >> for reading - at least we will be able to return error status to user
> >> when user tries to read such a data.
> >>
> >> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >> ---
> >>   drivers/lightnvm/pblk-core.c | 8 ++++++++
> >>   drivers/lightnvm/pblk-gc.c   | 5 ++---
> >>   drivers/lightnvm/pblk-read.c | 1 -
> >>   drivers/lightnvm/pblk.h      | 2 ++
> >>   4 files changed, 12 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> >> index 4d5cd99..6817f8f 100644
> >> --- a/drivers/lightnvm/pblk-core.c
> >> +++ b/drivers/lightnvm/pblk-core.c
> >> @@ -1786,6 +1786,14 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
> >>
> >>          spin_lock(&line->lock);
> >>          WARN_ON(line->state != PBLK_LINESTATE_GC);
> >> +       if (line->w_err_gc->has_gc_err) {
> >> +               spin_unlock(&line->lock);
> >> +               pblk_err(pblk, "line %d had errors during GC\n", line->id);
> >> +               pblk_put_line_back(pblk, line);
> >> +               line->w_err_gc->has_gc_err = 0;
> >
> > In a real bummer corner case, the line might have had a write error as well
> > (line->w_err_gc->has_write_err == true)
> >
> > In that case we need to inform the rate limiter:
> > pblk_rl_werr_line_out(&pblk->rl);
>
> Is that needed or rather preferred?
>
> I'm not clearing w_err_gc->has_write_err value in that case (and thus
> not informing the rate limiter), so the line will go back to exactly the
> same state as before GC (still with write error marked).

You're right, we will try to gc the line again. Thanks!

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

>
> >
> >> +               return;
> >> +       }
> >> +
> >>          line->state = PBLK_LINESTATE_FREE;
> >>          trace_pblk_line_state(pblk_disk_name(pblk), line->id,
> >>                                          line->state);
> >> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> >> index e23b192..63ee205 100644
> >> --- a/drivers/lightnvm/pblk-gc.c
> >> +++ b/drivers/lightnvm/pblk-gc.c
> >> @@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
> >>          wake_up_process(gc->gc_writer_ts);
> >>   }
> >>
> >> -static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
> >> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
> >>   {
> >>          struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> >>          struct list_head *move_list;
> >> @@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
> >>          /* Read from GC victim block */
> >>          ret = pblk_submit_read_gc(pblk, gc_rq);
> >>          if (ret) {
> >> -               pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
> >> -                                                               line->id, ret);
> >> +               line->w_err_gc->has_gc_err = 1;
> >>                  goto out;
> >>          }
> >>
> >> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> >> index 54422a2..6a77c24 100644
> >> --- a/drivers/lightnvm/pblk-read.c
> >> +++ b/drivers/lightnvm/pblk-read.c
> >> @@ -475,7 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
> >>
> >>          if (pblk_submit_io_sync(pblk, &rqd)) {
> >>                  ret = -EIO;
> >> -               pblk_err(pblk, "GC read request failed\n");
> >>                  goto err_free_bio;
> >>          }
> >>
> >> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> >> index 5d1040a..52002f5 100644
> >> --- a/drivers/lightnvm/pblk.h
> >> +++ b/drivers/lightnvm/pblk.h
> >> @@ -427,6 +427,7 @@ struct pblk_smeta {
> >>
> >>   struct pblk_w_err_gc {
> >>          int has_write_err;
> >> +       int has_gc_err;
> >>          __le64 *lba_list;
> >>   };
> >>
> >> @@ -909,6 +910,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
> >>   void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
> >>                                int *gc_active);
> >>   int pblk_gc_sysfs_force(struct pblk *pblk, int force);
> >> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
> >>
> >>   /*
> >>    * pblk rate limiter
> >> --
> >> 2.9.5
> >>
