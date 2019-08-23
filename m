Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C72EC3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 17:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30092339D
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FqtTm08j";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cMYM1kAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfHWRRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:17:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388334AbfHWRRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 13:17:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NHEQok030832;
        Fri, 23 Aug 2019 10:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EMbGGIDoZW5C6lvhbRyBEIFT34Tjra2yQIOM8a12zfI=;
 b=FqtTm08jBeK/f/hyCbUGRUqSsD98Q7nwzKIzV0eDSWXoYk44tuaE/UWKTdgGwvZvhPwS
 7gLc+DOMci38c1IZdQoQTGmpD+gY2Ou9Xx1fb25Y2HNApxkf3zi5socMtgUHx8U5HTDs
 4IvR4YZmccvrmYc1M1lEEGM8vwE2HdxMh74= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ujkcb8a8u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Aug 2019 10:17:10 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 10:17:08 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 23 Aug 2019 10:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbzOeXHIyideYlfRyWl1ajwDQelGSp4UEXABZOGvFQh4c7GXkrs6cTz7JQLm6wLqXegOKu2xUWx7tKFAwwEkySO92qgnRj+890eFGzvxe4gQtoZKP6fLmvUGS91nkScq+Hs59c1UlYMrRSv5e7Hp6uBOnTdSkIUUqFH/r1Y9FA9NQJyCUg8RCW+pfG4d/8nyI81QzUEgV9faXB5cE0W7M36iJquJkpN/SELu6bJy4Vxs7q/PE7w8Wys9vJlUSD3Tc4shTOs6x9C/Go/EawWQStMFtyFYVMTo6GewOktx8m7q/hDCYtzpTI2Qsn3vhvabYoH7Yd3Ggpax8qs/17F2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMbGGIDoZW5C6lvhbRyBEIFT34Tjra2yQIOM8a12zfI=;
 b=K71MQzVPhdXNQVOw/FokBQscqBSrMLAtp0nH6xL0p2PMlWeFVQJ0OWrkkUyae/LjvaPxeWI8PUwiywzps8q3YpvfiJenwo3YOZeh1zkj1QFs5OV6VTRrQdULw5REtizZeDugEaTf1CjbaobNc1yx0G0eeAXHiaxRkfstf+D6Opbqmcj92C0IlQGT6jzea1qnXYXNCs3xdNzJhTibzFyUJ1rsMxZV4zlOOBgOe6fIMYgMiyFKxrPwrnEb/Z3ltlmO1PUyZUNEOfaO3FF93fpcXSVZyQ7PIapk4BURegpVKu6k849dILB/FYvPQKis8SIWoWBonjvFJTAnHncWoKbLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMbGGIDoZW5C6lvhbRyBEIFT34Tjra2yQIOM8a12zfI=;
 b=cMYM1kATN55KfzhtOMUdFJsAyjcKpw3MN1snhoPDNPMf4y9+ai2zyOML78oahXUhJAK1uDgcCkni20gRpdEC5FR0IGofu3eTgCJbjZtxkfaRU1Y7kcGvrlNlgscAurAkDo991vy1z+AqNiHldAynw51gvQschF+vWydOqeQqRPw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1136.namprd15.prod.outlook.com (10.175.9.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 17:17:07 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 17:17:07 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Coly Li <colyli@suse.de>
CC:     NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC] How to handle an ugly md raid0 sector map bug ?
Thread-Topic: [RFC] How to handle an ugly md raid0 sector map bug ?
Thread-Index: AQHVWNXFc8cICUByoEiFXxVSkRSaLqcH2lYAgAEWFYCAAAdngIAAA68A
Date:   Fri, 23 Aug 2019 17:17:06 +0000
Message-ID: <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
 <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
