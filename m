Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466933;
	b=CpUI/OZsGlrRC34Sw81h0JX1Q62ftZSDJRSl6hONCPzA/6RB/bGtZKuyb0EP5JmbHZ4S
	 mi7UubNrpn9h+Oo3u2BASMMS88Oz81ON0Eu7AfHTrM99RAL4qZJPPFuE8as70g638+zEC
	 MVJ4XRSC9wzFHBjnwk7CFX6Z9f+nBJPvw14FA0NWBlucFQjyUcmwLeqt0fyPyNZwRvdnx
	 HyGvUtVKJkA8djIbU6spisZtj3Tr2lfX/NxyVKsmGpLoQl0wHOnFy3OukpiBJJlubTMVA
	 EkCVEfSGTBFInglXg05AJl1ChJf7EQ3WyVWOaVEbLkYPlXxU5qM0VIUcKf9UD1m+anA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=/4MtBLSGAeSlREMeMpXOJglcbVkwCt0++4H9V4EMMVM=;
	b=jS4ZSlghYH0V0Wo2kBrG7LwpTXKCQTMSGURCFP8X8Fc0mKyw53eV2LE3T3xwylOOrQCH
	 y8rc+YhK1y1FDtCmw8gOPS27cUgiSf5HXCFuC3HhC7YmGrY7xnZhAtmi67KScLHFrcBIL
	 2sJ0dt5VB3sclhNZ+IyotFhGebWRR0H2qWfLQ8SD/55g+3cMTAKLVJMMRDJrWqtQRjZy8
	 FXKeOwT+nccff1PW4IABIzNq3oHostaBO2AzbidJZ8Ir6jolgh0GjTFVoJ40oXk3bT9cp
	 WnWr6H0EsOjHWuXt17DK+oq0xIisaUyHN3+XAGXbXaYNYBfokUhuG0vwU2j2J6xuI1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Bjvcdfpw;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1A606A321
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 07:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A1A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Bjvcdfpw
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so761065a12.2
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794466931; x=1795071731; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/4MtBLSGAeSlREMeMpXOJglcbVkwCt0++4H9V4EMMVM=;
        b=BjvcdfpwCSBKwnvk9dCuZdO5bKIE7LwAVDFAJ/gmxSf74WWDcshOCc4hWUyXyWXXUr
         4sZTuk4jlequbSGaosO1Aa9C45fjTvXFUCFwQ/9zmPG8TnCwSWyOtFW1WxdYViy06yTc
         HyFX1dQtACLjFDtpRnNOcP/J81n1jrZC0X6gNuRiOoKvRw3BaT3Wwd6O03XwNbf5Ueuw
         PEtIxT25lUKN7ekbFyaixdV6RqZwO4LjKFYjA5f4dlm2xzjsWBm8x1RzGDJxAAkgyreV
         /vcr+SLLhddZFEgHZqgHxdSZH+baDtgbno3TWD21Uj+EIETHVKbPhaDJZ4K6/jVbpari
         RNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466931; x=1795071731;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4MtBLSGAeSlREMeMpXOJglcbVkwCt0++4H9V4EMMVM=;
        b=XOdqI1POq2u0mMNaG0LKirijy98ReKJIk7gbNy9ad6neKWDsvrqgE28Em7sDQkVRcy
         nt7MG26qtgupNz3p21x5t64pO55gu0NdNP2oMlVUbb/R8yUm8aFvZkefTsuS6qOaAySU
         I6etV1Vgf1hbVYExNhMPM084AG6939Bfudf+gYeuIv1s/rZScl1YTLBKihgYqeP8OpiO
         N02aXtolygFB1039TvGiwIYfmDwG3qR7zwcp1cISLYi5v5xnU4lt0KKrOrNCG+c2Sfiq
         YBaNtVmifmGLP4DOEONYACMDXmllHN7/HZ4yWizr820iT/MeMkv9+husTZ8+AK7u+G2j
         lhcg==
X-Forwarded-Encrypted: i=1; AL+hErHL9E4qcHBi2ZyqTc6BQYID9d0Oi6YbQDiIj51X9Yg/JXYUUIsyWwDpdYIJhZgQ/nt75wxmA/ivlrhGpQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z85SFuOPQ4W+OP5UkFtalcK5BTdHpj981kyN2s0mQ+uaIhbN+0B
	/ok76HKsaJ/2KV2e5m7I5QXE/i/LtjjG7zv5liNFMdwA68xAnT2WSTBxDnEqQALgQsc=
X-Gm-Gg: AYBFou1StBzR9kAQmLDSadyJI6ectAqmK9b+242r5+cTM43dJAf1qXwOLrzEuPj3H3N
	asmbXU3J7ANYaob87wvReJkS8l5qVhhUFuT+k/xEeQ86bcSjYPPlrfVFXaki83Umjcfbb4mFVe7
	FzLgv8cGvFzF/wFtEkj7hHeO9bgMd/3J5IOVKwrbPi8cs1JExYvl8Vd8SdI8CCh+lNXkGHEXf9s
	+C9A66ngpTpM747WasQwmb+Fxl2UxeNwpim9j8it5+S27UGj6G8kKlx/c5RLJGPRk7iBoGrdGfC
	V+51wjvMYmELTz4adwvq3pMoKGErS+XEHgJrbhhftNA8CxMHsLiTsQbmced6Z2Z13Gpcvs0wl6s
	ryUmUvqnL0WvMYH8L83xyOb9RApuiA9MBaHT87f2m3DefrIZGFJP64u0AKHEMzSc87Gz+I7mlwd
	l8SS9UL7PbYZuJmDtVdtRhMJCai2xurNUuk4qS5HQ9aucP5rXYucl100rykxwv4+sBSkXMuOTEF
	aSvipmSWmu9h4+tayo4IbJskqgWQk7ko6aLZWyKFTfOxTEOwqmpT9USoI2EPfoiTjEs+LOzNXLA
	4mh5abvizJyZ0t+4rZX+zJsBOLvTRH10GX0b2Ujba2zLsZfBxccH7NZfoHVdMOdqNZAo2cmoFgZ
	K7OsTazn/HU4t2sIumDmEYEy3BAKi80HfXXlPEx9IeghPHGatPjZ9AhXihgVQ0ahHoNoLRgHZ
