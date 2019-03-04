Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD795C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3920835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="J/UkmQPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfCDNoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:44:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40894 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDNoS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:44:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so4272767eds.7
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Tj4efxLDnajVOwe/01IXJvJ1F5TQzzVld3cShxRWgzM=;
        b=J/UkmQPgBhcMbgItpl8WPidSIwsWcTTzG/CTLqyLJJJOmJSXnqBeAdB8uj6VgSWZsC
         Y+/FXROIq3Juw9zylo93kKq6VzKWIUIBuxmnHrrDPHKKY7tXL/Y2Byf3dy9z5n/h0E3/
         AfsUaYGxzw+d6J5xod4w4fEVMjcIPGsmBpOhibXWPW2qka+sj+UgltqPpWwm2zqOYDp5
         jviWsuBDd8tfDx0vmGvRWyVh3w+aD7YecHeHzSbjdSbVmddFqCW9P2oNUpIkGDNWH5Fk
         z0ffn7dkTuNXehC2WngWJO/PYkBRKYa+dd6u2xevwUwPVOXnUTOZkFO3Zg3u/a+yU5vt
         SR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Tj4efxLDnajVOwe/01IXJvJ1F5TQzzVld3cShxRWgzM=;
        b=sYDNYfRR8aTcTKpU2/Yyq4MnUO2VS7OAbOYLRmcrBsW4Q48hfGLxBoel4oBGl2hW8Q
         1miqDk1CJgxpRV++CsdXPm4Hdv6K8nmiDh4dWLqTL7c6Hzhy28gt5bbXMPu0xC1QSr7T
         dLwa8U9HG4jt9V565dJcy8szwbXqezqg6hf7l/PkdjTv0IsvqBkv25EoSznYiiml3O4b
         +sTQ2o6mrNRdFFd5qhTtcKan4QCuOHzt9ep/XgdGiQiMo610MnURa/4KIPn16xUNbtm9
         IZ9N/q3AhO1FXgCNq8FG3nabMZfy40I3+/W7K739RNkz48tT0xzCQqm5N5gGqRpfHlv5
         +ssg==
X-Gm-Message-State: APjAAAVtbvdCBH+2hcwpwMVfaZwRvoBLF68+ThBsOWkabYXSwkykgHI2
        zXXtPW0sIrI/9QRutilEQ5aeHg==
X-Google-Smtp-Source: APXvYqxb+cH39srRP4KJncZ4paR6EIT6NqQu5VL0OA0AadbtjHNoP1XUure+42MBSZlPsq1mHLmAHQ==
X-Received: by 2002:a50:a7e5:: with SMTP id i92mr15803414edc.181.1551707055806;
        Mon, 04 Mar 2019 05:44:15 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id o23sm1202211ejg.28.2019.03.04.05.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:44:14 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <EA36DDD6-5A3D-4F5C-9B18-53E266EB676F@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C6030077-19CF-44C5-BF41-1402E4D9280E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
Date:   Mon, 4 Mar 2019 14:44:13 +0100
In-Reply-To: <c6fbb977-bfde-d76d-cc4f-198a732d38d0@lightnvm.io>
Cc:     Hans Holmberg <hans@owltronix.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Simon Andreas Frimann Lund <slund@cnexlabs.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com>
 <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
 <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
 <54D42A19-96EE-4370-B957-A474BB912530@javigon.com>
 <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
 <CDD16047-68EF-43EA-A33B-11279A4301E6@javigon.com>
 <c6fbb977-bfde-d76d-cc4f-198a732d38d0@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_C6030077-19CF-44C5-BF41-1402E4D9280E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4 Mar 2019, at 14.25, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 3/4/19 2:19 PM, Javier Gonz=C3=A1lez wrote:
