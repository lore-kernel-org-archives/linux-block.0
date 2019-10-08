Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61258C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218F021721
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZjY1fye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfJHWF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:05:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35900 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJHWF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 18:05:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so26348wrd.3;
        Tue, 08 Oct 2019 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=RpioymZ8THO1+vtxBBNSZWKxfnKuL14B09KXq62UiWg=;
        b=CZjY1fyeHmoc6heORpB0ltDH5n3PkjrxVo8wYEryTAV/Jjo2hzUoFTmdXf0tP50OJI
         DnIrklMv8Cu9ixUj4fGyx9U9qGraCj82SVNyrpuCm/3gRFB2wA4r+zkB20/i42W+Lwpa
         EokuwHRV+mhWAT3exMohdhHNnXMuIaHOD/FQKoTzlzBvcnELcUIi/TApQeHzY/vKGXz1
         rc1Vay47wfsO5me7Q0wmOqdTmbgdfuFuT7LJAlOGdmbBXM6EcwPnEhxs9w8Yl8TFR6g7
         OZURaP39MtrBtXLsv9UyPwGsqbiLA6emHoxRANzhEUlpLSDRwi0MQZWWuWcXdDF4tUp8
         8x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=RpioymZ8THO1+vtxBBNSZWKxfnKuL14B09KXq62UiWg=;
        b=j4Dbcf9HSaE787VCAEyJKJ7zYGoD9qEygcbj1FtMcsc2WnXatnqU/S6GM/cc25eUtn
         zbo2FszfTbEC5ovdociwj8g+m5IaRJx2Q0zvL7kSpT1BuwY69ouxTz6SFseeb3MIs/tP
         lJeHbsEtzbeToBJzpRGmG3R+nsqM4SIusgNIeVZ1wbRuWl80IHLwJkvnHoerhiMF41SY
         isfEw4XVxeS63a4Y/vzKWb/EnQsyGvUcuHQX/tl87+nJmtW5F3PE6EU+sZq+vi3MImlB
         8BeCF8szcnt8CH1cD9bNMSkhOJNJQUxzUz4m8A9zJsAzCSKzVY9ykj0pBL/3dPVYx6YM
         /cxw==
X-Gm-Message-State: APjAAAUsRihF5NFCxKit257PAKTmmbdEi7uiQOx36taQMCkUp3DjX/5o
        vGhlfpeZjZn45cbv/RlxpNUKJwlv
X-Google-Smtp-Source: APXvYqxIDfRKQffrdbZdZLVFnhaAxBDFqJM6lwDYPAnI7LjLj5q4cyhIefvJy0eUYErVy1L3ByJMQA==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr71240wrt.215.1570572354471;
        Tue, 08 Oct 2019 15:05:54 -0700 (PDT)
Received: from [192.168.43.219] ([109.126.138.202])
        by smtp.gmail.com with ESMTPSA id y19sm210699wmi.13.2019.10.08.15.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:05:51 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
 <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
 <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
Message-ID: <4004b5bc-edf0-cc8f-8efc-7f848c95f0ba@gmail.com>
Date:   Wed, 9 Oct 2019 01:05:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yIlVw3XG5ZYr0uTxHwD7mpXh9cod03GJp"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yIlVw3XG5ZYr0uTxHwD7mpXh9cod03GJp
Content-Type: multipart/mixed; boundary="V7yMANjARSlJhZwMxRwczcAhzhHvXv8cl";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <4004b5bc-edf0-cc8f-8efc-7f848c95f0ba@gmail.com>
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
 <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
 <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>
In-Reply-To: <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>

--V7yMANjARSlJhZwMxRwczcAhzhHvXv8cl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/10/2019 00:22, Jens Axboe wrote:
> On 10/8/19 2:58 PM, Pavel Begunkov wrote:
>> On 08/10/2019 20:00, Jens Axboe wrote:
>>> On 10/8/19 10:43 AM, Pavel Begunkov wrote:
>>>> On 08/10/2019 06:16, Jens Axboe wrote:
>>>>> On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
>>>>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>>>>
>>>>>> Any changes interesting to tasks waiting in io_cqring_wait() are
>>>>>> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_ref=
s()
>>>>>> also tries to do that but with no reason, that means spurious wake=
ups
>>>>>> every io_free_req() and io_uring_enter().
>>>>>>
>>>>>> Just use percpu_ref_put() instead.
>>>>>
>>>>> Looks good, this is a leftover from when the ctx teardown used
>>>>> the waitqueue as well.
>>>>>
>>>> BTW, is there a reason for ref-counting in struct io_kiocb? I unders=
tand
>>>> the idea behind submission reference, but don't see any actual part
>>>> needing it.
>>>
>>> In short, it's to prevent the completion running before we're done wi=
th
>>> the iocb on the submission side.
>>
>> Yep, that's what I expected. Perhaps I missed something, but what I've=

>> seen following code paths all the way down, it either
>> 1. gets error / completes synchronously and then frees req locally
>> 2. or passes it further (e.g. async list) and never accesses it after
>=20
> As soon as the IO is passed on, it can complete. In fact, it can comple=
te
> even _before_ that call returns. That's the issue. Obviously this isn't=

> true for purely polled IO, but it is true for IRQ based IO.

And the idea was to not use io_kiocb after submission. Except when we kno=
w,
that it won't complete asynchronously (e.g. error), that could be checked=

with return code, I guess.

Anyway, thanks for the explanation!

--=20
Yours sincerely,
Pavel Begunkov


--V7yMANjARSlJhZwMxRwczcAhzhHvXv8cl--

--yIlVw3XG5ZYr0uTxHwD7mpXh9cod03GJp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2dCD0ACgkQWt5b1Glr
+6Xr3w/9F7F/NNIXCXtDSBKW1q/7dmCkK1QBZnywTaKS4tF8tOgxXsDXB8tNn2Yt
XGSCxlyQ2IKUiShMsA2DPKIsdyAlwA03kd2jM5FHRLZ3RNAZLwz2nrg5R41Uu9rL
WipfLfi2k0gu0wlOQTgGjAlT8pquO7IuGxwznAGqdcoJplAQO56Dh4+mR/q2wvqi
uKCmGuGehyH9yHzt8A3a5on81kttgECqxI3H3NRIlEP1hi2K6lyMfa9UcFYcYKLK
cg5QUOlbdmCNzRzOnlvGGlAx77leOTHPWEopbuGoC8lIkXhM2aOl2OKB6FSq9v+4
QW+FbCUr3VCoxe19pIjUt2dSEd5JO9+ou9k1DFhWXuYjvQ1j0zzCYhJ2zoGY9707
H4Q1sPY2m057pd5YJaL9Ojm42MGugGIxQsZ4jncsseKqwkBelRlJsgmroJRlBNTT
fRlQgmuF+1o6KRcNHPZoRnwUYG08mKOfidsPI/5BSW20fWQx7FqHT8p6leYkMdr+
tX1A6b5hyoTGrLhn2yJ6vfzkxw7FitKPLsi4VytZ9Ruy8QlhdMjN5mVbP84+wdtU
5GbAMTo0/DImBS+7TTh4PodIF5vIFNpHxKu8r2R8AzjnmlJKe9rpv0IrZotM1YWo
3aMeFR78Fj9rhUQg1HLB0DmkUcvmfKrXMKyS/dwCBtwStE1Zp4o=
=I4EE
-----END PGP SIGNATURE-----

--yIlVw3XG5ZYr0uTxHwD7mpXh9cod03GJp--
