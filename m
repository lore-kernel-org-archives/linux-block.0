Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9513C5DC0
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220575; cv=none; b=oPSYSA3MSefwLsliN4JyX4J62VolP7AbUbABEiN8Y6mE0PtG0WZWxTTMeHxHGpCIJSRYao52t5symd4LruCbbTwfrTR3uobcDZb2sCaP0aqXZAYfj54XoJrD/2ohQKZ/DlrrYC8tP6lJQmrOaRBHxAwgP7e1EMO/xLKPWweLke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220575; c=relaxed/simple;
	bh=gmX47k16PCFMCXn0UmTzlCzGKMZSBXrDm/8qKo1TTnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHgqFL6bPrGMQ3m0RsbbGKJNWdgeC0ExeO3zD80hl+mF/Acw3yoB74AbRlWK9WWVdqPtq48OudW8g1a3DQfNeNj95VfY7A51Za6xsCgRK8xVdyn5OT2LxF0Bp3xN1c+NnCi74lpH9Mtpx1F9NrG50wLEZcCe83viAh7wbQFWxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/gvt4Gl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/gvt4Gl"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso9496084a12.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773220565; x=1773825365; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmX47k16PCFMCXn0UmTzlCzGKMZSBXrDm/8qKo1TTnA=;
        b=O/gvt4GlUfaXZSfvBtxI1Kw2yyu+aOdd+SE1Yp/TeZF0peJSq9Pn7DEWILqX2pn/7J
         uVneDogzBiUKmSbkJT92AJu5eQGocXTCazL7hpbiY/ewqhq52tFYSIJegFv5OxgdgxJO
         wO7sAzskfeuw4i6akJja759XV2QpepfUJ5us3k4zu/GVbUbuG0xsZptIBZgEjFOJnhDH
         0LuD6C7qVwrjWLwnih91hiPj0/TGFLfBLvVskxR3Qx6bj752LpMO6TsQgHRo6q63UiGi
         ODMNmws50pcZqwZ4ONLe+QFkdm6p+l7fgyey1EJjcUh9+h3F5fP0apE8u5a72pr/ZsCI
         0MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220565; x=1773825365;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmX47k16PCFMCXn0UmTzlCzGKMZSBXrDm/8qKo1TTnA=;
        b=WmV7HebItP8a45sA4Od8pKSr31/33DWQGCltdCx4EMRLAlceM/v+LRW7+vtEybV18D
         SpO8h3kEwgrAJU6xcSoEMckS/5qz/T0j3plIoxYEWGCNfQQEq84QT901xwKKLSkEN9Vw
         hsl552aPXpPHQQ8+S7KGmGSJ0TwzbO/PezY3n2XkFQ//13ywjTxrJKVbybFHEMxBf2i5
         lYZ2lv4IJrHK6+CCXVsWVOzj/YL3/gW9b1AGCnUjkAgrt+CxilUEsrbTVO1R3wwM3v8b
         1c72vnz5Vygq1BBKwgyZgjn+ySZ37UJv4RfP9sruuyr2GRU/Znp29ZSM0mSjHBxReLEg
         ywJw==
X-Forwarded-Encrypted: i=1; AJvYcCVxtbygAF5BMNuHWfUOQOL4GE3rHXjF9fo94b7n6PmDuRYA4/6Q8VJj7hC4tEyVt0QCt46lAL0x8ajyxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqF/Lsnc24FzqqbsD319ROzkbOJBBfl9iXPgIZ5Ps84ER4tNw
	bMvlLNUAqgxnbT1uC68s+gctm1kbTNREv6d3IciqtiVMxm7oXQRfVf/LhnVGNJ7LVvQ=
X-Gm-Gg: ATEYQzzUE1U2jc3SFX66wJirCLQAV1hoPI3vwYa7imBMrQpmUlFhcyblx/Kl4AoEqaD
	fcdBvI48HNLCz17eoy08MMeuYvSOrkrU+sPiDOOM3IuF0atX/yLc5FfYLH7c9EZ14XPGvM2zVNB
	GnTrsZTL/L3xLd1o/wmg+N6mbQsdiyccdqkw4if6Xn6X7IUK9geu3INgC5JLfSiuR4U3yIq5pX4
	BXguGtAIsmTlPw7XQjwjkx7uM/W9k+0aBYIFaB6qwWVcrk+/0FAgaRCu2vh8DiOfK9DG2jaCAy7
	02zKK96+m0zeha7yTPZ5d2FI+WLk57Z8zVBobc2JKAjBSBov7lRz4ELEsyODVxc7ngjk0q+J7xO
	Yxxq9c156AngygKWcX1hnecXrU6vs5fGiSfZRYSHH5GIIFQC/EmSrmsCy01x5XBYcKz//RtErmM
	MIj2OTDacy636e0v1MzIERMGd4MvTQMbb88Egec7fvRpWegFF/aD+4JFDHcj5TQkgZDTdHRVsVr
	otiCrX4GZcPprCVP2xVn0QMOCzbeZh4Cp+NJndtgDZ5AbRLnm7jCIZg+a85BXU4
