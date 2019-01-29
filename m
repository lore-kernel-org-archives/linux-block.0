Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CCC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16A72087F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Cmep03OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfA2SXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:23:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36193 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfA2SXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:23:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so16799937edb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7gLPS/1p5tg5SRzgfM9rDXpyTb7NzmR0Zr5w+AqikfU=;
        b=Cmep03OY2THyk7O1524MWErCjXA++I/Lv/ozr/N3mGsyF1d8qY/4zk65/Q2BMXFItx
         avkfVpRnQaic8RdJTEZuMn33ERJsVejQ5vkVVYhzZGS/D9TYRlXZ7sImTmmyQJYIxYOa
         SWtkQUNTMt0URwQPXjSBNvbz+38/iAqIK2XSS3m3+ZnHB/a6PdSwd4OCOTqRzBmvilXE
         SPF+cXOpewzVWCKYW+5IvKKAhO7/gSJ8G52xj6F0nfLXmsHi6CWsqJzOid3cIu3AH88v
         N/JHP+KELDV0xB/8pzWPnE84AK2XiXkszrhL32QlNVb2Lcsstz2EJT0EMb+MFWA1mTgv
         AJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7gLPS/1p5tg5SRzgfM9rDXpyTb7NzmR0Zr5w+AqikfU=;
        b=SC3ghwRtkHRNm/HkvXz9ACk6kXAS2csGIY7cJrR/ToPBCucivtSQ+mWo0hksEzGJOL
         O+9qvloxs/O0LqokIj59lB81/a3zMpKg9AWPMdoEhHoMNuMXBcbIt5SMXvJ1Z/VNVm4H
         oE1meYC/6IF6IOgxc4kGrZq0OMlZLitPcawMS0xm1OFtL/rog9LylHpyxw2+Kzkr+0kQ
         e5X61dcmfPUCDxeXLn9sd4DdPxgYa2Dm1C8zWRtxo3M7WGcr66umUGSgbQBUkCwePU0f
         dvlBeTJAz1keP4xi54uxFT51pHCf2RQ7BTWBKQNEWfj9IpPxsf8vDTVtBa/JM6iMQD36
         D3wg==
X-Gm-Message-State: AJcUukdK5icDrgZoEj2IxGhUdsU8DfE6UO0/ZroD77uECxu9eiaebZhH
        nsQIfylroFSPmFOxpVKqBuMqtw==
X-Google-Smtp-Source: ALg8bN66ONU96lXSqNGih8Ac+KgF7ZcMe9E07uYkW9yivemq5L0TEo8U6rlct4YxvJL5u+UV2j66LQ==
X-Received: by 2002:a50:8343:: with SMTP id 61mr26631613edh.154.1548786217771;
        Tue, 29 Jan 2019 10:23:37 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id k12sm2766107ejz.4.2019.01.29.10.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:23:37 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <D127CDFC-4149-464D-814A-7372D099EABA@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EB6DDAB9-FF68-40A2-B548-F59E019FFF60";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: extend line wp balance check
