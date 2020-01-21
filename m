Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAAAC2D0CE
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6924655
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 19:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HA7b8DlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAUT5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:57:23 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:46319 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUT5X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 14:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579636643; x=1611172643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2AM9PR3Tvgu7t+SfNKaHveu2VLV9169Zlv+ZZ4N0qpA=;
  b=HA7b8DlPnUOmZA9DIOUODnU04DHXGby0dzXoe2753OOaWi1TJwRZ+jLX
   4X19yilgzzGP6frkWBbM33gBK7JXzkfp1P/VALClm+ep10yZEbP3CFWa3
   5DINg/eE5D3kHFDvY/1dMa7Xg+/g9J8HZCjvJ2i3zbbP2atohPwsvJWAS
   w=;
IronPort-SDR: lY544I0KRAUsk4zKrPAMJmf3DphIrhLymowpbI89rShMVyOxxuTd5Dv3rwxoF3PoPih7muUPU3
 ObTngVwRiScA==
X-IronPort-AV: E=Sophos;i="5.70,347,1574121600"; 
   d="scan'208";a="14090811"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 21 Jan 2020 19:57:23 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id DF83CA2743;
        Tue, 21 Jan 2020 19:57:19 +0000 (UTC)
Received: from EX13D11UWB004.ant.amazon.com (10.43.161.90) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Jan 2020 19:57:19 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB004.ant.amazon.com (10.43.161.90) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Jan 2020 19:57:19 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 21 Jan 2020 19:57:19 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVxdHjydawp/BwQkuXvP0PUEOjWqfg3jQAgBTAIAA=
Date:   Tue, 21 Jan 2020 19:57:18 +0000
Message-ID: <a1a36b7163c10fd6c9450ba631f26b9ce23dc3f7.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-2-sblbir@amazon.com> <yq1ftgs2b6g.fsf@oracle.com>
         <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com>
         <yq17e221vvt.fsf@oracle.com> <20200108150428.GB10975@lst.de>
In-Reply-To: <20200108150428.GB10975@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB767E631009EE4F8B8589D586BA62FF@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTA4IGF0IDE2OjA0ICswMTAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBUdWUsIEphbiAwNywgMjAyMCBhdCAxMDoxNTozNFBNIC0wNTAwLCBNYXJ0aW4gSy4gUGV0ZXJz
ZW4gd3JvdGU6DQo+ID4gDQo+ID4gQmFsYmlyLA0KPiA+IA0KPiA+ID4gSSBkaWQgdGhpcyB0byBh
dm9pZCBoYXZpbmcgdG8gZW5mb3JjZSB0aGF0IHNldF9jYXBhY2l0eSgpIGltcGxpZWQgYQ0KPiA+
ID4gbm90aWZpY2F0aW9uLiBMYXJnZWx5IHRvIGNvbnRyb2wgdGhlIGltcGFjdCBvZiB0aGUgY2hh
bmdlIGJ5IGRlZmF1bHQuDQo+ID4gDQo+ID4gV2hhdCBJIHRob3VnaHQuIEknbSBPSyB3aXRoIHNl
dF9jYXBhY2l0eV9hbmRfbm90aWZ5KCksIGJ0dy4NCj4gDQo+IFRvIHNvbWUgZXh0ZW50IGl0IG1p
Z2h0IG1ha2Ugc2Vuc2UgdG8gYWx3YXlzIG5vdGlmeSBmcm9tIHNldF9jYXBhY2l0eQ0KPiBhbmQg
aGF2ZSBhIHNldF9jYXBhY2l0eV9ub25vdGlmeSBpZiB3ZSBkb24ndCB3YW50IHRvIG5vdGlmeSwg
YXMgaW4NCj4gZ2VuZXJhbCB3ZSBwcm9iYWJseSBzaG91bGQgbm90aWZ5IHVubGVzcyB3ZSBoYXZl
IGEgZ29vZCByZWFzb24gbm90IHRvLg0KDQpJIGFtIG5vdCBzdXJlIGlmIHRoaXMgaXMgdGhlIHJp
Z2h0IHBhdGgsIHNpbmNlIHdpdGggdGhlIG5ldyBpbnRlcmZhY2UsIHdlJ2xsDQpub3cgaGF2ZSBy
ZXZhbGlkYXRlIGRpc2sgYml0cyBidWlsdCBpbnRvIHRoZSBmdW5jdGlvbiAoc2VlIHRoZSBjb21t
ZW50cyBmcm9tDQpCb2IgZWFybGllcikuIEknZCBiZSBoYXBwaWVyIGNvbnZlcnRpbmcgaW50ZXJm
YWNlcyBhIGZldyBhdCBhIHRpbWUsIEEgcXVpY2sNCmdyZXAgZm91bmQgb3ZlciAxMDAgcmVmZXJl
bmNlcyBhbmQgSSBhbSBub3QgZXZlbiBzdXJlIGhvdyBtYW55IG9mIHRoZW0gYXJlDQpyZXNpemFi
bGUgd2l0aG91dCBob3RwbHVnIGluL291dCBvbiB0aGUgZmx5LiBIZW5jZSwgSSBsaW1pdGVkIG15
c2VsZiB0byB0aGUNCnNtYWxsIHN1YnNldCwgSSBjb3VsZCBjb25zaWRlciBleHBhbmRpbmcgaXQg
bGF0ZXIgYmFzZWQgb24gdGhlIG5lZWQgYW5kIHRoZWlyDQphYmlsaXR5IHRvIHJlc2l6ZSBvbiB0
aGUgZmx5DQoNCkJhbGJpciBTaW5naC4NCg==
