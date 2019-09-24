Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E23C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC0214DA
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 18:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiIy96nS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404559AbfIXS2u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:28:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53590 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392088AbfIXS2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 14:28:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so1257127wmd.3;
        Tue, 24 Sep 2019 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=zj8lAQ1QeNO4l2sUE81/QqbhsE/X5plSkltsp/CY7Aw=;
        b=SiIy96nSeXw0trfy77HSI/pYi+ANU5ibC4eICEot7LIukLAoeeyycY9Aux9TaVLoEz
         tktOqf66kQY6DYP018w3///AdX7q4VU3kytBjj91cmhqT65s3BaJBsJVXTqMT82kgFfF
         X/utrn8mBkvphwYTShblAgN7v3+cIRdmU7wll6sS5wivsiDxLTmHqTEPr+jquXAj9Lkw
         kVAXyDDkHOsUPnM2xxB3QRbpRsqEkxB6NPSiGsD0/ecbrKfmYAQcdc83ude8Tb0G0zGb
         Ds5FToe2iTxJK96A+niUAABN4AZ1/68r5fFgO+HuuMGSu3oIMXfOrYatcmCkg+q1MuoE
         CEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=zj8lAQ1QeNO4l2sUE81/QqbhsE/X5plSkltsp/CY7Aw=;
        b=Yx+nASOeiHCleAj7A0lR3gqO59+JC2jSKoqF2sVfVlkzuOu0XKzkhjjoj/aLFcb8Jo
         ETNASQpKSeDMpGPU7LOsBHzDp0hS7PipFeDyPwoD8BwQVdJGoRmZuU3XKE/Fk3gdYFHx
         qlr2OvVFteGf+Qe4hLLlT4OBcqi3rE/bvIMV5/j/EZnnoKlu66j6Qa8r4X5vy5Bx0hF5
         Z7FbDRyoC/yR3iz8W78hF+OeViN5STM1T3qDXjcuIESXQXg+EhpgFfIldFvC/sV75Lmy
         HF2Ge7f5v6EYaCPyTP1+vhaanyq5qeHlrXbPGWaCwGRBDxvKX29W5PWaoQIOCGJA1nAt
         f/sQ==
X-Gm-Message-State: APjAAAU9ZDT1l2T3QKO14yV3vkwoB5CcaIDjKqm9+SWZ1pQLu/grmRl3
        O7xNuqsLbOUohNYwYQAivxcEY6dQP+7Bog==
X-Google-Smtp-Source: APXvYqy/z5LHN1CZUB0cmR0R1a1RfBx2hi88MaOTRBFG3SBFbvdBLrOjtO/30SctuBaKSTvXVAcHjQ==
X-Received: by 2002:a1c:6a0f:: with SMTP id f15mr1486086wmc.159.1569349726254;
        Tue, 24 Sep 2019 11:28:46 -0700 (PDT)
Received: from [192.168.8.58] (lneuilly-656-1-59-14.w80-11.abo.wanadoo.fr. [80.11.63.14])
        by smtp.gmail.com with ESMTPSA id r18sm1170198wme.48.2019.09.24.11.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 11:28:45 -0700 (PDT)
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
 <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
 <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
 <79fa9cc2-e0cc-922f-89d3-9ace59abb2e8@gmail.com>
 <82f95b0f-8dd5-2fb5-7e17-b77072e86093@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <a307986b-94aa-f26f-fc5b-d0865083d060@gmail.com>
Date:   Tue, 24 Sep 2019 21:28:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <82f95b0f-8dd5-2fb5-7e17-b77072e86093@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MRerbCKMCgiDnv1pBgbZEOhd5eiJU1fgc"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MRerbCKMCgiDnv1pBgbZEOhd5eiJU1fgc
Content-Type: multipart/mixed; boundary="1QZ07OeRFzsu9yWAYUl0GV7BUUUqSYMUc";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a307986b-94aa-f26f-fc5b-d0865083d060@gmail.com>
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
 <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
 <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
 <79fa9cc2-e0cc-922f-89d3-9ace59abb2e8@gmail.com>
 <82f95b0f-8dd5-2fb5-7e17-b77072e86093@kernel.dk>
In-Reply-To: <82f95b0f-8dd5-2fb5-7e17-b77072e86093@kernel.dk>

