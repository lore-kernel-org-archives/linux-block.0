Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61811FB4;
	Thu,  5 Sep 2024 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504410; cv=none; b=nTMpfKCSxn8zJXWxr6pZKM9dSCMnNe2jCNCq6txI3fMzNnqttCisMYjR2NuyFP3cqWKLd0oX2xEq8PSzwWXQS4744ygkYaGDH5hDC3nv/Vn1EdZdJrYhEjn6jaamHp3DHwiA6R6FHxUBd5tYk3H1ovsOSMy4lXOb95N8e9fErxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504410; c=relaxed/simple;
	bh=J9823JSOJdn7kW1f9uSWn6n/yxKVwSGqiYhXuYKksjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EjaZW8hRh603pNBAvkusA6lCztqtS2P6ngf3vcT8AvBHnLjAS9swPRJu5Mg7vChqtdq8u9S4o6WC17XRdnttY3M2jdxt9+ZPayaETWgStdbxAVS+mPql/qZLVi4yYbEyr813CxKXrpeckTkvj/Ecf9cngBnWdqRxmv7hKNLwg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 4HRn6xVrRTGk5MlFCL93/w==
X-CSE-MsgGUID: qN2v+QB7Tz2EpU8s1dMvRg==
X-IronPort-AV: E=Sophos;i="6.10,203,1719849600"; 
   d="scan'208";a="121172516"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?5pa557+U?= <fangxiang@xiaomi.com>,
	=?utf-8?B?SHVpMTE3IFdhbmcg546L6L6J?= <wanghui117@xiaomi.com>
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHa/fgOh/cV01vbcESyzBPikRppQrJGv0cAgAE6VwA=
Date: Thu, 5 Sep 2024 02:46:39 +0000
Message-ID: <1641f51b-34f1-47c9-bd69-e56b036fc0f4@xiaomi.com>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <ZtgT4HhEsyRJMoQH@fedora>
In-Reply-To: <ZtgT4HhEsyRJMoQH@fedora>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAD37CDC24FA2C46B5ED9A42455B3518@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzQgMTY6MDEsIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBUdWUsIFNlcCAwMywgMjAy
NCBhdCAwNzo1NDozN1BNICswODAwLCBaaGFuZ0h1aSB3cm90ZToNCj4+IEZyb206IHpoYW5naHVp
IDx6aGFuZ2h1aTMxQHhpYW9taS5jb20+DQo+Pg0KPj4gQ3VycmVudGx5LCBmb3IgYSBjb250cm9s
bGVyIHRoYXQgc3VwcG9ydHMgbXVsdGlwbGUgcXVldWVzLCBsaWtlIFVGUzQuMCwNCj4+IHRoZSBt
cV9vcHMtPmNvbXBsZXRlIGlzIGV4ZWN1dGVkIGluIHRoZSBpbnRlcnJ1cHQgdG9wLWhhbGYuIFRo
ZXJlZm9yZSwNCj4+IHRoZSBmaWxlIHN5c3RlbSdzIGVuZCBpbyBpcyBleGVjdXRlZCBkdXJpbmcg
dGhlIHJlcXVlc3QgY29tcGxldGlvbiBwcm9jZXNzLA0KPj4gc3VjaCBhcyBmMmZzX3dyaXRlX2Vu
ZF9pbyBvbiBzbWFydHBob25lLg0KPj4NCj4+IEhvd2V2ZXIsIHdlIGZvdW5kIHRoYXQgdGhlIGV4
ZWN1dGlvbiB0aW1lIG9mIHRoZSBmaWxlIHN5c3RlbSBlbmQgaW8NCj4+IGlzIHN0cm9uZ2x5IHJl
bGF0ZWQgdG8gdGhlIHNpemUgb2YgdGhlIGJpbyBhbmQgdGhlIHByb2Nlc3Npbmcgc3BlZWQNCj4+
IG9mIHRoZSBDUFUuIEJlY2F1c2UgdGhlIGZpbGUgc3lzdGVtJ3MgZW5kIGlvIHdpbGwgdHJhdmVy
c2UgZXZlcnkgcGFnZQ0KPj4gaW4gYmlvLCB0aGlzIGlzIGEgdmVyeSB0aW1lLWNvbnN1bWluZyBv
cGVyYXRpb24uDQo+Pg0KPj4gV2UgbWVhc3VyZWQgdGhhdCB0aGUgODBNIGJpbyB3cml0ZSBvcGVy
YXRpb24gb24gdGhlIGxpdHRsZSBDUFUgd2lsbA0KPiBXaGF0IGlzIDgwTSBiaW8/DQo+DQo+IEl0
IGlzIG9uZSBrbm93biBpc3N1ZSB0aGF0IHNvZnQgbG9ja3VwIG1heSBiZSB0cmlnZ2VyZWQgaW4g
Y2FzZSBvZiBOOk0NCj4gYmxrLW1xIG1hcHBpbmcsIGJ1dCBub3Qgc3VyZSBpZiB0aGF0IGlzIHRo
ZSBjYXNlLg0KPg0KPiBXaGF0IGlzIG5yX2h3X3F1ZXVlcyhibGtfbXEpIGFuZCBucl9jcHVzIGlu
IHlvdXIgc3lzdGVtPw0KPg0KPj4gY2F1c2UgdGhlIGV4ZWN1dGlvbiB0aW1lIG9mIHRoZSB0b3At
aGFsZiB0byBiZSBncmVhdGVyIHRoYW4gMTAwbXMuDQo+PiBUaGUgQ1BVIHRpY2sgb24gYSBzbWFy
dHBob25lIGlzIG9ubHkgNG1zLCB3aGljaCB3aWxsIHVuZG91YnRlZGx5IGFmZmVjdA0KPj4gc2No
ZWR1bGluZyBlZmZpY2llbmN5Lg0KPiBzY2hlZHVsZSBpcyBvZmYgdG9vIGluIHNvZnRpcnEoYm90
dG9tLWhhbGYpLg0KPg0KPj4gTGV0J3MgZml4ZWQgdGhpcyBpc3N1ZSBieSBtb3ZlZCBub24gc3lu
YyByZXF1ZXN0IGNvbXBsZXRpb24gZmxvdyB0bw0KPj4gc29mdGlycSwgYW5kIGtlZXAgdGhlIHN5
bmMgcmVxdWVzdCBjb21wbGV0aW9uIGluIHRoZSB0b3AtaGFsZi4NCj4gSWYgeW91IGRvIGNhcmUg
aW50ZXJydXB0LW9mZiBvciBzY2hlZHVsZS1vZmYgbGF0ZW5jeSwgeW91IG1heSBoYXZlIHRvIG1v
dmUNCj4gdGhlIElPIGhhbmRsaW5nIGludG8gdGhyZWFkIGNvbnRleHQgaW4gdGhlIGRyaXZlci4N
Cj4NCj4gQlRXLCB0aHJlYWRlZCBpcnEgY2FuJ3QgaGVscCB5b3UgdG9vLg0KPg0KPg0KPiBUaGFu
a3MsDQo+IE1pbmcNCj4NCmhpIE1pbmcsDQoNClZlcnkgZ29vZCByZW1pbmRlciwgdGhhbmsgeW91
Lg0KDQpPbiBzbWFydHBob25lcywgbnJfaHdfcXVldWVzIGFuZCBucl9jcHVzIGFyZSAxOjEsIEkg
YW0gbW9yZSBjb25jZXJuZWQNCmFib3V0IHRoZSBpbnRlcnJ1cHQtb2ZmIGxhdGVuY3ksIHdoaWNo
IGlzIG1vcmUgb2J2aW91cyBvbiBsaXR0bGUgY29yZXMuDQoNCk1vdmluZyB0aW1lLWNvbnN1bWlu
ZyB3b3JrIHRvIHRoZSBib3R0b20gaGFsZiBtYXkgbm90IGhlbHAgd2l0aCBzY2hlZHVsZQ0KbGF0
ZW5jeSwgYnV0IGl0IGlzIG1heSBoZWxwZnVsIGZvciBpbnRlcnJ1cHQgcmVzcG9uc2UgbGF0ZW5j
eSBvZiBvdGhlcg0KbW9kdWxlcyBpbiB0aGUgc3lzdGVtPw0KDQpUaGFua3MNClpoYW5nDQoNCg==
