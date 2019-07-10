Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD79C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B528F20651
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MMsl/0nE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ekKxBmjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGJUkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:40:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31556 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbfGJUkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:40:18 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AKdDNB029587;
        Wed, 10 Jul 2019 13:40:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rec9V38234Jv9GRI5Id/G0gfTnvh13zJQFw6uN1QZvk=;
 b=MMsl/0nED3T1tIBklAE6wTdvVb+KGMz9AkoH/heWRQBDn8Zg8lhRnZjmarP5rAIAaf06
 mBZWujCDGiILBFgL072aNy1coYWxUvCXUWUEB3yk8Ne58mU+d+NRjQkDuu0nNQ9Tou6F
 cBMvZQIyBCPZjZxGSEANyX8zbT4qpqWki9w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tnhwrhyf2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Jul 2019 13:40:01 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jul 2019 13:40:00 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jul 2019 13:40:00 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Jul 2019 13:39:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rec9V38234Jv9GRI5Id/G0gfTnvh13zJQFw6uN1QZvk=;
 b=ekKxBmjOCKl0jX2KPV/BPj0B5+BsIwuPoYCKmiLClDPru1fGas5xeCHnmVYUgq/daDe1PhDiwy23mHAhK2m2EzwLNUz/q3CyYPs+BD4o6u/jeVFqm83/zk8BfU7UcB68cKkrG6atXI6hXzyGVmiG7UzThtrWsU5LgqXOkJaw9ME=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1845.namprd15.prod.outlook.com (10.172.75.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Wed, 10 Jul 2019 20:39:56 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::7d62:c9a2:b34e:74fd]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::7d62:c9a2:b34e:74fd%6]) with mapi id 15.20.2052.019; Wed, 10 Jul 2019
 20:39:56 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Thread-Topic: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Thread-Index: AQHVN1kRQ9jeXoBJ80uNXtvbiV/a9qbES/KAgAADUgCAAAFJAA==
Date:   Wed, 10 Jul 2019 20:39:55 +0000
Message-ID: <752dbdc9-945d-e70c-e6f3-0c48932c7f60@fb.com>
References: <20190710195227.92322-1-josef@toxicpanda.com>
 <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
 <20190710203516.GL3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190710203516.GL3419@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.29.164.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d3825b3-4ca7-490d-be36-08d70576c47c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1845;
