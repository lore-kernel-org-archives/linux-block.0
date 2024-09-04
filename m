Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6924D5BD;
	Wed,  4 Sep 2024 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420360; cv=none; b=JeGYzwPPURCM+ZlAR4ks56zYJFEpfYDyorHIoTCnPxlfC803uT9bXqoSTpE3p9tkuq9U1plJ9O+GHKBMBsFuSPVIQq5/2hRvygjqRrajTert48DoG6PRaeJ6PFDxf3NIT/9FNt20YbHcc3o6ogB/vfC/FtAVldwxsVO1Gkn9N0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420360; c=relaxed/simple;
	bh=bmanCmjxWczkQ2hnSDrLENqXLAf+YOBzZ9WKDpz/HC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNLzC3LBUeDoyYl3qK402G9nw9S13oiiuwVwQs2yYnbIIDf5NUbHWODgoNUMsUHwSiEzKWY9c3XCp8WqOo6mTSZSPiTuPZVytK1CjAurrQUqVESQnQtp5qV/MwsvbtHduJG7K9ZTpjlpUqqNuWiNYYIjvVrmu+W3aop3O2b/jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: piDI8MszQ1GvxMU8eMEOXA==
X-CSE-MsgGUID: glaku73bSLamD/v+xkULWw==
X-IronPort-AV: E=Sophos;i="6.10,200,1719849600"; 
   d="scan'208";a="95370732"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Jens Axboe <axboe@kernel.dk>, "bvanassche@acm.org" <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHa/fgOh/cV01vbcESyzBPikRppQrJF0TIAgAChD4A=
