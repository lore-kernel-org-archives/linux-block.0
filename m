Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090EBC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 08:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA19B206DD
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 08:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="EbJ1Clgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCEIVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:21:08 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39734 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEIVI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 03:21:08 -0500
Received: by mail-ua1-f68.google.com with SMTP id s15so6982014uap.6
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 00:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jDlGBOMDn/iu/olvAZLkNvTwpxsFjha+f/nPPDGInV4=;
        b=EbJ1ClgxC669BjSFiXrT2wI0qL4hnzM3qvXPsGN63N51gwF5xaewcui2F/3q/AN3JW
         wCtT7eqLPpVne8tiG/lHH5TQupIppmhGJCVOINPPsOOrTuSUqQznyMMe4Knzkn/Ax9lL
         eIH6KXqs97vs7+BOoeMzlQ/3S02oWEe2TsC42VUXEjR4dM0wMPKn78xUX71/TNcCAOOl
         DqT6Pp6cNcZVormKrCcNzCSxchwtnqjAlyt68FgxEQ2ogfQxbVq8q+wwsRjQQypsaMwt
         yKndnUKnfJT6gkeT6/Pu7OxeZrjbiCywV0pHap8moHPeDUHzjHrPhFNm2FMNtSFZ3KaV
         Gc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jDlGBOMDn/iu/olvAZLkNvTwpxsFjha+f/nPPDGInV4=;
        b=pfWnLxJDzxPoqpv6vRqOh9aebW47Dcm06M/Let1bF1Nf1B4u7tYVvpar7QY5aJ1Pea
         XMpLYEAyYmKQfaGgNr0uw5GXCovbG8M38rEM4HwMz0BOBylgG7kYj/bMNsvtKq9o5ops
         I9/Q78/UpPNQdZRRvL/KL3N1rmuumEOH2+O5NdkryrPOwNPYpnXOlV4DCmh1GyrP/rlq
         0j5GCrYgquupwg09ZZEPdIeXRiLZkJ2224SD8QgEWyZ5pIpUsaxRwMz1xXl8Gw6/tPL0
         x1kG3PFritvwa2qyuPY6ij2TWS2zeH3Sf0C3CkePPuVzEQAZUpGy0qgmkP1WRPfgPufq
         RXAQ==
X-Gm-Message-State: APjAAAVBurirGR6X6lbXfwbHETtR6S3Nr0wn01Txx7EA8iR9OuGhcYMD
        lBQkriSLODYe6oOjfocU/O8pinnIQtYk3XUkxyojdg==
X-Google-Smtp-Source: APXvYqwKMKgmvyvxAIFfeqqq+tJFoO3GOwp/8Z/RrcgMRsBEHOBDwk8Kv1t2JhgcQtLR7xUxq0qKVRD2oWOh7X0FNII=
X-Received: by 2002:ab0:e03:: with SMTP id g3mr574416uak.68.1551774067134;
 Tue, 05 Mar 2019 00:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com> <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
 <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com> <CANr-nt30zr_5sMEAK4Uk7VCRJPWr30zjPUVrQPA_H5kBU-nfrQ@mail.gmail.com>
 <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com> <387c3a1d-efe7-36c5-6233-f262f27a64a7@lightnvm.io>
In-Reply-To: <387c3a1d-efe7-36c5-6233-f262f27a64a7@lightnvm.io>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 5 Mar 2019 09:20:56 +0100
Message-ID: <CANr-nt0HuEnEPhAQC10xEFud4SHqcC662==1njSP8Ag2ue4UKA@mail.gmail.com>
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 2:00 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>
> On 3/4/19 1:44 PM, Igor Konopko wrote:
> >
> >
> > On 04.03.2019 12:43, Hans Holmberg wrote:
> >> On Mon, Mar 4, 2019 at 10:11 AM Javier Gonz=C3=A1lez <javier@javigon.c=
om>
> >> wrote:
> >>>
> >>>> On 4 Mar 2019, at 10.05, Hans Holmberg
> >>>> <hans.ml.holmberg@owltronix.com> wrote:
> >>>>
> >>>> I strongly disagree with adding code that would mask implantation
> >>>> errors.
> >>>>
> >>>> If we want more internal checks, we could add an if statement that
> >>>> would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
> >>>>
> >>>
> >>> Not sure who this is for - better not to top post.
> >>>
> >>> In any case, this is a spec grey zone. I=E2=80=99m ok with cleaning t=
he bits as
> >>> they mean nothing for the reset command. If you feel that strongly ab=
out
> >>> this, you can take if with Igor.
> >>
> >> Pardon the top-post. It was meant for both you and Igor.
> >>
> >
> > OCSSD 2.0 spec for vector chunk reset (chapter 2.2.2) explicitly says
> > "The addresses in the LBA list shall be the first logical block address
> > of each chunk to be reset.". So in my understanding we suppose to clear
> > the sectors bits of the PPA address in order to be spec compliant.
> >
>
> Agree. And since ppa_addr is allocated on the stack, it should be either
> memset or the remaining fields should be set to 0. Maybe better to zero
> initialize in declaration?

