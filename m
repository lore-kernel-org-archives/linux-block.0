Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B742DC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 19:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7464C2173E
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 19:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HCb94Ede"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLKTgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:36:24 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:7620 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfLKTgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 14:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576092984; x=1607628984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D/AQrht491ZPuSkniyC8AF1uSsDZTxSScktHXQ9tcas=;
  b=HCb94EdeBwNV7jkGisM1/b6B6tK1y0AZM3D0flcAVPAnQx/2KY/rnMMZ
   WTMSV+fDcA/KlkSX7zWrgaHpztipk0Oits9nSwNeSVhrxQYzUdTCz+22X
   nUwKRfDMfs2QOYDeovPOVy1n9Gkl/3QgAIfC3TEMqc/ebL87U+yDTxodz
   Y=;
IronPort-SDR: 7kOHZMP+PPKT5dumufzq2UMtwAG5aP/xGikeM+OabQlSKdSYXfor3mTs9QQCWKGTMkgOm2ZvsG
 ZPnHUPl7HBFQ==
X-IronPort-AV: E=Sophos;i="5.69,303,1571702400"; 
   d="scan'208";a="12985776"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Dec 2019 19:36:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 2B294A22B0;
        Wed, 11 Dec 2019 19:36:10 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 19:36:09 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 19:36:09 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Wed, 11 Dec 2019 19:36:09 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [RFC PATCH] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH] block/genhd: Notify udev about capacity change
Thread-Index: AQHVrwYjh2l0GmmZOEmELsmopgOsAqe1Vm2A
Date:   Wed, 11 Dec 2019 19:36:09 +0000
Message-ID: <3e23c39e2d6c99ce8bdae370de36f7479b6dab95.camel@amazon.com>
References: <20191210030131.4198-1-sblbir@amazon.com>
In-Reply-To: <20191210030131.4198-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <04931DD686A9514F94F948B5E992FB49@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTEwIGF0IDAzOjAxICswMDAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IEFsbG93IGJsb2NrL2dlbmhkIHRvIG5vdGlmeSB1c2VyIHNwYWNlICh2aWEgdWRldikgYWJvdXQg
ZGlzayBzaXplIGNoYW5nZXMNCj4gdXNpbmcgYSBuZXcgaGVscGVyIGRpc2tfc2V0X2NhcGFjaXR5
KCksIHdoaWNoIGlzIGEgd3JhcHBlciBvbiB0b3ANCj4gb2Ygc2V0X2NhcGFjaXR5KCkuIGRpc2tf
c2V0X2NhcGFjaXR5KCkgd2lsbCBvbmx5IG5vdGlmeSB2aWEgdWRldiBpZg0KPiB0aGUgY3VycmVu
dCBjYXBhY2l0eSBvciB0aGUgdGFyZ2V0IGNhcGFjaXR5IGlzIG5vdCB6ZXJvLg0KPiANCj4gZGlz
a19zZXRfY2FwYWNpdHkoKSBpcyBub3QgZW5hYmxlZCBmb3IgYWxsIGRldmljZXMsIGp1c3Qgdmly
dGlvIGJsb2NrLA0KPiB4ZW4tYmxvY2tmcm9udCwgbnZtZSBhbmQgc2QuIE93bmVycyBvZiBvdGhl
ciBibG9jayBkaXNrIGRldmljZXMgY2FuDQo+IGVhc2lseSBtb3ZlIG92ZXIgYnkgY2hhbmdpbmcg
c2V0X2NhcGFjaXR5KCkgdG8gZGlza19zZXRfY2FwYWNpdHkoKQ0KPiANCj4gQmFja2dyb3VuZDoN
Cj4gDQo+IEFzIGEgcGFydCBvZiBhIHBhdGNoIHRvIGFsbG93IHNlbmRpbmcgdGhlIFJFU0laRSBl
dmVudCBvbiBkaXNrIGNhcGFjaXR5DQo+IGNoYW5nZSwgQ2hyaXN0b3BoIChoY2hAbHN0LmRlKSBy
ZXF1ZXN0ZWQgdGhhdCB0aGUgcGF0Y2ggYmUgbWFkZSBnZW5lcmljDQo+IGFuZCB0aGUgaGFja3Mg
Zm9yIHZpcnRpbyBibG9jayBhbmQgeGVuIGJsb2NrIGRldmljZXMgYmUgcmVtb3ZlZCBhbmQNCj4g
bWVyZ2VkIHZpYSBhIGdlbmVyaWMgaGVscGVyLg0KPiANCj4gVGVzdGluZzoNCj4gMS4gSSBkaWQg
c29tZSBiYXNpYyB0ZXN0aW5nIHdpdGggYW4gTlZNRSBkZXZpY2UsIGJ5IHJlc2l6aW5nIGl0IGlu
DQo+IHRoZSBiYWNrZW5kIGFuZCBlbnN1cmVkIHRoYXQgdWRldmQgcmVjZWl2ZWQgdGhlIGV2ZW50
Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4g
U2lnbmVkLW9mZi1ieTogQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogU29tZXN3YXJ1ZHUgU2FuZ2FyYWp1IDxzc29tZXNoQGFtYXpvbi5jb20+DQo+IA0K
DQpBbnkgZmVlZGJhY2sgb24gdGhlIFJGQz8NCg0KQmFsYmlyIFNpbmdoLg0K
