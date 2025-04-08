Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92E3BBF2
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120675; cv=none; b=R6d2OK6UcOSVWHX1upZ3YVV0yw8UN/T46uK5Pnf3ZeS6ei6/40KGLf/Cm/LC9NBW8Jn3nHw7nb6nVbdGG6i9OqsdgFdzIvd9qCKREMezVfLBXOOgrniOeUIFy90v+SPfJ7/f/qD0+lakNO+tKMiRBSYcBBdVJJ7u+vPpmB9Ha48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120675; c=relaxed/simple;
	bh=1eLPJrXprM2M0bMGNsUFlKvKVg7bmQjnS+e4G6L38UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjIfimO6c8+11afYRReF7gDyJF2rShIn2NLr2kPgAZ1h3ET9g4jXvEAuKSlNw3Pw6CQGqV1Cqxr67th5cjlbRyNOpT4x2V/Zk3KKrA+ZDonU/oLxlLOwMmpbrVPUUq79z1csQtffD8nDl2B2tILWmauzxg4zST8vl4Dfb1/dQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao8zLtgL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao8zLtgL"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6eedceb2e7eso9219946d6.3
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744120673; x=1744725473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eLPJrXprM2M0bMGNsUFlKvKVg7bmQjnS+e4G6L38UU=;
        b=Ao8zLtgL5jLVLZPEpURa9A2urI+Wnc8YIDaWL0awdrM6oXR8j6j4l2+0mZudWSHbbw
         a6/8VQhmpxhDePDAq8JIMnAq9A/joBKPFGL+Vz/l1dnBsYk62vqDHOZlfmjsj3ebVXh1
         yNoOFXMeRkIga1dnB5umLOTj06ych1siWjznJ5f5ukqBOb3lF3MMwN+IGo/l8ItnCuU2
         /T4cQo9DjUT0jlRJ7ErIY6aawx57zqooHsWZm30IbUgR3vPdssyB31uAjzcY705ACxjE
         A7ucgK+139OgIBZGYecWFpg/m6ogTBAcAwghTIEahjvVYKmuNj0JAZwbGz1SYVJvFVdl
         uvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120673; x=1744725473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eLPJrXprM2M0bMGNsUFlKvKVg7bmQjnS+e4G6L38UU=;
        b=wRWWTzVQD3Qc9bpZ0+YKSdAjGq3bQJ3fF7fvfK/LTOPtbcAxWu9U4ekIAAg5almiFz
         ntTUW2Wm0how71JJjbtCTej45F0se7mhhoiSReOXjxOMEWgAM4f2jckdWu29nx6Z07Ef
         gF6v8ehl7F2EjpkyOkIccrb9B8DdKHau+w5869rI7BZQp4J3HsTLjvbdAtQGFawSTa3G
         8hsWYlkeVemumyxwATuuAIj7Fvkkedb03J/JDtk7PFoSPNdhZEy2Hz/fzPGeBu7mXkmS
         j/edHdOtO4TH3QIEuFGtvF/dIjW7J8nfcYi6E587UoeDeN+AnYrD6APS72DzEoBM0ymg
         duDg==
X-Forwarded-Encrypted: i=1; AJvYcCXlmdA4me3WTu+8gBUARboZkGP32Ba32WjpsEtwZf3qzDsfaJYSPery8U/xLOnfwIb5vM9eDQfjVo96CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6M83c//8aBbEwMV5yfjWd+W02cf/xOQhqXgUjYHKzAh03S5r
	27w97fWy8vpOlEGJSoBWLBSB0Wh3k8X0RloWZzr8trelhiAmfV50
