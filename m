Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC0C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 22:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC289246A2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 22:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1W5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:57:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:35636 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgB1W5k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 17:57:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 14:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="411550688"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2020 14:57:39 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Feb 2020 14:57:38 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.110]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.180]) with mapi id 14.03.0439.000;
 Fri, 28 Feb 2020 14:57:38 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
Subject: Re: [PATCH] block: sed-opal: Change the check condition for regular
 session validity
Thread-Topic: [PATCH] block: sed-opal: Change the check condition for
 regular session validity
Thread-Index: AQHV7oiiZtuPUtDOdEi133Q5Rryor6gxvfuA
Date:   Fri, 28 Feb 2020 22:57:37 +0000
Message-ID: <558ea751133ec0407cd603bae27416042bd1e435.camel@intel.com>
References: <20200228224225.61368-1-revanth.rajashekar@intel.com>
In-Reply-To: <20200228224225.61368-1-revanth.rajashekar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.216]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E67923461B392348AD21259E50EE7A11@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgUmV2YW50aA0KDQpPbiBGcmksIDIwMjAtMDItMjggYXQgMTU6NDIgLTA3MDAsIFJldmFudGgg
UmFqYXNoZWthciB3cm90ZToNCj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBjaGVjayBjb25kaXRp
b24gZm9yIHRoZSB2YWxpZGl0eS9hdXRoZW50aWNhdGlvbg0KPiBvZiB0aGUgc2Vzc2lvbi4NCj4g
DQo+IDEuIFRoZSBIb3N0IFNlc3Npb24gTnVtYmVyKEhTTikgaW4gdGhlIHJlc3BvbnNlIHNob3Vs
ZCBtYXRjaCB0aGUgSFNOIGZvcg0KPiAgICB0aGUgc2Vzc2lvbi4NCj4gMi4gVGhlIFRQRVIgU2Vz
c2lvbiBOdW1iZXIoVFNOKSBjYW4gbmV2ZXIgYmUgbGVzcyB0aGFuIDQwOTYgZm9yIGEgcmVndWxh
cg0KPiAgICBzZXNzaW9uLg0KPiANCj4gUmVmZXJlbmNlOg0KPiBTZWN0aW9uIDMuMi4yLjEgICBv
ZiBodHRwczovL3RydXN0ZWRjb21wdXRpbmdncm91cC5vcmcvd3AtY29udGVudC91cGxvYWRzL1RD
R19TdG9yYWdlX09wYWxfU1NDX0FwcGxpY2F0aW9uX05vdGVfMS0wMF8xLTAwLUZpbmFsLnBkZg0K
PiBTZWN0aW9uIDMuMy43LjEuMSBvZiBodHRwczovL3RydXN0ZWRjb21wdXRpbmdncm91cC5vcmcv
d3AtY29udGVudC91cGxvYWRzL1RDR19TdG9yYWdlX0FyY2hpdGVjdHVyZV9Db3JlX1NwZWNfdjIu
MDFfcjEuMDAucGRmDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IEFuZHJ6ZWogSmFrb3dza2kgPGFu
ZHJ6ZWouamFrb3dza2lAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyemVq
IEpha293c2tpIDxhbmRyemVqLmpha293c2tpQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogUmV2YW50aCBSYWphc2hla2FyIDxyZXZhbnRoLnJhamFzaGVrYXJAaW50ZWwuY29tPg0K
PiAtLS0NCj4gIGJsb2NrL29wYWxfcHJvdG8uaCB8IDEgKw0KPiAgYmxvY2svc2VkLW9wYWwuYyAg
IHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9vcGFsX3Byb3RvLmggYi9ibG9jay9vcGFsX3By
b3RvLmgNCj4gaW5kZXggMzI1Y2JiYTI0NjVmLi4yNzc0MGJhYWQ2MWQgMTAwNjQ0DQo+IC0tLSBh
L2Jsb2NrL29wYWxfcHJvdG8uaA0KPiArKysgYi9ibG9jay9vcGFsX3Byb3RvLmgNCj4gQEAgLTM2
LDYgKzM2LDcgQEAgZW51bSBvcGFsX3Jlc3BvbnNlX3Rva2VuIHsNCj4gDQo+ICAjZGVmaW5lIERU
QUVSUk9SX05PX01FVEhPRF9TVEFUVVMgMHg4OQ0KPiAgI2RlZmluZSBHRU5FUklDX0hPU1RfU0VT
U0lPTl9OVU0gMHg0MQ0KPiArI2RlZmluZSBSU1ZEX1RQRVJfU0VTU0lPTl9OVU0JNDA5Ng0KVGhp
cyBzZWVtcyBjb25mdXNpbmcgYXMgaXQgbG9va3MgbGlrZSA0MDk2IHRoZSBSZXNlcnZlZCBzZXNz
aW9uIHJhdGhlcg0KdGhhbiAwLTQwOTUuDQpDYW4geW91IG5hbWUgaXQgYXBwcm9wcmlhdGVseT8N
Cg0KDQo+IA0KPiAgI2RlZmluZSBUUEVSX1NZTkNfU1VQUE9SVEVEIDB4MDENCj4gICNkZWZpbmUg
TUJSX0VOQUJMRURfTUFTSyAweDEwDQo+IGRpZmYgLS1naXQgYS9ibG9jay9zZWQtb3BhbC5jIGIv
YmxvY2svc2VkLW9wYWwuYw0KPiBpbmRleCA4ODBjYzU3YTVmNmIuLmYyYjYxYTg2ODkwMSAxMDA2
NDQNCj4gLS0tIGEvYmxvY2svc2VkLW9wYWwuYw0KPiArKysgYi9ibG9jay9zZWQtb3BhbC5jDQo+
IEBAIC0xMDU2LDcgKzEwNTYsNyBAQCBzdGF0aWMgaW50IHN0YXJ0X29wYWxfc2Vzc2lvbl9jb250
KHN0cnVjdCBvcGFsX2RldiAqZGV2KQ0KPiAgCWhzbiA9IHJlc3BvbnNlX2dldF91NjQoJmRldi0+
cGFyc2VkLCA0KTsNCj4gIAl0c24gPSByZXNwb25zZV9nZXRfdTY0KCZkZXYtPnBhcnNlZCwgNSk7
DQo+IA0KPiAtCWlmIChoc24gPT0gMCAmJiB0c24gPT0gMCkgew0KPiArCWlmIChoc24gIT0gR0VO
RVJJQ19IT1NUX1NFU1NJT05fTlVNIHx8IHRzbiA8IFJTVkRfVFBFUl9TRVNTSU9OX05VTSkgew0K
PiAgCQlwcl9kZWJ1ZygiQ291bGRuJ3QgYXV0aGVudGljYXRlIHNlc3Npb25cbiIpOw0KPiAgCQly
ZXR1cm4gLUVQRVJNOw0KPiAgCX0NCj4gLS0NCj4gMi4xNy4xDQo+IA0K
