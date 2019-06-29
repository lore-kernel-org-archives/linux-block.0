Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00119C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B914C208E3
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuoCgk3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfF2Pm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:42:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35824 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF2Pm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:42:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so4908716plp.2;
        Sat, 29 Jun 2019 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=gpJbPI6bl+nXp0bBkiKZ8dARbqPZbVsTzRBwm4N0o3I=;
        b=fuoCgk3s9sNhhHbt/9pjpXKmKnR1KnQcACPAMVxh1BfU1yLyY0CXmHAm/CDYHVLE/M
         oWiJG4zqkAy6iLvovbRLhbFEjUX1nIRCBkOs6DTwhZdqTuCJxQI5uMH3t82G/BhY+Erj
         QqBBzPH9z3sV1XYKIodaXBvv9ZFZ/E5bxa1LFygjhat/VtPv6zQW+BrFHZWiCc2sw/2P
         zp1ppPKefxCaERfspxp158IArVajZo3qQGPg0MpJdUCYR6ZiF/uTcIVyWMRZWccZ3VWk
         AZEUwEx+zdu1qU/bCK8cKCCkDrpy34BWYYl/vLAj8dVbWj2WUkfnGShF0Ux9iqfNiFBX
         rjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=gpJbPI6bl+nXp0bBkiKZ8dARbqPZbVsTzRBwm4N0o3I=;
        b=Nz3MJsZjQ5HOggJn6LlKiyQbT8Rrv/FE7X3+w8m8XbkielpGb7QN8/RTSp24EAJ9Pb
         PN+LbBnu6FIcwp1CmkIkiXAA0FEG6MnaajPwcNEa/9GBbATKeJbiI6jkk4laFOIwOqZx
         4jkSGPrTIZb5kXf3gKCZPPT2ls4wJUrjQx26KOR+Oi+2UUuPzsz7D5htp779P+NWyKDT
         fQxW9W/wufNQJeQq5qBC92k0I04gH+UtrBpK9nGoU+4VIXuHnRsla1MD+hjq+JG8wByH
         zKuoIzqQklX/ZtPJnXMiJLELMB+DwkBJMrwBxCJNbi7f3u+hzCIh80lbUkoXhGQiMIGq
         A8ag==
X-Gm-Message-State: APjAAAV0uOMu6GCgYPd1XeML+P8m2RADutut1pInhd+w+5ScCBz25wHf
        Xb1mfi0Oj6QYwVVCtIHoCag7h06C
X-Google-Smtp-Source: APXvYqzuLDBjrZhohKWt/da+mCNK9cgDqB3SckoDmsnuBxWNfuqZWNtqECZ/+F6oYC82iXoK0vf3Kw==
X-Received: by 2002:a17:902:7586:: with SMTP id j6mr18623540pll.128.1561822944838;
        Sat, 29 Jun 2019 08:42:24 -0700 (PDT)
Received: from [172.20.3.188] ([12.206.169.194])
        by smtp.gmail.com with ESMTPSA id m20sm5081301pjn.16.2019.06.29.08.42.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:42:24 -0700 (PDT)
Subject: Re: [PATCH 1/1] sbitmap: Replace cmpxchg with xchg
To:     Jens Axboe <axboe@kernel.dk>, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <0979d23f-bc31-b653-51d0-867dd52bf7ee@gmail.com>
Date:   Sat, 29 Jun 2019 08:42:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uzz2TY5uZnI06xCKH3n3Lp4BlDS8ROpf4"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uzz2TY5uZnI06xCKH3n3Lp4BlDS8ROpf4
Content-Type: multipart/mixed; boundary="FuhgTVb8yfbQS7dziWodTAhy0by58eNYo";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, osandov@fb.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <0979d23f-bc31-b653-51d0-867dd52bf7ee@gmail.com>
Subject: Re: [PATCH 1/1] sbitmap: Replace cmpxchg with xchg
References: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
In-Reply-To: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>

