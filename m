Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896CFC3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 04:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D9B2465D
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 04:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XIUN+YBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCCEEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:04:02 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23763 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgCCEEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 23:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583208242; x=1614744242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sXeS6p7Itr7djtUdtudVwXDeytGL1G/3avUXEanK1OY=;
  b=XIUN+YBlnRA/9jmConDwZcGeBla7CISK1xw+co9fI+3uxYdDNlI2nZlH
   WcrWpYVmX0Ys4Sgzzhr+JKI6fCLXaV2YMYgEOjAMfzzPHFgfKYdBruRRz
   RdKZuY6dvK9fyCJ8KLgIZy8G3CLZiP3jD2VNsTf3jZhQK98mjZLiIMit6
   c=;
IronPort-SDR: 4NXr8SMbetEKaQTY4fdW/KXzww/XZW3aSn+bnL3yY+9egQoy1w6JqDjzftCPrM1Hnolsmw54mg
 Nkx4Xn7O58ew==
X-IronPort-AV: E=Sophos;i="5.70,509,1574121600"; 
   d="scan'208";a="20649458"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Mar 2020 04:03:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id D0089A2CB5;
        Tue,  3 Mar 2020 04:03:46 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Mar 2020 04:03:46 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 04:03:46 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Tue, 3 Mar 2020 04:03:45 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/5] Add support for block disk resize notification
Thread-Topic: [PATCH v2 0/5] Add support for block disk resize notification
Thread-Index: AQHV7BZlqlE0eKkI5kmZncB90XbQkKg2SUiA
Date:   Tue, 3 Mar 2020 04:03:45 +0000
Message-ID: <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.8]
Content-Type: text/plain; charset="utf-8"
Content-ID: <97EF196BA8BC864E90A3D2B135CE2ADB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDIwOjAxICswMDAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IEFsbG93IGJsb2NrL2dlbmhkIHRvIG5vdGlmeSB1c2VyIHNwYWNlIGFib3V0IGRpc2sgc2l6ZSBj
aGFuZ2VzIHVzaW5nIGENCj4gbmV3IGhlbHBlciBzZXRfY2FwYWNpdHlfcmV2YWxpZGF0ZV9hbmRf
bm90aWZ5KCksIHdoaWNoIGlzIGEgd3JhcHBlcg0KPiBvbiB0b3Agb2Ygc2V0X2NhcGFjaXR5KCku
IHNldF9jYXBhY2l0eV9yZXZhbGlkYXRlX2FuZF9ub3RpZnkoKSB3aWxsIG9ubHkNCj4gbm90aWZ5
DQo+IGlmZiB0aGUgY3VycmVudCBjYXBhY2l0eSBvciB0aGUgdGFyZ2V0IGNhcGFjaXR5IGlzIG5v
dCB6ZXJvIGFuZCB0aGUNCj4gY2FwYWNpdHkgcmVhbGx5IGNoYW5nZXMuDQo+IA0KPiBCYWNrZ3Jv
dW5kOg0KPiANCj4gQXMgYSBwYXJ0IG9mIGEgcGF0Y2ggdG8gYWxsb3cgc2VuZGluZyB0aGUgUkVT
SVpFIGV2ZW50IG9uIGRpc2sgY2FwYWNpdHkNCj4gY2hhbmdlLCBDaHJpc3RvcGggKGhjaEBsc3Qu
ZGUpIHJlcXVlc3RlZCB0aGF0IHRoZSBwYXRjaCBiZSBtYWRlIGdlbmVyaWMNCj4gYW5kIHRoZSBo
YWNrcyBmb3IgdmlydGlvIGJsb2NrIGFuZCB4ZW4gYmxvY2sgZGV2aWNlcyBiZSByZW1vdmVkIGFu
ZA0KPiBtZXJnZWQgdmlhIGEgZ2VuZXJpYyBoZWxwZXIuDQo+IA0KPiBUaGlzIHNlcmllcyBjb25z
aXN0cyBvZiA1IGNoYW5nZXMuIFRoZSBmaXJzdCBvbmUgYWRkcyB0aGUgYmFzaWMNCj4gc3VwcG9y
dCBmb3IgY2hhbmdpbmcgdGhlIHNpemUgYW5kIG5vdGlmeWluZy4gVGhlIGZvbGxvdyB1cCBwYXRj
aGVzDQo+IGFyZSBwZXIgYmxvY2sgc3Vic3lzdGVtIGNoYW5nZXMuIE90aGVyIGJsb2NrIGRyaXZl
cnMgY2FuIGFkZCB0aGVpcg0KPiBjaGFuZ2VzIGFzIG5lY2Vzc2FyeSBvbiB0b3Agb2YgdGhpcyBz
ZXJpZXMuIFNpbmNlIG5vdCBhbGwgZGV2aWNlcw0KPiBhcmUgcmVzaXphYmxlLCB0aGUgZGVmYXVs
dCB3YXMgdG8gYWRkIGEgbmV3IEFQSSBhbmQgbGV0IHVzZXJzDQo+IHNsb3dseSBjb252ZXJ0IG92
ZXIgYXMgbmVlZGVkLg0KPiANCj4gVGVzdGluZzoNCj4gMS4gSSBkaWQgc29tZSBiYXNpYyB0ZXN0
aW5nIHdpdGggYW4gTlZNRSBkZXZpY2UsIGJ5IHJlc2l6aW5nIGl0IGluDQo+IHRoZSBiYWNrZW5k
IGFuZCBlbnN1cmVkIHRoYXQgdWRldmQgcmVjZWl2ZWQgdGhlIGV2ZW50Lg0KPiANCj4gDQo+IENo
YW5nZWxvZyB2MjoNCj4gLSBSZW5hbWUgZGlza19zZXRfY2FwYWNpdHkgdG8gc2V0X2NhcGFjaXR5
X3JldmFsaWRhdGVfYW5kX25vdGlmeQ0KPiAtIHNldF9jYXBhY2l0eV9yZXZhbGlkYXRlX2FuZF9u
b3RpZnkgY2FuIGNhbGwgcmV2YWxpZGF0ZSBkaXNrDQo+ICAgaWYgbmVlZGVkLCBhIG5ldyBib29s
IHBhcmFtZXRlciBpcyBwYXNzZWQgKHN1Z2dlc3RlZCBieSBCb2IgTGl1KQ0KPiANCg0KUGluZz8g
SXQncyBub3QgYW4gdXJnZW50IHBhdGNoc2V0LCBJIGFtIGhhcHB5IHRvIHdhaXQgaWYgbm90aGlu
ZyBlbHNlIGlzDQpuZWVkZWQuDQoNCkJhbGJpciBTaW5naA0K
