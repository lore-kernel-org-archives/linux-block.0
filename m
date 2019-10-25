Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49260CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13251222BD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikG+Qy7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502588AbfJYQzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:55:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfJYQzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:55:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so3121303wro.7;
        Fri, 25 Oct 2019 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=+26/Ar9cTG9Hh1vjUEV5zDdPiLg86ysd6ifDvgpwm3M=;
        b=ikG+Qy7ITFbLrrZn/9iW/ypSgP4djjAtm1hxQ4rGsM+XLNKzQGEnf+tQ7TW4uY3nmo
         bYdFBdUfQ792TFaAOagBY/FViUdcxdAx72EoKAXJXBaKO0PyQn7UQFfvkRRB9QEGd0rx
         CIJglX93xT9JqYXZz4bMMqcsM0DvyYrqzX0ymqwn42w87CCFhC+eQcA74HhHOOdOnmIx
         H35BRpnchLnmOW8riYlybpGzidLtrOerrMnUaHq7bxYoPd1DlLGBBzibtDIj632Aow8b
         FVlUXGgM7aotdperwAtysk6wdwJgbAYMe/Y8AWo1wMvqE0aV2UzLHk719xJBMN5moYnr
         9Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=+26/Ar9cTG9Hh1vjUEV5zDdPiLg86ysd6ifDvgpwm3M=;
        b=Z1/rI/c/c7lFA8PE+NjNosyWQnyTWXQ0FGKAbiGX62s8veD06MwpbBM3kgZ8pC3uSw
         QKh8CICH0EYvbMldAZWNn/DQk9JpH3auUKcB+D8cMaF6JBl4MDLOE8+OEWWdjZcvCNuP
         pGcnacpfDFzEHMFeZ3jw/KBeqsat6iVe2hHJke/06DkT5SWLM6RyIOvc2W30KaJKkEKV
         q+EwppgF9aZesFSuIXa9fiEgqKIHYQT2Bp65ZcZOkmNqug2i2i1ab7MSc8lcgcLzOjtY
         iNmhjdda1kWZRI7BeVS1nXhcH10i7BJKnfww2B4A73j4ATfyURFY9ap+ucvRGDMlgz6g
         D2dw==
X-Gm-Message-State: APjAAAWmxg9lPyN4gAIP6FWgJ4RVJlWPB3p9BwvGqyu2aQMsMqJZ9soj
        gmw8IRw1j/mjO49dLlHGejCV5XI9
X-Google-Smtp-Source: APXvYqxSlB1UfwYIGCdCW9zl+vlOMKOl1LNevgy3Q/JP1gE3gqV/ZZnHW3WG5W7WFdRUkldSpxqqWQ==
X-Received: by 2002:adf:dd87:: with SMTP id x7mr3881514wrl.278.1572022529490;
        Fri, 25 Oct 2019 09:55:29 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id h205sm2950531wmf.35.2019.10.25.09.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:55:28 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
 <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [BUG] io_uring: defer logic based on shared data
Message-ID: <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
Date:   Fri, 25 Oct 2019 19:55:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="meSF8ThqZLkwy3XjkXPmjBCU4HBc6zfU4"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--meSF8ThqZLkwy3XjkXPmjBCU4HBc6zfU4
Content-Type: multipart/mixed; boundary="8cbjtZu6nsSd9Z3jIXL0K8ax2yTdepJFD";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
Subject: Re: [BUG] io_uring: defer logic based on shared data
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
 <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
In-Reply-To: <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>