x-ms-traffictypediagnostic: CY4PR15MB1845:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR15MB1845255B3F2653601976A7C0C0F00@CY4PR15MB1845.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(305945005)(7736002)(2906002)(68736007)(6246003)(31686004)(86362001)(66066001)(71200400001)(31696002)(8676002)(8936002)(71190400001)(6512007)(81166006)(81156014)(6306002)(53936002)(478600001)(476003)(486006)(2616005)(966005)(446003)(11346002)(52116002)(229853002)(99286004)(6116002)(3846002)(14444005)(256004)(36756003)(25786009)(4326008)(76176011)(26005)(102836004)(186003)(6506007)(6436002)(53546011)(6486002)(386003)(316002)(110136005)(5660300002)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1845;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x5gjfXVpj5WcfAvDb5XHUbS7MJrWCEEDXszHy73lk1j70Y8CQvPg2X/f+A6L1RH4LQun+ivl8vtFOq7a8vpWhsFV6FiWfrtiUay+4hFHjHBG0gq9KX7+FtZ7P68sVfmd7ldGlP1KkCFnYJvtiSCPmP2uqIQrCbFAmuDpqnA+6ZSG8dCwci3tTVEpB5tCrEVmd/UMSU90/G1toZ9E9vYVC3Kv6m7gdm+8+oxl++ylc9Cn3JhnnxeOSjm0B5mxPzV2XQ0Xrx4L7Pe4DWcqobIYkaqr4O3ngoy/ZphBY4LCxyOc/dfK+2BYr3gXCRGjwnF/ML9oLWeliTzFf16zehYUdiXhI8qWxJXx02UiMl3wBGxWY5l8D2YzARIILoqPsCwHa1Rq6S42mdFsOXCiVfNM46Oq0GE0vPBY1LuZ6etrRXw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5295360051379F4F8D22936BF83DA262@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3825b3-4ca7-490d-be36-08d70576c47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:39:56.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axboe@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1845
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100237
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8xMC8xOSAyOjM1IFBNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gV2VkLCBKdWwg
MTAsIDIwMTkgYXQgMDI6MjM6MjNQTSAtMDYwMCwgSmVucyBBeGJvZSB3cm90ZToNCj4+IE9uIDcv
MTAvMTkgMTo1MiBQTSwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+Pj4gcnEtcW9zIHNpdHMgaW4gdGhl
IGlvIHBhdGggc28gd2Ugd2FudCB0byB0YWtlIGxvY2tzIGFzIHNwYXJpbmdseSBhcw0KPj4+IHBv
c3NpYmxlLiAgVG8gYWNjb21wbGlzaCB0aGlzIHdlIHRyeSBub3QgdG8gdGFrZSB0aGUgd2FpdHF1
ZXVlIGhlYWQgbG9jaw0KPj4+IHVubGVzcyB3ZSBhcmUgc3VyZSB3ZSBuZWVkIHRvIGdvIHRvIHNs
ZWVwLCBhbmQgd2UgaGF2ZSBhbiBvcHRpbWl6YXRpb24NCj4+PiB0byBtYWtlIHN1cmUgdGhhdCB3
ZSBkb24ndCBzdGFydmUgb3V0IGV4aXN0aW5nIHdhaXRlcnMuICBTaW5jZSB3ZSBjaGVjaw0KPj4+
IGlmIHRoZXJlIGFyZSBleGlzdGluZyB3YWl0ZXJzIGxvY2tsZXNzbHkgd2UgbmVlZCB0byBiZSBh
YmxlIHRvIHVwZGF0ZQ0KPj4+IG91ciB2aWV3IG9mIHRoZSB3YWl0cXVldWUgbGlzdCBhZnRlciB3
ZSd2ZSBhZGRlZCBvdXJzZWx2ZXMgdG8gdGhlDQo+Pj4gd2FpdHF1ZXVlLiAgQWNjb21wbGlzaCB0
aGlzIGJ5IGFkZGluZyB0aGlzIGhlbHBlciB0byBzZWUgaWYgdGhlcmUgYXJlDQo+Pj4gbW9yZSB0
aGFuIHR3byB3YWl0ZXJzIG9uIHRoZSB3YWl0cXVldWUuDQo+Pj4NCj4+PiBTdWdnZXN0ZWQtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlZiBC
YWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgaW5jbHVkZS9saW51
eC93YWl0LmggfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
d2FpdC5oIGIvaW5jbHVkZS9saW51eC93YWl0LmgNCj4+PiBpbmRleCBiNmY3N2NmNjBkZDcuLjg5
YzQxYTdiMzA0NiAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3dhaXQuaA0KPj4+ICsr
KyBiL2luY2x1ZGUvbGludXgvd2FpdC5oDQo+Pj4gQEAgLTEyNiw2ICsxMjYsMjcgQEAgc3RhdGlj
IGlubGluZSBpbnQgd2FpdHF1ZXVlX2FjdGl2ZShzdHJ1Y3Qgd2FpdF9xdWV1ZV9oZWFkICp3cV9o
ZWFkKQ0KPj4+ICAgIAlyZXR1cm4gIWxpc3RfZW1wdHkoJndxX2hlYWQtPmhlYWQpOw0KPj4+ICAg
IH0NCj4+PiAgICANCj4+PiArLyoqDQo+Pj4gKyAqIHdxX2hhc19tdWx0aXBsZV9zbGVlcGVycyAt
IGNoZWNrIGlmIHRoZXJlIGFyZSBtdWx0aXBsZSB3YWl0aW5nIHByY2Vzc2VzDQo+Pj4gKyAqIEB3
cV9oZWFkOiB3YWl0IHF1ZXVlIGhlYWQNCj4+PiArICoNCj4+PiArICogUmV0dXJucyB0cnVlIG9m
IHdxX2hlYWQgaGFzIG11bHRpcGxlIHdhaXRpbmcgcHJvY2Vzc2VzLg0KPj4+ICsgKg0KPj4+ICsg
KiBQbGVhc2UgcmVmZXIgdG8gdGhlIGNvbW1lbnQgZm9yIHdhaXRxdWV1ZV9hY3RpdmUuDQo+Pj4g
KyAqLw0KPj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgd3FfaGFzX211bHRpcGxlX3NsZWVwZXJzKHN0
cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQpDQo+Pj4gK3sNCj4+PiArCS8qDQo+Pj4gKwkg
KiBXZSBuZWVkIHRvIGJlIHN1cmUgd2UgYXJlIGluIHN5bmMgd2l0aCB0aGUNCj4+PiArCSAqIGFk
ZF93YWl0X3F1ZXVlIG1vZGlmaWNhdGlvbnMgdG8gdGhlIHdhaXQgcXVldWUuDQo+Pj4gKwkgKg0K
Pj4+ICsJICogVGhpcyBtZW1vcnkgYmFycmllciBzaG91bGQgYmUgcGFpcmVkIHdpdGggb25lIG9u
IHRoZQ0KPj4+ICsJICogd2FpdGluZyBzaWRlLg0KPj4+ICsJICovDQo+Pj4gKwlzbXBfbWIoKTsN
Cj4+PiArCXJldHVybiAhbGlzdF9pc19zaW5ndWxhcigmd3FfaGVhZC0+aGVhZCk7DQo+Pj4gK30N
Cj4+PiArDQo+Pj4gICAgLyoqDQo+Pj4gICAgICogd3FfaGFzX3NsZWVwZXIgLSBjaGVjayBpZiB0
aGVyZSBhcmUgYW55IHdhaXRpbmcgcHJvY2Vzc2VzDQo+Pj4gICAgICogQHdxX2hlYWQ6IHdhaXQg
cXVldWUgaGVhZA0KPj4NCj4+IFRoaXMgKGFuZCAyLzIpIGxvb2tzIGdvb2QgdG8gbWUsIGJldHRl
ciB0aGFuIHYxIGZvciBzdXJlLiBQZXRlci9JbmdvLA0KPj4gYXJlIHlvdSBPSyB3aXRoIGFkZGlu
ZyB0aGlzIG5ldyBoZWxwZXI/IEZvciByZWZlcmVuY2UsIHRoaXMgKGFuZCB0aGUNCj4+IG5leHQg
cGF0Y2gpIHJlcGxhY2UgdGhlIGFsdGVybmF0aXZlLCB3aGljaCBpcyBhbiBvcGVuLWNvZGluZyBv
Zg0KPj4gcHJlcGFyZV90b193YWl0KCk6DQo+Pg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYmxvY2svMjAxOTA3MTAxOTA1MTQuODY5MTEtMS1qb3NlZkB0b3hpY3BhbmRhLmNvbS8N
Cj4gDQo+IFlldCBhbm90aGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIGhhdmUgcHJlcGFyZV90b193
YWl0KigpIHJldHVybiB0aGlzDQo+IHN0YXRlLCBidXQgSSB0aGluayB0aGlzIGlzIG9rLg0KDQpX
ZSBkaWQgZGlzY3VzcyB0aGF0IGNhc2UsIGJ1dCBpdCBzZWVtcyBzb21ld2hhdCByYW5kb20gdG8g
aGF2ZSBpdA0KcmV0dXJuIHRoYXQgc3BlY2lmaWMgcGllY2Ugb2YgaW5mby4gQnV0IGl0J2Qgd29y
ayBmb3IgdGhpcyBjYXNlLg0KDQo+IFRoZSBzbXBfbWIoKSBpcyBzdXBlcmZsdW91cyAtLSBpbiB5
b3VyIHNwZWNpZmljIGNhc2UgLS0gc2luY2UNCj4gcHJlcHJhcmVfdG9fd2FpdCooKSBhbHJlYWR5
IGRvZXMgb25lIHRocm91Z2ggc2V0X2N1cnJlbnRfc3RhdGUoKS4NCj4gDQo+IFNvIHlvdSBjb3Vs
ZCBkbyB3aXRob3V0IGl0LCBJIHRoaW5rLg0KDQpCdXQgdGhhdCdzIHNwZWNpZmljIHRvIHRoaXMg
dXNlIGNhc2UuIE1heWJlIGl0J3MgdGhlIG9ubHkgb25lIHdlJ2xsDQpoYXZlLCBhbmQgdGhlbiBp
dCdzIGZpbmUsIGJ1dCBhcyBhIGdlbmVyaWMgaGVscGVyIGl0IHNlZW1zIHNhZmVyIHRvDQppbmNs
dWRlIHRoZSBzYW1lIG9yZGVyaW5nIHByb3RlY3Rpb24gYXMgd3FfaGFzX3NsZWVwZXIoKS4NCg0K
LS0gDQpKZW5zIEF4Ym9lDQoNCg==
