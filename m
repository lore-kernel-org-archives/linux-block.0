Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135ED14B97A
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909645; cv=none; b=TCgCQzkELnN+R9VFLhnoMK97XD/L4+38tDqf5NoyLRdbgKFOOmog2AkmobEYl81FAq3NWdAPzqHSM3tt6ddInW8I541fDo/hC0QaTznwg8GOLh1G0mkJCwhO7YV2/tpo42hHAHRKtsCFmV46f/l/gJmAL0486/7NyNgQPebmMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909645; c=relaxed/simple;
	bh=fwscrn97KsOnVFjvOnNiiMQZDpm03hQFPACXlM2a6QA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMNmP73gYgTN2hDVjdfNyrD42JqbczJ5sXNkn5y3GALT/qyV2CfH/8tUEBnlv4SEQVKPiSXrcIxC9+94b3yjDFKxFOcBIob69VyioUCzLQhXLuZzc6PCgfCYiRlN7XFoBrQ9t/9TcDVNs2/iYbKxKMHPMAKEzjlArFNKDgdhcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4628dbxS010337;
	Tue, 2 Jul 2024 16:39:37 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WCx6W55Mjz2K4lJ5;
	Tue,  2 Jul 2024 16:34:43 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 2 Jul 2024
 16:39:36 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Tue, 2 Jul 2024 16:39:36 +0800
From: =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph
 Hellwig" <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMS8yXSBibG9jazogQ2FsbCAubGltaXRfZGVw?=
 =?utf-8?Q?th()_after_.hctx_has_been_set?=
Thread-Topic: [PATCH v2 1/2] block: Call .limit_depth() after .hctx has been
 set
