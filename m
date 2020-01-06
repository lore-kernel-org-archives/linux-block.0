Return-Path: <SRS0=PDkS=23=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE82C32771
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8CE2072C
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 08:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CJDQLzkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAFIrY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:47:24 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:12482 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAFIrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 03:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578300444; x=1609836444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ix5h9iU4MplLeme2iLjVHaJ92Uaud1kBSOfPMOmtTy0=;
  b=CJDQLzkhLrL+aVYud1p5jT2Qkq5fdmZ3PJhx4f6mMIJ8PVE5g+h0J+E4
   3US5zsliHBpwj3lGhdHRXuAK/J8YEIfFxJzA+tQHGEvh0B2/sIMF63A6e
   23cJWVkodTsOkTC06C6QvThHZ3hr4ivCo7iFg8K0WZqlrrPbxGs5RsY+A
   Q=;
IronPort-SDR: Dm6wR7zJAlUlUyRh5QULx4yI90ylhLA4vmAmCCbXBcA08vZVTRLPX+4gIo9ktDUC7rF7AWkhtN
 ZoEdfrjPq0Ig==
X-IronPort-AV: E=Sophos;i="5.69,401,1571702400"; 
   d="scan'208";a="8546392"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 06 Jan 2020 08:47:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 1BA64A2083;
        Mon,  6 Jan 2020 08:47:07 +0000 (UTC)
