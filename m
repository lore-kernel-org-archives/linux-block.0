Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FDEC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 08:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004762082C
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 08:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="jHNzf60T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfCEIky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:40:54 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38971 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfCEIkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 03:40:53 -0500
Received: by mail-ua1-f67.google.com with SMTP id s15so7025505uap.6
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 00:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/PiPRKH9fQyAwkhwERCNR7KrecE0/Afd76Qq92tH7TY=;
        b=jHNzf60TLmd6ThLatwuxROhSnbvRRKMx7GMqZO1Mlz1BsbAyl5o9uD1JMaDXitZy1Y
         MURqoU4uU88d4RA/EPuL4XOBnhjLfI0OeoZI/gfRUS7C3rsXVnYQbBfvaKbUUh0gl83G
         7KVWeNZI+BnwMC1gKuzIWvstXok3SbLg1JuDhEk4zqZ4HqzU5WzmTJvm3VpTT2gnWrPg
         2T41QJCEPt9rjkcLjgCyvmmZObzcJ7PB+AfhScVaWzoalhepyZ63mWMDeReZUzYK2iyF
         yo50LvJnxKEHeXmOmc+eQXZwvCzioNkEdmlmfhfqGRILkZ0i2FLCBM1fj/amorufUWm/
         qRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/PiPRKH9fQyAwkhwERCNR7KrecE0/Afd76Qq92tH7TY=;
        b=rvex5IDJ07houXDz/3t9MvZU3V5DiWmearv7mpb9m3PrWhzQEuQYNhOeiTUZfflokm
         7b8uefrbHYJ0owRjZ05M2SPREVSm72Rx+9Cdz8Vw92vfACE4z55zzFQHhn5/1w+r8f9h
         0+WMEoYsDVtgA1iLM9HFfV56KlSvSO2Q2Ri980/aH/wJyeQKD7/9LY4EbN+v7wfKZIiz
         LbHnKJkp1FgU157HAPr6Tfk9uVYmd9QXO3330kc+LXuBjGNh5sLYSlaEPOI/kZblbdlU
         Y7nrBQ8cCgLBdH6zlN5E8I54kxwyNPqUDodCc10c5qaVCA/eE7CaH9vc+kaRqAVzjZ9r
         dWiQ==
X-Gm-Message-State: APjAAAUMOezrwo531o3IliBdhvgoQbmOpqxcjEzRbT2vDhEyguvTSy4C
        CSvo01f3Rg0aDBbIaXUTTwcs7WcUxgVhlKUdLLQ2Qw==
X-Google-Smtp-Source: APXvYqwwDhtuO8BSOxBDiiLowqy7L2vmgZdDoptjXvQMRu/cLUpxHW1P35dsHI4XUVilsOPG7scFWg5lZ1G4qBWT1VY=
X-Received: by 2002:ab0:e03:: with SMTP id g3mr608638uak.68.1551775252363;
 Tue, 05 Mar 2019 00:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com> <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
 <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com> <CANr-nt30zr_5sMEAK4Uk7VCRJPWr30zjPUVrQPA_H5kBU-nfrQ@mail.gmail.com>
 <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com> <387c3a1d-efe7-36c5-6233-f262f27a64a7@lightnvm.io>
 <CANr-nt0HuEnEPhAQC10xEFud4SHqcC662==1njSP8Ag2ue4UKA@mail.gmail.com> <0cd6b922-c622-6946-b182-77176967e63b@intel.com>
In-Reply-To: <0cd6b922-c622-6946-b182-77176967e63b@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 5 Mar 2019 09:40:41 +0100
Message-ID: <CANr-nt0xLtFG3+D-qU9kWq3t5RwfYkzw=K4pa+UDqw-ZiaROGw@mail.gmail.com>
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 5, 2019 at 9:26 AM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 05.03.2019 09:20, Hans Holmberg wrote:
> > On Mon, Mar 4, 2019 at 2:00 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wr=
ote:
> >>
> >> On 3/4/19 1:44 PM, Igor Konopko wrote:
> >>>
> >>>
> >>> On 04.03.2019 12:43, Hans Holmberg wrote:
> >>>> On Mon, Mar 4, 2019 at 10:11 AM Javier Gonz=C3=A1lez <javier@javigon=
.com>
> >>>> wrote:
> >>>>>
> >>>>>> On 4 Mar 2019, at 10.05, Hans Holmberg
> >>>>>> <hans.ml.holmberg@owltronix.com> wrote:
> >>>>>>
> >>>>>> I strongly disagree with adding code that would mask implantation
> >>>>>> errors.
> >>>>>>
> >>>>>> If we want more internal checks, we could add an if statement that
> >>>>>> would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
> >>>>>>
> >>>>>
> >>>>> Not sure who this is for - better not to top post.
> >>>>>
> >>>>> In any case, this is a spec grey zone. I=E2=80=99m ok with cleaning=
 the bits as