X-Received: by 2002:a05:6402:1e94:b0:6b5:61fe:982a with SMTP id 4fb4d7f45d1cf-6b777824953mr3292179a12.45.1794466916038;
        Wed, 11 Nov 2026 23:01:56 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7ada54c88sm112091a12.2.2026.11.11.23.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 23:01:54 -0800 (PST)
Message-ID: <3a052d2c-8d14-4cb1-b6fd-277a6b0c8196@suse.com>
Date: Thu, 12 Nov 2026 08:01:53 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] xen-blkback: do some I/O statistics rework
To: Jan Beulich <jbeulich@suse.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20261111162058.804033-1-jgross@suse.com>
 <7af69a18-fcd7-48f9-a9e4-c2ddc060755e@suse.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <7af69a18-fcd7-48f9-a9e4-c2ddc060755e@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------XnKNkkfJknfgjGY9Ag00BvNt"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------XnKNkkfJknfgjGY9Ag00BvNt
Content-Type: multipart/mixed; boundary="------------znQNYWv2cH6gyTbCeqXfd0fm";
 protected-headers="v1"; hp="clear"
Message-ID: <3a052d2c-8d14-4cb1-b6fd-277a6b0c8196@suse.com>
Date: Thu, 12 Nov 2026 08:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] xen-blkback: do some I/O statistics rework
To: Jan Beulich <jbeulich@suse.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20261111162058.804033-1-jgross@suse.com>
 <7af69a18-fcd7-48f9-a9e4-c2ddc060755e@suse.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <7af69a18-fcd7-48f9-a9e4-c2ddc060755e@suse.com>

--------------znQNYWv2cH6gyTbCeqXfd0fm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMTEuMjYgMDc6MzQsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMS4xMS4yMDI2
IDE3OjIwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gU29tZSByZXdvcmsgb2YgdGhlIGJs
a2JhY2sgc3RhdGljcyBkYXRhIGhhbmRsaW5nLg0KPj4NCj4+IEp1ZXJnZW4gR3Jvc3MgKDMp
Og0KPj4gICAgeGVuLWJsa2JhY2s6IFJlbW92ZSBzdGF0aXN0aWNzIGxvZ2dpbmcgb24gY29u
c29sZQ0KPj4gICAgeGVuLWJsa2JhY2s6IG1vdmUgc3RhdGlzdGljcyBkYXRhIGludG8gc3Vi
LXN0cnVjdHVyZQ0KPj4gICAgeGVuLWJsa2JhY2s6IG1ha2Ugc3RhdGlzdGljcyBkYXRhIHBl
cnNpc3RlbnQgYWNyb3NzIGRpc2Nvbm5lY3QvY29ubmVjdA0KPiBSZXZpZXdlZC1ieTogSmFu
IEJldWxpY2ggPGpiZXVsaWNoQHN1c2UuY29tPg0KDQpUaGFua3MuDQoNCj4gSW4gdGhlIGxh
c3QgcGF0Y2ggYSBicmllZiBjb21tZW50IG9uIHRoZSBnbG9iYWwgc3RhdHMgaW5zdGFuY2Ug
bWF5IGJlDQo+IHdvcnRoLCB0byBpbmRpY2F0ZSBpdCdzIGd1YXJkZWQgYnkgdGhlIHJpbmdz
IGxvY2suDQo+IA0KPiBBbHNvLCBkbyBJIG1heWJlIGdldCBhIFJlcG9ydGVkLWJ5OiBvbiB0
aGUgbGFzdCBwYXRjaD8NClllcyB0byBib3RoLiA6LSkNCg0KDQpKdWVyZ2VuDQo=

--------------znQNYWv2cH6gyTbCeqXfd0fm--

--------------XnKNkkfJknfgjGY9Ag00BvNt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmr1ZGEFAwAAAAAACgkQsN6d1ii/Ey+j
5Qf/VkOKnOQT0F4EOFuBzac7B3dirk00TyTViv89zfyTCzNWvQ1NhWRd612k2Xgs3lS/oMFgAlZt
8xcOpUaNnM+ubudMuiHRsf94cKCdh2EubF04ANK9kn012eDseJjkCweKmxjVDDoPM/A1BVSwq5yQ
aTE8k+xGcOzKNYrGHwaFiC1C/jsIcw4DN+CCV/vPDL0iIkhFP0qWbOE8d7kQ0czpFzwJBXAI6LBQ
r/PKwaH/JwSwwW28ipAGIYNwTdlJWfsu18dP/C3j/A4UOiFGDFTWlFq31EaSvZkKmMSl+tQ2LHse
EX30z7qV/A7ZAEiQet8JXCQ9qtLsznVIwO+Q8Zn1JQ==
=hvYA
-----END PGP SIGNATURE-----

--------------XnKNkkfJknfgjGY9Ag00BvNt--
