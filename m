Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71152C282DD
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 22:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4C6206DB
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 22:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nqItzbDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgAGWao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:30:44 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:44683 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGWao (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 17:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578436243; x=1609972243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0yu/e1APmDyrOiyqfuBQvh2sEg4lzG89R8qZG0pTiHM=;
  b=nqItzbDsoQsOzVtXGtEFDubCdrYAJ6jin95qY1R8JmUkMvnRQd2HYOe0
   pr03Bki0vB3o1Avttqjo2PIbrwcKkEAaYxjqV3TJw1jZWtXP9OTGNyeFj
   yTTGytlLuBk2EgRUR+6glkRHU+ocmCYkYhAKnFWpy6jddu0aWbjjxohfm
   A=;
IronPort-SDR: 66EUQz2oAEeoZOeuh4f8ntEX+LesIbMW+YTYwydU/0vOpC8CDUarfk2n6Yy/a3UmN3AzAZwQ0C
 egJ7V36XHmpA==
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; 
   d="scan'208";a="18687284"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 07 Jan 2020 22:30:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 59101A20F3;
        Tue,  7 Jan 2020 22:30:31 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 22:30:30 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 22:30:30 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Tue, 7 Jan 2020 22:30:30 +0000
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
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVxQslydawp/BwQkuXvP0PUEOjWqffygqA
Date:   Tue, 7 Jan 2020 22:30:30 +0000
Message-ID: <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-2-sblbir@amazon.com> <yq1ftgs2b6g.fsf@oracle.com>
In-Reply-To: <yq1ftgs2b6g.fsf@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.109]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4476106396C040A8D83784CE3F10CD@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDIyOjMyIC0wNTAwLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3Jv
dGU6DQo+IEhpIEJhbGJpciwNCj4gDQo+ID4gQWxsb3cgYmxvY2svZ2VuaGQgdG8gbm90aWZ5IHVz
ZXIgc3BhY2UgKHZpYSB1ZGV2KSBhYm91dCBkaXNrIHNpemUNCj4gPiBjaGFuZ2VzIHVzaW5nIGEg
bmV3IGhlbHBlciBkaXNrX3NldF9jYXBhY2l0eSgpLCB3aGljaCBpcyBhIHdyYXBwZXIgb24NCj4g
PiB0b3Agb2Ygc2V0X2NhcGFjaXR5KCkuIGRpc2tfc2V0X2NhcGFjaXR5KCkgd2lsbCBvbmx5IG5v
dGlmeSB2aWEgdWRldg0KPiA+IGlmIHRoZSBjdXJyZW50IGNhcGFjaXR5IG9yIHRoZSB0YXJnZXQg
Y2FwYWNpdHkgaXMgbm90IHplcm8uDQo+IA0KPiBJIGtub3cgc2V0X2NhcGFjaXR5KCkgaXMgY2Fs
bGVkIGFsbCBvdmVyIHRoZSBwbGFjZSBtYWtpbmcgaXQgYSBiaXQgb2YgYQ0KPiBwYWluIHRvIGF1
ZGl0LiBJcyB0aGF0IHRoZSByZWFzb24geW91IGludHJvZHVjZWQgYSBuZXcgZnVuY3Rpb24gaW5z
dGVhZA0KPiBvZiBqdXN0IGVtaXR0aW5nIHRoZSBldmVudCBpbiBzZXRfY2FwYWNpdHkoKT8NCj4g
DQoNCkkgZGlkIHRoaXMgdG8gYXZvaWQgaGF2aW5nIHRvIGVuZm9yY2UgdGhhdCBzZXRfY2FwYWNp
dHkoKSBpbXBsaWVkIGENCm5vdGlmaWNhdGlvbi4gTGFyZ2VseSB0byBjb250cm9sIHRoZSBpbXBh
Y3Qgb2YgdGhlIGNoYW5nZSBieSBkZWZhdWx0Lg0KDQpCYWxiaXIgU2luZ2guDQo=
