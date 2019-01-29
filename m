Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E0C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 10:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B3E2148E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="IZT2f061"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfA2K63 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:58:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36005 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfA2K63 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 05:58:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so15614514edb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vgu1E6KwWJ7qMYrrDtE6sX0zf5M1niR+9V3Rf8zuDF4=;
        b=IZT2f061RUuW2CyI5WUJ8UqUEr4C4Y3EstjFckbZalm6wTIisAYugSk3ureGfTpltP
         UHJ9/qP5I89/dQeH0EL+qYehAhI+5TvyjeOoA6/fA13cpx5Az5MVXimwYeGxyQBRYUFc
         2zMjP9dhgVw1njskaD1H05DoxqCRwM5dc1QjnN9wgD6L3wg4HnZxn+oDv4/uR141oNvA
         lWzZ+lq8YylRGaJM8VL4gzP6ZbkgbU1hf42aQABu00sAab00Y/v6W7SRx2UiqKcg0OGk
         Iy7V99T4W9YGUtErRiaEp13oK9uiSGXKYj2sIQtkp6J0/hIg0Csq1oU+bDyXr1mncMjv
         QTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vgu1E6KwWJ7qMYrrDtE6sX0zf5M1niR+9V3Rf8zuDF4=;
        b=glmHm9DvIrpAjhA6sZB/f85vBjrma4ROxZp2fNnVhNCBwxQzOmcUMReOeThvO8rCKp
         B5BOWqSdju8KZxUdcsuNnPwwDkAXqYDeW9kVRHyZ4ExnkImoF1k/WyfpG9vK1MPmVX/6
         IJdkF3kRGvi9GA16kRqT3zHhW+LYaOfmz3HQhnkRmjo+RpNeDmXxHFgeI+UAtjTkzM74
         95rSH+AVf4cEsNBlYwqri13IjXsPGsOu5LelfFsxmfsnMR9sGf3jHJ7o4SIr3B3eopzE
         88vr9AzH5Kz2K9xkbEFOB+dkNNck+IRM3MpUGwBDZ3DiqOwJ9DpzV4c7D38NC9+ThMDZ
         OF7w==
X-Gm-Message-State: AJcUukflriLJfH9JU32jJFrsEoDYWtKZp1Ez8ncvKZpKpeRL8s7tTm7P
        2USI8BIMnSpzsFWnepuJguFPQiqeqMvdlg==
X-Google-Smtp-Source: ALg8bN5/jaxrIenEhN+RcQ5CGTmPpUcFZe5FSWkGUi+c3l1/9mIxTIy2pfH2fl0icNzyyisi2eY5RQ==
X-Received: by 2002:a17:906:4d16:: with SMTP id r22mr10370209eju.207.1548759506221;
        Tue, 29 Jan 2019 02:58:26 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id h1sm1981238ejx.41.2019.01.29.02.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:58:25 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <1B9C3267-912F-44C2-8203-0078154D82A4@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0BA3A42E-B7D6-45F8-A7AE-8A7E6BF69312";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: prevent stall due to wb threshold
Date:   Tue, 29 Jan 2019 11:58:24 +0100
In-Reply-To: <CANr-nt3KXtTOP44342b_SR5dcvJk1_XnP256d2FxN7Kkb1MZ_w@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <20190125100943.28743-1-javier@javigon.com>
 <a712d1f5-2d82-2879-b220-4c6790fdc56a@lightnvm.io>
 <CANr-nt3KXtTOP44342b_SR5dcvJk1_XnP256d2FxN7Kkb1MZ_w@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_0BA3A42E-B7D6-45F8-A7AE-8A7E6BF69312
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Jan 2019, at 11.15, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Fri, Jan 25, 2019 at 2:08 PM Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>> On 1/25/19 11:09 AM, Javier Gonz=C3=A1lez wrote:
>>> In order to respect mw_cuinits, pblk's write buffer maintains a
>>> backpointer to protect data not yet persisted; when writing to the =
write
>>> buffer, this backpointer defines a threshold that pblk's =
rate-limiter
>>> enforces.
>>>=20
>>> On small PU configurations, the following scenarios might take =
place: (i)
>>> the threshold is larger than the write buffer and (ii) the threshold =
is
>>> smaller than the write buffer, but larger than the maximun allowed
>>> split bio - 256KB at this moment (Note that writes are not always
>>> split - we only do this when we the size of the buffer is smaller
>>> than the buffer). In both cases, pblk's rate-limiter prevents the =
I/O to
>>> be written to the buffer, thus stalling.
>=20
> I'll start a regression test run.
> Do you have a way of reproducing these issues? It would be great to
> add regression test(s) covering the two cases you list.

