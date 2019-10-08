Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB4C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 16:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B31217D7
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVxD0KlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfJHQnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:43:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfJHQnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 12:43:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so2772050wmc.1;
        Tue, 08 Oct 2019 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=OykkNXCy5PK1k0apMLzKAwMrOuslEtQSur8czIWDomY=;
        b=UVxD0KlO5gu9E+82OgC7TTOA+3ZuKXyhsiJsFWdKr577+b6mxaSwhQVQYWQ6ijdkDr
         uuaKjnoxc+0H+yUkZ4ybrTrfTFudmtp9lIVoWQQBi/PAgmoks2h8mpZMoCsrmnB1oEqa
         b549BAhZJfU95bci2nqCtezLSNLhMmQ1NuSnfxxAEA18qnFMSXHWdHrE0cgVY3zaqt6F
         lEqAQE8GkpNh/TWuCxPeNWYbd3V4ToHi9SQeneiFZlPIAG9gc2XMmDTPW6Y8ptNWqUhc
         +5hLWj2lzI+9wsSwAD2EaopDNf8LUOXWiOQw6h7aOoMw4pHVcNBhrA3vEKku0CiZJeQA
         mexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=OykkNXCy5PK1k0apMLzKAwMrOuslEtQSur8czIWDomY=;
        b=eHp6gg1P+QqtHNtV/L+bD+q/MouQPXiJREUaek6tx9Xb/okX0pHh3SBAyUdc/bxFs/
         GhPI9I2Euvshjqc4Bp9zU2Jvy3IpWSk3oJlJKr1Rho25OKEzpt6niMQOxIz44VEtfz+K
         ogYVa1GerA8Diq9ljThLasVtWMaZu7mds4IPoFsqkndEWhUA9A72PaVYim90uJR56wZv
         sjGU7fnZDYh/0nU0dP0QcQM8iKc8pdicAYzetLYTgQSDpWD+gtrGZZYi/lA4Bo8Pw46M
         66J0L6aR/Pih4zizg1u+PfSO05yCC0/NBiyrOz0YyzpFuuJVZbQSqE/rJiicdwm93PiG
         zgLA==
X-Gm-Message-State: APjAAAUxTgK1ByIaAyINnQfuDX8HaAjM0bPncSKtrmoaBpVKWNgJEuLu
        8RojHum6Uq1QxiQVr+WQ3sXy7Mg9
X-Google-Smtp-Source: APXvYqyB7tWMuAZqZIwOG/p84gmh+/OWWX3Gt1yAk8LMXlOd2rBBt6eZCpLVfDesF9CjQyrjdXTVZg==
X-Received: by 2002:a1c:7fcc:: with SMTP id a195mr4683336wmd.27.1570553001324;
        Tue, 08 Oct 2019 09:43:21 -0700 (PDT)
Received: from [192.168.43.133] ([109.126.138.202])
        by smtp.gmail.com with ESMTPSA id z125sm3877572wme.37.2019.10.08.09.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:43:20 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
Message-ID: <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
Date:   Tue, 8 Oct 2019 19:43:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hLu72yIEVK9xBJIR5otQrTc17jYRh5NPx"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hLu72yIEVK9xBJIR5otQrTc17jYRh5NPx
Content-Type: multipart/mixed; boundary="2iADUy5gFpKbFUgaLFu9N6SXPlkEiUQwB";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
In-Reply-To: <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>

--2iADUy5gFpKbFUgaLFu9N6SXPlkEiUQwB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/10/2019 06:16, Jens Axboe wrote:
> On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Any changes interesting to tasks waiting in io_cqring_wait() are
>> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs()
>> also tries to do that but with no reason, that means spurious wakeups
>> every io_free_req() and io_uring_enter().
>>
>> Just use percpu_ref_put() instead.
>=20
> Looks good, this is a leftover from when the ctx teardown used
> the waitqueue as well.
>=20
BTW, is there a reason for ref-counting in struct io_kiocb? I understand
the idea behind submission reference, but don't see any actual part
needing it.

Tested with another ref-counting patch and got +5-8% to
nops performance.


--=20
Yours sincerely,
Pavel Begunkov


--2iADUy5gFpKbFUgaLFu9N6SXPlkEiUQwB--

--hLu72yIEVK9xBJIR5otQrTc17jYRh5NPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2cvKgACgkQWt5b1Glr
+6XVlA//X8GGiOoLXlFyQO5BZ9N3oU4Qr0hmy3II+7MJFnaD9+idQxE2xbROePEI
k0XyR064RJ53xEiP3t8aYrZ1BEpBSMb8pzWUYY5rydmLaCzXIbVVEKKCe8c0ox4D
EZUvNI4y7eNF+5PO2fIEcktl5sBeq764yLEQbuGJZFAq2BXU3bHtmg3/zjfj/8Fe
DfbNn7cscjFtgY3PFDy7rnCNlquGpbZKBtfXz6YH0s7Qz99LjRRSfU/2RLDjThqV
cuZkdgBj3S+oeRXw8phnHLEhGOe49F90Odi4qVqQg5DoafV4zxB90d9RpqdCbIDs
cam6wI2PoLBpYiE97uZzs0WxK/ic8yOfPI35zlzlrKq5gVD+q2rUhYsVGPYiy+j2
QZ5UHQE60VLZ4h+C0dKgxMsFs23JbaDqp+8HIUujoTbVuFnqQFUjiEBKInKLc2hq
66izvZxsH9HzmTgR3KAiJWq2z9+Pun7KknxOV5Fy/NczD+POoido7t/mTVcotiyq
1tNvj5Z8HHfAcZf2VnsVa96n8eHdYH5nltML1pHiqj/WEazACq1eRLYMWr5g0Wcn
RICsH1bOLwX5XVUXSsDnckyyllJRassam42NtKqgdlYzJfeL046TgugLB3gvkwSi
1z3QxdHGiRAi82halG1Icf4yr0AcspYkPBXyzbPICTlwZX4Q3+8=
=VKL6
-----END PGP SIGNATURE-----

--hLu72yIEVK9xBJIR5otQrTc17jYRh5NPx--
