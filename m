Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ADAC282DA
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084602133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qmYydaiN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Yl2hNl41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDISnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:43:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbfDISnN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 14:43:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39IbmUm018886;
        Tue, 9 Apr 2019 11:42:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JADv20O8BeqXNMb3Q1q0NbFiuZwcAes71bkObYAt3TI=;
 b=qmYydaiNUjar2E7+zK1dAQy8667KfMz1m2IxbGmWMUTb8o4KyghfX5IbiZXzXAdiaFLS
 dq5fC/0jnf4SrfuuinpxeEP6c8mb+/+wtH+en70mFYzoYkPqBOflDq8LDrvsxuFobQYO
 GO7pGnxDdMhRxZeo/hAh9TKtWfcjCgNC2dM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrvx796g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 11:42:59 -0700
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:42:57 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 11:42:56 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 11:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JADv20O8BeqXNMb3Q1q0NbFiuZwcAes71bkObYAt3TI=;
 b=Yl2hNl41rHRMcTB/ZZEqEZEN0qFPdaxxPAWMJQTtUvtdJIo0kJESDdQa929AM5ZhGOevD4Cq9b15rymZtWYewjCEVRhSTshKC4xpSX1Za2z/WsH9MxnUTrcM55kd6E1CBDFlfdHjfHHo8iVM6MrkBOWgX3ItSPam2RI8XPUlCqg=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.209.148) by
 DM5PR15MB1337.namprd15.prod.outlook.com (10.173.210.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 18:42:55 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::e828:23d4:87c9:b7f7]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::e828:23d4:87c9:b7f7%5]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 18:42:55 +0000
From:   Chris Mason <clm@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] io_uring: add support for barrier fsync
Thread-Topic: [PATCH] io_uring: add support for barrier fsync
Thread-Index: AQHU7vEvvXtetWT7+EuXEpZlgauUcqY0IygAgAABpACAAAVjgA==
Date:   Tue, 9 Apr 2019 18:42:55 +0000
Message-ID: <5BF7FDDE-212E-4F9A-9B50-26BDA99E952A@fb.com>
References: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
 <20190409181742.GA24925@infradead.org>
 <5f8d9644-9e8f-c9d2-611e-4b144c62539c@kernel.dk>
