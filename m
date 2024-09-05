Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426E158D9C;
	Thu,  5 Sep 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521617; cv=none; b=NuDBwuVxWZzft3PXs6I2hVBUGk3MspPYSQLLcruP5Lp40Gb6eRtXnVTEplcTh3aMsOaQjJ5W6/Ji/55SI6D0HQBVB6TauW3I8laLxYjFYwTAD0dSE371RO7IKfKODfd9Fw2QPyAqpw/afhAdIc+TQVpVerfoglg91RZ/1w6yP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521617; c=relaxed/simple;
	bh=97jQbhASEYG0hRESEWRHpQrm7iMLYDbkF9AgdD7u4ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/SxzVwv5rQUu3WlXbUoiVl6rnYuINkiYgsd3Cn/xB++wgitF9xOUXWBUmPgKM+gh23+beMOPXE5pauCrTkqjSJaMFDgE2uEaM+pVU7bK5DWU1AxCZUw0rM/UHdABC+Qys2HcualCbuZkZQNHW8uFGk2xHXwqed6l5wl2H8hlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: HFlxwGecRk6pP0k3uVyLyw==
X-CSE-MsgGUID: ZT7nvTLrQvmXQ1+mUCnY3A==
X-IronPort-AV: E=Sophos;i="6.10,204,1719849600"; 
   d="scan'208";a="121203028"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?5pa557+U?= <fangxiang@xiaomi.com>,
	=?utf-8?B?546L6L6J?= <wanghui33@xiaomi.com>
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHa/fgOh/cV01vbcESyzBPikRppQrJGv0cAgAE6VwCAABGBgIAAPqMA
Date: Thu, 5 Sep 2024 07:33:29 +0000
Message-ID: <a257ff06-ed02-46a2-81fc-caa351a379fd@xiaomi.com>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <ZtgT4HhEsyRJMoQH@fedora> <1641f51b-34f1-47c9-bd69-e56b036fc0f4@xiaomi.com>
 <ZtkqPxgC3tsRdDcz@fedora>
