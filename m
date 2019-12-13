Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA09C43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DB724658
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NS6Anzv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfLMJN2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:13:28 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46536 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMJN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 04:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576228406; x=1607764406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CBG1FDANtU5OZr3itkCR/uZ0kGzF/Rp81mdKwZKZTmw=;
  b=NS6Anzv2chFhdGEz7LHsKDZeWd72YiVKmNEojWbgpdtPAcsaNda0ORmq
   +T5hO4gZUocOKGI2Wuy868vl6KjmYXn6AO1VdXNGMlF3uxtBB/ekMqOJG
   tRofJEkXwviKzUkIwXXDvQC2oy+oIkvW3forIjO2pLrFSt6OaO0xh5KJG
   E=;
IronPort-SDR: R4EWnN0LcLv3X8VjF98eHYXSiwobj13NuJFtg1jfSe3jZQPRiaEXcXvdv2mR/rTU60u/8H6D4+
 oZHClg/pP4ww==
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="13309466"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Dec 2019 09:13:13 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 216D91A1E8F;
        Fri, 13 Dec 2019 09:13:11 +0000 (UTC)
Received: from EX13D11UWB004.ant.amazon.com (10.43.161.90) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Dec 2019 09:13:11 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB004.ant.amazon.com (10.43.161.90) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Dec 2019 09:13:11 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Fri, 13 Dec 2019 09:13:11 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [RFC PATCH] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH] block/genhd: Notify udev about capacity change
Thread-Index: AQHVrwYjh2l0GmmZOEmELsmopgOsAqe2RkCAgAGGxwA=
Date:   Fri, 13 Dec 2019 09:13:10 +0000
Message-ID: <8dee699c66a2c8532bd82515291d7fa86cab93f4.camel@amazon.com>
References: <20191210030131.4198-1-sblbir@amazon.com>
         <20191212095431.GA3720@lst.de>