X-Gm-Gg: ASbGncvOlAhJMCNzsx6yx2t8220CIpMmGWQv2kD/vtjns2zwMWm7TxIaos1xhnUEXot
	bAljfi0j22rxy0/Y0amUPgLremxUuU5hlFdEgAynhKC7kpjJCIXpF9gcuUOi035M6A+SU5NVyrK
	Qf2f28jBYlLJ8ZHaKydyA4RCb7AtDBVSR6V86H8/JUW4CXoBEnuxNNZ/ucXf0Zv32l97WpMKE3F
	0eKWZY7gh5ASsPRYVW1ARTlUf86lSRjlk5Smq7cAS58t1FNM9Yf3g9/QP/PDbuPt8b0VAQgMvc8
	nb3okTwWq9HUY3fDy/PBjDGQorBTb0dq1LJ8lpTUa4gGH7HuWUrgRp/0eYLOi+bQ7XlIz3qsRhh
	FGt+qTMQbvFCZK2C3S+xD
X-Google-Smtp-Source: AGHT+IEF0BAK7waavu4eeZ2kovhqT0j6efzE6PujE1HHSsq1l+s4f3Uj0huwtdFotlBVCLmUHqL8yQ==
X-Received: by 2002:a05:6214:e61:b0:6e8:fee2:aae2 with SMTP id 6a1803df08f44-6f01e7a1f77mr83556006d6.9.1744120672422;
        Tue, 08 Apr 2025 06:57:52 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0ee7565bsm74841946d6.0.2025.04.08.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 06:57:51 -0700 (PDT)
Message-ID: <25e201d2-aa80-1f1c-12fd-3b3f9c774e59@gmail.com>
Date: Tue, 8 Apr 2025 09:57:50 -0400
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
 <a0ffa9b9-8649-1b63-3d56-3fc45fdfda83@gmail.com>
 <7b8c4805-a91f-4455-a021-e5d8b6078d8b@suse.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <7b8c4805-a91f-4455-a021-e5d8b6078d8b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC84LzI1IDAyOjEwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDQvNy8yNSAx
NjoxNCwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IE9uIDQvNy8yNSAwMzoxMCwgSGFubmVz
IFJlaW5lY2tlIHdyb3RlOg0KPj4+IE9uIDQvNi8yNSAyMTo0MCwgU2VhbiBBbmRlcnNvbiB3
cm90ZToNCj4+Pj4gSGkgYWxsLA0KPj4+Pg0KPj4+PiBJJ20gbm90IHJlYWxseSBzdXJlIHdo
YXQgZ3VhcmFudGVlcyB0aGUgYmxvY2sgbGF5ZXIgbWFrZXMgcmVnYXJkaW5nIHRoZQ0KPj4+
PiBzZWdtZW50cyBpbiBhIGJpbyBhcyBwYXJ0IG9mIGEgcmVxdWVzdCBzdWJtaXR0ZWQgdG8g
YSBibG9jayBkcml2ZXIuIEFzDQo+Pj4+IGZhciBhcyBJIGNhbiB0ZWxsIHRoaXMgaXMgbm90
IGRvY3VtZW50ZWQgYW55d2hlcmUuIEluIHBhcnRpY3VsYXIsDQo+Pj4+DQo+Pj4+IC0gSXMg
YnZfbGVuIGFsaWduZWQgdG8gU0VDVE9SX1NJWkU/DQo+Pj4NCj4+PiBUaGUgYmxvY2sgbGF5
ZXIgYWx3YXlzIHVzZXMgYSA1MTIgYnl0ZSBzZWN0b3Igc2l6ZSwgc28geWVzLg0KPj4+DQo+
Pj4+IC0gVG8gbG9naWNhbF9zZWN0b3Jfc2l6ZT8NCj4+Pg0KPj4+IE5vdCBuZWNlc3Nhcmls
eS4gQnZlY3MgYXJlIGEgY29uc2VjdXRpdmUgbGlzdCBvZiBieXRlIHJhbmdlcyB3aGljaA0K
Pj4+IG1ha2UgdXAgdGhlIGRhdGEgcG9ydGlvbiBvZiBhIGJpby4NCj4+PiBUaGUgbG9naWNh
bCBzZWN0b3Igc2l6ZSBpcyBhIHByb3BlcnR5IG9mIHRoZSByZXF1ZXN0IHF1ZXVlLCB3aGlj
aCBpcw0KPj4+IGFwcGxpZWQgd2hlbiBhIHJlcXVlc3QgaXMgZm9ybWVkIGZyb20gb25lIG9y
IHNldmVyYWwgYmlvcy4NCj4+PiBGb3IgdGhlIHJlcXVlc3QgdGhlIG92ZXJhbGwgbGVuZ3Ro
IG5lZWQgdG8gYmUgYSBtdWx0aXBsZSBvZiB0aGUgbG9naWNhbA0KPj4+IHNlY3RvciBzaXpl
LCBidXQgbm90IG5lY2Vzc2FyaWx5IHRoZSBpbmRpdmlkdWFsIGJpb3MuDQo+Pg0KPj4gT2gs
IHNvIHRoaXMgaXMgd29yc2UgdGhhbiBJIHRob3VnaHQuIFNvIGlmIHlvdSBjYXJlIGFib3V0
IGUuZy4gb25seSBzdWJtaXR0aW5nIEkvTyBpbiB1bml0cyBvZiBsb2dpY2FsX2Jsb2NrX3Np
emUsIHlvdSBoYXZlIHRvIGNvbWJpbmUNCj4gID4gc2VnbWVudHMgYWNyb3NzIHRoZSBlbnRp
cmUgcmVxdWVzdC4+DQo+IFdlbGwsIHllcywgYW5kIG5vLg0KPiBZb3UgbWlnaHQgYmUgc2Vl
aW5nIGEgcmVxdWVzdCB3aXRoIHNldmVyYWwgYmlvcywgZWFjaCBoYXZpbmcgc21hbGwNCj4g
YnZlY3MuIEJ1dCBpbiB0aGUgZHJpdmVyIHlvdSB3aWxsIHdhbnQgdG8gdXNlIGFuIGlvdiBp
dGVyYXRvciBvciBtYXANCj4gaXQgaW50byBhIHNnIGxpc3QgdmlhIGJsa19ycV9tYXBfc2co
KSwgYW5kIHRoZW4gaXRlcmF0ZSBvdmVyIHRoYXQNCj4gZm9yIHN1Ym1pc3Npb24uDQo+IA0K
PiBbIC4uIF0NCj4+Pj4gLSBDYW4gSSBzb21laG93IHJlcXVlc3QgdG8gb25seSBnZXQgc2Vn
bWVudHMgd2l0aCBidl9sZW4gYWxpZ25lZCB0bw0KPj4+PiDCoMKgIGxvZ2ljYWxfc2VjdG9y
X3NpemU/IE9yIGRvIEkgbmVlZCB0byBkbyBteSBvd24gY29hbGVzY2luZyBhbmQgYm91bmNl
DQo+Pj4+IMKgwqAgYnVmZmVyaW5nIGZvciB0aGF0Pw0KPj4+Pg0KPj4+DQo+Pj4gVGhlIGRy
aXZlciBzdXJlbHkgY2FuLiBZb3Ugc2hvdWxkIGJlIGFibGUgdG8gc2V0ICdtYXhfc2VnbWVu
dF9zaXplJyB0bw0KPj4+IHRoZSBsb2dpY2FsIGJsb2NrIHNpemUsIGFuZCB0aGF0IHNob3Vs
ZCBnaXZlIHlvdSB3aGF0IHlvdSB3YW50Lg0KPj4NCj4+IEJ1dCBjb3VsZG4ndCBJIGdldCBz
ZWdtZW50cyBzbWFsbGVyIHRoYW4gdGhhdD8gbWF4X3NlZ21lbnRfc2l6ZSBzZWVtcyBsaWtl
DQo+PiBpdCB3b3VsZCBvbmx5IHJlc3RyaWN0IHRoZSBtYXhpbXVtIHNpemUsIGxlYXZpbmcg
dGhlIHBvc3NpYmlsaXR5IG9wZW4gZm9yDQo+PiBzbWFsbGVyIHNlZ21lbnRzLg0KPj4NCj4g
QXMgbWVudGlvbmVkOiBpbmRpdmlkdWFsIHNlZ21lbnRzIG1pZ2h0LiBUaGUgb3ZlcmFsbCBy
ZXF1ZXN0IHN0aWxsIHdpbGwgYWRoZXJlIHRvIHRoZSBsb2dpY2FsIGJsb2NrIHNpemUgc2V0
dGluZyAoaWUgaXQgd2lsbCBuZXZlciBiZSBzbWFsbGVyIHRoYW4gdGhlIGxvZ2ljYWwgYmxv
Y2sgc2l6ZSkuDQo+IA0KPiBNYXliZSBoYXZlIGEgbG9vayBhdCBkcml2ZXJzL210ZC91Ymkv
YmxvY2suYy4gVGhlcmUgdGhlIGRyaXZlciB3aWxsDQo+IG1hcCB0aGUgcmVxdWVzdCBvbnRv
IGEgc2NhdHRlcmxpc3QsIGFuZCB0aGVuIGl0ZXJhdGUgb3ZlciB0aGUgc2cgZW50cmllcw0K
PiB0byByZWFkIGluIHRoZSBkYXRhLg0KPiANCj4gTm90ZTogbWFwcGluZyBvbnRvIGEgc2Nh
dHRlcmxpc3Qgd2lsbCBjb2FsZXNjZSBhZGphY2VudCBidmVjcywgc28gb24gdGhlDQo+IHNj
YXR0ZXJsaXN0IHlvdSB3aWxsIGZpbmQgb25seSBjb250aWd1b3VzIHNlZ21lbnRzIHdoaWNo
IGFkaGVyZSB0byB0aGUNCj4gbG9naWNhbCBibG9jayBzaXplIGxpbm1pdGF0aW9ucy4NCg0K
SG93IGNhbiB0aGlzIGhhcHBlbj8gRnJvbSBhYm92ZSwgeW91IGNvdWxkIGhhdmUgYSBidmVj
IHdoZXJlIGl0IGNvbnRhaW5zIG9ubHkNCm9uZSBzZWN0b3IuIFNvIGl0IHdpbGwgYWx3YXlz
IGJlIGRpc2NvbnRpZ3VvdXMgaW4gdGVybXMgb2YgdGhlIGxvZ2ljYWwgYmxvY2sgc2l6ZS4N
Cg0KSSd2ZSBsb29rZWQgYXQgdWJpYmxvY2ssIGFuZCB0aGF0IG9ubHkgd29ya3MgZm9yIHRo
YXQgZHJpdmVyIGJlY2F1c2UgaXQncyByZWFkLW9ubHkuDQpUaGUgTVREIEFQSSBhbGxvd3Mg
eW91IHRvIHJlYWQgdW5hbGlnbmVkIGJ1ZmZlcnMgKGFsdGhvdWdoIGl0J3MgaW5lZmZpY2ll
bnQgc2luY2UNCnlvdSBtYXkgcmUtcmVhZCB0aGUgc2FtZSBwYWdlIG11bHRpcGxlIHRpbWVz
KSwgYnV0IGZvciB3cml0ZXMgdGhlIGRhdGEgbXVzdCBiZQ0KYWxpZ25lZCB0byB0aGUgcGFn
ZSBzaXplLg0KDQpJIHRoaW5rIHRoZSBvbmx5IHdheSB0byBzb2x2ZSB0aGlzIGlzIHRvIGNy
ZWF0ZSBhIChtdGQtKXBhZ2Utc2l6ZWQgYnVmZmVyIGFuZCBib3VuY2UNCnRoZSBpbmNvbWlu
ZyBkYXRhIGluIGlmIHRoZSBidmVjIGlzIHNob3J0ZXIgKG9yIGlmIGl0J3MgaW4gaGlnaCBt
ZW1vcnkpLg0KDQotLVNlYW4NCg==
