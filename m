Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96DCC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E07F20645
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="RddZSyR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfCDNTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:19:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38786 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCDNTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:19:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so4219855edb.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hVqctcFyMYOSygaBhJxYVtYfNfUtBZj3Yhq16Aq7Z7Q=;
        b=RddZSyR6h1PnZRD7nJjm1/Ff2aka5Ji2sI0wupS60NKlcM4RzcevcAx7Uhg4RBnsH1
         pSuPbOTsLsXYZ5zvVgS5B/I1pIP3OVnTibUphkIAbJZYmApB2KbvkJZH7UujzOkc8uCK
         zUFStZLr7J+SCvL+uOmchPHWH/4KXXprfl6DjsT2VbKfAa8Rqg7NmM17zQZRS2JZXypR
         doCjdB3V6gcjdb1nYZ4fSeRaWDNmnEnA2crw7uBEraR9T2L/I6x8B6KVQF59M+rzLJQl
         8ob7SiP8wTpVu4RKIieUdkjyz8FzMXhX26sJU6GiTf1IqcFnHGjmx6mwev4YXjzSSM1z
         iZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hVqctcFyMYOSygaBhJxYVtYfNfUtBZj3Yhq16Aq7Z7Q=;
        b=n6YD560sDcsJ80CGQOiRjM1VMiuV7Lk0zp5PvPJb/2Qn9xKAaLp1eO7mxH4MW1Fh4v
         Hee0kYc/QeB8MX9l6dEPCQ8If76nrF5DP4GGwmXV7eEGqdp+8FVKOIOupOsyR03pasXT
         0o9ApO/cvhKt5b8WhxK1lePzNx9aA97+A7cXiylLU011/LYzb6IafbajtYWmbS7ENEZT
         iD9j+LeJB6NByIA5lnxn5ET++S95U4td4txWprsZ3QeATdtc7rgdinDCwuXYk2bDADt+
         QTd8IZ7eyfuFdu6GlDCrhWw3yauK2ADbvpN2Il0HaMqs1njC2u2TcsSGDXz275NtyUxa
         0CNw==
X-Gm-Message-State: APjAAAV2D6m7Wil1bElxERT4pXLiuuSrrTEeP6mzeXXjrFzBhe2Ln6KG
        ZWICj3ROYCuoMSd4lDMeFlSbXQ==
X-Google-Smtp-Source: APXvYqyvCfr5x5KoRN1iZawLZeZxf3m3cKjK8DrlvyZMQy2p0QeTo98kdE8QZ+m1YpBM/Be52rIYCA==
X-Received: by 2002:a17:906:1ec5:: with SMTP id m5mr12553920ejj.159.1551705590948;
        Mon, 04 Mar 2019 05:19:50 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id i42sm2056060eda.86.2019.03.04.05.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:19:50 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <CDD16047-68EF-43EA-A33B-11279A4301E6@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_28A62530-BBCD-4A16-B862-1520BDD7EAEB";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
Date:   Mon, 4 Mar 2019 14:19:49 +0100
In-Reply-To: <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
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
 <54D42A19-96EE-4370-B957-A474BB912530@javigon.com>
 <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_28A62530-BBCD-4A16-B862-1520BDD7EAEB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Mon, Mar 4, 2019 at 12:44 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>>>=20
