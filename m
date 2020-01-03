Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB84C3276C
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC47222C3
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 00:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Len6NRcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgACAX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:23:26 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22838 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgACAX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 19:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578011005; x=1609547005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nxNZvIi52VletypUSupLtShqS3EDyEFQMmbPqmMqXZ8=;
  b=Len6NRcYs5P89q6NJqy93mJuNU0xp/onldrQAYhkRJ4CyGXTx2Wcsnmh
   VO6mvahvCgLolsagBPuJmHI2TABQezBvRKfIIY+hztsbDJITaCB7RnPI1
   CXCiggL1A7JJCxf+xXhwqkNrexR8BtDYkYXpmDGi0mT160UmzoUF6Sq/a
   k=;
IronPort-SDR: OD7PnJDvlniTzMV0V0Hj/1cIoEAOJpJQCZL8f6Wz3oOiOrbnPC9FRXpTKY/XKr6gCm4ZubRc2I
 ys6RXunBn6JA==
X-IronPort-AV: E=Sophos;i="5.69,388,1571702400"; 
   d="scan'208";a="17920676"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Jan 2020 00:23:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id C518EA209A;
        Fri,  3 Jan 2020 00:23:11 +0000 (UTC)
Received: from EX13D11UWB001.ant.amazon.com (10.43.161.53) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 Jan 2020 00:23:11 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB001.ant.amazon.com (10.43.161.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 Jan 2020 00:23:10 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Fri, 3 Jan 2020 00:23:10 +0000
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
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVwUG2bzD2dJjWXU+Xwn7M8hFup6fYFXCA
Date:   Fri, 3 Jan 2020 00:23:10 +0000
Message-ID: <804eef7a517fb93f5bdc3986515bb8f2b845681f.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com>
         <BYAPR04MB57496B5D29688B7DA14F53DB86200@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB57496B5D29688B7DA14F53DB86200@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02240C7601AC7C4CA288FB856F429E7A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTAyIGF0IDIyOjIxICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+IE9uIDAxLzAxLzIwMjAgMTE6NTMgUE0sIEJhbGJpciBTaW5naCB3cm90ZToNCj4gPiBi
bG9jay9nZW5oZCBwcm92aWRlcyBkaXNrX3NldF9jYXBhY2l0eSgpIGZvciBzZW5kaW5nDQo+ID4g
UkVTSVpFIG5vdGlmaWNhdGlvbnMgdmlhIHVldmVudHMuIFRoaXMgbm90aWZpY2F0aW9uIGlzDQo+
ID4gbmV3bHkgYWRkZWQgdG8gc2NzaSBzZC4NCj4gDQo+IG5pdCA6LQ0KPiANCj4gVGhlIGFib3Zl
IGNvbW1pdCBtZXNzYWdlcyBpbiB0aGlzIHNlcmllcyBhcmUgbG9va2luZyBvZGQgZnJvbQ0KPiB0
aGUgb25lcyB3ZSBoYXZlIGluIHRoZSB0cmVlIGFuZCBpcyBpdCBwb3NzaWJsZSB0byBmb2xkIGl0
IGluDQo+IHR3byBsaW5lcyA/DQo+IA0KPiBbQ2FuIGJlIGRvbmUgYXQgdGhlIHRpbWUgb2YgYXBw
bHlpbmcgc2VyaWVzLl0NCj4gDQoNClNvdW5kcyBnb29kISBJJ2xsIHJlcXVlc3QgdGhlIG1haW50
YWluZXIgb3IgcmVwb3N0IGlmIG5lZWRlZA0KDQpCYWxiaXIgU2luZ2guDQo=
