Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD53C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 14:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9626120989
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="c96fnEsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeK1BWM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:22:12 -0500
Received: from mail-eopbgr820057.outbound.protection.outlook.com ([40.107.82.57]:29719
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbeK1BWM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 20:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0wr4Nz17gzenXtzGczups9lb+mVbbsfyR732aS0AOg=;
 b=c96fnEsf8kbWYKrZsXh/IRVRk9Rl3em+YT4B61L+he6ZXf8BvssDHEtMIC/jyv06Y5wj/YbNlO3YVvQRUFNeZvi9evcS3fIHBLfC4+wxg751B2+kezc8yodd4gguvtunzz8UGrQ9AL1ADU1NQPfPGFd68mMKFXQUoTxTY1YC0Dc=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB4172.namprd06.prod.outlook.com (20.176.104.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 14:24:03 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 14:24:03 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "suhua.tanke@gmail.com" <suhua.tanke@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: adjust the position of the lock
Thread-Topic: [PATCH] lightnvm: pblk: adjust the position of the lock
Thread-Index: AQHUhfRSbN5Xcbn6ZEKx/nEy0nBdB6VjlbWAgAAXgoCAAACRVA==
Date:   Tue, 27 Nov 2018 14:24:03 +0000
Message-ID: <ACAA275B-AC2C-4147-AF88-E250771CA1DD@cnexlabs.com>
References: <20181127015309.2374-1-suhua.tanke@gmail.com>
 <F75BC3C7-FACE-4C04-A9BE-5A3AA25D3466@cnexlabs.com>,<a53eb78d-90d3-f84e-a0bf-9acbc32671f4@lightnvm.io>
In-Reply-To: <a53eb78d-90d3-f84e-a0bf-9acbc32671f4@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [77.241.133.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB4172;6:EJxZabTaVlraOryL65fJP/qFcjeqV5j/+A+LYZW7pXVD2so85PCCtFodO8rm008yuG7EqQAsudqHoZmHkOF00V3HRnwX4FkICivgiwTvVqy/AOx/7gk+XKfh9rw/GlqFuJYNMijh/KIKbGB6j5M4zQcxrHrDriImpLISqaonsl1TQ3bpLJY/gTOvS0P6m5Mtb/TpfLKSqqePe10pp/dKA7d9Jdlhq0s0qzrRV6aCJLBt5MOIl1vIhoHW5Orbpv53Uliev6SWzUmxCAOfyY4shJJtoCCkQtFpVs/TKoKHE7QOGWzv3O/yk+xwa9Gk1VYW/nJ/8OiMbz2MyHUEv4+6BGYB+XZuRxclpBAZoNJYX74AEekmpnYNGz6SWa7Oo6U+MJ/1iqqEdNTEoHeV9IxBu0pt9s/jHIVIQmADl2HqVwDlhAn9tl/OYDcPcZrPQfQ8CTUejGshHQAvLwpZayo7RA==;5:pv26ZS40HOGqV+WOnMa1+S3QbxXmb86pzStQy8aHUHC7t0JaJD/BvQEdVUzktQIyH3Ikhvt3dMQD4E3Q8hpXXgg40nvZk3CVkeRSpgAxVF2rw2CjxE1jn+1d8EN3me2ERbDOKKznrclGIHPISRxS8X1Ggncz5WsBRbO09G7OVqg=;7:hW0MFqZovysHF2mCFrepVpy3o3gNvMtNLsbDNiB491yjNoY1/0Ml80xLoyNCgsM/VJfmlQSJbWK/6fc75t5Isic+uLogV0pTD5BdW/CjJrPRPdsfqY04BtL/N1sHXhOBP/he6XJpEGjaolAWvJWFMA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4890ed8f-e33e-41ea-e0c9-08d65473fb3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR06MB4172;
x-ms-traffictypediagnostic: DM6PR06MB4172:
x-microsoft-antispam-prvs: <DM6PR06MB4172AA372C1F9AB9135D0987BAD00@DM6PR06MB4172.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB4172;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB4172;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(136003)(376002)(346002)(366004)(189003)(199004)(71200400001)(71190400001)(53546011)(6506007)(86362001)(66574009)(102836004)(36756003)(99286004)(186003)(97736004)(256004)(26005)(486006)(229853002)(2906002)(68736007)(7736002)(83716004)(76176011)(305945005)(6436002)(14444005)(6486002)(53936002)(11346002)(2616005)(6512007)(39060400002)(33656002)(316002)(476003)(54906003)(82746002)(446003)(8936002)(66066001)(14454004)(106356001)(478600001)(5660300001)(6246003)(3846002)(4326008)(6116002)(6916009)(8676002)(81156014)(81166006)(105586002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4172;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZdFnzqs/5O7a5QmPGDBn2zGClEAWk1uQLbRQxTYp6Q7eG4nKSrmDzA/iPDdZX4h3tTfemtGCfie7cERgXey8q5GIQAWLYA5ZZ5QXG+osAOMiM82lsPQYJTsWNQbxfjA3/a5mOrORWoXT1m36Wn3RW4N2eNY0HlKsstGvXeVmzoYhqic+of5pHHPXqLJ+xcmqSSmflFAEgvF4CYaKM+Vo9MSETRez9E27L4Mf4KfBTBMiXert1Dl0Z1BHgEhFlWigvWiKJifgSuhtQAaPKfJl+pZ6uSETshX5I1ZfmDtfWH9spy3CFDkV9ZGFqsfEY719Qyh7p8/ojNHhjIHFcKqeXF3exbSpFtKulwvfwFQ2oRo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4890ed8f-e33e-41ea-e0c9-08d65473fb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 14:24:03.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4172
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IE9uIDI3IE5vdiAyMDE4LCBhdCAxNS4yMiwgTWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRu
dm0uaW8+IHdyb3RlOg0KPiANCj4gT24gMTEvMjcvMjAxOCAwMTo1NyBQTSwgSmF2aWVyIEdvbnph
bGV6IHdyb3RlOg0KPj4+IE9uIDI3IE5vdiAyMDE4LCBhdCAwMi41MywgSHVhIFN1IDxzdWh1YS50
YW5rZUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEFkZCBsb2NrIHByb3RlY3Rpb24gZm9y
IGxpc3Qgb3BlcmF0aW9ucy4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBIdWEgU3UgPHN1aHVhLnRhbmtl
QGdtYWlsLmNvbT4NCj4+PiAtLS0NCj4+PiBkcml2ZXJzL2xpZ2h0bnZtL3BibGstY29yZS5jIHwg
MTcgKysrKysrKysrKy0tLS0tLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9saWdodG52
bS9wYmxrLWNvcmUuYyBiL2RyaXZlcnMvbGlnaHRudm0vcGJsay1jb3JlLmMNCj4+PiBpbmRleCA2
OTQ0YWFjNDNiMDEuLmU0OTBkZjIxN2RhYyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2xpZ2h0
bnZtL3BibGstY29yZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9saWdodG52bS9wYmxrLWNvcmUuYw0K
Pj4+IEBAIC0xMjg2LDI0ICsxMjg2LDI3IEBAIGludCBwYmxrX2xpbmVfcmVjb3ZfYWxsb2Moc3Ry
dWN0IHBibGsgKnBibGssIHN0cnVjdCBwYmxrX2xpbmUgKmxpbmUpDQo+Pj4gICAgbGlzdF9kZWwo
JmxpbmUtPmxpc3QpOw0KPj4+IA0KPj4+ICAgIHJldCA9IHBibGtfbGluZV9wcmVwYXJlKHBibGss
IGxpbmUpOw0KPj4+IC0gICAgaWYgKHJldCkgew0KPj4+IC0gICAgICAgIGxpc3RfYWRkKCZsaW5l
LT5saXN0LCAmbF9tZy0+ZnJlZV9saXN0KTsNCj4+PiAtICAgICAgICBzcGluX3VubG9jaygmbF9t
Zy0+ZnJlZV9sb2NrKTsNCj4+PiAtICAgICAgICByZXR1cm4gcmV0Ow0KPj4+IC0gICAgfQ0KPj4+
IC0gICAgc3Bpbl91bmxvY2soJmxfbWctPmZyZWVfbG9jayk7DQo+Pj4gKyAgICBpZiAocmV0KQ0K
Pj4+ICsgICAgICAgIGdvdG8gb3V0Ow0KPj4+IA0KPj4+ICAgIHJldCA9IHBibGtfbGluZV9hbGxv
Y19iaXRtYXBzKHBibGssIGxpbmUpOw0KPj4+ICAgIGlmIChyZXQpDQo+Pj4gLSAgICAgICAgcmV0
dXJuIHJldDsNCj4+PiArICAgICAgICBnb3RvIG91dDsNCj4+PiANCj4+PiAgICBpZiAoIXBibGtf
bGluZV9pbml0X2JiKHBibGssIGxpbmUsIDApKSB7DQo+Pj4gICAgICAgIGxpc3RfYWRkKCZsaW5l
LT5saXN0LCAmbF9tZy0+ZnJlZV9saXN0KTsNCj4+PiArICAgICAgICBzcGluX3VubG9jaygmbF9t
Zy0+ZnJlZV9sb2NrKTsNCj4+PiAgICAgICAgcmV0dXJuIC1FSU5UUjsNCj4+PiAgICB9DQo+Pj4g
KyAgICBzcGluX3VubG9jaygmbF9tZy0+ZnJlZV9sb2NrKTsNCj4+PiANCj4+PiAgICBwYmxrX3Js
X2ZyZWVfbGluZXNfZGVjKCZwYmxrLT5ybCwgbGluZSwgdHJ1ZSk7DQo+Pj4gICAgcmV0dXJuIDA7
DQo+Pj4gKw0KPj4+ICtvdXQ6DQo+Pj4gKyAgICBsaXN0X2FkZCgmbGluZS0+bGlzdCwgJmxfbWct
PmZyZWVfbGlzdCk7DQo+Pj4gKyAgICBzcGluX3VubG9jaygmbF9tZy0+ZnJlZV9sb2NrKTsNCj4+
PiArICAgIHJldHVybiByZXQ7DQo+Pj4gfQ0KPj4+IA0KPj4+IHZvaWQgcGJsa19saW5lX3JlY292
X2Nsb3NlKHN0cnVjdCBwYmxrICpwYmxrLCBzdHJ1Y3QgcGJsa19saW5lICpsaW5lKQ0KPj4+IC0t
DQo+Pj4gMi4xOS4xDQo+PiBUaGlzIHBhdGggaXMgb25seSB0b3VjaGVkIGJ5IHRoZSByZWNvdmVy
eSBwYXRoLCB3aGljaCBpcyBzaW5nbGUNCj4+IHRocmVhZGVkLCBzbyB0aGVyZSBpcyBubyByYWNl
IGNvbmRpdGlvbiBhcyBpcy4gQWxzbywgaWYgcmVjb3ZlcnkgZmFpbHMsDQo+PiBwYmxrIHdpbGwg
bm90IGNyZWF0ZSB0aGUgaW5zdGFuY2UgYXQgYWxsLiBUaGlzIHNhaWQsIGl0IHdvdWxkIGJlDQo+
PiBnb29kIHRvIHByb3RlY3QgdGhlIGxpc3RfYWRkIG9uIHRoZSBwYmxrX2xpbmVfaW5pdF9iYigp
IGVycm9yIHBhdGggaW4NCj4+IGNhc2UgdGhpcyBjb2RlIGlzIHVzZWQgZm9yIHNvbWUgb3RoZXIg
cHVycG9zZSBpbiB0aGUgZnV0dXJlLg0KPiANCj4gSSBsaWtlIHlvdXIgZXhwbGFuYXRpb24gaGVy
ZS4gQW5vdGhlciBvcHRpb24gaXMgdGhhdCB3ZSBjb3VsZCBhZGQgYSBjb21tZW50IHRvIG5vdGlm
eSB0aGUgZGV2ZWxvcGVyIHRoYXQgaXQgc2FmZSBpbiB0aGlzIGNvbnRleHQ/DQoNClN1cmUuIERv
IHlvdSB3YW50IHRvIGFkZCBpdD8gT3Igc2hvdWxkIEkgc2VuZCBpdD8NCg0KSmF2aWVyDQo=
