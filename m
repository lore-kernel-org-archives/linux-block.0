Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE3C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 09:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D611A2063F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kXtMECp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfCRJYz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:24:55 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:40286
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfCRJYz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 05:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIA08EZZx847Y0q03Ii+xv2duZOS+1lWL617NBQNokg=;
 b=kXtMECp3TCY639j2pm8FocT60aAsRTg3cLDFCRp5ZrxBaRgCGPVjPg5JpU124eJjCcyDw9+Zqx7GCXrQrIx5BWEHiWqnOAC8dW0RtfbwKzRWxk89O00/XsT+/HNi0gWnHqG0v1UmoofZLAoSH1MGnqP18kWQPxMnp18nMtfRStA=
Received: from AM4PR0501MB2257.eurprd05.prod.outlook.com (10.165.82.134) by
 AM4PR0501MB2305.eurprd05.prod.outlook.com (10.165.82.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 09:24:50 +0000
Received: from AM4PR0501MB2257.eurprd05.prod.outlook.com
 ([fe80::5499:d83f:af8a:da69]) by AM4PR0501MB2257.eurprd05.prod.outlook.com
 ([fe80::5499:d83f:af8a:da69%9]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:24:50 +0000
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
Thread-Topic: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
Thread-Index: AQHU0/lqcdRFeZasR0OH34LRhfNLg6X+x6WAgACiW4CAC6TkAIAGIgMA
Date:   Mon, 18 Mar 2019 09:24:50 +0000
Message-ID: <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
In-Reply-To: <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0112.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::17) To AM4PR0501MB2257.eurprd05.prod.outlook.com
 (2603:10a6:200:53::6)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yaminf@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02fb6391-b4f4-4ca1-ece5-08d6ab8391dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2305;
x-ms-traffictypediagnostic: AM4PR0501MB2305:
x-microsoft-antispam-prvs: <AM4PR0501MB2305D90D6DE004FE777AB36FB1470@AM4PR0501MB2305.eurprd05.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(51444003)(189003)(199004)(478600001)(68736007)(6116002)(8936002)(3846002)(97736004)(102836004)(31686004)(14454004)(8676002)(93886005)(2906002)(6246003)(11346002)(6436002)(446003)(36756003)(81166006)(81156014)(186003)(107886003)(25786009)(71190400001)(71200400001)(6486002)(6512007)(316002)(66066001)(2201001)(486006)(31696002)(86362001)(110136005)(476003)(2616005)(5660300002)(229853002)(305945005)(54906003)(26005)(7736002)(106356001)(6506007)(4326008)(76176011)(386003)(105586002)(2501003)(99286004)(53546011)(14444005)(52116002)(256004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2305;H:AM4PR0501MB2257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kgg/VwJa4b34sAe4XwivJJZLtr6aHJn9cINfDCeNcFdHJ8GXdA9BDk7UV19Oabq84qri60ExxhUtZgPPTmMQiTm9Ne18uTcAEMOQvq85N6xSfespB3DvSEhAWRH0kkHKjt9vKsMFbB1d3e9OlCzZEzhuT7mcZZSJwcV68MMGpfj+myQqbebbamFCyI7HNQMwoPBZpHjGcsFbrvFuFnW+WGRFSEyQfWqc60QcGPOFrsMFwGFgsviNgTaPIdSXkJt2vCcytZMTTRy3pUUHE5SDYJf8QAHZXuJkcxhpfzHbONU5FRiyATxA0WEKoAYaz4ItuRHwHb5jyZAINLu3aOKsH58ysdbv26xGGNA938ON5YU9d4aKl5mMYi1vaa11Hmpl6SiLQim36DhJVCcjlw6jvkYrVXS7qpgzIywDltUayfk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F39091EE63D86A4A8CE940C02D984987@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb6391-b4f4-4ca1-ece5-08d6ab8391dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:24:50.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2305
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQpPbiAzLzE0LzIwMTkgMTo0NSBQTSwgTWF4IEd1cnRvdm95IHdyb3RlOg0KPg0KPiBPbiAzLzcv
MjAxOSAzOjU2IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4NCj4+Pj4gbmV0X2RpbS5oIGxp
YiBleHBvc2VzIGFuIGltcGxlbWVudGF0aW9uIG9mIHRoZSBESU0gYWxnb3JpdGhtIGZvciANCj4+
Pj4gZHluYW1pY2FsbHktdHVuZWQgaW50ZXJydXB0DQo+Pj4+IG1vZGVyYXRpb24gZm9yIG5ldHdv
cmtpbmcgaW50ZXJmYWNlcy4NCj4+Pj4NCj4+Pj4gV2UgbmVlZCB0aGUgc2FtZSBiZWhhdmlvciBm
b3IgYW55IGJsb2NrIENRLiBUaGUgbWFpbiBtb3RpdmF0aW9uIGlzIA0KPj4+PiB0d28gYmVuZWZp
dCBmcm9tIG1heGltaXplZA0KPj4+PiBjb21wbGV0aW9uIHJhdGUgYW5kIHJlZHVjZWQgaW50ZXJy
dXB0IG92ZXJoZWFkIHRoYXQgRElNIG1heSBwcm92aWRlLg0KPj4+DQo+Pj4gV2hhdCBpcyBhICJi
bG9jayBDUSI/DQo+Pg0KPj4gVGhlcmUgaXMgbm8gc3VjaCB0aGluZy4uLiBBbHNvLCB0aGlzIGhh
cyBubyBkaWZmZXJlbmNlDQo+PiBpZiBhIGJsb2NrL2ZpbGUvd2hhdGV2ZXIgaXMgdXNpbmcgdGhl
IHJkbWEgY3EuDQo+Pg0KPj4gVGhlIG5hbWluZyBzaG91bGQgcmVhbGx5IGJlIHNvbWV0aGluZyBs
aWtlIHJkbWFfZGltIGFzIGl0IGFjY291bnRzDQo+PiBmb3IgY29tcGxldGlvbnMgYW5kIG5vdCBi
eXRlcy9wYWNrZXRzLg0KPg0KPiBTYWdpLA0KPg0KPiBJIHRoaW5rIHRoYXQgaW4gdGhlIGZ1dHVy
ZSB3ZSBjb3VsZCB1c2UgaXQgaW4gbnZtZSBzaW5jZSB0aGVyZSBpcyBhbiANCj4gb3B0aW9uIHRv
IHNldCB0aGUgaW50ZXJydXB0IGNvYWxlc2NpbmcgaW4gTlZNZSBzcGVjLg0KPg0KPiBUaGlzIG1p
Z2h0IGltcHJvdmUgcGVyZm9ybWFuY2UgZm9yIE5WTWUgZHJpdmVyLg0KPg0KPiBXZSBhbHJlYWR5
IHNlZSBzb21lIGJvdHRsZW5lY2tzIGluIHBlcmZvcm1hbmNlIChtYXliZSBkcml2ZXIgb25lcykg
DQo+IHdoaWxlIGRldmVsb3BpbmcgdGhlIE5WTWUgU05BUCBmZWF0dXJlIGluIEJsdWVmaWVsZCAo
TlZNZSBlbXVsYXRpb24gDQo+IHVzaW5nIFNtYXJ0IE5JQykuDQo+DQo+IFdlJ3JlIHRyeWluZyB0
byBnZXQgMi41LTIuNyBNSU9QcyBPT0IgZnJvbSAxIGNvbnRyb2xsZXIgYW5kIGl0J3Mgbm90IA0K
PiB0cml2aWFsIGZvciB0b2RheSdzIGRyaXZlci4NCj4NCj4gU28gbGV0J3MgdGFrZSB0aGlzIGlu
dG8gY29uc2lkZXJhdGlvbiB3aGVuIHdlIHNldCB0aGUgbmFtaW5nLg0KPg0KPg0KSSBhZ3JlZSB0
aGF0IGJsayBpcyBub3QgdGhlIG1vc3Qgc3VjY2Vzc2Z1bCBuYW1lLCB3ZSB3ZXJlIHRyeWluZyB0
byBmaW5kIA0Kc29tZXRoaW5nIHRoYXQgd291bGQgd29yayBmb3IgZ2VuZXJhbCBzdG9yYWdlIGFw
cGxpY2F0aW9ucy4gSSB0aGluayANCnJkbWFfZGltIHdvdWxkIHdvcmsgYXMgaXQgaXMgY29tcGxl
dGlvbiBiYXNlZCBidXQgdGhlbiB3aGVuIHdlIHdhbnQgdG8gDQp1c2UgaXQgZm9yIG52bWUgaXQg
d2lsbCBwcm9iYWJseSByZXF1aXJlIGNvZGUgZHVwbGljYXRpb24uDQoNCj4+DQo+Pg0KPj4+IEhv
dyBkb2VzIG5ldF9kaW0gY29tcGFyZSB0byBsaWIvaXJxX3BvbGw/DQo+Pg0KPj4gSXRzIG9ydGhv
Z29uYWwsIGl0cyBiYXNpY2FsbHkgYWRhcHRpdmUgaW50ZXJydXB0IG1vZGVyYXRpb24gZm9yDQo+
PiBSRE1BIGRldmljZXMuIEl0cyBzb3J0IG9mIGJlbG93IHRoZSBpcnFfcG9sbCBjb2RlLiBJdCBi
YXNpY2FsbHkNCj4+IGNvbmZpZ3VyZXMgaW50ZXJydXB0IG1vZGVyYXRpb24gYmFzZWQgb24gc3Rh
dHMgY29sbGVjdGVkIGJ5DQo+PiB0aGUgcmRtYSBkcml2ZXIuDQo+Pg0KPj4+IFdoaWNoIGFwcHJv
YWNoIHJlc3VsdHMgaW4gdGhlIGJlc3QgcGVyZm9ybWFuY2UgYW5kIGxvd2VzdCBsYXRlbmN5Pw0K
Pj4NCj4+IEkgZ3Vlc3MgaXQgZGVwZW5kcyBvbiB3aGF0IGlzIHRoZSB0ZXN0IGNhc2UuIFRoaXMg
YXBwcm9hY2ggdHJpZXMgdG8NCj4+IGFwcGx5IHNvbWUgdGltZSBvciBjb21wbGV0aW9uIGNvdW50
IGxpbWl0IHRvIHdoZW4gdGhlIEhXIHNob3VsZCBmaXJlDQo+PiBhbiBpbnRlcnJ1cHQgYmFzZWQg
b24gdGhlIGxvYWQgaW4gYW4gYWRhcHRpdmUgZmFzaGlvbi4NCj4+DQo+PiBUaGUgc2NoZW1lIGlz
IHRvIHRyeSBhbmQgZGV0ZWN0IHdoYXQgYXJlIHRoZSBsb2FkIGNoYXJhY3RlcmlzdGljcyBhbmQN
Cj4+IGNvbWUgdXAgd2l0aCBhIG1vZGVyYXRpb24gcGFyYW1ldGVycyB0aGF0IGZpdC4gRm9yIGhp
Z2ggaW50ZXJydXB0IHJhdGUNCj4+ICh1c3VhbGx5IHNlZW4gd2l0aCBzbWFsbCBzaXplIGhpZ2gg
cXVldWUtZGVwdGggd29ya2xvYWRzKSBpdCBjb25maWd1cmVzDQo+PiB0aGUgZGV2aWNlIHRvIGFn
Z3JlZ2F0ZSBzb21lIG1vcmUgYmVmb3JlIGZpcmluZyBhbiBpbnRlcnJ1cHQgLSBzbyBsZXNzDQo+
PiBpbnRlcnJ1cHRzLCBiZXR0ZXIgZWZmaWNpZW5jeSBwZXIgaW50ZXJydXB0IChmaW5kcyBtb3Jl
IGNvbXBsZXRpb25zKS4NCj4+IEZvciBsb3cgaW50ZXJydXB0IHJhdGUgKGxvdyBxdWV1ZSBkZXB0
aCkgdGhlIGxvYWQgaXMgcHJvYmFibHkgbG93IHRvDQo+PiBtb2RlcmF0ZSBhbmQgYWdncmVnYXRp
bmcgYmVmb3JlIGZpcmluZyBhbiBpbnRlcnJ1cHQgaXMganVzdCBhZGRlZA0KPj4gbGF0ZW5jeSBm
b3Igbm8gYmVuZWZpdC4gU28gdGhlIGFsZ29yaXRobSB0cmllcyB0byB0cmFuc2l0aW9uIGJldHdl
ZW4gYQ0KPj4gbnVtYmVyIG9mIHByZS1kZWZpbmVkIGxldmVscyBhY2NvcmRpbmcgdG8gdGhlIGxv
YWQgaXQgc2FtcGxlcy4NCj4+DQo+PiBUaGlzIGhhcyBiZWVuIHdpZGVseSB1c2VkIGJ5IHRoZSBu
ZXR3b3JrIGRyaXZlcnMgZm9yIHRoZSBwYXN0IGRlY2FkZS4NCj4+DQo+PiBOb3csIHRoaXMgYWxn
b3JpdGhtIHdoaWxlIHRyeWluZyB0byBhZGp1c3QgaXRzZWxmIGJ5IGxlYXJuaW5nIHRoZSBsb2Fk
LA0KPj4gYWxzbyBhZGRzIGVudHJvcHkgdG8gdGhlIG92ZXJhbGwgc3lzdGVtIHBlcmZvcm1hbmNl
IGFuZCBsYXRlbmN5Lg0KPj4gU28gdGhpcyBpcyBub3QgYSB0cml2aWFsIHRyYWRlLW9mZiBmb3Ig
YW55IHdvcmtsb2FkLg0KPj4NCj4+IEkgdG9vayBhIHN0YWIgYXQgdGhpcyBvbmNlIChjYW1lIHVw
IHdpdGggc29tZXRoaW5nIHZlcnkgc2ltaWxhciksDQo+PiBhbmQgd2hpbGUgZm9yIGxhcmdlIHF1
ZXVlLWRlcHRoIHdvcmtsb2FkcyBJIGdvdCB1cCB0byAyeCBJT1BzIGFzIHRoZQ0KPj4gYWxnb3Jp
dGhtIGNob3NlIGFnZ3Jlc3NpdmUgbW9kZXJhdGlvbiBwYXJhbWV0ZXJzIHdoaWNoIGltcHJvdmVk
IHRoZQ0KPj4gZWZmaWNpZW5jeSBhIGxvdCwgYnV0IHdoZW4gdGhlIHdvcmtsb2FkIHZhcmllZCB0
aGUgYWxnb3JpdGhtIHdhc24ndCB2ZXJ5DQo+PiBzdWNjZXNzZnVsIGRldGVjdGluZyB0aGUgbG9h
ZCBhbmQgdGhlIHN0ZXAgZGlyZWN0aW9uIChJIHVzZWQgYSB2YXJpYXRpb24NCj4+IG9mIHRoZSBz
YW1lIGJhc2ljIGFsZ29yaXRobSBmcm9tIG1seDUgZHJpdmVyIHRoYXQgbmV0X2RpbSBpcyBiYXNl
ZCBvbikuDQo+Pg0KPj4gQWxzbywgUUQ9MSByZXN1bHRlZCBpbiBoaWdoZXIgbGF0ZW5jeSBhcyB0
aGUgYWxnb3JpdGhtIHdhcyBkYW5nbGluZw0KPj4gYmV0d2VlbiB0aGUgdHdvIGxvd2VzdCBsZXZl
bHMuIFNvIEkgZ3Vlc3MgdGhpcyBuZWVkcyB0byB1bmRlcmdvIGENCj4+IHRob3JvdWdoIHBlcmZv
cm1hbmNlIGV2YWx1YXRpb24gZm9yIHN0ZWFkeSBhbmQgdmFyeWluZyB3b3JrbG9hZHMgYmVmb3Jl
DQo+PiB3ZSBjYW4gY29uc2lkZXIgdGhpcy4NCj4+DQo+PiBPdmVyYWxsLCBJIHRoaW5rIGl0cyBh
IGdyZWF0IGlkZWEgdG8gYWRkIHRoYXQgdG8gdGhlIHJkbWEgc3Vic3lzdGVtDQo+PiBidXQgd2Ug
Y2Fubm90IG1ha2UgaXQgdGhlIGRlZmF1bHQgYW5kIGVzcGVjaWFsbHkgd2l0aG91dCBiZWluZyBh
YmxlDQo+PiB0byB0dXJuIGl0IG9mZi4gU28gdGhpcyBuZWVkcyB0byBiZSBvcHQgaW4gd2l0aCBh
IHN5c2N0bCBvcHRpb24uDQo+DQo+IFdlIGNhbiBhZGQgZmxhZyBpbiBjcmVhdGVfY3EgY29tbWFu
ZCB0aGF0IHdpbGwgDQo+IHRyeV9jb2FsZXNjaW5nX2lzX3Bvc3NpYmxlIGluc3RlYWQgb2YgbW9k
dWxlIHBhcmFtZXRlciBvZiBjb3Vyc2UuDQo+DQo+IFN0b3JhZ2UgVUxQcyBjYW4gc2V0IGl0IHRv
IFRydWUuDQo+DQo+IEFsc28gaW4gdGhlIGludGVybmFsIHJldmlldyBZYW1pbiBhZGRlZCBhIHRh
YmxlIHRoYXQgc3VtbWFyaXplIGFsbCB0aGUgDQo+IHRlc3RpbmcgdGhhdCB3ZXJlIGRvbmUgdXNp
bmcgTlZNZW9GIChJIGd1ZXNzIGl0IHNvbWVob3cgZGlkbid0IGdldCB0byANCj4gdGhpcyBSRkMp
Lg0KPg0KPiBJIGd1ZXNzIHdlIGNhbiBkbyB0aGUgc2FtZSBmb3IgaVNFUiB0byBnZXQgbW9yZSBj
b25maWRlbmNlIGFuZCB0aGVuIA0KPiBzZXQgYm90aCB0byBjcmVhdGUgbW9kaWZpYWJsZSBjcSAo
aWYgSENBIHN1cHBvcnRzLCBvZiBjb3Vyc2UpLg0KPg0KPiBBZ3JlZWQgPw0KPg0KSSB0aGluayB0
aGF0IGFkZGluZyBhIGZsYWcgaW4gY3JlYXRlX2NxIHdpbGwgYmUgbGVzcyBjbGVhbiBhcyBpdCB3
aWxsIA0KcmVxdWlyZSBtb3JlIHdvcmsgZm9yIGFueW9uZSB3cml0aW5nIGFwcGxpY2F0aW9ucyB0
aGF0IHNob3VsZCBub3QgaGF2ZSANCnRvIGNvbnNpZGVyIHRoaXMgZmVhdHVyZS4NCg0KQmFzZWQg
b24gdGhlIHJlc3VsdHMgSSBzYXcgZHVyaW5nIHRlc3RpbmcgSSB3b3VsZCBzZXQgaXQgdG8gd29y
ayBieSANCmRlZmF1bHQgYXMgSSBjb3VsZCBub3QgZmluZCBhIHVzZSBjYXNlIHdoZXJlIGl0IHNp
Z25pZmljYW50bHkgcmVkdWNlcyANCnBlcmZvcm1hbmNlIGFuZCBpbiBtYW55IGNhc2VzIGl0IGlz
IGEgbGFyZ2UgaW1wcm92ZW1lbnQuIEl0IHNob3VsZCBiZSANCm1vcmUgb2YgYW4gb3B0IG91dCBz
aXR1YXRpb24uDQoNClBlcmZvcm1hbmNlIGltcHJvdmVtZW50IChDb25uZWN0WC01IDEwMEdiRSwg
eDg2KSBydW5uaW5nIEZJTyBiZW5jaG1hcmsgb3Zlcg0KIMKgwqDCoCBOVk1mIGJldHdlZW4gdHdv
IGVxdWFsIGVuZC1ob3N0cyB3aXRoIDU2IGNvcmVzIGFjcm9zcyBhIE1lbGxhbm94IHN3aXRjaA0K
IMKgwqDCoCB1c2luZyBudWxsX2JsayBkZXZpY2U6DQoNCiDCoMKgwqAgSU8gUkVBRFMgYmVmb3Jl
Og0KIMKgwqDCoCBibGsgc2l6ZSB8IEJXwqDCoMKgwqDCoCB8IElPUFMgfCA5OXRoIHBlcmNlbnRp
bGUgbGF0ZW5jeQ0KIMKgwqDCoCA1MTJCwqDCoMKgwqAgfCAzLjJHaULCoCB8IDYuNk0gfCAxNTQ5
wqAgdXNlYw0KIMKgwqDCoCA0a8KgwqDCoMKgwqDCoCB8IDcuMkdpQsKgIHwgMS44TSB8IDcxNzfC
oCB1c2VjDQogwqDCoMKgIDY0a8KgwqDCoMKgwqAgfCAxMC43R2lCIHwgMTc2ayB8IDgyMzE0IHVz
ZWMNCg0KIMKgwqDCoCBJTyBSRUFEUyBhZnRlcjoNCiDCoMKgwqAgYmxrIHNpemUgfCBCV8KgwqDC
oMKgwqAgfCBJT1BTIHwgOTl0aCBwZXJjZW50aWxlIGxhdGVuY3kNCiDCoMKgwqAgNTEyQsKgwqDC
oMKgIHwgNC4yR2lCwqAgfCA4LjZNIHwgMTcyOcKgwqAgdXNlYw0KIMKgwqDCoCA0a8KgwqDCoMKg
wqDCoCB8IDEwLjVHaUIgfCAyLjdNIHwgNTY2OcKgwqAgdXNlYw0KIMKgwqDCoCA2NGvCoMKgwqDC
oMKgIHwgMTAuN0dpQiB8IDE3NmsgfCAxMDIwMDAgdXNlYw0KDQogwqDCoMKgIElPIFdSSVRFUyBi
ZWZvcmU6DQogwqDCoMKgIGJsayBzaXplIHwgQlfCoMKgwqDCoMKgIHwgSU9QUyB8IDk5dGggcGVy
Y2VudGlsZSBsYXRlbmN5DQogwqDCoMKgIDUxMkLCoMKgwqDCoCB8IDNHaULCoMKgwqAgfCA2LjJN
IHwgMjU3M8KgIHVzZWMNCiDCoMKgwqAgNGvCoMKgwqDCoMKgwqAgfCA3LjJHaULCoCB8IDEuOE0g
fCA1MzQywqAgdXNlYw0KIMKgwqDCoCA2NGvCoMKgwqDCoMKgIHwgMTAuN0dpQiB8IDE3NmsgfCA2
MjEyOSB1c2VjDQoNCiDCoMKgwqAgSU8gV1JJVEVTIGFmdGVyOg0KIMKgwqDCoCBibGsgc2l6ZSB8
IEJXwqDCoMKgwqDCoCB8IElPUFPCoCB8IDk5dGggcGVyY2VudGlsZSBsYXRlbmN5DQogwqDCoMKg
IDUxMkLCoMKgwqDCoCB8IDQuMkdpQsKgIHwgOC42TcKgIHwgOTM4wqDCoCB1c2VjDQogwqDCoMKg
IDRrwqDCoMKgwqDCoMKgIHwgMTAuMkdpQiB8IDIuNjhNIHwgMjc2OcKgIHVzZWMNCiDCoMKgwqAg
NjRrwqDCoMKgwqDCoCB8IDEwLjZHaUIgfCAxNzNrwqAgfCA4NzU1NyB1c2VjDQoNCkl0IGRvZXNu
J3QgcmVhbGx5IG1ha2UgYSBkaWZmZXJlbmNlIHRvIG1lIGhvdyB0aGUgb3B0aW9uIGlzIGltcGxl
bWVudGVkIA0KYnV0IEkgdGhpbmsgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byBoYXZlIGl0IGRlYWx0
IHdpdGggYnkgdXMgc3VjaCBhcyBpbiBhIA0KbW9kdWxlIHBhcmFtZXRlciBhbmQgbm90IHNvbWV0
aGluZyBsaWtlIGEgZmxhZyB0aGF0IGhhcyBhIGxhcmdlciByYWRpdXMgDQpvZiBlZmZlY3QuDQoN
Cj4+DQo+Pg0KPj4gTW9yZW92ZXIsIG5vdCBldmVyeSBkZXZpY2Ugc3VwcG9ydCBjcSBtb2RlcmF0
aW9uIHNvIHlvdSBuZWVkIHRvIGNoZWNrDQo+PiB0aGUgZGV2aWNlIGNhcGFiaWxpdGllcyBiZWZv
cmUgeW91IGFwcGx5IGFueSBvZiB0aGlzLg0KPg0KPiBmb3Igc3VyZS4NCj4NCj4NCg==
