Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD6C432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEE920732
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 09:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRfxv2QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbfK3JWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 04:22:52 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34569 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfK3JWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 04:22:52 -0500
Received: by mail-wm1-f45.google.com with SMTP id f4so1903835wmj.1;
        Sat, 30 Nov 2019 01:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Qhw4j23ozajxo+UrHG0P2fsF7/+JskhPqMNTwJgkbjk=;
        b=WRfxv2QVPC3WYCVit1l1v6HcnFYNk1+PXrPH8y8mQjxL2el7bm9eB8RykSTCOm1YIP
         fG24Ukncw+AFQcRKGLfG9RkF5zIIiqFaGZE7RrBFPhoDPqcbiGFiFDlvW2ZGN9Zi4vGj
         yFMwmDteMug1w6c7Ch3Sc+6kpGPYLxP6GkKpwPBI+ZAb+ZwJNvnBOGQBFRCxQhgBdcpr
         ii2cDRMruy9mLgxDff6jGZ/7phgPHYtGA7p105XdddWccVHrRFNhYs8I7S1y7jS7nmVg
         VIj0TwgLdy4OYimsCpbKM5/ttLo9Y1mxPIDfQhOzrDs3KxQSByel3OYQqJGHFFkdMEzj
         R/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Qhw4j23ozajxo+UrHG0P2fsF7/+JskhPqMNTwJgkbjk=;
        b=C+Rd7Jh9JEbTnX2VB4OKxLK4V/FrmGhDmKUQo6UsPzkt9RZaa3QJxLOgssdgGjBsmL
         Cyf8QOMLniqJlI0hjWIVajQAagwClklJxZNT21tWHVGgLYV7WByopIKL3no87V+7zrl+
         u+JRMGhH4luB2AP+sk8pK5vcHZRa6mJbxqxK1QY3NleF92hbeI7kwJ4IyQRiadoA6BrP
         nPjLYvtK2u7g5p0UPsi4GcMDa2gIkXcaJvuNi8z6OtLDm0KaCP6lYbaEsooWPppGmgNO
         QTyTKlVKQeT3oMSDkC4SYEyVoIPwKYK4+5kK6GUrNvU1A4QXlBGUs7OKqHYfopyWTjAc
         jhtQ==
X-Gm-Message-State: APjAAAUL/jFWJY3ay5xpmIw7+++LxEYuNdlVokII3Y+7zYtGZHoOW43e
        rAYqu9on4EeZzHQMfnVmxTxiyVIKhh0=
X-Google-Smtp-Source: APXvYqwfQ37VVIHz68wo9ahBaMsDrOCg2Xik9U71iji8f8CszqbjfpYx8hfS9idIN73CblAyNQ8XOg==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr6238908wml.74.1575105769099;
        Sat, 30 Nov 2019 01:22:49 -0800 (PST)
Received: from [192.168.43.11] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id y16sm30073357wro.25.2019.11.30.01.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 01:22:48 -0800 (PST)
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
Message-ID: <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
Date:   Sat, 30 Nov 2019 12:22:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191129232445.GA1331087@rani.riverdale.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KwZwyfJl0orSB4BdMgk6UsqKM5VBI8AvE"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KwZwyfJl0orSB4BdMgk6UsqKM5VBI8AvE
Content-Type: multipart/mixed; boundary="9chfTVu7zDdPjdpOBd3wgkTANRLQuxQB5";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
In-Reply-To: <20191129232445.GA1331087@rani.riverdale.lan>

--9chfTVu7zDdPjdpOBd3wgkTANRLQuxQB5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/11/2019 02:24, Arvind Sankar wrote:
> On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
>> On 30/11/2019 01:17, Arvind Sankar wrote:
>>>
>>> The loop can be simplified a bit further, as done has to be 0 once we=
 go
