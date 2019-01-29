Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E781C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACB92175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="AlRt/AV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfA2PDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:03:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39203 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfA2PDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so16221317edt.6
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lLNnP59ZMU3ebsUNLsii3VqQKotAHHQp8+DgKYtWu4A=;
        b=AlRt/AV8DPk/GkbJhW3JVwliJz6wMLfXAYZ1t/6d5XomNy0W9peEbMwk8dQ6XUPQdC
         vZAaQq/KgrDvbo6sCa8aSsHrKfMDtntsiGql5xvEB6fBU3s8zoph/yZfXMxaErHDeoIX
         dlJ4t0+7W16OrV0Cf7i+UyGdxbBraHB3Bqdwg09F9er4xS7HcKKAvSr5/2H5ooXLHU6U
         DzlnstuQvUwupdO6ZbatFZrSGignFUjdy8M00veSHeSVFnlkjVzlSwNZtMjRNYyy3Yai
         GProIb8HSai12OEimcCHidIdRftP/5Uf1okXFF0CucQb5pvV5UKHkBisJ/5zWVMbBlqo
         uZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lLNnP59ZMU3ebsUNLsii3VqQKotAHHQp8+DgKYtWu4A=;
        b=aCw2GI5vy1+v4L0LAsJpVP+xkjvVZebPGOjN8ZL8xWldbdDjgIo26H19hpyABeEacn
         Pzr0g5tjGbv3dHpegIjr3hPZ+hsjlRv0qWhImH4nHaJvWq810ScdggNLvfNouKjA+WpE
         vpphX6LfvSWa8OWb/xXLzSdVu2cvWGxRkrnxWXh+9j8mWWNFAXucXKjVwHSkh0UA9L9V
         EE7TmMirjRxbdEbM1AS8N+S/bnniO46/gHbnvpJG+GLWiR4AD3l/qbbkP+womezMZNbE
         m9XdsDKxdR/HmE8i+znQljPI4NNhtIiY4FBccnIYATNV8FLNu460pDtXE8ihgmegqET3
         NKiQ==
X-Gm-Message-State: AJcUukfhco4PcAh9K0a5eDAz9WhSXV6NhOYzLkrxWyG5GzTxWi7FIqZ2
        d+n+thxHYggebnXQIDRdH3nJLQ==
X-Google-Smtp-Source: ALg8bN7uL2pbIbKVGD3bHvVfiHmRupItE3Jo2ZOdFG8JPN+U/Tlb7hScYwZ66XLwHc/uDG1ibBd8iA==
X-Received: by 2002:a17:906:8596:: with SMTP id v22mr11194643ejx.41.1548774192229;
        Tue, 29 Jan 2019 07:03:12 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id g20sm13818584edr.47.2019.01.29.07.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:11 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <74C79F4D-E9B0-4F47-ACF2-9335D3DB8604@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B56FF616-9AA0-41B6-928E-5C7C656C2C5B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: extend line wp balance check
Date:   Tue, 29 Jan 2019 16:03:10 +0100
In-Reply-To: <CANr-nt34gCrRWsNrAfKS1Opy=kV5EwuR_C1VDjQbBP5MnfdgpA@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190129084737.718-1-hans@owltronix.com>
 <FDFE70E2-CA70-456F-8507-94BF822BF9A7@javigon.com>
 <CANr-nt34gCrRWsNrAfKS1Opy=kV5EwuR_C1VDjQbBP5MnfdgpA@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_B56FF616-9AA0-41B6-928E-5C7C656C2C5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jan 2019, at 13.49, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Tue, Jan 29, 2019 at 12:19 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 29 Jan 2019, at 09.47, hans@owltronix.com wrote:
