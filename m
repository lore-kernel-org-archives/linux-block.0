Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA6EDE;
	Thu, 14 Mar 2024 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710378237; cv=none; b=n0PFK35JkxltLwSmHS8nsNpo/ruziSVvVAhfg/2Kg3o10Kf5E2/svOIALd0DyT+nbAnGWlA+Q01Er8jHzO4isr5MGDzSWeAZZQEtm2q5EyGaWaDH1UQ7TaEn+SEAqKFVQgx0IQZB3uVKqYbJFNAJNPpUwfPqf9P1zzysA/kKE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710378237; c=relaxed/simple;
	bh=bf/vjg/qaqi/ER/iveqlpt38o7vUIGhHSU47DZ/UJaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HiD1ulcOiHovi9JhBcy1yy1w+AQdW2os1BfNEzpczAaEcAHn1oNvkU3gpDFx72KBNrUGhpo6nbmljprnu6Fsf8BwQ8lBQIXEVsq88mKyY3MUBJhuORmpXy0UxmgQe4uDID2OQN3Bxd2vgR8S7g88cHdp8wDKJT9E/c+pHZRzc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42E13LGj084497;
	Thu, 14 Mar 2024 09:03:21 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tw8Gz2zcXz2L1Lpm;
	Thu, 14 Mar 2024 09:02:03 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 14 Mar
 2024 09:03:18 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Thu, 14 Mar 2024 09:03:18 +0800
From: =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph
 Hellwig" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Harshit Mogalapalli
	<harshit.m.mogalapalli@oracle.com>,
        =?utf-8?B?6YeR57qi5a6HIChIb25neXUgSmluKQ==?= <hongyu.jin@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFJldmVydCAiYmxvY2svbXEtZGVhZGxpbmU6IHVz?=
 =?utf-8?Q?e_correct_way_to_throttling_write_requests"?=
Thread-Topic: [PATCH] Revert "block/mq-deadline: use correct way to throttling
 write requests"
Thread-Index: AQHadY9udLecnqbSDUSAXigHuLhvL7E2aiUA
Date: Thu, 14 Mar 2024 01:03:17 +0000
Message-ID: <cf8127b0fa594169a71f3257326e5bec@BJMBX02.spreadtrum.com>
References: <20240313214218.1736147-1-bvanassche@acm.org>
In-Reply-To: <20240313214218.1736147-1-bvanassche@acm.org>
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
X-MAIL:SHSQR01.spreadtrum.com 42E13LGj084497

