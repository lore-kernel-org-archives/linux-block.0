Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDEDC43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4202C2073C
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hEeAN2yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfLDLwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:52:20 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:9659 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfLDLwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 06:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575460340; x=1606996340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=subuGb31/4BvlNMMaELIqppLGL3pCYIbeSsP2T2kb6A=;
  b=hEeAN2ygpC7HruauDTdiiera0rHtIJ6J5vazyQ2MS8qde9TO5w8uvGPZ
   sQbCKMTkWZlLdcIrQO1Kr96DBNnrVacJP6BRpwMn/EWUhk4c+4ZplaeeU
   PyH0Wy5gOKo1+o+TSfAuByb49SMmwFtqjIHsL/pUgWqeEx9rSnwZIA/IV
   A=;
IronPort-SDR: LPDeFf1hwrW5njIZKDQ/+xU+QNaLygCTTCMyzbeIsa9VPg1AuD/U2+aBjxtQo+fnYgCQuqFEV2
 QED0WsNMtctw==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="3133749"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 04 Dec 2019 11:52:07 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 9B588A25D4;
        Wed,  4 Dec 2019 11:52:06 +0000 (UTC)
Received: from EX13D31EUA003.ant.amazon.com (10.43.165.95) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:52:06 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D31EUA003.ant.amazon.com (10.43.165.95) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:52:04 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Wed, 4 Dec 2019 11:52:04 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     "Park, Seongjae" <sjpark@amazon.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Park, Seongjae" <sjpark@amazon.com>
Subject: RE: [Xen-devel] [PATCH 0/2] xen/blkback: Aggressively shrink page
 pools if a memory pressure is detected
Thread-Topic: [Xen-devel] [PATCH 0/2] xen/blkback: Aggressively shrink page
 pools if a memory pressure is detected
Thread-Index: AQHVqpcoosgr7ogcY0K6hF0oa7O7wqep3Ncw
Date:   Wed, 4 Dec 2019 11:52:04 +0000
Message-ID: <62c68f53cc0145ad9d0dfb167b50eac4@EX13D32EUC003.ant.amazon.com>
References: <20191204113419.2298-1-sjpark@amazon.com>
In-Reply-To: <20191204113419.2298-1-sjpark@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.177]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYZW4tZGV2ZWwgPHhlbi1kZXZl
bC1ib3VuY2VzQGxpc3RzLnhlbnByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YNCj4gU2VvbmdKYWUg
UGFyaw0KPiBTZW50OiAwNCBEZWNlbWJlciAyMDE5IDExOjM0DQo+IFRvOiBrb25yYWQud2lsa0Bv
cmFjbGUuY29tOyByb2dlci5wYXVAY2l0cml4LmNvbTsgYXhib2VAa2VybmVsLmRrDQo+IENjOiBz
ajM4LnBhcmtAZ21haWwuY29tOyB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7IGxpbnV4
LQ0KPiBibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFBhcmssIFNlb25namFlDQo+IDxzanBhcmtAYW1hem9uLmNvbT4NCj4gU3ViamVjdDogW1hlbi1k
ZXZlbF0gW1BBVENIIDAvMl0geGVuL2Jsa2JhY2s6IEFnZ3Jlc3NpdmVseSBzaHJpbmsgcGFnZQ0K
PiBwb29scyBpZiBhIG1lbW9yeSBwcmVzc3VyZSBpcyBkZXRlY3RlZA0KPiANCj4gRWFjaCBgYmxr
aWZgIGhhcyBhIGZyZWUgcGFnZXMgcG9vbCBmb3IgdGhlIGdyYW50IG1hcHBpbmcuICBUaGUgc2l6
ZSBvZg0KPiB0aGUgcG9vbCBzdGFydHMgZnJvbSB6ZXJvIGFuZCBiZSBpbmNyZWFzZWQgb24gZGVt
YW5kIHdoaWxlIHByb2Nlc3NpbmcNCj4gdGhlIEkvTyByZXF1ZXN0cy4gIElmIGN1cnJlbnQgSS9P
IHJlcXVlc3RzIGhhbmRsaW5nIGlzIGZpbmlzaGVkIG9yIDEwMA0KPiBtaWxsaXNlY29uZHMgaGFz
IHBhc3NlZCBzaW5jZSBsYXN0IEkvTyByZXF1ZXN0cyBoYW5kbGluZywgaXQgY2hlY2tzIGFuZA0K
PiBzaHJpbmtzIHRoZSBwb29sIHRvIG5vdCBleGNlZWQgdGhlIHNpemUgbGltaXQsIGBtYXhfYnVm
ZmVyX3BhZ2VzYC4NCj4gDQo+IFRoZXJlZm9yZSwgYGJsa2Zyb250YCBydW5uaW5nIGd1ZXN0cyBj
YW4gY2F1c2UgYSBtZW1vcnkgcHJlc3N1cmUgaW4gdGhlDQo+IGBibGtiYWNrYCBydW5uaW5nIGd1
ZXN0IGJ5IGF0dGFjaGluZyBhcmJpdHJhcmlseSBsYXJnZSBudW1iZXIgb2YgYmxvY2sNCj4gZGV2
aWNlcyBhbmQgaW5kdWNpbmcgSS9PLg0KDQpPT0kuLi4gSG93IGRvIGd1ZXN0cyB1bmlsYXRlcmFs
bHkgY2F1c2UgdGhlIGF0dGFjaG1lbnQgb2YgYXJiaXRyYXJ5IG51bWJlcnMgb2YgUFYgZGV2aWNl
cz8NCg0KICBQYXVsDQoNCg==