>>> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>>>=20
>>>>> Current lightnvm and pblk implementation does not care
>>>>> about NVMe max data transfer size, which can be smaller
>>>>> than 64*K=3D256K. This patch fixes issues related to that.
>>>=20
>>> Could you describe *what* issues you are fixing?
>>>=20
>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>> ---
>>>>> drivers/lightnvm/core.c      | 9 +++++++--
>>>>> drivers/nvme/host/lightnvm.c | 1 +
>>>>> include/linux/lightnvm.h     | 1 +
>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>> index 5f82036fe322..c01f83b8fbaf 100644
>>>>> --- a/drivers/lightnvm/core.c
>>>>> +++ b/drivers/lightnvm/core.c
>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>>>>>     struct nvm_target *t;
>>>>>     struct nvm_tgt_dev *tgt_dev;
>>>>>     void *targetdata;
>>>>> +     unsigned int mdts;
>>>>>     int ret;
>>>>>=20
>>>>>     switch (create->conf.type) {
>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev =
*dev, struct nvm_ioctl_create *create)
>>>>>     tdisk->private_data =3D targetdata;
>>>>>     tqueue->queuedata =3D targetdata;
>>>>>=20
>>>>> -     blk_queue_max_hw_sectors(tqueue,
>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>> +     mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>>>> +     if (dev->geo.mdts) {
>>>>> +             mdts =3D min_t(u32, dev->geo.mdts,
>>>>> +                             (dev->geo.csecs >> 9) * =
NVM_MAX_VLBA);
>>>>> +     }
>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>>>=20
>>>>>     set_capacity(tdisk, tt->capacity(targetdata));
>>>>>     add_disk(tdisk);
>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>> index b759c25c89c8..b88a39a3cbd1 100644
>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
>>>>>     geo->csecs =3D 1 << ns->lba_shift;
>>>>>     geo->sos =3D ns->ms;
>>>>>     geo->ext =3D ns->ext;
>>>>> +     geo->mdts =3D ns->ctrl->max_hw_sectors;
>>>>>=20
>>>>>     dev->q =3D q;
>>>>>     memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>>>> --- a/include/linux/lightnvm.h
>>>>> +++ b/include/linux/lightnvm.h
>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>>>     u16     csecs;          /* sector size */
>>>>>     u16     sos;            /* out-of-band area size */
>>>>>     bool    ext;            /* metadata in extended data buffer */
>>>>> +     u32     mdts;           /* Max data transfer size*/
>>>>>=20
>>>>>     /* device write constrains */
>>>>>     u32     ws_min;         /* minimum write size */
>>>>> --
>>>>> 2.17.1
>>>>=20
>>>> I see where you are going with this and I partially agree, but none =
of
>>>> the OCSSD specs define a way to define this parameter. Thus, adding =
this
>>>> behavior taken from NVMe in Linux can break current =
implementations. Is
>>>> this a real life problem for you? Or this is just for NVMe =
=E2=80=9Ccorrectness=E2=80=9D?
>>>>=20
>>>> Javier
>>>=20
>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
>>>=20
>>> (figure 28):"The number of Logical Blocks (NLB): This field =
indicates
>>> the number of logical blocks to be read. This is a 0=E2=80=99s based =
value.
>>> Maximum of 64 LBAs is supported."
>>>=20
>>> You got the max limit covered, and the spec  does not say anything
>>> about the minimum number of LBAs to support.
>>>=20
>>> Matias: any thoughts on this?
>>>=20
>>> Javier: How would this patch break current implementations?
>>=20
>> Say an OCSSD controller that sets mdts to a value under 64 or does =
not
>> set it at all (maybe garbage). Think you can get to one pretty =
quickly...
>=20
> So we cant make use of a perfectly good, standardized, parameter
> because some hypothetical non-compliant device out there might not
> provide a sane value?

The OCSSD standard has never used NVMe parameters, so there is no
compliant / non-compliant. In fact, until we changed OCSSD 2.0 to
get the sector and OOB sizes from the standard identify
command, we used to have them in the geometry.

If you did not catch it in the first reference, this concern is =
explicitly
related to OCSSD controllers already out there - some of which you
should be caring about.

If we are to use this information in the future, I would advocate to
first make changes in the spec and then in the code, not the other way
around.

>=20
>>> Igor: how does this patch fix the mdts restriction? There are no
>>> checks on i.e. the gc read path that ensures that a lower limit than
>>> NVM_MAX_VLBA is enforced.
>>=20
>> This is the other part where the implementation breaks.
>=20
> No, it just does not fix it.

It is broken in _this_ implementation.

>=20
> over-and-out,
> Hans
>> Javier

--Apple-Mail=_28A62530-BBCD-4A16-B862-1520BDD7EAEB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9JfUACgkQPEYBfS0l
eOBtfxAAiZd51Xmr6+QXuAtd4lMOJDI/OmhvEi4uGTkaVdvgnlPizG/eS3Dvsrrk
+QVXdB//+VFc4Rqp/69Dllx3Rh45YYtjdYqOFgab2Hncy5e+eZANydPea8WRUkWj
KowSCB1AfPa9tm0WpcMYKsjvdo7misIuVQIo0IhmCqJjdiGsscIMj47LHrGp9HO+
l9xe7uIqtt8xsEa+HUHWVkTuGu+KOhd0k4WGYVuf7/f7v8URijH2sif8w7VNYAcu
FXoqSH32yorHZ2NaQcqLF0caJW38SE/pqFaueapl7nPztORYeevkEKDouPPikqwN
P0NKEkX1YyLg1sCR9Ul9oCRl8LCHutOT18Sg9Tz/k0qLeYU/bnCfpKL1aQygJJcD
kCeUOozYPxMd9nfY0ID9xFxlhsZ0JqBy/v5dBToVh/S8p+tzr4XFsdCdt3DXu/Pl
pJnLBauW5UDwa5gQrUbWzkRrkbNSoS6JoTpXan/PSFGMkTsM1GVcKf9ZowxtT4Vh
vymUdVoHRQg6sfveubi6QRkhRZI0AwIeDGjqTADuTuc1UKY8cB1vdxJVqhsbo0F4
FVL9XW1d6YGnIZTNDjjzEJC3Q3ruCWCV8W8joPf+LdYItHzvav9boXeSq9pAQykt
liw0ETrGd1yM6TB3XQga1Krzbq1mu8/pHtfzid7gg11LvIN7KlQ=
=5KVA
-----END PGP SIGNATURE-----

--Apple-Mail=_28A62530-BBCD-4A16-B862-1520BDD7EAEB--
