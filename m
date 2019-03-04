Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75A8C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB43205C9
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="txgRQ0Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCDO1c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:27:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39865 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfCDO1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 09:27:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so4385998edc.6
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=3lRK7HYjvjIoB+SeW4DmdnTk4ZfZK40LeM8J50BTqm8=;
        b=txgRQ0CwYrFo9LS75ezr+QPGPzvRNM73GRwM6iafrZtbn14tXfshti8vNYyyOz3V0V
         kA7DNnJxpmEGRE/KeVKzAOszPpXmzkZRFWeRGhPFVIrLirrqyECKYtdh14VEsWQ0Vk21
         dx2DSdBMeJnUg2yWhPqv57P36PMhMo3iBRSlnfrcBSrBHhMnxkR3En8/HIMX1Dwcodgt
         Gwkhl9jJFsuGH51dRyqHTmjRg8l+Dg+0u+EosvQAHaukdPE8mAj5a9i6fRPatmiS0hIj
         dJIGgWF+35hgWP9IsEJYJEPbUuLoQbGYA/JQTMEfL/4c4IepmGIYe4ow/f1AFCXSR7j6
         8www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=3lRK7HYjvjIoB+SeW4DmdnTk4ZfZK40LeM8J50BTqm8=;
        b=TYkxtyIMWWEJHecYRcXJkpX5nOWysiYhK+SxptBcZH1f6dHfF7MTZSBP8FfESmsKti
         Ptkq8Th+ZEtvUTdJ8pSMck4RJbUtvhaqXtdFo4y61zk/8bNwiwr8x9v5YnuaRfQWMyWm
         hls6e6lopj5YB+W22bvr7VKiuAkjA78MS+u+OennAUAK3t7vgfU/DlUkYpTVDr/A9g5G
         PET0Diyb8gRzsxnSdtUqZSHHqRLWm3JlTtv9cTZE2Bj9K8XI4eAEW/4qyKRjV/IAZcXP
         YxCfO/8goYsdgTUsaRcUF19Nvwx4x1mesVokMZI2dd6l2g86eYKDxQe1a14sKI1jFvvn
         kU8Q==
X-Gm-Message-State: APjAAAUFBCEoa2mKgezscoW7Q4aSl71hHGAF1Ua1hi5FbWYGMCj3egq+
        Fe4IZA4HQRs+Imi3pAQNLMGHMg==
X-Google-Smtp-Source: APXvYqy1yK5l04TtCShBUcEjwTNqQReXrJUhLHTYZ4vd53SrwreIHJKSDCCQsUzc9elDBrUbNQ6T3Q==
X-Received: by 2002:a50:b646:: with SMTP id c6mr15797115ede.149.1551709650064;
        Mon, 04 Mar 2019 06:27:30 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id w24sm2150553edb.72.2019.03.04.06.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:27:29 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <4D8553F1-6058-4F0F-AB48-19FABB8A2A6A@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F8EE64B9-5207-4E6D-9064-B53DC5CE1C00";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
