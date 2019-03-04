Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC77C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569A8205C9
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="BHDeEfDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDLbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:31:06 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34142 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLbG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 06:31:06 -0500
Received: by mail-ua1-f67.google.com with SMTP id a42so4078694uad.1
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ppWK8TxtXqBStk3U+l5H/LR8hcY9UQ1uQwew6YMMlS0=;
        b=BHDeEfDnOXQxbKUkMraS7argx5SLG1wAOP+RrU2EDnZFvFOYncVF0YFkzjXg3Yd968
         +Gb38fb0LMwvN0dXW3HbxHli5qQFLFNKnNWmmCWmMP7jEFFAh5tDSgrYqEappnaDTEHV
         BFDwyK3IBktDz6B7k6VrNwGXyZDnVmsy2I212Xa7/5bh+mU0Q0tZ4vvOKD2+SWYuJuY1
         lYgyuAHtZvBGbwHetEtcU8rpoo7QTmXYReY6GzuqUXkpZwwsrCRXXwT8KgXo6qzYP+K8
         PbJ9ms1JjQpfGDqd2zOqHLS0IvYnqMVm0dVCy1RfV7ndicr1F8o9aQcl43a/yfmi/tm+
         wU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ppWK8TxtXqBStk3U+l5H/LR8hcY9UQ1uQwew6YMMlS0=;
        b=jpq1ASBiiX9XHs2Cffdnvk8uuHlIsb2zUivuFF0co5ZHI8ndP7RMzjt0wmBsIuv/eR
         MaDyKbLah3OmYJ0BbcYcckWEjzz+DLqg3Pe+9fD0Mj6w6TiiVKj1z2gtVjBmEMaotAdx
         d5kqT7s9l+R2ySUoIrYUnR6RnOJmiHFk5zTffYTX8DB6kcIAHWYxEtcw+j40AHU7U15i
         dpkAdA+lAhf8Xqagh4jVSeDQXEw2Unj1r9scg/meXrBqvMOyOtcaVkvR8m+Lv84NUUou
         RsBuGqu9TBSFB5g6bmIq06G4w6qXjg6ffxpxI/qRydwNNcQQCY+lcCqKETLWFZ4TFAFO
         O0LA==
X-Gm-Message-State: APjAAAXxTcRCuvdP875hmDa5bJcVT9IIcgwrV9hCqki67N5qmgSdeJ6O
        aFqSWhWBMeX+Cs/VfcQCCKEij7b9E4A+p5kCfMqDGWXSdSNbRg==
X-Google-Smtp-Source: APXvYqyn5NCk2ONsPBqt5Gc218uAF3Tkgvlb2nlsaKlxMIAtHa2sRG3C+iddULW/Z4xzsXCZSbOsYkjOKYHU4i9q7J0=
X-Received: by 2002:ab0:e03:: with SMTP id g3mr9232241uak.68.1551699065010;
 Mon, 04 Mar 2019 03:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com> <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
In-Reply-To: <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 12:30:54 +0100
Message-ID: <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Matias Bjorling <mb@lightnvm.io>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, Simon Lund <slund@cnexlabs.com>,
        Klaus Jensen <klaus.jensen@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Current lightnvm and pblk implementation does not care
> > about NVMe max data transfer size, which can be smaller
> > than 64*K=3D256K. This patch fixes issues related to that.

Could you describe *what* issues you are fixing?

> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/core.c      | 9 +++++++--
> > drivers/nvme/host/lightnvm.c | 1 +
> > include/linux/lightnvm.h     | 1 +
> > 3 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> > index 5f82036fe322..c01f83b8fbaf 100644
> > --- a/drivers/lightnvm/core.c
> > +++ b/drivers/lightnvm/core.c
> > @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, stru=
ct nvm_ioctl_create *create)
> >       struct nvm_target *t;
> >       struct nvm_tgt_dev *tgt_dev;
> >       void *targetdata;
> > +     unsigned int mdts;
> >       int ret;
> >
> >       switch (create->conf.type) {
> > @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, str=
uct nvm_ioctl_create *create)
> >       tdisk->private_data =3D targetdata;
> >       tqueue->queuedata =3D targetdata;
> >
> > -     blk_queue_max_hw_sectors(tqueue,
> > -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> > +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
> > +     if (dev->geo.mdts) {
> > +             mdts =3D min_t(u32, dev->geo.mdts,
> > +                             (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> > +     }
> > +     blk_queue_max_hw_sectors(tqueue, mdts);
> >
> >       set_capacity(tdisk, tt->capacity(targetdata));
> >       add_disk(tdisk);
> > diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.=
c
> > index b759c25c89c8..b88a39a3cbd1 100644
> > --- a/drivers/nvme/host/lightnvm.c
> > +++ b/drivers/nvme/host/lightnvm.c
> > @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *dis=
k_name, int node)
> >       geo->csecs =3D 1 << ns->lba_shift;
> >       geo->sos =3D ns->ms;
> >       geo->ext =3D ns->ext;
> > +     geo->mdts =3D ns->ctrl->max_hw_sectors;
> >
> >       dev->q =3D q;
> >       memcpy(dev->name, disk_name, DISK_NAME_LEN);
> > diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> > index 5d865a5d5cdc..d3b02708e5f0 100644
> > --- a/include/linux/lightnvm.h
> > +++ b/include/linux/lightnvm.h
> > @@ -358,6 +358,7 @@ struct nvm_geo {
> >       u16     csecs;          /* sector size */
> >       u16     sos;            /* out-of-band area size */
> >       bool    ext;            /* metadata in extended data buffer */
> > +     u32     mdts;           /* Max data transfer size*/
> >
> >       /* device write constrains */
> >       u32     ws_min;         /* minimum write size */
> > --
> > 2.17.1
>
> I see where you are going with this and I partially agree, but none of
> the OCSSD specs define a way to define this parameter. Thus, adding this
> behavior taken from NVMe in Linux can break current implementations. Is
> this a real life problem for you? Or this is just for NVMe =E2=80=9Ccorre=
ctness=E2=80=9D?
>
> Javier

Hmm.Looking into the 2.0 spec what it says about vector reads:

(figure 28):"The number of Logical Blocks (NLB): This field indicates
the number of logical blocks to be read. This is a 0=E2=80=99s based value.
Maximum of 64 LBAs is supported."

You got the max limit covered, and the spec  does not say anything
about the minimum number of LBAs to support.

Matias: any thoughts on this?

Javier: How would this patch break current implementations?

Igor: how does this patch fix the mdts restriction? There are no
checks on i.e. the gc read path that ensures that a lower limit than
NVM_MAX_VLBA is enforced.

Thanks,
Hans
