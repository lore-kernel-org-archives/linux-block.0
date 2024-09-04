Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8645026;
	Wed,  4 Sep 2024 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420931; cv=none; b=N3e98niENsSscFj8NYo6Da8Syacs4suv/0h1zL0curt6TGnwcFTXHyd7AIA3L+imzgo8LtOOQhELLXZNfS+qNtC4m3DoujidzG7xcF5FkWNGcJAkupz6GU5H5FbG7ZpLB5hdhr/BXhHQPt2U9SmUYIL2vemsNEsrwNhBAMVnuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420931; c=relaxed/simple;
	bh=Rg4HN5B4NI6qR0vgV3Ph6etPqobsHH1n67sBEbw3ctU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IM2cQdsPq6mpRE0c+Xgoc4i7ojMymBKAfb5m1WwBINmrcaLik3Xnr5rxOIPY+6ezDchCJ/8+U2grBjs7QhEjn9eWdEu28itH72ZJP4O+XQX6pXYYoDJlPAXMAv+1+aUrgrf0XFaqyKlLLbs4qMmLaXYGXsX0fxyIQFrpENoze7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: TTC0Ti2DQQmJVu2lSVSnwQ==
X-CSE-MsgGUID: qUw46wMuTjeU/uA6Hxai1Q==
X-IronPort-AV: E=Sophos;i="6.10,200,1719849600"; 
   d="scan'208";a="95371681"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Bart Van Assche <bvanassche@acm.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHa/fgOh/cV01vbcESyzBPikRppQrJFy1gAgACpkoA=
Date: Wed, 4 Sep 2024 03:35:27 +0000
Message-ID: <f669709a-b8e6-4c76-a75c-f3e7828e09f2@xiaomi.com>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
In-Reply-To: <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6006166A58118948948DCB3826161C68@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

5ZyoIDIwMjQvOS80IDE6MjgsIEJhcnQgVmFuIEFzc2NoZSDlhpnpgZM6DQo+IFvlpJbpg6jpgq7k
u7ZdIA0KPiDmraTpgq7ku7bmnaXmupDkuo7lsI/nsbPlhazlj7jlpJbpg6jvvIzor7fosKjmhY7l
pITnkIbjgILoi6Xlr7npgq7ku7blronlhajmgKflrZjnlpHvvIzor7flsIbpgq7ku7bovazlj5Hn
u5ltaXNlY0B4aWFvbWkuY29t6L+b6KGM5Y+N6aaIIA0KPg0KPg0KPiBPbiA5LzMvMjQgNDo1NCBB
TSwgWmhhbmdIdWkgd3JvdGU6DQo+PiBDdXJyZW50bHksIGZvciBhIGNvbnRyb2xsZXIgdGhhdCBz
dXBwb3J0cyBtdWx0aXBsZSBxdWV1ZXMsIGxpa2UgVUZTNC4wLA0KPj4gdGhlIG1xX29wcy0+Y29t
cGxldGUgaXMgZXhlY3V0ZWQgaW4gdGhlIGludGVycnVwdCB0b3AtaGFsZi4gVGhlcmVmb3JlLA0K
Pj4gdGhlIGZpbGUgc3lzdGVtJ3MgZW5kIGlvIGlzIGV4ZWN1dGVkIGR1cmluZyB0aGUgcmVxdWVz
dCBjb21wbGV0aW9uIA0KPj4gcHJvY2VzcywNCj4+IHN1Y2ggYXMgZjJmc193cml0ZV9lbmRfaW8g
b24gc21hcnRwaG9uZS4NCj4+DQo+PiBIb3dldmVyLCB3ZSBmb3VuZCB0aGF0IHRoZSBleGVjdXRp
b24gdGltZSBvZiB0aGUgZmlsZSBzeXN0ZW0gZW5kIGlvDQo+PiBpcyBzdHJvbmdseSByZWxhdGVk
IHRvIHRoZSBzaXplIG9mIHRoZSBiaW8gYW5kIHRoZSBwcm9jZXNzaW5nIHNwZWVkDQo+PiBvZiB0
aGUgQ1BVLiBCZWNhdXNlIHRoZSBmaWxlIHN5c3RlbSdzIGVuZCBpbyB3aWxsIHRyYXZlcnNlIGV2
ZXJ5IHBhZ2UNCj4+IGluIGJpbywgdGhpcyBpcyBhIHZlcnkgdGltZS1jb25zdW1pbmcgb3BlcmF0
aW9uLg0KPj4NCj4+IFdlIG1lYXN1cmVkIHRoYXQgdGhlIDgwTSBiaW8gd3JpdGUgb3BlcmF0aW9u
IG9uIHRoZSBsaXR0bGUgQ1BVIHdpbGwNCj4+IGNhdXNlIHRoZSBleGVjdXRpb24gdGltZSBvZiB0
aGUgdG9wLWhhbGYgdG8gYmUgZ3JlYXRlciB0aGFuIDEwMG1zLg0KPj4gVGhlIENQVSB0aWNrIG9u
IGEgc21hcnRwaG9uZSBpcyBvbmx5IDRtcywgd2hpY2ggd2lsbCB1bmRvdWJ0ZWRseSBhZmZlY3QN
Cj4+IHNjaGVkdWxpbmcgZWZmaWNpZW5jeS4NCj4+DQo+PiBMZXQncyBmaXhlZCB0aGlzIGlzc3Vl
IGJ5IG1vdmVkIG5vbiBzeW5jIHJlcXVlc3QgY29tcGxldGlvbiBmbG93IHRvDQo+PiBzb2Z0aXJx
LCBhbmQga2VlcCB0aGUgc3luYyByZXF1ZXN0IGNvbXBsZXRpb24gaW4gdGhlIHRvcC1oYWxmLg0K
Pg0KPiBBbiBleHBsYW5hdGlvbiBpcyBtaXNzaW5nIGZyb20gdGhlIHBhdGNoIGRlc2NyaXB0aW9u
IHdoeSB0aGlzIGlzc3VlDQo+IGNhbm5vdCBiZSBzb2x2ZWQgYnkgY2hhbmdpbmcgcnFfYWZmaW5p
dHkgdG8gMi4NCj4NCj4gVGhhbmtzLA0KPg0KPiBCYXJ0Lg0KPg0KaGkgQmFydCwNCg0KRG9lcyBz
ZXQgcnFfYWZmaW5pdHkgdG8gMiBtZWFuIFFVRVVFX0ZMQUdfU0FNRV9DT01QPw0KDQpUaGlzIHNl
ZW1zIHRvIGRldGVybWluZSBvbiB3aGljaCBjb3JlIHRoZSBjdXJyZW50IHJlcXVlc3QgaXMNCmNv
bXBsZXRlZCwgcmF0aGVyIHRoYW4gaW4gdGhlIGludGVycnVwdCB0b3Agb3IgYm90dG9tIGhhbGY/
DQoNClRoYW5rcw0KWmhhbmcNCg0K
