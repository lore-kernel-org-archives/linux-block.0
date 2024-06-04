Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F3145FF7
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492180; cv=none; b=qq+oZmdKSiuWYUYPONU83oKn6xPRDEyKFexLZHZsLej2111gjt1+ePt9zokSZU+IroPfbcKvfRexYtrNFahaYq/Mo37LnAaukaHDFF8JGrKEyF3aTY5hiFdlJd+RERaTMSNuNvpdrV91jSyf24f/GlRrwt2WzL66cFzAYpZ5fVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492180; c=relaxed/simple;
	bh=6Lig3/RUqPr/Yl8BoQ0K6Cf2+zHtdA6WNn4Y6WBWyU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KSxiSlePy9lg+hmEWlcXJQ2tHdgNYXP7NrFe8htOjvktLnYaicWwqVQtLxFdkr2a9VEzqndp0IKZ3XFuEwCG+YBbukJ+vZ30my7XEGLnOos3RcnIkDVIve8KzKiB3rVZp/iLytfhbFNDHtQvRr10bjjk2jl1idOnZS8sMnfp/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45498bSQ008201;
	Tue, 4 Jun 2024 17:08:37 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vtl5z3kdMz2R5sl0;
	Tue,  4 Jun 2024 17:04:39 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 4 Jun 2024
 17:08:36 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Tue, 4 Jun 2024 17:08:36 +0800
From: =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph
 Hellwig" <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMi8yXSBibG9jay9tcS1kZWFkbGluZTogRml4?=
 =?utf-8?Q?_the_tag_reservation_code?=
Thread-Topic: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
Thread-Index: AQHap2kizicYyTkUFUm9uy0mwBNrX7GZ2t6AgB2RWFA=
Date: Tue, 4 Jun 2024 09:08:36 +0000
Message-ID: <8bdfaa1201874892b166a5b5c59ee9c7@BJMBX02.spreadtrum.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
 <c9900a6e-889d-4b7c-8aba-4ab1a89c3672@acm.org>
In-Reply-To: <c9900a6e-889d-4b7c-8aba-4ab1a89c3672@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 45498bSQ008201

SGkgQmFydCBWYW4gQXNzY2hlIGFuZCBKZW5zIEF4Ym9lDQoNClNvcnJ5IHRvIGRpc3R1cmIgeW91
Lg0KV291bGQgeW91IGhhdmUgYSBwbGFuIFdoZW4gd2lsbCB0aGVzZSBwYXRjaCBzZXRzIGJlIG1l
cmdlZCBpbnRvIHRoZSBtYWlubGluZT8gDQpUaGFua3MhDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0t
LS0NCuWPkeS7tuS6ujogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+IA0K5Y+R
6YCB5pe26Ze0OiAyMDI05bm0NeaciDE35pelIDU6MjgNCuaUtuS7tuS6ujogWWFuZ1lhbmcgPHlh
bmcueWFuZ0B2aXZvLmNvbT4NCuaKhOmAgTogbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtl
cm5lbC5vcmc+OyDniZvlv5flm70gKFpoaWd1byBOaXUpIDxaaGlndW8uTml1QHVuaXNvYy5jb20+
OyBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQrkuLvpopg6IFJlOiBbUEFUQ0ggdjIgMi8y
XSBibG9jay9tcS1kZWFkbGluZTogRml4IHRoZSB0YWcgcmVzZXJ2YXRpb24gY29kZQ0KDQoNCuaz
qOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW6YOo44CC6Zmk6Z2e5L2g56Gu5a6a6YKu5Lu2
5YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K55Ye75Lu75L2V6ZO+5o6l5ZKM6ZmE5Lu244CC
DQpDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdh
bml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0K
DQoNCk9uIDUvMTYvMjQgMDI6MTQsIFlhbmdZYW5nIHdyb3RlOg0KPj4gQEAgLTUxMyw5ICs1Mjcs
OSBAQCBzdGF0aWMgdm9pZCBkZF9kZXB0aF91cGRhdGVkKHN0cnVjdCBibGtfbXFfaHdfY3R4DQo+
PiAqaGN0eCkNCj4+ICAgICAgIHN0cnVjdCBkZWFkbGluZV9kYXRhICpkZCA9IHEtPmVsZXZhdG9y
LT5lbGV2YXRvcl9kYXRhOw0KPj4gICAgICAgc3RydWN0IGJsa19tcV90YWdzICp0YWdzID0gaGN0
eC0+c2NoZWRfdGFnczsNCj4+IC0gICAgZGQtPmFzeW5jX2RlcHRoID0gbWF4KDFVTCwgMyAqIHEt
Pm5yX3JlcXVlc3RzIC8gNCk7DQo+PiArICAgIGRkLT5hc3luY19kZXB0aCA9IHEtPm5yX3JlcXVl
c3RzOw0KPj4gLSAgICBzYml0bWFwX3F1ZXVlX21pbl9zaGFsbG93X2RlcHRoKCZ0YWdzLT5iaXRt
YXBfdGFncywNCj4+IGRkLT5hc3luY19kZXB0aCk7DQo+PiArICAgIHNiaXRtYXBfcXVldWVfbWlu
X3NoYWxsb3dfZGVwdGgoJnRhZ3MtPmJpdG1hcF90YWdzLCAxKTsNCj4NCj4gSWYgc2JxLT5taW5f
c2hhbGxvd19kZXB0aCBpcyBzZXQgdG8gMSwgc2JxLT53YWtlX2JhdGNoIHdpbGwgYWxzbyBiZSAN
Cj4gc2V0IHRvIDEuIEkgZ3Vlc3MgdGhpcyBtYXkgcmVzdWx0IGluIGJhdGNoIHdha2V1cCBub3Qg
d29ya2luZyBhcyBleHBlY3RlZC4NCg0KVGhlIHZhbHVlIG9mIHRoZSBzYnEtPm1pbl9zaGFsbG93
X2RlcHRoIHBhcmFtZXRlciBtYXkgYWZmZWN0IHBlcmZvcm1hbmNlIGJ1dCBkb2VzIG5vdCBhZmZl
Y3QgY29ycmVjdG5lc3MuIFNlZSBhbHNvIHRoZSBjb21tZW50IGFib3ZlIHRoZQ0Kc2JpdG1hcF9x
dWV1ZV9taW5fc2hhbGxvd19kZXB0aCgpIGRlY2xhcmF0aW9uLiBJcyB0aGlzIHN1ZmZpY2llbnQg
dG8gYWRkcmVzcyB5b3VyIGNvbmNlcm4/DQoNClRoYW5rcywNCg0KQmFydC4NCg==
