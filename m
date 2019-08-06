Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66485C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DFE20818
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P+9/UG4v";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q6u/hYg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfHFOQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:16:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732883AbfHFOQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 10:16:30 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76EFYos015313;
        Tue, 6 Aug 2019 07:16:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+qSIB4C+fenWIyddeTLKhvdfjzjTzIGQYuzhPgn/SgE=;
 b=P+9/UG4v1iUTlaHCZkITAiAn3xDOn3Q09FsryyNrFuz9nQW+HJOSYM/d0beW9Z6LTdaC
 5trI/sB69IHmUVUh5Gt3S83OYmnWLD+Dc8KUjvEyHBCP6U1kLn0X6AUW/maDyV0GSIz7
 tgJdazc/s4Ao1Jf49Wvsf8vxu7PKzVpkJj0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u7am1r6qv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 07:16:19 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 07:16:14 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 07:16:14 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 07:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfg8kyjawCrIyjnP2AM0soIU2hNA/9LjOsAC7mQDMOnqHPwcA+AnLasBr/PA1i9FLiH3SVVqlN5qmMXNFJ34BblxSX8ExJtJcsj1gXpKj6uc3q/w7VlZGeOGt3HrwJ55Z88SHiumALL+rQn7jqwIRy06RMD/xTHHEI68mtpNU2qYgzJgDbSwpVTB7xiBAz33016Fb0z719ZWdbvM6+T+rhFkIl1wq2IKBMmlO4Bp0RSBB/rMp+z9o1C+YJdGBnOJWS3mhpBonNPRv8X89q2raiEIp28BzS8kbijG+y4UMRxFoOQV46SixaFfHuyraOuIrEVjoF6WATVMED/JC5APpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qSIB4C+fenWIyddeTLKhvdfjzjTzIGQYuzhPgn/SgE=;
 b=Xar65kODMAMVJu4LlLgS/UzArxo5UPtFxcmmK2vfsKeAlyghOy2343xspexAu9b9ODhTp5qx9GRZBWqz3S4jd/hK/w1M4cZSZJXOjPHYM706dYc/IoayeZGp35YPNpUVkV4gdLBMqPJ4LxL01WAGkliiX1+blWzsVMM/m46B7ugfKs1iyg4tlKT2Ep8apKrgq/ybUzsOekXmseyVygrnpOr8RD4TKQCtQ0wdyqzYeHCI3fxFn/VB5FrGKkCCoexSksPnLkIVLXX+dTLb7aoK0ZBRRFWmXrDgMKYAtP20Rg5esVK7XBee4hd7hBuo0GL8xiNh9VVTuRMyFNziza5t8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qSIB4C+fenWIyddeTLKhvdfjzjTzIGQYuzhPgn/SgE=;
 b=Q6u/hYg69H/vjVkSfs427sHQn3wPs28x7K6z6VFYVNCnUQmVS134IwFMe2nWiQCls60o86ZyOAdL6uv06pKSd4gkLFkoZ4pid92Mcl74eVUg+fOp54038dEwkZu7BAlhtD9GdDhz+N2bNDsz54O/Pfyw77kYFk5CCk0Ol0qOIfo=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (20.179.158.31) by
 BYAPR15MB2485.namprd15.prod.outlook.com (52.135.194.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 6 Aug 2019 14:16:13 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::4531:ecb8:acf6:5802]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::4531:ecb8:acf6:5802%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 14:16:13 +0000
From:   Jens Axboe <axboe@fb.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Hans Holmberg <hans@owltronix.com>, Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lnvm/pblk mapping cleanups
Thread-Topic: [PATCH 0/4] lnvm/pblk mapping cleanups
Thread-Index: AQHVTFyfHqDhmuDeN0+F2qAiyr5X4abuKkWA
Date:   Tue, 6 Aug 2019 14:16:12 +0000
Message-ID: <a7866969-5ecc-f9e8-73b3-5dcaa79efddf@fb.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
 <5e99586b-c78c-2e70-efb0-aceef56fd19d@lightnvm.io>