Date:   Tue, 29 Jan 2019 19:23:36 +0100
In-Reply-To: <CANr-nt3K3OWRoe9jHT0fJWZdSBTmiro4KERTNPu9CDiZB8QgAw@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190129084737.718-1-hans@owltronix.com>
 <FDFE70E2-CA70-456F-8507-94BF822BF9A7@javigon.com>
 <CANr-nt34gCrRWsNrAfKS1Opy=kV5EwuR_C1VDjQbBP5MnfdgpA@mail.gmail.com>
 <74C79F4D-E9B0-4F47-ACF2-9335D3DB8604@javigon.com>
 <CANr-nt3K3OWRoe9jHT0fJWZdSBTmiro4KERTNPu9CDiZB8QgAw@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_EB6DDAB9-FF68-40A2-B548-F59E019FFF60
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jan 2019, at 16.49, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Tue, Jan 29, 2019 at 4:03 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 29 Jan 2019, at 13.49, Hans Holmberg <hans@owltronix.com> wrote:
>>>=20
>>> On Tue, Jan 29, 2019 at 12:19 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>> On 29 Jan 2019, at 09.47, hans@owltronix.com wrote:
>>>>>=20
>>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>>=20
>>>>> pblk stripes writes of minimal write size across all non-offline =
chunks
>>>>> in a line, which means that the maximum write pointer delta should =
not
>>>>> exceed the minimal write size. Extend the line write pointer =
balance check
>>>>> to cover this case.
>>>>>=20
>>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>> ---
>>>>>=20
>>>>> This patch applies on top of Zhoujie's V3 of
>>>>> "lightnvm: pblk: ignore bad block wp for =
pblk_line_wp_is_unbalanced
>>>>>=20
>>>>> drivers/lightnvm/pblk-recovery.c | 60 =
++++++++++++++++++++------------
>>>>> 1 file changed, 37 insertions(+), 23 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>>>> index 02d466e6925e..d86f580036d3 100644
>>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>>> @@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk =
*pblk, struct pblk_line *line)
>>>>>     return (distance > line->left_msecs) ? line->left_msecs : =
distance;
>>>>> }
>>>>>=20
>>>>> -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
>>>>> -                                   struct pblk_line *line)
>>>>> +/* Return a chunk belonging to a line by stripe(write order) =
index */
>>>>> +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk =
*pblk,
>>>>> +                                               struct pblk_line =
*line,
>>>>> +                                               int index)
>>>>> {
>>>>>     struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>>     struct nvm_geo *geo =3D &dev->geo;
>>>>> -     struct pblk_line_meta *lm =3D &pblk->lm;
>>>>>     struct pblk_lun *rlun;
>>>>> -     struct nvm_chk_meta *chunk;
>>>>>     struct ppa_addr ppa;
>>>>> -     u64 line_wp;
>>>>> -     int pos, i, bit;
>>>>> +     int pos;
>>>>>=20
>>>>> -     bit =3D find_first_zero_bit(line->blk_bitmap, =
lm->blk_per_line);
>>>>> -     if (bit >=3D lm->blk_per_line)
>>>>> -             return 0;
>>>>> -     rlun =3D &pblk->luns[bit];
>>>>> +     rlun =3D &pblk->luns[index];
>>>>>     ppa =3D rlun->bppa;
>>>>>     pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>> -     chunk =3D &line->chks[pos];
>>>>>=20
>>>>> -     line_wp =3D chunk->wp;
>>>>> +     return &line->chks[pos];
>>>>> +}
>>>>>=20
>>>>> -     for (i =3D bit + 1; i < lm->blk_per_line; i++) {
>>>>> -             rlun =3D &pblk->luns[i];
>>>>> -             ppa =3D rlun->bppa;
>>>>> -             pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>> -             chunk =3D &line->chks[pos];
>>>>> +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
>>>>> +                                   struct pblk_line *line)
>>>>> +{
>>>>> +     struct pblk_line_meta *lm =3D &pblk->lm;
>>>>> +     int blk_in_line =3D lm->blk_per_line;
>>>>> +     struct nvm_chk_meta *chunk;
>>>>> +     u64 max_wp, min_wp;
>>>>> +     int i;
>>>>>=20
>>>>> -             if (chunk->state & NVM_CHK_ST_OFFLINE)
>>>>> -                     continue;
>>>>> +     i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
>>>>> +
>>>>> +     /* If there is one or zero good chunks in the line,
>>>>> +      * the write pointers can't be unbalanced.
>>>>> +      */
>>>>> +     if (i >=3D (blk_in_line - 1))
>>>>> +             return 0;
>>>>>=20
>>>>> -             if (chunk->wp > line_wp)
>>>>> +     chunk =3D pblk_get_stripe_chunk(pblk, line, i);
>>>>> +     max_wp =3D chunk->wp;
>>>>> +     if (max_wp > pblk->max_write_pgs)
>>>>> +             min_wp =3D max_wp - pblk->max_write_pgs;
>>>>> +     else
>>>>> +             min_wp =3D 0;
>>>>> +
>>>>> +     i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + =
1);
>>>>> +     while (i < blk_in_line) {
>>>>> +             chunk =3D pblk_get_stripe_chunk(pblk, line, i);
>>>>> +             if (chunk->wp > max_wp || chunk->wp < min_wp)
>>>>>                     return 1;
>>>>> -             else if (chunk->wp < line_wp)
>>>>> -                     line_wp =3D chunk->wp;
>>>>> +
>>>>> +             i =3D find_next_zero_bit(line->blk_bitmap, =
blk_in_line, i + 1);
>>>>>     }
>>>>>=20
>>>>>     return 0;
>>>>> @@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>>>>     int ret;
>>>>>     u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - =
lm->smeta_sec;
>>>>>=20
>>>>> -     if (pblk_line_wp_is_unbalanced(pblk, line))
>>>>> +     if (pblk_line_wps_are_unbalanced(pblk, line))
>>>>>             pblk_warn(pblk, "recovering unbalanced line (%d)\n", =
line->id);
>>>>>=20
>>>>>     ppa_list =3D p.ppa_list;
>>>>> --
>>>>> 2.17.1
>>>>=20
>>>> If I am understanding correctly, you want to protect against the =
case
>>>> where a pfail has broken the ws_min partition of a chunk, right? I =
say
>>>> this because there is a guarantee that the minimal write size and =
pblk's
>>>> write size align with ws_min and ws_opt. Even if we have grown bad
>>>> blocks on pfail for the current line (which is a bigger problem =
because
>>>> we have potentially lost data), this guarantee would remain.
>>>>=20
>>>> If this is the case, my first reaction would be to say that the
>>>> controller is responsible for guaranteeing atomicity for both =
scalar and
>>>> vector I/Os. If this is not guaranteed, we have bigger problems =
than
>>>> this (e.g., for the write error recovery path).
>>>>=20
>>>> Are you thinking of a different case?
>>>=20
>>> The write pointer check triggers a warning if something unexpected =
has
>>> happened to the chunks.
>>> i.e. if something else than pblk messed with the disk, or if the =
user
>>> tries to recover a pblk instance with an invalid lun configuration.
>>=20
>> But this will only solve a very specific corner case of this, right?
>> This is, when you are writing at WP on a middle LUN exactly < ws_min.
>>> For example, If the user attempts to start pblk with a different LUN
>> configuration, the alignment is the same an pblk will actually fail
>> because it cannot find any emeta.
>=20
> Well, we will try to recover a line if the emeta data cannot be read
> or the data fails the crc check, and the recovery path assumes that
> the write pointers pointers have been incremented in the pblk stripe
> order. We'll get a warning now for all cases if this assumption is not
> valid.
>=20
>> For completion, the original wp_unbalanced patch attempted to protect
>> against the case where several outstanding I/Os to different PUs are
>> inflight and then you have a pfail. In this case, a write to a PU =
that
>> is not "next" in the line bitmap completes and we have a whole, =
meaning
>> that if we recover this case, we risk to overwrite valid data, as we
>> break the "sequentiality" the line, which allows for recovering by
>> replaying the P2L stored on the OOB.
>=20
> For outstanding writes, we can leave no guarantees anyway. If a
> presync was attached to a bio, that bio will complete when the write
> completes.
>=20
>>> This patch adds a warning if a chunk wp is too small(i.e. if a chunk
>>> was unexpectedly reset)
>>=20
>> I am not arguing against the implementation, I am just trying to
>> understand what you are trying to fix. If it is the case I described
>> originally, then I do not think it is possible on the Open-Channel
>> architecture. If you want to add protection against corruptions, then
>> this needs more work as many corruption cases are missing - you would
>> need something like a OOB watermark to protect open lines and =
something
>> like a OOB lba CRC check in emeta to validate that no data has been
>> altered.
>>=20
>> If you ask me, I do not think the latter belongs to pblk, and if it =
did,
>> I would suggest a whole new (optional) feature that adds this short =
of
>> integrity protection, ideally, reusing NVMe PI. In the original pblk, =
we
>> have followed the same assumption as block devices do; you can go an
>> write on the side to a block device that has a FS on top; the block
>> device will not complain at all - if the FS detects this then they =
will
>> try to fix it, otherwise you lost data.
>>=20
>> In this context, we have discussed about a pblk tool a la fsck, which =
can
>> cover all this cases instead of adding more complexity to the =
recovery
>> path in the kernel. Here, you patch makes sense we fail if something
>> suspicious has occurred and move the burden to the pblk tool for it =
to
>> do the repair. But again, if the goal s adding integrity protection, =
it
>> needs to cover the rest of the cases.
>>=20
>> Hope this makes sense.
>=20
> It does! I'm not trying to do anything more than warn if the write
> pointers are not what we expect them to be.
>=20
> You're right, we need some sort of superblock and some recovery tool
> to make pblk more robust against corruptions.
> Now, we get a warning at least :)

