Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BEBC432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B502186D
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 16:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfKRQrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:47:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:35933 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfKRQru (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 11:47:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 08:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="196185270"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2019 08:47:50 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.52]) with mapi id 14.03.0439.000;
 Mon, 18 Nov 2019 08:47:49 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>
Subject: Re: [PATCH] block: sed-opal: Introduce SUM_SET_LIST parameter and
 append it using 'add_token_u64'
Thread-Topic: [PATCH] block: sed-opal: Introduce SUM_SET_LIST parameter and
 append it using 'add_token_u64'
Thread-Index: AQHVlomhnY96T2uKoEqQnoL5mXDAqaeLZjCAgAAUmoCABj4EAA==
Date:   Mon, 18 Nov 2019 16:47:48 +0000
Message-ID: <0799d4b77fc58ff0be7d403648e25a99a5077bdb.camel@intel.com>
References: <20191108230904.7932-1-revanth.rajashekar@intel.com>
         <e1bd6f75-b352-1ff8-af73-1ed9de04cff5@intel.com>
         <63cfa17b-28df-ac52-30ac-d5d6bd93a116@kernel.dk>
In-Reply-To: <63cfa17b-28df-ac52-30ac-d5d6bd93a116@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.143]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D5B0DBC53CB854A9D4120AFD27337C9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTE0IGF0IDEwOjI4IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxMS8xNC8xOSA5OjE0IEFNLCBSYWphc2hla2FyLCBSZXZhbnRoIHdyb3RlOg0KPiA+IEhpLA0K
PiA+IA0KPiA+IE9uIDExLzgvMjAxOSA0OjA5IFBNLCBSZXZhbnRoIFJhamFzaGVrYXIgd3JvdGU6
DQo+ID4gPiBJbiBmdW5jdGlvbiAnYWN0aXZhdGVfbHNwJywgcmF0aGVyIHRoYW4gaGFyZC1jb2Rp
bmcgdGhlDQo+ID4gPiBzaG9ydCBhdG9tIGhlYWRlcigweDgzKSwgd2UgbmVlZCB0byBsZXQgdGhl
IGZ1bmN0aW9uDQo+ID4gPiAnYWRkX3Nob3J0X2F0b21faGVhZGVyJyBhcHBlbmQgdGhlIGhlYWRl
ciBiYXNlZCBvbiB0aGUNCj4gPiA+IHBhcmFtZXRlciBiZWluZyBhcHBlbmRlZC4NCj4gPiA+IA0K
PiA+ID4gVGhlIHBhcmFtZXRlIGhhcyBiZWVuIGRlZmluZWQgaW4gU2VjdGlvbiAzLjEuMi4xIG9m
DQo+ID4gPiBodHRwczovL3RydXN0ZWRjb21wdXRpbmdncm91cC5vcmcvd3AtY29udGVudC91cGxv
YWRzL1RDR19TdG9yYWdlLU9wYWxfRmVhdHVyZV9TZXRfU2luZ2xlX1VzZXJfTW9kZV92MS0wMF9y
MS0wMC1GaW5hbC5wZGYNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmV2YW50aCBSYWph
c2hla2FyIDxyZXZhbnRoLnJhamFzaGVrYXJAaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAg
IGJsb2NrL29wYWxfcHJvdG8uaCB8IDQgKysrKw0KPiA+ID4gICBibG9jay9zZWQtb3BhbC5jICAg
fCA2ICstLS0tLQ0KPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL29wYWxfcHJvdG8u
aCBiL2Jsb2NrL29wYWxfcHJvdG8uaA0KPiA+ID4gaW5kZXggNzM2ZTY3YzNlN2M1Li4zMjVjYmJh
MjQ2NWYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9ibG9jay9vcGFsX3Byb3RvLmgNCj4gPiA+ICsrKyBi
L2Jsb2NrL29wYWxfcHJvdG8uaA0KPiA+ID4gQEAgLTIwNSw2ICsyMDUsMTAgQEAgZW51bSBvcGFs
X2xvY2tpbmdzdGF0ZSB7DQo+ID4gPiAgIAlPUEFMX0xPQ0tJTkdfTE9DS0VEID0gMHgwMywNCj4g
PiA+ICAgfTsNCj4gPiA+ICAgDQo+ID4gPiArZW51bSBvcGFsX3BhcmFtZXRlciB7DQo+ID4gPiAr
CU9QQUxfU1VNX1NFVF9MSVNUID0gMHgwNjAwMDAsDQo+ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+
ICAgLyogUGFja2V0cyBkZXJpdmVkIGZyb206DQo+ID4gPiAgICAqIFRDR19TdG9yYWdlX0FyY2hp
dGVjdHVyZV9Db3JlX1NwZWNfdjIuMDFfcjEuMDANCj4gPiA+ICAgICogU2VjaW9uOiAzLjIuMyBD
b21QYWNrZXRzLCBQYWNrZXRzICYgU3VicGFja2V0cw0KPiA+ID4gZGlmZiAtLWdpdCBhL2Jsb2Nr
L3NlZC1vcGFsLmMgYi9ibG9jay9zZWQtb3BhbC5jDQo+ID4gPiBpbmRleCBiMmNhY2M5ZGRkMTEu
Ljg4MGNjNTdhNWY2YiAxMDA2NDQNCj4gPiA+IC0tLSBhL2Jsb2NrL3NlZC1vcGFsLmMNCj4gPiA+
ICsrKyBiL2Jsb2NrL3NlZC1vcGFsLmMNCj4gPiA+IEBAIC0xODg2LDcgKzE4ODYsNiBAQCBzdGF0
aWMgaW50IGFjdGl2YXRlX2xzcChzdHJ1Y3Qgb3BhbF9kZXYgKmRldiwgdm9pZCAqZGF0YSkNCj4g
PiA+ICAgew0KPiA+ID4gICAJc3RydWN0IG9wYWxfbHJfYWN0ICpvcGFsX2FjdCA9IGRhdGE7DQo+
ID4gPiAgIAl1OCB1c2VyX2xyW09QQUxfVUlEX0xFTkdUSF07DQo+ID4gPiAtCXU4IHVpbnRfMyA9
IDB4ODM7DQo+ID4gPiAgIAlpbnQgZXJyLCBpOw0KPiA+ID4gICANCj4gPiA+ICAgCWVyciA9IGNt
ZF9zdGFydChkZXYsIG9wYWx1aWRbT1BBTF9MT0NLSU5HU1BfVUlEXSwNCj4gPiA+IEBAIC0xODk5
LDEwICsxODk4LDcgQEAgc3RhdGljIGludCBhY3RpdmF0ZV9sc3Aoc3RydWN0IG9wYWxfZGV2ICpk
ZXYsIHZvaWQgKmRhdGEpDQo+ID4gPiAgIAkJCXJldHVybiBlcnI7DQo+ID4gPiAgIA0KPiA+ID4g
ICAJCWFkZF90b2tlbl91OCgmZXJyLCBkZXYsIE9QQUxfU1RBUlROQU1FKTsNCj4gPiA+IC0JCWFk
ZF90b2tlbl91OCgmZXJyLCBkZXYsIHVpbnRfMyk7DQo+ID4gPiAtCQlhZGRfdG9rZW5fdTgoJmVy
ciwgZGV2LCA2KTsNCj4gPiA+IC0JCWFkZF90b2tlbl91OCgmZXJyLCBkZXYsIDApOw0KPiA+ID4g
LQkJYWRkX3Rva2VuX3U4KCZlcnIsIGRldiwgMCk7DQo+ID4gPiArCQlhZGRfdG9rZW5fdTY0KCZl
cnIsIGRldiwgT1BBTF9TVU1fU0VUX0xJU1QpOw0KPiA+ID4gICANCj4gPiA+ICAgCQlhZGRfdG9r
ZW5fdTgoJmVyciwgZGV2LCBPUEFMX1NUQVJUTElTVCk7DQo+ID4gPiAgIAkJYWRkX3Rva2VuX2J5
dGVzdHJpbmcoJmVyciwgZGV2LCB1c2VyX2xyLCBPUEFMX1VJRF9MRU5HVEgpOw0KPiA+IA0KPiA+
IEtpbmQgcmVtYWluZGVyIHRvIHJldmlldyB0aGlzIHBhdGNoIGFuZCB0aHJvdyB5b3VyIGNvbW1l
bnRzIGlmIGFueSA6KQ0KPiANCj4gSSdsbCBiZSBoYXBweSB0byBxdWV1ZSBpdCB1cCBmb3IgNS41
LCBidXQgU2NvdHQvSm9uYXRoYW4gc2hvdWxkDQo+IHJldmlldy9hY2sgaXQgZmlyc3QuDQo+IA0K
DQpMb29rcyBsaWtlIGl0IHNob3VsZCB3b3JrIHRoZSBzYW1lDQpSZXZpZXdlZC1ieTogSm9uIERl
cnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0K