Thread-Index: AQHaojKspCB5D8X03k6mmXGW9i179LHjchNw
Date: Tue, 2 Jul 2024 08:39:35 +0000
Message-ID: <57b38aac30d94bb1a167904db292d1fc@BJMBX02.spreadtrum.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-2-bvanassche@acm.org>
In-Reply-To: <20240509170149.7639-2-bvanassche@acm.org>
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
X-MAIL:SHSQR01.spreadtrum.com 4628dbxS010337

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQmFydCBWYW4gQXNzY2hlIDxi
dmFuYXNzY2hlQGFjbS5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0NeaciDEw5pelIDE6MDIN
CuaUtuS7tuS6ujogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0K5oqE6YCBOiBsaW51eC1i
bG9ja0B2Z2VyLmtlcm5lbC5vcmc7IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgQmFy
dCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+OyBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9h
bEBrZXJuZWwub3JnPjsg54mb5b+X5Zu9IChaaGlndW8gTml1KSA8WmhpZ3VvLk5pdUB1bmlzb2Mu
Y29tPg0K5Li76aKYOiBbUEFUQ0ggdjIgMS8yXSBibG9jazogQ2FsbCAubGltaXRfZGVwdGgoKSBh
ZnRlciAuaGN0eCBoYXMgYmVlbiBzZXQNCg0KDQrms6jmhI86IOi/meWwgemCruS7tuadpeiHquS6
juWklumDqOOAgumZpOmdnuS9oOehruWumumCruS7tuWGheWuueWuieWFqO+8jOWQpuWImeS4jeim
geeCueWHu+S7u+S9lemTvuaOpeWSjOmZhOS7tuOAgg0KQ0FVVElPTjogVGhpcyBlbWFpbCBvcmln
aW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFu
ZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KDQpDYWxsIC5saW1pdF9kZXB0aCgpIGFm
dGVyIGRhdGEtPmhjdHggaGFzIGJlZW4gc2V0IHN1Y2ggdGhhdCBkYXRhLT5oY3R4IGNhbiBiZSB1
c2VkIGluIC5saW1pdF9kZXB0aCgpIGltcGxlbWVudGF0aW9ucy4NCg0KQ2M6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KQ2M6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5v
cmc+DQpDYzogWmhpZ3VvIE5pdSA8emhpZ3VvLm5pdUB1bmlzb2MuY29tPg0KRml4ZXM6IDA3NzU3
NTg4ZTUwNyAoImJsb2NrL21xLWRlYWRsaW5lOiBSZXNlcnZlIDI1JSBvZiBzY2hlZHVsZXIgdGFn
cyBmb3Igc3luY2hyb25vdXMgcmVxdWVzdHMiKQ0KU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNz
Y2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQotLS0NCiBibG9jay9ibGstbXEuYyB8IDEyICsrKysr
Ky0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEuYyBiL2Jsb2NrL2Jsay1tcS5jIGluZGV4IDlm
Njc3ZWE4NWE1Mi4uYTYzMTBhNTUwYjc4IDEwMDY0NA0KLS0tIGEvYmxvY2svYmxrLW1xLmMNCisr
KyBiL2Jsb2NrL2Jsay1tcS5jDQpAQCAtNDQ4LDYgKzQ0OCwxMCBAQCBzdGF0aWMgc3RydWN0IHJl
cXVlc3QgKl9fYmxrX21xX2FsbG9jX3JlcXVlc3RzKHN0cnVjdCBibGtfbXFfYWxsb2NfZGF0YSAq
ZGF0YSkNCiAgICAgICAgaWYgKGRhdGEtPmNtZF9mbGFncyAmIFJFUV9OT1dBSVQpDQogICAgICAg
ICAgICAgICAgZGF0YS0+ZmxhZ3MgfD0gQkxLX01RX1JFUV9OT1dBSVQ7DQoNCityZXRyeToNCisg
ICAgICAgZGF0YS0+Y3R4ID0gYmxrX21xX2dldF9jdHgocSk7DQorICAgICAgIGRhdGEtPmhjdHgg
PSBibGtfbXFfbWFwX3F1ZXVlKHEsIGRhdGEtPmNtZF9mbGFncywgZGF0YS0+Y3R4KTsNCisNCkhp
IEJhcnQsDQpJIHRlc3RlZCBiYXNpYyBmdW5jdGlvbiBhYm91dCB0aGVzZSBzZXJpYWwgcGF0Y2hl
cyBhbmQgcmVzdWx0cyBpcyBwYXNzLCBhbmQgbm8gd2FybmluZyByZXBvcnQgYWZ0ZXIgc2V0dGlu
ZyBhc3luY19kZXB0aCB2YWx1ZSBieSBzeXNmcywgQnV0IHRoZXJlIGlzIGEgbGl0dGxlIHF1ZXN0
aW9uIGhlcmUsIGlmIGRvICJyZXRyeSIsIHRoZSBmb2xsb3dpbmcgaWYgY2FzZSB3aWxsIGJlIHJl
LXJ1biBhbHNvLCBzbyANCklzIHRoZXJlIHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoaXMgb3IgY2Fu
IGl0IGJlIGltcHJvdmVkPyAgT3RoZXJ3aXNlDQpUZXN0ZWQtYnk6IFpoaWd1byBOaXUgPHpoaWd1
by5uaXVAdW5pc29jLmNvbT4NClRoYW5rcyENCiAgICAgICAgaWYgKHEtPmVsZXZhdG9yKSB7DQog
ICAgICAgICAgICAgICAgLyoNCiAgICAgICAgICAgICAgICAgKiBBbGwgcmVxdWVzdHMgdXNlIHNj
aGVkdWxlciB0YWdzIHdoZW4gYW4gSS9PIHNjaGVkdWxlciBpcyBAQCAtNDY5LDEzICs0NzMsOSBA
QCBzdGF0aWMgc3RydWN0IHJlcXVlc3QgKl9fYmxrX21xX2FsbG9jX3JlcXVlc3RzKHN0cnVjdCBi
bGtfbXFfYWxsb2NfZGF0YSAqZGF0YSkNCiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChvcHMt
PmxpbWl0X2RlcHRoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHMtPmxpbWl0
X2RlcHRoKGRhdGEtPmNtZF9mbGFncywgZGF0YSk7DQogICAgICAgICAgICAgICAgfQ0KLSAgICAg
ICB9DQotDQotcmV0cnk6DQotICAgICAgIGRhdGEtPmN0eCA9IGJsa19tcV9nZXRfY3R4KHEpOw0K
LSAgICAgICBkYXRhLT5oY3R4ID0gYmxrX21xX21hcF9xdWV1ZShxLCBkYXRhLT5jbWRfZmxhZ3Ms
IGRhdGEtPmN0eCk7DQotICAgICAgIGlmICghKGRhdGEtPnJxX2ZsYWdzICYgUlFGX1NDSEVEX1RB
R1MpKQ0KKyAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgIGJsa19tcV90YWdfYnVzeShk
YXRhLT5oY3R4KTsNCisgICAgICAgfQ0KDQogICAgICAgIGlmIChkYXRhLT5mbGFncyAmIEJMS19N
UV9SRVFfUkVTRVJWRUQpDQogICAgICAgICAgICAgICAgZGF0YS0+cnFfZmxhZ3MgfD0gUlFGX1JF
U1Y7DQo=