>>>=20
>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>=20
>>> pblk stripes writes of minimal write size across all non-offline =
chunks
>>> in a line, which means that the maximum write pointer delta should =
not
>>> exceed the minimal write size. Extend the line write pointer balance =
check
>>> to cover this case.
>>>=20
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> ---
>>>=20
>>> This patch applies on top of Zhoujie's V3 of
>>> "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
>>>=20
>>> drivers/lightnvm/pblk-recovery.c | 60 =
++++++++++++++++++++------------
>>> 1 file changed, 37 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>> index 02d466e6925e..d86f580036d3 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk =
*pblk, struct pblk_line *line)
>>>      return (distance > line->left_msecs) ? line->left_msecs : =
distance;
>>> }
>>>=20
>>> -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
>>> -                                   struct pblk_line *line)
>>> +/* Return a chunk belonging to a line by stripe(write order) index =
*/
>>> +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk =
*pblk,
>>> +                                               struct pblk_line =
*line,
>>> +                                               int index)
>>> {
>>>      struct nvm_tgt_dev *dev =3D pblk->dev;
>>>      struct nvm_geo *geo =3D &dev->geo;
>>> -     struct pblk_line_meta *lm =3D &pblk->lm;
>>>      struct pblk_lun *rlun;
>>> -     struct nvm_chk_meta *chunk;
>>>      struct ppa_addr ppa;
>>> -     u64 line_wp;
>>> -     int pos, i, bit;
>>> +     int pos;
>>>=20
>>> -     bit =3D find_first_zero_bit(line->blk_bitmap, =
lm->blk_per_line);
>>> -     if (bit >=3D lm->blk_per_line)
>>> -             return 0;
>>> -     rlun =3D &pblk->luns[bit];
>>> +     rlun =3D &pblk->luns[index];
>>>      ppa =3D rlun->bppa;
>>>      pos =3D pblk_ppa_to_pos(geo, ppa);
>>> -     chunk =3D &line->chks[pos];
>>>=20
>>> -     line_wp =3D chunk->wp;
>>> +     return &line->chks[pos];
>>> +}
>>>=20
>>> -     for (i =3D bit + 1; i < lm->blk_per_line; i++) {
>>> -             rlun =3D &pblk->luns[i];
>>> -             ppa =3D rlun->bppa;
>>> -             pos =3D pblk_ppa_to_pos(geo, ppa);
>>> -             chunk =3D &line->chks[pos];
>>> +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
>>> +                                   struct pblk_line *line)
>>> +{
>>> +     struct pblk_line_meta *lm =3D &pblk->lm;
>>> +     int blk_in_line =3D lm->blk_per_line;
>>> +     struct nvm_chk_meta *chunk;
>>> +     u64 max_wp, min_wp;
>>> +     int i;
>>>=20
>>> -             if (chunk->state & NVM_CHK_ST_OFFLINE)
>>> -                     continue;
>>> +     i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
>>> +
>>> +     /* If there is one or zero good chunks in the line,
>>> +      * the write pointers can't be unbalanced.
>>> +      */
>>> +     if (i >=3D (blk_in_line - 1))
>>> +             return 0;
>>>=20
>>> -             if (chunk->wp > line_wp)
>>> +     chunk =3D pblk_get_stripe_chunk(pblk, line, i);
>>> +     max_wp =3D chunk->wp;
>>> +     if (max_wp > pblk->max_write_pgs)
>>> +             min_wp =3D max_wp - pblk->max_write_pgs;
>>> +     else
>>> +             min_wp =3D 0;
>>> +
>>> +     i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + =
1);
>>> +     while (i < blk_in_line) {
>>> +             chunk =3D pblk_get_stripe_chunk(pblk, line, i);
>>> +             if (chunk->wp > max_wp || chunk->wp < min_wp)
>>>                      return 1;
>>> -             else if (chunk->wp < line_wp)
>>> -                     line_wp =3D chunk->wp;
>>> +
>>> +             i =3D find_next_zero_bit(line->blk_bitmap, =
blk_in_line, i + 1);
>>>      }
>>>=20
>>>      return 0;
>>> @@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>>      int ret;
>>>      u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - =
lm->smeta_sec;
>>>=20
>>> -     if (pblk_line_wp_is_unbalanced(pblk, line))
>>> +     if (pblk_line_wps_are_unbalanced(pblk, line))
>>>              pblk_warn(pblk, "recovering unbalanced line (%d)\n", =
line->id);
>>>=20
>>>      ppa_list =3D p.ppa_list;
>>> --
>>> 2.17.1
>>=20
>> If I am understanding correctly, you want to protect against the case
>> where a pfail has broken the ws_min partition of a chunk, right? I =
say
>> this because there is a guarantee that the minimal write size and =
pblk's
>> write size align with ws_min and ws_opt. Even if we have grown bad
>> blocks on pfail for the current line (which is a bigger problem =
because
>> we have potentially lost data), this guarantee would remain.
>>=20
>> If this is the case, my first reaction would be to say that the
>> controller is responsible for guaranteeing atomicity for both scalar =
and
>> vector I/Os. If this is not guaranteed, we have bigger problems than
>> this (e.g., for the write error recovery path).
>>=20
>> Are you thinking of a different case?
>=20
> The write pointer check triggers a warning if something unexpected has
> happened to the chunks.
> i.e. if something else than pblk messed with the disk, or if the user
> tries to recover a pblk instance with an invalid lun configuration.