It is easy to reproduce in qemu - simulate a drive with 8 PUs (leave the
rest as default) and then create a pblk instance using 1 or 2 LUNs. You
should see a stall without this patch.

We should add these corner cases to the suit - I was actually surprised
this had been out there for so long...

> A general comment on the write buffer and rate limiter:  What is the
> rationale of rounding up the write buffer size to a power of two?

It is much easier to manage as we can use the ring buffer helpers. There
is also dependencies on the map algorithm to this. If you want to give
it a try and relax this, it is OK by me. Anyway, this is orthogonal to
this fix.

> We can end up allocating almost twice as much memory as we need,

In the worse case this is true.

> and all this power-of-two-arithmetic makes the code hard to read.

Ring buffers and many other structures in the kernel are primarily
powers-of-2, this is not pblk specific.

>=20
>>> This patch fixes the original backpointer implementation by =
considering
>>> the threshold both on buffer creation and on the rate-limiters path,
>>> when bio_split is triggered (case (ii) above).
>>>=20
>>> Fixes: 766c8ceb16fc ("lightnvm: pblk: guarantee that backpointer is =
respected on writer stall")
>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>>> ---
>>>  drivers/lightnvm/pblk-rb.c | 25 +++++++++++++++++++------
>>>  drivers/lightnvm/pblk-rl.c |  5 ++---
>>>  drivers/lightnvm/pblk.h    |  2 +-
>>>  3 files changed, 22 insertions(+), 10 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>>> index d4ca8c64ee0f..a6133b50ed9c 100644
>>> --- a/drivers/lightnvm/pblk-rb.c
>>> +++ b/drivers/lightnvm/pblk-rb.c
>>> @@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
>>>  /*
>>>   * pblk_rb_calculate_size -- calculate the size of the write buffer
>>>   */
>>> -static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
>>> +static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
>>> +                                        unsigned int threshold)
>>>  {
>>> -     /* Alloc a write buffer that can at least fit 128 entries */
>>> -     return (1 << max(get_count_order(nr_entries), 7));
>>> +     unsigned int thr_sz =3D 1 << (get_count_order(threshold + =
NVM_MAX_VLBA));
>>> +     unsigned int max_sz =3D max(thr_sz, nr_entries);
>>> +     unsigned int max_io;
>>> +
>>> +     /* Alloc a write buffer that can (i) fit at least two split =
bios
>>> +      * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee =
that the
>>> +      * threshold will be respected
>>> +      */
>>> +     max_io =3D (1 << max((int)(get_count_order(max_sz)),
>>> +                             (int)(get_count_order(NVM_MAX_VLBA << =
1))));
>>> +     if ((threshold + NVM_MAX_VLBA) >=3D max_io)
>>> +             max_io <<=3D 1;
>>> +
>>> +     return max_io;
>>>  }
>>>=20
>>>  /*
>>> @@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned =
int size, unsigned int threshold,
>>>      unsigned int alloc_order, order, iter;
>>>      unsigned int nr_entries;
>>>=20
>>> -     nr_entries =3D pblk_rb_calculate_size(size);
>>> +     nr_entries =3D pblk_rb_calculate_size(size, threshold);
>>>      entries =3D vzalloc(array_size(nr_entries, sizeof(struct =
pblk_rb_entry)));
>>>      if (!entries)
>>>              return -ENOMEM;
>>>=20
>>> -     power_size =3D get_count_order(size);
>>> +     power_size =3D get_count_order(nr_entries);
>>>      power_seg_sz =3D get_count_order(seg_size);
>>>=20
>>>      down_write(&pblk_rb_lock);
>>> @@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned =
int size, unsigned int threshold,
>>>       * Initialize rate-limiter, which controls access to the write =
buffer
>>>       * by user and GC I/O
>>>       */
>>> -     pblk_rl_init(&pblk->rl, rb->nr_entries);
>>> +     pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
>>>=20
>>>      return 0;
>>>  }
>>> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
>>> index 76116d5f78e4..f81d8f0570ef 100644
>>> --- a/drivers/lightnvm/pblk-rl.c
>>> +++ b/drivers/lightnvm/pblk-rl.c
>>> @@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
>>>      del_timer(&rl->u_timer);
>>>  }
>>>=20
>>> -void pblk_rl_init(struct pblk_rl *rl, int budget)
>>> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>>>  {
>>>      struct pblk *pblk =3D container_of(rl, struct pblk, rl);
>>>      struct nvm_tgt_dev *dev =3D pblk->dev;
>>> @@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int =
budget)
>>>      int sec_meta, blk_meta;
>>>      unsigned int rb_windows;
>>>=20
>>> -
>>>      /* Consider sectors used for metadata */
>>>      sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
>>>      blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
>>> @@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int =
budget)
>>>      /* To start with, all buffer is available to user I/O writers =
*/
>>>      rl->rb_budget =3D budget;
>>>      rl->rb_user_max =3D budget;
>>> -     rl->rb_max_io =3D budget >> 1;
>>> +     rl->rb_max_io =3D (budget >> 1) - get_count_order(threshold);
>=20
> Hmm? How can this work? get_count_order returns a bit index, and
> budget is a size.
>=20