--8cbjtZu6nsSd9Z3jIXL0K8ax2yTdepJFD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 19:44, Jens Axboe wrote:
> On 10/25/19 10:40 AM, Pavel Begunkov wrote:
>> On 25/10/2019 19:32, Jens Axboe wrote:
>>> On 10/25/19 10:27 AM, Jens Axboe wrote:
>>>> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>>>>> On 25/10/2019 19:03, Jens Axboe wrote:
>>>>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>>>>> I found 2 problems with __io_sequence_defer().
>>>>>>>
>>>>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, =
so
>>>>>>> it can be maliciously changed.
>>>>>>>
>>>>>>> see sent liburing test (test/defer *_hung()), which left an unkil=
lable
>>>>>>> process for me
>>>>>>
>>>>>> OK, how about the below. I'll split this in two, as it's really tw=
o
>>>>>> separate fixes.
>>>>> cached_sq_dropped is good, but I was concerned about cached_cq_over=
flow.
>>>>> io_cqring_fill_event() can be called in async, so shouldn't we do s=
ome
>>>>> synchronisation then?
>>>>
>>>> We should probably make it an atomic just to be on the safe side, I'=
ll
>>>> update the series.
>>>
>>> Here we go, patch 1:
>>>
>>> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3Df2a2=
41f596ed9e12b7c8f960e79ccda8053ea294
>>>
>>> patch 2:
>>>
>>> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3Db7d0=
297d2df5bfa0d1ecf9d6c66d23676751ef6a
>>>
>> 1. submit rqs (not yet completed)
>> 2. poll_list is empty, inflight =3D 0
>> 3. async completed and placed into poll_list
>>
>> So, poll_list is not empty, but we won't get to polling again.
>> At least until someone submitted something.
>=20
> But if they are issued, the will sit in ->poll_list as well. That list
> holds both "submitted, but pending" and completed entries.
>=20
Missed it, then should work. Thanks!

> + ret =3D iters =3D 0;
A small suggestion, could we just initialise it in declaration
to be a bit more concise?
e.g. int ret =3D 0, iters =3D 0;=20

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
And let me test it as both patches are ready.

--=20
Yours sincerely,
Pavel Begunkov


--8cbjtZu6nsSd9Z3jIXL0K8ax2yTdepJFD--

--meSF8ThqZLkwy3XjkXPmjBCU4HBc6zfU4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2zKPEACgkQWt5b1Glr
+6WY9xAApA/8lOF88RBWaaOKQJ6/xNjJZp+POTQp6hqDYumk1KyxZTCUOOuj4BuI
2GFfKoYAHdvy3AhqNMnD+DtL7PKV0kzBqjwfs6iO8Glhhe/Ex7ec9/Ix+CV6taCJ
MTrF6zLQ4UbaWKOuMuAPiEmiEMvLrZxoT6723S71mH2RKWQGf7A3BTLNa1lwsKLl
GEGnukBB3iLhs4p2rwCfJoodeA5dkwE6E/RhCJCTQJ0EWSw3vToz+IEHSOhnarc4
7P61D4LEoKHAh4d4aXP2LCRX3e1JSIPybWnJPV/Vy3TD1BfaCyj2et47xhmc6CwT
9fW8XLFHV+dWHFI0KFwi1uXB48hxEsqmCggS2HzvFhEtHjvwX7QcDv/wUrb4pPWq
72TVOPrChPHOdm98k7wrs/HDQN4xvR+clYHcoV0ec/KOUJ9TCsf6nMinpHCtI6g7
XSgNTxP1NsAlk1gcvKfonj0MO60tDocFSeg8OEgMVBw8CjgSLAfwh/AKBAk4bFIV
L6T2dlJZarg0XAE8o4eKYhIig2HBFH4Yb2UjsoyTI5xr2Q076633/BotVgy9/Dw2
RXe+wRSyg8rLJPnF1Abq9ZNg8yO5YknCLDf20cP4bELJPBqO8xff3u+2sd8RPiVt
zv7NqBE1IC6kHtNQLQpvz01NKtmtK0lIOZMlcDVYWm6F4+4pncA=
=NA7N
-----END PGP SIGNATURE-----

--meSF8ThqZLkwy3XjkXPmjBCU4HBc6zfU4--