In-Reply-To: <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::333a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7029fb27-c188-4ec5-fb7f-08d727edb995
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1136;
x-ms-traffictypediagnostic: MWHPR15MB1136:
x-microsoft-antispam-prvs: <MWHPR15MB11366689437A6D682083BC40B3A40@MWHPR15MB1136.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(305945005)(66946007)(86362001)(53546011)(6506007)(57306001)(7736002)(66446008)(46003)(14454004)(2906002)(76116006)(33656002)(64756008)(66556008)(476003)(229853002)(11346002)(6116002)(256004)(316002)(6436002)(446003)(14444005)(5660300002)(8676002)(81156014)(81166006)(54906003)(2616005)(6512007)(66476007)(36756003)(71200400001)(186003)(25786009)(102836004)(6246003)(4326008)(486006)(6916009)(6486002)(76176011)(50226002)(8936002)(53936002)(71190400001)(478600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1136;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YjlW1rxGErH8OnQ7Nk6y+sqyRAu6iaLRcCEt8hV51J+XOiLecHf1L9u9OLrH2ZwiqqjgPf7Iv566kj8zc5xoVuYtCptNzQN677QtRTnd1vj8j8vzSJxBeDIpkRgr6PXs0vYChvamLZ9p7apmOwRfu530oZpNRXTonyj0DxPkZ22k254kUXm75bWHMqG9Vk3uXQu/12nvNZT8QWd/Q7Xvrw0Azq4xb2eS0y0p2f9lW1szl4jtx7KCMWLQa8TujAv2rZ49b++G+iNFEh+L6y4dtBxUd3F8OL2L3xcNUAsFcGxLutYADitW5bIvzlVE+6JGMI03ihps9MJOkF2qj3BtWgea+P/EIjouYtAZAobX5Vototz1Mbyhl5qCw7Uya5A8Td0HKmXYLwp9Z0lHxNQGe7pfj7L/EzZIHGQAXK46A0I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <64B7C951DA339A4BB16BB1A00CD091A0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7029fb27-c188-4ec5-fb7f-08d727edb995
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 17:17:06.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9ogfe9mg5MlepHp6Kx1FqKj6iLHzFVgw8R4sZWLc8bl7oNQbLM9DM/jUlqENJNyEVs6maSdQB4zY7OZVsjmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1136
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230166
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gQXVnIDIzLCAyMDE5LCBhdCAxMDowMyBBTSwgQ29seSBMaSA8Y29seWxpQHN1c2Uu
ZGU+IHdyb3RlOg0KPiANCj4gT24gMjAxOS84LzI0IDEyOjM3IOS4iuWNiCwgU29uZyBMaXUgd3Jv
dGU6DQo+PiBUaGFua3MgQ29seSBhbmQgTmVpbC4gDQo+PiANCj4+PiBPbiBBdWcgMjIsIDIwMTks
IGF0IDU6MDIgUE0sIE5laWxCcm93biA8bmVpbGJAc3VzZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFRodSwgQXVnIDIyIDIwMTksIENvbHkgTGkgd3JvdGU6DQo+Pj4gDQo+Pj4+IEhpIGZvbGtz
LA0KPj4+PiANCj4+Pj4gRmlyc3QgbGluZTogVGhpcyBidWcgb25seSBpbmZsdWVuY2VzIG1kIHJh
aWQwIGRldmljZSB3aGljaCBhcHBsaWVzIGFsbA0KPj4+PiB0aGUgZm9sbG93aW5nIGNvbmRpdGlv
bnMsDQo+Pj4+IDEpIEFzc2VtYmxlZCBieSBjb21wb25lbnQgZGlza3Mgd2l0aCBkaWZmZXJlbnQg
c2l6ZXMuDQo+Pj4+IDIpIENyZWF0ZWQgYW5kIHVzZWQgdW5kZXIgTGludXgga2VybmVsIGJlZm9y
ZSAoaW5jbHVkaW5nKSBMaW51eCB2My4xMiwNCj4+Pj4gdGhlbiB1cGdyYWRlIHRvIExpbnV4IGtl
cm5lbCBhZnRlciAoaW5jbHVkaW5nKSBMaW51eCB2My4xMy4NCj4+Pj4gMykgTmV3IGRhdGEgYXJl
IHdyaXR0ZW4gdG8gbWQgcmFpZDAgaW4gbmV3IGtlcm5lbCA+PSBMaW51eCB2My4xMy4NCj4+Pj4g
VGhlbiB0aGUgbWQgcmFpZDAgbWF5IGhhdmUgaW5jb25zaXN0ZW50IHNlY3RvciBtYXBwaW5nIGFu
ZCBleHBlcmllbmNlDQo+Pj4+IGRhdGEgY29ycnVwdGlvbi4NCj4+Pj4gDQo+Pj4+IFJlY2VudGx5
IEkgcmVjZWl2ZSBhIGJ1ZyByZXBvcnQgdGhhdCBjdXN0b21lciBlbmNvdW50ZXIgZmlsZSBzeXN0
ZW0NCj4+Pj4gY29ycnVwdGlvbiBhZnRlciB1cGdyYWRpbmcgdGhlaXIga2VybmVsIGZyb20gTGlu
dXggMy4xMiB0byA0LjQuIEl0IHR1cm5zDQo+Pj4+IG91dCB0byBiZSB0aGUgdW5kZXJseWluZyBt
ZCByYWlkMCBjb3JydXB0aW9uIGFmdGVyIHRoZSBrZXJuZWwgdXBncmFkZS4NCj4+Pj4gDQo+Pj4+
IEkgZmluZCBpdCBpcyBiZWNhdXNlIGEgc2VjdG9yIG1hcCBidWcgaW4gbWQgcmFpZDAgY29kZSBp
bmNsdWRlIGFuZA0KPj4+PiBiZWZvcmUgTGludXggdjMuMTIuIEhlcmUgaXMgdGhlIGJ1Z2d5IGNv
ZGUgcGllY2UgSSBjb3BpZWQgZnJvbSBzdGFibGUNCj4+Pj4gTGludXggdjMuMTIuNzQgZHJpdmVy
cy9tZC9yYWlkMC5jOnJhaWQwX21ha2VfcmVxdWVzdCgpLA0KPj4+PiANCj4+Pj4gNTQ3ICAgICAg
ICAgc2VjdG9yX29mZnNldCA9IGJpby0+Ymlfc2VjdG9yOw0KPj4+PiA1NDggICAgICAgICB6b25l
ID0gZmluZF96b25lKG1kZGV2LT5wcml2YXRlLCAmc2VjdG9yX29mZnNldCk7DQo+Pj4+IDU0OSAg
ICAgICAgIHRtcF9kZXYgPSBtYXBfc2VjdG9yKG1kZGV2LCB6b25lLCBiaW8tPmJpX3NlY3RvciwN
Cj4+Pj4gNTUwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNlY3Rvcl9vZmZzZXQpOw0K
Pj4+IA0KPj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBjb2RlIGlzIGJ1Z2d5LiAgVGhlIG1hcHBpbmcg
bWF5IG5vdCBiZSB0aGUgbWFwcGluZw0KPj4+IHlvdSB3b3VsZCBleHBlY3QsIGJ1dCBpdCBpcyB0
aGUgbWFwcGluZyB0aGF0IG1kL3JhaWQwIGhhZCBhbHdheXMgdXNlZCB1cA0KPj4+IHRvIHRoaXMg
dGltZS4NCj4+PiANCj4+Pj4gDQo+Pj4+IEF0IGxpbmUgNTQ4IGFmdGVyIGZpbmRfem9uZSgpIHJl
dHVybnMsIHNlY3Rvcl9vZmZzZXQgaXMgdXBkYXRlZCB0byBiZSBhbg0KPj4+PiBvZmZzZXQgaW5z
aWRlIGN1cnJlbnQgem9uZS4gVGhlbiBhdCBsaW5lIDU0OSB0aGUgdGhpcmQgcGFyYW1ldGVyIG9m
DQo+Pj4+IGNhbGxpbmcgbWFwX3NlY3RvcigpIHNob3VsZCBiZSB0aGUgdXBkYXRlZCBzZWN0b3Jf
b2Zmc2V0LCBidXQNCj4+Pj4gYmlvLT5iaV9zZWN0b3IgKG9yaWdpbmFsIExCQSBvciBtZCByYWlk
MCBkZXZpY2UpIGlzIHVzZWQuIElmIHRoZSByYWlkMA0KPj4+PiBkZXZpY2UgaGFzICptdWx0aXBs
ZSB6b25lcyosIGV4Y2VwdCB0aGUgZmlyc3Qgem9uZSwgdGhlIG1hcHBpbmcgPGRldiwNCj4+Pj4g
c2VjdG9yPiBwYWlyIHJldHVybmVkIGJ5IG1hcF9zZWN0b3IoKSBmb3IgYWxsIHJlc3RlZCB6b25l
cyBhcmUNCj4+Pj4gdW5leHBlY3RlZCBhbmQgd3JvbmcuDQo+Pj4+IA0KPj4+PiBUaGUgYnVnZ3kg
Y29kZSB3YXMgaW50cm9kdWNlZCBzaW5jZSBMaW51eCB2Mi42LjMxIGluIGNvbW1pdCBmYmI3MDRl
ZmI3ODQNCj4+Pj4gKCJtZDogcmFpZDAgOkVuYWJsZXMgY2h1bmsgc2l6ZSBvdGhlciB0aGFuIHBv
d2VycyBvZiAyLiIpLCB1bmZvcnR1bmF0ZQ0KPj4+PiB0aGUgbWlzdGFrZW4gbWFwcGluZyBjYWxj
dWxhdGlvbiBoYXMgc3RhYmxlIGFuZCB1bmlxdWUgcmVzdWx0IHRvbywgc28gaXQNCj4+Pj4gd29y
a3Mgd2l0aG91dCBvYnZpb3VzIHByb2JsZW0gdW50aWwgY29tbWl0IDIwZDAxODliMTAxMiAoImJs
b2NrOg0KPj4+PiBJbnRyb2R1Y2UgbmV3IGJpb19zcGxpdCgpIikgbWVyZ2VkIGludG8gTGludXgg
djMuMTMuDQo+Pj4+IA0KPj4+PiBUaGlzIHBhdGNoIGZpeGVkIHRoZSBtaXN0YWtlbiBtYXBwaW5n
IGluIHRoZSBmb2xsb3dpbmcgbGluZXMgb2YgY2hhbmdlLA0KPj4+PiA2NTQgLSAgICAgICBzZWN0
b3Jfb2Zmc2V0ID0gYmlvLT5iaV9pdGVyLmJpX3NlY3RvcjsNCj4+Pj4gNjU1IC0gICAgICAgem9u
ZSA9IGZpbmRfem9uZShtZGRldi0+cHJpdmF0ZSwgJnNlY3Rvcl9vZmZzZXQpOw0KPj4+PiA2NTYg
LSAgICAgICB0bXBfZGV2ID0gbWFwX3NlY3RvcihtZGRldiwgem9uZSwgYmlvLT5iaV9pdGVyLmJp
X3NlY3RvciwNCj4+Pj4gNjU3IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNlY3Rvcl9v
ZmZzZXQpOw0KPj4+PiANCj4+Pj4gNjk0ICsgICAgICAgICAgICAgICB6b25lID0gZmluZF96b25l
KG1kZGV2LT5wcml2YXRlLCAmc2VjdG9yKTsNCj4+Pj4gNjk1ICsgICAgICAgICAgICAgICB0bXBf
ZGV2ID0gbWFwX3NlY3RvcihtZGRldiwgem9uZSwgc2VjdG9yLCAmc2VjdG9yKTsNCj4+Pj4gQXQg
bGluZSA2OTUgb2YgdGhpcyBwYXRjaCwgdGhlIHRoaXJkIHBhcmFtZXRlciBvZiBjYWxsaW5nIG1h
cF9zZWN0b3IoKQ0KPj4+PiBpcyBmaXhlZCB0byAnc2VjdG9yJywgdGhpcyBpcyB0aGUgY29ycmVj
dCB2YWx1ZSB3aGljaCBjb250YWlucyB0aGUNCj4+Pj4gc2VjdG9yIG9mZnNldCBpbnNpZGUgdGhl
IGNvcnJlc3BvbmRpbmcgem9uZS4NCj4+PiANCj4+PiBUaGlzIGlzIGJ1Z2d5IGJlY2F1c2UsIGFz
IHlvdSBzYXksIHRoZSB0aGlyZCBhcmd1bWVudCB0byBtYXBfc2VjdG9yIGhhcw0KPj4+IGNoYW5n
ZWQuDQo+Pj4gUHJldmlvdXNseSBpdCB3YXMgYmlvLT5iaV9pdGVyLmJpX3NlY3Rvci4gIE5vdyBp
dCBpcyAnc2VjdG9yJyB3aGljaA0KPj4+IGZpbmRfem9uZSBoYXMganVzdCBtb2RpZmllZC4NCj4+
PiANCj4+Pj4gDQo+Pj4+IFRoZSB0aGlzIHBhdGNoIGltcGxpY2l0bHkgKmNoYW5nZXMqIG1kIHJh
aWQwIG9uLWRpc2sgbGF5b3V0LiBJZiBhIG1kDQo+Pj4+IHJhaWQwIGhhcyBjb21wb25lbnQgZGlz
a3Mgd2l0aCAqZGlmZmVyZW50KiBzaXplcywgdGhlbiBpdCB3aWxsIGNvbnRhaW4NCj4+Pj4gbXVs
dGlwbGUgem9uZXMuIElmIHN1Y2ggbXVsdGlwbGUgem9uZXMgcmFpZDAgZGV2aWNlIGlzIGNyZWF0
ZWQgYmVmb3JlDQo+Pj4+IExpbnV4IHYzLjEzLCBhbGwgZGF0YSBjaHVua3MgYWZ0ZXIgZmlyc3Qg
em9uZSB3aWxsIGJlIG1hcHBlZCB0bw0KPj4+PiBkaWZmZXJlbnQgbG9jYXRpb24gaW4ga2VybmVs
IGFmdGVyIChpbmNsdWRpbmcpIExpbnV4IHYzLjEzLiBUaGUgcmVzdWx0DQo+Pj4+IGlzLCBkYXRh
IHdyaXR0ZW4gaW4gdGhlIExCQSBhZnRlciBmaXJzdCB6b25lIHdpbGwgYmUgdHJlYXRlZCBhcw0K
Pj4+PiBjb3JydXB0aW9uLiBBIHdvcnNlIGNhc2UgaXMsIGlmIHRoZSBtZCByYWlkMCBoYXMgZGF0
YSBjaHVua3MgZmlsbGVkIGluDQo+Pj4+IGZpcnN0IG1kIHJhaWQwIHpvbmUgaW4gTGludXggdjMu
MTIgKG9yIGVhcmxpZXIga2VybmVscyksIHRoZW4gdXBkYXRlIHRvDQo+Pj4+IExpbnV4IHYzLjEz
IChvciBsYXRlciBrZXJuZWxzKSBhbmQgZmlsbCBtb3JlIGRhdGEgY2h1bmtzIGluIHNlY29uZCBh
bmQNCj4+Pj4gcmVzdGVkIHpvbmUuIFRoZW4gaW4gbmVpdGhlciBMaW51eCB2My4xMiBubyBMaW51
eCB2My4xMywgdGhlcmUgaXMgYWx3YXlzDQo+Pj4+IHBhcnRpYWwgZGF0YSBjb3JydXB0ZWQuDQo+
Pj4+IA0KPj4+PiBDdXJyZW50bHkgdGhlcmUgaXMgbm8gd2F5IHRvIHRlbGwgd2hldGhlciBhIG1k
IHJhaWQwIGRldmljZSBpcyBtYXBwZWQgaW4NCj4+Pj4gd3JvbmcgY2FsY3VsYXRpb24gaW4ga2Vy
bmVsIGJlZm9yZSAoaW5jbHVkaW5nKSBMaW51eCB2My4xMiBvciBpbiBjb3JyZWN0DQo+Pj4+IGNh
bGN1bGF0aW9uIGluIGtlcm5lbHMgYWZ0ZXIgKGluY2x1ZGluZykgTGludXggdjMuMTMuIElmIGEg
bWQgcmFpZDANCj4+Pj4gZGV2aWNlIChjb250YWlucyBtdWx0aXBsZSB6b25lcykgY3JlYXRlZCBh
bmQgdXNlZCBjcm9zc2luZyB0aGVzZSBrZXJuZWwNCj4+Pj4gdmVyc2lvbiwgdGhlcmUgaXMgcG9z
c2liaWxpdHkgYW5kIGRpZmZlcmVudCBtYXBwaW5nIGNhbGN1bGF0aW9uDQo+Pj4+IGdlbmVyYXRp
b24gZGlmZmVyZW50L2luY29uc2lzdGVudCBvbi1kaXNrIGxheW91dCBpbiBkaWZmZXJlbnQgbWQg
cmFpZDANCj4+Pj4gem9uZXMsIGFuZCByZXN1bHRzIGRhdGEgY29ycnVwdGlvbi4NCj4+Pj4gDQo+
Pj4+IEZvciBvdXIgZW50ZXJwcmlzZSBMaW51eCBwcm9kdWN0cyB3ZSBjYW4gaGFuZGxlIGl0IHBy
b3Blcmx5IGZvciBhIGZldw0KPj4+PiBwcm9kdWN0IG51bWJlciBvZiBrZXJuZWxzLiBCdXQgZm9y
IHVwc3RyZWFtIGFuZCBzdGFibGUga2VybmVscywgSSBkb24ndA0KPj4+PiBoYXZlIGlkZWEgaG93
IHRvIGZpeCB0aGlzIHVnbHkgcHJvYmxlbSBpbiBhIGdlbmVyaWMgd2F5Lg0KPj4+PiANCj4+Pj4g
TmVpbCBCcm93biBkaXNjdXNzZWQgd2l0aCBtZSBvZmZsaW5lLCBoZSBwcm9wb3NlZCBhIHRlbXBv
cmFyeSB3b3JrYXJvdW5kDQo+Pj4+IHRoYXQgb25seSBwZXJtaXQgdG8gYXNzZW1ibGUgbWQgcmFp
ZDAgZGV2aWNlIHdpdGggaWRlbnRpY2FsIGNvbXBvbmVudA0KPj4+PiBkaXNrIHNpemUsIGFuZCBy
ZWplY3QgdG8gYXNzZW1ibGUgbWQgcmFpZDAgZGV2aWNlIHdpdGggY29tcG9uZW50IGRpc2tzDQo+
Pj4+IHdpdGggZGlmZmVyZW50IHNpemVzLiBXZSBjYW4gc3RvcCB0aGlzIHdvcmthcm91bmQgd2hl
biB0aGVyZSBpcyBhIHByb3Blcg0KPj4+PiB3YXkgdG8gZml4IHRoZSBwcm9ibGVtLg0KPj4+PiAN
Cj4+Pj4gSSBzdWdnZXN0IG91ciBkZXZlbG9wZXIgY29tbXVuaXR5IHRvIHdvcmsgdG9nZXRoZXIg
Zm9yIGEgc29sdXRpb24sIHRoaXMNCj4+Pj4gaXMgdGhlIG1vdGl2YXRpb24gSSBwb3N0IHRoaXMg
ZW1haWwgZm9yIHlvdXIgY29tbWVudHMuDQo+Pj4gDQo+Pj4gVGhlcmUgYXJlIGZvdXIgc2VwYXJh
dGUgY2FzZXMgdGhhdCB3ZSBuZWVkIHRvIGNvbnNpZGVyOg0KPj4+IC0gdjEueCBtZXRhZGF0YQ0K
Pj4+IC0gdjAuOTAgbWV0YWRhdGENCj4+PiAtIExWTSBtZXRhZGF0YSAodmlhIGRtLXJhaWQpDQo+
Pj4gLSBubyBtZXRhZGF0YSAoYXJyYXkgY3JlYXRlZCB3aXRoICJtZGFkbSAtLWJ1aWxkIikuDQo+
Pj4gDQo+Pj4gRm9yIHYxLnggbWV0YWRhdGEsIEkgdGhpbmsgd2UgY2FuIGFkZCBhIG5ldyAiZmVh
dHVyZV9tYXAiIGZsYWcuDQo+Pj4gSWYgdGhpcyBmbGFnIGlzbid0IHNldCwgcmFpZDAgd2l0aCBu
b24tdW5pZm9ybSBkZXZpY2Ugc2l6ZXMgd2lsbCBub3QgYmUNCj4+PiBhc3NlbWJsZWQuDQo+Pj4g
SWYgaXQgaXMgc2V0LCB0aGVuOg0KPj4+IGlmICdsYXlvdXQnIGlzIDAsIHVzZSB0aGUgb2xkIG1h
cHBpbmcNCj4+PiBpZiAnbGF5b3V0JyBpcyAxLCB1c2UgdGhlIG5ldyBtYXBwaW5nDQo+Pj4gDQo+
Pj4gRm9yIHYwLjkwIG1ldGFkYXRhIHdlIGRvbid0IGhhdmUgZmVhdHVyZS1mbGFncy4gIFdlIGNv
dWxkDQo+Pj4gVGhlIGd2YWxpZF93b3JkcyBmaWVsZCBpcyB1bnVzZWQgYW5kIGFsd2F5cyBzZXQg
dG8gemVyby4NCj4+PiBTbyB3ZSBjb3VsZCBzdGFydCBzdG9yaW5nIHNvbWUgZmVhdHVyZSBiaXRz
IHRoZXJlLg0KPj4+IA0KPj4+IEZvciBMVk0vZG0tcmFpZCwgSSBzdXNwZWN0IGl0IGRvZXNuJ3Qg
c3VwcG9ydCB2YXJ5aW5nDQo+Pj4gc2l6ZWQgZGV2aWNlcywgYnV0IHdlIHdvdWxkIG5lZWQgdG8g
Y2hlY2suDQo+Pj4gDQo+Pj4gRm9yICJubyBtZXRhZGF0YSIgYXJyYXlzIC4uLiB3ZSBjb3VsZCBw
b3NzaWJseSBqdXN0IHN0b3Agc3VwcG9ydGluZw0KPj4+IHRoZW0gLSBJIGRvdWJ0IHRoZXkgYXJl
IHVzZWQgbXVjaC4NCj4+IA0KPj4gU28gZm9yIGFuIGV4aXN0aW5nIGFycmF5LCB3ZSByZWFsbHkg
Y2Fubm90IHRlbGwgd2hldGhlciBpdCBpcyBicm9rZW4gb3IgDQo+PiBub3QsIHJpZ2h0PyBJZiB0
aGlzIGlzIHRoZSBjYXNlLCB3ZSBvbmx5IG5lZWQgdG8gd29ycnkgYWJvdXQgbmV3IGFycmF5cy4N
Cj4+IA0KPj4gRm9yIG5ldyBhcnJheXMsIEkgZ3Vlc3Mgd2UgY2FuIG9ubHkgYWxsb3cgdjEueCBy
YWlkMCB0byBoYXZlIG5vbi11bmlmb3JtDQo+PiBkZXZpY2VzIHNpemVzLCBhbmQgdXNlIHRoZSBu
ZXcgZmVhdHVyZV9tYXAgYml0LiANCj4+IA0KPj4gV291bGQgdGhpcyB3b3JrPyBJZiBzbywgd2Ug
b25seSBoYXZlIDEgY2FzZSB0byB3b3JrIG9uLiANCj4gDQo+IEl0IHNlZW1zIHYxLjIgc3VwcG9y
dCBzdGFydGVkIHNpbmNlIExpbnV4IHYyLjE2LCBzbyBpdCBtYXkgYWxzbyBoYXZlDQo+IHByb2Js
ZW0gZm9yIG11bHRpcGxlIHpvbmVzLg0KPiANCg0KRm9yIHYxLjIgbWV0YWRhdGEsIHdlIHN0aWxs
IG5lZWQgdGhlIGZlYXR1cmVfbWFwIGJpdCwgbWVhbmluZyB0aGlzIA0Kbm9uLXVuaWZvcm0gYXJy
YXkgaXMgc2FmZSB0byBhc3NlbWJsZS4gSWYgdGhlIGFycmF5IGRvZXNuJ3QgaGF2ZSANCnRoaXMg
Yml0LCBhbmQgaXMgbm9uLXVuaWZvcm0gc2l6ZSwgd2UgcmVmdXNlIHRvIGFzc2VtYmxlIGl0LiAN
Cg0KVGhhbmtzLA0KU29uZw0KDQoNCg0KDQo=
