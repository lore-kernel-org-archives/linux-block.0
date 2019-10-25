Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E5CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3769921D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyRKZsUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfJYPlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:41:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40134 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfJYPlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 11:41:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so2855426wro.7;
        Fri, 25 Oct 2019 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=wYEzynn3rt7rQLSQNoUgSXmg6Ipe410oiaIgCm4TPbE=;
        b=OyRKZsUizMcAVB1VNkg/O4FDcTPB8I/Tdra/lY8N8AdmWtWo3QQ7ZMQG8gL4YSs/uM
         ej9bQ7K1v4aE7XMZK6WQP2QmDBlrakdkVohOWdpntcFZbQNA6f7lBfr8DIEcVXlyTj1y
         VS7GI634PINUQYGittrG0pa83c6yzTlHYI8acZdN4ijRAl1135+ET/YBPLu0spsWjOzy
         pfu47iur72z/hlPVlL+jZIRx+o0NVYYXDpSRiPL9pTsyvQSqUu3v5zbQ4KVVWnEnRVkG
         CRqLLfPAd3kRbrVrwSdIOaWRo/Z9AiouA6Rtaf5MNZdZBu2rhdZ0nQZPk/pkUwPrp9ZD
         4OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=wYEzynn3rt7rQLSQNoUgSXmg6Ipe410oiaIgCm4TPbE=;
        b=UhrvLAYMGTDMYeVSl9/0DuRCY0QYaJeGFMLrCjDYN1rcDRIj0qK4lwYe7Iw9zBA11d
         pVMoDaR82D8isaAb4Yrn8r0ndt+tL7Ie9BfQ6axN1tM49Nx5odQP8Gvc/WAy0kzc1T76
         rZPxSgGeAgEipGqWsMREN5vTQRDtdcLq8D6LSqOMezFLPySbPc8Sx2ODL3D6vXBIXBny
         m/0YrArixyfuzP9fAvbukTZu2D7QPDYFUN4M/Yq50jHLqn0850ZWvb3SD+zXyTUQVz7+
         +vJIe0fYzW8uhs7Z+Nv1dx2OrC6xS2YpNUIXU7VNuXX0zFcdSqqAKzqs2wFQZVhVCEYO
         +cGg==
X-Gm-Message-State: APjAAAWC+WzWCUgPo8XT4+ym4YAyYLzuoZO7OnHMb4h4Bp4MYQHMRZlh
        knIsztIkqfRROCLlm4PY78woKpM6
X-Google-Smtp-Source: APXvYqwgBmbpGD/5Aws8MhKpC/UZOI30fRZBN5bkJ7Ry9EixqGE1GgrCmFYj7qHNEjsSbur2RqTYiA==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr3580204wrs.398.1572018058918;
        Fri, 25 Oct 2019 08:40:58 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id w18sm2835623wrl.75.2019.10.25.08.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:40:58 -0700 (PDT)
Subject: Re: [PATCH liburing 1/1] test/defer: Test deferring with drain and
 links
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b9509294fde6425b000d71613bd352059334c60d.1571995330.git.asml.silence@gmail.com>
 <3d2e8533-6085-b328-7e27-9a5be2027b7f@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <9ec359eb-b639-65a5-4f01-7e7fdfa9a8af@gmail.com>
Date:   Fri, 25 Oct 2019 18:40:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3d2e8533-6085-b328-7e27-9a5be2027b7f@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xtiy6oWrn7CAyC5aJXaj1VJzzBvQsTkYq"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xtiy6oWrn7CAyC5aJXaj1VJzzBvQsTkYq
Content-Type: multipart/mixed; boundary="w9edxVA1ZlgVuhbFhQK3ELJnInNwpRp3A";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <9ec359eb-b639-65a5-4f01-7e7fdfa9a8af@gmail.com>
Subject: Re: [PATCH liburing 1/1] test/defer: Test deferring with drain and
 links
References: <b9509294fde6425b000d71613bd352059334c60d.1571995330.git.asml.silence@gmail.com>
 <3d2e8533-6085-b328-7e27-9a5be2027b7f@kernel.dk>
In-Reply-To: <3d2e8533-6085-b328-7e27-9a5be2027b7f@kernel.dk>

--w9edxVA1ZlgVuhbFhQK3ELJnInNwpRp3A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 18:13, Jens Axboe wrote:
> On 10/25/19 3:48 AM, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> 1. test user_data integrity with cancelled links
>> 2. test the whole link is cancelled by sq_thread
>> 3. hunging io_uring based on koverflow and kdropped
>>
>> Be aware, that this test may leave unkillable user process, or
>> unstopped actively polling kthread.
>=20
> That's fine, that's what the test suite is for! Thanks, applied.

Just found it "a bit uncomfortable", that after several runs
my CPU was doing nothing but polling in vain.

>=20
> BTW, you need to update your liburing repo, you're several tests
> behind and I need to hand apply the test/Makefile every time.
>=20
Sorry for that, will do

--=20
Yours sincerely,
Pavel Begunkov


--w9edxVA1ZlgVuhbFhQK3ELJnInNwpRp3A--

--Xtiy6oWrn7CAyC5aJXaj1VJzzBvQsTkYq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2zF4UACgkQWt5b1Glr
+6UqGg//b43i37rukCMw1oa1k7hmAJa1D8XKWetHVxZeUVfwDwDbTnj9MDZnhQXe
5TCifVb9xQuupOSUzLwmWDLmKrwmmE4M4f+C/yAowtVeulp6Bk8qBhJxy6VFEHGc
mEW8SkQ4D/MbG9TfYg2RnImvCMPQMbVKjHMKl1/lpsnD2CpPkvuj3DCwGJf1ZOLE
1b2nuJc2Xeo0QYtKBL9YXo3aF5Wg1UAIbV3UzHdGEixizp3+HO8zN3O5tMFrb78J
WklwnMff99fm/0viKkGIUDBapWUEIPNyRGfO3YJGuduqGX/AvhlTTjMMX8HxVgAH
icT7X/ZaQBNhrW5O0dQMZN5lKwC1PrtoLR2FRru/R0fXxr1MiCNW3THiW+aGH5z2
R6oguxTD7e1ur0UeHHMAYOz+7SqFophL87K5LoRHVSR3CRQXx+mw5QzaIw5eHokS
jjijlYIM9AxYs0Ld+cL9yvb39tPXAycdRNQjJIf5X9uhAUxVFdfgpp67C1dQgBJY
EFiwR3zOpBbRCxBjWFvN+4Tt2o9/3EcMeOlF23I/uuunMCrFODYBZYFCnGPfcP7q
rXb3H0N8Ijn71XTXmH6b1leVBN5SH+84C6utcQ/y1VkhjlE44DoMjfZq7agqmlOg
JlYjwTSEXJkOxNpNTTOgIkxZydv3CAu6BlrFsbe35hAxDtAYI/Q=
=A2ji
-----END PGP SIGNATURE-----

--Xtiy6oWrn7CAyC5aJXaj1VJzzBvQsTkYq--
