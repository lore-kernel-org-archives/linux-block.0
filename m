Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37073C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019DE2075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="aAwL0O0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfCDM5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:57:45 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34036 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCDM5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 07:57:45 -0500
Received: by mail-ua1-f65.google.com with SMTP id a42so4281765uad.1
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hd4+Yvi8Na0fWe8FveOkbN1EXWp5dLTyKcSdQn3jCt8=;
        b=aAwL0O0RF4jj9sxjldjJPHjJv8fPzLPErXsPZPu8eK0MXMPU6/t85aQ1Sxu8VAWEH0
         2W6tQi76Kv/CBedstoiF9cF+cPVDyUshWEVsUZezrD+IRlBOL583O+ryjnFvFEkWXoR2
         0Lg/DujJiPmb06PC2d/xUrs33H9HmDgJb4Rn/YOyUZmAp6C0A3uDCIWtm1aYfuVlVWk+
         TljQwmegWEtMNISOR6MFkyjTSPEBeA/DmCz1EKFVimfd5adUvTOb701dYsJ/PXIlJuhx
         FfiEZiQPcFKakdAcQyRVrtQTknySOoOFMHqbRGGq8YqkqqBfZHO3JlnoZI8gp4pcF0He
         i3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hd4+Yvi8Na0fWe8FveOkbN1EXWp5dLTyKcSdQn3jCt8=;
        b=Ouqq3i6fq9VebTlriDe5G71Zs5k+ye3aeuXg1m+UNdTQJKz9ssQuDpzCdzb0hZihhE
         s5MzXl4b5QGiXrvDgghMG7c38hUxwIALbVIQR834K2sL6147Nvy9HMdV27iK8hTy4PW7
         8Laot8BHFnjTaRPyn5K6xg8mmuE6KJW3kDtW2yUL7mvFnTPlax6nRyVpLRao5dej0M1V
         qGP5+vIiWQ0foPywxaxLC9ulTb4xj0Ggd8SCh13hzlBgTLn+XQqrx+vdm0kJ1x2JyOMI
         rdSAo8ismxep3KYlqyGAT/6qz+mBGLBrWMAgzT4TVHJqYIXdzHip9tZwVmsaPOes4IuR
         V8+w==
X-Gm-Message-State: APjAAAWOYKoKCLHkZHmH9JyPsqSBNIFbIpKILLifpdVFzbVMO4QPvtdB
        4uTI4Mw9CaP+qmgNQ3HtSEAYupNLQfvaZ37xc3SIDQ==
X-Google-Smtp-Source: APXvYqwvgjDQ4HdMhP1rrDxgq5hlfhvzUra1D+Yj7BKqs9a1+Kgxz8GAhvtyAr73qKvrVGc0h9sPqDYqOJRg1t5OoO4=
X-Received: by 2002:ab0:7445:: with SMTP id p5mr9569653uaq.45.1551704263906;
 Mon, 04 Mar 2019 04:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com> <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
 <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com> <CANr-nt30zr_5sMEAK4Uk7VCRJPWr30zjPUVrQPA_H5kBU-nfrQ@mail.gmail.com>
 <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com>
In-Reply-To: <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 13:57:33 +0100
Message-ID: <CANr-nt3oCa10aA-MDh8Hx0tD=WW5Tke7-09DY9a8zhkHEwAatg@mail.gmail.com>
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 1:44 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 04.03.2019 12:43, Hans Holmberg wrote:
> > On Mon, Mar 4, 2019 at 10:11 AM Javier Gonz=C3=A1lez <javier@javigon.co=
m> wrote:
> >>
> >>> On 4 Mar 2019, at 10.05, Hans Holmberg <hans.ml.holmberg@owltronix.co=
m> wrote:
> >>>
> >>> I strongly disagree with adding code that would mask implantation err=
ors.
> >>>
> >>> If we want more internal checks, we could add an if statement that
> >>> would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
> >>>
> >>
> >> Not sure who this is for - better not to top post.
> >>
> >> In any case, this is a spec grey zone. I=E2=80=99m ok with cleaning th=
e bits as
> >> they mean nothing for the reset command. If you feel that strongly abo=
ut
> >> this, you can take if with Igor.
> >
> > Pardon the top-post. It was meant for both you and Igor.
> >
>
> OCSSD 2.0 spec for vector chunk reset (chapter 2.2.2) explicitly says
> "The addresses in the LBA list shall be the first logical block address
> of each chunk to be reset.". So in my understanding we suppose to clear
> the sectors bits of the PPA address in order to be spec compliant.

Hmm.. but my point is that if pblk->luns[bit].bppa is set to a valid
chunk address, there is no need to clear a.reserved.
that address originates from core.c:196,  and thats valid.

>
> >>
> >>>
> >>> On Mon, Mar 4, 2019 at 8:48 AM Javier Gonz=C3=A1lez <javier@javigon.c=
om> wrote:
> >>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> w=
rote:
> >>>>>
> >>>>> In current pblk implementation of erase command
> >>>>> there is a chance tha sector bits are set to some
> >>>>> random values for erase PPA. This is unexpected
> >>>>> situation, since erase shall be always chunk
> >>>>> aligned. This patch fixes that issue
> >>>>>
> >>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>>>> ---
> >>>>> drivers/lightnvm/pblk-core.c | 1 +
> >>>>> drivers/lightnvm/pblk-map.c  | 2 ++
> >>>>> 2 files changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-c=
ore.c
> >>>>> index a98b2255f963..78b1eea4ab67 100644
> >>>>> --- a/drivers/lightnvm/pblk-core.c
> >>>>> +++ b/drivers/lightnvm/pblk-core.c
> >>>>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct p=
blk_line *line)
> >>>>>
> >>>>>               ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> >>>>>               ppa.a.blk =3D line->id;
> >>>>> +             ppa.a.reserved =3D 0;
> >>>>>
> >>>>>               atomic_dec(&line->left_eblks);
> >>>>>               WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> >>>>> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-ma=
p.c
> >>>>> index 79df583ea709..aea46b4ec40f 100644
> >>>>> --- a/drivers/lightnvm/pblk-map.c
> >>>>> +++ b/drivers/lightnvm/pblk-map.c
> >>>>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct=
 nvm_rq *rqd,
> >>>>>
> >>>>>                       *erase_ppa =3D ppa_list[i];
> >>>>>                       erase_ppa->a.blk =3D e_line->id;
> >>>>> +                     erase_ppa->a.reserved =3D 0;
> >>>>>
> >>>>>                       spin_unlock(&e_line->lock);
> >>>>>
> >>>>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct=
 nvm_rq *rqd,
> >>>>>               atomic_dec(&e_line->left_eblks);
> >>>>>               *erase_ppa =3D pblk->luns[bit].bppa; /* set ch and lu=
n */
> >>>>>               erase_ppa->a.blk =3D e_line->id;
> >>>>> +             erase_ppa->a.reserved =3D 0;
> >>>>>       }
> >>>>>
> >>>>>       return 0;
> >>>>> --
> >>>>> 2.17.1
> >>>>
> >>>> I=E2=80=99m fine with adding this, but note that there is actually n=
o
> >>>> requirement for the erase to be chunk aligned - the only bits that
> >>>> should be looked at are group, PU and chunk.
> >>>>
> >>>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
