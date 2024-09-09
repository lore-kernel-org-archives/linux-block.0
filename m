Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3095125A9;
	Mon,  9 Sep 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848264; cv=none; b=EuitiRbhb8dPzoWeuIpKB5FiCVr9r1pxK5fFPENIIKg4FCB6nYlZ5nSwB44hpWf0gIdAyf21ITusrjLqNuVcueQ3xCeWRedXOOzbY6isFps2rmEUYhlthtBRF2QD/ezNufZcE6Bgv25OW666raWn2tPdZt+0xZPaSbkRn09ofa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848264; c=relaxed/simple;
	bh=J68ZTqETm5Qbp+y5vLazgUAqED/33316+Fl+6yd0rjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzT2FAMUsjHizio8i4FEnG2lIzOmtNZwjtAdGVxSk0hwvO7dSsbclRYve6cI+XqrpgDZhB45C+Sc5YbVfuSYSKs1kWFBBUxp7icoo2yrJPAjfgRsNIhsMeizBz4xejmw1kv+NP1ZQLi5BMfQYyDq+BIbaX7JZivuLq12eAw+6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: y6kCOH/xSIWfzAP0+CrT/Q==
X-CSE-MsgGUID: Ol4CaEmdS16ttgyfE2vldQ==
X-IronPort-AV: E=Sophos;i="6.10,213,1719849600"; 
   d="scan'208";a="121461837"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Jens Axboe <axboe@kernel.dk>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v6] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v6] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHbANCA2rqYy3IZ50Cs0aZXrY4W37JL0OyAgAJkMQA=
Date: Mon, 9 Sep 2024 02:17:32 +0000
Message-ID: <ae5739ae-5d9a-4efc-8e64-6a44fe37ed12@xiaomi.com>
References: <20240907024901.405881-1-zhanghui31@xiaomi.com>
 <38a71a3f-b505-48a3-bbaf-2bdf60dfcd9d@kernel.dk>
