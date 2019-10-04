Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB73C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B48215EA
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlDUpf/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfJDIcJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:32:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39850 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDIcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 04:32:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so5612776ljj.6;
        Fri, 04 Oct 2019 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=NPQ5cZjeAKLubxvECYH8lKvd804y+Ly8agJKLsQA30A=;
        b=XlDUpf/LQ1ng0doQW6R8Au7b6U7WkZN1JRB/fMdIsJ/1tD9fQnkMcz8cHcRYbpBaNT
         OT3XvKtOLyxT+u7+x/4AV/qTipUYH6l5load3Q0t5m2hPbQFTMMPhdRw0wBvNhBnDyPT
         /K4qUSiZ0PXtV1RwOZ3EFSX003r4eYo2D6HQG02/kExvD2zoPWEG5e4CPKcDEdr0o5Xj
         g4xq8FiTkWoUioDP1QHbClu1ZZUDi+/m3tIQ92BiXWVjmXg63kzYtvq2/VsoazgJj43I
         h6UJ9n7Whw/IAH1YMd/W6Ve542DP3NAleaGa3J/nkUs9/vdDRlrQ5CpIEmQceTLNZC3p
         VYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=NPQ5cZjeAKLubxvECYH8lKvd804y+Ly8agJKLsQA30A=;
        b=EFpXq4tg/lHdDjbPskePlcZSAoMcKPXpONkG1LFXLLGFY/it76ec48AMNbH0Z7CaiQ
         Q+J/oQdYXLxWrpU+w+yGm/uzBgn35cMHeCkuIIkHc8wt/Dapq2JZAbitBiOmjV/jCbzH
         7ascLqkYp8Lnrzekh9oMdwLiuSQAxvA1ySb0NdyXa5Hp8LwIwxyICGYW9jDpoHl4+KNZ
         rMxZk5M+yqgpRf5EwNRifyU+N+6Irkb6qsCHTbrigBQ9owl4MnNqKv9H6cKqFQaOYaw2
         2KfdbKePE58m65nJHWiPrqjSYq0F3W2pc6SCxVdoAtrFx25IoZk68nfNsbvMEt6oFh5Z
         vrfg==
X-Gm-Message-State: APjAAAV43ZSOB6OtwfnswiIGk4br4VV2aJuNIOGeHFFjxhada2TSbhV0
        nR61XCgZpk0eNhfJTqGcRh4M77BE
X-Google-Smtp-Source: APXvYqzLxS7n6FT1JetYlU1lm0Gp1CAIoBnDhgxYjByOima/TEF3aD+tp25sES0XsiSPTFM7uJF4vw==
X-Received: by 2002:a2e:3808:: with SMTP id f8mr8688996lja.7.1570177924558;
        Fri, 04 Oct 2019 01:32:04 -0700 (PDT)
Received: from [192.168.100.64] (mm-61-74-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.74.61])
        by smtp.gmail.com with ESMTPSA id 28sm989185lfy.47.2019.10.04.01.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 01:32:03 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] io_uring: Fix reversed nonblock flag
Message-ID: <cfd89ec4-f632-9274-6982-826bc9f45284@gmail.com>
Date:   Fri, 4 Oct 2019 11:32:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Bw0tPhRScHj7UlXCvIrrxiJmaZn9Ij0bm"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bw0tPhRScHj7UlXCvIrrxiJmaZn9Ij0bm
Content-Type: multipart/mixed; boundary="AJAJmnyxlAO8z74yubWeROTM09DJBPT06";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <cfd89ec4-f632-9274-6982-826bc9f45284@gmail.com>
Subject: Re: [PATCH] io_uring: Fix reversed nonblock flag
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
In-Reply-To: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>

--AJAJmnyxlAO8z74yubWeROTM09DJBPT06
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I haven't followed the code path properly, but it looks strange to me.
Jens, could you take a look?


On 04/10/2019 11:25, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()=

> passes something opposite.
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index c934f91c51e9..ffe66512ca07 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2761,7 +2761,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx=
, unsigned int to_submit,
> =20
>  	if (link)
>  		io_queue_link_head(ctx, link, &link->submit, shadow_req,
> -					block_for_last);
> +					force_nonblock);
>  	if (statep)
>  		io_submit_state_end(statep);
> =20
>=20

--=20
Yours sincerely,
Pavel Begunkov


--AJAJmnyxlAO8z74yubWeROTM09DJBPT06--

--Bw0tPhRScHj7UlXCvIrrxiJmaZn9Ij0bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2XA4YACgkQWt5b1Glr
+6XHTQ/+PGwwouus5oMwpLXP1+9kaNm9TNeWb7RDLjZtiZhYz29BKg1fIwu48Cz3
AiaE5BvhB3p9iXDGo6rgaawjXHVQ6wXzU7FHub6T00gfZC9jycu/IqdgDRpwfp4e
pPisIpljx2fZd7oVNZes0lrtKueTuzozsAPHvg4j5mcbCRS8nnkqvW19daMjlavg
brq7wB5VjD40zSvXS4a64FLgReLhdb8wqcIwdLpymIG6JI+KQsQGX1EDepZHcwyl
Ze3L6FBfa8jbSBud0Kmzr7poaaEZng1inacje8n4P6ukk6lbqjiNrfkFL3Om+B0P
dR5w3XgaLH20l7eStl1eg65frWw9ebDCHzHiAqzzb/P9h9huGKiiipWMMWqG163Q
XWC0x3APpyicd7y/mgabPVxrlWSXqNmcTAfenrhVG/wT8hjflAlyKv3QWd9MeKtB
h4uYloD9O9TIMPQxkfcwr1P5Oi9wgeeLHFvA8zpCi928/s2wQdX1uFplJ6dD4vZi
nRreZsuzTpzcOyToANEo/S9K40pVFp0xhyi0hAWXoIdkq1xuEQkGzwJVQMdcDIQa
hCu3bAwJCrwZaWq7SBSSLPetaTv56AEodtxHW1sOPQ8TFYopTJVILpzUUwr7eUXt
ku5piIHy+te7HVp4g1YRuStYMH0eTUTtHlTMVdQsF3t9umxqGOs=
=U4gt
-----END PGP SIGNATURE-----

--Bw0tPhRScHj7UlXCvIrrxiJmaZn9Ij0bm--