X-Received: by 2002:a17:906:fd84:b0:b94:1913:77fc with SMTP id a640c23a62f3a-b972e5f420emr107546366b.30.1773220565380;
        Wed, 11 Mar 2026 02:16:05 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de092dcsm40225866b.4.2026.03.11.02.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 02:16:04 -0700 (PDT)
Message-ID: <12b42fb2-092b-4ffc-9c5c-fd0bb7252bd3@suse.com>
Date: Wed, 11 Mar 2026 10:16:04 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] x86: Cleanups around slow_down_io()
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Denis Efremov <efremov@linux.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20260119182632.596369-1-jgross@suse.com>
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
In-Reply-To: <20260119182632.596369-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ly91FhzTvqqnaaaUYBZhau5n"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ly91FhzTvqqnaaaUYBZhau5n
Content-Type: multipart/mixed; boundary="------------4QPs0Tl0IvPk0NeNwm0fH0rQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Denis Efremov <efremov@linux.com>,
 Jens Axboe <axboe@kernel.dk>
Message-ID: <12b42fb2-092b-4ffc-9c5c-fd0bb7252bd3@suse.com>
Subject: Re: [PATCH v4 0/6] x86: Cleanups around slow_down_io()
References: <20260119182632.596369-1-jgross@suse.com>
In-Reply-To: <20260119182632.596369-1-jgross@suse.com>

--------------4QPs0Tl0IvPk0NeNwm0fH0rQ
Content-Type: multipart/mixed; boundary="------------ykCYmYZPmbNUyjW9yglZ6jAJ"