Ah, I thought this was not needed, as ppa is initialized as:

ppa =3D pblk->luns[bit].bppa; /* set ch and lun */

and luns[bit].bppa is initialized to on a value that originally comes
from drivers/lightnvm/core.c:196
(and that's explicitly zeroing all 64 bits before setting ch and lun)

Let me know if i don't make sense here.

>
> >>>
> >>>>
> >>>> On Mon, Mar 4, 2019 at 8:48 AM Javier Gonz=C3=A1lez <javier@javigon.=
com>
> >>>> wrote:
> >>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com>
> >>>>>> wrote:
> >>>>>>
> >>>>>> In current pblk implementation of erase command
> >>>>>> there is a chance tha sector bits are set to some
> >>>>>> random values for erase PPA. This is unexpected
> >>>>>> situation, since erase shall be always chunk
> >>>>>> aligned. This patch fixes that issue
> >>>>>>
> >>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>>>> ---
> >>>>>> drivers/lightnvm/pblk-core.c | 1 +
> >>>>>> drivers/lightnvm/pblk-map.c  | 2 ++
> >>>>>> 2 files changed, 3 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/lightnvm/pblk-core.c
> >>>>>> b/drivers/lightnvm/pblk-core.c
> >>>>>> index a98b2255f963..78b1eea4ab67 100644
> >>>>>> --- a/drivers/lightnvm/pblk-core.c
> >>>>>> +++ b/drivers/lightnvm/pblk-core.c
> >>>>>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct
> >>>>>> pblk_line *line)
> >>>>>>
> >>>>>>               ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> >>>>>>               ppa.a.blk =3D line->id;
> >>>>>> +             ppa.a.reserved =3D 0;
> >>>>>>
> >>>>>>               atomic_dec(&line->left_eblks);
> >>>>>>               WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> >>>>>> diff --git a/drivers/lightnvm/pblk-map.c
> >>>>>> b/drivers/lightnvm/pblk-map.c
> >>>>>> index 79df583ea709..aea46b4ec40f 100644
> >>>>>> --- a/drivers/lightnvm/pblk-map.c
> >>>>>> +++ b/drivers/lightnvm/pblk-map.c
> >>>>>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk,
> >>>>>> struct nvm_rq *rqd,
> >>>>>>
> >>>>>>                       *erase_ppa =3D ppa_list[i];
> >>>>>>                       erase_ppa->a.blk =3D e_line->id;
> >>>>>> +                     erase_ppa->a.reserved =3D 0;
> >>>>>>
> >>>>>>                       spin_unlock(&e_line->lock);
> >>>>>>
> >>>>>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk,
> >>>>>> struct nvm_rq *rqd,
> >>>>>>               atomic_dec(&e_line->left_eblks);
> >>>>>>               *erase_ppa =3D pblk->luns[bit].bppa; /* set ch and l=
un */
> >>>>>>               erase_ppa->a.blk =3D e_line->id;
> >>>>>> +             erase_ppa->a.reserved =3D 0;
> >>>>>>       }
> >>>>>>
> >>>>>>       return 0;
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>
> >>>>> I=E2=80=99m fine with adding this, but note that there is actually =
no
> >>>>> requirement for the erase to be chunk aligned - the only bits that
> >>>>> should be looked at are group, PU and chunk.
> >>>>>
> >>>>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>