Date: Wed, 4 Sep 2024 03:25:55 +0000
Message-ID: <31b99746-badc-4304-877d-790c6ff95c80@xiaomi.com>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <dd859c1b-40d0-4a10-a6af-0d7fae28da41@kernel.dk>
In-Reply-To: <dd859c1b-40d0-4a10-a6af-0d7fae28da41@kernel.dk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6DDBED67C9E32408F07A7428481F025@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzQgMTo0OSwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gOS8zLzI0IDU6NTQgQU0s
IFpoYW5nSHVpIHdyb3RlOg0KPj4gRnJvbTogemhhbmdodWkgPHpoYW5naHVpMzFAeGlhb21pLmNv
bT4NCj4+DQo+PiBDdXJyZW50bHksIGZvciBhIGNvbnRyb2xsZXIgdGhhdCBzdXBwb3J0cyBtdWx0
aXBsZSBxdWV1ZXMsIGxpa2UgVUZTNC4wLA0KPj4gdGhlIG1xX29wcy0+Y29tcGxldGUgaXMgZXhl
Y3V0ZWQgaW4gdGhlIGludGVycnVwdCB0b3AtaGFsZi4gVGhlcmVmb3JlLA0KPj4gdGhlIGZpbGUg
c3lzdGVtJ3MgZW5kIGlvIGlzIGV4ZWN1dGVkIGR1cmluZyB0aGUgcmVxdWVzdCBjb21wbGV0aW9u
IHByb2Nlc3MsDQo+PiBzdWNoIGFzIGYyZnNfd3JpdGVfZW5kX2lvIG9uIHNtYXJ0cGhvbmUuDQo+
Pg0KPj4gSG93ZXZlciwgd2UgZm91bmQgdGhhdCB0aGUgZXhlY3V0aW9uIHRpbWUgb2YgdGhlIGZp
bGUgc3lzdGVtIGVuZCBpbw0KPj4gaXMgc3Ryb25nbHkgcmVsYXRlZCB0byB0aGUgc2l6ZSBvZiB0
aGUgYmlvIGFuZCB0aGUgcHJvY2Vzc2luZyBzcGVlZA0KPj4gb2YgdGhlIENQVS4gQmVjYXVzZSB0
aGUgZmlsZSBzeXN0ZW0ncyBlbmQgaW8gd2lsbCB0cmF2ZXJzZSBldmVyeSBwYWdlDQo+PiBpbiBi
aW8sIHRoaXMgaXMgYSB2ZXJ5IHRpbWUtY29uc3VtaW5nIG9wZXJhdGlvbi4NCj4+DQo+PiBXZSBt
ZWFzdXJlZCB0aGF0IHRoZSA4ME0gYmlvIHdyaXRlIG9wZXJhdGlvbiBvbiB0aGUgbGl0dGxlIENQ
VSB3aWxsDQo+PiBjYXVzZSB0aGUgZXhlY3V0aW9uIHRpbWUgb2YgdGhlIHRvcC1oYWxmIHRvIGJl
IGdyZWF0ZXIgdGhhbiAxMDBtcy4NCj4+IFRoZSBDUFUgdGljayBvbiBhIHNtYXJ0cGhvbmUgaXMg
b25seSA0bXMsIHdoaWNoIHdpbGwgdW5kb3VidGVkbHkgYWZmZWN0DQo+PiBzY2hlZHVsaW5nIGVm
ZmljaWVuY3kuDQo+IFRoZSBlbGVwaGFudCBpbiB0aGUgcm9vbSBoZXJlIGlzIHdoeSBhbiA4ME0g
Y29tcGxldGlvbiB0YWtlcyAxMDAgbXNlYz8NCj4gVGhhdCBzZWVtcy4uLiBpbnNhbmUuDQo+DQo+
IFRoYXQgYXNpZGUsIGRvaW5nIHdyaXRlcyB0aGF0IGJpZyBpc24ndCBncmVhdCBmb3IgbGF0ZW5j
aWVzIGluIGdlbmVyYWwsDQo+IGV2ZW4gaWYgdGhleSBhcmUgb3JkZXJzIG9mIG1hZ25pdHVkZSBz
bWFsbGVyIChhcyB0aGV5IHNob3VsZCBiZSkuIE1heWJlDQo+IHRoaXMgaXMgc29sdmFibGUgYnkg
anVzdCBsaW1pdGluZyB0aGUgd3JpdGUgc2l6ZSBoZXJlLg0KPg0KPiBCdXQgaXQgcmVhbGx5IHNl
ZW1zIG91dCBvZiBsaW5lIGZvciBhIHdyaXRlIHRoYXQgc2l6ZSB0byB0YWtlIDEwMCBtc2VjDQo+
IHRvIHByb2Nlc3MuDQo+DQo+IC0tDQo+IEplbnMgQXhib2UNCj4NCmhpIEplbnMsDQoNClRoaXMg
cHJvYmxlbSBpcyBzdHJvbmdseSByZWxhdGVkIHRvIHdoZXRoZXIgdGhlIENQVSBpcyBhIGxhcmdl
DQpjb3JlIG9yIGEgbGl0dGxlIGNvcmUgYW5kIHRoZSBDUFUgZnJlcXVlbmN5LiBPbiBhIGxhcmdl
IGNvcmUsIHRoZSB0aW1lDQp3aWxsIG9idmlvdXNseSBiZSBzaG9ydGVyLCBidXQgd2UgY2Fubm90
IGFzc3VtZSB3aGljaCBjb3JlIHRoZSBJTyB3aWxsDQpiZSBjb21wbGV0ZWQgb24gYW5kIHRoZSBj
dXJyZW50IENQVSBmcmVxdWVuY3kuLi4NCg0KTGltaXRpbmcgdGhlIElPIHNpemUgaXMgYWxzbyBh
IG1ldGhvZCwgYnV0IGhvdyBsYXJnZSB0byBsaW1pdCBpdCBpcyBhDQpwcm9ibGVtLCBhbmQgSSBh
bSB3b3JyaWVkIHdoZXRoZXIgaXQgd2lsbCBjYXVzZSBiYW5kd2lkdGggbG9zcyBpbg0Kc29tZSBz
Y2VuYXJpb3M/DQoNClRoYW5rcw0KWmhhbmcNCg0K