Sounds good! Now I understand.

It is good for me to apply the patch then.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>



--Apple-Mail=_EB6DDAB9-FF68-40A2-B548-F59E019FFF60
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQmigACgkQPEYBfS0l
eODRYxAAuzWiYb+rYNOmd9z4WJO96wKlg0u5k+5HuQ3qt6SxtJBLL9g7s4jWOhSO
bdY5dKe0Gd/ZQ17TLXv2urDAeK7zJGWs7WaNh/+zpL0ItQf608auCQzdia7clYsp
qF4kY7ca85aaLAn79IFyvs3XoqT3xhfRiykQfJV8UDgz/T/7a7va+bOtuApjCUoh
jND4HZF0yktOnq9ur2cBjhozr4VHsGUd4baBlyeX4jw8kHyzlCFUL2Dnp4mPTpzp
u+VmCBQ9h6KkqldbvNDRmzaGVQcJFiQPiGWizELOuM7lneDPzuTAGZsZQ3427XL1
yS8dv7/lNLtx7D7OgbHIU1dIFwfGFISvJAOeugkV9bf1wRHxgVs3RB/ImC3TqX3d
1exCrAQAA2pSEHSCX2ZEuWzeGvOh73YzH2MnnWc+x6b+enDdeNLtiil73zZ3Km+L
1ikhfjJQ4UDxhrdOZaDMJ/lAHZOTmFijL1BSvoc969P6Y+YejL5j6jLku14B3Hpy
ZyAamcIIFccTiuaXeT6NhTfnjLnQ/fGOTmZUnXdVp3/2MqfHLrYPS+SzNHcPeJQo
sjlrBK+D7H+ym8LzBhEK/u1yeN5YbtoMTEaiBCN+2EGL+JW8Sxd6o80+o8OP+bxO
AWa6mO42LsAM1FKUDtTlhn/pNG+95IU+ONihkUdxlyz7Wfk1kzc=
=4Dyg
-----END PGP SIGNATURE-----

--Apple-Mail=_EB6DDAB9-FF68-40A2-B548-F59E019FFF60--
