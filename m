Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE98C282D8
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915C020989
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f74xczSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfA3PJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:09:37 -0500
Received: from mail-eopbgr680071.outbound.protection.outlook.com ([40.107.68.71]:39968
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729203AbfA3PJg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IPWLcW/t188ThKVQN0x38tCMjcAGeDzbsnMAiTJHDA=;
 b=f74xczSsxMJNIq1wbMdjoCSzsB4yd9n4BuK8HF7Llv6mNalKGT9dd8NZl1J48sR3m3Q1mRiFGXbc4kkoc/efany1ZwaiUDtTPPeUV9fPJbXY5U1xaVi8JHhHbDQn6uxLk1NvG+fOdLP8/u5LT39FesNFop1BdVjSkYNcmlAzYqY=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3232.namprd12.prod.outlook.com (20.179.82.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Wed, 30 Jan 2019 15:09:34 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:09:34 +0000
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
Subject: Re: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Thread-Topic: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Thread-Index: AQHUt67EIYwmAcLd10+T+UeE6WZPWKXH7DsA
Date:   Wed, 30 Jan 2019 15:09:33 +0000
Message-ID: <b1d5f903-e1c4-de50-7957-35597cc93a1e@amd.com>
References: <20190129084342.26030-1-joro@8bytes.org>
 <20190129084342.26030-4-joro@8bytes.org>
In-Reply-To: <20190129084342.26030-4-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0043.namprd05.prod.outlook.com
 (2603:10b6:803:41::20) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3232;20:mX8Ifu8FHC10xEK1eyP7XSYGjheK0jVv/60sGLd/+xb/EvDUarlG3nDtVd64XZVsOvJ9HVG9E/H8T8XV93loHILjbaIv3Upyoqiu98LecPrOlYRpalYAPOk6CGM8PF7krmxD6Y8jSqtWQ8/w+8ay7NemlbrBWzVipppxRuogfeeRyWZFssmgQYZLjYsTOwmHl5CYDvcIm1VdJ6IkTVZ5NkfEmJniCluDJRROJTo+HA/3jFuB5G52rOyh/zKx+GZy
x-ms-office365-filtering-correlation-id: c832f9a0-9c71-4cf8-5450-08d686c4f109
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3232;
x-ms-traffictypediagnostic: MN2PR12MB3232:
x-microsoft-antispam-prvs: <MN2PR12MB32327100DDFAEA5856B0D260EC900@MN2PR12MB3232.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(2616005)(53546011)(102836004)(25786009)(6506007)(6116002)(386003)(3846002)(6246003)(26005)(6512007)(81156014)(81166006)(4326008)(8676002)(99286004)(52116002)(31686004)(106356001)(105586002)(6436002)(76176011)(68736007)(8936002)(446003)(72206003)(11346002)(486006)(229853002)(6486002)(476003)(186003)(2906002)(53936002)(478600001)(97736004)(256004)(14444005)(316002)(86362001)(14454004)(36756003)(66066001)(110136005)(71200400001)(54906003)(7736002)(7416002)(31696002)(305945005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3232;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gSJCTQvqh72qzFkcSPLmg09UDacuIYr2JD0HvCKkUXW2hKcQ+5Ry/mGgTlU5Z1acLKPjuCGnVcw3lqWofdckSavD0+aFLYfU5KiRqg1cwdu1733wm8gk2CV/30gSdgPe7bPQOaq2RhRaR7kIjieMyJv7Pe2aur7miiuFrhZjMmJumFarJjnXFEraxgh4st8nqrsr4Xf8KgO2F7kw/qB48GLt2x0fVpoO16aU5tW/zS35m1nwroHJbAQ1pNgUtRfKAPzukV1rBAKUarhpea+ZpCRjRya2F0nN/OobXkindVMUjgMuty9k+aeJG+o+S5zXN8rLMvmR+dVrWrt8k5bthBmGMQy6prJ2p71y0g/D95AGMBAB1QcSmXY2KTK/sHEIELi1EA+qAG89M2nO4qXotzc0tSWHP79yuDPwHNul6x4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA2108D0538EC9438671C91F8C3DF4C0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c832f9a0-9c71-4cf8-5450-08d686c4f109
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:09:32.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yOS8xOSAyOjQzIEFNLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+IEZyb206IEpvZXJnIFJv
ZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gVGhlIGZ1bmN0aW9uIHJldHVybnMgdGhlIG1h
eGltdW0gc2l6ZSB0aGF0IGNhbiBiZSBtYXBwZWQNCj4gdXNpbmcgRE1BLUFQSSBmdW5jdGlvbnMu
IFRoZSBwYXRjaCBhbHNvIGFkZHMgdGhlDQo+IGltcGxlbWVudGF0aW9uIGZvciBkaXJlY3QgRE1B
IGFuZCBhIG5ldyBkbWFfbWFwX29wcyBwb2ludGVyDQo+IHNvIHRoYXQgb3RoZXIgaW1wbGVtZW50
YXRpb25zIGNhbiBleHBvc2UgdGhlaXIgbGltaXQuDQo+IA0KPiBSZXZpZXdlZC1ieTogS29ucmFk
IFJ6ZXN6dXRlayBXaWxrIDxrb25yYWQud2lsa0BvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9u
L0RNQS1BUEkudHh0ICAgfCAgOCArKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9kbWEtbWFwcGlu
Zy5oIHwgMTYgKysrKysrKysrKysrKysrKw0KPiAga2VybmVsL2RtYS9kaXJlY3QuYyAgICAgICAg
IHwgMTEgKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vRE1BLUFQSS50eHQgYi9Eb2N1bWVudGF0
aW9uL0RNQS1BUEkudHh0DQo+IGluZGV4IGUxMzNjY2Q2MDIyOC4uYWNmZTNkMGY3OGQxIDEwMDY0
NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL0RNQS1BUEkudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vRE1BLUFQSS50eHQNCj4gQEAgLTE5NSw2ICsxOTUsMTQgQEAgUmVxdWVzdGluZyB0aGUgcmVx
dWlyZWQgbWFzayBkb2VzIG5vdCBhbHRlciB0aGUgY3VycmVudCBtYXNrLiAgSWYgeW91DQo+ICB3
aXNoIHRvIHRha2UgYWR2YW50YWdlIG9mIGl0LCB5b3Ugc2hvdWxkIGlzc3VlIGEgZG1hX3NldF9t
YXNrKCkNCj4gIGNhbGwgdG8gc2V0IHRoZSBtYXNrIHRvIHRoZSB2YWx1ZSByZXR1cm5lZC4NCj4g
IA0KPiArOjoNCj4gKw0KPiArCXNpemVfdA0KPiArCWRtYV9kaXJlY3RfbWF4X21hcHBpbmdfc2l6
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArDQo+ICtSZXR1cm5zIHRoZSBtYXhpbXVtIHNpemUg
b2YgYSBtYXBwaW5nIGZvciB0aGUgZGV2aWNlLiBUaGUgc2l6ZSBwYXJhbWV0ZXINCj4gK29mIHRo
ZSBtYXBwaW5nIGZ1bmN0aW9ucyBsaWtlIGRtYV9tYXBfc2luZ2xlKCksIGRtYV9tYXBfcGFnZSgp
IGFuZA0KPiArb3RoZXJzIHNob3VsZCBub3QgYmUgbGFyZ2VyIHRoYW4gdGhlIHJldHVybmVkIHZh
bHVlLg0KPiAgDQo+ICBQYXJ0IElkIC0gU3RyZWFtaW5nIERNQSBtYXBwaW5ncw0KPiAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZG1hLW1hcHBpbmcuaCBiL2luY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaA0KPiBpbmRleCBmNmRl
ZDk5MmMxODMuLmEzY2E4YTcxYTcwNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEt
bWFwcGluZy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaA0KPiBAQCAtMTMw
LDYgKzEzMCw3IEBAIHN0cnVjdCBkbWFfbWFwX29wcyB7DQo+ICAJCQllbnVtIGRtYV9kYXRhX2Rp
cmVjdGlvbiBkaXJlY3Rpb24pOw0KPiAgCWludCAoKmRtYV9zdXBwb3J0ZWQpKHN0cnVjdCBkZXZp
Y2UgKmRldiwgdTY0IG1hc2spOw0KPiAgCXU2NCAoKmdldF9yZXF1aXJlZF9tYXNrKShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpOw0KPiArCXNpemVfdCAoKm1heF9tYXBwaW5nX3NpemUpKHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5lIERNQV9NQVBQSU5HX0VSUk9SCQkofihk
bWFfYWRkcl90KTApDQo+IEBAIC0yNTcsNiArMjU4LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGRt
YV9kaXJlY3Rfc3luY19zZ19mb3JfY3B1KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gIH0NCj4gICNl
bmRpZg0KPiAgDQo+ICtzaXplX3QgZG1hX2RpcmVjdF9tYXhfbWFwcGluZ19zaXplKHN0cnVjdCBk
ZXZpY2UgKmRldik7DQo+ICsNCj4gICNpZmRlZiBDT05GSUdfSEFTX0RNQQ0KPiAgI2luY2x1ZGUg
PGFzbS9kbWEtbWFwcGluZy5oPg0KPiAgDQo+IEBAIC00NDAsNiArNDQzLDE5IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGRtYV9tYXBwaW5nX2Vycm9yKHN0cnVjdCBkZXZpY2UgKmRldiwgZG1hX2FkZHJf
dCBkbWFfYWRkcikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSBz
aXplX3QgZG1hX21heF9tYXBwaW5nX3NpemUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiAr
CWNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqb3BzID0gZ2V0X2RtYV9vcHMoZGV2KTsNCj4gKwlz
aXplX3Qgc2l6ZSA9IFNJWkVfTUFYOw0KPiArDQo+ICsJaWYgKGRtYV9pc19kaXJlY3Qob3BzKSkN
Cj4gKwkJc2l6ZSA9IGRtYV9kaXJlY3RfbWF4X21hcHBpbmdfc2l6ZShkZXYpOw0KPiArCWVsc2Ug
aWYgKG9wcyAmJiBvcHMtPm1heF9tYXBwaW5nX3NpemUpDQo+ICsJCXNpemUgPSBvcHMtPm1heF9t
YXBwaW5nX3NpemUoZGV2KTsNCj4gKw0KPiArCXJldHVybiBzaXplOw0KPiArfQ0KPiArDQo+ICB2
b2lkICpkbWFfYWxsb2NfYXR0cnMoc3RydWN0IGRldmljZSAqZGV2LCBzaXplX3Qgc2l6ZSwgZG1h
X2FkZHJfdCAqZG1hX2hhbmRsZSwNCj4gIAkJZ2ZwX3QgZmxhZywgdW5zaWduZWQgbG9uZyBhdHRy
cyk7DQo+ICB2b2lkIGRtYV9mcmVlX2F0dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwgc2l6ZV90IHNp
emUsIHZvaWQgKmNwdV9hZGRyLA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9kaXJlY3QuYyBi
L2tlcm5lbC9kbWEvZGlyZWN0LmMNCj4gaW5kZXggMzU1ZDE2YWNlZTZkLi42MzEwYWQwMWY5MTUg
MTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9kbWEvZGlyZWN0LmMNCj4gKysrIGIva2VybmVsL2RtYS9k
aXJlY3QuYw0KPiBAQCAtMzgwLDMgKzM4MCwxNCBAQCBpbnQgZG1hX2RpcmVjdF9zdXBwb3J0ZWQo
c3RydWN0IGRldmljZSAqZGV2LCB1NjQgbWFzaykNCj4gIAkgKi8NCj4gIAlyZXR1cm4gbWFzayA+
PSBfX3BoeXNfdG9fZG1hKGRldiwgbWluX21hc2spOw0KPiAgfQ0KPiArDQo+ICtzaXplX3QgZG1h
X2RpcmVjdF9tYXhfbWFwcGluZ19zaXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlz
aXplX3Qgc2l6ZSA9IFNJWkVfTUFYOw0KPiArDQo+ICsJLyogSWYgU1dJT1RMQiBpcyBhY3RpdmUs
IHVzZSBpdHMgbWF4aW11bSBtYXBwaW5nIHNpemUgKi8NCj4gKwlpZiAoaXNfc3dpb3RsYl9hY3Rp
dmUoKSkNCj4gKwkJc2l6ZSA9IHN3aW90bGJfbWF4X21hcHBpbmdfc2l6ZShkZXYpOw0KPiArDQo+
ICsJcmV0dXJuIHNpemU7DQo+ICt9DQoNCldoZW4gSSBidWlsZCB3aXRoIHRoZXNlIHBhdGNoZXMg
YW5kIHdpdGggdGhlIHZpcnRpbyBkZXZpY2VzIGFzIG1vZHVsZXMgSQ0KZ2V0IGEgYnVpbGQgZmFp
bHVyZS4gTG9va3MgbGlrZSB0aGlzIG5lZWRzIGFuIEVYUE9SVF9TWU1CT0woKSAoSSdtDQphc3N1
bWluZyBFWFBPUlRfU1lNQk9MIGZvciBETUEgZnVuY3Rpb25zIGFuZCBub3QgRVhQT1JUX1NZTUJP
TF9HUEw/KS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo=
