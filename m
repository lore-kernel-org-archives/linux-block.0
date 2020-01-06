Return-Path: <SRS0=PDkS=23=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220CDC00523
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 00:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B692072C
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 00:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LYPwCLxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAFAqo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jan 2020 19:46:44 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:13184 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFAqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jan 2020 19:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578271604; x=1609807604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nm1HPLZ/VpXMl1rLxnlZl6cpUugevRClIBZqy2h1HHY=;
  b=LYPwCLxgV0ljFa8Yn0MvyccWhtE7RoKMbaZabLpmh7nkXXDHBcwvxLC+
   N1cxg86wlGBy4VzatBVrc0rw3n4ftyhA7c/D42Xrp7yAwRw379CQcafKM
   H2byuKHBHXvQCwcvMFNvmtSmJx0UKRWAUXknrNOFUKZoqnSY4V6jKXBOS
   Q=;
IronPort-SDR: mP9tPbE7gNPbslPChUuDQUv3q5kWneKRt1xJ5Ul5rKiNjptAkUCHBrrVMXtgfjYNLC0ld1s6Tr
 yS6oCCP0FIXg==
X-IronPort-AV: E=Sophos;i="5.69,400,1571702400"; 
   d="scan'208";a="16874826"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Jan 2020 00:46:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 000F72497BB;
        Mon,  6 Jan 2020 00:46:27 +0000 (UTC)
Received: from EX13D11UWB001.ant.amazon.com (10.43.161.53) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 Jan 2020 00:46:27 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB001.ant.amazon.com (10.43.161.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 Jan 2020 00:46:27 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Mon, 6 Jan 2020 00:46:26 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVwUG1iZmE8Pm/G0CenFe4gZ349afc0u0A
Date:   Mon, 6 Jan 2020 00:46:26 +0000
Message-ID: <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-5-sblbir@amazon.com>
         <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <50ECDC6CF5780E44B2534B78D9303263@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gU2F0LCAyMDIwLTAxLTA0IGF0IDIyOjI3ICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+IFF1aWNrIHF1ZXN0aW9uIGhlcmUgaWYgdXNlciBleGVjdXRlcyBudm1lIG5zLXJlc2Nh
biAvZGV2L252bWUxDQo+IHdpbGwgZm9sbG93aW5nIGNvZGUgcmVzdWx0IGluIHRyaWdnZXJpbmcg
dWV2ZW50KHMpIGZvcg0KPiB0aGUgbmFtZXNwYWNlKHMoIGZvciB3aGljaCB0aGVyZSBpcyBubyBj
aGFuZ2UgaW4gdGhlIHNpemUgPw0KPiANCj4gSWYgc28gaXMgdGhhdCBhbiBleHBlY3RlZCBiZWhh
dmlvciA/DQo+IA0KDQpNeSBvbGQgY29kZSBoYWQgYSBjaGVjayB0byBzZWUgaWYgb2xkX2NhcGFj
aXR5ICE9IG5ld19jYXBhY2l0eSBhcyB3ZWxsLg0KSSBjYW4gcmVkbyB0aG9zZSBiaXRzIGlmIG5l
ZWRlZC4NCg0KVGhlIGV4cGVjdGVkIGJlaGF2aW91ciBpcyBub3QgY2xlYXIsIGJ1dCB0aGUgZnVu
Y3Rpb25hbGl0eSBpcyBub3QgYnJva2VuLCB1c2VyDQpzcGFjZSBzaG91bGQgYmUgYWJsZSB0byBk
ZWFsIHdpdGggYSByZXNpemUgZXZlbnQgd2hlcmUgdGhlIHByZXZpb3VzIGNhcGFjaXR5DQo9PSBu
ZXcgY2FwYWNpdHkgSU1ITy4NCg0KQmFsYmlyIFNpbmdoLg0KDQoNCj4gT24gMDEvMDEvMjAyMCAx
MTo1NCBQTSwgQmFsYmlyIFNpbmdoIHdyb3RlOg0KPiA+IGJsb2NrL2dlbmhkIHByb3ZpZGVzIGRp
c2tfc2V0X2NhcGFjaXR5KCkgZm9yIHNlbmRpbmcNCj4gPiBSRVNJWkUgbm90aWZpY2F0aW9ucyB2
aWEgdWV2ZW50cy4gVGhpcyBub3RpZmljYXRpb24gaXMNCj4gPiBuZXdseSBhZGRlZCB0byBOVk1F
IGRldmljZXMNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWxiaXIgU2luZ2ggPHNibGJpckBh
bWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgMiAr
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYw0KPiA+IGluZGV4IDY2N2YxOGY0NjViZS4uY2IyMTRlOTE0ZmMyIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+IEBAIC0xODA4LDcgKzE4MDgsNyBAQCBzdGF0aWMgdm9p
ZCBudm1lX3VwZGF0ZV9kaXNrX2luZm8oc3RydWN0IGdlbmRpc2sNCj4gPiAqZGlzaywNCj4gPiAg
IAkgICAgbnMtPmxiYV9zaGlmdCA+IFBBR0VfU0hJRlQpDQo+ID4gICAJCWNhcGFjaXR5ID0gMDsN
Cj4gPiANCj4gPiAtCXNldF9jYXBhY2l0eShkaXNrLCBjYXBhY2l0eSk7DQo+ID4gKwlkaXNrX3Nl
dF9jYXBhY2l0eShkaXNrLCBjYXBhY2l0eSk7DQoNCg0KPiA+IA0KPiA+ICAgCW52bWVfY29uZmln
X2Rpc2NhcmQoZGlzaywgbnMpOw0KPiA+ICAgCW52bWVfY29uZmlnX3dyaXRlX3plcm9lcyhkaXNr
LCBucyk7DQo+ID4gDQo+IA0KPiANCg==
