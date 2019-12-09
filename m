Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A32C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C1420726
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SLSmAy21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLIJqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:46:33 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:53393 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfLIJqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 04:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575884791; x=1607420791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4cIuMxtJH4KZz9+iT3cGj9msbb3a41ZVBSEqjbz+WdA=;
  b=SLSmAy21f7mrEWjW9itUQV8+9DQ0hLws3fPikioviEZLyvl3edlFONHo
   vTGW2nvmhYTYZrBbD9mDQA6/I2l19jIhUQQwV2PHp5Zl3zwE2F3p9vy1j
   Y7wO7ZL1sHjA8ZYZtjEgvpI9r5om25ius/wJDG7D57OLMDwwGjoRVCRLd
   8=;
IronPort-SDR: arqHB+twrTT98tJnLn4AETwVom5+UNCEXWZoX+SoypLJ7tOeZxnXbkSGFvksFQPtNgtDUfSYSt
 G+F8qhe4JlUg==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="8224098"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 09 Dec 2019 09:46:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 963E2A22A5;
        Mon,  9 Dec 2019 09:46:27 +0000 (UTC)
Received: from EX13D31EUB001.ant.amazon.com (10.43.166.210) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 09:46:26 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 09:46:25 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 09:46:25 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "Park, Seongjae" <sjpark@amazon.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: RE: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
 pressure
Thread-Topic: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
 pressure
Thread-Index: AQHVrm7tNfXN4zMxAE2n5qoiVkODNaexjBwAgAABEcA=
Date:   Mon, 9 Dec 2019 09:46:25 +0000
Message-ID: <026ba79524da43648371e5bca437a5e4@EX13D32EUC003.ant.amazon.com>
References: <20191209085839.21215-1-sjpark@amazon.com>
 <954f7beb-9d40-253e-260b-4750809bf808@suse.com>
