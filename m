Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE278184D
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797498; cv=none; b=t/dArpt0kcNyaAh4StzWIYp+qMI+3br/2DTTBafapo7+X+DT2NhHuIRLvfyunMg64jg16A8zvuSAtyzBy4w4lMHNW8Pl4s0gOLvz+ZF96+2gsqDff2vsiokFf5BTqHpMwHBjjRL1lJzPTyR1ao60vfZ3+xJc9qrs6pF4Ch/sLjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797498; c=relaxed/simple;
	bh=YVFi9c5jilG6eH5c+1dI1w5yW0NJ8o+eSTf2mPKtplQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kakV2uA9VONbg7faoolkbB+xf/nXUo0ePGYLwm90joN2pNShz0DYV8ZRzyAxc1s+8kwQnwDu44ShYcSNFxe/4yEacEaD/u9xMAoFV032/cP356zMUjqx451u5uuRBcv4Fz5A3BG/Uzzi7Kl8lYOoUXxX0vAPz8IDHTs52ADSn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4611UbOS083984;
	Mon, 1 Jul 2024 09:30:37 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WC7f04ghYz2KHC1Q;
	Mon,  1 Jul 2024 09:25:44 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 1 Jul 2024
 09:30:34 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Mon, 1 Jul 2024 09:30:34 +0800
From: =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Damien Le
 Moal" <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Bart Van
 Assche" <bvanassche@acm.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?=
	<Hao_hao.Wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2MiAyLzJdIGJsb2NrL21xLWRlYWRs?=
 =?utf-8?Q?ine:_Fix_the_tag_reservation_code?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMi8yXSBibG9jay9tcS1kZWFkbGluZTogRml4?=
 =?utf-8?Q?_the_tag_reservation_code?=
Thread-Index: AQHap2kizicYyTkUFUm9uy0mwBNrX7GZ2t6AgB2RWFD//6krAIAqQfaQ
Date: Mon, 1 Jul 2024 01:30:34 +0000
Message-ID: <e0edef374df6415cb2e68539c0189614@BJMBX02.spreadtrum.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
 <c9900a6e-889d-4b7c-8aba-4ab1a89c3672@acm.org>
 <8bdfaa1201874892b166a5b5c59ee9c7@BJMBX02.spreadtrum.com>
 <366285cb-b099-4c8e-ba52-63c34b55db7f@acm.org>
In-Reply-To: <366285cb-b099-4c8e-ba52-63c34b55db7f@acm.org>
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
X-MAIL:SHSQR01.spreadtrum.com 4611UbOS083984

SGkgYmxvY2sgZGV2ZWxvcGVycywNCg0KQ2FuIHlvdSBoZWxwIHJldmlldyB0aGlzIHNlcmlhbHMg
cGF0Y2ggZnJvbSBCYXJ0IFZhbiBBc3NjaGU/IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjQwNTA5MTcwMTQ5Ljc2MzktMS1idmFuYXNzY2hlQGFjbS5vcmcvDQpbUEFUQ0ggdjIgMS8y
XSBibG9jazogQ2FsbCAubGltaXRfZGVwdGgoKSBhZnRlciAuaGN0eCBoYXMgYmVlbiBzZXQNCltQ
QVRDSCB2MiAyLzJdIGJsb2NrL21xLWRlYWRsaW5lOiBGaXggdGhlIHRhZyByZXNlcnZhdGlvbiBj
b2RlDQoNClRoZXNlIHBhdGNoIHdpbGwgZml4IHRoZSBpc3N1ZSAidGhlcmUgbWF5IHdhcm5pbmcg
aGFwcGVuIGlmIHdlIHNldCBkZCBhc3luY19kZXB0aCBmcm9tIHVzZXIiLCANCkZvciBtb3JlIGlu
Zm9ybWF0aW9uIGFib3V0IHdhcm5pbmdzLCBwbGVhc2UgcmVmZXIgdG8gY29tbWl0IG1zZzoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUhKOFAzS0VPQ19EWFFtWkszdTdQSGdaRm1XcE1W
elBhNnBna09ncHlvSDd3Z1Q1bndAbWFpbC5nbWFpbC5jb20vDQoNCklmIHlvdSBuZWVkIGFueSB0
ZXN0cywgeW91IGNhbiBhc2sgbWUuIEkgY2FuIGhlbHAgaWYgbXkgZXhwZXJpbWVudGFsIGVudmly
b25tZW50IGNhbiBiZSBpbXBsZW1lbnRlZC4NClRoYW5rcyENCi0tLS0t6YKu5Lu25Y6f5Lu2LS0t
LS0NCuWPkeS7tuS6ujogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+IA0K5Y+R
6YCB5pe26Ze0OiAyMDI05bm0NuaciDTml6UgMTk6NDkNCuaUtuS7tuS6ujog54mb5b+X5Zu9ICha
aGlndW8gTml1KSA8WmhpZ3VvLk5pdUB1bmlzb2MuY29tPjsgSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPg0K5oqE6YCBOiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPjsgRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz47
IOeOi+eakyAoSGFvX2hhbyBXYW5nKSA8SGFvX2hhby5XYW5nQHVuaXNvYy5jb20+DQrkuLvpopg6
IFJlOiDnrZTlpI06IFtQQVRDSCB2MiAyLzJdIGJsb2NrL21xLWRlYWRsaW5lOiBGaXggdGhlIHRh
ZyByZXNlcnZhdGlvbiBjb2RlDQoNCg0K5rOo5oSPOiDov5nlsIHpgq7ku7bmnaXoh6rkuo7lpJbp
g6jjgILpmaTpnZ7kvaDnoa7lrprpgq7ku7blhoXlrrnlronlhajvvIzlkKbliJnkuI3opoHngrnl
h7vku7vkvZXpk77mjqXlkozpmYTku7bjgIINCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KT24gNi80LzI0IDAyOjA4LCDniZvlv5flm70g
KFpoaWd1byBOaXUpIHdyb3RlOg0KPiBXb3VsZCB5b3UgaGF2ZSBhIHBsYW4gV2hlbiB3aWxsIHRo
ZXNlIHBhdGNoIHNldHMgYmUgbWVyZ2VkIGludG8gdGhlIG1haW5saW5lPw0KDQpUaGVzZSBwYXRj
aGVzIHN0aWxsIGFwcGx5IHdpdGhvdXQgYW55IGNoYW5nZXMgdG8gSmVucycgYmxvY2svZm9yLW5l
eHQgYnJhbmNoLiBJIHRoaW5rIHRoZSBuZXh0IHN0ZXAgaXMgdGhhdCBzb21lb25lIGhlbHBzIGJ5
IHBvc3RpbmcgUmV2aWV3ZWQtYnkgb3IgVGVzdGVkLWJ5IHRhZ3MgZm9yIHRoZXNlIHBhdGNoZXMu
DQoNClRoYW5rcywNCg0KQmFydC4NCg==