In-Reply-To: <38a71a3f-b505-48a3-bbaf-2bdf60dfcd9d@kernel.dk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE4134CCA6AFF2469A0F8771E05110A4@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzcgMjE6NDYsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDkvNi8yNCA4OjQ5IFBN
LCBaaGFuZ0h1aSB3cm90ZToNCj4+IEZyb206IHpoYW5naHVpIDx6aGFuZ2h1aTMxQHhpYW9taS5j
b20+DQo+Pg0KPj4gQ3VycmVudGx5LCBmb3IgYSBjb250cm9sbGVyIHRoYXQgc3VwcG9ydHMgbXVs
dGlwbGUgcXVldWVzLCBsaWtlIFVGUzQuMCwNCj4+IHRoZSBtcV9vcHMtPmNvbXBsZXRlIGlzIGV4
ZWN1dGVkIGluIHRoZSBpbnRlcnJ1cHQgdG9wLWhhbGYuIFRoZXJlZm9yZSwNCj4+IHRoZSBmaWxl
IHN5c3RlbSdzIGVuZCBpbyBpcyBleGVjdXRlZCBkdXJpbmcgdGhlIHJlcXVlc3QgY29tcGxldGlv
biBwcm9jZXNzLA0KPj4gc3VjaCBhcyBmMmZzX3dyaXRlX2VuZF9pbyBvbiBzbWFydHBob25lLg0K
Pj4NCj4+IEhvd2V2ZXIsIHdlIGZvdW5kIHRoYXQgdGhlIGV4ZWN1dGlvbiB0aW1lIG9mIHRoZSBm
aWxlIHN5c3RlbSBlbmQgaW8NCj4+IGlzIHN0cm9uZ2x5IHJlbGF0ZWQgdG8gdGhlIHNpemUgb2Yg
dGhlIGJpbyBhbmQgdGhlIHByb2Nlc3Npbmcgc3BlZWQNCj4+IG9mIHRoZSBDUFUuIEJlY2F1c2Ug
dGhlIGZpbGUgc3lzdGVtJ3MgZW5kIGlvIHdpbGwgdHJhdmVyc2UgZXZlcnkgcGFnZQ0KPj4gaW4g
YmlvLCB0aGlzIGlzIGEgdmVyeSB0aW1lLWNvbnN1bWluZyBvcGVyYXRpb24uDQo+Pg0KPj4gV2Ug
bWVhc3VyZWQgdGhhdCB0aGUgODBNIGJpbyB3cml0ZSBvcGVyYXRpb24gb24gdGhlIGxpdHRsZSBD
UFUgd2lsbA0KPj4gY2F1c2UgdGhlIGV4ZWN1dGlvbiB0aW1lIG9mIHRoZSB0b3AtaGFsZiB0byBi
ZSBncmVhdGVyIHRoYW4gMTAwbXMsDQo+PiB3aGljaCB3aWxsIHVuZG91YnRlZGx5IGFmZmVjdCBp
bnRlcnJ1cHQgcmVzcG9uc2UgbGF0ZW5jeS4NCj4+DQo+PiBMZXQncyBmaXggdGhpcyBpc3N1ZSBi
eSBtb3Zpbmcgbm9uIHN5bmMgcmVxdWVzdHMgY29tcGxldGlvbiB0byBzb2Z0aXJxDQo+PiBjb250
ZXh0LCBhbmQga2VlcGluZyBzeW5jIHJlcXVlc3RzIGNvbXBsZXRpb24gaW4gdGhlIElSUSB0b3At
aGFsZiBjb250ZXh0Lg0KPiBZb3Uga2VlcCBpZ25vcmluZyB0aGUgZmVlZGJhY2ssIGFuZCBoZW5j
ZSBJIHRvbyBzaGFsbCBiZSBpZ25vcmluZyB0aGlzDQo+IHBhdGNoIGdvaW5nIGZvcndhcmQgdGhl
bi4NCj4NCj4gVGhlIGtleSBpc3N1ZSBoZXJlIGlzIHRoYXQgdGhlIGNvbXBsZXRpb24gdGFrZXMg
c28gbG9uZywgYW5kIGFkZGluZyBhDQo+IGhldXJpc3RpYyB0aGF0IGVxdWF0ZXMgbm90LXN5bmMg
d2l0aCBsYXRlbmN5LW5vdC1pbXBvcnRhbnQgaXMgcHJldHR5DQo+IGJvZ3VzIGFuZCBub3QgYSBn
b29kIHdheSB0byBhdHRlbXB0IHRvIHdvcmsgYXJvdW5kIGl0Lg0KPg0KPiAtLQ0KPiBKZW5zIEF4
Ym9lDQo+DQpoaSBKZW5zLA0KDQpTb3JyeSBmb3Igbm90IHJlcGx5aW5nIGluIHRpbWUuDQoNCldl
IGhhdmUgYmFzaWNhbGx5IGRldGVybWluZWQgdGhlIHBsYW4gZm9yIHRoZSBmMmZzIHNpZGUuIFRo
ZSBzaG9ydC10ZXJtDQpwbGFuIGlzIHRvIGxpbWl0IHRoZSBzaXplIG9mIGEgc2luZ2xlIGJpbywg
YW5kIHRoZSBsb25nLXRlcm0gcGxhbiBpcyB0bw0KY2hhbmdlIGYyZnMgZnJvbSBwYWdlIHRvIGZv
bGlvIHRvIHJlZHVjZSB0aGUgcGFnZWNhY2hlIHRyYXZlcnNhbCB0aW1lLg0KDQpIb3dldmVyLCBJ
IHRoaW5rIGl0IGFsc28gbWFrZXMgc2Vuc2UgdG8gbW92ZSBsZXNzIHVyZ2VudCB3b3JrIG91dCBv
ZiB0aGUNCklSUSB0b3AtaGFsZi4NCg0KVGhhbmtzDQpaaGFuZw0KDQo=
