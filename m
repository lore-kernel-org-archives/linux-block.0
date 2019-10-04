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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7DC4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED7020873
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbZ+L5w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJDN67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:58:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44736 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388840AbfJDN67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 09:58:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so7301900wrl.11;
        Fri, 04 Oct 2019 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=1b2AxNlcACzMk0U9YNl0uIY6EiVutDPAtGfln84Tf+M=;
        b=nbZ+L5w3tWzQIV8zQuf47tcURw5VkZ0dx3yeSUYgoOlCGzHPX0TUaDmQHfbmeAYb7u
         5xNoQ2Bls1xDxBj5fhahmVnHo86tUVokyt5gt2tQH2QPoK6FLszGl0kkPqqVXXI+1XNU
         4E00uWKvGOPD65Tv98geCWAd+zKYjR93sWh0e/UmLm2quSHw/915PzHeF7KzGe5Ymfb8
         IivKKwDrLKAmeBBPwdxtMxQuBF2+tFJ5FGyoiIYMh7GGSDh0me2hhUn7tRVpuJbA1czz
         Aby6sGgGhjbxFxCyiIkjpXSP0v53ZFiTXMxMMH7+WDMSSsVIrsJ0G2aR3OqBbV2EbUvA
         Lvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=1b2AxNlcACzMk0U9YNl0uIY6EiVutDPAtGfln84Tf+M=;
        b=GBQP4AZte1upS6lnSKcsovLcJZfBNPHeu65aYpZLEKBr7fHdGq220bnOpTp2hfdn6j
         B+e6K7mtY0jZSx1y5FESb3fGqkIVi71zaor8uoIoDClGfUAZhRCgsSxwc0cBqm1GzFKl
         D9ethZIvN2hGlaqx/ohDLLpOkoroAYmPBsMNMyAw+1C/OxIw0ctzh5SxBfg0NAXBFlUh
         vyVqA53ANU7d58CLHBX10Wy249yfhgkqsnSLiOfjlBhfrKe5h8GIXgeLouMBogkswzpr
         Ce7YvXQsLS9QykM4DEWafCh2KiID47NXhQfk3MMvvGTRg9z79nxhiD0HAbxLffaUHnvR
         ItNA==
X-Gm-Message-State: APjAAAVpDrKYpqUW60s95jNRNUDVS/Ab0Dx76PobYwb2J7/EcxKqpxpJ
        1CJhz2yaIUUKT7CI9I+gJENsZfJ5
X-Google-Smtp-Source: APXvYqxFyjMc10K4bMMkPmLX8DbZEmOLkgoMgtlw1SESsK1ObOf8rjbA1kc1id5aKbtqEQS8gVQplg==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr12070182wrn.48.1570197535979;
        Fri, 04 Oct 2019 06:58:55 -0700 (PDT)
Received: from [192.168.43.66] ([109.126.135.5])
        by smtp.gmail.com with ESMTPSA id v8sm8977672wra.79.2019.10.04.06.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:58:55 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
 <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
 <7a18d7d7-323a-5903-2952-814954910ddd@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2] io_uring: Fix reversed nonblock flag
Message-ID: <d3e3b157-c8e7-0e75-099d-9ceea6659bf8@gmail.com>
Date:   Fri, 4 Oct 2019 16:58:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7a18d7d7-323a-5903-2952-814954910ddd@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P30GNLPQK7ompxBYtH8sJO1Nxxkw2bZFn"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P30GNLPQK7ompxBYtH8sJO1Nxxkw2bZFn
Content-Type: multipart/mixed; boundary="h6NnuxY728R3qvpe9lwvjRwAohZq9O3et";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kbuild test robot <lkp@intel.com>
Message-ID: <d3e3b157-c8e7-0e75-099d-9ceea6659bf8@gmail.com>
Subject: Re: [PATCH v2] io_uring: Fix reversed nonblock flag
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
 <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
 <7a18d7d7-323a-5903-2952-814954910ddd@kernel.dk>
In-Reply-To: <7a18d7d7-323a-5903-2952-814954910ddd@kernel.dk>