In-Reply-To: <5e99586b-c78c-2e70-efb0-aceef56fd19d@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2605:e000:100e:83a1:5cfb:b4eb:1062:5bea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37e37468-7707-41cf-6984-08d71a78a2de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2485;
x-ms-traffictypediagnostic: BYAPR15MB2485:
x-microsoft-antispam-prvs: <BYAPR15MB248513F33C699F33519F3429C0D50@BYAPR15MB2485.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(5660300002)(86362001)(46003)(229853002)(66476007)(66446008)(66946007)(14454004)(31696002)(64756008)(66556008)(102836004)(8936002)(76176011)(52116002)(6506007)(53546011)(99286004)(81156014)(81166006)(8676002)(386003)(316002)(186003)(54906003)(25786009)(4326008)(68736007)(2906002)(6916009)(7736002)(14444005)(6246003)(36756003)(31686004)(256004)(6512007)(53936002)(305945005)(486006)(6116002)(66574012)(71200400001)(478600001)(6436002)(6486002)(476003)(2616005)(11346002)(71190400001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2485;H:BYAPR15MB2790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jEsiV+CDfugDj8tb/vlP3jg58Zw7RLHJDhDawxEGEWjAvccJHDfsk6NhY1fvVzGnhclbLyVxVxN2dlqsiwI7A6s3qMRTP2HbPm1Xd0QSdJ7G+B8CpuJG4ZU9ISUuEeBwMT1oT3z174VBVbEgCVjuZjMhJZ2bcI3BpSfcjuRfEaRWE7RHKqwo58xYd/GF1Gn4u2A4QgBZfy4ByRaXwZk4+CT9UwjQ6vydCdy4RBZ0qitM9bi335sG/AzH88Ikm2VmVTGqbEtmW0lAoynWOLx0PeQv+IEYuew6PGCKck98msLQ2jXmf/PtleFnBIG4IKqdn3eIPqmQZbWoc5U274e0U7Wf3YsaQAuDgeNIRZ8Qzbsn2N+PUx5zS48pIPWRnGzfM53ew85uYgQ6yh+ss4W77D18F6Co913B5RUOjgpe/kQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <040E17EAE8C2EE4E87A14B90262C2505@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e37468-7707-41cf-6984-08d71a78a2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 14:16:13.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axboe@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2485
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=916 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060144
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC82LzE5IDY6NDAgQU0sIE1hdGlhcyBCasO4cmxpbmcgd3JvdGU6DQo+IE9uIDcvMzEvMTkg
MTE6NDEgQU0sIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+PiBUaGlzIHNlcmllcyBjbGVhbnMgdXAg
dGhlIG1ldGFkYXRhIGFsbG9jYXRpb24vbWFwcGluZyBpbiBsbnZtL3BibGsNCj4+IGJ5IG1vdmlu
ZyBvdmVyIHRvIGt2bWFsbG9jIGZvciBtZXRhZGF0YSBhbmQgbW92aW5nIG1ldGFkYXRhIG1hcHBp
bmcNCj4+IGRvd24gdG8gdGhlIGxvd2VyIGxldmVyIGRyaXZlciB3aGVyZSBibGtfcnFfbWFwX2tl
cm4gY2FuIGJlIHVzZWQuDQo+Pg0KPj4gSGFucyBIb2xtYmVyZyAoNCk6DQo+PiAgICAgbGlnaHRu
dm06IHJlbW92ZSBudm1fc3VibWl0X2lvX3N5bmNfZm4NCj4+ICAgICBsaWdodG52bTogbW92ZSBt
ZXRhZGF0YSBtYXBwaW5nIHRvIGxvd2VyIGxldmVsIGRyaXZlcg0KPj4gICAgIGxpZ2h0bnZtOiBw
YmxrOiB1c2Uga3ZtYWxsb2MgZm9yIG1ldGFkYXRhDQo+PiAgICAgYmxvY2s6IHN0b3AgZXhwb3J0
aW5nIGJpb19tYXBfa2Vybg0KPj4NCj4+ICAgIGJsb2NrL2Jpby5jICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxIC0NCj4+ICAgIGRyaXZlcnMvbGlnaHRudm0vY29yZS5jICAgICAgICAgIHwgIDQz
ICsrKysrKysrKysrKy0tLQ0KPj4gICAgZHJpdmVycy9saWdodG52bS9wYmxrLWNvcmUuYyAgICAg
fCAxMTYgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgICBkcml2
ZXJzL2xpZ2h0bnZtL3BibGstZ2MuYyAgICAgICB8ICAxOSArKystLS0tDQo+PiAgICBkcml2ZXJz
L2xpZ2h0bnZtL3BibGstaW5pdC5jICAgICB8ICAzOCArKysrLS0tLS0tLS0tDQo+PiAgICBkcml2
ZXJzL2xpZ2h0bnZtL3BibGstcmVhZC5jICAgICB8ICAyMiArLS0tLS0tLQ0KPj4gICAgZHJpdmVy
cy9saWdodG52bS9wYmxrLXJlY292ZXJ5LmMgfCAgMzkgKystLS0tLS0tLS0tLQ0KPj4gICAgZHJp
dmVycy9saWdodG52bS9wYmxrLXdyaXRlLmMgICAgfCAgMjAgKy0tLS0tLQ0KPj4gICAgZHJpdmVy
cy9saWdodG52bS9wYmxrLmggICAgICAgICAgfCAgMzEgKy0tLS0tLS0tLS0NCj4+ICAgIGRyaXZl
cnMvbnZtZS9ob3N0L2xpZ2h0bnZtLmMgICAgIHwgIDQ1ICsrKysrLS0tLS0tLS0tLQ0KPj4gICAg
aW5jbHVkZS9saW51eC9saWdodG52bS5oICAgICAgICAgfCAgIDggKy0tDQo+PiAgICAxMSBmaWxl
cyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCAyODYgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4g
SGkgSmVucywNCj4gDQo+IFdvdWxkIHlvdSBsaWtlIG1lIHRvIHBpY2sgdXAgdGhpcyBzZXJpZSwg
YW5kIHNlbmQgaXQgdGhyb3VnaCB0aGUNCj4gbGlnaHRudm0gcHVsbCByZXF1ZXN0LCBvciB3b3Vs
ZCB5b3UgbGlrZSB0byBwaWNrIGl0IHVwPw0KDQpJIGNhbiBhcHBseSBpdCBkaXJlY3RseSBmb3Ig
NS40Lg0KDQotLSANCkplbnMgQXhib2UNCg0K
