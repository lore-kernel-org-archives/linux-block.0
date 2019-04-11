Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1525C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68C22083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j40vB5tq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Yv18qPq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDKQUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:20:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbfDKQUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 12:20:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BGG9RD016985;
        Thu, 11 Apr 2019 09:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sAJmrXCAh5eK9KFjTDchA38qIJEmn/H5D3xmHK47pMM=;
 b=j40vB5tqCsDSsjnDijKhCSIS70WhzIxN2GvPIwIyW00GlwD0WJEFG7vQdN3RXoIfKgcS
 WUKDGmx4acUW0ODkta5Vl9YZI7J0c2ZYvKoQrjdPyEGIWC+/VqITBmhAH8SqYSFRBwF7
 zl6dn/4qRaTv+2S5f6+AxzJNZVN8jJdz/WU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rt6je0hyn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Apr 2019 09:20:04 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 11 Apr 2019 09:19:41 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Apr 2019 09:19:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAJmrXCAh5eK9KFjTDchA38qIJEmn/H5D3xmHK47pMM=;
 b=Yv18qPq3emhQu7T6GEXb0ZMeGIQef3gDg4lllzL43ljAeYIm+zY/GPvkJgVTe+mt2NS4/rnFp+PM0w8BERYsQAU37qZPIKknsQla0tCH14AmlEoZSRq8nVi/jejti6nBGO2eFJeNcREf2z5OLPiQ+r2I+Di2YlSy6j95MooaOPI=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.209.148) by
 DM5PR15MB1449.namprd15.prod.outlook.com (10.173.225.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Thu, 11 Apr 2019 16:19:40 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::e828:23d4:87c9:b7f7]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::e828:23d4:87c9:b7f7%5]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 16:19:40 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCHSET 0/3] io_uring: add sync_file_range and drains
Thread-Topic: [PATCHSET 0/3] io_uring: add sync_file_range and drains
Thread-Index: AQHU8Hg7hL4y7EbimkCTFhs1XP8uw6Y3EkSAgAARf4A=
Date:   Thu, 11 Apr 2019 16:19:39 +0000
Message-ID: <A054D130-CF7D-4F20-9E8C-92EE19BFF9E1@fb.com>
References: <20190411150657.18480-1-axboe@kernel.dk>
 <20190411151657.GD22763@bombadil.infradead.org>
