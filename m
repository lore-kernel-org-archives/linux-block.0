Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23240C31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0F2084E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as5+XqJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfFSRft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:35:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44583 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSRft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:35:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so232484lfm.11;
        Wed, 19 Jun 2019 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=NHm7xB5LUXS0s17TzfQaK6KKy/+rzOoNiBvwQqHxzOI=;
        b=as5+XqJ9917Efyyy6IkKnShcrsWNQLrVkLJXgdvGt3f8ghlaUaGIP6Cx/HxH196P5N
         kkz5t+y71peo7pE1cwdxh3eKBf7Hdk283Etr+aAo2bky+GnOToBCGdG0BKtS5+Z+xbIS
         gOsLVMBusTk6yDsRp5/k+lK5spA1V/Ace0sj4jcfoUWg7ZgoBAzoVu40FSCcO5ZIEpTO
         DUo9+Rl8+vxjbZCk/hKIci6RJs1GS88Y9yON5RWbeWVYu+KoprFJYQVxge5mld14pV6n
         07BT+W/KG5utnXd/50OxE9jbYQod+lto/fsUgrcgV0vLS5eF5ol5khA+5U9SyYTRdRh7
         HWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=NHm7xB5LUXS0s17TzfQaK6KKy/+rzOoNiBvwQqHxzOI=;
        b=YMePCxDef3yFpveW0wvQVqguyxviDivHJ6TlFMWb5X90eD5LwLJT2HuLkuhO/aNLxO
         EvQQEdJQRDe1oQGvcB4CS8KNHWUoJPxrazAKEMsrwcq4MLJrXEheNNr3Qr9Z5UJZzkbK
         4y7oQsjn1eIa+6dH+Wprydp3T4+9q+EDbzEQOnKvpLibWGckIZvhTqha3A8X0D3wzc3o
         Oj64sjIVjGKtSGrEIaWBXO32TFFtJvzFE3pMzA+rezCt3We2jp/XpDc2cbtr1COyl7bF
         lc4QqDW2IkNGdAS+jtsdqrxpkBwtY4L6moO/hLaaHUo2I95IHf+A0sr6drOKZ9wG6X+N
         tXPA==
X-Gm-Message-State: APjAAAXVq8xh6TRg96xDFli6B6ylQqe5RkDNa0IuIT+GOVRwPlnoihfZ
        O0wGV+C80FiBRNUxs50nMmOm4xfO
X-Google-Smtp-Source: APXvYqyVpEBzbcLc6PCU87jUaDOxP4i2TWncL0cQ28ZTstwEOjPSKuwr7lMEbAkdv++vfjy7O3nw6A==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr7374204lfy.51.1560965745591;
        Wed, 19 Jun 2019 10:35:45 -0700 (PDT)
Received: from [192.168.100.202] (mm-148-236-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.236.148])
        by smtp.gmail.com with ESMTPSA id 24sm3558662ljs.63.2019.06.19.10.35.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:35:44 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-core: Remove blk_end_request*() declarations
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <b6d25f41-4422-b0e7-8127-0356b35d8fa9@gmail.com>
Date:   Wed, 19 Jun 2019 20:35:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wbisv2a2GG0lU1ZmrXRzQ5G4aYTX0t9pT"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wbisv2a2GG0lU1ZmrXRzQ5G4aYTX0t9pT
Content-Type: multipart/mixed; boundary="M3B98CrXHQos5uTQBXt9E74O8zctoLblx";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <b6d25f41-4422-b0e7-8127-0356b35d8fa9@gmail.com>
Subject: Re: [PATCH 1/1] blk-core: Remove blk_end_request*() declarations
References: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
In-Reply-To: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>

--M3B98CrXHQos5uTQBXt9E74O8zctoLblx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping?

