Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B881AC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73404218EA
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="sO7A/yXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfAaQdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:33:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45702 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfAaQdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 11:33:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so3170316ljd.12
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 08:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N131cBkmPO6ZG353LPw+duwBsX7Ikptu5L7e+pOYSxg=;
        b=sO7A/yXkGeFD1Am01O9hU8+VfIISfXQaHTgFI0l9eUrnN92Fz9lOuF7J2ULur+HlpD
         4LBgEl0qmm3HMTzW2kejI7HgC9Jir+cIBgT4fIcOp2JyVIIR1gG0Yq7lPCsb9gbZTZBh
         Vz7WDdjpZlnRW/P5WDE7AUJHUx5SRxwPfq3dJzQp7yBKG0b+qEohd0dmKqCpP8OG8ySY
         yO+M+tQKu5GwhKLOcARWlz4Ze/Dq97YLnf4PWUlZ7I61zpz61ODY0kx/tgHvzoCue8x3
         GSSKpiKKU24OBXqnwOccRLkvLbvO+tYc69mkFHUDy7koiZK7DGWQ66Z/qnsHAjHjQkYN
         hsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N131cBkmPO6ZG353LPw+duwBsX7Ikptu5L7e+pOYSxg=;
        b=IMcPNfe79AGFueDpmH08FIpu0YuzKEY3CsGm0zG6qFQNdG8/iBakRbbfOuE6horXEE
         pwCPidxu+aM3Yg14nxZzcH1h4mDG+NMbXfOrABz+eA34DGR5dC0xT0pCRxngSG4n+Atg
         wj62nqq0Rqc1wf5iqz6nkxANXU2z/BJ8H41hUu8pCvN5YXcAS6m0kPXFyhgdG9zuwd/A
         bklXvSG+bC+Zss8d0ZSsSCZoQnusuVdJC09aSwEPPk0GxHxmdt41Q43+QHhSTNZzlwmB
         B4H/h1KwHkIfpqdKZz/nZEt1CWj1AJu8uXTqSivwADbqj9IjiGGxpMhf8GML/+HCtPBw
         rhJw==
X-Gm-Message-State: AJcUukcKoQ3OnZkQZD7FOAdFf5ZtXezMuI/wOTbmzexPkkyEXJYa5U8W
        yfoIO4lS5VcFE7vQzkk1YcJfhA==
X-Google-Smtp-Source: ALg8bN7JowjjguFPEuZaECo/3dxpqSYmHdlLdwZ4FWcXBb4YUf/jWVAIaEHifW5N6emPMsVCEZhLWg==
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr28314515ljh.135.1548952389191;
        Thu, 31 Jan 2019 08:33:09 -0800 (PST)
Received: from [100.111.108.164] (77.241.128.248.mobile.3.dk. [77.241.128.248])
        by smtp.gmail.com with ESMTPSA id 18-v6sm852276ljg.83.2019.01.31.08.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 08:33:08 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2] lightnvm: pblk: prevent stall due to wb threshold
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CANr-nt27moc9eLMgXkoXQGR7GA=uRpg2u+v7aJxzNB_AGbw5hQ@mail.gmail.com>
Date:   Thu, 31 Jan 2019 16:33:06 +0000
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4DF0FFC-5A45-405D-A942-DD8572CC1BD1@javigon.com>
References: <20190130102604.14496-1-javier@javigon.com> <CANr-nt27moc9eLMgXkoXQGR7GA=uRpg2u+v7aJxzNB_AGbw5hQ@mail.gmail.com>
To:     Hans Holmberg <hans@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 31 Jan 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> Hi Javier!
>=20
> How did you test this? I'm trying to add a test case to our testing framew=
ork.
>=20
> This is what i ran in qemu, and I got a hang (with this version of the pat=
ch)
>=20
> nvme lnvm create -d nvme0n1 -t pblk -n pblk0 -f -b 0 -e 0

I run several low configurations without problem. Can you share the qemu con=
figuration and version?

I=E2=80=99m on travel until Friday - I=E2=80=99ll come back to you over the w=
eekend.=20

>=20
> kernel log: [  116.381799] pblk pblk0: luns:1, lines:280, secs:212736,
> buf entries:128
>=20
> # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D4k count=3D1
> 1+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000480941 s, 8.5 MB/s
> # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D64k count=3D1
> 1+0 records in
> 1+0 records out
> 65536 bytes (66 kB, 64 KiB) copied, 0.000477373 s, 137 MB/s
> # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D128k count=3D1
> 1+0 records in
> 1+0 records out
> 131072 bytes (131 kB, 128 KiB) copied, 0.000548722 s, 239 MB/s
> # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D256k count=3D1
> 1+0 records in
> 1+0 records out
> 262144 bytes (262 kB, 256 KiB) copied, 0.000718515 s, 365 MB/s
> # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D512k count=3D1
> <HANG>


>=20
>=20
>> On Wed, Jan 30, 2019 at 11:28 AM Javier Gonz=C3=A1lez <javier@javigon.com=
> wrote:
>>=20
>> In order to respect mw_cuinits, pblk's write buffer maintains a
>> backpointer to protect data not yet persisted; when writing to the write
>> buffer, this backpointer defines a threshold that pblk's rate-limiter
>> enforces.
>>=20
>> On small PU configurations, the following scenarios might take place: (i)=