But this will only solve a very specific corner case of this, right?
This is, when you are writing at WP on a middle LUN exactly < ws_min.

For example, If the user attempts to start pblk with a different LUN
configuration, the alignment is the same an pblk will actually fail
because it cannot find any emeta.

For completion, the original wp_unbalanced patch attempted to protect
against the case where several outstanding I/Os to different PUs are
inflight and then you have a pfail. In this case, a write to a PU that
is not "next" in the line bitmap completes and we have a whole, meaning
that if we recover this case, we risk to overwrite valid data, as we
break the "sequentiality" the line, which allows for recovering by
replaying the P2L stored on the OOB.

>=20
> This patch adds a warning if a chunk wp is too small(i.e. if a chunk
> was unexpectedly reset)

I am not arguing against the implementation, I am just trying to
understand what you are trying to fix. If it is the case I described
originally, then I do not think it is possible on the Open-Channel
architecture. If you want to add protection against corruptions, then
this needs more work as many corruption cases are missing - you would
need something like a OOB watermark to protect open lines and something
like a OOB lba CRC check in emeta to validate that no data has been
altered.

If you ask me, I do not think the latter belongs to pblk, and if it did,
I would suggest a whole new (optional) feature that adds this short of
integrity protection, ideally, reusing NVMe PI. In the original pblk, we
have followed the same assumption as block devices do; you can go an
write on the side to a block device that has a FS on top; the block
device will not complain at all - if the FS detects this then they will
try to fix it, otherwise you lost data.

In this context, we have discussed about a pblk tool a la fsck, which =
can
cover all this cases instead of adding more complexity to the recovery
path in the kernel. Here, you patch makes sense we fail if something
suspicious has occurred and move the burden to the pblk tool for it to
do the repair. But again, if the goal s adding integrity protection, it
needs to cover the rest of the cases.

Hope this makes sense.

Javier

--Apple-Mail=_B56FF616-9AA0-41B6-928E-5C7C656C2C5B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQay4ACgkQPEYBfS0l
eOCurg//UlDMZi3CYYX0XmXUWY93+zHkBY3+/z0jZE5aPXSugFpnVxMxGnpltV9s
VjHdLRms3F46gGv/7LI6zDXF1yJws6RtmWEMg6Ja9538Xjmy4UFNQmZii6rZQpf8
2WziLvNwJDWFY+E6dA14EJwwsJeerrPHmkOEypiUMtZipl6ehFkVVHZMve/fm84A
ihSzhcewbvDxaaCvjJqUStO/zQJxYhpXkdN2E2WmpjQq6styeRsT5a0bmQj2tYiI
/3pJDTK2v3vdIIr2Vm03eEFx/IBqFjY67K85S2Udf98GYy8EAVtHNqwTLrK83N/k
d/g3TuvkiE7OTsPVtzXGjNi/8eodngegeJp4nNlMqOi65CHvgh1VMp6HjeidLDhR
ow3hYNvhO1+7jaHoiw/+/6EC2hnoH09D46o4b0W2OspLOIQ8LlJIKitRUmWeKYz9
z8kkfG0/7Js846Fc8kLs+EpwEQ9m1XSaGppno5pMSRlfXa3BP97o/o4BztytU7BD
X4RwaSC/Rak681/98XeSrup2WMamL2WbCbUIK1u9uXeJjTi9+TO22KFcg+QyBC5j
tI9EboHVl2zC8VOwstu0CitMX7mApu6YNEwyWAy9wYsJbrIlzmUdradbkkamPkYK
yyzF6LXoSQs+g/sVFBkhvBV5dn6KtlV2AdzSGthgrv8U+M2vWD4=
=mJEK
-----END PGP SIGNATURE-----

--Apple-Mail=_B56FF616-9AA0-41B6-928E-5C7C656C2C5B--
