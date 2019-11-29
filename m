Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA723C432C3
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 22:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F27E208E4
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 22:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmBvPvtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK2Wrm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:47:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46477 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK2Wrm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 17:47:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so33445883wrl.13;
        Fri, 29 Nov 2019 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=4VVgUqmSmecvuckjo/Yt9+m9Fx224ys8dZjey61nyUY=;
        b=tmBvPvtL1KsNa5bCozINffvOr89UTSQm5x/Twh5Dj1BkcKV3VBxfSz/bSIaknmHQMV
         1ddy3I3CoEvoLHxCE/mykiucSpT/ZkC+rfjsVp/kLLgITyeDepVXDKlhrumbqjTX/5x3
         koBWu888pPWW9LLMfNzdDetw0VcSUkY4y3So58R8CuWxEjQyC8HLqRv+h9DX3STTyzsn
         3cf8VORKziDdKMbg87v/3Zk5+Ot+hPFsjn4+j7rEo87PhbU3lEYOJDveZ8/I+EUJhKpO
         aFD4Fa8CBTBaOZJeyzc51LtRtomBQDH7jnIKXPlArZphc4EQu6b/66PIN/VTagGAP4Ds
         lqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=4VVgUqmSmecvuckjo/Yt9+m9Fx224ys8dZjey61nyUY=;
        b=dQ7P3NOtV3zIwxs7VufFsd2koAcPZ1yqhWCwLtwQ046ydVlUlHLrUPtQ7oMuQ54AqR
         3unL2GJVz+8EFM8ZWCnd3z0EgHJnw0bAeAHx7RtCiJSezTq5YjP/HtpQ9jU0D5E3ZTZI
         zOq7uLcy8RMlY+fZuTwfxd9Rmi7kUS9SKxbBx9sBqQPWMhRpWa4vyMWz4ZbftpKJ6q5p
         EFOZiCw1j1c9IEe8UREM/1e2Qub9xFyJsxuuj34F4jGFdAGWpxNjUd7/wQ+yvTTsYvaw
         RF/+AWwEsNgsXfyC8gNmd8jLDBJUpxdEkQuZmJ6RACdDp1EBIC+NNx7VJn73fvYnc1g4
         t6lw==
X-Gm-Message-State: APjAAAVTnS4hHz1y4WFMWNtxlwPGlu3R2KqMf6Baw/5JOJRJ4XX6kden
        QREGEddn75FByVdc5OJjMgAthATnmA8=
X-Google-Smtp-Source: APXvYqwM7Od64H87C/q1ZU5FBs0SMaXvVfRajwZ8PQKkQBOQCd7QH/D/r0WLBt06Haz2P7dIzeeRIQ==
X-Received: by 2002:adf:e550:: with SMTP id z16mr33484201wrm.315.1575067659133;
        Fri, 29 Nov 2019 14:47:39 -0800 (PST)
Received: from [192.168.43.161] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id v188sm4569346wma.10.2019.11.29.14.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 14:47:38 -0800 (PST)
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
Message-ID: <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
Date:   Sat, 30 Nov 2019 01:47:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191129221709.GA1164864@rani.riverdale.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hy6QMdZ8bYve8HLzTjihAODypEy7EwHFC"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hy6QMdZ8bYve8HLzTjihAODypEy7EwHFC
Content-Type: multipart/mixed; boundary="jXHixpq44PzsMkCcoYiVpdojulr8WwGJO";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
In-Reply-To: <20191129221709.GA1164864@rani.riverdale.lan>

--jXHixpq44PzsMkCcoYiVpdojulr8WwGJO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/11/2019 01:17, Arvind Sankar wrote:
>=20
> The loop can be simplified a bit further, as done has to be 0 once we g=
o
> beyond the current bio_vec. See below for the simplified version.
>=20

Thanks for the suggestion! I thought about it, and decided to not
for several reasons. I prefer to not fine-tune and give compilers
more opportunity to do their job. And it's already fast enough with
modern architectures (MOVcc, complex addressing, etc).

Also need to consider code clarity and the fact, that this is inline,
so should be brief and register-friendly.


