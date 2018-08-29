Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36332 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbeH2Sso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 14:48:44 -0400
Received: by mail-ua1-f68.google.com with SMTP id c12-v6so3414255uan.3
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 07:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-3-git-send-email-hans.ml.holmberg@owltronix.com> <eb5ca95c-6c4a-71a0-4cf1-634b211b52ce@lightnvm.io>
In-Reply-To: <eb5ca95c-6c4a-71a0-4cf1-634b211b52ce@lightnvm.io>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Wed, 29 Aug 2018 16:51:13 +0200
Message-ID: <CANr-nt2hZku+CwO2eQ4hbu0bCP-=14jRHp2GkR-4N6-Tx_CiLg@mail.gmail.com>
Subject: Re: [PATCH 2/7] lightnvm: pblk: fix mapping issue on failed writes
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 29, 2018 at 3:23 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > On 1.2-devices, the mapping-out of remaning sectors in the
> > failed-write's block can result in an infinite loop,
> > stalling the write pipeline, fix this.
> >
> > Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path"=
)
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >   drivers/lightnvm/pblk-write.c | 45 ++++++++++++++++++++++++++++++++++=
---------
> >   1 file changed, 36 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-writ=
e.c
> > index 1bc879ab679d..fd67325f6e54 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -103,6 +103,41 @@ static void pblk_complete_write(struct pblk *pblk,=
 struct nvm_rq *rqd,
> >       pblk_rb_sync_end(&pblk->rwb, &flags);
> >   }
> >
> > +static int pblk_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *=
ppa)
> > +{
> > +     int done =3D 0;
>
> Could this please be renamed to last to signify it is the last ppa in
> the ppa.

Yes, that would be better.

>
> > +
> > +     if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
> > +             int sec =3D ppa->g.sec;
> > +
> > +             sec++;
> > +             if (sec =3D=3D geo->ws_min) {
> > +                     int pg =3D ppa->g.pg;
> > +
> > +                     sec =3D 0;
> > +                     pg++;
> > +                     if (pg =3D=3D geo->num_pg) {
> > +                             int pl =3D ppa->g.pl;
> > +
> > +                             pg =3D 0;
> > +                             pl++;
> > +                             if (pl =3D=3D geo->num_pln)
> > +                                     done =3D 1;
> > +
> > +                             ppa->g.pl =3D pl;
> > +                     }
> > +                     ppa->g.pg =3D pg;
> > +             }
> > +             ppa->g.sec =3D sec;
> > +     } else {
> > +             ppa->m.sec++;
> > +             if (ppa->m.sec =3D=3D geo->clba)
> > +                     done =3D 1;
> > +     }
> > +
> > +     return done;
> > +}
> > +
>
> Can you please move this function to core? I want to avoid introducing
> more if's around 1.2/2.0 in targets.

That makes sense, i'll post a V2. Thanks for the review.

>
> >   /* Map remaining sectors in chunk, starting from ppa */
> >   static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *pp=
a)
> >   {
> > @@ -125,15 +160,7 @@ static void pblk_map_remaining(struct pblk *pblk, =
struct ppa_addr *ppa)
> >               if (!test_and_set_bit(paddr, line->invalid_bitmap))
> >                       le32_add_cpu(line->vsc, -1);
> >
> > -             if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
> > -                     map_ppa.ppa++;
> > -                     if (map_ppa.g.pg =3D=3D geo->num_pg)
> > -                             done =3D 1;
> > -             } else {
> > -                     map_ppa.m.sec++;
> > -                     if (map_ppa.m.sec =3D=3D geo->clba)
> > -                             done =3D 1;
> > -             }
> > +             done =3D pblk_next_ppa_in_blk(geo, &map_ppa);
> >       }
> >
> >       line->w_err_gc->has_write_err =3D 1;
> >
>
