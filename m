Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A028DCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C3F21726
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 16:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3ulVURE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfJ0Qo5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:44:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40497 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfJ0Qo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 12:44:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so6717375wmm.5;
        Sun, 27 Oct 2019 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=BqMb4Og5ZoutQ/OROdKeQdGN52EzODWPmX6ZkRQt7/8=;
        b=d3ulVUREW3/mzD0JEXgiT68HAoDUuhJZ5mCPZh+SQJzE/OFUnApDn9VvRiZ1PGXx6w
         p1ZuB1/LQhUwO7UoNiNh6TZogooFuJN9i8GBQ0koox/sk97ae0gSFKZyM0nshJ+MgJ1P
         HJpOhvmiNMsEgRlXbnW1QSzzZTYqbZA3mdMF1nZndMEXVnMu/j6kVp1L4UcQ3SjQEWf1
         e5AnEXJMsuwQQvFCVhEp1f5meesYD8AeZdI+0+D+uSnn5D8+Eq7IAESM5C5GobMzGKJG
         UicI6sBKLMMbeEl8+UauIvS2IaV0ywEJDAvLzF1wXGQ9MOy4FsPx6JF4EJVvtQkSMGNL
         VWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=BqMb4Og5ZoutQ/OROdKeQdGN52EzODWPmX6ZkRQt7/8=;
        b=XzZNg9yNv0SbBVLj4UKtZmqru6GY6wwduURP/ZitlIZP9dY5KgaHnoRPW/zStI4CJn
         ctTgP0CnC8HXv+fGUnGgwd0I/cyQfHdKXXztkPTpay/u3ASehR8Yw9HERsDAHbunXU6N
         LNWlGcWN3/Rp1Xcz07AcmdQ5Jo8x9Lm1+NCHZVRN2V2YeXrCQJ9W6MJEScqN0iMcOSLV
         FFM2krTEWeMSP23xbmPr4PApofpmmTFRJUBVxlHLfRxmrLo2Mq7ogv5NKDpv+r6TUqyP
         OR990mRugWZu3Kpp0yQUZXjWy5Er0ugjp4jrdtfBIU/3Hb1KpsyBZj29aR/dN3s3dk+r
         xaZA==
X-Gm-Message-State: APjAAAWlXsNhDO53Wnqedb6wzJyf1X5YgV9/EJ4anTCEgxXSdK5sMago
        Ztyvim9UGPc/Wux8tm3V4HrzzHvz
X-Google-Smtp-Source: APXvYqzhYh6H1KCVoI3lMxyz0tRJQPgsjGgsFEaWYUVW89U7a9Nh1+ORJMCBfi0DzEptBrb8ZM2Hpg==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr9919140wmg.71.1572194692684;
        Sun, 27 Oct 2019 09:44:52 -0700 (PDT)
Received: from [192.168.43.222] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id n3sm9592188wrr.50.2019.10.27.09.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:44:52 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
Message-ID: <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
Date:   Sun, 27 Oct 2019 19:44:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iIVjAJtCRP5mHWQwgw1T2aRJlNj31NGRc"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iIVjAJtCRP5mHWQwgw1T2aRJlNj31NGRc
Content-Type: multipart/mixed; boundary="0XPEyzmFFBrM5ojLhve2reCEgJ0k2BGkp";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
In-Reply-To: <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>

--0XPEyzmFFBrM5ojLhve2reCEgJ0k2BGkp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/10/2019 19:32, Jens Axboe wrote:
> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>> A small cleanup of very similar but diverged io_submit_sqes() and
>> io_ring_submit()
>>
>> Pavel Begunkov (2):
>>    io_uring: handle mm_fault outside of submission
>>    io_uring: merge io_submit_sqes and io_ring_submit
>>
>>   fs/io_uring.c | 116 ++++++++++++++----------------------------------=
--
>>   1 file changed, 33 insertions(+), 83 deletions(-)
>=20
> I like the cleanups here, but one thing that seems off is the
> assumption that io_sq_thread() always needs to grab the mm. If
> the sqes processed are just READ/WRITE_FIXED, then it never needs
> to grab the mm.
> Yeah, we removed it to fix bugs. Personally, I think it would be
clearer to do lazy grabbing conditionally, rather than have two
functions. And in this case it's easier to do after merging.

Do you prefer to return it back first?

--=20
Yours sincerely,
Pavel Begunkov


--0XPEyzmFFBrM5ojLhve2reCEgJ0k2BGkp--

--iIVjAJtCRP5mHWQwgw1T2aRJlNj31NGRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl21yX4ACgkQWt5b1Glr
+6WAlg/+PsuhLZSBzMvQIlAa1T1MSlrOcLW7FPej+MHXp5gcKF1HR+Qy5Gp5jdSi
3moAqpvZFPD+4aDGycI9hlsoTmY0aF5NldmWS7nB4alFIXLNfVXuKqTTd46Urp1t
C752lLgFZ2TV+TZ3L2lRDPcaFO/XIJi6my5bcZCP5y8Gx1AeH/KFBbdaJu+sdxzU
Kz/Q++pvTGAAQR0O2ZOqOFrvXMn3bMsRNjEVqJTBtExY0tm6z859S1i4ghfl1o/Q
9uQYaOVa5diC48aDA4OYIonRYUz+J+Im17+hQnrhsEi/uY0EVDqjwdHWKq13nU/X
fTJZkGYQQFIh5MU4STH9snOp/UBWdzSc0vodRCICyH8Y4TI6s6HwTA8jDSLhVoN/
u9j/IzUMcjHeN5Kam/1FUubYno8Ucj0dDoy6RwLJpL8vD5kO4HmaF8omhJlmw6yu
/N5T7LDT9vNy7fmN7/9AQmBTYsUxb/bXK0uYUayMBSrUDmAbVesFudlxuMmAbeBZ
LayoKPngQSQxwN4YQuLmtO+Nv6Ghibs0/y7fDX+V289y8M/BntBLNQE9lN7/VKqJ
aqPHsNrMKhbdrp/iLyJ1vykl4UcxtB07uLDL6edjDWD/8SQLfynauC+g6MTF442h
ubbhr6tJEXg/U9w/BIR1C8iZjJhCk3WM3XwCcxe/KS/6uwIvUlk=
=CxvR
-----END PGP SIGNATURE-----

--iIVjAJtCRP5mHWQwgw1T2aRJlNj31NGRc--
