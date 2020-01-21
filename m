Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD9EC2D0CE
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 19:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB184217F4
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 19:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qUR3604K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAUTwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:52:21 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10390 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUTwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 14:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579636341; x=1611172341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XmzH6UUhf2fq7wRQ6JDGuAiXl76NE0nd9fhU95gyxxs=;
  b=qUR3604KmaGylsWJv41ZjQNQJDSgE+7kaDFHtMOr7vQxKvEmsFYfu0YD
   GyG5f55Y4wO5FYj7bRnYH5EtQ9FXOKnfnKWvdogPbaDCMSP+ml4W2/tY4
   x7/hqgBu3dmQ6js57OOE4MOtqmJmgx41CORriPml0Zh+DKAAT4LANHehy
   c=;
IronPort-SDR: cUrWtJYzh5SkjSAWnROiY1GCaVFVcrwkJBLQYslWMGOqBtqCnoh+iGPltozsC/AFszrvhLxt4b
 VZ6W6RyVqaPQ==
X-IronPort-AV: E=Sophos;i="5.70,347,1574121600"; 
   d="scan'208";a="20200140"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Jan 2020 19:52:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 9F5ECA05E3;
        Tue, 21 Jan 2020 19:52:07 +0000 (UTC)
Received: from EX13D11UWB002.ant.amazon.com (10.43.161.20) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Jan 2020 19:52:07 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB002.ant.amazon.com (10.43.161.20) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Jan 2020 19:52:07 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 21 Jan 2020 19:52:07 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVwUG1iZmE8Pm/G0CenFe4gZ349afc0u0AgAQUfoCAFL6VAA==
Date:   Tue, 21 Jan 2020 19:52:06 +0000
Message-ID: <40580ebc0991c4ffc3be67d60aeaf269703854ac.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-5-sblbir@amazon.com>
         <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
         <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
         <20200108150447.GC10975@lst.de>
In-Reply-To: <20200108150447.GC10975@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.8]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6425CB2DE728D54BA14C729788634425@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTA4IGF0IDE2OjA0ICswMTAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBNb24sIEphbiAwNiwgMjAyMCBhdCAxMjo0NjoyNkFNICswMDAwLCBTaW5naCwgQmFsYmlyIHdy
b3RlOg0KPiA+IE9uIFNhdCwgMjAyMC0wMS0wNCBhdCAyMjoyNyArMDAwMCwgQ2hhaXRhbnlhIEt1
bGthcm5pIHdyb3RlOg0KPiA+ID4gUXVpY2sgcXVlc3Rpb24gaGVyZSBpZiB1c2VyIGV4ZWN1dGVz
IG52bWUgbnMtcmVzY2FuIC9kZXYvbnZtZTENCj4gPiA+IHdpbGwgZm9sbG93aW5nIGNvZGUgcmVz
dWx0IGluIHRyaWdnZXJpbmcgdWV2ZW50KHMpIGZvcg0KPiA+ID4gdGhlIG5hbWVzcGFjZShzKCBm
b3Igd2hpY2ggdGhlcmUgaXMgbm8gY2hhbmdlIGluIHRoZSBzaXplID8NCj4gPiA+IA0KPiA+ID4g
SWYgc28gaXMgdGhhdCBhbiBleHBlY3RlZCBiZWhhdmlvciA/DQo+ID4gPiANCj4gPiANCj4gPiBN
eSBvbGQgY29kZSBoYWQgYSBjaGVjayB0byBzZWUgaWYgb2xkX2NhcGFjaXR5ICE9IG5ld19jYXBh
Y2l0eSBhcyB3ZWxsLg0KPiA+IEkgY2FuIHJlZG8gdGhvc2UgYml0cyBpZiBuZWVkZWQuDQo+ID4g
DQo+ID4gVGhlIGV4cGVjdGVkIGJlaGF2aW91ciBpcyBub3QgY2xlYXIsIGJ1dCB0aGUgZnVuY3Rp
b25hbGl0eSBpcyBub3QgYnJva2VuLA0KPiA+IHVzZXINCj4gPiBzcGFjZSBzaG91bGQgYmUgYWJs
ZSB0byBkZWFsIHdpdGggYSByZXNpemUgZXZlbnQgd2hlcmUgdGhlIHByZXZpb3VzDQo+ID4gY2Fw
YWNpdHkNCj4gPiA9PSBuZXcgY2FwYWNpdHkgSU1ITy4NCj4gDQo+IEkgdGhpbmsgaXQgbWFrZXMg
c2Vuc2UgdG8gbm90IGJvdGhlciB3aXRoIGEgbm90aWZpY2F0aW9uIHVubGVzcyB0aGVyZQ0KPiBp
cyBhbiBhY3R1YWwgY2hhbmdlLg0KDQpbU29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLCBq
dXN0IGJhY2sgZnJvbSBMQ0FdDQoNCkFncmVlZCENCg0KQmFsYmlyIFNpbmdoDQo=
