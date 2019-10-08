Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E71C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 20:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16572070B
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 20:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE2gr0lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJHU6b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:58:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54979 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHU6b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 16:58:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so4635317wmp.4;
        Tue, 08 Oct 2019 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=KhVyG1oqyXOZisQbhdA4t8WN7r/MK7Y+MHTNnDP/fLA=;
        b=UE2gr0lw9NM7u42nZOR4hySORAp2gJEGA0goy/v/knvu/ng04NHYZ/9tcvwAOkUt7g
         JrgYPCm7k6VC3tUhBpCd8AalmPtyZAxQwaK811+F7WuvA6PRAs6e1eySJbhL8DbU9rXe
         jM3j9LjKUEO/7U2pa6paKcN1yUjzXxTB2i/59rrF+MIFpWFw5xxD3IOzuyUfebk4g6Re
         NiGYNYapbGxFJhsnNMblR8K3roIwDubHVDccRBb4yNskc7thUr1PYQ7w0dk9cS2VxKlb
         UIdeT+AZVOP/tLYyCna6dnQsK/sCVBM/LTl9KddGUbOSOEGZyJLiBKjzyGAX95WAd/Dk
         cr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=KhVyG1oqyXOZisQbhdA4t8WN7r/MK7Y+MHTNnDP/fLA=;
        b=JLCuamZ2I8dQAmgpuufpGaLdAjlF86eV7/hr1JKeVOhD3fBavUHDra1JK5wsdYi35Z
         +/CT0+aaE3UIbQd8Cu8E1O5gS4tq+Qw/9uekCdIXpFUmhfRrKqUl9DEywuKgvju+FZaT
         1Z0h2CWMUovXiJoGtOPc1TsqSgZQ/UvfAJ2iTFaGKevE6nMtG55b70P0mZc7/n71c3/7
         2Tp6rXL73+jp75p237sF1mP1MsVAYC/AhknpOG39DszVZtgirCvL39MXpKCyNzM3Jufh
         6JVyScsnv2AkdaeY1ljS6OZut0LbUk9QsI15Ln6B70fN+w7vrsDl+DKcyA5aTPsC6kx0
         tDyw==
X-Gm-Message-State: APjAAAXjK5LhpcGnQXVd9an5xgzt/0RYZk75asvpL1fi6dMJYlkA7LOF
        5qKnRXF7wq3fcdd+5eGm4l9wpsBf
X-Google-Smtp-Source: APXvYqyjt4wUFZ+ltVFLM5UJ9djyCOTjBEzMal/faB73PnhcQ3Rz0WchwIfxq9ASc+gcRYsNMF5S2Q==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr5421546wma.111.1570568307562;
        Tue, 08 Oct 2019 13:58:27 -0700 (PDT)
Received: from [192.168.43.219] ([109.126.138.202])
        by smtp.gmail.com with ESMTPSA id a3sm7162332wmc.3.2019.10.08.13.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 13:58:26 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
Message-ID: <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
Date:   Tue, 8 Oct 2019 23:58:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="imql4eltqydCrgLAL9dtbKpVIcHH7vihC"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--imql4eltqydCrgLAL9dtbKpVIcHH7vihC
Content-Type: multipart/mixed; boundary="70ZD2ktFWQNuD4DuGoqolYdN7GUeugA1b";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
In-Reply-To: <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>

--70ZD2ktFWQNuD4DuGoqolYdN7GUeugA1b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/10/2019 20:00, Jens Axboe wrote:
> On 10/8/19 10:43 AM, Pavel Begunkov wrote:
>> On 08/10/2019 06:16, Jens Axboe wrote:
>>> On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
>>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>>
>>>> Any changes interesting to tasks waiting in io_cqring_wait() are
>>>> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs(=
)
>>>> also tries to do that but with no reason, that means spurious wakeup=
s
>>>> every io_free_req() and io_uring_enter().
>>>>
>>>> Just use percpu_ref_put() instead.
>>>
>>> Looks good, this is a leftover from when the ctx teardown used
>>> the waitqueue as well.
>>>
>> BTW, is there a reason for ref-counting in struct io_kiocb? I understa=
nd
>> the idea behind submission reference, but don't see any actual part
>> needing it.
>=20
> In short, it's to prevent the completion running before we're done with=

> the iocb on the submission side.

Yep, that's what I expected. Perhaps I missed something, but what I've
seen following code paths all the way down, it either
1. gets error / completes synchronously and then frees req locally
2. or passes it further (e.g. async list) and never accesses it after


--=20
Yours sincerely,
Pavel Begunkov


--70ZD2ktFWQNuD4DuGoqolYdN7GUeugA1b--

--imql4eltqydCrgLAL9dtbKpVIcHH7vihC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2c+HMACgkQWt5b1Glr
+6X8axAAofnRFDmrBGuHquleJlW+0frnQyZO9B5d2zhwp1rLOLhV3Hqyoy+RjWfO
yWfO2NYHVV71LktpfVHAkBxoDCtl5uo5khdDrMLnml3nuB5tq40nm+I/eVOHiyfY
4Te/c8cbgJrRvdi8J68ans3+z3otCYYwRPdJ8G4ZJjbzdKkkIhYy77jg3REVu6Ga
h4E7xILhPtSxTp7a3uYQ52mHuGE6AiGTgiFDltXT6cJtflfjKIsj9tXfFXMfwE37
nI+Klw/r7tcdtqrRODeH6ax1Sv371A4AnZ8V4wyy3fAD9Ve6TB1z/5BEwC4insDM
e4tTbd0w3zCgEum1WDn/0FNsemNOh+ou94fRHMxE7EfxheZ88GWn64vdV5Ziz6b/
lCBj1hWS+X3SW7X0zQpKS8NJl7YLp0bpabgqvjem4+5c2GnG9muNP9kRqGDRMa40
zkf3ZAV9EN+49Qvv6gO1WOY7YfyNZ1F9R9UA6AncJYj8DTG3zpYahNK2MrSVvgd2
djKZsa+41Q3pwlkOPpZ218hYfXSt0ggsTuB2WJaoqN4uP+4HsNjGGtzfMR8g6eIJ
IXycPmvv0HVvNvwEQ6o1kuQ3lIvqraWfcdcx29ZwET9jyuPkDHx5rfgvKciO1SeH
Ipecyd0rsoemidOb9/o2GO0bOQnDENSvCTRIn2rIY0wZT+fpA+s=
=UdxX
-----END PGP SIGNATURE-----

--imql4eltqydCrgLAL9dtbKpVIcHH7vihC--
