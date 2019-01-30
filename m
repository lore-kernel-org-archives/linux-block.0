Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FCC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89521473
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oa8t/X5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfA3PKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:10:45 -0500
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:45184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfA3PKp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCjQpwtmb9lxjDv6t+MekMSpE58/bWDAiLNYsGxb680=;
 b=oa8t/X5J5v5KVsFbnG12FfuSaeR8yg7bGKOeM80+/pcAOcmg8N9Mv1sxGgFosm2yf+p0nzSwESDbCd09yMEAxuJ6gO4qjvxAnyPH+th/PlmtZXk9iIYG7ZzwmRApH/4oQ1Fhk9W+T2Ff9cEz2HYMg+Fqqp0v2+TP9yxbwXK1ZNg=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3632.namprd12.prod.outlook.com (20.178.243.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 15:10:29 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:10:29 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Joerg Roedel <joro@8bytes.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jfehlig@suse.com" <jfehlig@suse.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Thread-Topic: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Thread-Index: AQHUt677Jk4fk5o5Fke87yAomV3Fp6XH7H0A
Date:   Wed, 30 Jan 2019 15:10:29 +0000
Message-ID: <e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
References: <20190129084342.26030-1-joro@8bytes.org>
 <20190129084342.26030-5-joro@8bytes.org>
In-Reply-To: <20190129084342.26030-5-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0064.namprd05.prod.outlook.com
 (2603:10b6:803:41::41) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3632;20:HaJDKAazBdY5rtUYVKQxWcMGns92D89cn3ff7vIMOPvd8jv6GGtsMDtsdEacEhknPtjTeqztj09xC4Gk74NVrwMZ0+pdv2zJ4O/VpEYppHOuwE38HnbsSqZ99Bz1RR1/seEkPshOsU6OiIrjYtHhex5o0CKGbL/tAEb4uTkVRBBK1Bane/paIJ74MLvzZ/GChDkOy7yAR1vbPLrj79nDqIZ0Cls7MV7CX2ZnrUsNVmdwQbSAJ7KoCMP/XqWZp6WO
x-ms-office365-filtering-correlation-id: 3de963d8-90a2-428a-9267-08d686c5122d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3632;
x-ms-traffictypediagnostic: MN2PR12MB3632:
x-microsoft-antispam-prvs: <MN2PR12MB3632B929356D465D30EA758BEC900@MN2PR12MB3632.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(31696002)(6512007)(86362001)(31686004)(6116002)(53936002)(486006)(6246003)(6486002)(6436002)(7736002)(71190400001)(476003)(446003)(4326008)(68736007)(66066001)(2616005)(3846002)(106356001)(99286004)(11346002)(14444005)(36756003)(305945005)(97736004)(71200400001)(256004)(105586002)(229853002)(25786009)(6506007)(110136005)(26005)(76176011)(478600001)(386003)(72206003)(53546011)(54906003)(52116002)(8676002)(81166006)(8936002)(14454004)(2906002)(81156014)(186003)(316002)(7416002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3632;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YOtyxEPgMJ18LFne7XurXhNKqS8n9N0emsRbbBczamqyUVYcMIGdHzA6lpUI5BANtUiEQC740cy68nL3qVFGi+d+ujTlpZvzXwMgeya78+vz2QjajXqAFl7X0ge6V0Tmz5cKUHK+hUsrfibGHRsYuP6Tq7bArpqBFM3bNn/D9inP46T6EA7cHKfcDF/u4tJ2aKQ6GN9GViTrasqMXptszCg/n3LC8f5SwMk5CaMaRwKuNQml15MSmIRvgRUJRAxIjPQW9y6xa8m0hz/inHQVOuwpxmBWGyFPjk7lWIZQHFrfasJEtibJBTnVe3nqhVXWiTpsmvQvM678LQn2AhSKpDC8WhvlPNt+VIbyrGsJgJEMgDv4YVpyKNZsmbVf4D+QQhw0EkO8cNMywBA9iSqNx1NGS0Bgb1f2EEyDbRQ/mFI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBE9E75945572C4BBDAC4F17E791DBD8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de963d8-90a2-428a-9267-08d686c5122d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:10:28.2273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3632
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yOS8xOSAyOjQzIEFNLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+IEZyb206IEpvZXJnIFJv
ZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gVGhpcyBmdW5jdGlvbiByZXR1cm5zIHRoZSBt
YXhpbXVtIHNlZ21lbnQgc2l6ZSBmb3IgYSBzaW5nbGUNCj4gZG1hIHRyYW5zYWN0aW9uIG9mIGEg
dmlydGlvIGRldmljZS4gVGhlIHBvc3NpYmxlIGxpbWl0IGNvbWVzDQo+IGZyb20gdGhlIFNXSU9U
TEIgaW1wbGVtZW50YXRpb24gaW4gdGhlIExpbnV4IGtlcm5lbCwgdGhhdA0KPiBoYXMgYW4gdXBw
ZXIgbGltaXQgb2YgKGN1cnJlbnRseSkgMjU2a2Igb2YgY29udGlndW91cw0KPiBtZW1vcnkgaXQg
Y2FuIG1hcC4gT3RoZXIgRE1BLUFQSSBpbXBsZW1lbnRhdGlvbnMgbWlnaHQgYWxzbw0KPiBoYXZl
IGxpbWl0cy4NCj4gDQo+IFVzZSB0aGUgbmV3IGRtYV9tYXhfbWFwcGluZ19zaXplKCkgZnVuY3Rp
b24gdG8gZGV0ZXJtaW5lIHRoZQ0KPiBtYXhpbXVtIG1hcHBpbmcgc2l6ZSB3aGVuIERNQS1BUEkg
aXMgaW4gdXNlIGZvciB2aXJ0aW8uDQo+IA0KPiBSZXZpZXdlZC1ieTogS29ucmFkIFJ6ZXN6dXRl
ayBXaWxrIDxrb25yYWQud2lsa0BvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VyZyBS
b2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgMTAgKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8
ICAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYw0KPiBpbmRleCBjZDdlNzU1NDg0ZTMuLjljYTNmZTZhZjlmYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0KPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jDQo+IEBAIC0yNjYsNiArMjY2LDE2IEBAIHN0YXRpYyBib29sIHZyaW5n
X3VzZV9kbWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiAgCXJldHVybiBmYWxz
ZTsNCj4gIH0NCj4gIA0KPiArc2l6ZV90IHZpcnRpb19tYXhfZG1hX3NpemUoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpDQo+ICt7DQo+ICsJc2l6ZV90IG1heF9zZWdtZW50X3NpemUgPSBTSVpF
X01BWDsNCj4gKw0KPiArCWlmICh2cmluZ191c2VfZG1hX2FwaSh2ZGV2KSkNCj4gKwkJbWF4X3Nl
Z21lbnRfc2l6ZSA9IGRtYV9tYXhfbWFwcGluZ19zaXplKCZ2ZGV2LT5kZXYpOw0KPiArDQo+ICsJ
cmV0dXJuIG1heF9zZWdtZW50X3NpemU7DQo+ICt9DQoNCldoZW4gSSBidWlsZCB3aXRoIHRoZXNl
IHBhdGNoZXMgYW5kIHdpdGggdGhlIHZpcnRpbyBkZXZpY2VzIGFzIG1vZHVsZXMgSQ0KZ2V0IGEg
YnVpbGQgZmFpbHVyZS4gTG9va3MgbGlrZSB0aGlzIG5lZWRzIGFuIEVYUE9SVF9TWU1CT0xfR1BM
KCkuDQoNClRoYW5rcywNClRvbQ0KDQo+ICsNCj4gIHN0YXRpYyB2b2lkICp2cmluZ19hbGxvY19x
dWV1ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgc2l6ZV90IHNpemUsDQo+ICAJCQkgICAg
ICBkbWFfYWRkcl90ICpkbWFfaGFuZGxlLCBnZnBfdCBmbGFnKQ0KPiAgew0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgNCj4gaW5k
ZXggZmExYjVkYTI4MDRlLi42NzNmZTNlZjM2MDcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdmlydGlvLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaA0KPiBAQCAtMTU3LDYg
KzE1Nyw4IEBAIGludCB2aXJ0aW9fZGV2aWNlX2ZyZWV6ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAq
ZGV2KTsNCj4gIGludCB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KmRldik7DQo+ICAjZW5kaWYNCj4gIA0KPiArc2l6ZV90IHZpcnRpb19tYXhfZG1hX3NpemUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpOw0KPiArDQo+ICAjZGVmaW5lIHZpcnRpb19kZXZpY2Vf
Zm9yX2VhY2hfdnEodmRldiwgdnEpIFwNCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHZxLCAmdmRl
di0+dnFzLCBsaXN0KQ0KPiAgDQo+IA0K
