Return-Path: <SRS0=imFw=XJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC225C4CEC7
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 10:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA7620693
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 10:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEBXrn0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfINKLW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Sep 2019 06:11:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36435 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfINKLW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 06:11:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id t3so5201739wmj.1;
        Sat, 14 Sep 2019 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=AntpfjJb+6RUr00R7hxLMBZcAFur0UaZMcMfYGGosJg=;
        b=fEBXrn0A8uxynm4/Owsy0em31/hBNct9IJh630YO1GzJZlIuh6x5kGiPeAJJErsCzi
         3NGXnFLjG3NwjprVywqHEbKQw5DYDLvm3gDqxI8CQEb2s+70J0uAK37FTIe3Y4QcPMAX
         PKFIrlAcG19GczDetW+yZTQKFiWxEWl/DtlupcN7p9p4wnX5SYvWOvjvAf8v0QnW/vUu
         cUsNuG+QMYDN0NqPTnJGWE6Ftfp+SddL03o+J/M4Zcpcl3QCcq7mS7SvktfwWJs94o2E
         XtTlmeCK3tG88DkNFMm2C+u8s9fGWP9eXthwwlefg1FUxoUPeyK083tQAF2/Fzm0l0Bs
         2imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=AntpfjJb+6RUr00R7hxLMBZcAFur0UaZMcMfYGGosJg=;
        b=bVkk7K6umGScynxc0ysrlDyyKhHaHFRGOQOZLyvpdUiR5QzOtsF+1dvHXgc7pPKn7C
         DfjUvtNWBMwLWldazwpdVvYGoltqld3voDauamOwOOfVD1gNg4WyoftaM9h6nj8JMMNr
         QBwsUQs8algXZKW2F/6vcjVTcPsdbF0l3/FUwTDw48pWpBpdHOJ9DLJsSnPKVlIR1B8B
         M5FQ7l9tlyfJBmJVzgb6yvu60jFdTvlWRmylZUKsHJ0QHAip4cpdgTBIHQGdidDsIOMt
         ooTbczLpGOhQDKqL6HbuzdhFcMNs6wJRdLFX1b73rkyNAYHc2Yp6LPs0CCyFua1m3Lqo
         RZZw==
X-Gm-Message-State: APjAAAV+KitdejpIiVIGZ0W2eKwatb1EbW53sEEiIEtSkztAHyhg7uzs
        3j4ZOlTZ3Fqv8Yj42S/hR6+Lc3efj0U=
X-Google-Smtp-Source: APXvYqwfXkgi7kf823flEHp0OEqzX1EcoG+bb6AFPMWB7SZyp6PnzsMCxpmbjk3WQdCSZNIJrrMZiw==
X-Received: by 2002:a1c:7902:: with SMTP id l2mr6665209wme.55.1568455878951;
        Sat, 14 Sep 2019 03:11:18 -0700 (PDT)
Received: from [192.168.43.11] ([109.126.145.74])
        by smtp.gmail.com with ESMTPSA id e30sm58062825wra.48.2019.09.14.03.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 03:11:18 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1568413210.git.asml.silence@gmail.com>
 <af5ba045-2ea8-b213-3625-354c10334540@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RFC PATCH 0/2] Optimise io_uring completion waiting
Message-ID: <cb105638-2394-5eef-216f-9c6ff918ee59@gmail.com>
Date:   Sat, 14 Sep 2019 13:11:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <af5ba045-2ea8-b213-3625-354c10334540@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1UpWvQKmHjh63s1q2D5QaIWPw37539xMm"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1UpWvQKmHjh63s1q2D5QaIWPw37539xMm
Content-Type: multipart/mixed; boundary="n83DNlQnNXXTEpVorGmAy12v3UslHPoME";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <cb105638-2394-5eef-216f-9c6ff918ee59@gmail.com>
Subject: Re: [RFC PATCH 0/2] Optimise io_uring completion waiting
References: <cover.1568413210.git.asml.silence@gmail.com>
 <af5ba045-2ea8-b213-3625-354c10334540@kernel.dk>
In-Reply-To: <af5ba045-2ea8-b213-3625-354c10334540@kernel.dk>

--n83DNlQnNXXTEpVorGmAy12v3UslHPoME
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

It solves much of the problem, though still have overhead on traversing
a wait queue + indirect calls for checking.

I've been thinking to either
1. create n wait queues and bucketing waiter. E.g. log2(min_events)
bucketing  would remove at least half of such calls for arbitary
min_events and all if min_events is pow2.

2. or dig deeper and add custom wake_up with perhaps sorted wait_queue.
As I see it, it's pretty bulky and over-engineered, but maybe somebody
knows an easier way?

Anyway, I don't have performance numbers for that, so don't know if this
would be justified.


On 14/09/2019 03:31, Jens Axboe wrote:
> On 9/13/19 4:28 PM, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> There could be a lot of overhead within generic wait_event_*() used fo=
r
>> waiting for large number of completions. The patchset removes much of
>> it by using custom wait event (wait_threshold).
>>
>> Synthetic test showed ~40% performance boost. (see patch 2)
>=20
> Nifty, from an io_uring perspective, I like this a lot.
>=20
> The core changes needed to support it look fine as well. I'll await
> Peter/Ingo's comments on it.
>=20

--=20
Yours sincerely,
Pavel Begunkov


--n83DNlQnNXXTEpVorGmAy12v3UslHPoME--

--1UpWvQKmHjh63s1q2D5QaIWPw37539xMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl18vMEACgkQWt5b1Glr
+6XnSw/7BNkPkh3Nd7JZKz/MxlxlDO9WJViWrafCx0DwriU7WUd3uE1u0cEda+hJ
lv/biGOrIkhsFFBlnx7e//XdiliS6U9oYRE/2tuyts+bTKnbRvjKHApRFQO8fguO
jBHbfUcXVANMq6O3CgeTzPOstPeXvU0va9Ey69AuWQQy1k7bZpn/8PJdTp7vn8l5
aSfX3m/lobS5BG43jh0eThhghjHwwZdj4dybcP2Mzp2yuwzbxkERHIhR0jWN4Tt9
Ngk43SYx8MHaS3X0incND2QR7ZaU0K58ztUf33U+umzV8kLRImiRX2nJu31wHv5g
p9GbcUft6YBI6f5oO9Vh6VbxvCYoMenFkhEovf4aunxlDBLMUKFOuF6kfVg4E/oE
tskpU2pn88USu0Yzc9ROOilOgBUhruVxToJCErgeQQFRzkI5+xlfAQ6HXmefDWhH
ioUOmG5EFxXj8w+Pqjof13U/KczxANlmNGYNUPz2TEiwDyEpC4MpjzAsgZI65lkW
l0Mv2GnE9sh7qv3gz+2QJhSH4nD0QYMHvHQVAVZ+N6Fq6Bg6fOkzfdLfI6BQT3OV
XrOq8XBGKUK/8hG1r3+eMSGEMlkGg3zviov/Z83WznhvgEgc+yYOBtUrkHle0Iue
Jws/PwXpSCl1FpXMPudATZghBG65zM8F1nSHajLlt7qBuzz1Ibg=
=jlm/
-----END PGP SIGNATURE-----

--1UpWvQKmHjh63s1q2D5QaIWPw37539xMm--