>>> On 4 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>>>=20
>>> On Mon, Mar 4, 2019 at 12:44 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>>>>>=20
>>>>> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>>>>>=20
>>>>>>> Current lightnvm and pblk implementation does not care
>>>>>>> about NVMe max data transfer size, which can be smaller
>>>>>>> than 64*K=3D256K. This patch fixes issues related to that.
>>>>>=20
>>>>> Could you describe *what* issues you are fixing?
>>>>>=20
>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>> ---
>>>>>>> drivers/lightnvm/core.c      | 9 +++++++--
>>>>>>> drivers/nvme/host/lightnvm.c | 1 +
>>>>>>> include/linux/lightnvm.h     | 1 +
>>>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>>>> index 5f82036fe322..c01f83b8fbaf 100644
>>>>>>> --- a/drivers/lightnvm/core.c
>>>>>>> +++ b/drivers/lightnvm/core.c
>>>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev =
*dev, struct nvm_ioctl_create *create)
>>>>>>>     struct nvm_target *t;
>>>>>>>     struct nvm_tgt_dev *tgt_dev;
>>>>>>>     void *targetdata;
>>>>>>> +     unsigned int mdts;
>>>>>>>     int ret;
>>>>>>>=20
>>>>>>>     switch (create->conf.type) {
>>>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev =
*dev, struct nvm_ioctl_create *create)
>>>>>>>     tdisk->private_data =3D targetdata;
>>>>>>>     tqueue->queuedata =3D targetdata;
>>>>>>>=20
>>>>>>> -     blk_queue_max_hw_sectors(tqueue,
>>>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>>>> +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>>>>>> +     if (dev->geo.mdts) {
>>>>>>> +             mdts =3D min_t(u32, dev->geo.mdts,
>>>>>>> +                             (dev->geo.csecs >> 9) * =
NVM_MAX_VLBA);
>>>>>>> +     }
>>>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>>>>>=20
>>>>>>>     set_capacity(tdisk, tt->capacity(targetdata));
>>>>>>>     add_disk(tdisk);
>>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>>> index b759c25c89c8..b88a39a3cbd1 100644
>>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, =
char *disk_name, int node)
>>>>>>>     geo->csecs =3D 1 << ns->lba_shift;
>>>>>>>     geo->sos =3D ns->ms;
>>>>>>>     geo->ext =3D ns->ext;
>>>>>>> +     geo->mdts =3D ns->ctrl->max_hw_sectors;
>>>>>>>=20
>>>>>>>     dev->q =3D q;
>>>>>>>     memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>>>>>> --- a/include/linux/lightnvm.h
>>>>>>> +++ b/include/linux/lightnvm.h
>>>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>>>>>     u16     csecs;          /* sector size */
>>>>>>>     u16     sos;            /* out-of-band area size */
>>>>>>>     bool    ext;            /* metadata in extended data buffer =
*/
>>>>>>> +     u32     mdts;           /* Max data transfer size*/
>>>>>>>=20
>>>>>>>     /* device write constrains */
>>>>>>>     u32     ws_min;         /* minimum write size */
>>>>>>> --
>>>>>>> 2.17.1
>>>>>>=20
>>>>>> I see where you are going with this and I partially agree, but =
none of
>>>>>> the OCSSD specs define a way to define this parameter. Thus, =
adding this
>>>>>> behavior taken from NVMe in Linux can break current =
implementations. Is
>>>>>> this a real life problem for you? Or this is just for NVMe =
=E2=80=9Ccorrectness=E2=80=9D?
>>>>>>=20
>>>>>> Javier
>>>>>=20
>>>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
>>>>>=20
>>>>> (figure 28):"The number of Logical Blocks (NLB): This field =
indicates
>>>>> the number of logical blocks to be read. This is a 0=E2=80=99s =
based value.
>>>>> Maximum of 64 LBAs is supported."
>>>>>=20
>>>>> You got the max limit covered, and the spec  does not say anything
>>>>> about the minimum number of LBAs to support.
>>>>>=20
>>>>> Matias: any thoughts on this?
>>>>>=20
>>>>> Javier: How would this patch break current implementations?
>>>>=20
>>>> Say an OCSSD controller that sets mdts to a value under 64 or does =
not
>>>> set it at all (maybe garbage). Think you can get to one pretty =
quickly...
>>>=20
>>> So we cant make use of a perfectly good, standardized, parameter
>>> because some hypothetical non-compliant device out there might not
>>> provide a sane value?
>> The OCSSD standard has never used NVMe parameters, so there is no
>> compliant / non-compliant. In fact, until we changed OCSSD 2.0 to
>> get the sector and OOB sizes from the standard identify
>> command, we used to have them in the geometry.
>=20
> What the hell? Yes it has. The whole OCSSD spec is dependent on the
> NVMe spec. It is using many commands from the NVMe specification,
> which is not defined in the OCSSD specification.
>=20

