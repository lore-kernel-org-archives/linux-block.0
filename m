Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B98CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 10:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiCQKWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiCQKWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 06:22:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F421DE6E4
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 03:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNEv4d79krufnjf/alejFOfdfAA7u7DhnuK95B64f7fXBNcqJqhgJ4XA8jfsrfjqhDEZEVXi43ntRejQJjCWjQ3sS4wePgTFD49RT1IU0biVa26KR6Z8JTVKzdBoaRib22HwKINO8RFTtCA+JhnIZrdlCP0r4mHuvLBq1guhJr3kHysoktuHojt+1d9xRZ/Hjq3+E326DId1rVRYdj7duR6akPjjrp9Ay5otPw3ixIw2Pj4jWhad4wllm8hg2jvDcbmIotuy7lQkNsrf7VArmNkCPdTMMdLG8RJwqV7qEcbwT35TFRgBMYXtDTB37i8XjUxVFNjdF4r7lkDcKXg1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fbj6YDBTdiChEhEhUQ6G9Z6w7ScQfVSRzX8iE55cdg=;
 b=oV9xxN0qaCyB2ZZOLoRh752btijkOei7BDc+S3K+A3BS7CBbgAZ5AqO8GV5Hpl/VL53AsyT3JBYsA1OVn90JLL5xC3OO4AVMcObB2N6lbnGZRkJxfYcGAzd0rTPPQEKofOGgMhFKsCnT+zM9BzPzX+b9I0rHDgyV6VKjHLngWQWSOFxNuEXCGGNwa2vik2T8rpO70imkEhbB3/Sg9krZ0H6cc72GRyDEBGxh5eFDYwmRLmL5tc2jO+OTvLek3YQkYtwxbqmnZSgZJyTavxVnWWHxfHdTtoWj++ZvIP4tTutVUYA2JGGu+jDFJpzaLm9lQ5g561+q3S6s49i/U+DK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fbj6YDBTdiChEhEhUQ6G9Z6w7ScQfVSRzX8iE55cdg=;
 b=PI/XCPj0+bmmSyR/Izv2sLy1/A+eYQjep7KaOkAHr8nsAsVwnHZfiEisECj641OSg19/oefxVFvqddct4kVQjrodCPSG0/qfeDmH+4CIaIKfZ2nZRup/1o+/bH8yr40WP8qPBlU3Nmkg/nWHPJuHr1LkpxvMdJKbSEyaWck6Dyscdmx2qgNWu4Wg0gzzxQNlW1ZL9fSj/322fa86HOu6jhhjjmJWqFtSHzavDF1mM7aQL7asAhOCMF3DGnz0qce1N2OhSruR+p/idwbnoCtBh5lwoMNzWqYB2g4l/H0DD+Oxhq7fN0lXQn5nLqCZEDA0sL4z1rADzSbGNhTBYi4nvQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 10:20:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 10:20:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Eric Wheeler <linux-block@lists.ewheeler.net>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: loop: are parallel requests serialized by the single workqueue?
