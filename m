Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467D8C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F49120684
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="PmxStlFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfCFO3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:29:48 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38775 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfCFO3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:29:48 -0500
Received: by mail-vs1-f67.google.com with SMTP id h132so2312256vsd.5
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OVDusR3yfYljr7SU5AGkRm6D+/ALnG2xoyh2wz8IgJY=;
        b=PmxStlFOA/7Ud4WbfqxDHredOARIBZdS9c3+hr28INZcKCvl5+s/326pUG66igrl5Z
         Os8zmtPA09wzC9TeCeeMyHtflqakrSTyXP5WDf/qkz4+QkOqdnoRBuYM0OxmWEntEzaQ
         lZnNKaLmI7tXeqQke95rTpez2Y4zPHh/j+cFtdAf/2DbrKR+Ugx9FcP+1JvcDR4QC4jm
         yLTqLP6QCHdU6HfKzZGgnUA5xVozK/qq9WLPl2062d7iK3kYtUxcVMz7hxvauygz1xV8
         xEINtNfzC8ITd1faF0OcrE1owA50ZdBNuOotzqtYQwZkWOI6YX4kdcMMyQ6T5HbRnBd9
         NsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OVDusR3yfYljr7SU5AGkRm6D+/ALnG2xoyh2wz8IgJY=;
        b=b3VGifQ8pORXOH4hTHGRL5ueh0FF1wJV/u6HlgLVFVEm+zRRuZaDD7Qc5pt9LfUMET
         bMt8mvMrpgF0PjdYjC30uK+oaSfO6yf0VrhnrJszQ/Sv4l6MG0zNuPAkG5cAZ/vuqnFx
         gx0GPWrxY3P3qD8C/6fG7AVoXvun2cH4/to6PiOHTINJQBj82xDAdPSdGqckSDQrffgm
         RyS5BjPrVgmo/JT1CaDMgXdKR8koxEMsKRhkx6fYii0QSOoX8N0VG0J/eABDbanTnCiZ
         M8RINvltuT3GfdRjZSuTdBb98H6o90uildgUPFY723aNKqVGtDZoesTufPgA5fHvXKNB
         AbxQ==
X-Gm-Message-State: APjAAAVLfQ0wDP6rgYXvcXTCy3FBa517z3gIVLXu9hT4vB7ZWhz1mM+a
        uQVMsk4xNpDXoSGSFcC5yr19w5GVrnKNB7pEYbPc/A==
X-Google-Smtp-Source: APXvYqxdvxID13NrH/XA5YQW6RtFZ6PJglgEJinNl6INiicO5Lazo7gjxnE29W68vCzRNOwzf8syfVRDq0JxpZJnpW8=
X-Received: by 2002:a67:f744:: with SMTP id w4mr4133127vso.16.1551882587000;
 Wed, 06 Mar 2019 06:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-9-igor.j.konopko@intel.com> <fbe81dc8-fcf4-57ce-5443-11b44f3478bf@lightnvm.io>
 <9EAC5F97-CFEF-4598-A251-8C5C06F0DC96@javigon.com>
In-Reply-To: <9EAC5F97-CFEF-4598-A251-8C5C06F0DC96@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:29:36 +0100
Message-ID: <CANr-nt0t43K6y44G5VAg+KN2+BQahYoA-yiDT6-Hvgx00QcsFA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] lightnvm: Inherit mdts from the parent nvme device
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me too,

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Wed, Mar 6, 2019 at 8:44 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 5 Mar 2019, at 15.34, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
> >
> > On 3/5/19 2:51 PM, Igor Konopko wrote:
> >> Current lightnvm and pblk implementation does not care about NVMe max
> >> data transfer size, which can be smaller than 64*K=3D256K. There are
> >> existing NVMe controllers which NVMe max data transfer size is lower
> >> that 256K (for example 128K, which happens for existing NVMe
> >> controllers which are NVMe spec compliant). Such a controllers are not
> >> able to handle command which contains 64 PPAs, since the the size of
> >> DMAed buffer will be above the capabilities of such a controller.
> >> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
> >> ---
> >>  drivers/lightnvm/core.c      | 9 +++++++--
> >>  drivers/nvme/host/lightnvm.c | 1 +
> >>  include/linux/lightnvm.h     | 1 +
> >>  3 files changed, 9 insertions(+), 2 deletions(-)
> >> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >> index 5f82036..c01f83b 100644
> >> --- a/drivers/lightnvm/core.c
> >> +++ b/drivers/lightnvm/core.c
> >> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, str=
uct nvm_ioctl_create *create)
> >>      struct nvm_target *t;
> >>      struct nvm_tgt_dev *tgt_dev;
> >>      void *targetdata;
> >> +    unsigned int mdts;
> >>      int ret;
> >>      switch (create->conf.type) {
> >> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, st=
ruct nvm_ioctl_create *create)
> >>      tdisk->private_data =3D targetdata;
> >>      tqueue->queuedata =3D targetdata;
> >>  -   blk_queue_max_hw_sectors(tqueue,
> >> -                    (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> >> +    mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
> >> +    if (dev->geo.mdts) {
> >> +            mdts =3D min_t(u32, dev->geo.mdts,
> >> +                            (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> >> +    }
> >> +    blk_queue_max_hw_sectors(tqueue, mdts);
> >>      set_capacity(tdisk, tt->capacity(targetdata));
> >>      add_disk(tdisk);
> >> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm=
.c
> >> index 949e29e..4f20a10 100644
> >> --- a/drivers/nvme/host/lightnvm.c
> >> +++ b/drivers/nvme/host/lightnvm.c
> >> @@ -977,6 +977,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *di=
sk_name, int node)
> >>      geo->csecs =3D 1 << ns->lba_shift;
> >>      geo->sos =3D ns->ms;
> >>      geo->ext =3D ns->ext;
> >> +    geo->mdts =3D ns->ctrl->max_hw_sectors;
> >>      dev->q =3D q;
> >>      memcpy(dev->name, disk_name, DISK_NAME_LEN);
> >> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> >> index 5d865a5..d3b0270 100644
> >> --- a/include/linux/lightnvm.h
> >> +++ b/include/linux/lightnvm.h
> >> @@ -358,6 +358,7 @@ struct nvm_geo {
> >>      u16     csecs;          /* sector size */
> >>      u16     sos;            /* out-of-band area size */
> >>      bool    ext;            /* metadata in extended data buffer */
> >> +    u32     mdts;           /* Max data transfer size*/
> >>      /* device write constrains */
> >>      u32     ws_min;         /* minimum write size */
> >
> > I think I can pick this up. I'll let Javier/Hans rereview.
> >
> > Given Javier's feedback on broken existing mdts implementations. When
> > they are brought to light, we may want to add in a quirk list to
> > update MDTS accordingly. Javier, will this address the issue you have
> > regarding using mdts?
>
> Sounds good. Thanks for considering this.
>
> Javier
