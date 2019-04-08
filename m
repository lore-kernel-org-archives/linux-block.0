Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4704EC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0710121473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kqW0n6h4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Cm2tcnVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDHVbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:31:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59840 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbfDHVbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 17:31:33 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LSTYL025260;
        Mon, 8 Apr 2019 14:30:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=T23SFj+yPeCOZ6q/Sxi2nEla/t7b5lEV11qQHtBamq8=;
 b=kqW0n6h4P8yMNOF5jfStCwhrCOigQluPrVk6lKG6sOhC4sKg4c75cq/VcLwHRTKW1Vcu
 kseHyHwkGGSC3jSZv/nu6r/S5EKLGwxwt6u1VFvOqHKT8PJGxekYRqhGnIGTr34lphbD
 m07PxSXw/Dd0Vx45BRejmO7Go6fU88rj/sw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rraew12da-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 14:30:32 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 14:30:32 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 14:30:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Apr 2019 14:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T23SFj+yPeCOZ6q/Sxi2nEla/t7b5lEV11qQHtBamq8=;
 b=Cm2tcnVxEzkrlZNedE9OSSt2pVwwnKrFvyfa1nwIM2ZTBNkv+++7DXu+w6ImJeWd8Eq3StBfqJLti7Z+1zCbFy0oI/mCrgxfzZjywgbQB8c7jbbrRbpGSoxQeaHUO/ADEAAOqxm2eNC6KoV0/NQvT4IyjIn/U+Pn32iKvslg4D0=
