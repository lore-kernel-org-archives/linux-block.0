Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5EC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF84D206BA
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="aXv7kpeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCDOZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:25:05 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46501 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfCDOZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 09:25:05 -0500
Received: by mail-ua1-f68.google.com with SMTP id j8so4501878uae.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bAdRlG1l9QpXXgg9ZDs3aKt4yzS9E3RiK2soTV5kuA0=;
        b=aXv7kpeK1+sj6nt2nI/rpbI0UDoGoinIt+Ix6Qt1NDjtH2Tk34XlKBF9HGAySrwXat
         ST2tnGT5lNHSYmuY7Ew63E6SA4L3xUB2IgBCL4oQBOPizZjG8zCq1MkHmL1WwspNTdp2
         OhK2wZtSYQJ1fXES8efDNWTnbvKhT6a3N4UgDmID+VivxnSBDWYQtb413lGWGkj9XZRg
         WsYYMbH2dM1b6EeE2fFllBXzSQ7NsTXWW0OJIi3uegvCN3UuyLBYcZ5/p+G/hSp7J86K
         PT0bRLHO9RELt08Meabi6jqQFWzaoX0qbCbnvS9xQ4EzR1v8i1S11U8QFaQtFHj+gcrV
         9yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bAdRlG1l9QpXXgg9ZDs3aKt4yzS9E3RiK2soTV5kuA0=;
        b=V9ZIdDr5vA92fHG5or7yx2BUpWE5C8p/1LaBeFLQaDrO9jSlOGxDmWzi4d7sJtaoUe
         q7X+I+UN30HInaxLdCVdOhIn5vCC1nvlYkf7vHtECUkVpP45uIX1KMB+sQqwHROYSMpL
         3TKCJVWDSFiEesDgTzXaEAj4jIloPi99qOULS+28N4+7JOImKF222zc5DfIPuOrZZ4JH
         OL4p3OytDvoaCCCKBvkPV9VuwXksuD+zj2eyhc4R7rxxGGaaqIb4NECoNkc7U2sh1i+P
         J7CJORFkilymnUE1RJGt/KJmTLPIrJU+mfAE0AuEeMivrfTBJqJRaYI1uHk8ME4xL/dx
         62vg==
X-Gm-Message-State: APjAAAXdSqMg5F6zY8UWiI/ZYDJg8wk+IEZQ5970nNcJRZYN3JmYWNto
        rhJei2EqIniJvLYslX71wulsT0PWf3LxRpfirWexOA==
X-Google-Smtp-Source: APXvYqxB55PM9vntITYYvXnsK00L7jnjyzGjVqyi+BBDJ4QUyY2SBr91TOYmBIqgPCR4Dzg2IBBBkxdjyxiKJ1w+Lcg=
X-Received: by 2002:a67:bb16:: with SMTP id m22mr9801406vsn.153.1551709503497;
 Mon, 04 Mar 2019 06:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com> <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
 <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
 <54D42A19-96EE-4370-B957-A474BB912530@javigon.com> <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
 <CDD16047-68EF-43EA-A33B-11279A4301E6@javigon.com> <c6fbb977-bfde-d76d-cc4f-198a732d38d0@lightnvm.io>
 <EA36DDD6-5A3D-4F5C-9B18-53E266EB676F@javigon.com>
In-Reply-To: <EA36DDD6-5A3D-4F5C-9B18-53E266EB676F@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 15:24:51 +0100
Message-ID: <CANr-nt2TYvJyL-fcELt3SCMkZjV8jkmye27wtThjrPRaTJiXiQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
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

On Mon, Mar 4, 2019 at 2:44 PM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
>
> > On 4 Mar 2019, at 14.25, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
> >
> > On 3/4/19 2:19 PM, Javier Gonz=C3=A1lez wrote:
> >>> On 4 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
> >>>
> >>> On Mon, Mar 4, 2019 at 12:44 PM Javier Gonz=C3=A1lez <javier@javigon.=
com> wrote:
> >>>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
> >>>>>
> >>>>> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez <javier@javigo=
n.com> wrote:
> >>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com>=
 wrote:
> >>>>>>>
> >>>>>>> Current lightnvm and pblk implementation does not care
> >>>>>>> about NVMe max data transfer size, which can be smaller
> >>>>>>> than 64*K=3D256K. This patch fixes issues related to that.
> >>>>>
> >>>>> Could you describe *what* issues you are fixing?
> >>>>>
> >>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>>>>> ---
> >>>>>>> drivers/lightnvm/core.c      | 9 +++++++--
> >>>>>>> drivers/nvme/host/lightnvm.c | 1 +
> >>>>>>> include/linux/lightnvm.h     | 1 +
> >>>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >>>>>>> index 5f82036fe322..c01f83b8fbaf 100644
> >>>>>>> --- a/drivers/lightnvm/core.c
> >>>>>>> +++ b/drivers/lightnvm/core.c
> >>>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev=
, struct nvm_ioctl_create *create)
> >>>>>>>     struct nvm_target *t;
> >>>>>>>     struct nvm_tgt_dev *tgt_dev;
> >>>>>>>     void *targetdata;
> >>>>>>> +     unsigned int mdts;
> >>>>>>>     int ret;
> >>>>>>>
> >>>>>>>     switch (create->conf.type) {
> >>>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *de=
v, struct nvm_ioctl_create *create)
> >>>>>>>     tdisk->private_data =3D targetdata;
> >>>>>>>     tqueue->queuedata =3D targetdata;
> >>>>>>>
> >>>>>>> -     blk_queue_max_hw_sectors(tqueue,
> >>>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> >>>>>>> +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
> >>>>>>> +     if (dev->geo.mdts) {
> >>>>>>> +             mdts =3D min_t(u32, dev->geo.mdts,
> >>>>>>> +                             (dev->geo.csecs >> 9) * NVM_MAX_VLB=
A);
> >>>>>>> +     }
> >>>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
> >>>>>>>
> >>>>>>>     set_capacity(tdisk, tt->capacity(targetdata));
> >>>>>>>     add_disk(tdisk);
> >>>>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lig=
htnvm.c
> >>>>>>> index b759c25c89c8..b88a39a3cbd1 100644
> >>>>>>> --- a/drivers/nvme/host/lightnvm.c
> >>>>>>> +++ b/drivers/nvme/host/lightnvm.c
> >>>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, cha=
r *disk_name, int node)
> >>>>>>>     geo->csecs =3D 1 << ns->lba_shift;
> >>>>>>>     geo->sos =3D ns->ms;
> >>>>>>>     geo->ext =3D ns->ext;
> >>>>>>> +     geo->mdts =3D ns->ctrl->max_hw_sectors;
> >>>>>>>
> >>>>>>>     dev->q =3D q;
> >>>>>>>     memcpy(dev->name, disk_name, DISK_NAME_LEN);
> >>>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> >>>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
> >>>>>>> --- a/include/linux/lightnvm.h
> >>>>>>> +++ b/include/linux/lightnvm.h
> >>>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
> >>>>>>>     u16     csecs;          /* sector size */
> >>>>>>>     u16     sos;            /* out-of-band area size */
> >>>>>>>     bool    ext;            /* metadata in extended data buffer *=
/
> >>>>>>> +     u32     mdts;           /* Max data transfer size*/
> >>>>>>>
> >>>>>>>     /* device write constrains */
> >>>>>>>     u32     ws_min;         /* minimum write size */
> >>>>>>> --
> >>>>>>> 2.17.1
> >>>>>>
> >>>>>> I see where you are going with this and I partially agree, but non=
e of
> >>>>>> the OCSSD specs define a way to define this parameter. Thus, addin=
g this
> >>>>>> behavior taken from NVMe in Linux can break current implementation=
s. Is
> >>>>>> this a real life problem for you? Or this is just for NVMe =E2=80=
=9Ccorrectness=E2=80=9D?
> >>>>>>
> >>>>>> Javier
> >>>>>
> >>>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
> >>>>>
> >>>>> (figure 28):"The number of Logical Blocks (NLB): This field indicat=
es
> >>>>> the number of logical blocks to be read. This is a 0=E2=80=99s base=
d value.
> >>>>> Maximum of 64 LBAs is supported."
> >>>>>
> >>>>> You got the max limit covered, and the spec  does not say anything
> >>>>> about the minimum number of LBAs to support.
> >>>>>
> >>>>> Matias: any thoughts on this?
> >>>>>
> >>>>> Javier: How would this patch break current implementations?
> >>>>
> >>>> Say an OCSSD controller that sets mdts to a value under 64 or does n=
ot
> >>>> set it at all (maybe garbage). Think you can get to one pretty quick=
ly...
> >>>
> >>> So we cant make use of a perfectly good, standardized, parameter
> >>> because some hypothetical non-compliant device out there might not
> >>> provide a sane value?
> >> The OCSSD standard has never used NVMe parameters, so there is no
> >> compliant / non-compliant. In fact, until we changed OCSSD 2.0 to
> >> get the sector and OOB sizes from the standard identify
> >> command, we used to have them in the geometry.
> >
> > What the hell? Yes it has. The whole OCSSD spec is dependent on the
> > NVMe spec. It is using many commands from the NVMe specification,
> > which is not defined in the OCSSD specification.
> >
>
> First, lower the tone.
>
> Second, no, it has not and never has, starting with all the write
> constrains, continuing with the vector commands, etc. You cannot choose
> what you want to be compliant with and what you do not. OCSSD uses the
> NVMe protocol but it is self sufficient with its geometry for all the
> read / write / erase paths - it even depends on different PCIe class
> codes to be identified=E2=80=A6 To do this in the way the rest of the spe=
c is
> defined, we either add a filed to the geometry or explicitly mention
> that MDTS is used, as we do with the sector and metadata sizes.
>
> Third, as a maintainer of this subsystem you should care about devices
> in the field that might break due to such a change (supported by the
> company you work for or not) - even if you can argue whether the change
> is compliant or not.
>
> And Hans, as a representative of a company that has such devices out
> there, you should care too.

If you worry about me doing my job, you need not to.
I test. So far I have not found any regressions in this patchset.

Please keep your open source hat on Javier.

>
> What if we add a quirk in the feature bits for this so that newer
> devices can implement this and older devices can still function?
>
> > The MDTS field should be respected in all case, similarly to how the
> > block layer respects it. Since the lightnvm subsystem are hooking in
> > on the side, this also be honoured by pblk (or the lightnvm subsystem
> > should fix it up)
> >
>
> This said, pblk does not care which value you give, it uses what the
> subsystem tells it - this is not arguing for this change not to be
> implemented.
>
> The only thing we should care about if implementing this is removing the
> constant defining 64 ppas and making allocations dynamic in the partial
> read and GC paths.
>
> Javier