You are right. I was playing with passing the order and forgot to remove
this. It should be
   rl-rb_max_io =3D budget - threshold;

Note that in the original code we allow for 2 I/Os to come in
simultaneously by dividing by 2 the max_io, but this was a silly
"optimization" that we can remove as it does not do anything.

I will fix it in V2.

> Also, what happens during garbage collection? Won't we risk stalling
> anyway when GC consumes most of the budget?
>=20

This only affects the max_io size, which is shared by user and GC I/O. I
would not expect any effect on the budget by this change.

> For user writes to be inserted into the write buffer, they need to
> pass the check pblk_rl_user_may_insert, which checks rb_user_max(which
> is tuned depending on gc pressure) , not rb_max_io.

There is no tuning, just a check that there is space. Now we limit the
I/O size, which only means that the write needs to wait until the
previous I/Os have completed.

I am happy to be proven wrong if you find a regression on the tests, but
I cannot see any at this point neither on the code nor on my tests.

>=20
>>>      rl->rb_gc_max =3D 0;
>>>      rl->rb_state =3D PBLK_RL_HIGH;
>>>=20
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 85e38ed62f85..752cd40e4ae6 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int =
force);
>>>  /*
>>>   * pblk rate limiter
>>>   */
>>> -void pblk_rl_init(struct pblk_rl *rl, int budget);
>>> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
>>>  void pblk_rl_free(struct pblk_rl *rl);
>>>  void pblk_rl_update_rates(struct pblk_rl *rl);
>>>  int pblk_rl_high_thrs(struct pblk_rl *rl);
>>=20
>> + Hans

--Apple-Mail=_0BA3A42E-B7D6-45F8-A7AE-8A7E6BF69312
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQMdAACgkQPEYBfS0l
eOCgOA/+IwnDSZNlyx74Cef3I9jUiAlYJ6uRS4/X0IgrrpxRj+I8cIUtAlUCPFhE
+J27lwM3YBCRim/XldBiQNn4/0jAgYL4lA9UmpOCcT6nEEBDOOMBTfvPN2RIdaPN
9YAOAVlomoihFqWcYn0Tj5EMvqokGotFOPZEQHqi8dlH9isqxtu8WR8UBSh5aDvw
Wa5QufZSHAFJxWE/x5KjjeMdGUPWYKQd6WCanhzXRTb9d3xfzCH7eVv/y1ZyLh/a
pD98oAkQIm5GD2FOTeFhFyiVVIwXIMRVx8rMT/omok/o3FguPUV5lEdUoP3mwqVv
IMMcSJdsw4Mw9JSI0jom20JfCu4pDZCxwnQwE25O2rnUhqmYHcpmZ9y2i/oybaX4
6lw9Sk104J2hOjkTu5eqG61aOjg6IW6mpwmFPH1QUNVvMrZ2Wf7YmaV5b9OB9HRP
vQ0KarsQ8xu2aTdXxXMVQHPcfMzihDRgd5UebvtQ0CiUuJjHy3+7yju9c5uuCsbz
dMz0otjYdl+3t8h38bXPI65V8K2IKhU8sMAwzd3heY1ia4EmVz3t+7hjyzdexDcX
gUmMl+X7Wb82Hb1xYpbMzODS+xVcG0nen4qXds6CVBQJ0ndtmmKrwHFYg91IjFWZ
8kuA72Nn5uJ2Mv3nQXxsp0bAUP5EcgY4bw/8DfNfcSwGbaBzBBU=
=Vv8v
-----END PGP SIGNATURE-----

--Apple-Mail=_0BA3A42E-B7D6-45F8-A7AE-8A7E6BF69312--
