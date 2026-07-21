Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916E367B91
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635117; cv=none; b=AdC8QbNAUhrkEblyqizp7VecKuhE+RA3+TimRtb4loq50iRTdg4DV76UXBvPYnTFmONesg8Jj7b2+qy1ySFkCPsA+q0vCGFndxaej2kF4g9VkgXOzTGO9oMrOZZV+zTIxjeKBRTEMvKtQFsl0Duud8FwUxToiYbKD66+hIM5znc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635117; c=relaxed/simple;
	bh=d0Oy5vuTsG2UsvQbhUscQ0E+46wvsBy9tXOtIZMySow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saJmEmjoyomvy3xhldxy7QzoHt5ly7J0HY3HNu8Zk9UuLuLJ8h1znLFhklIS9axdb1WUMYDdKS+Ktc1L/EI5AzxzilHZlyQShSOG73xaUsHCO+Hz69WGFz48JoZ7euRCngwKSXUQ4CxsnBN2dc23jDfX81YV7RzkGA8L1WsaBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eM6ao/Ta; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eM6ao/Ta"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso11980460a12.0
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784635114; x=1785239914; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d0Oy5vuTsG2UsvQbhUscQ0E+46wvsBy9tXOtIZMySow=;
        b=eM6ao/Tay/0DCf1hz7MOToMmquR8gKUaqi4+TJt0wq7g1Wou6eW5KLoenV48Hd00nG
         qfMkq4jr/jHUZPoI+5maN1bNy278Zhybokv+fmWQ9/aspkxrrcmj++4VcKR99IAEiaNo
         jOfkVhKetHNUcYMkVf0uMQXaluBas7V/DrKo5Sf9G0uupC+dk7W7k1+oleyhuE+dCqN2
         rfVdCh3SgGa3KYQp7HmCVWEoy+MAFi5vWaRHR48RX0bjTsqxda1SZbIydy0aBNEr/rER
         w/G9Z28XCFyCKWOK4gEDSbSEDcVL2eqGqJ06XaC0imYa6lJUH4SWXELoY5pEge4P9zpR
         esCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784635114; x=1785239914;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0Oy5vuTsG2UsvQbhUscQ0E+46wvsBy9tXOtIZMySow=;
        b=cuMc5gowAoyIMf0zcx/YjZpLYHD4vwQj4cNc9s5ZInqwpjC98Dyv2tMmCmcsy2wfKG
         f+RPe+XkaIzXNU7WpG1hYJu8aR1C5xUb46zrkfxBBKs+EmUSatlyyvHnzYL3e9cWhJFt
         v4Q1zJuBb8eZvYsiUNpVRT5fpqy8DKmy+xnCy5zHGFjxcoUjJ8Dapvn5DbfBhCdHNPYS
         cy2UahepPEWDFPMPdFbFxKZQxvQ2qJXbfczkmSewtDmHpsNCFLz1TXy4BvFVE5cntP65
         Ldl3JiY3CW69WInrZ2K15s7kyM4WNq1nHcVW+lpTxeNN9g5rI5OpMxO6U/GwZuhUtM4d
         H3+g==
X-Forwarded-Encrypted: i=1; AHgh+RrZCMLLvSpQOlbcMR2iFzI8I0+swK89S3z4sbLi4w86Rf6w3BqwMQvwopQlBzPPpTFCGX9rDVmHaYWiLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1keCIKBXzz+1IClP3NRlZTz2Ee96E/W8jGGqrPbxIDaNQh0p3
	ex6i/+JfLnd4m2uNXTeQSS6rE+HBMA+mP1CsvfBBRf5MBQexpZ5rp2dePJuu/qRDDEI=
X-Gm-Gg: AR+sD12Dpe/AQkeUaRvS5KsNDSfig+N3MV0jEcn0UH1zyeFepa0yCv0QKlAc9xo1qRX
	9cw56L1GrOdmPUI95VnIOd+HGIi7bs+4wUUsJiGRJDEOUdNGmJYeopDvFbDUJmBbGdb4/2eJzbl
	X599adv6eXhkuwUbkQvpepisTqxtOQGMTwYU3EAmkx1gAM+ToVOCzOwrYgoD3wigB1O2cmysX2F
	zovNU2ELPJtKwkoC0O5Cd4K3OY92lZsAUtD92gXAjYJPBuhwF+BfsOWW2sM2snlEXbS0ISpyh0z
	OZllUwDQAvT2In2ieS0J5wF4kTOOCSgfMy2eKXtJOL8eJ7n+EW8Y08bM5T1OPeRyzZCgs8EhoZn
	OHMTgGWkI1Qfq1YeyGs1vitv9h0Xzaq8LFXpgzrecCdNzicrOEtbvXRAO7eleVfiXWGeqBvCSgS
	Ri5iV2ePH30YOoPPuU9BPlvkqhypl8bmmyQaTh/5P2A3SVapr7GhoUF/IO2vDQnKbdpDAyrqBfB
	Jr5VUYFPKfjEsp7RVA/PiVTM/SAEQiB