--1QZ07OeRFzsu9yWAYUl0GV7BUUUqSYMUc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/09/2019 20:46, Jens Axboe wrote:
> On 9/24/19 11:33 AM, Pavel Begunkov wrote:
>> On 24/09/2019 16:13, Jens Axboe wrote:
>>> On 9/24/19 5:23 AM, Pavel Begunkov wrote:
>>>>> Yep that should do it, and saves 8 bytes of stack as well.
>>>>>
>>>>> BTW, did you test my patch, this one or the previous? Just curious =
if it
>>>>> worked for you.
>>>>>
>>>> Not yet, going to do that tonight
>>>
>>> Thanks! For reference, the final version is below. There was still a
>>> signal mishap in there, now it should all be correct afaict.
>>>
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 9b84232e5cc4..d2a86164d520 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2768,6 +2768,38 @@ static int io_ring_submit(struct io_ring_ctx *=
ctx, unsigned int to_submit,
>>>   	return submit;
>>>   }
>>>  =20
>>> +struct io_wait_queue {
>>> +	struct wait_queue_entry wq;
>>> +	struct io_ring_ctx *ctx;
>>> +	unsigned to_wait;
>>> +	unsigned nr_timeouts;
>>> +};
>>> +
>>> +static inline bool io_should_wake(struct io_wait_queue *iowq)
>>> +{
>>> +	struct io_ring_ctx *ctx =3D iowq->ctx;
>>> +
>>> +	/*
>>> +	 * Wake up if we have enough events, or if a timeout occured since =
we
>>> +	 * started waiting. For timeouts, we always want to return to users=
pace,
>>> +	 * regardless of event count.
>>> +	 */
>>> +	return io_cqring_events(ctx->rings) >=3D iowq->to_wait ||
>>> +			atomic_read(&ctx->cq_timeouts) !=3D iowq->nr_timeouts;
>>> +}
>>> +
>>> +static int io_wake_function(struct wait_queue_entry *curr, unsigned =
int mode,
>>> +			    int wake_flags, void *key)
>>> +{
>>> +	struct io_wait_queue *iowq =3D container_of(curr, struct io_wait_qu=
eue,
>>> +							wq);
>>> +
>>> +	if (!io_should_wake(iowq))
>>> +		return -1;
>>
>> It would try to schedule only the first task in the wait list. Is that=
 the
>> semantic you want?
>> E.g. for waiters=3D[32,8] and nr_events =3D=3D 8, io_wake_function() r=
eturns
>> after @32, and won't wake up the second one.
>=20
> Right, those are the semantics I want. We keep the list ordered by usin=
g
> the exclusive wait addition. Which means that for the case you list,
> waiters=3D32 came first, and we should not wake others before that task=

> gets the completions it wants. Otherwise we could potentially starve
> higher count waiters, if we always keep going and new waiters come in.
>=20
Yes. I think It would better to be documented in userspace API. I
could imagine some crazy case deadlocking userspace. E.g.=20
thread 1: wait_events(8), reap_events
thread 2: wait_events(32), wait(thread 1), reap_events

works well
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Tested-by: Pavel Begunkov <asml.silence@gmail.com>

BTW, I searched for wait_event*(), and it seems there are plenty of
similar use cases. So, generic case would be useful, but this is for
later.



--=20
Yours sincerely,
Pavel Begunkov


--1QZ07OeRFzsu9yWAYUl0GV7BUUUqSYMUc--

--MRerbCKMCgiDnv1pBgbZEOhd5eiJU1fgc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2KYFgACgkQWt5b1Glr
+6WOVhAAoM1vm/5z41T0xHtzCKlfjOfoXADaUbIm74FJicLDi2PuwWgLvBnTApfO
C0eONoA+Z4RmTU+Xw2Hkk9zU2MK79cdeDMPzNWr/oqHVac5gIn6xE2ykDjYppwGc
4O87BqVXz52AncaBoISCRNP7wYCOAW7KFicj+GUceCHsoDf4I/A45fWEXAPlgada
Ouil+DKAtqK3KvwsVKtT3CBUSMuHSIRzKdiO6iC4AgEcf5haC+GEL0wZBzU8Y3h5
+xXsK8YMWYGTBPMR7TiDnXcW9WJf57xDqq5XoTlYVbG0vkRjrUVGhMJ+yAYtvy01
+I+IHQXk8Y/fnPC8IM75It7MJanNZ1vOKB6hy3XY40fKw7xWedEPIzyznmG70tou
+klTXLNdA/DFQurOXtofvJhtzaRICMcyInT1pwPUG2+kNxxLKcBwBt3tDLQoAcQS
aWkdPQBOJSQjThEi8REKK6UU2PdUSoF9/6lIGIbtgOrkxvnudS3QKGtYUUcrt82k
rYakO+mqwJyrKh67B4Yj2GC/JSfVPVjd3ydrCGogxFokMX5iSwlYvf8MhAr92oh5
m76cOgr5QXJ94qu5KSEI4cXaHUdE+Vf/2wOXrsx0NeGZIf7foNbh/uvMwRVG5L1e
93acnuEGS4SGgQ4XPLe2MYEZ/ST6qtM9M5fVpQZiQj/UjRBiFCQ=
=k2qf
-----END PGP SIGNATURE-----

--MRerbCKMCgiDnv1pBgbZEOhd5eiJU1fgc--
