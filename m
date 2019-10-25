Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884B6CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 18:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9E206DD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 18:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYRfzAjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfJYSN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:13:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45407 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbfJYSN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 14:13:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so3354358wrs.12;
        Fri, 25 Oct 2019 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=GO8LwytqPhbdmHGFHx0M2/FV0b24nYxY4Ijyc4k+7Ok=;
        b=fYRfzAjVya6qh4w58ocGK7vjBrLpnqHIaqDBlKvHTLPKPYFbvTwepz255nys1wj5Os
         B70U9QDQW1Bw9E47M7lTcCH+sLx5l0cKTGsmMmu338cmAWFdn+Se5raUk1AORcbXyuTD
         bLb/i6rf/fQhcCNAOlMAJWNvjZpkjk8B/V0472I+yWIxHcL2pYDQpAFMrfU2nNZrctxZ
         s+0FlyQvMaXPu9ACVK1Q56yc8NV+YDhB4EzaR67tC5UFiLvg6dDyV0rCQjljKkps2aIo
         X7SGZ+Ndl0h0GhXV20EnxeYz3qhW7bp+snEqvjziHnP6Yrzi6bkXwgEKB4gUMcNp3X4e
         L+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=GO8LwytqPhbdmHGFHx0M2/FV0b24nYxY4Ijyc4k+7Ok=;
        b=o91oVAdVYbjWO7D2mDzwWdgnT342Q+weEtzNie9PqfU1rqlToRaMTmo4X1Mhmbg6mv
         AHvcDA7qNtErAZDTzmQqCSUE0SnoE378L3kP5NewYeMrAz5TcTgbIQ+LSJtCysKHqilu
         qpvxFW19a4KBS9vfCqRlrmWgnWlexctXx63uyjZiRDFpAwJ3QImFyphuh1CwJplEycBe
         HO5SKl/uMJthtjEoGKFyJgvhG/cm8duJDm2AMm5sg04I5O5Jw3ZbH4iU+TRVCaAILKCy
         sXp/sofTAMjcWIdxhIKrIPkoKwXO8f8tTUEYqreGDHK2CGYu0st51Zgae7ZYc1UWLVH+
         bX7A==
X-Gm-Message-State: APjAAAVOslWrbSS8dWv+UaY4ada5QfM0En71v4IqGqhRiqFjdw35l1V0
        nnCfc2YDeFDvQDVNmz/r4xjE39pF
X-Google-Smtp-Source: APXvYqw4yYdOvuPrcil6FvRGXav5Y1vhNlhIXXh9SiQUs0Qe0ugc9+M1G7J2M8Bu7lcijSKHbYlBcg==
X-Received: by 2002:adf:c402:: with SMTP id v2mr4504837wrf.323.1572027233400;
        Fri, 25 Oct 2019 11:13:53 -0700 (PDT)
Received: from [192.168.43.163] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id a11sm3525678wmh.40.2019.10.25.11.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 11:13:52 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
 <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
 <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
 <a0d8a8e1-18dc-8090-037c-e5baf9bd45c3@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [BUG] io_uring: defer logic based on shared data
Message-ID: <436eb658-582d-c752-f20a-2f2c43d741a3@gmail.com>
Date:   Fri, 25 Oct 2019 21:13:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a0d8a8e1-18dc-8090-037c-e5baf9bd45c3@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tDmejJ4peNBVPyYXdkaFE9TNjVrV2GM3R"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tDmejJ4peNBVPyYXdkaFE9TNjVrV2GM3R
Content-Type: multipart/mixed; boundary="f5S6ySCGxFe9KbxpQktXptnQIhtSmRNeC";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <436eb658-582d-c752-f20a-2f2c43d741a3@gmail.com>
Subject: Re: [BUG] io_uring: defer logic based on shared data
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
 <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
 <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
 <a0d8a8e1-18dc-8090-037c-e5baf9bd45c3@kernel.dk>
In-Reply-To: <a0d8a8e1-18dc-8090-037c-e5baf9bd45c3@kernel.dk>