In-Reply-To: <20190411151657.GD22763@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BL0PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:208:35::19) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b3::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::8f3b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c426bc8-9326-4624-fd6f-08d6be997f41
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1449;
x-ms-traffictypediagnostic: DM5PR15MB1449:
x-microsoft-antispam-prvs: <DM5PR15MB144957AEAA3EB48CFA729650D32F0@DM5PR15MB1449.namprd15.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(316002)(53936002)(52116002)(99286004)(68736007)(186003)(4326008)(14454004)(6246003)(97736004)(76176011)(54906003)(6486002)(229853002)(6116002)(2906002)(6506007)(386003)(25786009)(102836004)(6436002)(53546011)(86362001)(33656002)(5660300002)(81156014)(50226002)(8936002)(46003)(256004)(83716004)(446003)(486006)(81166006)(2616005)(14444005)(36756003)(478600001)(8676002)(71200400001)(82746002)(7736002)(476003)(6512007)(71190400001)(105586002)(106356001)(11346002)(6916009)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1449;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 41Djx9x+9ZzuvrsfnMscP3jvCQCmcYJEvDq9RugbdrVRin3E6OgaVhaHz7wcVzfILxI8Ns0CrBcj4GTgIWq4FiXlh/iljpUucdwGiwJI/VfU84Gg25OPo1DB7VlnO3x3LHT879SzGlc4HoCzBLzKXLatDU46QsN2M5aor+SBjZsk4JCkldOk0Q+Op6ovEqllZ0Dr9Bdims9YhILUD0YhCIcNDacqeKhhzdmPhis0K3YQvv+ogeC6Pi9dajHlC2t8Dc0iaibPVtS7ZzEcHqJ4epQ7yTHL/IBKaJVwj5b3HqQuvIG+v0uTB3G3pKxzvM6oWpuYl2gffcz4gTISCp9T5d17xHnK7TF+pyt13eESYd5C7pS3CHhWSxbrvNb5ZME4rmZumi2ZQifAuDSY97ay7xBZy4/MWtirLabSS9PpwLI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c426bc8-9326-4624-fd6f-08d6be997f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 16:19:40.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1449
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCk9uIDExIEFwciAyMDE5LCBhdCAxMToxNiwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQoNCj4g
T24gVGh1LCBBcHIgMTEsIDIwMTkgYXQgMDk6MDY6NTRBTSAtMDYwMCwgSmVucyBBeGJvZSB3cm90
ZToNCj4+IEluIGNvbnRpbnVhdGlvbiBvZiB0aGUgZnN5bmMgYmFycmllciBwYXRjaCBmcm9tIHRo
ZSBvdGhlciBkYXksIEkNCj4+IHJld29ya2VkIHRoYXQgcGF0Y2ggdG8gdHVybiBpdCBpbnRvIGEg
Z2VuZXJhbCBwcmltaXRpdmUgaW5zdGVhZC4gVGhpcw0KPj4gbWVhbnMgdGhhdCBhbnkgY29tbWFu
ZCBjYW4gYmUgZmxhZ2dlZCB3aXRoIElPU1FFX0lPX0RSQUlOLCB3aGljaCB3aWxsDQo+PiBpbnNl
cnQgYSBzZXF1ZW5jZSBwb2ludCBpbiB0aGUgcXVldWUuIElmIGEgcmVxdWVzdCBpcyBtYXJrZWQg
d2l0aA0KPj4gSU9TUUVfSU9fRFJBSU4sIHRoZW4gcHJldmlvdXMgY29tbWFuZHMgbXVzdCBjb21w
bGV0ZSBiZWZvcmUgdGhpcyBvbmUNCj4+IGlzIGlzc3VlZC4gU3Vic2VxdWVudCByZXF1ZXN0cyBh
cmUgbm90IHN0YXJ0ZWQgdW50aWwgdGhlIGRyYWluIGhhcw0KPj4gY29tcGxldGVkLiBUaGUgbGF0
dGVyIGlzIGEgbmVjZXNzaXR5IHNpbmNlIHdlIHRyYWNrIHRoaXMgdGhyb3VnaCB0aGUNCj4+IENR
IGluZGV4LiBJZiB3ZSBhbGxvdyBsYXRlciBjb21tYW5kcywgdGhlbiB0aGV5IGNvdWxkIGNvbXBs
ZXRlIGJlZm9yZQ0KPj4gZWFybGllciBjb21tYW5kcyBhbmQgd2UnZCBtaXN0YWtlbmx5IHRoaW5r
IHRoYXQgd2UgaGF2ZSBzYXRpc2ZpZWQgdGhlDQo+PiBzZXF1ZW5jZSBwb2ludC4NCj4NCj4gVGhh
dCdzIHBvdGVudGlhbGx5IGdvaW5nIHRvIGNhdXNlIHF1aXRlIHRoZSBidWJibGUgaW4gdGhlIHBp
cGVsaW5lIG9mDQo+IGNvbW1hbmRzIGJlaW5nIHNlbnQuDQo+DQo+IERvIGNvbnN1bWVycyBrbm93
IHdoaWNoIHdyaXRlcyB0aGV5IGFyZSBnb2luZyB0byB3YW50IHRvIGZlbmNlPyAgV2UgDQo+IGNv
dWxkDQo+IGRvIHNvbWV0aGluZyBsaWtlIHRhZyBlYWNoIGNvbW1hbmQgd2l0aCBhIHN0cmVhbSBJ
RCBhbmQgdGhlbiBmZW5jZSBhDQo+IHBhcnRpY3VsYXIgc3RyZWFtLiAgV2UnZCBuZWVkIG9uZSBu
cl9wZW5kaW5nIGNvdW50ZXIgcGVyIHN0cmVhbSwgYnV0DQo+IHRoYXQgc2hvdWxkIGJlIHByZXR0
eSBjaGVhcC4NCg0KSXQnbGwgYmUgYSBidWJibGUsIGJ1dCB3aXRob3V0IHRoZSBkcmFpbiBjb21t
YW5kLCBpb3VfcmluZyB1c2VycyB3b3VsZCANCnN0aWxsIGhhdmUgdGhlIHNhbWUgYnViYmxlIHdo
aWxlIHRoZXkgd2FpdCBmb3IgSU8gaW4gb3JkZXIgdG8gZW5mb3JjZSANCnRoZSBvcmRlcmluZyB0
aGVtc2VsdmVzLg0KDQpJIHByZWZlciBKZW5zJyBzdWdnZXN0aW9uIHRvIGxpbWl0IHRoZSBkcmFp
bidzIGltcGFjdCB3aXRoIG11bHRpcGxlIA0KaW91X3JpbmdzIGluc3RlYWQgb2YgYWRkaW5nIGEg
c3RyZWFtIGlkLiAgIEkgZG9uJ3QgaGF2ZSBhIHJlYWxseSBzb2xpZCANCnJlYXNvbiBmb3IgdGhp
cywgYnV0IEknZCBoZXNpdGF0ZSB0byBhZGQgY29tcGxleGl0eSBiZWZvcmUgd2UgaGF2ZSBtb3Jl
IA0KZGF0YSBmcm9tIHVzZXJzLg0KDQotY2hyaXMNCg==
