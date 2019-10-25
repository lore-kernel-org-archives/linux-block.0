Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F0CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6429921D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlhUSfKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633107AbfJYQkk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:40:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37851 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633105AbfJYQkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:40:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id q130so2652188wme.2;
        Fri, 25 Oct 2019 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Mfo/BfU2EL7FSUaTgsXgC0wyVjMtB28HbAwaKiuUEhw=;
        b=GlhUSfKV/2z+EE36/SrYztfoqgZwMq7CkJGIsq/VDdkqEFww9YdpRysEuOhm+OpacF
         f739qysSSG0kAY83jg7S9GWBvlCeuXyQDlsb4+iwpQwznpN3VXQmxmdNXJxQ16q48gJ0
         KFErseMfFiTzRztKlhu69O7fQ51Wzqhaoyx//EfPH1SInE3dv1LwkreTlJfSwy/kUUi1
         gEtFEUPZZGeXrteosgzKb5KHgoVXwb8EN8qicaxv/UPqaJf9lA0O1ZeZkgaZaG0S3MlA
         oXFaQeyytlo5/fS4iVpbbm2LgJzWEQhDkMbux4aDfLPv1R9nmrlIAKBe7Eog+bBt3cCz
         sJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Mfo/BfU2EL7FSUaTgsXgC0wyVjMtB28HbAwaKiuUEhw=;
        b=J2qRDq4lOw9yTOgWtphEIgtnLLA0OQG3P9vdLI6NLrCnPhlLSCKecZakBYxIgU/B9d
         zTCXyC+tDXpbBedniN0Ryr2WII3nWJJOi3jV/LBJ/d9HNS5GbpahO5stRZv0ut1L01Cf
         troJ1dz1WFdpw5Yia70T71VAJsgUTwtDBqQZetveNJtopmujmKgeOb/kvdwjgsiTlTpd
         QZSnAyQNd1Kx+A3OW2NqqrhBY/7aGIuuxoAujJr4hQXmdfvvzXX/365gqprZQKUnzrcs
         nzUN2a+bKZ6Woe8vXe7QtCyxH8vV9Sd5FIPP0WD8E17PEagw8Y3qVoe89cgSrpNOZ4/I
         jfoA==
X-Gm-Message-State: APjAAAVh1U0hapdiy2UWEFOjbcgUR1Mf1gQNtzMt8RCXr6oYEHGGxr1g
        F/9TJPpLX0BNHS5S73Nr71GR3ior
X-Google-Smtp-Source: APXvYqzxEy0lOFvJ/aGn0kxhS7wL7G9+foJKGZlRMJ/0wVXfWwQzCXLUgYA/5ziW2f4j3mzLoc2oAA==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr4192980wmc.11.1572021636924;
        Fri, 25 Oct 2019 09:40:36 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id 17sm2255012wmg.29.2019.10.25.09.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:40:36 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [BUG] io_uring: defer logic based on shared data
Message-ID: <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
Date:   Fri, 25 Oct 2019 19:40:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wb6vixXjHWBLQL0aiNcZPh0cB85T4ITXv"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wb6vixXjHWBLQL0aiNcZPh0cB85T4ITXv
Content-Type: multipart/mixed; boundary="DvpRx4KljX6yzYynEe9WpMbne6GOEA6TB";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
Subject: Re: [BUG] io_uring: defer logic based on shared data
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
In-Reply-To: <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>

--DvpRx4KljX6yzYynEe9WpMbne6GOEA6TB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 19:32, Jens Axboe wrote:
> On 10/25/19 10:27 AM, Jens Axboe wrote:
>> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>>> On 25/10/2019 19:03, Jens Axboe wrote:
>>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>>> I found 2 problems with __io_sequence_defer().
>>>>>
>>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so=

>>>>> it can be maliciously changed.
>>>>>
>>>>> see sent liburing test (test/defer *_hung()), which left an unkilla=
ble
>>>>> process for me
>>>>
>>>> OK, how about the below. I'll split this in two, as it's really two
>>>> separate fixes.
>>> cached_sq_dropped is good, but I was concerned about cached_cq_overfl=
ow.
>>> io_cqring_fill_event() can be called in async, so shouldn't we do som=
e
>>> synchronisation then?
>>
>> We should probably make it an atomic just to be on the safe side, I'll=

>> update the series.
>=20
> Here we go, patch 1:
>=20
> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3Df2a241=
f596ed9e12b7c8f960e79ccda8053ea294
>=20
> patch 2:
>=20
> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3Db7d029=
7d2df5bfa0d1ecf9d6c66d23676751ef6a
>=20
1. submit rqs (not yet completed)
2. poll_list is empty, inflight =3D 0
3. async completed and placed into poll_list

So, poll_list is not empty, but we won't get to polling again.
At least until someone submitted something.

--=20
Yours sincerely,
Pavel Begunkov


--DvpRx4KljX6yzYynEe9WpMbne6GOEA6TB--

--wb6vixXjHWBLQL0aiNcZPh0cB85T4ITXv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2zJYEACgkQWt5b1Glr
+6Vrdg//dxuY82uWIRnNxVbgWmkiK/cDNvTjuwvEfrshkCo4grayfY7YT4tkZF0O
yI7ogixxrylxoINEjMZBtd4IYaXuHHSt56GUPMTMw8q2ApBcEg5ZADEoXxFtq8hU
eopPKMYzfecY6FGkTkM0gbrlrFhLAgcUNI3qkDGCwSpotaznjMaBQsCdvnzgSyil
DJAN1WtFY2pk6xOYVTR97eXEq/n4Or/K5PBDXeNMB4bSDoAjDxq1+gIY6xGvdpbq
AO24h+ckeFqdDPZInHHz7z7++gQhFvu0vIyrkIQDqIwH9rIjx17oyAkQZCdG2OqM
CoTjR0JuCzR3OcPBTbPeDKAqjL6FTjR+hR0DX1NUAu7kj6MoRdWQ3YkDfmXP/Rfh
UbN2wgBcpOLzxzxBsp3SNOEII/WTRMy23edMZsqfRAhbjbySXxkwGLLgUKMMCYv3
f5gI6iNTOuJE99OkhDKUTfhiurLYCMWrvBeA+DyP3bfCTTz6wrI+t5/Nq9sEWW0z
5seIu/dowvFzdLtkQXqoXcLjclp1RoEivRr1xoq+nn00sfw0anMf+U3yKOdsAP73
y28XZbmkSLci3Rm3/9cpscd7zw8D4NKW4yCM/n3SKL4jd8x1yw3wzgw/g93dG2E1
0vUKqKAyaUv1cIKRhpvkYtAswgnEFecDkGl/WEF5IbolANBFIVk=
=uGsX
-----END PGP SIGNATURE-----

--wb6vixXjHWBLQL0aiNcZPh0cB85T4ITXv--
