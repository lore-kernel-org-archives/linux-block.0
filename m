Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54231CAA76
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035273; cv=none; b=VaoKrzk8XmDmNmcW8G6dq17qMj8POkOv/hmIvHEmkNUfCFF4jUaOzLNVtmX/ejzNEsQjSeVS4YO53eULIyS1MqSu/GYNsOxmc72a7Wb3p53hB3Udmh7cKZLRzG7FsU0htHH6HwTjGlDaPSTMnYyhPnj9/NJP9y1S4wok+z106+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035273; c=relaxed/simple;
	bh=uwFW/Eb/R0FJBv28GaHOzSCwEzOQyTEr2FES8VqXhyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqEHSCv0ybV88ifDEboc2oYJ9a5xJii1dmXiZ0bVLL2uhPvN6vWTIuY7vedvOR6kShvq6nSkVyi9UXcHlht3/ivKEShU1nFbKjjl3bXzkHvLABwSSg6LiJ6yfaxjiPoC5dbkBK5HvbW0Y0NADQuKANmHq5GkTndXhzqPKMA/568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8xAWgly; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8xAWgly"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5445cb72dso46633685a.3
        for <linux-block@vger.kernel.org>; Mon, 07 Apr 2025 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744035271; x=1744640071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwFW/Eb/R0FJBv28GaHOzSCwEzOQyTEr2FES8VqXhyU=;
        b=X8xAWglybsnM3vaLbuBTN/8dlH7jKOAV6Z555WhqWqLs3Qfnbccqpqu9d5lGXyKVNZ
         P0xAWhD40BxSwX8yj4cr2jC/0WAwPJ5/Mstj3wOGgJoQU18nH7aHTZ2pc5edlMt/PfeZ
         9y8gV3zuuMwe+TNDTyqtyQ5KlhP/HE/4aBHhgnfJOLYH7GLgZISpJyuSWPkpUVU5tdhO
         wkXSNL4nwDtjmLQa37QZCoVqQAl28VsVC7LwjBAj68W5LWVqlcsdXLLcBPIo4oD/GApT
         JWZ+J2f/iJc3Nt3bC/IQmbQi+9rI4VsZX15ULZIKSCRlWPkCkz9cvavrXrLFUdrNzOq9
         tc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035271; x=1744640071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwFW/Eb/R0FJBv28GaHOzSCwEzOQyTEr2FES8VqXhyU=;
        b=IhU7nwZ3ivQiOnKCgcY5ROsO/pApKAW3WmTkYJcyc7Jnt4nL15vUGpyfGkIC97fOiX
         f2HFcDKGS2AeROWzip8aqR1ZBu2RbiVXSx/IqHKwfrmpr2mbS3yLWcT5pm6v8SIvCm9z
         ZQtsg39cWnAle3IuArWY5sHtCLMfYeMpoCMt32T/ilSokusmjCOGs+y+V+F03dzRuYQj
         KA+4MS4LdBXNkhNYKZ1y7/d2JwB37lREKeacs6bf/GzrnlqDp06vZ8t3oLtabKZWsxfs
         mHs/ldB140ZzN8lfcmgW41U2eOmo6mKoSYMs2oxHjbFazA1Xlhej8b66nsSvL2HUmowO
         sO0g==
X-Forwarded-Encrypted: i=1; AJvYcCUfldAMFKQLboTIYyJ0TRL4LE2LsFj5cdke0lOmBdy3DdFrFjgpfHEF2jt3b2lIGzO64RAUMh3XiszeXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xIt/P+szUhXuxL9jjwFEcdLuaQ5y4M7pjKTQMB3fy8gnTFMt
	QKQsCKgRysm6utKWeJn104/auvga7i1Ex2Nip8/mkuEnrB2R2xJH