First, lower the tone.

Second, no, it has not and never has, starting with all the write
constrains, continuing with the vector commands, etc. You cannot choose
what you want to be compliant with and what you do not. OCSSD uses the
NVMe protocol but it is self sufficient with its geometry for all the
read / write / erase paths - it even depends on different PCIe class
codes to be identified=E2=80=A6 To do this in the way the rest of the =
spec is
defined, we either add a filed to the geometry or explicitly mention
that MDTS is used, as we do with the sector and metadata sizes.

Third, as a maintainer of this subsystem you should care about devices
in the field that might break due to such a change (supported by the
company you work for or not) - even if you can argue whether the change
is compliant or not.

And Hans, as a representative of a company that has such devices out
there, you should care too.

What if we add a quirk in the feature bits for this so that newer
devices can implement this and older devices can still function?

> The MDTS field should be respected in all case, similarly to how the
> block layer respects it. Since the lightnvm subsystem are hooking in
> on the side, this also be honoured by pblk (or the lightnvm subsystem
> should fix it up)
>=20

This said, pblk does not care which value you give, it uses what the
subsystem tells it - this is not arguing for this change not to be
implemented.

The only thing we should care about if implementing this is removing the
constant defining 64 ppas and making allocations dynamic in the partial
read and GC paths.

Javier

--Apple-Mail=_C6030077-19CF-44C5-BF41-1402E4D9280E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9K60ACgkQPEYBfS0l
eOBbgw/+JLOzjDbw4KrF32ao6OycutQ5F6NLrAYBO2SDbtygBjBmn2PHx5DUS0Xd
hBHtxfaEvAeOjrR9SxKr8cJ/NR5Jsu1U8walX+QtiMY1S+KM8bMuXEHdgh0L1im5
hxJ60nrTBbKrE+J7fn+0FCgtv/A50EfKN31dYHE1XXLT4BACF6EC3lj9jtrIu5nK
KVRD9m6R1qcTOOnXAqJ9proSDYQYPIzpTx6fzkjejWHTug/4B+cUGosAPRLsoXg4
44V3rxLwvsovzxUgOchYPeHlW8JyX1V7U/fWYnDn8fIh9jYIyB3gBd0DL1xNf/0z
xJcz0tbAmqSS5PKQcPpMP123SEreIPIXSCiM6Ia/k4Rd7RQz+OHjyibv5K780esw
vQzzUvf1FtN+XS04UE538zCgmGe7g6SmpSvRoMZZl0vOjuLJhtof1msCPx5S4GmR
N80Ein+r2EhP/5GDYHcl3vmt9azikqQsaVb/gnQaNpbpg+mGpVBYm74xuXKizng5
OF/cHE9S5yjJAYj4XBxGRlHyDejCu5cDKT6P4HSWnmrIs86xyPZjv9/vTf3B+BkD
gUGnUI4PNmxwcQjAFqM2arwojkLUoP7jADB7dl+3Pdz5C6794Ox4HnGzqtivHOqN
YN3Qqo+qEURtk8rkAKuR0kgFXCd005hbGitUd8i9/rx9C/lfQHU=
=XbAv
-----END PGP SIGNATURE-----

--Apple-Mail=_C6030077-19CF-44C5-BF41-1402E4D9280E--
