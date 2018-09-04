Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44745 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeIDPEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Sep 2018 11:04:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id m11-v6so2441297uao.11
        for <linux-block@vger.kernel.org>; Tue, 04 Sep 2018 03:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com> <AE72A23A-F779-466B-89A7-846A232DD9B2@cnexlabs.com>
In-Reply-To: <AE72A23A-F779-466B-89A7-846A232DD9B2@cnexlabs.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 4 Sep 2018 12:39:46 +0200
Message-ID: <CANr-nt3kvXVMSeaEZf3hZo2tR31G+h1B9X300Ew+Ys5QiK02QQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] lightnvm: pblk: add tracing for chunk resets
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 29, 2018 at 10:09 PM Javier Gonzalez <javier@cnexlabs.com> wrote:
>
> > On 29 Aug 2018, at 14.31, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
> >
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Trace state of chunk resets.
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> > drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
> > drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
> > drivers/lightnvm/pblk.h       |  6 ++++++
> > 3 files changed, 49 insertions(+)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> > index 566a5d3165ee..b874001d1175 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
> >       atomic_dec(&line->left_seblks);
> >
> >       if (rqd->error) {
> > +             trace_pblk_chunk_reset(pblk_disk_name(pblk),
> > +                             &rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
> > +
> >               chunk->state = NVM_CHK_ST_OFFLINE;
> >               pblk_mark_bb(pblk, line, rqd->ppa_addr);
> >       } else {
> > +             trace_pblk_chunk_reset(pblk_disk_name(pblk),
> > +                             &rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
> > +
> >               chunk->state = NVM_CHK_ST_FREE;
> >       }
> >
> > @@ -958,6 +964,9 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
> >               WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> >               spin_unlock(&line->lock);
> >
> > +             trace_pblk_chunk_reset(pblk_disk_name(pblk),
> > +                             &ppa, PBLK_CHUNK_RESET_START);
> > +
>
> Can you move this inside of pblk_blk_erase_sync() instead? I was looking
> at the code now to implement a different thing and it is confusing to
> see tracing inside erase_async and not in erase_sync.
>

Fixed in a V2. Thanks.
