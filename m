Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8F7C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 18:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BA720869
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 18:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0xU2lmPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfA3SLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:11:51 -0500
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:18560
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbfA3SLv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 13:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeWUr+BCYE5PHWPj7LUB49o9micBH0IgntWY9SBkY1U=;
 b=0xU2lmPRbsjWuAAb8gDP7mHhEW1dniwI4L1dnTiQwYzXt2wTU6Ua8wICyjNXDyrJq5CsoQhTez5SLH0wsdzA8vsfzwGWiv5gJdRS/iimXWBiFV3kEy1dR6Asg7nvC1RjbkQ6SXO92Tpi2fak1dfzcv2jj1xihnpcPoXwSdsA7es=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3197.namprd12.prod.outlook.com (20.179.82.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Wed, 30 Jan 2019 18:11:48 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 18:11:48 +0000
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
Subject: Re: [PATCH 0/5 v5] Fix virtio-blk issue with SWIOTLB
Thread-Topic: [PATCH 0/5 v5] Fix virtio-blk issue with SWIOTLB
Thread-Index: AQHUuLp4XdaGLuJErUWEM3h2DGFIBKXIHQ+A
Date:   Wed, 30 Jan 2019 18:11:48 +0000
Message-ID: <616969d8-c03a-5d24-8112-11dd1f60dd9b@amd.com>
References: <20190130164007.26497-1-joro@8bytes.org>
In-Reply-To: <20190130164007.26497-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:805::19) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3197;20:3XdewLp5912enqVxJb88oiHTvAZ5NN99BlUkEZIvkR4ffz3aJo3FfQANYvuMEHs7o3EF7fH3YNWX5kHEwy6N6gFLPS9Qy2lPdOVsZImucYBzekJYrfERAUPO70yz/S1hd9KhpqxhSTPSkX8BRveSJ6JbsmvYC2whxj6SVTmfhmK9HSUC9ccp32o+crb9zZIbVcJWv7TPDPT5npWYkDYOH66zpvCkxf6WXLlnZg1+wKgjT7BeLgRmW+2Q/ruvhMkT
x-ms-office365-filtering-correlation-id: 5dc5abb5-3459-4d49-fbdd-08d686de66a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3197;
x-ms-traffictypediagnostic: MN2PR12MB3197:
x-microsoft-antispam-prvs: <MN2PR12MB3197713CE6686DE586B44887EC900@MN2PR12MB3197.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(186003)(14454004)(26005)(81156014)(81166006)(68736007)(72206003)(966005)(8676002)(8936002)(478600001)(76176011)(86362001)(102836004)(11346002)(446003)(476003)(2616005)(54906003)(31686004)(110136005)(53546011)(6506007)(99286004)(386003)(31696002)(52116002)(486006)(2906002)(6116002)(36756003)(229853002)(6512007)(105586002)(256004)(6306002)(316002)(6436002)(66066001)(97736004)(106356001)(6246003)(4326008)(53936002)(71190400001)(7736002)(25786009)(71200400001)(7416002)(6486002)(305945005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3197;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EopASeXef/Dg0VZV6y96krvBZqmpZZGYPbaXRkpZ/s63lXynEn2+hCQGtpxZCMlXw1Bd1iGjbm7y8/6rtLcWHLhuVnMe+LBVcjlxe4MEGlQ9t7AUkmVuU4U6F1CQSTtJ3lfNtFFaQeNHZNSrICb39ckeJkq8RUAtBMkc7yzomfXnMYWuM2UJPwdD99rfKDZ4gBwqOxtfcTJXFY63E8N0o7WpV9uUvgrXgFexHxe+JGuQFx3eRvj01g1X+4sRnyWhtf1BX4s0RDDAKhQ3NOd3kJ0n1S9y5gevrTxh1pJxQAFqvPytXkY1DSWK1N8Ie8r0XDunucF13YWZvRd7p1VLJXg9+biIzPd7tye+pX+sfmNAcL2MvvMzWDkvIhR6gBXsv+/t0ZDG7ZIMH9sJFUxvR5Do3lfcHWqNa1S571D7Elo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA468A5C6C008B43B282A2B28B182289@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc5abb5-3459-4d49-fbdd-08d686de66a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 18:11:47.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3197
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8zMC8xOSAxMDo0MCBBTSwgSm9lcmcgUm9lZGVsIHdyb3RlOg0KPiBIaSwNCj4gDQo+IGhl
cmUgaXMgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLXNldC4gUHJldmlvdXMNCj4gdmVy
c2lvbnMgY2FuIGJlIGZvdW5kIGhlcmU6DQo+IA0KPiAJVjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAxOTAxMTAxMzQ0MzMuMTU2NzItMS1qb3JvQDhieXRlcy5vcmcvDQo+IA0KPiAJ
VjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTAxMTUxMzIyNTcuNjQyNi0xLWpv
cm9AOGJ5dGVzLm9yZy8NCj4gDQo+IAlWMzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDE5MDEyMzE2MzA0OS4yNDg2My0xLWpvcm9AOGJ5dGVzLm9yZy8NCj4gDQo+IAlWNDogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDEyOTA4NDM0Mi4yNjAzMC0xLWpvcm9AOGJ5dGVz
Lm9yZy8NCj4gDQo+IFRoZSBwcm9ibGVtIHNvbHZlZCBoZXJlIGlzIGEgbGltaXRhdGlvbiBvZiB0
aGUgU1dJT1RMQiBpbXBsZW1lbnRhdGlvbiwNCj4gd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCBhbGxv
Y2F0aW9ucyBsYXJnZXIgdGhhbiAyNTZrYi4gIFdoZW4gdGhlDQo+IHZpcnRpby1ibGsgZHJpdmVy
IHRyaWVzIHRvIHJlYWQvd3JpdGUgYSBibG9jayBsYXJnZXIgdGhhbiB0aGF0LCB0aGUNCj4gYWxs
b2NhdGlvbiBvZiB0aGUgZG1hLWhhbmRsZSBmYWlscyBhbmQgYW4gSU8gZXJyb3IgaXMgcmVwb3J0
ZWQuDQo+IA0KPiBDaGFuZ2VzIHRvIHY0IGFyZToNCj4gDQo+IAktIEFkZGVkIFJldmlld2VkLWJ5
IHRhZ3MgZnJvbSBDaHJpc3RvcGgNCj4gDQo+IAktIEFkZGVkIG1pc3NpbmcgRVhQT1JUX1NZTUJP
TChfR1BMKSBsaW5lcw0KPiANCj4gUGxlYXNlIHJldmlldy4NCg0KTG9va3MgZ29vZC4gQm9vdGVk
IGFuZCB0ZXN0ZWQgdXNpbmcgYW4gU0VWIGd1ZXN0IHdpdGhvdXQgYW55IGlzc3Vlcy4NCg0KVGVz
dGVkLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KDQpUaGFua3Ms
DQpUb20NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCUpvZXJnDQo+IEpvZXJnIFJvZWRlbCAoNSk6
DQo+ICAgc3dpb3RsYjogSW50cm9kdWNlIHN3aW90bGJfbWF4X21hcHBpbmdfc2l6ZSgpDQo+ICAg
c3dpb3RsYjogQWRkIGlzX3N3aW90bGJfYWN0aXZlKCkgZnVuY3Rpb24NCj4gICBkbWE6IEludHJv
ZHVjZSBkbWFfbWF4X21hcHBpbmdfc2l6ZSgpDQo+ICAgdmlydGlvOiBJbnRyb2R1Y2UgdmlydGlv
X21heF9kbWFfc2l6ZSgpDQo+ICAgdmlydGlvLWJsazogQ29uc2lkZXIgdmlydGlvX21heF9kbWFf
c2l6ZSgpIGZvciBtYXhpbXVtIHNlZ21lbnQgc2l6ZQ0KPiANCj4gIERvY3VtZW50YXRpb24vRE1B
LUFQSS50eHQgICAgfCAgOCArKysrKysrKw0KPiAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMg
ICB8IDEwICsrKysrKy0tLS0NCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMSAr
KysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oICB8IDE2ICsrKysrKysr
KysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvc3dpb3RsYi5oICAgICAgfCAxMSArKysrKysrKysr
Kw0KPiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAyICsrDQo+ICBrZXJuZWwvZG1h
L2RpcmVjdC5jICAgICAgICAgIHwgMTIgKysrKysrKysrKysrDQo+ICBrZXJuZWwvZG1hL3N3aW90
bGIuYyAgICAgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4gIDggZmlsZXMgY2hhbmdlZCwgODAg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo=