X-Received: by 2002:a05:6402:2425:b0:69c:3ea3:6d39 with SMTP id 4fb4d7f45d1cf-69e6530e8a2mr6684630a12.35.1784635114070;
        Tue, 21 Jul 2026 04:58:34 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fef2477sm6065212a12.7.2026.07.21.04.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:58:33 -0700 (PDT)
Message-ID: <4545c047-8fad-48b3-a0dc-bb5841506dee@suse.com>
Date: Tue, 21 Jul 2026 13:58:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update my email address
To: Roger Pau Monne <roger@xenproject.org>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260721082321.81212-1-roger@xenproject.org>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260721082321.81212-1-roger@xenproject.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lh59tjigc0GORZXvuJyFRWFv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lh59tjigc0GORZXvuJyFRWFv
Content-Type: multipart/mixed; boundary="------------iPU4FBcALDptvLbJC37L2s6K";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Roger Pau Monne <roger@xenproject.org>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Message-ID: <4545c047-8fad-48b3-a0dc-bb5841506dee@suse.com>
Subject: Re: [PATCH] MAINTAINERS: update my email address
References: <20260721082321.81212-1-roger@xenproject.org>
In-Reply-To: <20260721082321.81212-1-roger@xenproject.org>

--------------iPU4FBcALDptvLbJC37L2s6K
Content-Type: multipart/mixed; boundary="------------ofs10OGrgUtoMGtgr1YVqsjg"

--------------ofs10OGrgUtoMGtgr1YVqsjg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDcuMjYgMTA6MjMsIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToNCj4gU2lnbmVkLW9m
Zi1ieTogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXJAeGVucHJvamVjdC5vcmc+DQo+IC0tLQ0K
PiAgIE1BSU5UQUlORVJTIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMNCj4gaW5kZXggMWFiODczNjg1MGVhLi4wZGFkY2FmZmFiMzEgMTAwNjQ0
DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0yOTM5
OSw3ICsyOTM5OSw3IEBAIEY6CW5ldC94ZHAvDQo+ICAgRjoJdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmLyp4c2sqDQo+ICAgDQo+ICAgWEVOIEJMT0NLIFNVQlNZU1RFTQ0KPiAtTToJ
Um9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+DQo+ICtNOglSb2dlciBQ
YXUgTW9ubsOpIDxyb2dlckB4ZW5wcm9qZWN0Lm9yZz4NCj4gICBMOgl4ZW4tZGV2ZWxAbGlz
dHMueGVucHJvamVjdC5vcmcgKG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQ0KPiAg
IFM6CVN1cHBvcnRlZA0KPiAgIEY6CWRyaXZlcnMvYmxvY2sveGVuKg0KDQpSZXZpZXdlZC1i
eTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------ofs10OGrgUtoMGtgr1YVqsjg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ofs10OGrgUtoMGtgr1YVqsjg--

--------------iPU4FBcALDptvLbJC37L2s6K--

--------------lh59tjigc0GORZXvuJyFRWFv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpfXukFAwAAAAAACgkQsN6d1ii/Ey97
tggAiM6q6mKSyMBdvs9R+pUgtGcWvatoLN808NzfKF19jkF86EDtqoiwMBZH4UKvmELESQumg82Q
gkdVtS1oUr63gDth+9ptf2xd9S9+EnEZoCWq2v0ghJkC7vLf6mqeW2cw6Kc4mmqJZS7eyGv0OQG9
EV1x+a3p+UNNMgpC4pYDl3wLjJWAyYBoFrWN2eMNETxjf1HSIvW6L/8OKa946auA8o9GRp9R/6h0
qhN2wtrCtJlzUuVbK8F/hpCPhqmnvGsYcTSZpBacjSFdxQG2jqx0Z47eCcrE8GJ33fIM2Az7zDKM
gQjSEL5z0mbaGnkc4K1pmDzETU6za1hWvnbnrSwi4w==
=qrQd
-----END PGP SIGNATURE-----

--------------lh59tjigc0GORZXvuJyFRWFv--
