Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48DCC43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC88206B7
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rSB5Dtes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfANTKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:10:04 -0500
Received: from mail-eopbgr700051.outbound.protection.outlook.com ([40.107.70.51]:39840
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfANTKE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 14:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fvInwuFURrRZ0Bo4JK8m338ucZgHrI57VpfumCKE5g=;
 b=rSB5DtesCkNvmRC4hpH5kjpeFid+2JZKZX5GwfVNPS4EyIBevA//SEDmrnLzXKXLxsjr82l3Vgf8vVKexWk05+TKdhX+6WU4UXSwNu5K7z2uIjorAl6amUVgW81fiUQiQmnvY2PiaEVf53TqBkJ+vOLjE+ho9kanLt4lymMJI6Y=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3531.namprd12.prod.outlook.com (20.179.106.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Mon, 14 Jan 2019 19:09:21 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::10bf:617c:4515:4ad2]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::10bf:617c:4515:4ad2%2]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 19:09:21 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jfehlig@suse.com" <jfehlig@suse.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Thread-Topic: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Thread-Index: AQHUqOqihHxlw0AWx0aoCF210KZLPKWpaeWAgABgiQCABL6DAIAAAkMAgAAv8YCAAF7AgIAADY4A
Date:   Mon, 14 Jan 2019 19:09:20 +0000
Message-ID: <b0dad138-cc87-9e51-9303-f29696e68385@amd.com>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
 <20190114131114-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190114131114-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0072.namprd12.prod.outlook.com
 (2603:10b6:802:20::43) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3531;20:M5ClJ67lv8vYY2YaueA5OkXWA35+iLEvwGM9LXKoHqdMK2uM1QYAaSgG9BtE+VS5KM+RGR0lKBw3znzVyybwr9pabT75nSKXvuL4dHtxTDjn5CyLoRW/yOWXTPhli+RpVzUxZwJh/AG2GmlGiJWMY4LVXjlKLNyEL4++ceZed+uU5OtWQ2EET6MrZLSD36X9WDkjBZI1fY1X9E8NJh+LKR2VoacJcBkDqs+et7ZNZPsdFiT9j2u8P1z17oNzzOrS
x-ms-office365-filtering-correlation-id: b9c661e3-1829-48d9-9954-08d67a53c9d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3531;
x-ms-traffictypediagnostic: DM6PR12MB3531:
x-microsoft-antispam-prvs: <DM6PR12MB35315AA2B84C25CF02E46843E5800@DM6PR12MB3531.namprd12.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(478600001)(68736007)(53936002)(6512007)(486006)(14444005)(256004)(106356001)(105586002)(31686004)(97736004)(6246003)(31696002)(99286004)(5660300001)(7416002)(6436002)(36756003)(4326008)(86362001)(229853002)(25786009)(2616005)(476003)(11346002)(102836004)(7736002)(76176011)(446003)(305945005)(26005)(2906002)(6116002)(8676002)(3846002)(81156014)(14454004)(71190400001)(8936002)(66066001)(81166006)(54906003)(316002)(186003)(110136005)(386003)(53546011)(6506007)(71200400001)(6486002)(93886005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3531;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: id6268mR9E8nsRP82pG8mfpBzeLtGcwTPCBMcbDIa8gtjkhUZ/BwRBCWjjWNlY/14oliPhiqpnisX3qwBltCYypa7PN5Z+2JwLI8z3SsNsa7xTXfnK6AFr8Xp3/4Oa4EADD0ZPze3zsXFZTC6gqL9VDA+cUHWDk567nZ0aMf03xg8ZKezdvLPTOEjQmq1H2sY/rsHH1nAhH5X8H+ZvY/017zw12wsjnev6slZ5XuB1yYeQNrfcZ2nJRbwIE8LfKgKzspI09VmVuOq3/fXejm0gEL2qbjw3v7mEscem+xgIFBRbZZUS9TXITW8+6/DNVjB0A3IGaolV1ryPZl3zbmwOAz9h0GAb8FPQgoYeSilg5rFg962D93vKtzpXMe/dOmhOKYveKWYSoZeAR6yP/6B4VPF29W1yIwpeEizUrTOMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EA19D22B291F445A177EDECC5289AD3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c661e3-1829-48d9-9954-08d67a53c9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 19:09:21.0269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3531
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCk9uIDEvMTQvMTkgMTI6MjAgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24g
TW9uLCBKYW4gMTQsIDIwMTkgYXQgMDg6NDE6MzdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToN
Cj4+DQo+PiBPbiAyMDE5LzEvMTQg5LiL5Y2INTo1MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
DQo+Pj4gT24gTW9uLCBKYW4gMTQsIDIwMTkgYXQgMDU6NDE6NTZQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToNCj4+Pj4gT24gMjAxOS8xLzExIOS4i+WNiDU6MTUsIEpvZXJnIFJvZWRlbCB3cm90
ZToNCj4+Pj4+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDExOjI5OjMxQU0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6DQo+Pj4+Pj4gSnVzdCB3b25kZXIgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBj
b3JyZWN0IElPTU1VX1BMQVRGT1JNIG11c3QgYmUgc2V0IGZvcg0KPj4+Pj4+IGFsbCB2aXJ0aW8g
ZGV2aWNlcyB1bmRlciBBTUQtU0VWIGd1ZXN0cz8NCj4+Pj4+IFllcywgdGhhdCBpcyBjb3JyZWN0
LiBFbXVsYXRlZCBETUEgY2FuIG9ubHkgaGFwcGVuIG9uIHRoZSBTV0lPVExCDQo+Pj4+PiBhcGVy
dHVyZSwgYmVjYXVzZSB0aGF0IG1lbW9yeSBpcyBub3QgZW5jcnlwdGVkLiBUaGUgZ3Vlc3QgYm91
bmNlcyB0aGUNCj4+Pj4+IGRhdGEgdGhlbiB0byBpdHMgZW5jcnlwdGVkIG1lbW9yeS4NCj4+Pj4+
DQo+Pj4+PiBSZWdhcmRzLA0KPj4+Pj4NCj4+Pj4+IAlKb2VyZw0KPj4+Pg0KPj4+PiBUaGFua3Ms
IGhhdmUgeW91IHRlc3RlZCB2aG9zdC1uZXQgaW4gdGhpcyBjYXNlLiBJIHN1c3BlY3QgaXQgbWF5
IG5vdCB3b3JrDQo+Pj4gV2hpY2ggYnJpbmdzIG1lIGJhY2sgdG8gbXkgcGV0IHBldmVlIHRoYXQg
d2UgbmVlZCB0byB0YWtlIGFjdGlvbnMNCj4+PiB0aGF0IHZpcnRpbyB1c2VzIHRoZSBwcm9wZXIg
ZG1hIG1hcHBpbmcgQVBJIGJ5IGRlZmF1bHQgd2l0aCBxdWlya3MNCj4+PiBmb3IgbGVnYWN5IGNh
c2VzLiAgVGhlIG1hZ2ljIGJ5cGFzcyBpdCB1c2VzIGlzIGp1c3QgY2F1c2luZyBwcm9ibGVtcw0K
Pj4+IG92ZXIgcHJvYmxlbXMuDQo+Pg0KPj4NCj4+IFllcywgSSBmdWxseSBhZ3JlZSB3aXRoIHlv
dS4gVGhpcyBpcyBwcm9iYWJseSBhbiBleGFjdCBleGFtcGxlIG9mIHN1Y2gNCj4+IHByb2JsZW0u
DQo+Pg0KPj4gVGhhbmtzDQo+IA0KPiBJIGRvbid0IHRoaW5rIHNvIC0gdGhlIGlzc3VlIGlzIHJl
YWxseSB0aGF0IERNQSBBUEkgZG9lcyBub3QgeWV0IGhhbmRsZQ0KPiB0aGUgU0VWIGNhc2UgMTAw
JSBjb3JyZWN0bHkuIEkgc3VzcGVjdCBwYXNzdGhyb3VnaCBkZXZpY2VzIHdvdWxkIGhhdmUNCj4g
dGhlIHNhbWUgaXNzdWUuDQo+IA0KDQoNCkluIGNhc2Ugb2YgU0VWLCBlbXVsYXRlZCBETUEgaXMg
cGVyZm9ybWVkIHRocm91Z2ggdGhlIFNXSU9UTEINCih3aGljaCBib3VuY2VzIHRoZSBlbmNyeXB0
ZWQgYnVmZmVycykuIFRoZSBpc3N1ZSByZXBvcnRlZCBoZXJlIHdpbGwNCmhhcHBlbiBvbiBhbnkg
cGxhdGZvcm0gd2hpY2ggaXMgbWFraW5nIHVzZSBvZiBTV0lPVExCLiBXZSBjb3VsZA0KZWFzaWx5
IHJlcHJvZHVjZSB0aGUgdGhlIHZpcnRpby1ibGsgZmFpbHVyZSBpZiB3ZSBjb25maWd1cmUNCnN3
aW90bGI9Zm9yY2UgaW4gbm9uIFNFViBndWVzdC4gVW5mb3J0dW5hdGVseSBpbiBjYXNlIG9mIFNF
ViB0aGUNClNXSU9UTEIgaXMgbXVzdC4gQXMgSm9yZ2UgaGlnaGxpZ2h0ZWQgdGhlIG1haW4gaXNz
dWUgaXMgbGltaXRhdGlvbg0Kb2YgdGhlIFNXSU9UTEIsIGl0IGRvZXMgbm90IHN1cHBvcnQgYWxs
b2NhdGlvbi9tYXAgbGFyZ2VyIHRoYW4gMjU2S2IuDQoNCg0KPiBJbiBmYWN0IHdob2V2ZXIgc2V0
cyBJT01NVV9QTEFURk9STSBpcyBjb21wbGV0ZWx5IHVuYWZmZWN0ZWQgYnkNCj4gQ2hyaXN0b3Bo
J3MgcGV0IHBlZXZlLg0KPiANCj4gQ2hyaXN0b3BoIGlzIHNheWluZyB0aGF0ICFJT01NVV9QTEFU
Rk9STSBkZXZpY2VzIHNob3VsZCBoaWRlIHRoZQ0KPiBjb21wYXRpYmlsaXR5IGNvZGUgaW4gYSBz
cGVjaWFsIHBlci1kZXZpY2UgRE1BIEFQSSBpbXBsZW1lbnRhdGlvbi4NCj4gV2hpY2ggd291bGQg
YmUgZmluZSBlc3BlY2lhbGx5IGlmIHdlIGNhbiBtYW5hZ2Ugbm90IHRvIGludHJvZHVjZSBhIGJ1
bmNoDQo+IG9mIGluZGlyZWN0IGNhbGxzIGFsbCBvdmVyIHRoZSBwbGFjZSBhbmQgaHVydCBwZXJm
b3JtYW5jZS4gIEl0J3MganVzdA0KPiB0aGF0IHRoZSBiZW5lZml0IGlzIHVubGlrZWx5IHRvIGJl
IGJpZyAoZS5nLiB3ZSBjYW4ndCBhbHNvIGdldCByaWQgb2YNCj4gdGhlIHZpcnRpbyBzcGVjaWZp
YyBtZW1vcnkgYmFycmllcnMpIHNvIG5vIG9uZSB3YXMgbW90aXZhdGVkIGVub3VnaCB0bw0KPiB3
b3JrIG9uIGl0Lg0KPiANCg==