Received: from MWHPR15MB1262.namprd15.prod.outlook.com (10.175.3.12) by
 MWHPR15MB1630.namprd15.prod.outlook.com (10.175.135.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 21:30:29 +0000
Received: from MWHPR15MB1262.namprd15.prod.outlook.com
 ([fe80::d08:5fd8:f1b5:5840]) by MWHPR15MB1262.namprd15.prod.outlook.com
 ([fe80::d08:5fd8:f1b5:5840%4]) with mapi id 15.20.1771.014; Mon, 8 Apr 2019
 21:30:29 +0000
From:   Matt Mullins <mmullins@fb.com>
To:     "josef@toxicpanda.com" <josef@toxicpanda.com>
CC:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Hall <hall@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
Subject: Re: [PATCH bpf-next v2 2/5] nbd: trace sending nbd requests
Thread-Topic: [PATCH bpf-next v2 2/5] nbd: trace sending nbd requests
Thread-Index: AQHU7AsxHZ52PwHfXkyVeGXr0eWfqKYv1JsAgAL334A=
Date:   Mon, 8 Apr 2019 21:30:29 +0000
Message-ID: <370f1a299dba40bfe31459293b72d89ba0fd72c4.camel@fb.com>
References: <20190405235506.29236-1-mmullins@fb.com>
         <20190405235506.29236-3-mmullins@fb.com>
         <20190407001045.vbmwrzaokqb4ufww@MacBook-Pro-91.local>
In-Reply-To: <20190407001045.vbmwrzaokqb4ufww@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [2620:10d:c090:200::3:82f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c7dac6d-10c8-4022-e819-08d6bc696c6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1630;
x-ms-traffictypediagnostic: MWHPR15MB1630:
x-microsoft-antispam-prvs: <MWHPR15MB163087252BFB3E1DAB9A4FB5B02C0@MWHPR15MB1630.namprd15.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(25786009)(305945005)(5660300002)(71190400001)(71200400001)(86362001)(256004)(14444005)(102836004)(53936002)(6436002)(316002)(6116002)(36756003)(5640700003)(486006)(2906002)(54906003)(476003)(2616005)(6486002)(97736004)(118296001)(6512007)(81156014)(8676002)(1730700003)(81166006)(7736002)(446003)(99286004)(229853002)(11346002)(6916009)(186003)(50226002)(76176011)(2501003)(14454004)(6506007)(6246003)(478600001)(8936002)(68736007)(106356001)(105586002)(4326008)(7416002)(2351001)(46003)(99106002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1630;H:MWHPR15MB1262.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XQ8gBQDIXG3xsrc7ENG7HYS72gq32Ja73h/pU0+TSALweb0Um5EYt3hDR8shu2SgZhhLo1Eep1NvOnSgcRKSumQwRUJViaNDUwtQ7P8EE4HuBRiFAkDBLSSwMwnj/RhwAP0YNg6t/0pBfB/9vX2ODH50pxoQCLrJoxN42V+/ieTuWanq3JhAH4YZr+KqzGthWu6yZRuIXrR1xd/Se/b/KTcpewXG1eJqLpaxcV7akxJf17XZ3v9glMb5t0ADsYez4hqpg7KRhj7SiHa2NSQ9a0lMyRBAJ7gKJKZA7Q/97dkXLNhxNUncPH64bjWwgct6xsqZmpVXGnsef8pQiYGJ3yPtKd0wIGw1RRWATxaPLYhGSqtI24h28yejaBZahMk/D62dFGMWrSL8IdhBr1FdaOm3nWBL6upl/oypiRHbFUM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80E294868D891A46B11C46CF5A75AD40@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7dac6d-10c8-4022-e819-08d6bc696c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 21:30:29.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gU2F0LCAyMDE5LTA0LTA2IGF0IDIwOjEwIC0wNDAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
T24gRnJpLCBBcHIgMDUsIDIwMTkgYXQgMDQ6NTU6MDNQTSAtMDcwMCwgTWF0dCBNdWxsaW5zIHdy
b3RlOg0KPiA+IFRoaXMgYWRkcyBhIHRyYWNlcG9pbnQgdGhhdCBjYW4gYm90aCBvYnNlcnZlIHRo
ZSBuYmQgcmVxdWVzdCBiZWluZyBzZW50DQo+ID4gdG8gdGhlIHNlcnZlciwgYXMgd2VsbCBhcyBt
b2RpZnkgdGhhdCByZXF1ZXN0ICwgZS5nLiwgc2V0dGluZyBhIGZsYWcgaW4NCj4gPiB0aGUgcmVx
dWVzdCB0aGF0IHdpbGwgY2F1c2UgdGhlIHNlcnZlciB0byBjb2xsZWN0IGRldGFpbGVkIHRyYWNp
bmcgZGF0YS4NCj4gPiANCj4gPiBUaGUgc3RydWN0IHJlcXVlc3QgKiBiZWluZyBoYW5kbGVkIGlz
IGluY2x1ZGVkIHRvIHBlcm1pdCBjb3JyZWxhdGlvbg0KPiA+IHdpdGggdGhlIGJsb2NrIHRyYWNl
cG9pbnRzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHQgTXVsbGlucyA8bW11bGxpbnNA
ZmIuY29tPg0KPiA+IC0tLQ0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICB8ICAxICsN
Cj4gPiAgZHJpdmVycy9ibG9jay9uYmQuYyAgICAgICAgfCAgNSArKysrDQo+ID4gIGluY2x1ZGUv
dHJhY2UvZXZlbnRzL25iZC5oIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3RyYWNlL2V2ZW50cy9uYmQuaA0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+ID4gaW5kZXggZTE3ZWJmNzBiNTQ4
Li42ZGI1ODNkMmIwZWEgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9N
QUlOVEFJTkVSUw0KPiA+IEBAIC0xMDczNyw2ICsxMDczNyw3IEBAIEw6CWxpbnV4LWJsb2NrQHZn
ZXIua2VybmVsLm9yZw0KPiA+ICBMOgluYmRAb3RoZXIuZGViaWFuLm9yZw0KPiA+ICBGOglEb2N1
bWVudGF0aW9uL2Jsb2NrZGV2L25iZC50eHQNCj4gPiAgRjoJZHJpdmVycy9ibG9jay9uYmQuYw0K
PiA+ICtGOglpbmNsdWRlL3RyYWNlL2V2ZW50cy9uYmQuaA0KPiA+ICBGOglpbmNsdWRlL3VhcGkv
bGludXgvbmJkLmgNCj4gPiAgDQo+ID4gIE5FVFdPUksgRFJPUCBNT05JVE9SDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYmxvY2svbmJkLmMgYi9kcml2ZXJzL2Jsb2NrL25iZC5jDQo+ID4gaW5k
ZXggOTBiYTlmNGMwM2YzLi43MzkzZDA0ZDI1NWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9i
bG9jay9uYmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmxvY2svbmJkLmMNCj4gPiBAQCAtNDQsNiAr
NDQsOSBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvbmJkLW5ldGxpbmsuaD4NCj4gPiAgI2luY2x1
ZGUgPG5ldC9nZW5ldGxpbmsuaD4NCj4gPiAgDQo+ID4gKyNkZWZpbmUgQ1JFQVRFX1RSQUNFX1BP
SU5UUw0KPiA+ICsjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL25iZC5oPg0KPiA+ICsNCj4gPiAgc3Rh
dGljIERFRklORV9JRFIobmJkX2luZGV4X2lkcik7DQo+ID4gIHN0YXRpYyBERUZJTkVfTVVURVgo
bmJkX2luZGV4X211dGV4KTsNCj4gPiAgc3RhdGljIGludCBuYmRfdG90YWxfZGV2aWNlcyA9IDA7
DQo+ID4gQEAgLTUyNiw2ICs1MjksOCBAQCBzdGF0aWMgaW50IG5iZF9zZW5kX2NtZChzdHJ1Y3Qg
bmJkX2RldmljZSAqbmJkLCBzdHJ1Y3QgbmJkX2NtZCAqY21kLCBpbnQgaW5kZXgpDQo+ID4gIAlo
YW5kbGUgPSBuYmRfY21kX2hhbmRsZShjbWQpOw0KPiA+ICAJbWVtY3B5KHJlcXVlc3QuaGFuZGxl
LCAmaGFuZGxlLCBzaXplb2YoaGFuZGxlKSk7DQo+ID4gIA0KPiA+ICsJdHJhY2VfbmJkX3NlbmRf
cmVxdWVzdCgmcmVxdWVzdCwgbmJkLT5pbmRleCwgYmxrX21xX3JxX2Zyb21fcGR1KGNtZCkpOw0K
PiA+ICsNCj4gDQo+IEp1c3QgdXNlIHRoZSBoYW5kbGUsIG5vdCB0aGUgcG9pbnRlci4gIFRoYW5r
cywNCg0KQXNzdW1pbmcgeW91J3JlIHRhbGtpbmcgYWJvdXQgdGhlIHN0cnVjdCByZXF1ZXN0ICos
IHdlIGFyZSB0cmFjaW5nDQp0aGluZ3MgdGhyb3VnaCBmcm9tIGJsa19tcV9zdGFydF9yZXF1ZXN0
LCB3aGljaCBlbWl0cyB0cmFjZXBvaW50cyBsaWtlDQoNCkRFRklORV9FVkVOVChibG9ja19ycSwg
YmxvY2tfcnFfaXNzdWUsDQoJVFBfUFJPVE8oc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIHN0cnVj
dCByZXF1ZXN0ICpycSksDQoNCldlIG5lZWQgYXQgbGVhc3Qgb25lIG9mIHRoZSB0cmFjZXBvaW50
cyB0byBvYnNlcnZlIGEgY29ycmVsYXRpb24NCmJldHdlZW4gTkJEIGhhbmRsZSAoaW4gdGhpcyBj
YXNlLCBlbWJlZGRlZCBpbiB0aGUgc3RydWN0IG5iZF9yZXF1ZXN0KQ0KYW5kIHRoZSBzdHJ1Y3Qg
cmVxdWVzdC4gIFRoYXQgc2FpZCwgSSBkb24ndCBhY3R1YWxseSBtaW5kIGlmIHRoZXkncmUNCnRo
ZSBoYXNoZWQga2luZCBvZiBwb2ludGVycywgYXMgbG9uZyBhcyB0aGUgcmVzdCBvZiB0aGUgYmxv
Y2sNCnRyYWNlcG9pbnRzIGRvIHRoZSBzYW1lLi4uDQo=
