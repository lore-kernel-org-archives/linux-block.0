Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEB30EF8B;
	Wed, 11 Mar 2026 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773201655; cv=none; b=gsmw4QcFqd5YQwlk06VJDF0LGlk3QQodjcedI16bkKD+2sCHHHYH+1+XVg00hb3HW00ICZStmTTB2uebHncPUc1suKA0i+9cSKU2xj/uNSOS3KgBWe2CMzysdKLZSdJs5lKv5za8efr39EFuHdtiZXgvwSILV3p33c8J5F5eN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773201655; c=relaxed/simple;
	bh=za318KmxwpZ1gDhTjFlKNWedrLcKDVlRK0MPiajZW+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cbIxc/t93NzZpbOtsaGaJO3L5/pJ6HskCltf0znRkoYoy21FTdYYddlNa69cEemVU+LT/781sgJhtcN4J/niR+ThRTPfjEFVPVIlAAzBDnsI4T96D32CLuUK8BTOY0xO+RdqiTmdGiDFXtSsI4ozWGWvjh7LMLzO/xeH7gerv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4fVxlv1Xy6zYmMpt;
	Wed, 11 Mar 2026 11:57:31 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 11 Mar
 2026 12:00:48 +0800
Received: from a008.hihonor.com (10.68.30.56) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 11 Mar
 2026 12:00:48 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Wed, 11 Mar 2026 12:00:48 +0800
From: gao xu <gaoxu2@honor.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>,
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: RE: zram: Optimize LZ4 dictionary compression performance
Thread-Topic: zram: Optimize LZ4 dictionary compression performance
Thread-Index: AdywM2pDLIO0gp5TQXuJ4OQmnHDBWf//vZmA//4fC/A=
Date: Wed, 11 Mar 2026 04:00:48 +0000
Message-ID: <cfb89ffc52d649f39ec98b844efa8bd9@honor.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
 <aa-2nItXDdeDj4Xi@google.com>
In-Reply-To: <aa-2nItXDdeDj4Xi@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gT24gKDI2LzAzLzEwIDAyOjU0KSwgZ2FvIHh1IHdyb3RlOg0KPiA+ICsJCW1lbWNweSh6
Y3R4LT5jc3RybSwgJmRydi0+YmFzZV9jc3RyZWFtLA0KPiA+ICsJCSAgIHNpemVvZigqemN0eC0+
Y3N0cm0pKTsNCj4gDQo+IERvIHdlIG5lZWQgdG8gZG8gdGhpcyBtZW1jcHkoKSBldmVyeSB0aW1l
Pw0KbWVtY3B5IGlzIGEgcmVwbGFjZW1lbnQgZm9yIExaNF9sb2FkRGljdC4gTFo0X2xvYWREaWN0
IHVwZGF0ZXMgdGhlIExaNCBoYXNoIHRhYmxlIHVzaW5nIHRoZSBkaWN0aW9uYXJ5LiBGdXJ0aGVy
bW9yZSwgTFo0IGFsc28gdXBkYXRlcyBpdHMgaGFzaCB0YWJsZSB3aXRoIHRoZSByZXN1bHRzIG9m
IHRoZSBwcmV2aW91cyBjb21wcmVzc2lvbi4gVGhlcmVmb3JlLCB0byBlbnN1cmUgdGhlIGNvbXBy
ZXNzaW9uIGRpY3Rpb25hcnkgcmVtYWlucyBlZmZlY3RpdmUsIHdlIHdvdWxkIG5lZWQgdG8gcmVz
ZXQgdGhlIGhhc2ggdGFibGUgZXZlcnkgdGltZSwgd2hpY2ggd291bGQgaW52b2x2ZSBleGVjdXRp
bmcgbWVtY3B5KCkgb3IgTFo0X2xvYWREaWN0KCkuIChQbGVhc2UgY29ycmVjdCBtZSBpZiB0aGVy
ZSdzIGFueSBtaXN1bmRlcnN0YW5kaW5nIGhlcmUuKQ0KPiBBIG5pdDogaWYgaXQgY2Fubm90IGZp
dCBvbiBvbmUgbGluZSwgdGhlbiBsZXQncyBhbGlnbiBzaXplb2YoKnpjdHgtPmNzdHJtKSB3aXRo
ICIoIi4NClJlY2VpdmVkLCB0aGFuayB5b3UuDQoNCg==
