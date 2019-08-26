Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895BAC3A59F
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 19:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584D523427
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 19:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfHZT1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:27:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:39480 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbfHZT1l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 15:27:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 12:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="187692582"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2019 12:27:40 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 26 Aug 2019 12:27:39 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.103]) with mapi id 14.03.0439.000;
 Mon, 26 Aug 2019 12:27:39 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>
CC:     "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block: sed-opal: Add support to read/write opal
 tables generically
Thread-Topic: [PATCH 3/3] block: sed-opal: Add support to read/write opal
 tables generically
Thread-Index: AQHVWFPv9reGpILH7UiRlHLlRaEEMKcMxn4AgAGG1gA=
Date:   Mon, 26 Aug 2019 19:27:38 +0000
Message-ID: <c48b10f43cd6b5cf859ea1376b32604ac0ff7113.camel@intel.com>
References: <20190821191051.3535-1-revanth.rajashekar@intel.com>
         <20190821191051.3535-4-revanth.rajashekar@intel.com>
         <20190825200846.GA30738@hacktheplanet>
In-Reply-To: <20190825200846.GA30738@hacktheplanet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4DB83793D430E428819D93C662AA702@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gU3VuLCAyMDE5LTA4LTI1IGF0IDE2OjA4IC0wNDAwLCBTY290dCBCYXVlciB3cm90ZToNCj4g
T24gV2VkLCBBdWcgMjEsIDIwMTkgYXQgMDE6MTA6NTFQTSAtMDYwMCwgUmV2YW50aCBSYWphc2hl
a2FyIHdyb3RlOg0KPiANCj4gW3NuaXBdDQo+IA0KPiA+IFRoZSBpb2N0bCBwcm92aWRlcyBhIHBy
aXZhdGUgZmllbGQgd2l0aCB0aGUgaW50ZW50aW9udCB0byBhY2NvbW1vZGF0ZQ0KPiA+IGFueSBm
dXR1cmUgZXhwYW5zaW9ucyB0byB0aGUgaW9jdGwuDQo+IA0KPiBzcGVsbGluZyAoaW50ZW50aW9u
dCkgDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKyAqIElPX0JVRkZFUl9MRU5HVEggPSAyMDQ4DQo+
ID4gKyAqIHNpemVvZihoZWFkZXIpID0gNTYNCj4gPiArICogTm8uIG9mIFRva2VuIEJ5dGVzIGlu
IHRoZSBSZXNwb25zZSA9IDExDQo+ID4gKyAqIE1BWCBzaXplIG9mIGRhdGEgdGhhdCBjYW4gYmUg
Y2FycmllZCBpbiByZXNwb25zZSBidWZmZXINCj4gPiArICogYXQgYSB0aW1lIGlzIDogMjA0OCAt
ICg1NiArIDExKSA9IDE5ODEgPSAweDdCRC4NCj4gPiArICovDQo+ID4gKyNkZWZpbmUgT1BBTF9N
QVhfUkVBRF9UQUJMRSAoMHg3QkQpDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJlYWRfdGFibGVf
ZGF0YShzdHJ1Y3Qgb3BhbF9kZXYgKmRldiwgdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsJCWRz
dCA9ICh1OCBfX3VzZXIgKikodWludHB0cl90KXJlYWRfdGJsLT5kYXRhOw0KPiA+ICsJCWlmIChj
b3B5X3RvX3VzZXIoZHN0ICsgb2ZmLCBkZXYtPnByZXZfZGF0YSwgZGV2LT5wcmV2X2RfbGVuKSkg
ew0KPiA+ICsJCQlwcl9kZWJ1ZygiRXJyb3IgY29weWluZyBkYXRhIHRvIHVzZXJzcGFjZVxuIik7
DQo+ID4gKwkJCWVyciA9IC1FRkFVTFQ7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0NCj4gDQo+
IEknbSB3aXRoIEpvbiBvbiB0aGlzIG9uZS4gRXZlbiB0aG91Z2ggdGhlIHNwZWMgc2F5cyB3ZSBo
YXZlIGEgbWF4IHNpemUsIGxldHMgbm90IHB1dCBvdXIgdHJ1c3QgaW4gZmlybXdhcmUgZW5naW5l
ZXJzLg0KPiBBIHNpbXBsZSBpZiBjaGVjayBpcyBlYXN5IHRvIHBsYWNlIGJlZm9yZSB0aGUgQ1RV
IGFuZCB3aWxsIHNvbHZlIGFueSBmdXR1cmUgd3RmIGRlYnVnZ2luZyBvbiBhIHVzZXJsYW5kIHBy
b2dyYW0uDQo+IA0KPiANCkkgdGhpbmsgd2UgY291bGQgZG8gdGhhdCBhcyB3ZWxsIGFzIHNwZWNp
ZnkgdGhlDQpNYXhSZXNwb25zZUNvbVBhY2tldFNpemU9SU9fQlVGRkVSX0xFTkdUSCBpbiB0aGUg
Y29tbWFuZA0KaHR0cHM6Ly90cnVzdGVkY29tcHV0aW5nZ3JvdXAub3JnL3dwLWNvbnRlbnQvdXBs
b2Fkcy9UQ0dfU3RvcmFnZV9PcGFsX1NTQ19BcHBsaWNhdGlvbl9Ob3RlXzEtMDBfMS0wMC1GaW5h
bC5wZGYNCjMuMi4xLjIuMSBIb3N0IHRvIFRQZXIgUHJvcGVydGllcyBpbnZvY2F0aW9uDQoNCj4g
DQo+IA0KPiANCj4gPiArc3RhdGljIGludCBvcGFsX2dlbmVyaWNfcmVhZF93cml0ZV90YWJsZShz
dHJ1Y3Qgb3BhbF9kZXYgKmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3Qgb3BhbF9yZWFkX3dyaXRlX3RhYmxlICpyd190YmwpDQo+ID4gK3sN
Cj4gPiArCWNvbnN0IHN0cnVjdCBvcGFsX3N0ZXAgd3JpdGVfdGFibGVfc3RlcHNbXSA9IHsNCj4g
PiArCQl7IHN0YXJ0X2FkbWluMUxTUF9vcGFsX3Nlc3Npb24sICZyd190YmwtPmtleSB9LA0KPiA+
ICsJCXsgd3JpdGVfdGFibGVfZGF0YSwgcndfdGJsIH0sDQo+ID4gKwkJeyBlbmRfb3BhbF9zZXNz
aW9uLCB9DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCWNvbnN0IHN0cnVjdCBvcGFsX3N0ZXAgcmVh
ZF90YWJsZV9zdGVwc1tdID0gew0KPiA+ICsJCXsgc3RhcnRfYWRtaW4xTFNQX29wYWxfc2Vzc2lv
biwgJnJ3X3RibC0+a2V5IH0sDQo+ID4gKwkJeyByZWFkX3RhYmxlX2RhdGEsIHJ3X3RibCB9LA0K
PiA+ICsJCXsgZW5kX29wYWxfc2Vzc2lvbiwgfQ0KPiA+ICsJfTsNCj4gPiArCWludCByZXQgPSAw
Ow0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJmRldi0+ZGV2X2xvY2spOw0KPiA+ICsJc2V0dXBf
b3BhbF9kZXYoZGV2KTsNCj4gPiArCWlmIChyd190YmwtPmZsYWdzICYgT1BBTF9UQUJMRV9SRUFE
KSB7DQo+ID4gKwkJaWYgKHJ3X3RibC0+c2l6ZSA+IDApDQo+ID4gKwkJCXJldCA9IGV4ZWN1dGVf
c3RlcHMoZGV2LCByZWFkX3RhYmxlX3N0ZXBzLA0KPiA+ICsJCQkJCSAgICBBUlJBWV9TSVpFKHJl
YWRfdGFibGVfc3RlcHMpKTsNCj4gPiArCX0gZWxzZSBpZiAocndfdGJsLT5mbGFncyAmIE9QQUxf
VEFCTEVfV1JJVEUpIHsNCj4gPiArCQlpZiAocndfdGJsLT5zaXplID4gMCkNCj4gPiArCQkJcmV0
ID0gZXhlY3V0ZV9zdGVwcyhkZXYsIHdyaXRlX3RhYmxlX3N0ZXBzLA0KPiA+ICsJCQkJCSAgICBB
UlJBWV9TSVpFKHdyaXRlX3RhYmxlX3N0ZXBzKSk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXBy
X2RlYnVnKCJJbnZhbGlkIGJpdCBzZXQgaW4gdGhlIGZsYWcuXG4iKTsNCj4gPiArCQlyZXQgPSAt
RUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZkZXYtPmRldl9sb2NrKTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiBEbyB3ZSBleHBlY3QgdG8gYWRk
IG1vcmUgZmxhZ3MgaW4gdGhlIGZ1dHVyZT8gSSBhc2sgYmVjYXVzZSB0aGlzIGZ1bmN0aW9uIGNh
biBxdWlja2x5IGdldCBvdXQNCj4gb2YgaGFuZCB3aXRoIHJlZ2FyZCB0byB0aGUgZWxzZSBpZiBj
aGFpbiBhbmQgdGhlIGZ1bmN0aW9uIHRhYmxlIGxpc3QgYWJvdmUuIElmIHdlIHRoaW5rIHdlJ3Jl
IGdvaW5nDQo+IHRvIGFkZCBtb3JlIGZsYWdzIGluIHRoZSBmdXR1cmUgbGV0cyBzbGFwIGEgc3dp
dGNoIHN0YXRlbWVudCBpbiBoZXJlIHRvIGNhbGwgb3BhbF90YWJsZV93cml0ZSgpIGFuZA0KPiBv
cGFsX3RhYmxlX3JlYWQoKS4gV2UgY2FuIGRlYWwgd2l0aCB0aGF0IGluIHRoZSBmdXR1cmUgSSBn
dWVzcywgSSBqdXN0IGRvbid0IHdhbnQgYSAzMDAwIGxpbmUgZnVuY3Rpb24uDQo+IA0KPiANCkkg
aGFkIGltYWdpbmVkIHBvdGVudGlhbGx5IGNoYWluaW5nIEFDUyBzZXR0aW5ncyBpbiB0aGUgcmVh
ZC93cml0ZQ0KDQpZb3UgY291bGQgYWRkIGEgZmxhZyB0aGF0IHNheXMgJ3ByaXZhdGUnIGlzIGFu
b3RoZXIgb3IgbXVsdGlwbGUgdGFibGUNCnJlYWQvd3JpdGVzLCBhbmQgdGhlIHByaXZhdGUgcG9p
bnRzIHRvIGEgZGVzY3JpcHRvciBlcXVhbCB0byB0aGUgaW9jdGwNCnN0cnVjdC4NCg0KSSdtIG9r
IHdpdGggY2hhbmdpbmcgaWYvZWxzZSB0byBzd2l0Y2guIFdoaWNoZXZlciBsb29rcyBiZXR0ZXIu
DQoNCg0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9zZWQtb3Bh
bC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3NlZC1vcGFsLmgNCj4gPiBpbmRleCA1OWVlZDBiZGZm
ZDMuLmE4MDNlZDA1MzRkYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvc2Vk
LW9wYWwuaA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9zZWQtb3BhbC5oDQo+ID4gK3N0
cnVjdCBvcGFsX3JlYWRfd3JpdGVfdGFibGUgew0KPiA+ICsJc3RydWN0IG9wYWxfa2V5IGtleTsN
Cj4gPiArCWNvbnN0IF9fdTY0IGRhdGE7DQo+ID4gKwljb25zdCBfX3U4IHRhYmxlX3VpZFtPUEFM
X1VJRF9MRU5HVEhdOw0KPiA+ICsJX191NjQgb2Zmc2V0Ow0KPiA+ICsJX191NjQgc2l6ZTsNCj4g
PiArCSNkZWZpbmUgT1BBTF9UQUJMRV9SRUFEICgxIDw8IDApDQo+ID4gKwkjZGVmaW5lIE9QQUxf
VEFCTEVfV1JJVEUgKDEgPDwgMSkNCj4gPiArCV9fdTY0IGZsYWdzOw0KPiA+ICsJX191NjQgcHJp
djsNCj4gPiArfTsNCj4gDQo+IFR3byB0aGluZ3MsIGNhbiB5b3UgZG91YmxlIGNoZWNrIHRoZSBw
YWhvbGUgb24gdGhpcyBzdHJ1Y3QgKEdvb2dsZSBpdCBvciBhc2sgSm9uIGhlIGtub3dzKS4NCkkn
bGwgbWFrZSBzdXJlIHdlIGRvbid0IGJyZWFrIHBhZGRpbmcgYW5kIGFsaWdubWVudCBmb3IgdjIN
Cg0KPiBTZWNvbmQsIGNhbiB5b3UgbGlmdCB0aG9zZSBkZWZpbmVzIGludG8gRW51bWVyYXRpb25z
IG9yIG91dCBvZiB0aGUgc3RydWN0PyBJcyB0aGVyZSBhIHJlYXNvbg0KPiB0aGV5J3JlIGluIHRo
ZXJlPw0KSnVzdCBzZWVtcyB0byBiZSBjb21tb24gY29kaW5nIHN0eWxlIGZvciBmbGFncywgZXgg
ZmQuaA0KDQo+IA0K
