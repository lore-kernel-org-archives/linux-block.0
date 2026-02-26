Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE21CEACB;
	Thu, 26 Feb 2026 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106531; cv=none; b=Y4PR5Irktu+R12tDVfmYxrCH03GaUIjU6SD3ViKmHmil/bS+kZQfuwa+B2OvQNfuOBw7w7hRhn7/a1DMYkpTm3PviZzjmJX/7H3krbBNTqIpS9nrMzUQJkKmCmhu54jKtNFVefkeAPBNWvlaqPAft5CVm+z+4C8qF+U3bjTw9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106531; c=relaxed/simple;
	bh=p/xatuph0/sh2FYDS+GoX/08w09AH0mFYQfkx2PDLvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W1DSkONl5fFK4a6ftIcJ7XD9iOx0f1yYnOmu7Phtk4fwhYa5mOZRWZUlpoY1wyRswdzx8GMfz1kOW5K0OKJ0tbEUzhFaa1OEOmkKFsc6NTh1zg527xdfRvrbtJCY/jV1MC8htzDXxJPmEGImWoIHhB1jP3O2k00nEE/6sXqbZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4fM8ly6FTmzYkxs9;
	Thu, 26 Feb 2026 19:45:34 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 26 Feb
 2026 19:48:46 +0800
Received: from a008.hihonor.com (10.68.30.56) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 26 Feb
 2026 19:48:45 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Thu, 26 Feb 2026 19:48:45 +0800
From: gao xu <gaoxu2@honor.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>,
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: RE: [PATCH] zram: compression algorithms name use static fields
Thread-Topic: [PATCH] zram: compression algorithms name use static fields
Thread-Index: Adym8lMkejBmbNzMQs2D5/5nPYBYaP//h3uA//9DV+A=
Date: Thu, 26 Feb 2026 11:48:45 +0000
Message-ID: <0058c37421d1470597a599eaddb09a60@honor.com>
References: <32d733a0719c479f85d06f6fec3cc533@honor.com>
 <uizrrkcxvs5dnqn7tosot564gjymgzsuypdtjj4w6wpfxfoxvm@a6quz7px4ssu>
In-Reply-To: <uizrrkcxvs5dnqn7tosot564gjymgzsuypdtjj4w6wpfxfoxvm@a6quz7px4ssu>
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

PiANCj4gT24gKDI2LzAyLzI2IDA3OjUwKSwgZ2FvIHh1IHdyb3RlOg0KPiBbLi5dDQo+ID4gQEAg
LTE2NDgsNiArMTY0NCw3IEBAIHN0YXRpYyBpbnQgX19jb21wX2FsZ29yaXRobV9zdG9yZShzdHJ1
Y3QgenJhbQ0KPiAqenJhbSwgdTMyIHByaW8sIGNvbnN0IGNoYXIgKmJ1ZikNCj4gPiAgew0KPiA+
ICAJY2hhciAqY29tcHJlc3NvcjsNCj4gPiAgCXNpemVfdCBzejsNCj4gPiArCWNvbnN0IGNoYXIg
KmFsZzsNCj4gPg0KPiA+ICAJc3ogPSBzdHJsZW4oYnVmKTsNCj4gPiAgCWlmIChzeiA+PSBaUkFN
X01BWF9BTEdPX05BTUVfU1opDQo+ID4gQEAgLTE2NjEsMTAgKzE2NTgsMTAgQEAgc3RhdGljIGlu
dCBfX2NvbXBfYWxnb3JpdGhtX3N0b3JlKHN0cnVjdCB6cmFtDQo+ICp6cmFtLCB1MzIgcHJpbywg
Y29uc3QgY2hhciAqYnVmKQ0KPiA+ICAJaWYgKHN6ID4gMCAmJiBjb21wcmVzc29yW3N6IC0gMV0g
PT0gJ1xuJykNCj4gPiAgCQljb21wcmVzc29yW3N6IC0gMV0gPSAweDAwOw0KPiA+DQo+ID4gLQlp
ZiAoIXpjb21wX2F2YWlsYWJsZV9hbGdvcml0aG0oY29tcHJlc3NvcikpIHsNCj4gPiAtCQlrZnJl
ZShjb21wcmVzc29yKTsNCj4gPiArCWFsZyA9IHpjb21wX2xvb2t1cF9iYWNrZW5kX25hbWUoY29t
cHJlc3Nvcik7DQo+ID4gKwlrZnJlZShjb21wcmVzc29yKTsNCj4gDQo+IEkgZ3Vlc3Mgd2UgZG9u
J3QgcmVhbGx5IG5lZWQgdG8ga3N0cmR1cCgpIHRoZSBjb21wcmVzc29yIG5hbWU/ICBMb29rdXAN
Cj4gdXNlcyBzeXNmc19zdHJlcSgpLCB3aGljaCBzaG91bGQgdGFrZSBjYXJlIG9mIHRlcm1pbmF0
aW5nIFxuLCBzbyBJIGFzc3VtZQ0KPiB3ZSBjYW4ganVzdCBwYXNzIGBidWZgIHRvIHpjb21wX2xv
b2t1cF9iYWNrZW5kX25hbWUoKSBkaXJlY3RseT8NCj4gDQo+IEkgZ3Vlc3Mgd2UgYWxzbyBjYW4g
Z2V0IHJpZCBvZiBgW3N6IC0gMV0gPT0gJ1xuJ2AgdGhpbmc/DQpJJ3ZlIHZlcmlmaWVkIHlvdXIg
c3VnZ2VzdGVkIGNoYW5nZXMgYW5kIGhhdmVuJ3QgZm91bmQgYW55IGlzc3Vlcy4gDQpJIHdpbGwg
aW5jb3Jwb3JhdGUgdGhpcyBtb2RpZmljYXRpb24gaW50byB0aGUgdjIgdmVyc2lvbi4NCg==
