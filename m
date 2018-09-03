Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35132 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeICMQB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Sep 2018 08:16:01 -0400
Received: by mail-ua1-f67.google.com with SMTP id m26-v6so12487159uap.2
        for <linux-block@vger.kernel.org>; Mon, 03 Sep 2018 00:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com> <70ce6061-61f0-9a14-7b70-59d0ad2bfa43@lightnvm.io>
In-Reply-To: <70ce6061-61f0-9a14-7b70-59d0ad2bfa43@lightnvm.io>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Mon, 3 Sep 2018 09:56:51 +0200
Message-ID: <CANr-nt2cv7Ja=4zwp_kwyYsgeLWy=mR8gMEYz=FNOJ0pffQ-Gw@mail.gmail.com>
Subject: Re: [PATCH V2] lightnvm: pblk: fix mapping issue on failed writes
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 31, 2018 at 4:18 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 08/31/2018 11:59 AM, Hans Holmberg wrote:
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
> >
> > Changes in V2:
> >       Moved the helper function pblk_next_ppa_in_blk to lightnvm core
> >       Renamed variable done->last in the helper function
> >
> >
> >   drivers/lightnvm/pblk-write.c | 10 +---------
> >   include/linux/lightnvm.h      | 34 ++++++++++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-writ=
e.c
> > index 5e6df65d392c..922506d2d0a6 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -125,15 +125,7 @@ static void pblk_map_remaining(struct pblk *pblk, =
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
> > +             done =3D nvm_next_ppa_in_blk(geo, &map_ppa);
> >       }
> >
> >       line->w_err_gc->has_write_err =3D 1;
> > diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> > index 09f65c6c6676..2a6cbfe1d1b4 100644
> > --- a/include/linux/lightnvm.h
> > +++ b/include/linux/lightnvm.h
> > @@ -593,6 +593,40 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_de=
v *dev,
> >       return ppa32;
> >   }
> >
> > +static inline int nvm_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_=
addr *ppa)
>
> You can pass nvm_tgt_dev here. Then the two unfoldings in
> pblk_map_remaining are not needed.

Yeah. thats better. fixed.

>
> The naming sounds very 1.2ish, how about nvm_get_next_lba_in_chk?

I used blk because in the generic ppa format (ppa_addr.a), the name is blk.
Chunk is more abstract concept so i think it's better using that going forw=
ard.
Fixed.

>
> > +{
> > +     int last =3D 0;
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
> > +                                     last =3D 1;
> > +
> > +                             ppa->g.pl =3D pl;
> > +                     }
> > +                     ppa->g.pg =3D pg;
> > +             }
> > +             ppa->g.sec =3D sec;
> > +     } else {
> > +             ppa->m.sec++;
> > +             if (ppa->m.sec =3D=3D geo->clba)
> > +                     last =3D 1;
> > +     }
> > +
> > +     return last;
> > +}
> >
> >   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct =
bio *);
> >   typedef sector_t (nvm_tgt_capacity_fn)(void *);
> >
>