SGkgQmFydCwNCg0KSnVzdCBhcyBtZW50aW9uZWQgaW4gb3JpZ2luYWwgcGF0Y2gsICJkZC0+YXN5
bmNfZGVwdGggPSBtYXgoMVVMLCAzICogcS0+bnJfcmVxdWVzdHMgLyA0KTsiLCB0aGlzIGxpbWl0
YXRpb24gbWV0aG9kcyBsb29rIGxpa2VzIHdvbid0IGhhdmUgYSBsaW1pdCBlZmZlY3QsIGJlY2F1
c2UgdGFnIGFsbG9jYXRlZCBpcyBiYXNlZCBvbiBzYml0bWFwLCBub3QgYmFzZWQgdGhlIHdob2xl
IG5yX3JlcXVlc3RzLg0KUmlnaHQ/DQpUaGFua3MhDQoNCkZvciB3cml0ZSByZXF1ZXN0cywgd2hl
biB3ZSBhc3NpZ24gYSB0YWdzIGZyb20gc2NoZWRfdGFncywNCmRhdGEtPnNoYWxsb3dfZGVwdGgg
d2lsbCBiZSBwYXNzZWQgdG8gc2JpdG1hcF9maW5kX2JpdCwNCnNlZSB0aGUgZm9sbG93aW5nIGNv
ZGU6DQoNCm5yID0gc2JpdG1hcF9maW5kX2JpdF9pbl93b3JkKCZzYi0+bWFwW2luZGV4XSwNCgkJ
CW1pbl90ICh1bnNpZ25lZCBpbnQsDQoJCQlfX21hcF9kZXB0aChzYiwgaW5kZXgpLA0KCQkJZGVw
dGgpLA0KCQkJYWxsb2NfaGludCwgd3JhcCk7DQoNClRoZSBzbWFsbGVyIG9mIGRhdGEtPnNoYWxs
b3dfZGVwdGggYW5kIF9fbWFwX2RlcHRoKHNiLCBpbmRleCkNCndpbGwgYmUgdXNlZCBhcyB0aGUg
bWF4aW11bSByYW5nZSB3aGVuIGFsbG9jYXRpbmcgYml0cy4NCg0KRm9yIGEgbW1jIGRldmljZSAo
b25lIGh3IHF1ZXVlLCBkZWFkbGluZSBJL08gc2NoZWR1bGVyKToNCnEtPm5yX3JlcXVlc3RzID0g
c2NoZWRfdGFncyA9IDEyOCwgc28gYWNjb3JkaW5nIHRvIHRoZSBwcmV2aW91cw0KY2FsY3VsYXRp
b24gbWV0aG9kLCBkZC0+YXN5bmNfZGVwdGggPSBkYXRhLT5zaGFsbG93X2RlcHRoID0gOTYsDQph
bmQgdGhlIHBsYXRmb3JtIGlzIDY0Yml0cyB3aXRoIDggY3B1cywgc2NoZWRfdGFncy5iaXRtYXBf
dGFncy5zYi5zaGlmdD01LA0Kc2IubWFwc1tdPTMyLzMyLzMyLzMyLCAzMiBpcyBzbWFsbGVyIHRo
YW4gOTYsIHdoZXRoZXIgaXQgaXMgYSByZWFkIG9yDQphIHdyaXRlIEkvTywgdGFncyBjYW4gYmUg
YWxsb2NhdGVkIHRvIHRoZSBtYXhpbXVtIHJhbmdlIGVhY2ggdGltZSwNCndoaWNoIGhhcyBub3Qg
dGhyb3R0bGluZyBlZmZlY3QuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujog
QmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI0
5bm0M+aciDE05pelIDU6NDINCuaUtuS7tuS6ujogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRr
Pg0K5oqE6YCBOiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPjsgQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+OyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnOyBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPjsg
SGFyc2hpdCBNb2dhbGFwYWxsaSA8aGFyc2hpdC5tLm1vZ2FsYXBhbGxpQG9yYWNsZS5jb20+OyDn
iZvlv5flm70gKFpoaWd1byBOaXUpIDxaaGlndW8uTml1QHVuaXNvYy5jb20+DQrkuLvpopg6IFtQ
QVRDSF0gUmV2ZXJ0ICJibG9jay9tcS1kZWFkbGluZTogdXNlIGNvcnJlY3Qgd2F5IHRvIHRocm90
dGxpbmcgd3JpdGUgcmVxdWVzdHMiDQoNCg0K5rOo5oSPOiDov5nlsIHpgq7ku7bmnaXoh6rkuo7l
pJbpg6jjgILpmaTpnZ7kvaDnoa7lrprpgq7ku7blhoXlrrnlronlhajvvIzlkKbliJnkuI3opoHn
grnlh7vku7vkvZXpk77mjqXlkozpmYTku7bjgIINCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQg
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KVGhlIGNvZGUgIm1heCgxVSwgMyAqICgx
VSA8PCBzaGlmdCkgIC8gNCkiIGNvbWVzIGZyb20gdGhlIEt5YmVyIEkvTyBzY2hlZHVsZXIuIFRo
ZSBLeWJlciBJL08gc2NoZWR1bGVyIG1haW50YWlucyBvbmUgaW50ZXJuYWwgcXVldWUgcGVyIGh3
cSBhbmQgaGVuY2UgZGVyaXZlcyBpdHMgYXN5bmNfZGVwdGggZnJvbSB0aGUgbnVtYmVyIG9mIGh3
cSB0YWdzLiBVc2luZyB0aGlzIGFwcHJvYWNoIGZvciB0aGUgbXEtZGVhZGxpbmUgc2NoZWR1bGVy
IGlzIHdyb25nIHNpbmNlIHRoZSBtcS1kZWFkbGluZSBzY2hlZHVsZXIgbWFpbnRhaW5zIG9uZSBp
bnRlcm5hbCBxdWV1ZSBmb3IgYWxsIGh3cXMgY29tYmluZWQuIEhlbmNlIHRoaXMgcmV2ZXJ0Lg0K
DQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KQ2M6IERhbWllbiBMZSBNb2FsIDxkbGVtb2Fs
QGtlcm5lbC5vcmc+DQpDYzogSGFyc2hpdCBNb2dhbGFwYWxsaSA8aGFyc2hpdC5tLm1vZ2FsYXBh
bGxpQG9yYWNsZS5jb20+DQpDYzogWmhpZ3VvIE5pdSA8WmhpZ3VvLk5pdUB1bmlzb2MuY29tPg0K
Rml4ZXM6IGQ0N2Y5NzE3ZTVjZiAoImJsb2NrL21xLWRlYWRsaW5lOiB1c2UgY29ycmVjdCB3YXkg
dG8gdGhyb3R0bGluZyB3cml0ZSByZXF1ZXN0cyIpDQpTaWduZWQtb2ZmLWJ5OiBCYXJ0IFZhbiBB
c3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCi0tLQ0KIGJsb2NrL21xLWRlYWRsaW5lLmMgfCAz
ICstLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2Jsb2NrL21xLWRlYWRsaW5lLmMgYi9ibG9jay9tcS1kZWFkbGluZS5jIGlu
ZGV4IGY5NThlNzkyNzdiOC4uMDJhOTE2YmE2MmVlIDEwMDY0NA0KLS0tIGEvYmxvY2svbXEtZGVh
ZGxpbmUuYw0KKysrIGIvYmxvY2svbXEtZGVhZGxpbmUuYw0KQEAgLTY0Niw5ICs2NDYsOCBAQCBz
dGF0aWMgdm9pZCBkZF9kZXB0aF91cGRhdGVkKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQ0K
ICAgICAgICBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGhjdHgtPnF1ZXVlOw0KICAgICAgICBz
dHJ1Y3QgZGVhZGxpbmVfZGF0YSAqZGQgPSBxLT5lbGV2YXRvci0+ZWxldmF0b3JfZGF0YTsNCiAg
ICAgICAgc3RydWN0IGJsa19tcV90YWdzICp0YWdzID0gaGN0eC0+c2NoZWRfdGFnczsNCi0gICAg
ICAgdW5zaWduZWQgaW50IHNoaWZ0ID0gdGFncy0+Yml0bWFwX3RhZ3Muc2Iuc2hpZnQ7DQoNCi0g
ICAgICAgZGQtPmFzeW5jX2RlcHRoID0gbWF4KDFVLCAzICogKDFVIDw8IHNoaWZ0KSAgLyA0KTsN
CisgICAgICAgZGQtPmFzeW5jX2RlcHRoID0gbWF4KDFVTCwgMyAqIHEtPm5yX3JlcXVlc3RzIC8g
NCk7DQoNCiAgICAgICAgc2JpdG1hcF9xdWV1ZV9taW5fc2hhbGxvd19kZXB0aCgmdGFncy0+Yml0
bWFwX3RhZ3MsIGRkLT5hc3luY19kZXB0aCk7ICB9DQo=
