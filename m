Return-Path: <SRS0=GSyA=X4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B65C32792
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A007E20673
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392855AbfJCRGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:06:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:15008 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393126AbfJCRGJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Oct 2019 13:06:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 10:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="393272209"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2019 10:06:07 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 3 Oct 2019 10:06:07 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.55]) with mapi id 14.03.0439.000;
 Thu, 3 Oct 2019 10:06:07 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: sed-opal: fix sparse warning: convert __be64
 data
Thread-Topic: [PATCH 2/2] block: sed-opal: fix sparse warning: convert
 __be64 data
Thread-Index: AQHVeZGSCWgTvFsPkkSWBOzJr9STdKdJhBaAgAAXyAA=
Date:   Thu, 3 Oct 2019 17:06:06 +0000
Message-ID: <d091d361b0233da07f45488aae87857cb9388529.camel@intel.com>
References: <82f70133-7242-d113-f041-9b89694685c0@infradead.org>
         <20191003154053.GA2450@hacktheplanet>
In-Reply-To: <20191003154053.GA2450@hacktheplanet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <90673F7865A38542AC230A2D6562171E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTAzIGF0IDExOjQwIC0wNDAwLCBTY290dCBCYXVlciB3cm90ZToNCj4g
T24gV2VkLCBPY3QgMDIsIDIwMTkgYXQgMDc6MjM6MTVQTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOg0KPiA+IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+
IA0KPiA+IHNwYXJzZSB3YXJucyBhYm91dCBpbmNvcnJlY3QgdHlwZSB3aGVuIHVzaW5nIF9fYmU2
NCBkYXRhLg0KPiA+IEl0IGlzIG5vdCBiZWluZyBjb252ZXJ0ZWQgdG8gQ1BVLWVuZGlhbiBidXQg
aXQgc2hvdWxkIGJlLg0KPiA+IA0KPiA+IEZpeGVzIHRoZXNlIHNwYXJzZSB3YXJuaW5nczoNCj4g
PiANCj4gPiAuLi9ibG9jay9zZWQtb3BhbC5jOjM3NToyMDogd2FybmluZzogaW5jb3JyZWN0IHR5
cGUgaW4gYXNzaWdubWVudCAoZGlmZmVyZW50IGJhc2UgdHlwZXMpDQo+ID4gLi4vYmxvY2svc2Vk
LW9wYWwuYzozNzU6MjA6ICAgIGV4cGVjdGVkIHVuc2lnbmVkIGxvbmcgbG9uZyBbdXNlcnR5cGVd
IGFsaWduDQo+ID4gLi4vYmxvY2svc2VkLW9wYWwuYzozNzU6MjA6ICAgIGdvdCByZXN0cmljdGVk
IF9fYmU2NCBjb25zdCBbdXNlcnR5cGVdIGFsaWdubWVudF9ncmFudWxhcml0eQ0KPiA+IC4uL2Js
b2NrL3NlZC1vcGFsLmM6Mzc2OjI1OiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiBhc3NpZ25t
ZW50IChkaWZmZXJlbnQgYmFzZSB0eXBlcykNCj4gPiAuLi9ibG9jay9zZWQtb3BhbC5jOjM3Njoy
NTogICAgZXhwZWN0ZWQgdW5zaWduZWQgbG9uZyBsb25nIFt1c2VydHlwZV0gbG93ZXN0X2xiYQ0K
PiA+IC4uL2Jsb2NrL3NlZC1vcGFsLmM6Mzc2OjI1OiAgICBnb3QgcmVzdHJpY3RlZCBfX2JlNjQg
Y29uc3QgW3VzZXJ0eXBlXSBsb3dlc3RfYWxpZ25lZF9sYmENCj4gPiANCj4gPiBGaXhlczogNDU1
YTdiMjM4Y2Q2ICgiYmxvY2s6IEFkZCBTZWQtb3BhbCBsaWJyYXJ5IikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gPiBDYzogU2NvdHQg
QmF1ZXIgPHNjb3R0LmJhdWVyQGludGVsLmNvbT4NCj4gPiBDYzogUmFmYWVsIEFudG9nbm9sbGkg
PHJhZmFlbC5hbnRvZ25vbGxpQGludGVsLmNvbT4NCj4gPiBDYzogSmVucyBBeGJvZSA8YXhib2VA
a2VybmVsLmRrPg0KPiA+IENjOiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+ICsg
Sm9uIGFuZCBSZXZhbnRoLA0KPiANCj4gDQo+IFRoZXNlIGxvb2sgZmluZS4gVGhleSdyZSBjdXJy
ZW50bHkgdW51c2VkLCBidXQgbWF5IGJlIHVzZWZ1bCBpbiB0aGUgZnV0dXJlIGZvciBzeXNmcyBv
ciB3aGF0IGV2ZXIgZWxzZSB3ZSBhZGQgaW4uDQoNCkkgaW1hZ2luZSBtb2Rlcm4gZGV2aWNlcyB3
aXRoIGxvZ2ljYWwvcGh5c2ljYWwgaW5kaXJlY3Rpb24gd291bGQNCnByb2JhYmx5IHJlcG9ydCBn
cmFuPTEgYW5kIGxvd2VzdD0wIHJlZ2FyZGxlc3MuDQoNCkVpdGhlciB3YXksDQpSZXZpZXdlZC1i
eTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0K