X-Gm-Gg: ASbGncv3VgbsCu1TAg3NlapxRlaPpGieJxmkn1FvndXN53AXqAmLoyQ268aIUYpOniD
	/Cgt0vUQcrSetewQZYpGo8Gyqy03ne8qO/g7//FCAFzYGytKtSsLMqkj8O9O47j4OZ+iuqkeTwP
	lfOKc3Tr5dpA+Jv6Y0543P/le6v+P8DZtj/Bv2byuv7gi1USBQ9Q3CM18dahlcjx8fIIAZZp+lm
	8nFPs6mXm2g1c1vzuSZ9RDLuHENzG2D8/1g2rykIyAHxMcieMo08uNml7pInQCaOHBuKex0+Oux
	J0cLEV9qbPqYBBn9y54usoR7+2m3T/XRy7XwL6ClmK8EGibPv7YXDfF3R7fdbHDAnOu3lCA47jE
	BcbNVfOzLoXZMmNuOwDoU
X-Google-Smtp-Source: AGHT+IGjFDuTUnh1KO8p1udDbzjbopvo23OYnSLVyEZ0yS5lxthcKxhsKsbqDXcWnscVY+yFVKr1dA==
X-Received: by 2002:a05:620a:17a6:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c774dbe6d1mr621761785a.11.1744035270111;
        Mon, 07 Apr 2025 07:14:30 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea7eeabsm601695385a.94.2025.04.07.07.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:14:29 -0700 (PDT)
