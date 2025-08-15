Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242032D1308;
	Fri, 15 Aug 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248138; cv=none; b=uU404ZSxfQ05sjonE1nNofKtuK26/ZQ25zrcV0u2yetgY2v4mMePJJuO8unxhIlpQ0QynSyWsDleqxrOBJiKo80sD9P9e8lrn/d2pvbLJFZrvkif/37tMVK1Vid8zWhHv1AHSmJvTHqJC9IyarUcROofzLWIJOu0I7/FxC7ICzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248138; c=relaxed/simple;
	bh=SVN0u/TGQIp5tjfqWI9pwP28aQFwTLYUt1W/pUQeEvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FaaumTnDokoHPiw67ny/fb7WHZ5ihXolWD/RNDXGGr+VuqgEUYAEoQ/EXrrUkFu/l5iT4ZXMpFyNgBBEs1USGIAeKdmYBOL4kAydaJpCEDqBhBY6xI6Ti5r5IRluQ/ab6i7FKRPxQFKqZxVclx8r8NyuGyb16E089CfTJpWphp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=fail (1024-bit key) header.d=126.com header.i=@126.com header.b=V4tyR2SQ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="V4tyR2SQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zacT6xkjTGxRYpvcmxrSsU9fI1AYXqPhHOXgZeRyHHE=; b=V
	4tyR2SQewYBBH46H5T/zAHEEvAZrS33Xpx5WO1NOArX9zWN4GGyVz7xHvXQRffn4
	xfSmDZ14kxlXMIb1CfRGAPBu2dpc7vJSvGg4WGqnz4Tbkq26eTFWEvekGHFr6bK7
	7DAW6MPgz0Th+pCHn+EhuXNt7ef3qkmi1L3DkJNQxw=
Received: from zhanggenjian$126.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-41-115 (Coremail) ; Fri, 15 Aug 2025 16:53:57 +0800
 (CST)
Date: Fri, 15 Aug 2025 16:53:57 +0800 (CST)
From: "genjian zhang" <zhanggenjian@126.com>
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: axboe@kernel.dk, shinichiro.kawasaki@wdc.com, johannes.thumshirn@wdc.com,
	kch@nvidia.com, zhengqixing@huawei.com, willy@infradead.org,
	namcao@linutronix.de, vincent.fu@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Genjian Zhang" <zhanggenjian@kylinos.cn>
Subject: Re:Re: [PATCH] null_blk: Fix correct parameter desc for the module
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <d892eb87-6ee2-40a4-9b25-66c2f2e8befa@kernel.org>
References: <20250815043033.1534949-1-zhanggenjian@126.com>
 <d892eb87-6ee2-40a4-9b25-66c2f2e8befa@kernel.org>
X-NTES-SC: AL_Qu2eB/6ft0go4SaeZukfmUgQhec8W8ewvfsh2IFXOJl8jAzj5z4JRlNvDHTu4MurETyTqRuYWgZM1/RfUbRWWoMJg59otHgNWOb9W2Gnnx3zzw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <30445c6a.6920.198acef8f24.Coremail.zhanggenjian@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cykvCgD3n+Om9Z5oCj8bAA--.16019W
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHgOqfmieqlav6wAFsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDgtMTUgMTM6MjM6NTAsICJEYW1pZW4gTGUgTW9hbCIgPGRsZW1vYWxAa2VybmVs
Lm9yZz4gd3JvdGU6Cj5PbiA4LzE1LzI1IDEzOjMwLCBHZW5qaWFuIHdyb3RlOgo+PiBGcm9tOiBH
ZW5qaWFuIFpoYW5nIDx6aGFuZ2dlbmppYW5Aa3lsaW5vcy5jbj4KPgo+VGhlIHBhdGNoIHRpdGxl
IGlzIGEgbGl0dGxlIHN0cmFuZ2UuIFdoYXQgYWJvdXQ6Cj4KPm51bGxfYmxrOiBGaXggdGhlIGRl
c2NyaXB0aW9uIG9mIHRoZSBjYWNoZV9zaXplIG1vZHVsZSBhcmd1bWVudAo+Cj4+IAo+PiBXaGVu
IGV4ZWN1dGluZyBtb2RpbmZvIG51bGxfYmxrLCB0aGVyZSBpcyBhbiBlcnJvciBpbiB0aGUgZGVz
Y3JpcHRpb24KPj4gb2YgbW9kdWxlIHBhcmFtZXRlciBtYnBzLCBhbmQgdGhlIG91dHB1dCBpbmZv
cm1hdGlvbiBvZiBjYWNoZV9zaXplIGlzCj4+IGluY29tcGxldGUuVGhlIG91dHB1dCBvZiBtb2Rp
bmZvIGJlZm9yZSBhbmQgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaAo+PiBpcyBhcyBmb2xsb3dz
Ogo+PiAKPj4gQmVmb3JlOgo+PiBbLi4uXQo+PiBwYXJtOiAgICAgICAgICAgY2FjaGVfc2l6ZTp1
bG9uZwo+PiBbLi4uXQo+PiBwYXJtOiAgICAgICAgICAgbWJwczpDYWNoZSBzaXplIGluIE1pQiBm
b3IgbWVtb3J5LWJhY2tlZCBkZXZpY2UuCj4+IAkJRGVmYXVsdDogMCAobm9uZSkgKHVpbnQpCj4+
IFsuLi5dCj4+IAo+PiBBZnRlcjoKPj4gWy4uLl0KPj4gcGFybTogICAgICAgICAgIGNhY2hlX3Np
emU6Q2FjaGUgc2l6ZSBpbiBNaUIgZm9yIG1lbW9yeS1iYWNrZWQgZGV2aWNlLgo+PiAJCURlZmF1
bHQ6IDAgKG5vbmUpICh1bG9uZykKPj4gWy4uLl0KPj4gcGFybTogICAgICAgICAgIG1icHM6TGlt
aXQgbWF4aW11bSBiYW5kd2lkdGggKGluIE1pQi9zKS4KPj4gCQlEZWZhdWx0OiAwIChubyBsaW1p
dCkgKHVpbnQpCj4+IFsuLi5dCj4+IAo+PiBGaXhlczogMDU4ZWZlMDAwYjMxICgibnVsbF9ibGs6
IGFkZCBtb2R1bGUgcGFyYW1ldGVycyBmb3IgNCBvcHRpb25zIikKPj4gCj4KPlJlbW92ZSB0aGUg
YmxhbmsgbGluZSBoZXJlLgo+Cj4+IFNpZ25lZC1vZmYtYnk6IEdlbmppYW4gWmhhbmcgPHpoYW5n
Z2VuamlhbkBreWxpbm9zLmNuPgo+Cj5XaXRoIHRoZXNlIGZpeGVkLAo+Cj5SZXZpZXdlZC1ieTog
RGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4KPgo+LS0gCj5EYW1pZW4gTGUgTW9h
bAo+V2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoCgpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlv
bnMuIEkgd2lsbCBzZW5kIGEgcGF0Y2ggdjIuCgotLSAKR2Vuamlhbgo=