In-Reply-To: <20191212095431.GA3720@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85A3E586BE61E449B1EB82A25A1F7677@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTEyIGF0IDEwOjU0ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBEZWMgMTAsIDIwMTkgYXQgMDM6MDE6MzFBTSArMDAwMCwgQmFsYmlyIFNp
bmdoIHdyb3RlOg0KPiA+IEFsbG93IGJsb2NrL2dlbmhkIHRvIG5vdGlmeSB1c2VyIHNwYWNlICh2
aWEgdWRldikgYWJvdXQgZGlzayBzaXplIGNoYW5nZXMNCj4gPiB1c2luZyBhIG5ldyBoZWxwZXIg
ZGlza19zZXRfY2FwYWNpdHkoKSwgd2hpY2ggaXMgYSB3cmFwcGVyIG9uIHRvcA0KPiA+IG9mIHNl
dF9jYXBhY2l0eSgpLiBkaXNrX3NldF9jYXBhY2l0eSgpIHdpbGwgb25seSBub3RpZnkgdmlhIHVk
ZXYgaWYNCj4gPiB0aGUgY3VycmVudCBjYXBhY2l0eSBvciB0aGUgdGFyZ2V0IGNhcGFjaXR5IGlz
IG5vdCB6ZXJvLg0KPiA+IA0KPiA+IGRpc2tfc2V0X2NhcGFjaXR5KCkgaXMgbm90IGVuYWJsZWQg
Zm9yIGFsbCBkZXZpY2VzLCBqdXN0IHZpcnRpbyBibG9jaywNCj4gPiB4ZW4tYmxvY2tmcm9udCwg
bnZtZSBhbmQgc2QuIE93bmVycyBvZiBvdGhlciBibG9jayBkaXNrIGRldmljZXMgY2FuDQo+ID4g
ZWFzaWx5IG1vdmUgb3ZlciBieSBjaGFuZ2luZyBzZXRfY2FwYWNpdHkoKSB0byBkaXNrX3NldF9j
YXBhY2l0eSgpDQo+ID4gDQo+ID4gQmFja2dyb3VuZDoNCj4gPiANCj4gPiBBcyBhIHBhcnQgb2Yg
YSBwYXRjaCB0byBhbGxvdyBzZW5kaW5nIHRoZSBSRVNJWkUgZXZlbnQgb24gZGlzayBjYXBhY2l0
eQ0KPiA+IGNoYW5nZSwgQ2hyaXN0b3BoIChoY2hAbHN0LmRlKSByZXF1ZXN0ZWQgdGhhdCB0aGUg
cGF0Y2ggYmUgbWFkZSBnZW5lcmljDQo+ID4gYW5kIHRoZSBoYWNrcyBmb3IgdmlydGlvIGJsb2Nr
IGFuZCB4ZW4gYmxvY2sgZGV2aWNlcyBiZSByZW1vdmVkIGFuZA0KPiA+IG1lcmdlZCB2aWEgYSBn
ZW5lcmljIGhlbHBlci4NCj4gPiANCj4gPiBUZXN0aW5nOg0KPiA+IDEuIEkgZGlkIHNvbWUgYmFz
aWMgdGVzdGluZyB3aXRoIGFuIE5WTUUgZGV2aWNlLCBieSByZXNpemluZyBpdCBpbg0KPiA+IHRo
ZSBiYWNrZW5kIGFuZCBlbnN1cmVkIHRoYXQgdWRldmQgcmVjZWl2ZWQgdGhlIGV2ZW50Lg0KPiA+
IA0KPiA+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTb21lc3dhcnVkdSBTYW5nYXJhanUgPHNzb21lc2hAYW1hem9uLmNvbT4NCj4g
PiAtLS0NCj4gPiAgYmxvY2svZ2VuaGQuYyAgICAgICAgICAgICAgICB8IDE5ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgICB8ICA0ICstLS0NCj4g
PiAgZHJpdmVycy9ibG9jay94ZW4tYmxrZnJvbnQuYyB8ICA1ICstLS0tDQo+ID4gIGRyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyAgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL3Njc2kvc2QuYyAgICAg
ICAgICAgIHwgIDIgKy0NCj4gPiAgaW5jbHVkZS9saW51eC9nZW5oZC5oICAgICAgICB8ICAxICsN
Cj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9ibG9jay9nZW5oZC5jIGIvYmxvY2svZ2VuaGQuYw0KPiA+
IGluZGV4IGZmNjI2ODk3MGRkYy4uOTRmYWVjOTg2MDdiIDEwMDY0NA0KPiA+IC0tLSBhL2Jsb2Nr
L2dlbmhkLmMNCj4gPiArKysgYi9ibG9jay9nZW5oZC5jDQo+ID4gQEAgLTQ2LDYgKzQ2LDI1IEBA
IHN0YXRpYyB2b2lkIGRpc2tfYWRkX2V2ZW50cyhzdHJ1Y3QgZ2VuZGlzayAqZGlzayk7DQo+ID4g
IHN0YXRpYyB2b2lkIGRpc2tfZGVsX2V2ZW50cyhzdHJ1Y3QgZ2VuZGlzayAqZGlzayk7DQo+ID4g
IHN0YXRpYyB2b2lkIGRpc2tfcmVsZWFzZV9ldmVudHMoc3RydWN0IGdlbmRpc2sgKmRpc2spOw0K
PiA+ICANCj4gPiArLyoNCj4gPiArICogU2V0IGRpc2sgY2FwYWNpdHkgYW5kIG5vdGlmeSBpZiB0
aGUgc2l6ZSBpcyBub3QgY3VycmVudGx5DQo+ID4gKyAqIHplcm8gYW5kIHdpbGwgbm90IGJlIHNl
dCB0byB6ZXJvDQo+IA0KPiBOaXQ6IFVzZSB1cCBhbGwgdGhlIDgwIGNoYXJzIHBlciBsaW5lLiAg
QWxzbyBtYXliZSB0dXJuIHRoaXMgaW50byBhDQo+IGtlcm5lbGRvYyBjb21tZW50LiAgSSB0aGlu
ayB5b3UgYWxzbyB3YW50IHRvIG1lbnRpb24gdGhlIG5vdGlmaWNhdGlvbg0KPiBhcyB3ZWxsLg0K
DQpXaWxsIGRvIQ0KDQo+IA0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChkaXNrX3NldF9jYXBhY2l0
eSk7DQo+ID4gKw0KPiA+ICsNCj4gPiAgdm9pZCBwYXJ0X2luY19pbl9mbGlnaHQoc3RydWN0IHJl
cXVlc3RfcXVldWUgKnEsIHN0cnVjdCBoZF9zdHJ1Y3QgKnBhcnQsDQo+ID4gaW50IHJ3KQ0KPiAN
Cj4gTm8gbmVlZCBmb3IgdGhlIGRvdWJsZSBlbXB0eSBsaW5lLg0KPiANCj4gPiAgew0KPiA+ICAJ
aWYgKHF1ZXVlX2lzX21xKHEpKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3ZpcnRp
b19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jDQo+ID4gaW5kZXggN2ZmZDcxOWQ4
OWRlLi44NjljZDNjMzE1MjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9f
YmxrLmMNCj4gPiArKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYw0KPiANCj4gQW5kIHlv
dSBwcm9iYWJseSB3YW50IHRvIHR1cm4gdGhpcyBpbnRvIGEgc2VyaWVzIHdpdGggcGF0Y2ggMSBh
ZGRpbmcNCj4gdGhlIGluZnJhc3RydWN0dXJlLCBhbmQgdGhlbiBvbmUgcGF0Y2ggcGVyIGRyaXZl
ciBzd2l0Y2hlZCBvdmVyLg0KTWFrZXMgc2Vuc2UsIHdpbGwgZG8NCg0KVGhhbmtzIGZvciB0aGUg
ZmVlZGJhY2sNCkJhbGJpciBTaW5naC4NCg==
