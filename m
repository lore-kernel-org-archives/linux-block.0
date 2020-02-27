Return-Path: <SRS0=eQE1=4P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A28CC3F2CB
	for <linux-block@archiver.kernel.org>; Thu, 27 Feb 2020 22:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7B0246A3
	for <linux-block@archiver.kernel.org>; Thu, 27 Feb 2020 22:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="unt1eg+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgB0Wbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:31:31 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61228 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgB0Wbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Feb 2020 17:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582842691; x=1614378691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uObpfsJDmihVgZnzlDTj5o7Ywc3QNpzXPVckbbWnw74=;
  b=unt1eg+wtc0sCRUCkdl16CWjH1yF7/y8ThQyBLuIssPG1eg2AG7E6052
   bZ3yzIO6xemldupFDWEnVRqXsbE58tbgxpGxkccE6CiczAmYRahxNxAeH
   Es5FqgvzIyTItKuIDoyQG+G99YiHNu3k0F4eYMqXBokYC/D2a0UKmGB/P
   Q=;
IronPort-SDR: 5/rXP3wl4rOgsS34VYNAVuM5/ZludsOJikxutjMaTDc4GLRYE+pwdC2N/WRzkPzOtDqMJia7vV
 TeVdZvDejueg==
X-IronPort-AV: E=Sophos;i="5.70,493,1574121600"; 
   d="scan'208";a="19601107"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Feb 2020 22:31:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 883CF2880B2;
        Thu, 27 Feb 2020 22:31:23 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 27 Feb 2020 22:31:22 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Feb 2020 22:31:22 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 27 Feb 2020 22:31:22 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2 4/5] drivers/nvme/host/core.c: Convert to use
 set_capacity_revalidate_and_notify
Thread-Topic: [PATCH v2 4/5] drivers/nvme/host/core.c: Convert to use
 set_capacity_revalidate_and_notify
Thread-Index: AQHV7BZmVG7GS2zvD0eE2vmktqMGT6gtx0WAgAHb04A=
Date:   Thu, 27 Feb 2020 22:31:22 +0000
Message-ID: <1ed561abb467362b8ddf7949882b42e00d583a20.camel@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
         <20200225200129.6687-5-sblbir@amazon.com>
         <20200226180819.GA23813@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200226180819.GA23813@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBCA5387B812CE4B8DC82CCF484CAAFC@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTI3IGF0IDAzOjA4ICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gVHVlLCBGZWIgMjUsIDIwMjAgYXQgMDg6MDE6MjhQTSArMDAwMCwgQmFsYmlyIFNpbmdoIHdy
b3RlOg0KPiA+IGJsb2NrL2dlbmhkIHByb3ZpZGVzIHNldF9jYXBhY2l0eV9yZXZhbGlkYXRlX2Fu
ZF9ub3RpZnkoKSBmb3INCj4gPiBzZW5kaW5nIFJFU0laRSBub3RpZmljYXRpb25zIHZpYSB1ZXZl
bnRzLiBUaGlzIG5vdGlmaWNhdGlvbiBpcw0KPiA+IG5ld2x5IGFkZGVkIHRvIE5WTUUgZGV2aWNl
cw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5j
b20+DQo+IA0KPiBQYXRjaCBsb29rcyBmaW5lLiBQbGVhc2UgY2hhbmdlIHRoZSBjb21taXQgc3Vi
amVjdCBwcmVmaXggdG8ganVzdCAibnZtZToiDQo+IHRvIG1hdGNoIHRoZSBsb2NhbCBzdHlsZSBh
bmQgZm9yIGxlbmd0aCBjb25zdHJhaW50cyAodGhlIGNvbW1pdHRlciBtYXkNCj4gZG8gdGhpcyBp
ZiB0aGV5IHdhbnQpLg0KPiANCj4gQWNrZWQtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVs
Lm9yZz4NCg0KU3VyZSB0aGFua3MhIFllcywgdGhhdCBtYWtlcyBzZW5zZS4NCg0KQmFsYmlyIFNp
bmdoLg0K
