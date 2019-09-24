Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B5AC432C2
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EB321655
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeVds6V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504517AbfIXLXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:23:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44686 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504653AbfIXLXN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 07:23:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so1490737wru.11;
        Tue, 24 Sep 2019 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=a1/5fGcr5c/EA/ruL6XWdplUdglGT2wUTJBUAn9ie1M=;
        b=JeVds6V87276qLcFxKmthksUQ1lQFEW/GaNtlc/QueA2iMqStVYicS6yuK9skaMTt0
         oriZp9al1FAAiaDBTmpIuWHZzFC7Y3IIUyetQ1IzebfN2p10GiYiLpfAHkL21dbZOHtd
         vQZoxGOk8YG8WxqbEKukMAWqNkNmoEjJ38mthThnlV0t8nZHLx0QysWZYTSPZUA6EeKq
         dtk6ZUU270vh5bnFUcTsDlg61BprSvjkW6aJWZN8P0Atb1zapfZUcFEGsykqTdIoGHIo
         MwqiFXyq1pKWfQamma2p5EaLbiHH6AH4QTlkqI9C43cqgijFOYnkmfN2aOHcNnbYrzLk
         GFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=a1/5fGcr5c/EA/ruL6XWdplUdglGT2wUTJBUAn9ie1M=;
        b=SLH5gWhj3VGRY6gPjMtqOfKD258R7jC7jPtRwyAQQ3Bd+XDgWjfZUYzHQLAVlSAnV3
         4uvGkODccLnAbh339t1zkE9EbF1xwNF4YE1AUBGao/Jhn+sz/up5x47JZHuDcG17TbNO
         d+bnGRhChd/DVEwCp0BMetKX/GlOpKR9yCB+hNFOSIwMYZq7qyPk+yeIcnQX2x4CjS8E
         i+Oad/tvk7F/falqLY3Cm9e6nsEaxTlsAHC/4V925eVOMzFTnGH6le9hjPTrz8+jQDLb
         uJjIU6KmLKer60ZLr5BWSzG1mB6NUBgq8YdNFZAZ3yzttyITaO0jaGhBgVlnOEUWoAWk
         HHbQ==
X-Gm-Message-State: APjAAAXDBXaZzlqOv+/k+tbCtIJTKpouoJbnwQJR42FNrBQOMKqnpzda
        KjwvLRJesH1d+mBdDnqAAz3wx7Dkd8suUQ==
X-Google-Smtp-Source: APXvYqzqZUkiOGrfzJlWyrtRcjD+KE/sAGqGHaODT4TxLIZwE6pBxf9YF+eOUmRNxyGdb2P0tMxCBg==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr1824961wrx.51.1569324191713;
        Tue, 24 Sep 2019 04:23:11 -0700 (PDT)
Received: from [192.168.1.75] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id q19sm2447916wra.89.2019.09.24.04.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:23:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
Date:   Tue, 24 Sep 2019 14:23:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vponxphrChCw4VKnnzbWHbYFN9PxjZEmp"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vponxphrChCw4VKnnzbWHbYFN9PxjZEmp
Content-Type: multipart/mixed; boundary="u5CyVYcpD1tHFsT7QXakagEGiOraFbNRl";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
In-Reply-To: <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>

--u5CyVYcpD1tHFsT7QXakagEGiOraFbNRl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/09/2019 14:15, Jens Axboe wrote:
> On 9/24/19 5:11 AM, Pavel Begunkov wrote:
>> On 24/09/2019 13:34, Jens Axboe wrote:
>>> On 9/24/19 4:13 AM, Jens Axboe wrote:
>>>> On 9/24/19 3:49 AM, Peter Zijlstra wrote:
>>>>> On Tue, Sep 24, 2019 at 10:36:28AM +0200, Jens Axboe wrote:
>>>>>
>>>>>> +struct io_wait_queue {
>>>>>> +	struct wait_queue_entry wq;
>>>>>> +	struct io_ring_ctx *ctx;
>>>>>> +	struct task_struct *task;
>>>>>
>>>>> wq.private is where the normal waitqueue stores the task pointer.
>>>>>
>>>>> (I'm going to rename that)
>>>>
>>>> If you do that, then we can just base the io_uring parts on that.
>>>
>>> Just took a quick look at it, and ran into block/kyber-iosched.c that=

>>> actually uses the private pointer for something that isn't a task
>>> struct...
>>>
>>
>> Let reuse autoremove_wake_function anyway. Changed a bit your patch:
>=20
> Yep that should do it, and saves 8 bytes of stack as well.
>=20
> BTW, did you test my patch, this one or the previous? Just curious if i=
t
> worked for you.
>=20
Not yet, going to do that tonight

--=20
Yours sincerely,
Pavel Begunkov


--u5CyVYcpD1tHFsT7QXakagEGiOraFbNRl--

--vponxphrChCw4VKnnzbWHbYFN9PxjZEmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2J/JoACgkQWt5b1Glr
+6XAzA/+OXCoZw2fYO5ysjNZz7IiVIwCavCve77P6iseEqiVMsssG7FKS5d16okF
MmbtcZuFAy3G9wQj5ByCUTII1fD11h7lodro/hi6mrJgOkeWt+rLRCpm6tdXu7iN
Tdr37rdMvhPBfG69Tv1XQC/9/ygYvCSTOjGUOSj5xRCKzOzIGQc2BY1taGbF7Ij0
59WWqAHQD+dvGljFxme2VzNY7Pxc5MfksSYdbUWuJ69wl0cUj1ed+zhly+s2WYYv
PT8SiEM96pC0t+nRK1XMkRSmhJvZ8UOBT2O3wgs8oYGeEoSowd5zJq83N7bh8btP
msaaapWUrQLcQDsFFQP0j9XHATU5ouxI0aRJCVV//Wafr3QcZVpGL4wmwvI30MME
jXU97+4B4V0q/tMwRzzYRjeQWKTXXCLCNIohKzT1ehpxvT+t3sp2pSIRsDncOoSm
OQTCtBui8u5Ikuwy6nQF+UwPCD4w3qswyMGD0bdhXMgcNDE2pxRblfXc12NoYxbP
c7nxuq1FqXix87KSsbztW/FU1EzEnrxHf4iS0Q+G3vjFAU94N+oDYySb/BqMRa2T
lHi/j/alTDptHGVFl6+UphRNo6RN3/n60DBD1fZ2yG1Hr2RIVdfsvDYnTx7fUgVs
RhF2cGVAvsCi/pubO0SXFiubOoUkxyQ8ovR9GeDIijG7++KX45w=
=+Oe7
-----END PGP SIGNATURE-----

--vponxphrChCw4VKnnzbWHbYFN9PxjZEmp--
