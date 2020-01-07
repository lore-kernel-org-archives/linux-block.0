Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C1C282DD
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 22:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA92206DB
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 22:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q6/aPnnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgAGW2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:28:43 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56292 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgAGW2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 17:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578436122; x=1609972122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LRlH58C5d9znngWjy3uFjBYUUg3z1df7ROpFmuAf/5I=;
  b=Q6/aPnnxSPTPnSfAD99eyG+MjbhfASL9H/FxhnVHsfPRudgRXOZDKHhi
   unltp/QlHC3iwC2NU9fpk1L9y689Rne6usDbPTRFgnZk/zEI38LBpUPiR
   RjKabfMFZ0xW2L2EUtxeQ8lzMhLtvgu2qqD6kA8YGTn3xAu+6SVrYqIzq
   4=;
IronPort-SDR: AuEZdKRYI4+iXdoh0i3w2sfARMEul7xPeRcjEbLLek8onVu1cfXFFoT3v42WGaiCke9l94gYS5
 IjN8tJYTPPEA==
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; 
   d="scan'208";a="8909129"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jan 2020 22:28:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 88523A2269;
        Tue,  7 Jan 2020 22:28:30 +0000 (UTC)
Received: from EX13D11UWB002.ant.amazon.com (10.43.161.20) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 22:28:29 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB002.ant.amazon.com (10.43.161.20) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 22:28:29 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 7 Jan 2020 22:28:29 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVxQ2ElvRRrRbcTUG70jpk0aWGbqffyXeA
Date:   Tue, 7 Jan 2020 22:28:29 +0000
Message-ID: <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
In-Reply-To: <yq1blrg2agh.fsf@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.109]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A767107664C5A648B65DC44D45C2A332@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDIyOjQ4IC0wNTAwLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3Jv
dGU6DQo+IEJhbGJpciwNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zZC5jIGIv
ZHJpdmVycy9zY3NpL3NkLmMNCj4gPiBpbmRleCA1YWZiMDA0NmIxMmEuLjFhM2JlMzBiNmI3OCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Njc2kvc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc2Nz
aS9zZC5jDQo+ID4gQEAgLTMxODQsNyArMzE4NCw3IEBAIHN0YXRpYyBpbnQgc2RfcmV2YWxpZGF0
ZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQ0KPiA+ICANCj4gPiAgCXNka3AtPmZpcnN0X3Nj
YW4gPSAwOw0KPiA+ICANCj4gPiAtCXNldF9jYXBhY2l0eShkaXNrLCBsb2dpY2FsX3RvX3NlY3Rv
cnMoc2RwLCBzZGtwLT5jYXBhY2l0eSkpOw0KPiA+ICsJZGlza19zZXRfY2FwYWNpdHkoZGlzaywg
bG9naWNhbF90b19zZWN0b3JzKHNkcCwgc2RrcC0+Y2FwYWNpdHkpKTsNCj4gPiAgCXNkX2NvbmZp
Z193cml0ZV9zYW1lKHNka3ApOw0KPiA+ICAJa2ZyZWUoYnVmZmVyKTsNCj4gDQo+IFdlIGFscmVh
ZHkgZW1pdCBhbiBTREVWX0VWVF9DQVBBQ0lUWV9DSEFOR0VfUkVQT1JURUQgZXZlbnQgaWYgZGV2
aWNlDQo+IGNhcGFjaXR5IGNoYW5nZXMuIEhvd2V2ZXIsIHRoaXMgZXZlbnQgZG9lcyBub3QgYXV0
b21hdGljYWxseSBjYXVzZQ0KPiByZXZhbGlkYXRpb24uDQo+IA0KDQpUaGUgcHJvcG9zZWQgaWRl
YSBpcyB0byBub3QgcmVpbmZvcmNlIHJldmFsaWRhdGlvbiwgdW5sZXNzIGV4cGxpY3RseSBzcGVj
aWZpZWQNCihpbiB0aGUgdGhyZWFkIGJlZm9yZSBCb2IgTGl1IGhhZCBzdWdnZXN0aW9ucykuIFRo
ZSBnb2FsIGlzIHRvIG5vdGlmeSB1c2VyDQpzcGFjZSBvZiBjaGFuZ2VzIHZpYSBSRVNJWkUuIFND
U0kgc2QgY2FuIG9wdCBvdXQgb2YgdGhpcyBJT1csIEkgY2FuIHJlbW92ZQ0KdGhpcyBpZiB5b3Ug
ZmVlbCBTREVWX0VWVF9DQVBBQ0lUWV9DSEFOR0VfUkVQT1JURUQgaXMgc3VmZmljaWVudCBmb3Ig
Y3VycmVudA0KdXNlIGNhc2VzLg0KDQpCYWxiaXIgU2luZ2guDQo=