Date:   Mon, 4 Mar 2019 15:27:28 +0100
In-Reply-To: <CANr-nt2TYvJyL-fcELt3SCMkZjV8jkmye27wtThjrPRaTJiXiQ@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Simon Andreas Frimann Lund <slund@cnexlabs.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com>
 <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
 <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
 <54D42A19-96EE-4370-B957-A474BB912530@javigon.com>
 <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
 <CDD16047-68EF-43EA-A33B-11279A4301E6@javigon.com>
 <c6fbb977-bfde-d76d-cc4f-198a732d38d0@lightnvm.io>
 <EA36DDD6-5A3D-4F5C-9B18-53E266EB676F@javigon.com>
 <CANr-nt2TYvJyL-fcELt3SCMkZjV8jkmye27wtThjrPRaTJiXiQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_F8EE64B9-5207-4E6D-9064-B53DC5CE1C00
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4 Mar 2019, at 15.24, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Mon, Mar 4, 2019 at 2:44 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 4 Mar 2019, at 14.25, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 3/4/19 2:19 PM, Javier Gonz=C3=A1lez wrote:
>>>>> On 4 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>>>>>=20
>>>>> On Mon, Mar 4, 2019 at 12:44 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> =
wrote:
>>>>>>>=20
>>>>>>> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>>>>>>>=20
>>>>>>>>> Current lightnvm and pblk implementation does not care
>>>>>>>>> about NVMe max data transfer size, which can be smaller
>>>>>>>>> than 64*K=3D256K. This patch fixes issues related to that.
>>>>>>>=20
>>>>>>> Could you describe *what* issues you are fixing?
>>>>>>>=20
>>>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>>>> ---
>>>>>>>>> drivers/lightnvm/core.c      | 9 +++++++--
>>>>>>>>> drivers/nvme/host/lightnvm.c | 1 +
>>>>>>>>> include/linux/lightnvm.h     | 1 +
>>>>>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>>>>>> index 5f82036fe322..c01f83b8fbaf 100644
>>>>>>>>> --- a/drivers/lightnvm/core.c
>>>>>>>>> +++ b/drivers/lightnvm/core.c
>>>>>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev =
*dev, struct nvm_ioctl_create *create)
>>>>>>>>>    struct nvm_target *t;
>>>>>>>>>    struct nvm_tgt_dev *tgt_dev;
>>>>>>>>>    void *targetdata;
>>>>>>>>> +     unsigned int mdts;
>>>>>>>>>    int ret;
>>>>>>>>>=20
>>>>>>>>>    switch (create->conf.type) {
>>>>>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev =
*dev, struct nvm_ioctl_create *create)
>>>>>>>>>    tdisk->private_data =3D targetdata;
>>>>>>>>>    tqueue->queuedata =3D targetdata;
>>>>>>>>>=20
>>>>>>>>> -     blk_queue_max_hw_sectors(tqueue,
>>>>>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>>>>>> +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>>>>>>>> +     if (dev->geo.mdts) {
>>>>>>>>> +             mdts =3D min_t(u32, dev->geo.mdts,
>>>>>>>>> +                             (dev->geo.csecs >> 9) * =
NVM_MAX_VLBA);
>>>>>>>>> +     }
>>>>>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>>>>>>>=20
>>>>>>>>>    set_capacity(tdisk, tt->capacity(targetdata));
>>>>>>>>>    add_disk(tdisk);
>>>>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>>>>> index b759c25c89c8..b88a39a3cbd1 100644
>>>>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, =
char *disk_name, int node)
>>>>>>>>>    geo->csecs =3D 1 << ns->lba_shift;
>>>>>>>>>    geo->sos =3D ns->ms;
>>>>>>>>>    geo->ext =3D ns->ext;
>>>>>>>>> +     geo->mdts =3D ns->ctrl->max_hw_sectors;
>>>>>>>>>=20
>>>>>>>>>    dev->q =3D q;
>>>>>>>>>    memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>>>>>> diff --git a/include/linux/lightnvm.h =
b/include/linux/lightnvm.h
>>>>>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>>>>>>>> --- a/include/linux/lightnvm.h
>>>>>>>>> +++ b/include/linux/lightnvm.h
>>>>>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>>>>>>>    u16     csecs;          /* sector size */
>>>>>>>>>    u16     sos;            /* out-of-band area size */
>>>>>>>>>    bool    ext;            /* metadata in extended data buffer =
*/
>>>>>>>>> +     u32     mdts;           /* Max data transfer size*/
>>>>>>>>>=20
>>>>>>>>>    /* device write constrains */
>>>>>>>>>    u32     ws_min;         /* minimum write size */
>>>>>>>>> --
>>>>>>>>> 2.17.1
>>>>>>>>=20
>>>>>>>> I see where you are going with this and I partially agree, but =
none of
>>>>>>>> the OCSSD specs define a way to define this parameter. Thus, =
adding this
>>>>>>>> behavior taken from NVMe in Linux can break current =
implementations. Is
>>>>>>>> this a real life problem for you? Or this is just for NVMe =
=E2=80=9Ccorrectness=E2=80=9D?
>>>>>>>>=20
>>>>>>>> Javier
>>>>>>>=20
>>>>>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
>>>>>>>=20
>>>>>>> (figure 28):"The number of Logical Blocks (NLB): This field =
indicates
>>>>>>> the number of logical blocks to be read. This is a 0=E2=80=99s =
based value.
>>>>>>> Maximum of 64 LBAs is supported."
>>>>>>>=20
>>>>>>> You got the max limit covered, and the spec  does not say =
anything
>>>>>>> about the minimum number of LBAs to support.
>>>>>>>=20
>>>>>>> Matias: any thoughts on this?
>>>>>>>=20
>>>>>>> Javier: How would this patch break current implementations?
>>>>>>=20
>>>>>> Say an OCSSD controller that sets mdts to a value under 64 or =
does not
>>>>>> set it at all (maybe garbage). Think you can get to one pretty =
quickly...
>>>>>=20
>>>>> So we cant make use of a perfectly good, standardized, parameter
>>>>> because some hypothetical non-compliant device out there might not
>>>>> provide a sane value?
>>>> The OCSSD standard has never used NVMe parameters, so there is no
>>>> compliant / non-compliant. In fact, until we changed OCSSD 2.0 to
>>>> get the sector and OOB sizes from the standard identify
>>>> command, we used to have them in the geometry.
>>>=20
>>> What the hell? Yes it has. The whole OCSSD spec is dependent on the
>>> NVMe spec. It is using many commands from the NVMe specification,
>>> which is not defined in the OCSSD specification.
>>=20
>> First, lower the tone.
>>=20
>> Second, no, it has not and never has, starting with all the write
>> constrains, continuing with the vector commands, etc. You cannot =
choose
>> what you want to be compliant with and what you do not. OCSSD uses =
the
>> NVMe protocol but it is self sufficient with its geometry for all the
>> read / write / erase paths - it even depends on different PCIe class
>> codes to be identified=E2=80=A6 To do this in the way the rest of the =
spec is
>> defined, we either add a filed to the geometry or explicitly mention
>> that MDTS is used, as we do with the sector and metadata sizes.
>>=20
>> Third, as a maintainer of this subsystem you should care about =
devices
>> in the field that might break due to such a change (supported by the
>> company you work for or not) - even if you can argue whether the =
change
>> is compliant or not.
>>=20
>> And Hans, as a representative of a company that has such devices out
>> there, you should care too.
>=20
> If you worry about me doing my job, you need not to.
> I test. So far I have not found any regressions in this patchset.
>=20
> Please keep your open source hat on Javier.