>> the threshold is larger than the write buffer and (ii) the threshold is
>> smaller than the write buffer, but larger than the maximun allowed
>> split bio - 256KB at this moment (Note that writes are not always
>> split - we only do this when we the size of the buffer is smaller
>> than the buffer). In both cases, pblk's rate-limiter prevents the I/O to
>> be written to the buffer, thus stalling.
>>=20
>> This patch fixes the original backpointer implementation by considering
>> the threshold both on buffer creation and on the rate-limiters path,
>> when bio_split is triggered (case (ii) above).
>>=20
>> Fixes: 766c8ceb16fc ("lightnvm: pblk: guarantee that backpointer is respe=
cted on writer stall")
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>> ---
>>=20
>>  Changes since V1:
>>    - Fix a bad arithmetinc on the rate-limiter max_io calculation (from
>>      Hans)
>>=20
>> drivers/lightnvm/pblk-rb.c | 25 +++++++++++++++++++------
>> drivers/lightnvm/pblk-rl.c |  5 ++---
>> drivers/lightnvm/pblk.h    |  2 +-
>> 3 files changed, 22 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>> index d4ca8c64ee0f..a6133b50ed9c 100644
>> --- a/drivers/lightnvm/pblk-rb.c
>> +++ b/drivers/lightnvm/pblk-rb.c
>> @@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
>> /*
>>  * pblk_rb_calculate_size -- calculate the size of the write buffer
>>  */
>> -static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
>> +static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
>> +                                          unsigned int threshold)
>> {
>> -       /* Alloc a write buffer that can at least fit 128 entries */
>> -       return (1 << max(get_count_order(nr_entries), 7));
>> +       unsigned int thr_sz =3D 1 << (get_count_order(threshold + NVM_MAX=
_VLBA));
>> +       unsigned int max_sz =3D max(thr_sz, nr_entries);
>> +       unsigned int max_io;
>> +
>> +       /* Alloc a write buffer that can (i) fit at least two split bios
>> +        * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee tha=
t the
>> +        * threshold will be respected
>> +        */
>> +       max_io =3D (1 << max((int)(get_count_order(max_sz)),
>> +                               (int)(get_count_order(NVM_MAX_VLBA << 1))=
));
>> +       if ((threshold + NVM_MAX_VLBA) >=3D max_io)
>> +               max_io <<=3D 1;
>> +
>> +       return max_io;
>> }
>>=20
>> /*
>> @@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int siz=
e, unsigned int threshold,
>>        unsigned int alloc_order, order, iter;
>>        unsigned int nr_entries;
>>=20
>> -       nr_entries =3D pblk_rb_calculate_size(size);
>> +       nr_entries =3D pblk_rb_calculate_size(size, threshold);
>>        entries =3D vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_e=
ntry)));
>>        if (!entries)
>>                return -ENOMEM;
>>=20
>> -       power_size =3D get_count_order(size);
>> +       power_size =3D get_count_order(nr_entries);
>>        power_seg_sz =3D get_count_order(seg_size);
>>=20
>>        down_write(&pblk_rb_lock);
>> @@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int siz=
e, unsigned int threshold,
>>         * Initialize rate-limiter, which controls access to the write buf=
fer
>>         * by user and GC I/O
>>         */
>> -       pblk_rl_init(&pblk->rl, rb->nr_entries);
>> +       pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
>>=20
>>        return 0;
>> }
>> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
>> index 76116d5f78e4..e9e0af0df165 100644
>> --- a/drivers/lightnvm/pblk-rl.c
>> +++ b/drivers/lightnvm/pblk-rl.c
>> @@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
>>        del_timer(&rl->u_timer);
>> }
>>=20
>> -void pblk_rl_init(struct pblk_rl *rl, int budget)
>> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>> {
>>        struct pblk *pblk =3D container_of(rl, struct pblk, rl);
>>        struct nvm_tgt_dev *dev =3D pblk->dev;
>> @@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>>        int sec_meta, blk_meta;
>>        unsigned int rb_windows;
>>=20
>> -
>>        /* Consider sectors used for metadata */
>>        sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_li=
nes;
>>        blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
>> @@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>>        /* To start with, all buffer is available to user I/O writers */
>>        rl->rb_budget =3D budget;
>>        rl->rb_user_max =3D budget;
>> -       rl->rb_max_io =3D budget >> 1;
>> +       rl->rb_max_io =3D budget - threshold;
>>        rl->rb_gc_max =3D 0;
>>        rl->rb_state =3D PBLK_RL_HIGH;
>>=20
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 72ae8755764e..a6386d5acd73 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int force)=
;
>> /*
>>  * pblk rate limiter
>>  */
>> -void pblk_rl_init(struct pblk_rl *rl, int budget);
>> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
>> void pblk_rl_free(struct pblk_rl *rl);
>> void pblk_rl_update_rates(struct pblk_rl *rl);
>> int pblk_rl_high_thrs(struct pblk_rl *rl);
>> --
>> 2.17.1
>>=20
