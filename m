Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081711494B0;
	Thu,  5 Sep 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504766; cv=none; b=iSgICVe0vqvMkhCfkBnjYgrrOyqY1ze+CGzdh5r8pwZgqFMB+sGDZoJ8Kigr8WGYD26heJMTZ0joQTLpcN78ukp8quSu/j3YC017e4WHkNrHcQWZUMeeEx+Ymq9obvrKwCsJfQdi6VY08NK0I9HsEVooro1HkOzlk9eSMHGTOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504766; c=relaxed/simple;
	bh=ReNgNwxY9qc6uT/fthDCOkytxfhoQ7TBjs9e1gLc8g0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LGABmjUX2T86XYq36jZ3SxxckvBAJNJrHrjfv0qjVA8IFBR1aVqMP+TuLMF1EItAQE8T+OyqesDU3qfR+iqRZbFgsCkoqmlXCBrLU8v+s3RypvcA59BH+3tN2iuDCFS70XnFrx3Cs7b9Db6IdTtnMfjkOoUICHE3tPrlu8tcg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: jgMBh4xERGKtJzGdjMw//g==
X-CSE-MsgGUID: 4dDGwn+gS92XMASYPxWNVg==
X-IronPort-AV: E=Sophos;i="6.10,203,1719849600"; 
   d="scan'208";a="121173131"
From: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC: "bvanassche@acm.org" <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Topic: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Thread-Index: AQHa/fgOh/cV01vbcESyzBPikRppQrJF0TIAgACy1ICAAXdCgA==
Date: Thu, 5 Sep 2024 02:52:36 +0000
Message-ID: <b89bd2e5-ff8d-4e29-b082-9129284a51cb@xiaomi.com>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <dd859c1b-40d0-4a10-a6af-0d7fae28da41@kernel.dk>
 <ZtfiK1xg2RVzkXW9@infradead.org>
In-Reply-To: <ZtfiK1xg2RVzkXW9@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C8E53D17920864A821C97BEED253C01@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzQgMTI6MjksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAwMywgMjAyNCBhdCAxMTo0OToyOEFNIC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPj4gVGhl
IGVsZXBoYW50IGluIHRoZSByb29tIGhlcmUgaXMgd2h5IGFuIDgwTSBjb21wbGV0aW9uIHRha2Vz
IDEwMCBtc2VjPw0KPj4gVGhhdCBzZWVtcy4uLiBpbnNhbmUuDQo+Pg0KPj4gVGhhdCBhc2lkZSwg
ZG9pbmcgd3JpdGVzIHRoYXQgYmlnIGlzbid0IGdyZWF0IGZvciBsYXRlbmNpZXMgaW4gZ2VuZXJh
bCwNCj4+IGV2ZW4gaWYgdGhleSBhcmUgb3JkZXJzIG9mIG1hZ25pdHVkZSBzbWFsbGVyIChhcyB0
aGV5IHNob3VsZCBiZSkuIE1heWJlDQo+PiB0aGlzIGlzIHNvbHZhYmxlIGJ5IGp1c3QgbGltaXRp
bmcgdGhlIHdyaXRlIHNpemUgaGVyZS4NCj4+DQo+PiBCdXQgaXQgcmVhbGx5IHNlZW1zIG91dCBv
ZiBsaW5lIGZvciBhIHdyaXRlIHRoYXQgc2l6ZSB0byB0YWtlIDEwMCBtc2VjDQo+PiB0byBwcm9j
ZXNzLg0KPiBwYWdlY2FjaGUgc3RhdGUgcHJvY2Vzc2luZyBpcyBxdWl0ZSBpbmVmZmljaWVudCwg
d2UgaGFkIHRvIGxpbWl0DQo+IHRoZSBudW1iZXIgb2YgdGhlbSBmb3IgWEZTIHRvIGF2b2lkIGxh
dGVuY3kgcHJvYmxlbXMgYSB3aGlsZSBhZ28uDQo+IE5vdGUgdGhhdCBtb3ZpbmcgdG8gZm9saW9z
IG1lYW5zIHlvdSBjYW4gcHJvY2VzcyBhIGxvdCBtb3JlIGRhdGENCj4gd2l0aCB0aGUgc2FtZSBu
dW1iZXIgb2YgY29tcGxldGlvbiBpdGVyYXRpb25zIGFzIHdlbGwuICBJJ2Qgc3VnZ2VzdA0KPiB0
aGUgc3VibWl0dGVyIGxvb2tzIGludG8gdGhhdCBmb3Igd2hhdGV2ZXIgZmlsZSBzeXN0ZW0gdGhl
eSBhcmUgdXNpbmcuDQo+DQpoaSBDaHJpc3RvcGgsDQoNClRoZSBGMkZTIGZpbGUgc3lzdGVtIGlz
IHVzZWQgb24gdGhlIHNtYXJ0cGhvbmUsIGFuZCBlbmRfaW8gdXNlcyBwYWdlDQp0cmF2ZXJzYWwg
aW5zdGVhZCBvZiBmb2xpbyB0cmF2ZXJzYWwuDQpJIHdpbGwgY29uZmlybSB0aGUgcGxhbiB0byBt
aWdyYXRlIHRvIGZvbGlvLiBUaGFuayB5b3UhDQoNClRoYW5rcw0KWmhhbmcNCg0K