--f5S6ySCGxFe9KbxpQktXptnQIhtSmRNeC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 19:57, Jens Axboe wrote:
> On 10/25/19 10:55 AM, Pavel Begunkov wrote:
>> On 25/10/2019 19:44, Jens Axboe wrote:
>>> On 10/25/19 10:40 AM, Pavel Begunkov wrote:
>>>> On 25/10/2019 19:32, Jens Axboe wrote:
>>>>> On 10/25/19 10:27 AM, Jens Axboe wrote:
>>>>>> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>>>>>>> On 25/10/2019 19:03, Jens Axboe wrote:
>>>>>>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>>>>>>> I found 2 problems with __io_sequence_defer().
>>>>>>>>>
>>>>>>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>>>>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace=
, so
>>>>>>>>> it can be maliciously changed.
>>>>>>>>>
>>>>>>>>> see sent liburing test (test/defer *_hung()), which left an unk=
illable
>>>>>>>>> process for me
>>>>>>>>
>>>>>>>> OK, how about the below. I'll split this in two, as it's really =
two
>>>>>>>> separate fixes.
>>>>>>> cached_sq_dropped is good, but I was concerned about cached_cq_ov=
erflow.
>>>>>>> io_cqring_fill_event() can be called in async, so shouldn't we do=
 some
>>>>>>> synchronisation then?
>>>>>>
>>>>>> We should probably make it an atomic just to be on the safe side, =
I'll
>>>>>> update the series.
>>>>>
>>>>> Here we go, patch 1:
>>>>>
>>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3Df2=
a241f596ed9e12b7c8f960e79ccda8053ea294
>>>>>
>>>>> patch 2:
>>>>>
>>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3Db7=
d0297d2df5bfa0d1ecf9d6c66d23676751ef6a
>>>>>
>>>> 1. submit rqs (not yet completed)
>>>> 2. poll_list is empty, inflight =3D 0
>>>> 3. async completed and placed into poll_list
>>>>
>>>> So, poll_list is not empty, but we won't get to polling again.
>>>> At least until someone submitted something.
>>>
>>> But if they are issued, the will sit in ->poll_list as well. That lis=
t
>>> holds both "submitted, but pending" and completed entries.
>>>
>> Missed it, then should work. Thanks!
>=20
> Glad we agree :-)
>=20
>>> + ret =3D iters =3D 0;
>> A small suggestion, could we just initialise it in declaration
>> to be a bit more concise?
>> e.g. int ret =3D 0, iters =3D 0;
>>
>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>> And let me test it as both patches are ready.
>=20
> Sure, I'll make that change and add your reviewed-by. Thanks!
>=20
Stress tested, works well!

Tested-by: Pavel Begunkov <asml.silence@gmail.com>

--=20
Yours sincerely,
Pavel Begunkov


--f5S6ySCGxFe9KbxpQktXptnQIhtSmRNeC--

--tDmejJ4peNBVPyYXdkaFE9TNjVrV2GM3R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2zO1wACgkQWt5b1Glr
+6UOAg/+Id+8kY8W4M63AswXMxDmEysB5tJt8UFZE+hCY8spC6dZZtUZkwGdioDx
/x8BQN8xm2sRX/mKvdgqOAIdoEt0HmbcnQLRKbLt2OsqH8ONw1W+et0sq2fAkCYO
5GrOyYXDzdhGtJnUxtDuyCijvON1h9JW9dxFsbcEnVAkMzvekbMdkg8byqHH6Tyr
0LBqob0nX3RJk8g05UrZZY13hzFFwbTqXRPBakxmptRwxci4/JdEEyq/7Lq5fykP
9Bc+LBpLXqgU6z0c5suSHG09aa8/b3D7eD/0rtqJ701jTxoXh+a+JwXpMzKzboXl
qfdgpl+aME85cg1KBDjpw7bVOBmwycRFuNTr66Ysw2jaLZCw074KRa7f+y2Y34Py
Fti90RugTvSzXktIL69PlAYzrhj6+dbetq+oKeXPSx6znoQIOOVhBbSvWXBOgin1
90KuM16DyKpAlNHIUe0PdpfjuEOYqPjHHtmZng3d6gg4jf7f5IbzAJg164Kxizx8
U2Dnuxrz+DKJEaXJCbHo35DRiTsQMsnbxJ+8+f6u1DMtgnZOLvuStlRjJyZFOFv8
pBO0n+GwvZIWETLfbROJl9CAeAf0BlaHERBkDLASw7/WJ9C6EnzLn3xSbsSwYqh7
4HjBAhRoKOIO0EfSoYXGi/z2Ir0/vuQ7f0CZasEGly0YvFSbxkU=
=DK2a
-----END PGP SIGNATURE-----

--tDmejJ4peNBVPyYXdkaFE9TNjVrV2GM3R--