>>> beyond the current bio_vec. See below for the simplified version.
>>>
>>
>> Thanks for the suggestion! I thought about it, and decided to not
>> for several reasons. I prefer to not fine-tune and give compilers
>> more opportunity to do their job. And it's already fast enough with
>> modern architectures (MOVcc, complex addressing, etc).
>>
>> Also need to consider code clarity and the fact, that this is inline,
>> so should be brief and register-friendly.
>>
>=20
> It should be more register-friendly, as it uses fewer variables, and I
> think it's easier to see what the loop is doing, i.e. that we advance
> one bio_vec per iteration: in the existing code, it takes a bit of
> thinking to see that we won't spend more than one iteration within the
> same bio_vec.

Yeah, may be. It's more the matter of preference then. I don't think
it's simpler, and performance is entirely depends on a compiler and=20
input. But, that's rather subjective and IMHO not worth of time.

Anyway, thanks for thinking this through!

>=20
> I don't see this as fine-tuning, rather simplifying the code. I do agre=
e
> that it's not going to make much difference for performance of the loop=

> itself, as the most common case I think is that we either stay in the
> current bio_vec or advance by one.
>=20
>>
>>> I also check if bi_size became zero so we can skip the rest of the
>>> calculations in that case. If we want to preserve the current behavio=
r of
>>> updating iter->bi_idx and iter->bi_bvec_done even if bi_size is going=
 to
>>> become zero, the loop condition should change to
>>>
>>> 		while (bytes && bytes >=3D cur->bv_len)
>>
>> Probably, it's better to leave it in a consistent state. Shouldn't be
>> a problem, but never know when and who will screw it up.=20
>>
>=20
> The WARN_ONCE case does leave it inconsistent, though that's not
> supposed to happen, so less of a pitfall there.
>=20

But I hope, this WARN_ONCE won't ever happen, but I wouldn't be
suprised by code like:

last_page =3D (bv + iter->idx - 1)->page.=20


--=20
Pavel Begunkov


--9chfTVu7zDdPjdpOBd3wgkTANRLQuxQB5--

--KwZwyfJl0orSB4BdMgk6UsqKM5VBI8AvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3iNNcACgkQWt5b1Glr
+6XHEg/+Ieq8bmnCFhfKCwiK20vU2GsLVAbFsk2TqHExwAZa/hnFxoOHkPE4gItH
YaKSagnfUkCDn3clCgysxJJhLl+uexJel0OW/O02wZyqELS5QkF2uH8SfPgD3Fab
gZ0TtxYKBpPsxVAnUC6jVURhcQJHN0F+NjBZXyKH7YOtUvSCbUGNX9zO4Y3ZQB75
iu+loTMdL0qxFN0VSZgRsQ3W3aqpMjtU1kec6GOwGtb4MiYd+Is5Dr3KcocElJKx
2AqvS40Gx20OKbW8z6DaGVxcy9xakuXuK4HfkcgIAj9TLITN8Z5NxvFt2IxDp9Hq
1jAu+a2a4kHKVGjJz66xJhUVdQXxLJ8SRiSroE57C126UHHyrEE4Mm1XfFphGJTd
axHU7X3+67Apmg4eY4AUJj7dercPXJgF7EwfP2du/nMw9w8zP+ebX84Leoxz8UpL
tAmBFJV79J4/yELGPMnWxlkEbzwWR8g0oKcjAT4clXZVAMUS6Ded8iXfpMjf8TG6
8qQvHQmehbzrfsuGAyAGPGzqchNoNInADqgoBz9ofyFOslBjWw38erm/1bdNGvHb
4kUogAF8B7lHzOe8qyqEcZMNx6k8Pv4+JtkTHiMSQE7SVQwIG33qd+XNLd9Bl2C0
CzxqCUkn5pLhy9kDexsqIcTZo/NhBEud6mXDF3PZyK3l7RkMDp4=
=Xd72
-----END PGP SIGNATURE-----

--KwZwyfJl0orSB4BdMgk6UsqKM5VBI8AvE--
