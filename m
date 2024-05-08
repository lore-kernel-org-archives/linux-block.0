Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3561A2C25
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135355; cv=none; b=qgAmv/VOrmTALO3/mBknmnR1d+Szj5UZxPOIWZ9amKBtH2tM/NN0rRZXaCGwx1eQbv+191Gd8zocj7aWMPjCvX42EFotbrlCFyV4rMvuMWddEczCCqp1351qybCaAYoLilvvziPL1cM1jinRo5E5BiRc9WZZjN5g758hP9w7SxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135355; c=relaxed/simple;
	bh=5Oogk+UJ3qTqVULsButkpnee938XqlYSAYYWe6Cp0R8=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=WGcCcmsa+6x/SKnOJckdaBn7NeVMa/Otj7dmMsWdVQFZpxOg0ru7mt6Ogz6OPRwCw3hoRlOMIV+wlOnMEKe1T1xv/xURf7B6hFJv5wtWUPoONIxfYKyDk0xYI8QQX9Ygykgt75YQiWMx+pdJAbmVIX+KP1i3UvJSeINTDI96ypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4482SA7g004588;
	Wed, 8 May 2024 10:28:10 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VYzWP6Xs5z2PJH5f;
	Wed,  8 May 2024 10:25:05 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 8 May 2024
 10:28:08 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Wed, 8 May 2024 10:28:08 +0800
From: =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal
	<dlemoal@kernel.org>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?=
	<Ke.Wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMS8yXSBibG9jazogQ2FsbCAubGltaXRfZGVwdGgo?=
 =?utf-8?Q?)_after_.hctx_has_been_set?=
Thread-Topic: [PATCH 1/2] block: Call .limit_depth() after .hctx has been set
Thread-Index: AQHahg1Ooezi5XCTgU6377H+1hRBg7FY2VYAgAC9lwCAMzgDkIAAA3Ow
Date: Wed, 8 May 2024 02:28:08 +0000
Message-ID: <8fe8624ac50d49ef9a8aea9de92e93af@BJMBX02.spreadtrum.com>
References: <20240403212354.523925-1-bvanassche@acm.org>
 <20240403212354.523925-2-bvanassche@acm.org> <20240405084640.GA12705@lst.de>
 <a712785d-9441-45c6-a57b-6a35d802028b@acm.org> 
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
X-MAIL:SHSQR01.spreadtrum.com 4482SA7g004588