Ok. You said it.

Then please apply the patch :)

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_F8EE64B9-5207-4E6D-9064-B53DC5CE1C00
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9NdAACgkQPEYBfS0l
eOA2DBAAi+zOzSzYU1/ahvD4n82yj1FbbS/BozDurOXhVbfeTKKcWS/1/R0JrJgK
zgpdgtzgoYRLaK0rVzBzxd6lJQhwmsdwiQQDukrrzSE4mrvkzVNlc15lK3Swczzp
H08nNltAZFQvb8eMLRjUSX2hygQyF4yg5sYdhYdBIDvdarSfmx3TkeUEWG2PluuD
GvVz2Y0wW5X84qEcCxPM8w4UArfLRmJh+mYLp0Vvp9717Gt95IugHs5dbScjzWVD
xgJ9s45bVNJkleQJwcXTof+Rm09wK/rdSvIcLuiSd0nsjtXiVEg3ju/wzMtgQ9Pe
FpkU2sKuGYhTLPO3Vfn+3quLwSEbOCm9U/q/gkn3qaYTwK1bhiPHoFnUhOyn5wrr
eYI4ZDS5HcP2+kNaDJyxeffgLWqf63tvSlPK2XGz9uK/HI/ZrsC52CXOSjSisB4s
Vu6cYchFAI2y8dd37WYYIugnxfW4dECdcsEb9wnWnXrNdDt74eNLIo/O0V5vO3it
rr6lMhPS8IhkT9/93IPC0l6Yhu6n9wroHiDdjrnDqJU7uUgCf0EoWo0pVqC6ALBv
6YNAp1B1/eywXvHVFYZzZ7plPZ+H1THLJitG1JGieGY3QWTDuNs6EZxOe+MEcVp2
DpbR3U/Ve3VhGVztcaWza7PyGfntZ97d/TtH32tbPC9h5DpuUKY=
=4tJk
-----END PGP SIGNATURE-----

--Apple-Mail=_F8EE64B9-5207-4E6D-9064-B53DC5CE1C00--
