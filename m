Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43717 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbeKFVR1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 16:17:27 -0500
Received: by mail-vk1-f194.google.com with SMTP id o130so317734vke.10
        for <linux-block@vger.kernel.org>; Tue, 06 Nov 2018 03:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
 <20181105122610.1555-2-hans.ml.holmberg@owltronix.com> <de7235bc-e458-381d-442e-11b42dd20dc9@gydle.com>
In-Reply-To: <de7235bc-e458-381d-442e-11b42dd20dc9@gydle.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Tue, 6 Nov 2018 12:52:25 +0100
Message-ID: <CANr-nt1Juq4OX3H+c2B4F4xRYO=HZxu_Sx+_d+0eOi4Y5gqGTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lightnvm: pblk: fix resubmission of overwritten
 write err lbas
To: sboisvert@gydle.com
Cc: Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 5, 2018 at 4:12 PM Sebastien Boisvert <sboisvert@gydle.com> wrote:
>
>
>
> On 2018-11-05 7:26 a.m., Hans Holmberg wrote:
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Make sure we only look up valid lba addresses on the resubmission path.
> >
> > If an lba is invalidated in the write buffer, that sector will be
> > submitted to disk(as it is already mapped to a ppa), and that write
>
> submitted to disk(as it is already mapped to a ppa), and that write
>                  ^
>                  add a space
>
> > might fail, resulting in a crash when trying to look up the lba in the
> > mapping table (as the lba is marked as invalid).
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >  drivers/lightnvm/pblk-write.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> > index fa8726493b39..3ddd16f47106 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -148,9 +148,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
> >               w_ctx = &entry->w_ctx;
> >
> >               /* Check if the lba has been overwritten */
> > -             ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
> > -             if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> > -                     w_ctx->lba = ADDR_EMPTY;
> > +             if (w_ctx->lba != ADDR_EMPTY) {
> > +                     ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
> > +                     if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> > +                             w_ctx->lba = ADDR_EMPTY;
> > +             }
>
> Was w_ctx->lba set to ADDR_EMPTY in the same kernel I/O thread ?
>
> I wonder if w_ctx->lba could become ADDR_EMPTY after
>
>                 if (w_ctx->lba != ADDR_EMPTY) {
>
> but before
>
>                         ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);

It can't, the lba adress can only be changed on the write error
handling path, and we'll have to resubmit the write before that can
happen.
Thanks for the review.

/ Hans
>
>
> >
> >               /* Mark up the entry as submittable again */
> >               flags = READ_ONCE(w_ctx->flags);
> >
