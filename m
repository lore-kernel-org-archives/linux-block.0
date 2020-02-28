Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEEC3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965B7246AF
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 23:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1XHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:07:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:2826 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB1XHF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 18:07:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 15:07:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="437582342"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2020 15:07:03 -0800
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Feb 2020 15:07:03 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.110]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.66]) with mapi id 14.03.0439.000;
 Fri, 28 Feb 2020 15:07:03 -0800
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
Thread-Index: AQHV7oiiZtuPUtDOdEi133Q5Rryor6gxvfuAgAABOYCAAAFpAA==
Date:   Fri, 28 Feb 2020 23:07:03 +0000
Message-ID: <2143472fa237e9c636143e4ae6aa2a989fa8984b.camel@intel.com>
References: <20200228224225.61368-1-revanth.rajashekar@intel.com>
         <558ea751133ec0407cd603bae27416042bd1e435.camel@intel.com>
         <68f27a5e-a39b-3c3e-dbb3-ce0c6b56f33c@intel.com>
In-Reply-To: <68f27a5e-a39b-3c3e-dbb3-ce0c6b56f33c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.216]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B09CEAD6F786664BA35C7F80F6E66B64@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTI4IGF0IDE2OjAxIC0wNzAwLCBSYWphc2hla2FyLCBSZXZhbnRoIHdy
b3RlOg0KPiBIaSBKb24sDQo+IA0KPiBPbiAyLzI4LzIwMjAgMzo1NyBQTSwgRGVycmljaywgSm9u
YXRoYW4gd3JvdGU6DQo+ID4gSGkgUmV2YW50aA0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMC0wMi0y
OCBhdCAxNTo0MiAtMDcwMCwgUmV2YW50aCBSYWphc2hla2FyIHdyb3RlOg0KPiA+ID4gVGhpcyBw
YXRjaCBjaGFuZ2VzIHRoZSBjaGVjayBjb25kaXRpb24gZm9yIHRoZSB2YWxpZGl0eS9hdXRoZW50
aWNhdGlvbg0KPiA+ID4gb2YgdGhlIHNlc3Npb24uDQo+ID4gPiANCj4gPiA+IDEuIFRoZSBIb3N0
IFNlc3Npb24gTnVtYmVyKEhTTikgaW4gdGhlIHJlc3BvbnNlIHNob3VsZCBtYXRjaCB0aGUgSFNO
IGZvcg0KPiA+ID4gICAgdGhlIHNlc3Npb24uDQo+ID4gPiAyLiBUaGUgVFBFUiBTZXNzaW9uIE51
bWJlcihUU04pIGNhbiBuZXZlciBiZSBsZXNzIHRoYW4gNDA5NiBmb3IgYSByZWd1bGFyDQo+ID4g
PiAgICBzZXNzaW9uLg0KPiA+ID4gDQo+ID4gPiBSZWZlcmVuY2U6DQo+ID4gPiBTZWN0aW9uIDMu
Mi4yLjEgICBvZiBodHRwczovL3RydXN0ZWRjb21wdXRpbmdncm91cC5vcmcvd3AtY29udGVudC91
cGxvYWRzL1RDR19TdG9yYWdlX09wYWxfU1NDX0FwcGxpY2F0aW9uX05vdGVfMS0wMF8xLTAwLUZp
bmFsLnBkZg0KPiA+ID4gU2VjdGlvbiAzLjMuNy4xLjEgb2YgaHR0cHM6Ly90cnVzdGVkY29tcHV0
aW5nZ3JvdXAub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9UQ0dfU3RvcmFnZV9BcmNoaXRlY3R1cmVf
Q29yZV9TcGVjX3YyLjAxX3IxLjAwLnBkZg0KPiA+ID4gDQo+ID4gPiBDby1kZXZlbG9wZWQtYnk6
IEFuZHJ6ZWogSmFrb3dza2kgPGFuZHJ6ZWouamFrb3dza2lAbGludXguaW50ZWwuY29tPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogQW5kcnplaiBKYWtvd3NraSA8YW5kcnplai5qYWtvd3NraUBsaW51
eC5pbnRlbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSZXZhbnRoIFJhamFzaGVrYXIgPHJl
dmFudGgucmFqYXNoZWthckBpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBibG9jay9vcGFs
X3Byb3RvLmggfCAxICsNCj4gPiA+ICBibG9jay9zZWQtb3BhbC5jICAgfCAyICstDQo+ID4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL29wYWxfcHJvdG8uaCBiL2Jsb2NrL29wYWxfcHJvdG8u
aA0KPiA+ID4gaW5kZXggMzI1Y2JiYTI0NjVmLi4yNzc0MGJhYWQ2MWQgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9ibG9jay9vcGFsX3Byb3RvLmgNCj4gPiA+ICsrKyBiL2Jsb2NrL29wYWxfcHJvdG8uaA0K
PiA+ID4gQEAgLTM2LDYgKzM2LDcgQEAgZW51bSBvcGFsX3Jlc3BvbnNlX3Rva2VuIHsNCj4gPiA+
IA0KPiA+ID4gICNkZWZpbmUgRFRBRVJST1JfTk9fTUVUSE9EX1NUQVRVUyAweDg5DQo+ID4gPiAg
I2RlZmluZSBHRU5FUklDX0hPU1RfU0VTU0lPTl9OVU0gMHg0MQ0KPiA+ID4gKyNkZWZpbmUgUlNW
RF9UUEVSX1NFU1NJT05fTlVNCTQwOTYNCj4gPiBUaGlzIHNlZW1zIGNvbmZ1c2luZyBhcyBpdCBs
b29rcyBsaWtlIDQwOTYgdGhlIFJlc2VydmVkIHNlc3Npb24gcmF0aGVyDQo+ID4gdGhhbiAwLTQw
OTUuDQo+ID4gQ2FuIHlvdSBuYW1lIGl0IGFwcHJvcHJpYXRlbHk/DQo+IFN1cmUsIGRvIHlvdSB0
aGluayBJTklUX1RQRVJfU0VTU0lPTl9OVU0gd291bGQgYmUgYXBwcm9wcmlhdGUuLj8NCkluaXQg
Y291bGQgYmUgY29uZnVzZWQgd2l0aCBJbml0aWFsaXplDQpNYXliZSBNSU5fVFBFUl9TRVNTSU9O
X05VTSBvciBGSVJTVF8uLi4gPw0KDQpUaGFua3MgZm9yIHRoaW5raW5nIGFib3V0IHRoaXMuDQoN
Cj4gPiA+ICAjZGVmaW5lIFRQRVJfU1lOQ19TVVBQT1JURUQgMHgwMQ0KPiA+ID4gICNkZWZpbmUg
TUJSX0VOQUJMRURfTUFTSyAweDEwDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svc2VkLW9wYWwu
YyBiL2Jsb2NrL3NlZC1vcGFsLmMNCj4gPiA+IGluZGV4IDg4MGNjNTdhNWY2Yi4uZjJiNjFhODY4
OTAxIDEwMDY0NA0KPiA+ID4gLS0tIGEvYmxvY2svc2VkLW9wYWwuYw0KPiA+ID4gKysrIGIvYmxv
Y2svc2VkLW9wYWwuYw0KPiA+ID4gQEAgLTEwNTYsNyArMTA1Niw3IEBAIHN0YXRpYyBpbnQgc3Rh
cnRfb3BhbF9zZXNzaW9uX2NvbnQoc3RydWN0IG9wYWxfZGV2ICpkZXYpDQo+ID4gPiAgCWhzbiA9
IHJlc3BvbnNlX2dldF91NjQoJmRldi0+cGFyc2VkLCA0KTsNCj4gPiA+ICAJdHNuID0gcmVzcG9u
c2VfZ2V0X3U2NCgmZGV2LT5wYXJzZWQsIDUpOw0KPiA+ID4gDQo+ID4gPiAtCWlmIChoc24gPT0g
MCAmJiB0c24gPT0gMCkgew0KPiA+ID4gKwlpZiAoaHNuICE9IEdFTkVSSUNfSE9TVF9TRVNTSU9O
X05VTSB8fCB0c24gPCBSU1ZEX1RQRVJfU0VTU0lPTl9OVU0pIHsNCj4gPiA+ICAJCXByX2RlYnVn
KCJDb3VsZG4ndCBhdXRoZW50aWNhdGUgc2Vzc2lvblxuIik7DQo+ID4gPiAgCQlyZXR1cm4gLUVQ
RVJNOw0KPiA+ID4gIAl9DQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4xDQo+ID4gPiANCg==