--FuhgTVb8yfbQS7dziWodTAhy0by58eNYo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping?

On 23/05/2019 08:39, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> cmpxchg() with an immediate value could be replaced with less expensive=

> xchg(). The same true if new value don't _depend_ on the old one.
>=20
> In the second block, atomic_cmpxchg() return value isn't checked, so
> after atomic_cmpxchg() ->  atomic_xchg() conversion it could be replace=
d
> with atomic_set(). Comparison with atomic_read() in the second chunk wa=
s
> left as an optimisation (if that was the initial intention).
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  lib/sbitmap.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 155fe38756ec..7d7e0e278523 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -37,9 +37,7 @@ static inline bool sbitmap_deferred_clear(struct sbit=
map *sb, int index)
>  	/*
>  	 * First get a stable cleared mask, setting the old mask to 0.
>  	 */
> -	do {
> -		mask =3D sb->map[index].cleared;
> -	} while (cmpxchg(&sb->map[index].cleared, mask, 0) !=3D mask);
> +	mask =3D xchg(&sb->map[index].cleared, 0);
> =20
>  	/*
>  	 * Now clear the masked bits in our free word
> @@ -527,10 +525,8 @@ static struct sbq_wait_state *sbq_wake_ptr(struct =
sbitmap_queue *sbq)
>  		struct sbq_wait_state *ws =3D &sbq->ws[wake_index];
> =20
>  		if (waitqueue_active(&ws->wait)) {
> -			int o =3D atomic_read(&sbq->wake_index);
> -
> -			if (wake_index !=3D o)
> -				atomic_cmpxchg(&sbq->wake_index, o, wake_index);
> +			if (wake_index !=3D atomic_read(&sbq->wake_index))
> +				atomic_set(&sbq->wake_index, wake_index);
>  			return ws;
>  		}
> =20
>=20

--=20
Yours sincerely,
Pavel Begunkov


--FuhgTVb8yfbQS7dziWodTAhy0by58eNYo--

--uzz2TY5uZnI06xCKH3n3Lp4BlDS8ROpf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl0Xht8ACgkQWt5b1Glr
+6UtHw/+NA/Cl2kUbo540HN/b2x/QpS31C5Jq/4YyHKBPMidCw83E8RS+OB2/Sql
59OOugg8Bvw1ZAym2gM7/Ab6XmZpeWwg+kRSlRzKL9GPjJRg+U+kpz9oDF5WO4w8
qAI8gk+v74rjH8PVuNuwDQPnFiuyVWJA9QmbOf6uTZpuojAXVPWXjqTT2w3bCh1j
XkOFR5LqdXgQEToCF4YJdpgXV4M3Peotk0lr2nA0ojf9NywB9kh/zJTnk1qPq8RY
fSuX4bJwa45y1aduX+AI0jL0l140VUqFx8jcCqyma7nq2eOfTFstkx/4rm6b3Zbg
54OIisWekQy2hiUKDRic/GbnbToDuaFnzebyHacUKX1i/LWDxFtbt2SGF4S4g0kg
Upq0VExbzi9Hfng7FF4NgzbVHkQGOVvZlBtDiW00k3PRzgwq8fPcPywluh1daOle
qyEzKJlGIngBZARMfI9oFL7zpQ4FC+EnHh/m+CQtYzZqW6pcBH8Dyk+myYvxkFpE
CNY1Fjk112Lq5lIcE4ZqNnGDxCsrFq3Bx4Ntq7R72+BjGchaM6yUVpfdQ37YK9m9
+g7u6zKZGN7/vWAaEtcFaSQEcIHPMAUzve5xONylGAJ03zcRq4skYEd7u5rkuWSd
pJUMvgkJUWIoEUZ8HoMhBNmnwyFywcmOlU59F+hMa+AaPOMBNXc=
=UP90
-----END PGP SIGNATURE-----

--uzz2TY5uZnI06xCKH3n3Lp4BlDS8ROpf4--
