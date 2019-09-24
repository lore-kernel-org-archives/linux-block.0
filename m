Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E07C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 09:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3141B214D9
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 09:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3FrK2Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395150AbfIXJVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:21:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395143AbfIXJVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 05:21:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id x2so1331301wmj.2;
        Tue, 24 Sep 2019 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=JWRvhh5To4/VQiba55QbL1WefOtwhk6K4xBj6xm2agk=;
        b=s3FrK2Dq7/0vV/tR+NhcgcdnPnHtxIkDaY8K5afnyRO0nXVgca22tKLDiE2ZyXTj+x
         3LgRRUo9V50Z+q3URJL174K1L7EzW2uPnFlhtUOND9UuqCbc/7VtZKbYa4eR1v2mISMc
         /0JeZ0JuzsneBWER1Uc5sbeo/t/KGBXKyRcP0ZoXkTEOQMJgNsNVOuHqf+EAF0my0ZdK
         jzDiewdrKDdjzbyMdmCiUAKWYUL6RUHjovaaDAwQaO3rPQ0QIKxASI9d5hhfdbO/6q1Q
         p4ZCd69DwY4q1R8L8uTFvl/ckMxI+kDl/nNd1+nyErALoo6346KuhHqx1KWRN0NESYza
         Dj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=JWRvhh5To4/VQiba55QbL1WefOtwhk6K4xBj6xm2agk=;
        b=pzdHkBVgtU/1pBrzwsz44rs6eMDgINhyo0MysbhfvOrP4yoHAKM3LubdcpaNN+G6Ju
         rsSkPZTYwIVO1bLCJmAzoanE1oBQdXHCXlznWnrf+mclkJkZDdg3Wx3edYwXUva3ZQ1k
         aM2n+G6GIcjgKtXE+fFJ3/0LRJmgz8DkVI3Kj/dFxcwdfjYXQJ7sjJFhlwOXq6tpswYI
         +8vsP1uolYPDg5cHozXgY+JFu0FvHkSBdxESkVCG5VNabBwEt9WHab3QnLBv1DHweTLq
         VH+8DS/uEgBGQ/w36UAcqD7wPsZmDjTSe+cGj7XEy0f3hQ+soFjRINbcVzA9MmhKAiRz
         YVGg==
X-Gm-Message-State: APjAAAW+8BnlDOWTOQJnlRPmuyMct0wfLiHI1wWzUZPi3iUzLWdLwd+T
        49Db02UNuljnyuyFim8ktRX1IHrPU3v06Q==
X-Google-Smtp-Source: APXvYqyMNlO5DrV5pqnWaqJz1eO9A9bJNw7KxGoV9pwm5Fwy3OMnhypQMD5ZU4fRpQqV/FlaLTJV+A==
X-Received: by 2002:a1c:2397:: with SMTP id j145mr1753084wmj.69.1569316879869;
        Tue, 24 Sep 2019 02:21:19 -0700 (PDT)
Received: from [192.168.1.75] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id r12sm830827wrq.88.2019.09.24.02.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 02:21:19 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <4240453d-2a6a-092f-28a4-523d2f6fc6c1@gmail.com>
Date:   Tue, 24 Sep 2019 12:20:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q1Tb3EFwvXKmu9xh0qOk3JMtHw6aPUveJ"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q1Tb3EFwvXKmu9xh0qOk3JMtHw6aPUveJ
Content-Type: multipart/mixed; boundary="mGYUj5oYnlKkW4DKTIAxaS91zbKycJ52C";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <4240453d-2a6a-092f-28a4-523d2f6fc6c1@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
In-Reply-To: <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>

--mGYUj5oYnlKkW4DKTIAxaS91zbKycJ52C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 24/09/2019 11:27, Jens Axboe wrote:
> On 9/24/19 2:02 AM, Jens Axboe wrote:
>> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>>> structure with a count in it, on the stack. Got some flight time
>>>>> coming up later today, let me try and cook up a patch.
>>>>
>>>> Totally untested, and sent out 5 min before departure... But somethi=
ng
>>>> like this.
>>> Hmm, reminds me my first version. Basically that's the same thing but=

>>> with macroses inlined. I wanted to make it reusable and self-containe=
d,
>>> though.
>>>
>>> If you don't think it could be useful in other places, sure, we could=
 do
>>> something like that. Is that so?
>>
>> I totally agree it could be useful in other places. Maybe formalized a=
nd
>> used with wake_up_nr() instead of adding a new primitive? Haven't look=
ed
>> into that, I may be talking nonsense.
>>
>> In any case, I did get a chance to test it and it works for me. Here's=

>> the "finished" version, slightly cleaned up and with a comment added
>> for good measure.
>=20
> Notes:
>=20
> This version gets the ordering right, you need exclusive waits to get
> fifo ordering on the waitqueue.
>=20
> Both versions (yours and mine) suffer from the problem of potentially
> waking too many. I don't think this is a real issue, as generally we
> don't do threaded access to the io_urings. But if you had the following=

> tasks wait on the cqring:
>=20
> [min_events =3D 32], [min_events =3D 8], [min_events =3D 8]
>=20
> and we reach the io_cqring_events() =3D=3D threshold, we'll wake all th=
ree.
> I don't see a good solution to this, so I suspect we just live with
> until proven an issue. Both versions are much better than what we have
> now.
>=20
If io_cqring_events() =3D=3D 8, only the last two would be woken up in bo=
th
implementations, as to_wait/threshold is specified per waiter. Isn't it?

Agree with waiting, I don't see a good real-life case for that, that
couldn't be done efficiently in userspace.


--=20
Yours sincerely,
Pavel Begunkov


--mGYUj5oYnlKkW4DKTIAxaS91zbKycJ52C--

--Q1Tb3EFwvXKmu9xh0qOk3JMtHw6aPUveJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2J3/kACgkQWt5b1Glr
+6Uw+g//Z7ZPSw79sA9YJBqsiLM/2DAL3ik9moLYbY5jwloPgHfZdt9ELssywoox
gSLqph/mpBFK97/VBr9gRO4D2yhQup0SiEv3CgZZ+LTlqsBfs5HotQmWx13zdCfc
Rcz6lzj2h9ibvPDFHfKrZDnYl5M7g8br3+EICk/4i3yq5qCX+viJV6aDNP6TkNq3
HEDN3sjpccVNCYDKccsuK5My/u3mdYmOBIiXVaDkI9wSEAlbW5rULKoLVOwjcM1U
1B/fnbSuWkoJDeqQMT+OGlpeh2FVrih3rdFyabI7fshY+PCI+V/N2zfCH9re/9kL
iOeLop+A5gtzV1pnNlKbpfFQVDX6Lk7rhVRxQ4bC5VVmdr3xdkO+qdCSERwdbgDP
vhRkm8RNFVzZmeRwrLS9kewKSehJP1vDnp3CKE1lAIL1Zma4+tKCfDueIFDh9FVz
4snHCuIychzNa1ES781XB7wDoecSRKNQud4J3kf0O9zqy9iBRl7DkAlicvjGFOcr
4yuAJtCmvC/5ldGqFrip9r++SLHqWQupSEsZYBpnHH7giMI+R8DKalB+c/6PxNBG
KocxcrIQp1rb0Ac1CFrzy3ER01W8P9WRyvjlKSEH7EKsiAeK1YUAdUB/Ht0gkW9t
tr/WYLRvCSw5GmlnackbZPf0kwHesVTLNytA7NhFi6HPnvJRghg=
=MDKy
-----END PGP SIGNATURE-----

--Q1Tb3EFwvXKmu9xh0qOk3JMtHw6aPUveJ--
