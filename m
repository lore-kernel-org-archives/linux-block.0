Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0883AC10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 22:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4931206CD
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 22:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ecEYYmaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCLWvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:51:53 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31580 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLWvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 18:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584053513; x=1615589513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=APmuTEj00jSwH9UdKFoz86SYSwY6N2q5esvdw5Bdl+o=;
  b=ecEYYmaRVNMS+YIAPUNaFPu4KOI9ow4wXEonCS4K5gw22JkwEjqyNCfj
   ThnppnmJ9xKzs8xK32WjQ7/YHF3PH36ejOUcqnWCakDGeye545GjBBXdI
   NxMn91IyDjlQdKJe6tvy5ziR3KXSTBUQvrzHZGDE96zy1Un8pdtWiliHv
   w=;
IronPort-SDR: ugjucCAlacrlOlBoX7R+p/ruO8wypS9aieV7ZL/kdFBMiPo3e2F7WuMI4vhcZCTvJ8GlrtvpiT
 e4ImMoCq71Cg==
X-IronPort-AV: E=Sophos;i="5.70,546,1574121600"; 
   d="scan'208";a="22562882"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 12 Mar 2020 22:51:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id C14F3A277A;
        Thu, 12 Mar 2020 22:51:46 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Mar 2020 22:51:46 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 22:51:45 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 12 Mar 2020 22:51:45 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v2 0/5] Add support for block disk resize notification
Thread-Topic: [PATCH v2 0/5] Add support for block disk resize notification
Thread-Index: AQHV+MDObGy8ubWnEEm2OFraTMxGPw==
Date:   Thu, 12 Mar 2020 22:51:45 +0000
Message-ID: <3c43712ebbd3d4e5c301677a17ec7a301487faa4.camel@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
         <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
         <05bb1606-4cf1-dba3-22a0-5f8624b43767@kernel.dk>