In-Reply-To: <954f7beb-9d40-253e-260b-4750809bf808@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKw7xyZ2VuIEdyb8OfIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMTkgMDk6MzkNCj4gVG86IFBhcmss
IFNlb25namFlIDxzanBhcmtAYW1hem9uLmNvbT47IGF4Ym9lQGtlcm5lbC5kazsNCj4ga29ucmFk
LndpbGtAb3JhY2xlLmNvbTsgcm9nZXIucGF1QGNpdHJpeC5jb20NCj4gQ2M6IGxpbnV4LWJsb2Nr
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRHVycmFudCwN
Cj4gUGF1bCA8cGR1cnJhbnRAYW1hem9uLmNvbT47IHNqMzgucGFya0BnbWFpbC5jb207IHhlbi0N
Cj4gZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAw
LzFdIHhlbi9ibGtiYWNrOiBTcXVlZXplIHBhZ2UgcG9vbHMgaWYgYSBtZW1vcnkNCj4gcHJlc3N1
cmUNCj4gDQo+IE9uIDA5LjEyLjE5IDA5OjU4LCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0KPiA+IEVh
Y2ggYGJsa2lmYCBoYXMgYSBmcmVlIHBhZ2VzIHBvb2wgZm9yIHRoZSBncmFudCBtYXBwaW5nLiAg
VGhlIHNpemUgb2YNCj4gPiB0aGUgcG9vbCBzdGFydHMgZnJvbSB6ZXJvIGFuZCBiZSBpbmNyZWFz
ZWQgb24gZGVtYW5kIHdoaWxlIHByb2Nlc3NpbmcNCj4gPiB0aGUgSS9PIHJlcXVlc3RzLiAgSWYg
Y3VycmVudCBJL08gcmVxdWVzdHMgaGFuZGxpbmcgaXMgZmluaXNoZWQgb3IgMTAwDQo+ID4gbWls
bGlzZWNvbmRzIGhhcyBwYXNzZWQgc2luY2UgbGFzdCBJL08gcmVxdWVzdHMgaGFuZGxpbmcsIGl0
IGNoZWNrcyBhbmQNCj4gPiBzaHJpbmtzIHRoZSBwb29sIHRvIG5vdCBleGNlZWQgdGhlIHNpemUg
bGltaXQsIGBtYXhfYnVmZmVyX3BhZ2VzYC4NCj4gPg0KPiA+IFRoZXJlZm9yZSwgYGJsa2Zyb250
YCBydW5uaW5nIGd1ZXN0cyBjYW4gY2F1c2UgYSBtZW1vcnkgcHJlc3N1cmUgaW4gdGhlDQo+ID4g
YGJsa2JhY2tgIHJ1bm5pbmcgZ3Vlc3QgYnkgYXR0YWNoaW5nIGEgbGFyZ2UgbnVtYmVyIG9mIGJs
b2NrIGRldmljZXMgYW5kDQo+ID4gaW5kdWNpbmcgSS9PLg0KPiANCj4gSSdtIGhhdmluZyBwcm9i
bGVtcyB0byB1bmRlcnN0YW5kIGhvdyBhIGd1ZXN0IGNhbiBhdHRhY2ggYSBsYXJnZSBudW1iZXIN
Cj4gb2YgYmxvY2sgZGV2aWNlcyB3aXRob3V0IHRob3NlIGhhdmluZyBiZWVuIGNvbmZpZ3VyZWQg
YnkgdGhlIGhvc3QgYWRtaW4NCj4gYmVmb3JlLg0KPiANCj4gSWYgdGhvc2UgZGV2aWNlcyBoYXZl
IGJlZW4gY29uZmlndXJlZCwgZG9tMCBzaG91bGQgYmUgcmVhZHkgZm9yIHRoYXQNCj4gbnVtYmVy
IG9mIGRldmljZXMsIGUuZy4gYnkgaGF2aW5nIGVub3VnaCBzcGFyZSBtZW1vcnkgYXJlYSBmb3Ig
YmFsbG9vbmVkDQo+IHBhZ2VzLg0KPiANCj4gU28gZWl0aGVyIEknbSBtaXNzaW5nIHNvbWV0aGlu
ZyBoZXJlIG9yIHlvdXIgcmVhc29uaW5nIGZvciB0aGUgbmVlZCBvZg0KPiB0aGUgcGF0Y2ggaXMg
d3JvbmcuDQo+IA0KDQpJIHRoaW5rIHRoZSB1bmRlcmx5aW5nIGlzc3VlIGlzIHRoYXQgcGVyc2lz
dGVudCBncmFudCBzdXBwb3J0IGlzIGhvZ2dpbmcgbWVtb3J5IGluIHRoZSBiYWNrZW5kcywgdGhl
cmVieSBjb21wcm9taXNpbmcgc2NhbGFiaWxpdHkuIElJVUMgdGhpcyBwYXRjaCBpcyBlc3NlbnRp
YWxseSBhIGJhbmQtYWlkIHRvIGdldCBiYWNrIHRvIHRoZSBzY2FsYWJpbGl0eSB0aGF0IHdhcyBw
b3NzaWJsZSBiZWZvcmUgcGVyc2lzdGVudCBncmFudCBzdXBwb3J0IHdhcyBhZGRlZC4gVWx0aW1h
dGVseSB0aGUgcmlnaHQgYW5zd2VyIHNob3VsZCBiZSB0byBnZXQgcmlkIG9mIHBlcnNpc3RlbnQg
Z3JhbnRzIHN1cHBvcnQgYW5kIHVzZSBncmFudCBjb3B5LCBidXQgc3VjaCBhIGNoYW5nZSBpcyBj
bGVhcmx5IG1vcmUgaW52YXNpdmUgYW5kIHdvdWxkIG5lZWQgZmFyIG1vcmUgdGVzdGluZy4NCg0K
ICBQYXVsDQo=
