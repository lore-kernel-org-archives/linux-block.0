Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93006C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8F620449
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="vvJp5rxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCDLoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:44:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45553 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 06:44:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id f19so3968428eds.12
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 03:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=15csMa+qrHnRuIOgOyDuOk4ImaSR/tgeZUrPFV/G50c=;
        b=vvJp5rxAmCHoY94cey1GOT5B6o6tygH+lBcenT6aLE7/FYlllkvUPLLVNJKuDHe01u
         b5tjqFvFHLHl6flK6JHCd/+ooISh8MwAosI0QSI0Es+vMNCIN0cq/zgnVui8IvJ7rLh0
         mcA+L8vb1d8B89PEA2kUjdqxBpjFkzHOPM7Mz2eNf19zTruvSLTHy1LkeOVXtpHLa3/t
         BFo0ATDLjS7BhSowTnFnpFGMtXyFoZvrQLxphUauH6MzoydsfO/K/kaAm/lwUkthwVi4
         hIXj4vXwysylJJiEFcYV7tyf0M0ohL3IyACDkEDObuCnr+snDHNFYT0zj+Ge6G6Ws1ma
         Kh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=15csMa+qrHnRuIOgOyDuOk4ImaSR/tgeZUrPFV/G50c=;
        b=I1Ywoh+gkw1ErOt+30IwOcLah5l3OLJKFN7F6nHD7Rse31r7WuN/2+UuuGnWNtyQX+
         PawuDu17zIuxbpy4jLdjDxcr7tmq0hI3aSoT6axO62dkkQerb0V0dlfGAEbG0wJ3Ymak
         7Ga0sdsIzj6wjNwTh+GaQtdvLvXEub1h8oxNMtj7hm4A1Gj7tr9D+hDfPD0TTM/fTxSe
         QtIqHXaS3cH8hLqlvIy7sGbN+0Fkvmvh55AnxsfxVXMXmjmCzh6lnpRsr94VGc+d4nOO
         OHmmZXq1PQPJgIxwh29JzHBlo7GTwSyx0t7dsLIk3mbdbXnHRYpUSvBnjHBJJ5ujQk7c
         yx8g==
X-Gm-Message-State: APjAAAWscEsaTkOzw+LhCvN/GP51SolpylrxP4hUoSgvfM47ia8PS4XN
        VreMOaJXMTjWFBw8IzQUqq7Wvw==
X-Google-Smtp-Source: APXvYqx/fOZX0eez3JjBcmLH+PGrQjT5nJ0K1dl4bvVeoj8r1i0T8dEub8pFgrq5by5+rKrm1a1vgg==
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr15005544edr.117.1551699847315;
        Mon, 04 Mar 2019 03:44:07 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id me7sm1145945ejb.46.2019.03.04.03.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 03:44:06 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <54D42A19-96EE-4370-B957-A474BB912530@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_199A4DD1-71F5-4B5B-81B7-B5DD05F48860";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