Received: from EX13D11UWB002.ant.amazon.com (10.43.161.20) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 Jan 2020 08:47:07 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB002.ant.amazon.com (10.43.161.20) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 Jan 2020 08:47:07 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Mon, 6 Jan 2020 08:47:07 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bob.liu@oracle.com" <bob.liu@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [resend v1 0/5] Add support for block disk resize notification
Thread-Topic: [resend v1 0/5] Add support for block disk resize notification
Thread-Index: AQHVwUGyPPcy7lGHrU2FjB+Vz+cImqfdKliAgAAuqAA=
Date:   Mon, 6 Jan 2020 08:47:06 +0000
Message-ID: <f260159c7c56a08711240cc6c7f69d2d5327a449.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <62ef2cd2-42a2-6117-155d-ed052a136c5c@oracle.com>
In-Reply-To: <62ef2cd2-42a2-6117-155d-ed052a136c5c@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <00642D1230BA1646B79D85953B680334@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDEzOjU5ICswODAwLCBCb2IgTGl1IHdyb3RlOg0KPiBPbiAx
LzIvMjAgMzo1MyBQTSwgQmFsYmlyIFNpbmdoIHdyb3RlOg0KPiA+IEFsbG93IGJsb2NrL2dlbmhk
IHRvIG5vdGlmeSB1c2VyIHNwYWNlIGFib3V0IGRpc2sgc2l6ZSBjaGFuZ2VzDQo+ID4gdXNpbmcg
YSBuZXcgaGVscGVyIGRpc2tfc2V0X2NhcGFjaXR5KCksIHdoaWNoIGlzIGEgd3JhcHBlciBvbiB0
b3ANCj4gPiBvZiBzZXRfY2FwYWNpdHkoKS4gZGlza19zZXRfY2FwYWNpdHkoKSB3aWxsIG9ubHkg
bm90aWZ5IGlmDQo+ID4gdGhlIGN1cnJlbnQgY2FwYWNpdHkgb3IgdGhlIHRhcmdldCBjYXBhY2l0
eSBpcyBub3QgemVyby4NCj4gPiANCj4gDQo+IHNldF9jYXBhY2l0eV9hbmRfbm90aWZ5KCkgbWF5
IGJlIGEgbW9yZSBzdHJhaWdodGZvcndhcmQgbmFtZS4NCj4gDQoNClllcywgYWdyZWVkLg0KDQo+
ID4gQmFja2dyb3VuZDoNCj4gPiANCj4gPiBBcyBhIHBhcnQgb2YgYSBwYXRjaCB0byBhbGxvdyBz
ZW5kaW5nIHRoZSBSRVNJWkUgZXZlbnQgb24gZGlzayBjYXBhY2l0eQ0KPiA+IGNoYW5nZSwgQ2hy
aXN0b3BoIChoY2hAbHN0LmRlKSByZXF1ZXN0ZWQgdGhhdCB0aGUgcGF0Y2ggYmUgbWFkZSBnZW5l
cmljDQo+ID4gYW5kIHRoZSBoYWNrcyBmb3IgdmlydGlvIGJsb2NrIGFuZCB4ZW4gYmxvY2sgZGV2
aWNlcyBiZSByZW1vdmVkIGFuZA0KPiA+IG1lcmdlZCB2aWEgYSBnZW5lcmljIGhlbHBlci4NCj4g
PiANCj4gPiBUaGlzIHNlcmllcyBjb25zaXN0cyBvZiA1IGNoYW5nZXMuIFRoZSBmaXJzdCBvbmUg
YWRkcyB0aGUgYmFzaWMNCj4gPiBzdXBwb3J0IGZvciBjaGFuZ2luZyB0aGUgc2l6ZSBhbmQgbm90
aWZ5aW5nLiBUaGUgZm9sbG93IHVwIHBhdGNoZXMNCj4gPiBhcmUgcGVyIGJsb2NrIHN1YnN5c3Rl
bSBjaGFuZ2VzLiBPdGhlciBibG9jayBkcml2ZXJzIGNhbiBhZGQgdGhlaXINCj4gPiBjaGFuZ2Vz
IGFzIG5lY2Vzc2FyeSBvbiB0b3Agb2YgdGhpcyBzZXJpZXMuDQo+ID4gDQo+ID4gVGVzdGluZzoN
Cj4gPiAxLiBJIGRpZCBzb21lIGJhc2ljIHRlc3Rpbmcgd2l0aCBhbiBOVk1FIGRldmljZSwgYnkg
cmVzaXppbmcgaXQgaW4NCj4gPiB0aGUgYmFja2VuZCBhbmQgZW5zdXJlZCB0aGF0IHVkZXZkIHJl
Y2VpdmVkIHRoZSBldmVudC4NCj4gPiANCj4gPiBOT1RFOiBBZnRlciB0aGVzZSBjaGFuZ2VzLCB0
aGUgbm90aWZpY2F0aW9uIG1pZ2h0IGhhcHBlbiBiZWZvcmUNCj4gPiByZXZhbGlkYXRlIGRpc2ss
IHdoZXJlIGFzIGl0IG9jY3VyZWQgbGF0ZXIgYmVmb3JlLg0KPiA+IA0KPiANCj4gSXQncyBiZXR0
ZXIgbm90IHRvIGNoYW5nZSBvcmlnaW5hbCBiZWhhdmlvci4NCj4gSG93IGFib3V0IHNvbWV0aGlu
ZyBsaWtlOg0KPiANCj4gK3ZvaWQgc2V0X2NhcGFjaXR5X2FuZF9ub3RpZnkoc3RydWN0IGdlbmRp
c2sgKmRpc2ssIHNlY3Rvcl90IHNpemUsIGJvb2wNCj4gcmV2YWxpZGF0ZSkNCj4gew0KPiAJc2Vj
dG9yX3QgY2FwYWNpdHkgPSBnZXRfY2FwYWNpdHkoZGlzayk7DQo+IA0KPiAJc2V0X2NhcGFjaXR5
KGRpc2ssIHNpemUpOw0KPiANCj4gKyAgICAgICAgaWYgKHJldmFsaWRhdGUpDQo+ICsJCXJldmFs
aWRhdGVfZGlzayhkaXNrKTsNCg0KRG8geW91IHNlZSBhIGNvbmNlcm4gd2l0aCB0aGUgbm90aWZp
Y2F0aW9uIGdvaW5nIG91dCBiZWZvcmUgcmV2YWxpZGF0ZV9kaXNrPw0KSSBjb3VsZCBrZWVwIHRo
ZSBiZWhhdmlvdXIgYW5kIGNvbWUgdXAgd2l0aCBhIHN1aXRhYmxlIG5hbWUNCg0KcmV2YWxpZGF0
ZV9kaXNrX2FuZF9ub3RpZnkoKSAoc2V0X2NhcGFjaXR5IGlzIGEgcGFydCBvZiB0aGUgcmV2YWxp
ZGF0aW9uDQpwcm9jZXNzKSwgb3IgZmVlbCBmcmVlIHRvIHN1Z2dlc3QgYSBiZXR0ZXIgbmFtZQ0K
DQpUaGFua3MsDQpCYWxiaXIgU2luZ2gNCg0K