Thread-Topic: loop: are parallel requests serialized by the single workqueue?
Thread-Index: AQHYOac8nCi3kHkmYkGUOXoc1OmimazDXg6A
Date:   Thu, 17 Mar 2022 10:20:53 +0000
Message-ID: <6349f346-5b23-0d2f-0759-c97a56577822@nvidia.com>
References: <59a58637-837-fc28-6cb9-d584aa21d60@ewheeler.net>
In-Reply-To: <59a58637-837-fc28-6cb9-d584aa21d60@ewheeler.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cb48999-8325-4eeb-eaf4-08da07ffd192
x-ms-traffictypediagnostic: MWHPR12MB1199:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1199835840828FBE33736BE8A3129@MWHPR12MB1199.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C78xBjw/fZbRKXLwl68J+jSBcX7KlgiwQEaZcD5yCs5pcUfL+xBxEOIAbPTQoF20UWezG48MEhauwULV4vr3y6fWOLRikUdP2ptszSpP39ndhQ8ELTJaAMehzAg6ClNbG+A20lVMbC0fMdDqBOiJlj5f5X5Ef37SUEHRTJ3yKwhYXW6HgAR66quGwsPfzNbL1wn022vg+pJ6Z8ubKkt7KrS5Kscinglx9spwJ7Ritrk5/bCfiiR2nznBvwZKs7xQrspg4pJpnMQOJiyoGbJqfNn7h3vmm6WglRcc9/IaCDl/ynWQXElibRkCwrAH1SE9OHDC5dBxEHzlVSsDE5aGM2XudR6ptxM+kBfJQqYX3hngrIBDNcjtN0M40qry7mucXN5eUWrqKTuP2pP7CqJopwc0vonau32KsS96OLrfh2BjBy5YQaNSi4GeJx2qHINiKcItiZ2pgHXekCls4rNYQvf+mzbfIdLi2/CCQGZU98CRN+Cr3xiAaYjGi6G2OgI+xYRotF5Zld35WR0oWu+Gjqho4pmFheNx0NQS0PrA/swHGU9NWTyDhA2J+FfnV3OKYdMFVzsOX91HUcbtTC3RB3Ysa1gtI80khu2XkC0GjtuBaBy0XwBu2ThCSnzpZRR+vBVUhKjx44toWytkHU1Dzs/Ta9+Yy4ByYzSw8FHu9Qa3zIy0QWz38fkQvsCINd2u07zEoJvMFiUsoCH6NMiNwbjuylLXJwj+GM8rZnrE3eoxrJcC6imqyjIeUogZP7ySEMTO2Oka7mPtCii0hXYnn4hGNnHpeXlasCtEneFQtHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(186003)(2616005)(31686004)(6486002)(966005)(6512007)(71200400001)(6506007)(83380400001)(53546011)(508600001)(38070700005)(38100700002)(86362001)(31696002)(66556008)(8676002)(66476007)(64756008)(66946007)(5660300002)(76116006)(66446008)(4326008)(54906003)(316002)(91956017)(6916009)(36756003)(122000001)(43740500002)(45980500001)(10090945011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXFCeGw4UjJFeHlXS1F6MjNmWU0vQkZYUmhjVzZvZ3B0TDZlQXFRdFY0Mk9w?=
 =?utf-8?B?cmtacWc0L2U5NXM2bXhlUzJmVWRJcGhCZTVGeGtaT0dCOGw4dWh3SmRDSkxN?=
 =?utf-8?B?TVUyL0dUeWRTamZkdTYwVWFBVjFVK3NpTHdLNHBqY3BoSnVVelN3YTRuSDNm?=
 =?utf-8?B?RjQrQjNTaDBtS1dtL0hQVCt2WlB6OUV4Si9MZyt1NFZ0ZWpLMGpCUUhnWnZR?=
 =?utf-8?B?alYyTjBaT3hPZkUvbW5kM1JVWC9yc0NjR2dvbEU5MEhjTXIzZ2F1V0ROL3hw?=
 =?utf-8?B?ZG5UQXBHVnBYaDJSYW9mTnJBY0VUUXFSYjFZNkxPUjB0MnBGL01Pdk5aUFcy?=
 =?utf-8?B?QWR3OGF4RHpRZmNXUVB3bEZTRFladWV5S1ppL0s3Z0FSMFkxR1VNY3owNnBq?=
 =?utf-8?B?aU1TcnYyVmtQQ2NlYS9lQkJxL3FaTGFKSWhvTWQzbXU1SFN0Z2w0VVBrYmZ4?=
 =?utf-8?B?Q2JNQjBSVURlaWUxWXlsRDFnRkZJcXZ2QTZiR3lST3o2TFBWMEgzQmI0M3g4?=
 =?utf-8?B?QWtvNUthdVJqeW9UYVA2c1o4WGYxTE1qRldXTFF4YXJDZSt3RGtVQUJVQUlM?=
 =?utf-8?B?NjZGc1Y4MTNhOUFSOXJXWkI3WFpDaHhsek1IbTNWamJlTnpxNDBDejNTTWcv?=
 =?utf-8?B?Y2d3bnF4WWpnOGlMOUJkYW00VEl3RFFDRWNTMXQ3TTZJQWl6bGNTZE9xdEZn?=
 =?utf-8?B?MVVUbXgrTGNWdVJpVE93R1lEN2FpVWN2TFRYMStpUU9jZ3lMcHYwVTBQa2c3?=
 =?utf-8?B?SXp6OUljVytLVzAwKzZKdjBCemlVcFFVR1hKU3Jjc3ZHTlIwcjlNUFRPa0FH?=
 =?utf-8?B?WjNwek1vR3pWYWV5dzloZitQWlVaRE85MlpjTDZOTWVXYkJqb2dReVNJeklB?=
 =?utf-8?B?Y2FTL3QzRkRYWm1mMTRQb0I3Z3dPemZWRENkRkJkUnFRUnd5Ymx6c0xqSUl0?=
 =?utf-8?B?QksvUmFwYnBuR1FHTFlrcDVUWjFNT0ZmVWVDVzBrK1JUMmpMczRuZUJabFpi?=
 =?utf-8?B?MStaT1dDQVhyUmw5MGFUbHVMV21mN0FvRFB4S1lDTmJ5NXIramlIR2dUYXg4?=
 =?utf-8?B?eVUwOGtuc01MSWgyRmUxSytNV2FEd25ZVXpqaHgrZ1FkWkI4eGhkcmw1azBm?=
 =?utf-8?B?MHpsYmtHMGFqOTZSUG8vMEdnTHd2Mkd0NFkwcGUrbFlQcjg5UzV0em1SdDYr?=
 =?utf-8?B?ZUVzaUZmeTZGS0RBWXBvdVBFdWozclc0aUVmc3NHMlBRVXZ4Tnc5Q2Z0OW1Q?=
 =?utf-8?B?bmh0ZXNLckNiQVVxTjBFdlZKdUFtVzVaVmtyNHRqSFdzQkhXejhpOVRudTJn?=
 =?utf-8?B?bGo1WjloSXdYTDlwbG0zZXBweWhsN2kySHp0bm1RaWRyMHo0OElNNU0rWlBZ?=
 =?utf-8?B?NURabDdyaDQxUnFLZC9Ramo4Qk5WTVoxb055bmlRNFo5RXhrakExQTQweXhm?=
 =?utf-8?B?L2NFcHZwTkVmSHlsRnp5RlcyaWRtbUkzanppVlQ1YStvOWRPekZYelpRUlVD?=
 =?utf-8?B?b2UzdVJGNENhUWU2Y0w2RXRiR2pueUlmM3R4MVZBWU0weWhyQThUQmJKeWhH?=
 =?utf-8?B?WHpQMHJCb0NnV3lQaEpxS05FWThhbDArbU0vanhwcGNpU2dVUE5mdERJdHF2?=
 =?utf-8?B?cHpIdkkyajRCQ2NOU3dQSkgrbnlJRzVEbDBqRnV3eGx3OER1a2pvWHBCT3pI?=
 =?utf-8?B?VDRRUXQzcDQyRXplQW9mOWE2NE1qbmczdGNtT1pzbVhpZFJDcEhTNzJNZGVM?=
 =?utf-8?B?MDc2OC8rVHN4Mk9rd2luTFFvc1BZUDEzUTQxdmhLdTRzYk44SDBUVEdnT0p1?=
 =?utf-8?B?TFB5S3Z3UUJTY3pMdnpNL25YM0NuV1lTb0w2dXUxQXlTc2FDRzBsamw0ZFB2?=
 =?utf-8?B?WTlqUFR3R013c3ZDcVdjVmF1eE84ZXM0Ymo1MENkWktrUjdTRkNuTDJxSXJs?=
 =?utf-8?B?cU1FVll5bVRDRU9MTHVkWE1QbVFLNmJ6cU44bHBHQkFFKzNoandwNTR6Myth?=
 =?utf-8?B?NHBlbitpUy9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F452543715254E4EA93DC75DA7E8CB6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb48999-8325-4eeb-eaf4-08da07ffd192
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 10:20:53.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b1ojvY3rENtC8Xu3gOGKAmexNnVZpjztR/XFa5fBbUrMiopUUVSNZtO/BjiDJlx9mgJyN/JNHOScXuzAkMmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RXJpYywNCg0KT24gMy8xNi8yMiA3OjI2IFBNLCBFcmljIFdoZWVsZXIgd3JvdGU6DQo+IFtTb21l
IHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBm
cm9tIGxpbnV4LWJsb2NrQGxpc3RzLmV3aGVlbGVyLm5ldC4gTGVhcm4gd2h5IHRoaXMgaXMgaW1w
b3J0YW50IGF0IGh0dHA6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uLl0N
Cj4gDQo+IEhpIE1pbmcsDQo+IA0KPiBJIHdhcyBzdHVkeWluZyB0aGUgbG9vcC5jIERJTyAmIEFJ
TyBjaGFuZ2VzIHlvdSBtYWRlIGJhY2sgaW4gMjAxNSB0aGF0DQo+IGluY3JlYXNlZCBsb29wIHBl
cmZvcm1hbmNlIGFuZCByZWR1Y2VkIHRoZSBtZW1vcnkgZm9vdHByaW50DQo+IChiYzA3YzEwYTM2
MDNhNWFiM2VmMDFiYTQyYjNkNDFmOWFjNjNkMWI2KS4NCj4gDQo+IEkgaGF2ZSBhIGZldyBxdWVz
dGlvbnMgaWYgeW91IGFyZSBhYmxlIHRvIGNvbW1lbnQsIGhlcmUgaXMgYSBxdWljaw0KPiBzdW1t
YXJ5Og0KPiANCj4gVGhlIGRpcmVjdCBJTyBwYXRoIHN0YXJ0cyBieSBxdWV1aW5nIHRoZSB3b3Jr
Og0KPiANCj4gICAgLnF1ZXVlX3JxICAgICAgID0gbG9vcF9xdWV1ZV9ycToNCj4gDQo+ICAgICAg
ICAgIC0+IGxvb3BfcXVldWVfd29yayhsbywgY21kKTsNCj4gICAgICAgICAgLT4gSU5JVF9XT1JL
KCZ3b3JrZXItPndvcmssIGxvb3Bfd29ya2ZuKTsNCj4gICAgICAgICAgICAgICAgICAuLi4gcXVl
dWVfd29yayhsby0+d29ya3F1ZXVlLCB3b3JrKTsNCj4gDQo+IFRoZW4gZnJvbSB3aXRoaW4gdGhl
IHdvcmtxdWV1ZToNCj4gDQo+ICAgICAgICAgIC0+IGxvb3Bfd29ya2ZuKCkNCj4gICAgICAgICAg
LT4gbG9vcF9wcm9jZXNzX3dvcmsod29ya2VyLCAmd29ya2VyLT5jbWRfbGlzdCwgd29ya2VyLT5s
byk7DQo+ICAgICAgICAgIC0+IGxvb3BfaGFuZGxlX2NtZChjbWQpOw0KPiAgICAgICAgICAtPiBk
b19yZXFfZmlsZWJhY2tlZChsbywgYmxrX21xX3JxX2Zyb21fcGR1KGNtZCkgKTsNCj4gICAgICAg
ICAgLT4gbG9fcndfYWlvKGxvLCBjbWQsIHBvcywgUkVBRCkgLy8gKG9yIFdSSVRFKQ0KPiANCj4g
IEZyb20gaGVyZSB0aGUga2lvY2IgaXMgc2V0dXAgYW5kIHRoaXMgaXMgdGhlIDUuMTctcmM4IGNv
ZGUgYXQgdGhlDQo+IGJvdHRvbSBvZiBsb19yd19haW8oKSB3aGVuIGl0IHNldHMgdXAgdGhlIGRp
c3BhdGNoIHRvIHRoZSBmaWxlc3lzdGVtOg0KPiANCj4gICAgICAgICAgY21kLT5pb2NiLmtpX3Bv
cyA9IHBvczsNCj4gICAgICAgICAgY21kLT5pb2NiLmtpX2ZpbHAgPSBmaWxlOw0KPiAgICAgICAg
ICBjbWQtPmlvY2Iua2lfY29tcGxldGUgPSBsb19yd19haW9fY29tcGxldGU7DQo+ICAgICAgICAg
IGNtZC0+aW9jYi5raV9mbGFncyA9IElPQ0JfRElSRUNUOw0KPiAgICAgICAgICBjbWQtPmlvY2Iu
a2lfaW9wcmlvID0gSU9QUklPX1BSSU9fVkFMVUUoSU9QUklPX0NMQVNTX05PTkUsIDApOw0KPiAN
Cj4gICAgICAgICAgaWYgKHJ3ID09IFdSSVRFKQ0KPiAgICAgICAgICAgICAgICAgIHJldCA9IGNh
bGxfd3JpdGVfaXRlcihmaWxlLCAmY21kLT5pb2NiLCAmaXRlcik7DQo+ICAgICAgICAgIGVsc2UN
Cj4gICAgICAgICAgICAgICAgICByZXQgPSBjYWxsX3JlYWRfaXRlcihmaWxlLCAmY21kLT5pb2Ni
LCAmaXRlcik7DQo+IA0KPiAgICAgICAgICBsb19yd19haW9fZG9fY29tcGxldGlvbihjbWQpOw0K
PiANCj4gICAgICAgICAgaWYgKHJldCAhPSAtRUlPQ0JRVUVVRUQpDQo+ICAgICAgICAgICAgICAg
ICAgbG9fcndfYWlvX2NvbXBsZXRlKCZjbWQtPmlvY2IsIHJldCk7DQo+IA0KPiANCj4gQWZ0ZXIg
aGF2aW5nIGNhbGxlZCBgY2FsbF9yZWFkX2l0ZXJgIGl0IGlzIGluIHRoZSBmaWxlc3lzdGVtJ3MN
Cj4gaGFuZGxlci4NCj4gDQo+IFNpbmNlIGtpX2NvbXBsZXRlIGlzIGRlZmluZWQsIGRvZXMgdGhh
dCBtZWFuIHRoZSBmaWxlc3lzdGVtIHdpbGwgX2Fsd2F5c18NCj4gdGFrZSB0aGVzZSBpbiBhbmQg
YWx3YXlzIHF1ZXVlIHRoZXNlIGludGVybmFsbHkgYW5kIHJldHVybiAtRUlPQ0JRVUVVRUQNCj4g
ZnJvbSBjYWxsX3JlYWRfaXRlcigpPyAgQW5vdGhlciB3YXkgdG8gYXNrOiBpZiBraV9jb21wbGV0
ZSE9TlVMTCwgY2FuIGENCj4gZmlsZXN5c3RlbSBldmVyIGJlaGF2ZSBzeW5jaHJvbm91c2x5PyAg
KElzIHRoZXJlIGRvY3VtZW50YXRpb24gYWJvdXQgdGhpcw0KPiBzb21ld2hlcmU/ICBJIGNvdWxk
bid0IGZpbmQgYW55dGhpbmcgZGVmaW5pdGl2ZS4pDQo+IA0KDQphIG5vbi1udWxsIGtpX2NvbXBs
ZXRlIGFza3MgZm9yIGFzeW5jIEkvTyBhbmQgdGhhdCBpcyB3aGF0IHdlIG5lZWQgdG8NCmdldCB0
aGUgaGlnaGVyIHBlcmZvcm1hbmNlLg0KDQo+IA0KPiBBYm91dCB0aGUgY2xlYW51cCBhZnRlciBk
aXNwYXRjaCBhdCB0aGUgYm90dG9tIG9mIGxvX3J3X2FpbygpIGZyb20gdGhpcw0KPiBjb2RlIChh
bHNvIHNob3duIGFib3ZlKToNCj4gDQo+ICAgICAgICAgIGxvX3J3X2Fpb19kb19jb21wbGV0aW9u
KGNtZCk7DQo+IA0KPiAgICAgICAgICBpZiAocmV0ICE9IC1FSU9DQlFVRVVFRCkNCj4gICAgICAg
ICAgICAgICAgICBsb19yd19haW9fY29tcGxldGUoJmNtZC0+aW9jYiwgcmV0KTsNCj4gDQo+ICog
SXQgYXBwZWFycyB0aGF0IGxvX3J3X2Fpb19kb19jb21wbGV0aW9uKCkgd2lsbCBga2ZyZWUoY21k
LT5idmVjKWAuICBJZg0KPiAgICB0aGUgZmlsZXN5c3RlbSBxdWV1ZWQgdGhlIGNtZC0+aW9jYiBm
b3IgaW50ZXJuYWwgdXNlLCB3b3VsZCBpdCBoYXZlIG1hZGUNCj4gICAgYSBjb3B5IG9mIGNtZC0+
YnZlYyBzbyB0aGF0IHRoaXMgaXMgc2FmZT8NCj4gDQo+ICogSWYgcmV0ICE9IC1FSU9DQlFVRVVF
RCwgdGhlbiBsb19yd19haW9fY29tcGxldGUoKSBpcyBjYWxsZWQgd2hpY2ggY2FsbHMNCj4gICAg
bG9fcndfYWlvX2RvX2NvbXBsZXRpb24oKSBhIHNlY29uZCB0aW1lLiAgTm93IGxvX3J3X2Fpb19k
b19jb21wbGV0aW9uDQo+ICAgIGRvZXMgZG8gdGhpcyByZWYgY2hlY2ssIHNvIGl0IF9pc18gc2Fm
ZToNCj4gDQo+ICAgICAgICAgIGlmICghYXRvbWljX2RlY19hbmRfdGVzdCgmY21kLT5yZWYpKQ0K
PiAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IEZvciBteSBvd24gdW5kZXJzdGFuZGlu
ZywgaXMgdGhpcyBlcXVpdmFsZW50Pw0KPiANCj4gLSAgICAgICBsb19yd19haW9fZG9fY29tcGxl
dGlvbihjbWQpOw0KPiANCj4gICAgICAgICAgaWYgKHJldCAhPSAtRUlPQ0JRVUVVRUQpDQo+ICAg
ICAgICAgICAgICAgICAgbG9fcndfYWlvX2NvbXBsZXRlKCZjbWQtPmlvY2IsIHJldCk7DQo+ICsg
ICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgbG9fcndfYWlvX2RvX2NvbXBsZXRpb24oY21k
KTsNCj4gDQo+IA0KPiANCj4NCg0KSSB0aGluayB0aGUgcHVycG9zZSBvZiByZWZjb3VudCBpcyB0
byBtYWtlIHN1cmUgd2UgZnJlZSB0aGUgcmVxdWVzdCBpbg0KbG9fcndfYWlvX2RvX2NvbXBsZXRp
b24oKSB3aG9ldmVyIGZpbmlzaGVzIGxhc3QgZWl0aGVyIHN1Ym1pc3Npb24gdGhyZWFkDQpvciBm
cyBjb21wbGV0aW9uIGN0eCBjYWxsaW5nIGtpX2NvbXBsZXRlKCkgLT4gbG9fcndfYWlvX2NvbXBs
ZXRlKCkuDQoNClNvIHRoZXJlIGFyZSBhY3R1YWxseSB0aHJlZSBjYXNlcyA6LQ0KDQoxLiBJL08g
aXMgc3VjY2Vzc2Z1bGx5IHF1ZXVlZCBpLmUuIGNhbGxfaXRlcigpIHJldCA9PSAtRUlPQ0JRVUVV
RUQuDQpDYXNlIDEgOg0KMS4xIGZzIGNvbXBsZXRpb24gaGFwcG5lcyBhZnRlciB3ZSBleGl0IGZy
b20gbG9fcndfYWlvKCkNCiAgYS4gc3VibWlzc2lvbiB0aHJlYWQgbG9fcndfYWlvKCkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlZmNudCA9IDINCiAgYi4gc3VibWlzc2lvbiB0aHJlYWQg
bG9fcnFfYWlvX2RvX2NvbXBsZXRpb24oKSAgICAgICAgICAgICAgIHJlZmNudCA9IDENCiAgYy4g
ZnMgY29tcGxldGlvbiBjdHggZnMtPmtpX2NvbXBsZXRlKCktPmxvX3J3X2Fpb19jb21wbGV0ZSgp
IHJlZmNudCA9IDANCg0KQ2FzZSAyOg0KMS4yIGZzIGNvbXBsZXRpb24gaGFwcGVucyBiZWZvcmUg
d2UgZXhpdCBsb19ycV9haW8oKQ0KICBhLiBzdWJtaXNzaW9uIHRocmVhZCBsb19yd19haW8oKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVmY250ID0gMg0KICBiLiBmcyBjb21wbGV0aW9u
IGN0eCBmcy0+a2lfY29tcGxldGUoKS0+bG9fcndfYWlvX2NvbXBsZXRlKCkgcmVmY250ID0gMQ0K
ICBjLiBzdWJtaXNzaW9uIHRocmVhZCBsb19ycV9haW9fZG9fY29tcGxldGlvbigpICAgICAgICAg
ICAgICAgcmVmY250ID0gMA0KDQoyLiBJL08gaXMgbm90IHN1Y2Nlc3NmdWxseSBxdWV1ZWQgaS5l
LiBjYWxsX2l0ZXIoKSByZXQgIT0gLUVJT0NCUVVFVUVELg0KQ2FzZSAzOg0KICBhLiBzdWJtaXNz
aW9uIHRocmVhZCBsb19yd19haW8oKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVmY250
ID0gMg0KICBiLiBzdWJtaXNzaW9uIHRocmVhZCBsb19ycV9haW9fZG9fY29tcGxldGlvbigpICAg
ICAgICAgICAgICAgcmVmY250ID0gMQ0KICBjLiBzdWJtaXNzaW9uIHRocmVhZCBsb19yd19haW9f
Y29tcGxldGUoKSAgICAgICAgICAgICAgICAgICAgcmVmY250ID0gMA0KDQpzbyBpZiB5b3UgY2hh
bmdlIHRoZSBwb3NpdGlvbiBvZiB0aGUgY2FsbCBsb19yd19haW9fZG9fY29tcGxldGlvbigpDQpp
dCBtaWdodCBub3Qgd29yayBzaW5jZSByZWZjb3VudCB3aWxsIGJlIGRlY3JlbWVudGVkIGJ5IG9u
bHkgb25jZS4NCg0KaG9wZSB0aGlzIGhlbHBzLCBpZiBpdCBjcmVhdGVzIG1vcmUgY29uZnVzaW9u
IHRoZW4gcGx6IGlnbm9yZSB0aGlzIGFuZA0KZm9sbG93IE1pbmcncyByZXBseS4NCg0KLWNrDQoN
Cg==
