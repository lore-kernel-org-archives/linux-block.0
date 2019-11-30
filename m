Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA03C432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D2020833
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk2fixfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfK3UM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:12:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44556 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3UM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 15:12:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so2929953wrm.11;
        Sat, 30 Nov 2019 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=XzHpmGtiuRL9SujQ0RyQoQUI57AzXNksp7VOvHtB0hs=;
        b=Qk2fixfwVZfbm4GCXvqQzFttGJPfvUxeWnUcU5BCbwzHjuM9HMzcxyvezPSGhki1sh
         ogctXChECd+jAqPb3RPTRBEUDX4NRkag3q59ftLb6eNtE3luO3eV8w4T1IXzfRVBNbCv
         pY6/ts+gPc1psptLYL/uE4924wynd4meJwUFCu6KNuxboj6pv9p8Sbb7mn1FSQd5Pnwy
         cM6ZlQEt10tOKHzyCxNohqhYDUCpyH8cvek4hYd6gRY+C91y1YkO5v4SAjmI/eQysSkb
         cT+T/7TGr7iyHypVVcwL3cx7tfIBa48v9ZVbKm6Kf9Q4+y4DOw3k2c/+WOGO5ItGgZ0D
         Nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=XzHpmGtiuRL9SujQ0RyQoQUI57AzXNksp7VOvHtB0hs=;
        b=SdD7EUciBi/VoEjMzb15+FEruO2uIB386r6gyCuwK/3iOxTVQ4lK1dKB3HS6VLp64r
         rdxjhhlfYfdIrSi7YcT/ubhrdvC32ooPOZLKBG0eNZQ+gsjm8q7oAwBYodEfZqdYQO2m
         /llhXmrGyf/FOch3+FZVU/7B+dmz8DemnNJmAUmQC+DqLWLqGiHAsseUG9hES6uu06hC
         p6kZZKsEIcbpf0Q018meEPlvDzpL8eR/XKNUQZVjB5g494+EG1rcl5rkmwlhDN+3DWzZ
         GlkNUmhZyytPhLcL0ZtHvlbONAGe8WTuU2xfHMWPgfUoLZK2biqZOIZNNxmPmK93mKZg
         1gmw==
X-Gm-Message-State: APjAAAUJU/wIJMpRtdcUzSXyZc/ftfxV4gL9l88E4RMUrK4QGZrqTYf3
        YNxACZJ9sEGHcA5BT+pFD2DcRgII
X-Google-Smtp-Source: APXvYqw1miJhALEy7B7ydSr+VuMpuWjnO+20FJ4pS7/mD0WgX9bTIxpoiC/paZ1BlNW1G02mdUtHMw==
X-Received: by 2002:a5d:6887:: with SMTP id h7mr30366533wru.397.1575144742059;
        Sat, 30 Nov 2019 12:12:22 -0800 (PST)
Received: from [192.168.43.93] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l26sm17941324wmj.48.2019.11.30.12.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 12:12:21 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
 <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
 <20191130185634.GA1848835@rani.riverdale.lan>
 <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
Message-ID: <84a065b0-956c-460a-3575-260df7117fb8@gmail.com>
Date:   Sat, 30 Nov 2019 23:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kmtfoe3O86m2IMKAGIQUvbpRnmbrx63zy"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kmtfoe3O86m2IMKAGIQUvbpRnmbrx63zy
Content-Type: multipart/mixed; boundary="piXJhDvN1GzmAhNCi5ZsHLVTzVwH7aCfr";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Arvind Sankar <nivedita@alum.mit.edu>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <84a065b0-956c-460a-3575-260df7117fb8@gmail.com>
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
 <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
 <20191130185634.GA1848835@rani.riverdale.lan>
 <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>
In-Reply-To: <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>

--piXJhDvN1GzmAhNCi5ZsHLVTzVwH7aCfr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/11/2019 21:57, Jens Axboe wrote:
> On 11/30/19 10:56 AM, Arvind Sankar wrote:
>> On Sat, Nov 30, 2019 at 12:22:27PM +0300, Pavel Begunkov wrote:
>>> On 30/11/2019 02:24, Arvind Sankar wrote:
>>>> On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
>>>>> On 30/11/2019 01:17, Arvind Sankar wrote:
>>>>>>
>>>>>> The loop can be simplified a bit further, as done has to be 0 once=
 we go
>>>>>> beyond the current bio_vec. See below for the simplified version.
>>>>>>
>>>>>
>>>>> Thanks for the suggestion! I thought about it, and decided to not
>>>>> for several reasons. I prefer to not fine-tune and give compilers
>>>>> more opportunity to do their job. And it's already fast enough with=

