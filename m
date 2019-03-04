Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA9BC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39E820830
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="JqprZE5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCDNQg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:16:36 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40505 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfCDNQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:16:35 -0500
Received: by mail-ua1-f68.google.com with SMTP id c5so4322124uaq.7
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=icnReoU/MUokDWjCmTP7Nnh6R6c7YrlVUiJKMPp8VGI=;
        b=JqprZE5wLWf4ry14QOHvrOceP3/UgD4Ud7142o8GXF7PDpF6dRPLRJ+0j5F0NXWgS/
         7Jq0egS24fW9dra2FXnGLPEouvr6cUeadIlC+NDSyzshMx7pRBQdj0kCzMhxGJ8jmkze
         wrINFA4tkvZlpxANhe4UGh6XSvamAK9eakml9Pdn8a2ecPpY1I+u2MlRjCq1K+9Lbkra
         jmJEbRExgkBQMbPyF0wYNsWeFf3BV615Uesgs/MpjPNqhrLjXFWrdvp8Y12JzD8hi9qe
         WY569jEhCZguzkAhhL0WcOCKuWEhAoW5D70ghFqUFn2k1oCBcOLTb8eqpmBDzxBRr6hT
         oMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=icnReoU/MUokDWjCmTP7Nnh6R6c7YrlVUiJKMPp8VGI=;
        b=Pz7XdqJhVI/XSqQ1zFerNsjeBEoc9l4PPKgYstlVZMUw10mtl2jHWkmuZxB0kG+7Lm
         4yCauenDhdzz25SYm15dyM9ywFxWhnkxOGhYhW57G4XCio0HTnun8p7rlJqLP9cDPnFg
         72Ybavq2/0COHxypydUXLZWMeRPcteadg4jNaCyQkPeDASTMh0/ezpSXYIafDYuhl5FD
         YnUQf8pDN0Gw0nz1SlNfHjYDaVGMTCTWTUmqR8k7aHk902Wml2lsn+yPbATs2+HxHQXn
         zykNwDqxl8QWbXBuxCcVBW7TcZt3MD9IVu7DlouYE6C/n35GJMluLKobt+JdeheMi8G/
         KmIA==
X-Gm-Message-State: APjAAAX1Ggb/4g2mBL7wW5Pz6PTF8RrRZnsR3q1nDbQoDIex4u/6Iy5L
        MAuD8gKENdxgGOmKfgStQHdGNR6OdzyTjztxNNejaA==
X-Google-Smtp-Source: APXvYqwBgGcJ0kTX9ZwJRy62MBNvhbXuxnQRuChgOJHb2Z6andTYAsjaTnazdmiY/ysGG0K5AE+bEfccQsCK421zA1A=
X-Received: by 2002:a67:bb16:: with SMTP id m22mr9650902vsn.153.1551705394134;
 Mon, 04 Mar 2019 05:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com> <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
 <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
 <54D42A19-96EE-4370-B957-A474BB912530@javigon.com> <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
 <3d053281-ef87-66e3-3433-de4c18884326@intel.com>
In-Reply-To: <3d053281-ef87-66e3-3433-de4c18884326@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 14:16:23 +0100
Message-ID: <CANr-nt1JjwoKqiZivj_MH+9m_5-r5jsN0Lr5DpUGwKMiZ6q9QA@mail.gmail.com>
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Simon Andreas Frimann Lund <slund@cnexlabs.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 2:04 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 04.03.2019 13:22, Hans Holmberg wrote:
> > On Mon, Mar 4, 2019 at 12:44 PM Javier Gonz=C3=A1lez <javier@javigon.co=
m> wrote:
> >>
> >>
> >>
> >>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
> >>>
> >>> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez <javier@javigon.=
com> wrote:
> >>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> w=
rote:
> >>>>>
> >>>>> Current lightnvm and pblk implementation does not care
> >>>>> about NVMe max data transfer size, which can be smaller
> >>>>> than 64*K=3D256K. This patch fixes issues related to that.
> >>>
> >>> Could you describe *what* issues you are fixing?
>
> I'm fixing the issue related to controllers which NVMe max data transfer
> size is lower that 256K (for example 128K, which happens for existing
> NVMe controllers and NVMe spec compliant). Such a controllers are not
> able to handle command which contains 64 PPAs, since the the size of
> DMAed buffer will be above the capabilities of such a controller.

Thanks for the explanation, that would be great to have in the commit messa=
ge.

