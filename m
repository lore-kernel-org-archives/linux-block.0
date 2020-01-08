Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C593EC33C9B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 04:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B02206ED
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 04:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B8KiHxhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAHEVB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:21:01 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:65168 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAHEVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 23:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578457260; x=1609993260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1OsGcmReV23Ns6GEgxqF7Tm8toBm55M9+IgR0xNKyJU=;
  b=B8KiHxhdIvrDa8zwzxDoMtFDk++njbfiW+AjDLEcyslNgr/ceuSRJnFB
   FEVnHGt3+GxTpXgVmX5UZyKwdkI7BE+zFo9fTcM8jr8dmYegU3a/LXELf
   3Pacslo5b1KXLv0NZYU5DOyupSkElvktXDRKwEoCPfzZLYjb/zXMshmDL
   4=;
IronPort-SDR: O9+rmpiBNrQLSNLXnnHli6sgP7fkp9EhZwkgMxdTlPKlb++pPwaEIpuS+xjUwJfxdKThtdQNJT
 iDWqxIE4i9pw==
X-IronPort-AV: E=Sophos;i="5.69,408,1571702400"; 
   d="scan'208";a="8967941"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 08 Jan 2020 04:20:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 86B8DA243D;
        Wed,  8 Jan 2020 04:20:48 +0000 (UTC)
Received: from EX13D11UWB004.ant.amazon.com (10.43.161.90) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 8 Jan 2020 04:20:48 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB004.ant.amazon.com (10.43.161.90) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 8 Jan 2020 04:20:48 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Wed, 8 Jan 2020 04:20:47 +0000
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
Thread-Index: AQHVxdHPlvRRrRbcTUG70jpk0aWGbqfgKlyA
Date:   Wed, 8 Jan 2020 04:20:47 +0000
Message-ID: <e88e18fcd77243f7af39081b3b15aed3d2a1e674.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com>     <yq1blrg2agh.fsf@oracle.com>
         <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
         <yq1blre1vwr.fsf@oracle.com>
In-Reply-To: <yq1blre1vwr.fsf@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.119]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF6FE334C78AC4F8FA46091ED182175@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTA3IGF0IDIyOjE1IC0wNTAwLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3Jv
dGU6DQo+IEJhbGJpciwNCj4gDQo+ID4gPiBXZSBhbHJlYWR5IGVtaXQgYW4gU0RFVl9FVlRfQ0FQ
QUNJVFlfQ0hBTkdFX1JFUE9SVEVEIGV2ZW50IGlmIGRldmljZQ0KPiA+ID4gY2FwYWNpdHkgY2hh
bmdlcy4gSG93ZXZlciwgdGhpcyBldmVudCBkb2VzIG5vdCBhdXRvbWF0aWNhbGx5IGNhdXNlDQo+
ID4gPiByZXZhbGlkYXRpb24uDQo+ID4gDQo+ID4gVGhlIHByb3Bvc2VkIGlkZWEgaXMgdG8gbm90
IHJlaW5mb3JjZSByZXZhbGlkYXRpb24sIHVubGVzcyBleHBsaWN0bHkNCj4gPiBzcGVjaWZpZWQg
KGluIHRoZSB0aHJlYWQgYmVmb3JlIEJvYiBMaXUgaGFkIHN1Z2dlc3Rpb25zKS4gVGhlIGdvYWwg
aXMNCj4gPiB0byBub3RpZnkgdXNlciBzcGFjZSBvZiBjaGFuZ2VzIHZpYSBSRVNJWkUuIFNDU0kg
c2QgY2FuIG9wdCBvdXQgb2YNCj4gPiB0aGlzIElPVywgSSBjYW4gcmVtb3ZlIHRoaXMgaWYgeW91
IGZlZWwNCj4gPiBTREVWX0VWVF9DQVBBQ0lUWV9DSEFOR0VfUkVQT1JURUQgaXMgc3VmZmljaWVu
dCBmb3IgY3VycmVudCB1c2UgY2FzZXMuDQo+IA0KPiBJIGhhdmUgbm8gcGFydGljdWxhciBvYmpl
Y3Rpb24gdG8gdGhlIGNvZGUgY2hhbmdlLiBJIHdhcyBqdXN0IG9ic2VydmluZw0KPiB0aGF0IGlu
IHRoZSBjb250ZXh0IG9mIHNkLmMsIFJFU0laRT0xIGlzIG1vcmUgb2YgYSAieW91ciByZXF1ZXN0
IHRvDQo+IHJlc2l6ZSB3YXMgc3VjY2Vzc2Z1bCIgbm90aWZpY2F0aW9uIGR1ZSB0byB0aGUgcmVx
dWlyZW1lbnQgb2YgYW4NCj4gZXhwbGljaXQgdXNlcmxhbmQgYWN0aW9uIGluIGNhc2UgYSBkZXZp
Y2UgcmVwb3J0cyBhIGNhcGFjaXR5IGNoYW5nZS4NCj4gDQoNClRoYXQgaXMgdHJ1ZSwgeWVzIEkg
YWdyZWUgd2l0aCB5b3VyIG9ic2VydmF0aW9uLg0KDQpCYWxiaXIgU2luZ2guDQo=