> >>>>> they mean nothing for the reset command. If you feel that strongly =
about
> >>>>> this, you can take if with Igor.
> >>>>
> >>>> Pardon the top-post. It was meant for both you and Igor.
> >>>>
> >>>
> >>> OCSSD 2.0 spec for vector chunk reset (chapter 2.2.2) explicitly says
> >>> "The addresses in the LBA list shall be the first logical block addre=
ss
> >>> of each chunk to be reset.". So in my understanding we suppose to cle=
ar
> >>> the sectors bits of the PPA address in order to be spec compliant.
> >>>
> >>
> >> Agree. And since ppa_addr is allocated on the stack, it should be eith=
er
> >> memset or the remaining fields should be set to 0. Maybe better to zer=
o
> >> initialize in declaration?
> >
> > Ah, I thought this was not needed, as ppa is initialized as:
> >
> > ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> >
> > and luns[bit].bppa is initialized to on a value that originally comes
> > from drivers/lightnvm/core.c:196
> > (and that's explicitly zeroing all 64 bits before setting ch and lun)
> >
> > Let me know if i don't make sense here.
> >
>
> I just noticed the same.
>
> In two places (pblk-core:1095 and pblk-map:205) we are using values
> initialized previously in core.c - so my changes are not needed here.
>
> But still there is one place (pblk-map:163) where we initializing
> erase_ppa based on ppa_list[i], which has PPA sector set in most of the
> cases, so this zeroing is still needed here.

Yes, you are right, thanks for pointing it out. Are you ok with just
changing this?

> >>
> >>>>>
> >>>>>>
> >>>>>> On Mon, Mar 4, 2019 at 8:48 AM Javier Gonz=C3=A1lez <javier@javigo=
n.com>
> >>>>>> wrote:
> >>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com=
>
> >>>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> In current pblk implementation of erase command
> >>>>>>>> there is a chance tha sector bits are set to some
> >>>>>>>> random values for erase PPA. This is unexpected
> >>>>>>>> situation, since erase shall be always chunk
> >>>>>>>> aligned. This patch fixes that issue
> >>>>>>>>
> >>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>>>>>> ---
> >>>>>>>> drivers/lightnvm/pblk-core.c | 1 +
> >>>>>>>> drivers/lightnvm/pblk-map.c  | 2 ++
> >>>>>>>> 2 files changed, 3 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/lightnvm/pblk-core.c
> >>>>>>>> b/drivers/lightnvm/pblk-core.c
> >>>>>>>> index a98b2255f963..78b1eea4ab67 100644
> >>>>>>>> --- a/drivers/lightnvm/pblk-core.c
> >>>>>>>> +++ b/drivers/lightnvm/pblk-core.c
> >>>>>>>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struc=
t
> >>>>>>>> pblk_line *line)
> >>>>>>>>
> >>>>>>>>                ppa =3D pblk->luns[bit].bppa; /* set ch and lun *=
/
> >>>>>>>>                ppa.a.blk =3D line->id;
> >>>>>>>> +             ppa.a.reserved =3D 0;
> >>>>>>>>
> >>>>>>>>                atomic_dec(&line->left_eblks);
> >>>>>>>>                WARN_ON(test_and_set_bit(bit, line->erase_bitmap)=
);
> >>>>>>>> diff --git a/drivers/lightnvm/pblk-map.c
> >>>>>>>> b/drivers/lightnvm/pblk-map.c
> >>>>>>>> index 79df583ea709..aea46b4ec40f 100644
> >>>>>>>> --- a/drivers/lightnvm/pblk-map.c
> >>>>>>>> +++ b/drivers/lightnvm/pblk-map.c
> >>>>>>>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk,
> >>>>>>>> struct nvm_rq *rqd,
> >>>>>>>>
> >>>>>>>>                        *erase_ppa =3D ppa_list[i];
> >>>>>>>>                        erase_ppa->a.blk =3D e_line->id;
> >>>>>>>> +                     erase_ppa->a.reserved =3D 0;
> >>>>>>>>
> >>>>>>>>                        spin_unlock(&e_line->lock);
> >>>>>>>>
> >>>>>>>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk,
> >>>>>>>> struct nvm_rq *rqd,
> >>>>>>>>                atomic_dec(&e_line->left_eblks);
> >>>>>>>>                *erase_ppa =3D pblk->luns[bit].bppa; /* set ch an=
d lun */
> >>>>>>>>                erase_ppa->a.blk =3D e_line->id;
> >>>>>>>> +             erase_ppa->a.reserved =3D 0;
> >>>>>>>>        }
> >>>>>>>>
> >>>>>>>>        return 0;
> >>>>>>>> --
> >>>>>>>> 2.17.1
> >>>>>>>
> >>>>>>> I=E2=80=99m fine with adding this, but note that there is actuall=
y no
> >>>>>>> requirement for the erase to be chunk aligned - the only bits tha=
t
> >>>>>>> should be looked at are group, PU and chunk.
> >>>>>>>
> >>>>>>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
> >>
