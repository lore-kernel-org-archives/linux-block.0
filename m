Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:35170
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755667AbdDFEVE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 00:21:04 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Thu, 6 Apr 2017 04:21:01 +0000
Message-ID: <DM5PR03MB2490E70D9B18A701A81005C8A00D0@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
         <1491438735.2787.18.camel@sandisk.com>
         <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
 <1491450335.8994.1.camel@sandisk.com>
In-Reply-To: <1491450335.8994.1.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydCBWYW4gQXNzY2hl
IFttYWlsdG86QmFydC5WYW5Bc3NjaGVAc2FuZGlzay5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgNSwgMjAxNyA4OjQ2IFBNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IExvbmcgTGkNCj4gPGxvbmdsaUBtaWNyb3Nv
ZnQuY29tPjsgYXhib2VAa2VybmVsLmRrDQo+IENjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1t
aW5AbWljcm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBibG9jay1tcTogc2V0IGJvdGggYmxvY2sgcXVldWUgYW5k
IGhhcmR3YXJlIHF1ZXVlDQo+IHJlc3RhcnQgYml0IGZvciByZXN0YXJ0DQo+IA0KPiBPbiBUaHUs
IDIwMTctMDQtMDYgYXQgMDM6MzggKzAwMDAsIExvbmcgTGkgd3JvdGU6DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmFydCBWYW4gQXNzY2hlIFttYWlsdG86
QmFydC5WYW5Bc3NjaGVAc2FuZGlzay5jb21dDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGRyb3AgdGhp
cyBwYXRjaC4gSSdtIHdvcmtpbmcgb24gYSBiZXR0ZXIgc29sdXRpb24uDQo+ID4NCj4gPiBUaGFu
ayB5b3UuIExvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHBhdGNoLg0KPiANCj4gSGVsbG8gTG9uZywN
Cj4gDQo+IEl0IHdvdWxkIGhlbHAgaWYgeW91IGNvdWxkIHNoYXJlIHRoZSBuYW1lIG9mIHRoZSBi
bG9jayBvciBTQ1NJIGRyaXZlciB3aXRoDQo+IHdoaWNoIHlvdSByYW4gaW50byB0aGF0IGxvY2t1
cCBhbmQgYWxzbyBpZiB5b3UgY291bGQgc2hhcmUgdGhlIG5hbWUgb2YgdGhlDQo+IEkvTyBzY2hl
ZHVsZXIgdXNlZCBpbiB5b3VyIHRlc3QuDQoNClRoZSB0ZXN0cyB0aGF0IGluZGljYXRlZCB0aGUg
aXNzdWUgd2VyZSBydW4gSHlwZXItVi4gVGhlIGRyaXZlciBpcyBzdG9ydnNjX2Rydi5jDQpUaGUg
SS9PIHNjaGVkdWxlciB3YXMgSSB0aGluayBub29wLg0KDQpLLiBZDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBCYXJ0Lg0K