>
> >>>
> >>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>>> ---
> >>>>> drivers/lightnvm/core.c      | 9 +++++++--
> >>>>> drivers/nvme/host/lightnvm.c | 1 +
> >>>>> include/linux/lightnvm.h     | 1 +
> >>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >>>>> index 5f82036fe322..c01f83b8fbaf 100644
> >>>>> --- a/drivers/lightnvm/core.c
> >>>>> +++ b/drivers/lightnvm/core.c
> >>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
> >>>>>       struct nvm_target *t;
> >>>>>       struct nvm_tgt_dev *tgt_dev;
> >>>>>       void *targetdata;
> >>>>> +     unsigned int mdts;
> >>>>>       int ret;
> >>>>>
> >>>>>       switch (create->conf.type) {
> >>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev,=
 struct nvm_ioctl_create *create)
> >>>>>       tdisk->private_data =3D targetdata;
> >>>>>       tqueue->queuedata =3D targetdata;
> >>>>>
> >>>>> -     blk_queue_max_hw_sectors(tqueue,
> >>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> >>>>> +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
> >>>>> +     if (dev->geo.mdts) {
> >>>>> +             mdts =3D min_t(u32, dev->geo.mdts,
> >>>>> +                             (dev->geo.csecs >> 9) * NVM_MAX_VLBA)=
;
> >>>>> +     }
> >>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
> >>>>>
> >>>>>       set_capacity(tdisk, tt->capacity(targetdata));
> >>>>>       add_disk(tdisk);
> >>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/light=
nvm.c
> >>>>> index b759c25c89c8..b88a39a3cbd1 100644
> >>>>> --- a/drivers/nvme/host/lightnvm.c
> >>>>> +++ b/drivers/nvme/host/lightnvm.c
> >>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
> >>>>>       geo->csecs =3D 1 << ns->lba_shift;
> >>>>>       geo->sos =3D ns->ms;
> >>>>>       geo->ext =3D ns->ext;
> >>>>> +     geo->mdts =3D ns->ctrl->max_hw_sectors;
> >>>>>
> >>>>>       dev->q =3D q;
> >>>>>       memcpy(dev->name, disk_name, DISK_NAME_LEN);
> >>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> >>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
> >>>>> --- a/include/linux/lightnvm.h
> >>>>> +++ b/include/linux/lightnvm.h
> >>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
> >>>>>       u16     csecs;          /* sector size */
> >>>>>       u16     sos;            /* out-of-band area size */
> >>>>>       bool    ext;            /* metadata in extended data buffer *=
/
> >>>>> +     u32     mdts;           /* Max data transfer size*/
> >>>>>
> >>>>>       /* device write constrains */
> >>>>>       u32     ws_min;         /* minimum write size */
> >>>>> --
> >>>>> 2.17.1
> >>>>
> >>>> I see where you are going with this and I partially agree, but none =
of
> >>>> the OCSSD specs define a way to define this parameter. Thus, adding =
this
> >>>> behavior taken from NVMe in Linux can break current implementations.=
 Is
> >>>> this a real life problem for you? Or this is just for NVMe =E2=80=9C=
correctness=E2=80=9D?
> >>>>
> >>>> Javier
> >>>
> >>> Hmm.Looking into the 2.0 spec what it says about vector reads:
> >>>
> >>> (figure 28):"The number of Logical Blocks (NLB): This field indicates
> >>> the number of logical blocks to be read. This is a 0=E2=80=99s based =
value.
> >>> Maximum of 64 LBAs is supported."
> >>>
> >>> You got the max limit covered, and the spec  does not say anything
> >>> about the minimum number of LBAs to support.
> >>>
> >>> Matias: any thoughts on this?
> >>>
> >>> Javier: How would this patch break current implementations?
> >>
> >> Say an OCSSD controller that sets mdts to a value under 64 or does not
> >> set it at all (maybe garbage). Think you can get to one pretty quickly=
...
> >
> > So we cant make use of a perfectly good, standardized, parameter
> > because some hypothetical non-compliant device out there might not
> > provide a sane value?
> >
> >>
> >>>
> >>> Igor: how does this patch fix the mdts restriction? There are no
> >>> checks on i.e. the gc read path that ensures that a lower limit than
> >>> NVM_MAX_VLBA is enforced.
> >>
> >> This is the other part where the implementation breaks.
> >
> > No, it just does not fix it.
> >
> > over-and-out,
> > Hans
>
> IO requests issued from both garbage collector and writer thread are
> upper limiter by pblk->max_write_pgs variable. This variable is
> calculated based on queue_max_hw_sectors() already in pblk.
>
> User reads on the other hand are splitted by block layer based on
> queue_max_hw_sectors() too.

Mea culpa, right you are!

>
> Is there any other path which I'm missing, which will still tries to
> issue IOs with higher IO size? Or am I missing sth else in my logic?

I missed the adjustments of max_write_pgs in pblk_core_init. We should be g=
ood.

Thanks,
Hans