--h6NnuxY728R3qvpe9lwvjRwAohZq9O3et
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/10/2019 16:05, Jens Axboe wrote:
> On 10/4/19 4:07 AM, Pavel Begunkov (Silence) wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit(=
)
>> passes something opposite.
>>
>> v2: fix build error by test robot: Rebase from custom tree
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   fs/io_uring.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index c934f91c51e9..c909ea2b84e9 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2703,6 +2703,7 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>>   	struct io_kiocb *shadow_req =3D NULL;
>>   	bool prev_was_link =3D false;
>>   	int i, submit =3D 0;
>> +	bool force_nonblock =3D true;
>>  =20
>>   	if (to_submit > IO_PLUG_THRESHOLD) {
>>   		io_submit_state_start(&state, ctx, to_submit);
>> @@ -2710,9 +2711,9 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>>   	}
>>  =20
>>   	for (i =3D 0; i < to_submit; i++) {
>> -		bool force_nonblock =3D true;
>>   		struct sqe_submit s;
>>  =20
>> +		force_nonblock =3D true;
>>   		if (!io_get_sqring(ctx, &s))
>>   			break;
>>  =20
>> @@ -2761,7 +2762,7 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>>  =20
>>   	if (link)
>>   		io_queue_link_head(ctx, link, &link->submit, shadow_req,
>> -					block_for_last);
>> +					force_nonblock);
>>   	if (statep)
>>   		io_submit_state_end(statep);
>=20
> Shouldn't this just be:
>=20
>    		io_queue_link_head(ctx, link, &link->submit, shadow_req,
>  					!block_for_last);
>=20
> We're outside the loop, so by definition at the end of what we need to
> do. We don't need to factor in the fiddling of force_nonblock here,
> it'll be false at this point anyway. Only exception is error handling,
> if the caller asked for more than what was in the ring. Not a big
> deal...

Thanks for explaining this, I'll resend.
Played safe because of breaks in the loop.

--=20
Yours sincerely,
Pavel Begunkov


--h6NnuxY728R3qvpe9lwvjRwAohZq9O3et--

--P30GNLPQK7ompxBYtH8sJO1Nxxkw2bZFn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2XUBkACgkQWt5b1Glr
+6Xgew/8COSy56WLApYkI2MHZC2diOC/3XD7kXv/2MIj3ZCsLeTLt18oPMzDKGro
4nNN+/W44YAL5y/n2N8fwmZc0VSX3iMYaH9VX55Bu5IBTu/Gk9W9f4b3/j81acXj
8P6MQP57+SlaRw0MhuiSLnKpvliz7o/cAFR+I7CBRKW9jAdrQgC3WYlHWDoQeNje
8fsqwOsdE3j6Lc3hrysxtdbSWKqZs+S+LdJsFc4QrT+Bg6WpMted/pyTVBTpS0DV
bul6rTwnRK8B447fqbXn8Zyl/mE2TBqyhQKSX1wuD80x+38gX/Oiq1pBZpAHaPE3
/slnD+4VfXINenGCYpb+9kLyLUI8WwNkN8FKSDoWCVEq0ncidIV0dW9W6Q10+bTa
jEyC8Iwo3+bpJBP2+anwGbbxiOToeY2eugfjrAtgpXYxqbEGJSY1DYi+DmzDzRAC
SpWBYnc+6J/F+ePtTs+ZJlEe+9eY6oaSdxj7+jDS5dytPQ4jDPNB8eoMrMCoE9tY
F8pV7cDbLWDXIp6rnR1TFUwJolaHxUkhn4lYjgetoyHrM/6XZWYC3rj+F5KakbZT
BNwEze8BOaoOtTmfwRK/u7dF8jnMy/PWYEa6gcZ2rG4R3irhi2rcMaL8kBJrqdo2
vcyb+6JEhpNEXEdvg2ltJZNUIWN/vNGDrKAgRsTwzCy3MIGb1pM=
=XGKq
-----END PGP SIGNATURE-----

--P30GNLPQK7ompxBYtH8sJO1Nxxkw2bZFn--