On 23/05/2019 18:43, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> Commit a1ce35fa49852db60fc6e268 ("block: remove dead elevator code")
> deleted blk_end_request() and friends, but some declaration are still
> left. Purge them.
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-core.c       |  2 +-
>  include/linux/blkdev.h | 12 ------------
>  2 files changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 419d600e6637..48ba4783437f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1393,7 +1393,7 @@ EXPORT_SYMBOL_GPL(blk_steal_bios);
>   *
>   *     This special helper function is only for request stacking drive=
rs
>   *     (e.g. request-based dm) so that they can handle partial complet=
ion.
> - *     Actual device drivers should use blk_end_request instead.
> + *     Actual device drivers should use blk_mq_end_request instead.
>   *
>   *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
>   *     %false return from this function.
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1aafeb923e7b..d069b5e2a295 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1021,21 +1021,9 @@ void blk_steal_bios(struct bio_list *list, struc=
t request *rq);
>   *
>   * blk_update_request() completes given number of bytes and updates
>   * the request without completing it.
> - *
> - * blk_end_request() and friends.  __blk_end_request() must be called
> - * with the request queue spinlock acquired.
> - *
> - * Several drivers define their own end_request and call
> - * blk_end_request() for parts of the original function.
> - * This prevents code duplication in drivers.
>   */
>  extern bool blk_update_request(struct request *rq, blk_status_t error,=

>  			       unsigned int nr_bytes);
> -extern void blk_end_request_all(struct request *rq, blk_status_t error=
);
> -extern bool __blk_end_request(struct request *rq, blk_status_t error,
> -			      unsigned int nr_bytes);
> -extern void __blk_end_request_all(struct request *rq, blk_status_t err=
or);
> -extern bool __blk_end_request_cur(struct request *rq, blk_status_t err=
or);
> =20
>  extern void __blk_complete_request(struct request *);
>  extern void blk_abort_request(struct request *);
>=20

--=20
Yours sincerely,
Pavel Begunkov


--M3B98CrXHQos5uTQBXt9E74O8zctoLblx--

--wbisv2a2GG0lU1ZmrXRzQ5G4aYTX0t9pT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl0KcmcACgkQWt5b1Glr
+6W/QBAAps6EoA8cMh38YCszcbkA56Su9gHIXNK399QSmDhRnsfnbjLAnHbJZWI+
D7iDGfM/EqKHdbq3fw/p1EArhp0LzpKxYxRKPpuoSg0SD9m2SihMzdUVRNX792/R
cwX8RoPC1tg4M4FBIg1j92YrS+oWiOVkj05B0OAv+oy22sOmcKOIXul5bSUFNc7R
19pnNkAPatq9OhYqrt49ln6UmuDh5o8c+MxRUGWQr5pRN4dhacbodBLGla0gn7/8
5HIau4k79p0kYg2j8nX2YeOJD4lKPn8G3ZMw6IaGrJxNo/WUSIkfU889LL9Ld6b8
KaYoasYLNAx9q0kW0JPnWb8uEnug5RLD7y0Pa06UphDFRF5t/Nt7cLHmjT9OtOkf
quM9V5C2iKpgHfZy5zvB/E3YwhXbVVZLppvqfgNzGSbrjrNwUJbB4ad7kmVM1YFB
DJ+b5AMiSYw4tm1EhQrz/6R40TqihpNovIkNW8m1RemJ7JVsm+5myF9ziKwiNIc+
tcHdYsYJCGUUNHXTdRmHSSEo1JZa7qLgdKeAoznSbOYVXAw2t8XZviu0RpUMAZPJ
5UknGxlvE6fLLrwILLfloPTMMbu/Ck26WsQfifigZRmqNU0fTCLlOer1JzqdBXFv
UIOTJEwhNg8tBTRghJAszVUFAblSZ/jaMTnJ1JHd4dyWstHnc5k=
=FRcJ
-----END PGP SIGNATURE-----

--wbisv2a2GG0lU1ZmrXRzQ5G4aYTX0t9pT--