In-Reply-To: <5f8d9644-9e8f-c9d2-611e-4b144c62539c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BN8PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:408:60::17) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b3::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::2ad7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ffce8d4-49ac-4906-0c87-08d6bd1b2dbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR15MB1337;
x-ms-traffictypediagnostic: DM5PR15MB1337:
x-microsoft-antispam-prvs: <DM5PR15MB1337AFE074DA0D3A5AB2C6C7D32D0@DM5PR15MB1337.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(6246003)(8676002)(11346002)(446003)(2906002)(76176011)(52116002)(53546011)(478600001)(476003)(8936002)(2616005)(186003)(6506007)(4326008)(386003)(102836004)(25786009)(6512007)(46003)(83716004)(14454004)(305945005)(256004)(14444005)(71190400001)(7736002)(81156014)(81166006)(53936002)(54906003)(71200400001)(6486002)(82746002)(316002)(6436002)(68736007)(86362001)(229853002)(6916009)(99286004)(97736004)(50226002)(105586002)(486006)(106356001)(33656002)(36756003)(6116002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1337;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zTaAyBEo05GaGhBopy9UBMGXhOUu+0VcTmUg8Q6EK6H7SXjSJTXOJ5CKylIrfejcciRlnvi/bqYW7Pinz5oXug6prSlIVfFQ+IJUGwVGc461FMbwXxlotYn7Ucft3dFt1w7aDdfRbsHc7mXfRPe9qGz4t/GBQ/1EnmXXfNCeU/n6bz9HYH2sAbLTYrB4ZjqA7NB2qx/eJ1FiFjODz99NO6VuNvRXe5fC/OMOZK4CzXgMYRizC2ArD2th9QXrd5UZMu327F4UiQ+ncI7l2dM/IBdyxQuYyCfA//ZMCWRayR+9XSgBsAt4oaYRC3Bjamob3VoKb3GJgr0KR4toNwdEpjHpuZXWjIMFI/snnxjmGCUEH+sffj5m1zmRqKyiptD5QTI927RbIqj+9vSJ3Ao1YOrF0Yxnmyq/tr1cG0NHSYM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffce8d4-49ac-4906-0c87-08d6bd1b2dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 18:42:55.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1337
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOSBBcHIgMjAxOSwgYXQgMTQ6MjMsIEplbnMgQXhib2Ugd3JvdGU6DQoNCj4gT24gNC85LzE5
IDEyOjE3IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IE9uIFR1ZSwgQXByIDA5LCAy
MDE5IGF0IDEwOjI3OjQzQU0gLTA2MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+Pj4gSXQncyBhIHF1
aXRlIGNvbW1vbiB1c2UgY2FzZSB0byBpc3N1ZSBhIGJ1bmNoIG9mIHdyaXRlcywgdGhlbiBhbiAN
Cj4+PiBmc3luYw0KPj4+IG9yIGZkYXRhc3luYyB3aGVuIHRoZXkgY29tcGxldGUuIFNpbmNlIGlv
X3VyaW5nIGRvZXNuJ3QgZ3VhcmFudGVlIA0KPj4+IGFueQ0KPj4+IHR5cGUgb2Ygb3JkZXJpbmcs
IHRoZSBhcHBsaWNhdGlvbiBtdXN0IHRyYWNrIGlzc3VlZCB3cml0ZXMgYW5kIHdhaXQNCj4+PiB3
aXRoIHRoZSBmc3luYyBpc3N1ZSB1bnRpbCB0aGV5IGhhdmUgY29tcGxldGVkLg0KPj4+DQo+Pj4g
QWRkIGFuIElPUklOR19GU1lOQ19CQVJSSUVSIGZsYWcgdGhhdCBoZWxwcyB3aXRoIHRoaXMgc28g
dGhlIA0KPj4+IGFwcGxpY2F0aW9uDQo+Pj4gZG9lc24ndCBoYXZlIHRvIGRvIHRoaXMgbWFudWFs
bHkuIElmIHRoaXMgZmxhZyBpcyBzZXQgZm9yIHRoZSBmc3luYw0KPj4+IHJlcXVlc3QsIHdlIHdv
bid0IGlzc3VlIGl0IHVudGlsIHBlbmRpbmcgSU8gaGFzIGFscmVhZHkgY29tcGxldGVkLg0KPj4N
Cj4+IEkgdGhpbmsgd2UgbmVlZCBhIG11Y2ggbW9yZSBkZXRhaWxlZCBleHBsYW5hdGlvbiBvZiB0
aGUgc2VtYW50aWNzLA0KPj4gcHJlZmVyYWJseSBpbiBtYW4gcGFnZSBmb3JtYXQuDQo+Pg0KPj4g
QmFycmllciBhdCBsZWFzdCBpbiBMaW51eCB0cmFkaXRpb25hbGx5IG1lYW5zIGFsbCBwcmV2aW91
c2x5IA0KPj4gc3VibWl0dGVkDQo+PiByZXF1ZXN0cyBoYXZlIGZpbmlzaGVkIGFuZCBubyBuZXcg
b25lcyBhcmUgc3RhcnRlZCB1bnRpbCB0aGUNCj4+IGJhcnJpZXIgcmVxdWVzdCBmaW5pc2hlcywg
d2hpY2ggaXMgdmVyeSBoZWF2eSBoYW5kZWQuICBJcyB0aGF0IHdoYXQNCj4+IHRoaXMgaXMgc3Vw
cG9zZWQgdG8gZG8/ICBJZiBub3Qgd2hhdCBhcmUgdGhlIGV4YWN0IGd1YXJhbnRlZXMgdnMNCj4+
IG9yZGVyaW5nIGFuZCBvciBiYXJyaWVyIHNlbWFudGljcz8NCj4NCj4gVGhlIHBhdGNoIGRlc2Ny
aXB0aW9uIGlzbid0IHRoYXQgZ3JlYXQsIGFuZCBtYXliZSB0aGUgbmFtaW5nIGlzbid0IA0KPiB0
aGF0DQo+IGludHVpdGl2ZSBlaXRoZXIuIFRoZSB3YXkgaXQncyBpbXBsZW1lbnRlZCwgdGhlIGZz
eW5jIHdpbGwgTk9UIGJlIA0KPiBpc3N1ZWQNCj4gdW50aWwgcHJldmlvdXNseSBpc3N1ZWQgSU9z
IGhhdmUgY29tcGxldGVkLiBUaGF0IG1lYW5zIGJvdGggcmVhZHMgYW5kDQo+IHdyaXRlcywgc2lu
Y2UgdGhlcmUncyBubyB3YXkgdG8gd2FpdCBmb3IganVzdCBvbmUuICBJbiB0ZXJtcyBvZg0KPiBz
ZW1hbnRpY3MsIGFueSBwcmV2aW91c2x5IHN1Ym1pdHRlZCB3cml0ZXMgd2lsbCBoYXZlIGNvbXBs
ZXRlZCBiZWZvcmUNCj4gdGhpcyBmc3luYyBpcyBpc3N1ZWQuIFRoZSBiYXJyaWVyIGZzeW5jIGhh
cyBubyBvcmRlcmluZyB3cnQgZnV0dXJlDQo+IHdyaXRlcywgbm8gb3JkZXJpbmcgaXMgaW1wbGll
ZCB0aGVyZS4gSGVuY2U6DQo+DQo+IFcxLCBXMiwgVzMsIEZTWU5DX1dfQkFSUklFUiwgVzQsIFc1
DQo+DQo+IFcxLi4zIHdpbGwgaGF2ZSBiZWVuIGNvbXBsZXRlZCBieSB0aGUgaGFyZHdhcmUgc2lk
ZSBiZWZvcmUgd2Ugc3RhcnQNCj4gRlNZTkNfV19CQVJSSUVSLiBXZSBkb24ndCB3YWl0IHdpdGgg
aXNzdWluZyBXNC4uNSB1bnRpbCBhZnRlciB0aGUgDQo+IGZzeW5jDQo+IGNvbXBsZXRlcywgbm8g
b3JkZXJpbmcgaXMgcHJvdmlkZWQgdGhlcmUuDQoNCkxvb2tpbmcgYXQgdGhlIHBhdGNoLCB3aHkg
aXMgZnN5bmMgc3BlY2lhbD8gIFNlZW1zIGxpa2UgeW91IGNvdWxkIGFkZCANCnRoaXMgb3JkZXJp
bmcgYml0IHRvIGFueSB3cml0ZT8NCg0KV2hpbGUgeW91J3JlIGhlcmUsIGRvIHlvdSB3YW50IHRv
IGFkZCBhIHdheSB0byBGVUEvY2FjaGUgZmx1c2g/ICANCkJhc2ljYWxseSB0aGUgcmVzdCBvZiB3
aGF0IHVzZXIgbGFuZCB3b3VsZCBuZWVkIHRvIG1ha2UgdGhlaXIgb3duIA0Kd3JpdGUtYmFjay1j
YWNoZS1zYWZlIGltcGxlbWVudGF0aW9uLg0KDQotY2hyaXMNCg==