SGkgIEplbnMgQXhib2UsDQoNCkV4Y3VzZSBtZSwgZG8geW91IGhhdmUgYW55IGNvbW1lbnRzIGFi
b3V0IHRoaXMgcGF0Y2ggc2V0IGZyb20gQmFydCBWYW4gQXNzY2hlLCBXZSBtZWV0IHRoaXMgICJ3
YXJuaW5nIGlzc3VlIiBhYm91dCBhc3luY19kZXB0aCwgbW9yZSBkZXRhaWwgaW5mbyBpcyBpbjoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUhKOFAzS0VPQ19EWFFtWkszdTdQSGdaRm1X
cE1WelBhNnBna09ncHlvSDd3Z1Q1bndAbWFpbC5nbWFpbC5jb20vDQpwbGVhc2UgaGVscCBjb25z
aWRlciBpdCBhbmQgaXQgY2FuIHNvbHZlIHRoZSBhYm92ZSB3YXJuaW5nIGlzc3VlLg0KVGhhbmtz
Lg0KDQpBdHRhY2ggVGhlIGZvbGxvd2luZyBjb21taXQgbXNnIGZyb20gQmFydCBWYW4gQXNzY2hl
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDQwMzIxMjM1NC41MjM5MjUtMS1idmFu
YXNzY2hlQGFjbS5vcmcvI1INCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBC
YXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCuWPkemAgeaXtumXtDogMjAyNOW5
tDTmnIg25pelIDQ6MDUNCuaUtuS7tuS6ujogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
DQrmioTpgIE6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz47IGxpbnV4LWJsb2NrQHZnZXIu
a2VybmVsLm9yZzsgRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz47IOeJm+W/l+Wb
vSAoWmhpZ3VvIE5pdSkgPFpoaWd1by5OaXVAdW5pc29jLmNvbT4NCuS4u+mimDogUmU6IFtQQVRD
SCAxLzJdIGJsb2NrOiBDYWxsIC5saW1pdF9kZXB0aCgpIGFmdGVyIC5oY3R4IGhhcyBiZWVuIHNl
dA0KDQoNCuazqOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW6YOo44CC6Zmk6Z2e5L2g56Gu
5a6a6YKu5Lu25YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K55Ye75Lu75L2V6ZO+5o6l5ZKM
6ZmE5Lu244CCDQpDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9m
IHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCg0KDQoNCk9uIDQvNS8yNCAwMTo0NiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+
IENhbGxpbmcgbGltaXRfZGVwdGggd2l0aCB0aGUgaGN0eCBzZXQgbWFrZSBzZW5zZSwgYnV0IHRo
ZSB3YXkgaXQncyANCj4gZG9uZSBsb29rcyBvZGQuICBXaHkgbm90IHNvbWV0aGluZyBsaWtlIHRo
aXM/DQo+DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEuYyBiL2Jsb2NrL2Jsay1tcS5jIGlu
ZGV4IA0KPiBiOGRiZmVkOGIyOGJlMS4uODg4ODZmZDkzYjFhOWMgMTAwNjQ0DQo+IC0tLSBhL2Js
b2NrL2Jsay1tcS5jDQo+ICsrKyBiL2Jsb2NrL2Jsay1tcS5jDQo+IEBAIC00NDgsNiArNDQ4LDEw
IEBAIHN0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqX19ibGtfbXFfYWxsb2NfcmVxdWVzdHMoc3RydWN0
IGJsa19tcV9hbGxvY19kYXRhICpkYXRhKQ0KPiAgICAgICBpZiAoZGF0YS0+Y21kX2ZsYWdzICYg
UkVRX05PV0FJVCkNCj4gICAgICAgICAgICAgICBkYXRhLT5mbGFncyB8PSBCTEtfTVFfUkVRX05P
V0FJVDsNCj4NCj4gK3JldHJ5Og0KPiArICAgICBkYXRhLT5jdHggPSBibGtfbXFfZ2V0X2N0eChx
KTsNCj4gKyAgICAgZGF0YS0+aGN0eCA9IGJsa19tcV9tYXBfcXVldWUocSwgZGF0YS0+Y21kX2Zs
YWdzLCBkYXRhLT5jdHgpOw0KPiArDQo+ICAgICAgIGlmIChxLT5lbGV2YXRvcikgew0KPiAgICAg
ICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAgICogQWxsIHJlcXVlc3RzIHVzZSBzY2hlZHVs
ZXIgdGFncyB3aGVuIGFuIEkvTyBzY2hlZHVsZXIgDQo+IGlzIEBAIC00NjksMTMgKzQ3Myw5IEBA
IHN0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqX19ibGtfbXFfYWxsb2NfcmVxdWVzdHMoc3RydWN0IGJs
a19tcV9hbGxvY19kYXRhICpkYXRhKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKG9wcy0+
bGltaXRfZGVwdGgpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wcy0+bGltaXRf
ZGVwdGgoZGF0YS0+Y21kX2ZsYWdzLCBkYXRhKTsNCj4gICAgICAgICAgICAgICB9DQo+IC0gICAg
IH0NCj4gLQ0KPiAtcmV0cnk6DQo+IC0gICAgIGRhdGEtPmN0eCA9IGJsa19tcV9nZXRfY3R4KHEp
Ow0KPiAtICAgICBkYXRhLT5oY3R4ID0gYmxrX21xX21hcF9xdWV1ZShxLCBkYXRhLT5jbWRfZmxh
Z3MsIGRhdGEtPmN0eCk7DQo+IC0gICAgIGlmICghKGRhdGEtPnJxX2ZsYWdzICYgUlFGX1NDSEVE
X1RBR1MpKQ0KPiArICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgIGJsa19tcV90YWdfYnVz
eShkYXRhLT5oY3R4KTsNCj4gKyAgICAgfQ0KPg0KPiAgICAgICBpZiAoZGF0YS0+ZmxhZ3MgJiBC
TEtfTVFfUkVRX1JFU0VSVkVEKQ0KPiAgICAgICAgICAgICAgIGRhdGEtPnJxX2ZsYWdzIHw9IFJR
Rl9SRVNWOw0KDQpIaSBDaHJpc3RvcGgsDQoNClRoZSBhYm92ZSBwYXRjaCBsb29rcyBnb29kIHRv
IG1lIGFuZCBJJ20gZmluZSB3aXRoIHJlcGxhY2luZyBwYXRjaCAxLzIgd2l0aCB0aGUgYWJvdmUg
cGF0Y2guIERvIHlvdSB3YW50IG1lIHRvIGFkZCB5b3VyIFNpZ25lZC1vZmYtYnkgdG8gdGhlIGFi
b3ZlIHBhdGNoPw0KDQpUaGFua3MsDQoNCkJhcnQuDQo=