In-Reply-To: <ZtkqPxgC3tsRdDcz@fedora>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A990E78F5636E643885B37D21C4E81D9@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzUgMTE6NDksIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBUaHUsIFNlcCAwNSwgMjAy
NCBhdCAwMjo0NjozOUFNICswMDAwLCDnq6Dovokgd3JvdGU6DQo+PiBPbiAyMDI0LzkvNCAxNjow
MSwgTWluZyBMZWkgd3JvdGU6DQo+Pj4gT24gVHVlLCBTZXAgMDMsIDIwMjQgYXQgMDc6NTQ6MzdQ
TSArMDgwMCwgWmhhbmdIdWkgd3JvdGU6DQo+Pj4+IEZyb206IHpoYW5naHVpIDx6aGFuZ2h1aTMx
QHhpYW9taS5jb20+DQo+Pj4+DQo+Pj4+IEN1cnJlbnRseSwgZm9yIGEgY29udHJvbGxlciB0aGF0
IHN1cHBvcnRzIG11bHRpcGxlIHF1ZXVlcywgbGlrZSBVRlM0LjAsDQo+Pj4+IHRoZSBtcV9vcHMt
PmNvbXBsZXRlIGlzIGV4ZWN1dGVkIGluIHRoZSBpbnRlcnJ1cHQgdG9wLWhhbGYuIFRoZXJlZm9y
ZSwNCj4+Pj4gdGhlIGZpbGUgc3lzdGVtJ3MgZW5kIGlvIGlzIGV4ZWN1dGVkIGR1cmluZyB0aGUg
cmVxdWVzdCBjb21wbGV0aW9uIHByb2Nlc3MsDQo+Pj4+IHN1Y2ggYXMgZjJmc193cml0ZV9lbmRf
aW8gb24gc21hcnRwaG9uZS4NCj4+Pj4NCj4+Pj4gSG93ZXZlciwgd2UgZm91bmQgdGhhdCB0aGUg
ZXhlY3V0aW9uIHRpbWUgb2YgdGhlIGZpbGUgc3lzdGVtIGVuZCBpbw0KPj4+PiBpcyBzdHJvbmds
eSByZWxhdGVkIHRvIHRoZSBzaXplIG9mIHRoZSBiaW8gYW5kIHRoZSBwcm9jZXNzaW5nIHNwZWVk
DQo+Pj4+IG9mIHRoZSBDUFUuIEJlY2F1c2UgdGhlIGZpbGUgc3lzdGVtJ3MgZW5kIGlvIHdpbGwg
dHJhdmVyc2UgZXZlcnkgcGFnZQ0KPj4+PiBpbiBiaW8sIHRoaXMgaXMgYSB2ZXJ5IHRpbWUtY29u
c3VtaW5nIG9wZXJhdGlvbi4NCj4+Pj4NCj4+Pj4gV2UgbWVhc3VyZWQgdGhhdCB0aGUgODBNIGJp
byB3cml0ZSBvcGVyYXRpb24gb24gdGhlIGxpdHRsZSBDUFUgd2lsbA0KPj4+IFdoYXQgaXMgODBN
IGJpbz8NCj4+Pg0KPj4+IEl0IGlzIG9uZSBrbm93biBpc3N1ZSB0aGF0IHNvZnQgbG9ja3VwIG1h
eSBiZSB0cmlnZ2VyZWQgaW4gY2FzZSBvZiBOOk0NCj4+PiBibGstbXEgbWFwcGluZywgYnV0IG5v
dCBzdXJlIGlmIHRoYXQgaXMgdGhlIGNhc2UuDQo+Pj4NCj4+PiBXaGF0IGlzIG5yX2h3X3F1ZXVl
cyhibGtfbXEpIGFuZCBucl9jcHVzIGluIHlvdXIgc3lzdGVtPw0KPj4+DQo+Pj4+IGNhdXNlIHRo
ZSBleGVjdXRpb24gdGltZSBvZiB0aGUgdG9wLWhhbGYgdG8gYmUgZ3JlYXRlciB0aGFuIDEwMG1z
Lg0KPj4+PiBUaGUgQ1BVIHRpY2sgb24gYSBzbWFydHBob25lIGlzIG9ubHkgNG1zLCB3aGljaCB3
aWxsIHVuZG91YnRlZGx5IGFmZmVjdA0KPj4+PiBzY2hlZHVsaW5nIGVmZmljaWVuY3kuDQo+Pj4g
c2NoZWR1bGUgaXMgb2ZmIHRvbyBpbiBzb2Z0aXJxKGJvdHRvbS1oYWxmKS4NCj4+Pg0KPj4+PiBM
ZXQncyBmaXhlZCB0aGlzIGlzc3VlIGJ5IG1vdmVkIG5vbiBzeW5jIHJlcXVlc3QgY29tcGxldGlv
biBmbG93IHRvDQo+Pj4+IHNvZnRpcnEsIGFuZCBrZWVwIHRoZSBzeW5jIHJlcXVlc3QgY29tcGxl
dGlvbiBpbiB0aGUgdG9wLWhhbGYuDQo+Pj4gSWYgeW91IGRvIGNhcmUgaW50ZXJydXB0LW9mZiBv
ciBzY2hlZHVsZS1vZmYgbGF0ZW5jeSwgeW91IG1heSBoYXZlIHRvIG1vdmUNCj4+PiB0aGUgSU8g
aGFuZGxpbmcgaW50byB0aHJlYWQgY29udGV4dCBpbiB0aGUgZHJpdmVyLg0KPj4+DQo+Pj4gQlRX
LCB0aHJlYWRlZCBpcnEgY2FuJ3QgaGVscCB5b3UgdG9vLg0KPj4+DQo+Pj4NCj4+PiBUaGFua3Ms
DQo+Pj4gTWluZw0KPj4+DQo+PiBoaSBNaW5nLA0KPj4NCj4+IFZlcnkgZ29vZCByZW1pbmRlciwg
dGhhbmsgeW91Lg0KPj4NCj4+IE9uIHNtYXJ0cGhvbmVzLCBucl9od19xdWV1ZXMgYW5kIG5yX2Nw
dXMgYXJlIDE6MSwgSSBhbSBtb3JlIGNvbmNlcm5lZA0KPj4gYWJvdXQgdGhlIGludGVycnVwdC1v
ZmYgbGF0ZW5jeSwgd2hpY2ggaXMgbW9yZSBvYnZpb3VzIG9uIGxpdHRsZSBjb3Jlcy4NCj4gU28g
eW91IHN1Ym1pdHMgODBNIGJ5dGVzIGZyb20gb25lIENQVSwgYW5kIGFsbW9zdCBhbGwgdGhlc2Ug
YmlvcyBhcmUgY29tcGxldGVkDQo+IGluIHNpbmdsZSBpbnRlcnJ1cHQsIHdoaWNoIGxvb2tzIHZl
cnkgaW1wb3NzaWJsZSwgZXhjZXB0IHRoYXQgeW91cg0KPiBVRlMgY29udHJvbGxlciBpcyBmYXIg
ZmFzdGVyIHRoYW4gdGhlIENQVS4NCg0KVGhlIDgwTSBiaW8gYmlvIHJlZmVycyB0byB0aGUgYmlv
IHNlbnQgYnkgdGhlIGZpbGUgc3lzdGVtLiBBdCB0aGUgYmxvY2sNCmxheWVyLCBpdCB3aWxsIGJl
IHNwbGl0IGludG8gbWFueSBiaW9zIGFuZCBmb3JtIGEgYmlvIGNoYWluLiBUaGUNCnRpbWUtY29u
c3VtaW5nIHBhcnQgaXMgZW5kX2lvIG9mIGZpbGVzeXN0ZW0gcHJvY2Vzc2luZyBhbGwgcGFnZSBz
dGF0ZS4NCkl0IHdpbGwgb25seSBiZSBhY3R1YWxseSBjYWxsZWQgYWZ0ZXIgYWxsIHRoZSA4ME0g
QklPcyBpbiB0aGUgYmlvIGNoYWluDQphcmUgY29tcGxldGVkLg0KDQo+PiBNb3ZpbmcgdGltZS1j
b25zdW1pbmcgd29yayB0byB0aGUgYm90dG9tIGhhbGYgbWF5IG5vdCBoZWxwIHdpdGggc2NoZWR1
bGUNCj4+IGxhdGVuY3ksIGJ1dCBpdCBpcyBtYXkgaGVscGZ1bCBmb3IgaW50ZXJydXB0IHJlc3Bv
bnNlIGxhdGVuY3kgb2Ygb3RoZXINCj4+IG1vZHVsZXMgaW4gdGhlIHN5c3RlbT8NCj4gc2NoZWR1
bGluZyByZXNwb25zZSBsYXRlbmN5IGlzIHN5c3RlbS13aWRlIHRvby4NCj4NCj4gVGhlbiBwbGVh
c2UgZG9jdW1lbnQgdGhlIGludGVycnVwdCBsYXRlbmN5IGltcHJvdmVtZW50IGluc3RlYWQgb2YN
Cj4gc2NoZWR1bGluZyBpbiB5b3VyIGNvbW1pdCBsb2csIG90aGVyd2lzZSBpdCBpcyBqdXN0IG1p
c2xlYWRpbmcuDQo+DQo+IGBgYA0KPiBUaGUgQ1BVIHRpY2sgb24gYSBzbWFydHBob25lIGlzIG9u
bHkgNG1zLCB3aGljaCB3aWxsIHVuZG91YnRlZGx5IGFmZmVjdA0KPiBzY2hlZHVsaW5nIGVmZmlj
aWVuY3kuDQo+IGBgYA0KPg0KPiBUaGFua3MsDQo+IE1pbmcNCg0KaGkgTWluZywNCg0KT0ssIEkg
d2lsbCB1cGRhdGUgcGF0Y2ggVjQgbGF0ZXIgZm9yIGNvbW1lbnQgdXBkYXRlLg0KVGhhbmsgeW91
IGZvciB5b3VyIHN1Z2dlc3Rpb24hDQpCZXNpZGVzIHRoaXMsZG8geW91IGhhdmUgYW55IG90aGVy
IGNvbmNlcm4/DQoNClRoYW5rcw0KWmhhbmcNCg0K