Date:   Mon, 4 Mar 2019 12:44:05 +0100
In-Reply-To: <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Simon Andreas Frimann Lund <slund@cnexlabs.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com>
 <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
 <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_199A4DD1-71F5-4B5B-81B7-B5DD05F48860
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> Current lightnvm and pblk implementation does not care
>>> about NVMe max data transfer size, which can be smaller
>>> than 64*K=3D256K. This patch fixes issues related to that.
>=20
> Could you describe *what* issues you are fixing?
>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/core.c      | 9 +++++++--
>>> drivers/nvme/host/lightnvm.c | 1 +
>>> include/linux/lightnvm.h     | 1 +
>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>> index 5f82036fe322..c01f83b8fbaf 100644
>>> --- a/drivers/lightnvm/core.c
>>> +++ b/drivers/lightnvm/core.c
>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>>>      struct nvm_target *t;
>>>      struct nvm_tgt_dev *tgt_dev;
>>>      void *targetdata;
>>> +     unsigned int mdts;
>>>      int ret;
>>>=20
>>>      switch (create->conf.type) {
>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>>>      tdisk->private_data =3D targetdata;
>>>      tqueue->queuedata =3D targetdata;
>>>=20
>>> -     blk_queue_max_hw_sectors(tqueue,
>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>> +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>> +     if (dev->geo.mdts) {
>>> +             mdts =3D min_t(u32, dev->geo.mdts,
>>> +                             (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>> +     }
>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>=20
>>>      set_capacity(tdisk, tt->capacity(targetdata));
>>>      add_disk(tdisk);
>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>> index b759c25c89c8..b88a39a3cbd1 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
>>>      geo->csecs =3D 1 << ns->lba_shift;
>>>      geo->sos =3D ns->ms;
>>>      geo->ext =3D ns->ext;
>>> +     geo->mdts =3D ns->ctrl->max_hw_sectors;
>>>=20
>>>      dev->q =3D q;
>>>      memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>      u16     csecs;          /* sector size */
>>>      u16     sos;            /* out-of-band area size */
>>>      bool    ext;            /* metadata in extended data buffer */
>>> +     u32     mdts;           /* Max data transfer size*/
>>>=20
>>>      /* device write constrains */
>>>      u32     ws_min;         /* minimum write size */
>>> --
>>> 2.17.1
>>=20
>> I see where you are going with this and I partially agree, but none =
of
>> the OCSSD specs define a way to define this parameter. Thus, adding =
this
>> behavior taken from NVMe in Linux can break current implementations. =
Is
>> this a real life problem for you? Or this is just for NVMe =
=E2=80=9Ccorrectness=E2=80=9D?
>>=20
>> Javier
>=20
> Hmm.Looking into the 2.0 spec what it says about vector reads:
>=20
> (figure 28):"The number of Logical Blocks (NLB): This field indicates
> the number of logical blocks to be read. This is a 0=E2=80=99s based =
value.
> Maximum of 64 LBAs is supported."
>=20
> You got the max limit covered, and the spec  does not say anything
> about the minimum number of LBAs to support.
>=20
> Matias: any thoughts on this?
>=20
> Javier: How would this patch break current implementations?

Say an OCSSD controller that sets mdts to a value under 64 or does not
set it at all (maybe garbage). Think you can get to one pretty =
quickly...

>=20
> Igor: how does this patch fix the mdts restriction? There are no
> checks on i.e. the gc read path that ensures that a lower limit than
> NVM_MAX_VLBA is enforced.

This is the other part where the implementation breaks.

Javier

--Apple-Mail=_199A4DD1-71F5-4B5B-81B7-B5DD05F48860
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9D4UACgkQPEYBfS0l
eOClVBAAn8bI6QaZdURnASQFBqJ2R3X5SKXv1FiLdn46Cmikt/faDdiKuxtN7/ok
Lwt+uNaLDga8U+7HjHZYIy4iO6VLOsSPXDaOf7E7yAOUO72d+2j7TxHj3aA0sTTW
+fy+4evroz8OfhFc5+KJ43lUi4CQbPV6kJxMBPFrB6blhFlvK56n3/6HIw7Wf7iw
9J31WKSlmK5oenmpMh3DnJIg5fqekFQVkQQLSY7FAaQ8wnu5uKn7zLvPMzamXb0j
S6MwE1Zl1x7PIz//trCrGARdN37ga3bfCW1TTP8a8StR+EPBf2caSsZj3pkLxpo6
yHNIgo38nQyYM2CpGnC7kPJ3l/+wmY5WWlosL3b96ipQOtYl8gBoDpeexxn7d9QX
wU6JgaY+S2LtPVcMin38H1UOnLU9FOSauYRtR1VYO3WJ5n9PhDhcHBDgjJAaAvbi
pxAxod56v0p2aAN5sXnaqGjqRA7e4gionezOsT0my/hZBkJ8MA0sLJ46APAGuINB
OcWXsG/LpDqhmLutSB7TPxTseqrMynps86JoXmgzcYRe06ob17FxMUOB1nUbqW5N
8c2OUbMpDdazHhqi5QorKFoRHzP98GBGmv1BzyihqcU5GgGm9jtUexf8F7E/JU7W
VLHP0a0VbotAIpytvHa4pqqSnfN+70+5oPMTnAy8GRnMDFKKuHA=
=itoR
-----END PGP SIGNATURE-----

--Apple-Mail=_199A4DD1-71F5-4B5B-81B7-B5DD05F48860--