>>>>> modern architectures (MOVcc, complex addressing, etc).
>>>>>
>>>>> Also need to consider code clarity and the fact, that this is inlin=
e,
>>>>> so should be brief and register-friendly.
>>>>>
>>>>
>>>> It should be more register-friendly, as it uses fewer variables, and=
 I
>>>> think it's easier to see what the loop is doing, i.e. that we advanc=
e
>>>> one bio_vec per iteration: in the existing code, it takes a bit of
>>>> thinking to see that we won't spend more than one iteration within t=
he
>>>> same bio_vec.
>>>
>>> Yeah, may be. It's more the matter of preference then. I don't think
>>> it's simpler, and performance is entirely depends on a compiler and
>>> input. But, that's rather subjective and IMHO not worth of time.
>>>
>>> Anyway, thanks for thinking this through!
>>>
>>
>> You don't find listing 1 simpler than listing 2? It does save one
>> register, as it doesn't have to keep track of done independently from
>> bytes. This is always going to be the case unless the compiler can
>> eliminate done by transforming Listing 2 into Listing 1. Unfortunately=
,
>> even if it gets much smarter, it's unlikely to be able to do that,
>> because they're equivalent only if there is no overflow, so it would
>> need to know that bytes + iter->bi_bvec_done cannot overflow, and that=

>> iter->bi_bvec_done must be smaller than cur->bv_len initially.
>>
>> Listing 1:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0bytes +=3D iter->bi_bvec_done;
>> =C2=A0=C2=A0=C2=A0=C2=A0while (bytes) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct bio_vec *cur =3D=
 bv + idx;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bytes < cur->bv_len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes -=3D cur->bv_len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx++;
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0iter->bi_idx =3D idx;
>> =C2=A0=C2=A0=C2=A0=C2=A0iter->bi_bvec_done =3D bytes;
>>
>> Listing 2:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0while (bytes) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct bio_vec *cur =3D=
 bv + idx;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int len =3D min(by=
tes, cur->bv_len - done);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes -=3D len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done +=3D len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (done =3D=3D cur->bv_len=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx=
++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 don=
e =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0iter->bi_idx =3D idx;
>> =C2=A0=C2=A0=C2=A0=C2=A0iter->bi_bvec_done =3D done;
>=20
> Have yet to take a closer look (and benchmark) and the patches and
> the generated code, but fwiw I do agree that case #1 is easier to
> read.
>=20
Ok, ok, I'm not keen on bike-shedding. I'll resend a simplified version

--=20
Pavel Begunkov


--piXJhDvN1GzmAhNCi5ZsHLVTzVwH7aCfr--

--kmtfoe3O86m2IMKAGIQUvbpRnmbrx63zy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3izRMACgkQWt5b1Glr
+6X2WQ//edKjZl9P5h9swPp7+NwAxVsQhlJ1f8F04OsvrM5VOckIX+sHRfQo35IO
uk5U9ZAB/07SbqHE3QiQ0go2pWsPPqQHXkWjTqIWtMZM814FaXz/I+fx3fwsegAS
LnTY/1D/zw95PYP/WtYQh76tCo1vIVHgevB8w5LjE1n+pvlG4MN/b1FCVYPMzeeW
z0RbcU0ny9GcuAdz8HkRmrXPDh4W9gA5CaD4WnZbbENfWWLbiYwnlG5e1N7C0X4G
0KWU3p0LE4/UYqYUqZW698gFyoVHCzmQo7PP/V6ydG1LRiFKMyZx8/2I1lYVobdM
ylClkigKG4EHlxAOHm/Kqu7IwjZuHZcDgGClXSxXXQGj9mN2jf588x31uv+3jv+h
KkNA2w6CCsv9ZJApA0iHyqCaXhEMUVBBxCeWp54gLhyuwLEad+TS5e4dzc9I8iCh
rtAfrpDas/NERuowkq6uqYZUvww/mm4cGuq+nvz86t6IgcZH9xWlwbW7020l0fBz
pmm5npRslF5EDpMR/t/fcq+FV67m/8U7nMv2dFewoLNdGG1fYBOgmfkqUPqAVnNr
cS156T2J5eNfdxMVlRuHC3XhPgYcGG2iGtF1xqdjeI36qzBuxWFv++jP5LrmE6eb
yoKg4W2bpoGpOuVQnCwOvoTCWHRhtj6GNXike0sBc6/0fKjsTtQ=
=TEWf
-----END PGP SIGNATURE-----

--kmtfoe3O86m2IMKAGIQUvbpRnmbrx63zy--