> I also check if bi_size became zero so we can skip the rest of the
> calculations in that case. If we want to preserve the current behavior =
of
> updating iter->bi_idx and iter->bi_bvec_done even if bi_size is going t=
o
> become zero, the loop condition should change to
>=20
> 		while (bytes && bytes >=3D cur->bv_len)

Probably, it's better to leave it in a consistent state. Shouldn't be
a problem, but never know when and who will screw it up.=20

>=20
> to ensure that we don't try to access past the end of the bio_vec array=
=2E
>=20
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index a032f01e928c..380d188dfbd2 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -87,25 +87,26 @@ struct bvec_iter_all {
>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  		struct bvec_iter *iter, unsigned bytes)
>  {
> +	unsigned int idx =3D iter->bi_idx;
> +	const struct bio_vec *cur =3D bv + idx;
> +
>  	if (WARN_ONCE(bytes > iter->bi_size,
>  		     "Attempted to advance past end of bvec iter\n")) {
>  		iter->bi_size =3D 0;
>  		return false;
>  	}
> =20
> -	while (bytes) {
> -		const struct bio_vec *cur =3D bv + iter->bi_idx;
> -		unsigned len =3D min3(bytes, iter->bi_size,
> -				    cur->bv_len - iter->bi_bvec_done);
> -
> -		bytes -=3D len;
> -		iter->bi_size -=3D len;
> -		iter->bi_bvec_done +=3D len;
> -
> -		if (iter->bi_bvec_done =3D=3D cur->bv_len) {
> -			iter->bi_bvec_done =3D 0;
> -			iter->bi_idx++;
> +	iter->bi_size -=3D bytes;
> +	if (iter->bi_size !=3D 0) {
> +		bytes +=3D iter->bi_bvec_done;
> +		while (bytes >=3D cur->bv_len) {
> +			bytes -=3D cur->bv_len;
> +			idx++;
> +			cur++;
>  		}
> +
> +		iter->bi_idx =3D idx;
> +		iter->bi_bvec_done =3D bytes;
>  	}
>  	return true;
>  }
>=20

--=20
Pavel Begunkov


--jXHixpq44PzsMkCcoYiVpdojulr8WwGJO--

--Hy6QMdZ8bYve8HLzTjihAODypEy7EwHFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3hn/gACgkQWt5b1Glr
+6VcihAAgJPKsOeKjG/5K99qJ3mx523YwzHZVNkFKCTGILg8pUyXZQ5aZLMHgiYL
eWMdtqxnx9LyYnhNKQKJ8sWAGr1J0esprFspw/Q5QVCvjutjiMKdGay827rI3uE4
LSDkhXiSGVvYNIF9BpQtFjUm8CSfNMfbDp/3vqjojxmhUNW58tX8b4oFBog76yA8
EMkXQ8MogOHIuQUAMQgK4knC5IsMC+nDw7pb36S6YzM/h+KuVm1iIudCoNYMcchS
XCZJYWgUyDxVg3kDOHBIXeT5cRUDgRW2sKYv2jeOpfsfZuxmJcuH0Qgo8TnAV5+L
MwFLnOgJfNrMbnVtC390TVJ88vH6i43YSQKxbrJg9VBH8Bl1ETLV+3wTJNVze8TO
rrjyqVqY8YqenrzKrSjvcA2F4ePQiUC1M2EYEaWLuIGrZS21AZVAD31h1RU5X9IZ
+NV/LylLPeAAeQzJK6vSs5A4+2UoKQvuNJlzO+S+ymPGTQat3LzuIlg9+sFPZ3Of
cGyxFgGtUwXquLm+jogxtEO4tn4dl+Q7Ptpa6yVPTu/tHUitLFY2sxmOTn/JZH06
2zkqfVqt3ISmCR68u0SphDZOHbfolIkv8ZAiJZM/B8XYD5Yrgwv4Zl65JvCSGx3b
GbSZ2GfrF9xI9JpMBn8kohqWL8nMpaE/poPZvPsQoEeF7F1DbDo=
=NYl8
-----END PGP SIGNATURE-----

--Hy6QMdZ8bYve8HLzTjihAODypEy7EwHFC--