--------------ykCYmYZPmbNUyjW9yglZ6jAJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDEuMjYgMTk6MjYsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IFdoaWxlIGxvb2tp
bmcgYXQgcGFyYXZpcnQgY2xlYW51cHMgSSBzdHVtYmxlZCBvdmVyIHNsb3dfZG93bl9pbygp
IGFuZA0KPiB0aGUgcmVsYXRlZCBSRUFMTFlfU0xPV19JTyBkZWZpbmUuDQo+IA0KPiBEbyBz
ZXZlcmFsIGNsZWFudXBzLCByZXN1bHRpbmcgaW4gYSBkZWxldGlvbiBvZiBSRUFMTFlfU0xP
V19JTyBhbmQgdGhlDQo+IGlvX2RlbGF5KCkgcGFyYXZpcnQgZnVuY3Rpb24gaG9vay4NCj4g
DQo+IFBhdGNoIDQgaXMgcmVtb3ZpbmcgdGhlIGNvbmZpZyBvcHRpb25zIGZvciBzZWxlY3Rp
bmcgdGhlIGRlZmF1bHQgZGVsYXkNCj4gbWVjaGFuaXNtIGFuZCBzZXRzIHRoZSBkZWZhdWx0
IHRvICJubyBkZWxheSIuIFRoaXMgaXMgaW4gcHJlcGFyYXRpb24gb2YNCj4gcmVtb3Zpbmcg
dGhlIGlvX2RlbGF5KCkgZnVuY3Rpb25hbGl0eSBjb21wbGV0ZWx5LCBhcyBzdWdnZXN0ZWQg
YnkgSW5nbw0KPiBNb2xuYXIuDQo+IA0KPiBQYXRjaCA1IGlzIGFkZGluZyBhbiBhZGRpdGlv
bmFsIGNvbmZpZyBvcHRpb24gYWxsb3dpbmcgdG8gYXZvaWQNCj4gYnVpbGRpbmcgaW9fZGVs
YXkuYyAoZGVmYXVsdCBpcyBzdGlsbCB0byBidWlsZCBpdCkuDQo+IA0KPiBDaGFuZ2VzIGlu
IFYyOg0KPiAtIHBhdGNoZXMgMiBhbmQgMyBvZiBWMSBoYXZlIGJlZW4gYXBwbGllZA0KPiAt
IG5ldyBwYXRjaGVzIDQgYW5kIDUNCj4gDQo+IENoYW5nZXMgaW4gVjM6DQo+IC0gcmViYXNl
IHRvIHRpcC9tYXN0ZXIga2VybmVsIGJyYW5jaA0KPiANCj4gQ2hhbmdlcyBpbiBWNDoNCj4g
LSBhZGQgcGF0Y2ggMSBhcyBwcmVyZXEgcGF0Y2ggdG8gdGhlIHNlcmllcw0KPiANCj4gSnVl
cmdlbiBHcm9zcyAoNik6DQo+ICAgIHg4Ni9pcnFmbGFnczogRml4IGJ1aWxkIGZhaWx1cmUN
Cj4gICAgeDg2L3BhcmF2aXJ0OiBSZXBsYWNlIGlvX2RlbGF5KCkgaG9vayB3aXRoIGEgYm9v
bA0KPiAgICBibG9jay9mbG9wcHk6IERvbid0IHVzZSBSRUFMTFlfU0xPV19JTyBmb3IgZGVs
YXlzDQo+ICAgIHg4Ni9pbzogUmVtb3ZlIFJFQUxMWV9TTE9XX0lPIGhhbmRsaW5nDQo+ICAg
IHg4Ni9pb19kZWxheTogU3dpdGNoIGlvX2RlbGF5KCkgZGVmYXVsdCBtZWNoYW5pc20gdG8g
Im5vbmUiDQo+ICAgIHg4Ni9pb19kZWxheTogQWRkIGNvbmZpZyBvcHRpb24gZm9yIGNvbnRy
b2xsaW5nIGJ1aWxkIG9mIGlvX2RlbGF5Lg0KPiANCj4gICBhcmNoL3g4Ni9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgIHwgIDggKysrDQo+ICAgYXJjaC94ODYvS2NvbmZpZy5kZWJ1
ZyAgICAgICAgICAgICAgICB8IDMwIC0tLS0tLS0tLS0NCj4gICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9mbG9wcHkuaCAgICAgICAgIHwgMzEgKysrKysrKystLQ0KPiAgIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL2lvLmggICAgICAgICAgICAgfCAxOSArKysrLS0tDQo+ICAgYXJjaC94ODYv
aW5jbHVkZS9hc20vaXJxZmxhZ3MuaCAgICAgICB8ICA2ICstDQo+ICAgYXJjaC94ODYvaW5j
bHVkZS9hc20vcGFyYXZpcnQtYmFzZS5oICB8ICA2ICsrDQo+ICAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGFyYXZpcnQuaCAgICAgICB8IDExIC0tLS0NCj4gICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wYXJhdmlydF90eXBlcy5oIHwgIDIgLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9NYWtl
ZmlsZSAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvdm13
YXJlLmMgICAgICAgICAgfCAgMiArLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9pb19kZWxheS5j
ICAgICAgICAgICAgfCA4MSArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNo
L3g4Ni9rZXJuZWwva3ZtLmMgICAgICAgICAgICAgICAgIHwgIDggKy0tDQo+ICAgYXJjaC94
ODYva2VybmVsL3BhcmF2aXJ0LmMgICAgICAgICAgICB8ICAzICstDQo+ICAgYXJjaC94ODYv
a2VybmVsL3NldHVwLmMgICAgICAgICAgICAgICB8ICA0ICstDQo+ICAgYXJjaC94ODYveGVu
L2VubGlnaHRlbl9wdi5jICAgICAgICAgICB8ICA2ICstDQo+ICAgZHJpdmVycy9ibG9jay9m
bG9wcHkuYyAgICAgICAgICAgICAgICB8ICAyIC0NCj4gICAxNiBmaWxlcyBjaGFuZ2VkLCA2
MyBpbnNlcnRpb25zKCspLCAxNTkgZGVsZXRpb25zKC0pDQo+IA0KDQpBbnkgY29tbWVudHM/
DQoNCg0KSnVlcmdlbg0K
--------------ykCYmYZPmbNUyjW9yglZ6jAJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ykCYmYZPmbNUyjW9yglZ6jAJ--

--------------4QPs0Tl0IvPk0NeNwm0fH0rQ--

--------------ly91FhzTvqqnaaaUYBZhau5n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmmxMtQFAwAAAAAACgkQsN6d1ii/Ey8A
eQf8CHdFysN8bD+Zo0Oxso2E1yhRpRH1owAFupCVGF3BUqTaDASBcCuvsG9/Ki0F45119ijMsBjw
TFDm/0+5boYGwCqHqvHsFCMdMaYRmVqFecdT+YS0Y1P8gY6ss0Gss8aOnF3DBJWGJ/9uxlToJYSt
Iskf/Ngli/nA6twrtqlX4PqF/9uX5QpAERj607WFkQ7ObvTNpZAyejlnTJPxR2yrb9d9mrrm4LHt
7LOvBn+R2GCJhztJ9ROE7yBNFNjwyUu63vPCc3wShFdxXqjKXiuOvlC87MCbfL6crZr1nRX//HDj
Vj9OPYJkGm0vldthYiLXqEmDUTp7IhKoXgrM9Ks6jg==
=uMUn
-----END PGP SIGNATURE-----

--------------ly91FhzTvqqnaaaUYBZhau5n--
