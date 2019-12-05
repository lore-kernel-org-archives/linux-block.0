Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DDC43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF0F20675
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll6ddSr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfLENTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:19:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39756 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLENTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 08:19:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so3644803wmh.4;
        Thu, 05 Dec 2019 05:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=offnvkSoi10d30Lg1V/THeACMkBFadrrSknxxq7jyUI=;
        b=Ll6ddSr1FlfGF6soUSMyBIsi57In/jCBS1WdS/DrYVV4xjFLvw4s+Hwtf5ipXVeH9Z
         JCmbGOd1BpniagDawGicq36cMeuppBER+DwsOGycsdCkAw7groLkLjfVgCm4/7ohjMAM
         ONAuAYMpGWjuJcdGb+ev4sR2JldQBawgUSbQQsq1YVb5JOCxzNXcLCMpC0GegmraukHD
         AxP0lTSREIjhoo6w7gWWByq/2fKQ1eRLZDgvGv5ibN/+2k7qwDvdtCIl3Ky3LlE6CdHg
         ukB+Kvu2WYjjbJjOZxVk4FieERJ+/fQrCnbcgL+c3AAe09lc57EaWWwKQHtVcHRgpwDV
         l+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=offnvkSoi10d30Lg1V/THeACMkBFadrrSknxxq7jyUI=;
        b=S5tNn334+a71hYoolCvbf5L80o9Z9RAnHom+XzF0CBmELnYJtOqQUsOlDvcLfyB+tQ
         S+P0erwNRPeSiuLZS6vENPPeg2Adu7ibMLQVLXJyGMPLdSUMv1BWmXEAJLOYONDj3D/X
         +4pwIxXchLrQAvQy8MUSGsvm30059LC9A9Govw9VEl4L3xK09IsCW1Tin71EshTjtcxJ
         ePG8m4ntZS7UIIwl+yfTllYCGuTtJAfFzQmZQg06VOw/pqQpW9r1lBB9cg3+l/zMyDgq
         1zfdd6F/VD+deGReeF7IB0T8aSvg+wwTC6wLSV/HY3KMbVwK6SOdOc7zUbc+iitI9XMC
         Tjig==
X-Gm-Message-State: APjAAAWyyto76M8RnptJ2BDaeHn5V/naMzrcDjB8gFkkwstBff43fR7i
        h/B7NWE2TZp8MGtt+Y9K0fe1HNAP
X-Google-Smtp-Source: APXvYqyI9ZcYakSo8KyvHM/c3mJW5fj3HFhnOeIT3KN6MfLsHEXAX5YeV2HNx49PxQcPzeryeoSlGA==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr5083033wmc.81.1575551990102;
        Thu, 05 Dec 2019 05:19:50 -0800 (PST)
Received: from [192.168.43.100] ([109.126.146.231])
        by smtp.gmail.com with ESMTPSA id x10sm12249758wrp.58.2019.12.05.05.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 05:19:49 -0800 (PST)
Subject: Re: [PATCH 0/3] blk-mq: optimise plugging
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1574974577.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <da7f8969-b2ee-2bfd-c61c-50f12eb7dc16@gmail.com>
Date:   Thu, 5 Dec 2019 16:19:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <cover.1574974577.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dHuurv8um7Oq5CwLzgdpgh44yvIUJ4ZDH"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dHuurv8um7Oq5CwLzgdpgh44yvIUJ4ZDH
Content-Type: multipart/mixed; boundary="swypTY5e5Tan5CwWPEZUzOigmmel2IWCs";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <da7f8969-b2ee-2bfd-c61c-50f12eb7dc16@gmail.com>
Subject: Re: [PATCH 0/3] blk-mq: optimise plugging
References: <cover.1574974577.git.asml.silence@gmail.com>
In-Reply-To: <cover.1574974577.git.asml.silence@gmail.com>

--swypTY5e5Tan5CwWPEZUzOigmmel2IWCs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29/11/2019 00:11, Pavel Begunkov wrote:
> Clean and optimise blk_mq_flush_plug_list().
>=20
ping

> Pavel Begunkov (3):
>   blk-mq: optimise rq sort function
>   list: introduce list_for_each_continue()
>   blk-mq: optimise blk_mq_flush_plug_list()
>=20
>  block/blk-mq.c       | 69 +++++++++++++++-----------------------------=

>  include/linux/list.h | 10 +++++++
>  2 files changed, 33 insertions(+), 46 deletions(-)
>=20

--=20
Pavel Begunkov


--swypTY5e5Tan5CwWPEZUzOigmmel2IWCs--

--dHuurv8um7Oq5CwLzgdpgh44yvIUJ4ZDH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3pA+IACgkQWt5b1Glr
+6Uhhw/+NNf+lB2ZaR8m7J0WPqlTBhMk2pxNbkoSdA41qpAZgwEpvmIvM2Jiwy4u
rlVqhicxZvPKEInrRafcqGsuBDW6yL47AsXwBoPLTnCVc2WpocPWOYbniKa5ZIZY
JaQKmxj/w6hZ40+1MzDsvk+Hk3Y7yhA1bRzifblmA2mUYCZZdh1VeOsa7Psysx4l
/iA2AHBXwY4Jj9etQpW1J70r+jDjasfA61wLRwcXqIO/w2ZsJ7+cjCDEYDDEXy3E
5IzwuQtq2OtC2S8ZM3bgPhqvygor5oTBCuzxGzwgyB0HSktHqIpeGnuIXvPxdUz6
Pl/pZw2PkZn5ICMzdDpD7CL6bUKoJc9mFqdRvGzlLvyHupoi0YPbYJbVDyO0D9j1
4w6oErDQM+r4MWBB8iOmr2rpSrxFpB+uAnM2tnqU7B77WZpiQ/+q5WRU59z/KfgD
ZVo59QayTZhaO2f/KfJMDD79gpU59alTXJGD+A5MEZXL2aFsv0Vm7hNF+V1Xjl0z
Yugogrv1Q7yupE8S/S3XKK8EOcrpnew0L7Qrct4xa7nER9LnqE48WAmz7wigNb4+
UL7kwbFdg2DnZVMWhs6l/4O9/pi6A8z22C5pUlc51WiwuYjab5Va3m0Nznskoa/o
HIETNYZmP3advt3EAK7nADy2c5nM+xefeBhOviOOGQQ+IVeerYs=
=mloA
-----END PGP SIGNATURE-----

--dHuurv8um7Oq5CwLzgdpgh44yvIUJ4ZDH--