Message-ID: <a0ffa9b9-8649-1b63-3d56-3fc45fdfda83@gmail.com>
Date: Mon, 7 Apr 2025 10:14:28 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: bio segment constraints
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <8a232716-74f8-4bba-a514-d0f766492344@suse.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <8a232716-74f8-4bba-a514-d0f766492344@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC83LzI1IDAzOjEwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDQvNi8yNSAy
MTo0MCwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IEhpIGFsbCwNCj4+DQo+PiBJJ20gbm90
IHJlYWxseSBzdXJlIHdoYXQgZ3VhcmFudGVlcyB0aGUgYmxvY2sgbGF5ZXIgbWFrZXMgcmVn
YXJkaW5nIHRoZQ0KPj4gc2VnbWVudHMgaW4gYSBiaW8gYXMgcGFydCBvZiBhIHJlcXVlc3Qg
c3VibWl0dGVkIHRvIGEgYmxvY2sgZHJpdmVyLiBBcw0KPj4gZmFyIGFzIEkgY2FuIHRlbGwg
dGhpcyBpcyBub3QgZG9jdW1lbnRlZCBhbnl3aGVyZS4gSW4gcGFydGljdWxhciwNCj4+DQo+
PiAtIElzIGJ2X2xlbiBhbGlnbmVkIHRvIFNFQ1RPUl9TSVpFPw0KPiANCj4gVGhlIGJsb2Nr
IGxheWVyIGFsd2F5cyB1c2VzIGEgNTEyIGJ5dGUgc2VjdG9yIHNpemUsIHNvIHllcy4NCj4g
DQo+PiAtIFRvIGxvZ2ljYWxfc2VjdG9yX3NpemU/DQo+IA0KPiBOb3QgbmVjZXNzYXJpbHku
IEJ2ZWNzIGFyZSBhIGNvbnNlY3V0aXZlIGxpc3Qgb2YgYnl0ZSByYW5nZXMgd2hpY2gNCj4g
bWFrZSB1cCB0aGUgZGF0YSBwb3J0aW9uIG9mIGEgYmlvLg0KPiBUaGUgbG9naWNhbCBzZWN0
b3Igc2l6ZSBpcyBhIHByb3BlcnR5IG9mIHRoZSByZXF1ZXN0IHF1ZXVlLCB3aGljaCBpcw0K
PiBhcHBsaWVkIHdoZW4gYSByZXF1ZXN0IGlzIGZvcm1lZCBmcm9tIG9uZSBvciBzZXZlcmFs
IGJpb3MuDQo+IEZvciB0aGUgcmVxdWVzdCB0aGUgb3ZlcmFsbCBsZW5ndGggbmVlZCB0byBi
ZSBhIG11bHRpcGxlIG9mIHRoZSBsb2dpY2FsDQo+IHNlY3RvciBzaXplLCBidXQgbm90IG5l
Y2Vzc2FyaWx5IHRoZSBpbmRpdmlkdWFsIGJpb3MuDQoNCk9oLCBzbyB0aGlzIGlzIHdvcnNl
IHRoYW4gSSB0aG91Z2h0LiBTbyBpZiB5b3UgY2FyZSBhYm91dCBlLmcuIG9ubHkgc3VibWl0
dGluZw0KSS9PIGluIHVuaXRzIG9mIGxvZ2ljYWxfYmxvY2tfc2l6ZSwgeW91IGhhdmUgdG8g
Y29tYmluZSBzZWdtZW50cyBhY3Jvc3MgdGhlDQplbnRpcmUgcmVxdWVzdC4NCg0KPj4gLSBX
aGF0IGlmIGxvZ2ljYWxfc2VjdG9yX3NpemUgPiBQQUdFX1NJWkU/DQo+IA0KPiBTZWUgYWJv
dmUuDQo+IA0KPj4gLSBXaGF0IGFib3V0IGJ2X29mZnNldD8NCj4gDQo+IFNhbWUgc3Rvcnku
IFRoZSBldmVudHVhbCByZXF1ZXN0IG5lZWRzIHRvIG9ic2VydmUgdGhhdCB0aGUgb2Zmc2V0
DQo+IGFuZCB0aGUgbGVuZ3RoIGlzIGFsaWduZWQgdG8gdGhlIGxvZ2ljYWwgYmxvY2sgc2l6
ZSwgYnV0IHRoZSBpbmRpdmlkdWFsDQo+IGJpb3MgbWlnaHQgbm90Lg0KPiANCj4+IC0gSXMg
aXQgcG9zc2libGUgdG8gaGF2ZSBhIGJpbyB3aGVyZSB0aGUgdG90YWwgbGVuZ3RoIGlzIGEg
bXVsdGlwbGUgb2YNCj4+IMKgwqAgbG9naWNhbF9zZWN0b3Jfc2l6ZSwgYnV0IHRoZSBkYXRh
IGlzIHNwbGl0IGFjcm9zcyBzZXZlcmFsIHNlZ21lbnRzDQo+PiDCoMKgIHdoZXJlIGVhY2gg
c2VnbWVudCBpcyBhIG11bHRpcGxlIG9mIFNFQ1RPUl9TSVpFPw0KPiANCj4gU3VyZS4NCj4g
DQo+PiAtIElzIGlzIHBvc3NpYmxlIHRvIGhhdmUgc2VnbWVudHMgbm90IGV2ZW4gYWxpZ25l
ZCB0byBTRUNUT1JfU0laRT8NCj4gDQo+IE5vcGUuDQo+IA0KPj4gLSBDYW4gSSBzb21laG93
IHJlcXVlc3QgdG8gb25seSBnZXQgc2VnbWVudHMgd2l0aCBidl9sZW4gYWxpZ25lZCB0bw0K
Pj4gwqDCoCBsb2dpY2FsX3NlY3Rvcl9zaXplPyBPciBkbyBJIG5lZWQgdG8gZG8gbXkgb3du
IGNvYWxlc2NpbmcgYW5kIGJvdW5jZQ0KPj4gwqDCoCBidWZmZXJpbmcgZm9yIHRoYXQ/DQo+
Pg0KPiANCj4gVGhlIGRyaXZlciBzdXJlbHkgY2FuLiBZb3Ugc2hvdWxkIGJlIGFibGUgdG8g
c2V0ICdtYXhfc2VnbWVudF9zaXplJyB0bw0KPiB0aGUgbG9naWNhbCBibG9jayBzaXplLCBh
bmQgdGhhdCBzaG91bGQgZ2l2ZSB5b3Ugd2hhdCB5b3Ugd2FudC4NCg0KQnV0IGNvdWxkbid0
IEkgZ2V0IHNlZ21lbnRzIHNtYWxsZXIgdGhhbiB0aGF0PyBtYXhfc2VnbWVudF9zaXplIHNl
ZW1zIGxpa2UNCml0IHdvdWxkIG9ubHkgcmVzdHJpY3QgdGhlIG1heGltdW0gc2l6ZSwgbGVh
dmluZyB0aGUgcG9zc2liaWxpdHkgb3BlbiBmb3INCnNtYWxsZXIgc2VnbWVudHMuDQoNCj4+
IEkndmUgYmVlbiByZWFkaW5nIHNvbWUgZHJpdmVycyAoYXMgd2VsbCBhcyBzdHVmZiBpbiBi
bG9jay8pIHRvIHRyeSBhbmQNCj4+IGZpZ3VyZSB0aGluZ3Mgb3V0LCBidXQgaXQncyBoYXJk
IHRvIGZpZ3VyZSBvdXQgYWxsIHRoZSBwbGFjZXMgd2hlcmUNCj4+IGNvbnN0cmFpbnRzIGFy
ZSBlbmZvcmNlZC4gSW4gcGFydGljdWxhciwgSSd2ZSByZWFkIHNldmVyYWwgZHJpdmVycyB0
aGF0DQo+PiBtYWtlIHNvbWUgYmlnIGFzc3VtcHRpb25zICh3aGljaCBtaWdodCBiZSBidWdz
PykgRm9yIGV4YW1wbGUsIGluDQo+PiBkcml2ZXJzL210ZC9tdGRfYmxrZGV2cy5jLCBkb19i
bGt0cmFuc19yZXF1ZXN0IGxvb2tzIGxpa2U6DQo+Pg0KPiBJbiBnZW5lcmFsLCB0aGUgYmxv
Y2sgbGF5ZXIgaGFzIHR3byBtYWpvciBkYXRhIGl0ZW1zLCBiaW9zIGFuZCByZXF1ZXN0cy4N
Cj4gJ3N0cnVjdCBiaW8nIGlzIHRoZSBjZW50cmFsIHN0cnVjdHVyZSBmb3IgYW55ICd1cHBl
cicgbGF5ZXJzIHRvIHN1Ym1pdA0KPiBkYXRhICh2aWEgdGhlICdzdWJtaXRfYmlvKCknIGZ1
bmN0aW9uKSwgYW5kICdzdHJ1Y3QgcmVxdWVzdCcgaXMgdGhlDQo+IGNlbnRyYWwgc3RydWN0
dXJlIGZvciBkcml2ZXJzIHRvIGZldGNoIGRhdGEgZm9yIHN1Ym1pc3Npb24gdG8gdGhlDQo+
IGhhcmR3YXJlICh2aWEgdGhlICdxdWV1ZV9ycSgpJyByZXF1ZXN0X3F1ZXVlIGNhbGxiYWNr
KS4NCj4gQW5kIHRoZSB0YXNrIG9mIHRoZSBibG9jayBsYXllciBpcyB0byBjb252ZXJ0ICdz
dHJ1Y3QgYmlvJyBpbnRvDQo+ICdzdHJ1Y3QgcmVxdWVzdCcuDQo+IA0KPiBbIC4uIF0NCj4g
DQo+PiBGb3IgY29udGV4dCwgdHItPmJsa3NoaWZ0IGlzIGVpdGhlciA1MTIgb3IgNDA5Niwg
ZGVwZW5kaW5nIG9uIHRoZQ0KPj4gYmFja2VuZC4gRnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRo
aXMgY29kZSBhc3N1bWVzIHRoZSBmb2xsb3dpbmc6DQo+Pg0KPiBtdGQgaXMgcHJvYmFibHkg
bm90IGEgZ29vZCBleGFtcGxlcywgYXMgTVREIGhhcyBpdCdzIG93biBzZXQgb2YgbGltaXRh
dGlvbnMgd2hpY2ggbWlnaHQgcmVzdWx0IGluIGNlcnRhaW4gc2hvcnRjdXRzIHRvIGJlIHRh
a2VuLg0KDQpXZWxsLCBJIHdhbnQgdG8gd3JpdGUgYSBibG9jayBkcml2ZXIgb24gdG9wIG9m
IE1URCwgc28gaXQncyBhIHByZXR0eSBnb29kDQpleGFtcGxlIGZvciBteSBwdXJwb3NlcyA6
UA0KDQo+PiAtIFRoZXJlIGlzIG9ubHkgb25lIGJpbyBpbiBhIHJlcXVlc3QuIFRoaXMgb25l
IGlzIGEgYml0IG9mIGEgc29mdA0KPj4gwqDCoCBhc3N1bXB0aW9uIHNpbmNlIHdlIHNob3Vs
ZCBvbmx5IGZsdXNoIHRoZSBwYWdlcyBpbiB0aGUgYmlvIGFuZCBub3QgdGhlDQo+PiDCoMKg
IHdob2xlIHJlcXVlc3Qgb3RoZXJ3aXNlLg0KPj4gLSBUaGVyZSBpcyBvbmx5IG9uZSBzZWdt
ZW50IGluIGEgYmlvLiBUaGlzIG9uZSBjb3VsZCBiZSByZWFzb25hYmxlIGlmDQo+PiDCoMKg
IG1heF9zZWdtZW50cyB3YXMgc2V0IHRvIDEsIGJ1dCBpdCdzIG5vdCBhcyBmYXIgYXMgSSBj
YW4gdGVsbC4gU28gSQ0KPj4gwqDCoCBndWVzcyB3ZSBqdXN0IGdvIG9mZiB0aGUgZW5kIG9m
IHRoZSBiaW8gaWYgdGhlcmUncyBhIHNlY29uZCBzZWdtZW50Pw0KPj4gLSBUaGUgZGF0YSBp
cyBpbiBsb3dtZW0gT1IgYnZfb2Zmc2V0ICsgYnZfbGVuIDw9IFBBR0VfU0laRS4ga21hcCgp
IG9ubHkNCj4+IMKgwqAgbWFwcyBhIHNpbmdsZSBwYWdlLCBzbyBpZiB3ZSBnbyBwYXN0IG9u
ZSBwYWdlIHdlIGVuZCB1cCBpbiBhZGphY2VudA0KPj4gwqDCoCBrbWFwcGVkIHBhZ2VzLg0K
Pj4NCj4gV2VsbCwgdGhhdCBjb2RlIF9kb2VzXyBsb29rIHN1c3BpY2lvdXMuIEl0IHJlYWxs
eSBzaG91bGQgYmUgY29udmVydGVkDQo+IHRvIHVzaW5nIHRoZSBpb3YgaXRlcmF0b3JzLg0K
DQpJIGhhZCBhIGxvb2sgYXQgdGhpcywgYnV0IHRoZSBBUEkgaXNuJ3QgZG9jdW1lbnRlZCBz
byBJIHdhc24ndCBzdXJlIHdoYXQNCkkgd291bGQgZ2V0IG91dCBvZiBpdC4gSSdsbCBoYXZl
IGEgY2xvc2VyIGxvb2suDQoNCj4gQnV0IHRoZW4gYWdhaW4sIGl0IF9taWdodF8gYmUgb2th
eSBpZiB0aGVyZSBhcmUgdW5kZXJseWluZyBNVEQNCj4gcmVzdHJpY3Rpb25zIHdoaWNoIHdv
dWxkIGRldm9sdmUgaW50byBNVEQgb25seSBoYXZpbmcgYSBzaW5nbGUgYnZlYy4NCg0KVGhl
IHVuZGVybHlpbmcgcmVzdHJpY3Rpb24gaXMgdGhhdCB0aGUgTVREIEFQSSBleHBlY3RzIGEg
YnVmZmVyIHRoYXQgaGFzDQpjb250aWd1b3VzIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3Nlcy4g
VGhlIGRyaXZlciB3aWxsIGRvIGJvdW5jZS1idWZmZXJpbmcNCmlmIHdhbnRzIHRvIGRvIERN
QSBhbmQgdmlydF9hZGRyX3ZhbGlkIGlzIGZhbHNlLiBUaGUgbXRkX2Jsa2RldnMgZHJpdmVy
DQpwcm9taXNlcyB0byBzdWJtaXQgYnVmZmVycyBvZiBzaXplIHRyLT5ibGtzaXplIHRvIHRo
ZSB1bmRlcmx5aW5nIGJsdHJhbnMNCmRyaXZlci4gVGhpcyB3aG9sZSB0aGluZyBpcyBub3Qg
dmVyeSBlZmZpY2llbnQgaWYgdGhlIE1URCBkcml2ZXIgY2FuIGRvDQpzY2F0dGVyLWdhdGhl
ciBETUEsIGJ1dCB0aGF0J3Mgbm90IHRoZSBBUEkuLi4NCg0KTWF5YmUgSSBzaG91bGQganVz
dCB2bWFwIHRoZSBlbnRpcmUgcmVxdWVzdD8NCg0KLS1TZWFuDQo=