In-Reply-To: <05bb1606-4cf1-dba3-22a0-5f8624b43767@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.115]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAD689968AC0AB42B571A46AC6393DEB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTEyIGF0IDA4OjA2IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiAN
Cj4gT24gMy8yLzIwIDk6MDMgUE0sIFNpbmdoLCBCYWxiaXIgd3JvdGU6DQo+ID4gT24gVHVlLCAy
MDIwLTAyLTI1IGF0IDIwOjAxICswMDAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+ID4gPiBBbGxv
dyBibG9jay9nZW5oZCB0byBub3RpZnkgdXNlciBzcGFjZSBhYm91dCBkaXNrIHNpemUgY2hhbmdl
cyB1c2luZyBhDQo+ID4gPiBuZXcgaGVscGVyIHNldF9jYXBhY2l0eV9yZXZhbGlkYXRlX2FuZF9u
b3RpZnkoKSwgd2hpY2ggaXMgYSB3cmFwcGVyDQo+ID4gPiBvbiB0b3Agb2Ygc2V0X2NhcGFjaXR5
KCkuIHNldF9jYXBhY2l0eV9yZXZhbGlkYXRlX2FuZF9ub3RpZnkoKSB3aWxsIG9ubHkNCj4gPiA+
IG5vdGlmeQ0KPiA+ID4gaWZmIHRoZSBjdXJyZW50IGNhcGFjaXR5IG9yIHRoZSB0YXJnZXQgY2Fw
YWNpdHkgaXMgbm90IHplcm8gYW5kIHRoZQ0KPiA+ID4gY2FwYWNpdHkgcmVhbGx5IGNoYW5nZXMu
DQo+ID4gPiANCj4gPiA+IEJhY2tncm91bmQ6DQo+ID4gPiANCj4gPiA+IEFzIGEgcGFydCBvZiBh
IHBhdGNoIHRvIGFsbG93IHNlbmRpbmcgdGhlIFJFU0laRSBldmVudCBvbiBkaXNrIGNhcGFjaXR5
DQo+ID4gPiBjaGFuZ2UsIENocmlzdG9waCAoaGNoQGxzdC5kZSkgcmVxdWVzdGVkIHRoYXQgdGhl
IHBhdGNoIGJlIG1hZGUgZ2VuZXJpYw0KPiA+ID4gYW5kIHRoZSBoYWNrcyBmb3IgdmlydGlvIGJs
b2NrIGFuZCB4ZW4gYmxvY2sgZGV2aWNlcyBiZSByZW1vdmVkIGFuZA0KPiA+ID4gbWVyZ2VkIHZp
YSBhIGdlbmVyaWMgaGVscGVyLg0KPiA+ID4gDQo+ID4gPiBUaGlzIHNlcmllcyBjb25zaXN0cyBv
ZiA1IGNoYW5nZXMuIFRoZSBmaXJzdCBvbmUgYWRkcyB0aGUgYmFzaWMNCj4gPiA+IHN1cHBvcnQg
Zm9yIGNoYW5naW5nIHRoZSBzaXplIGFuZCBub3RpZnlpbmcuIFRoZSBmb2xsb3cgdXAgcGF0Y2hl
cw0KPiA+ID4gYXJlIHBlciBibG9jayBzdWJzeXN0ZW0gY2hhbmdlcy4gT3RoZXIgYmxvY2sgZHJp
dmVycyBjYW4gYWRkIHRoZWlyDQo+ID4gPiBjaGFuZ2VzIGFzIG5lY2Vzc2FyeSBvbiB0b3Agb2Yg
dGhpcyBzZXJpZXMuIFNpbmNlIG5vdCBhbGwgZGV2aWNlcw0KPiA+ID4gYXJlIHJlc2l6YWJsZSwg
dGhlIGRlZmF1bHQgd2FzIHRvIGFkZCBhIG5ldyBBUEkgYW5kIGxldCB1c2Vycw0KPiA+ID4gc2xv
d2x5IGNvbnZlcnQgb3ZlciBhcyBuZWVkZWQuDQo+ID4gPiANCj4gPiA+IFRlc3Rpbmc6DQo+ID4g
PiAxLiBJIGRpZCBzb21lIGJhc2ljIHRlc3Rpbmcgd2l0aCBhbiBOVk1FIGRldmljZSwgYnkgcmVz
aXppbmcgaXQgaW4NCj4gPiA+IHRoZSBiYWNrZW5kIGFuZCBlbnN1cmVkIHRoYXQgdWRldmQgcmVj
ZWl2ZWQgdGhlIGV2ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IENoYW5nZWxvZyB2MjoNCj4g
PiA+IC0gUmVuYW1lIGRpc2tfc2V0X2NhcGFjaXR5IHRvIHNldF9jYXBhY2l0eV9yZXZhbGlkYXRl
X2FuZF9ub3RpZnkNCj4gPiA+IC0gc2V0X2NhcGFjaXR5X3JldmFsaWRhdGVfYW5kX25vdGlmeSBj
YW4gY2FsbCByZXZhbGlkYXRlIGRpc2sNCj4gPiA+ICAgaWYgbmVlZGVkLCBhIG5ldyBib29sIHBh
cmFtZXRlciBpcyBwYXNzZWQgKHN1Z2dlc3RlZCBieSBCb2IgTGl1KQ0KPiA+ID4gDQo+ID4gDQo+
ID4gUGluZz8gSXQncyBub3QgYW4gdXJnZW50IHBhdGNoc2V0LCBJIGFtIGhhcHB5IHRvIHdhaXQg
aWYgbm90aGluZyBlbHNlIGlzDQo+ID4gbmVlZGVkLg0KPiANCj4gSXQgZG9lc24ndCBhcHBseSB0
byB0aGUgNS43IGJyYW5jaGVzLCBjYW4geW91IHJlc2VuZCBhZ2FpbnN0IGZvci01LjcvYmxvY2s/
DQo+IA0KDQpUaGFua3MsIEknbGwgdGFrZSBhIGxvb2suIEkgdXNlZCB0aGUgbGF0ZXN0IG5leHQg
KG5leHQtMjAyMDAzMTIpIGFuZCByZWJhc2VkDQpvbiBpdC4gSSBnb3QgYSB0aHJlZSB3YXkgbWVy
Z2Ugc3VjY2VzcyBvbiB4ZW4tYmxrZnJvbnQNCg0KVXNpbmcgaW5kZXggaW5mbyB0byByZWNvbnN0
cnVjdCBhIGJhc2UgdHJlZS4uLg0KTSAgICAgICBkcml2ZXJzL2Jsb2NrL3hlbi1ibGtmcm9udC5j
DQpGYWxsaW5nIGJhY2sgdG8gcGF0Y2hpbmcgYmFzZSBhbmQgMy13YXkgbWVyZ2UuLi4NCg0KSSBw
cmVzdW1lIHlvdSBhcmUgcnVubmluZyBpbnRvIHRoZSBzYW1lIHRoaW5nLg0KDQpJIHdpbGwgcmVz
ZW5kIHRoZSBwYXRjaGVzIG9uIHRvcCBvZiBuZXh0IHNob3J0bHkNCg0KQmFsYmlyDQoNCg==
