Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14556C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFC72184A
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBLDha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:37:30 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:55674 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbfBLDh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 22:37:29 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C3aMiV018771;
        Tue, 12 Feb 2019 03:37:26 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qkfd22ek9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Feb 2019 03:37:26 +0000
Received: from G9W8454.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 6A29760;
        Tue, 12 Feb 2019 03:37:24 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 12 Feb 2019 03:37:24 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 12 Feb 2019 03:37:24 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB1009.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 03:37:22 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f012:82c9:aba7:b348]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f012:82c9:aba7:b348%2]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 03:37:22 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
CC:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: RE: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
Thread-Topic: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes
 5 minute delay during boot on Sun Blade 2500
Thread-Index: AQHUwJmmjZ1iXw54OUeEt0jgeA4qpaXXxqmAgAD7FwCAAGwUAIAABeAAgAAFiwCAAALEAIABftQAgAAA6gCAAAPygIAAAOQAgAAL6ICAAACugIAAoqkAgAAKYgCAAAhwMA==
Date:   Tue, 12 Feb 2019 03:37:22 +0000
Message-ID: <AT5PR8401MB1169D3DBEBC4F88D76BD1710AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
 <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
 <1549815924.4142.8.camel@HansenPartnership.com>
 <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
 <1549898730.2831.6.camel@HansenPartnership.com>
 <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
 <1549899773.2831.12.camel@HansenPartnership.com>
 <1a00da0e-cb8e-30ea-8d17-120f97242b2f@kernel.dk>
 <1549902521.2831.23.camel@HansenPartnership.com>
 <fce66227-ff41-3a4e-4c6a-f4c2ca492b95@kernel.dk>
 <1549937598.2857.8.camel@HansenPartnership.com>
 <fc547d40-9a42-a823-b62f-460c3244fe7d@kernel.dk>
In-Reply-To: <fc547d40-9a42-a823-b62f-460c3244fe7d@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.30.18.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad588d9c-efce-4a85-2749-08d6909b65f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1009;
x-ms-traffictypediagnostic: AT5PR8401MB1009:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBVDVQUjg0MDFNQjEwMDk7MjM6aUUxOUwxV0wrM0pxSFpWLzBvenpFWEZp?=
 =?utf-8?B?blhYMEYwZHpuU00zbHJ2KzFRSEhJOGF1eEkrQjBBb3grZVkzSTJITStFV1hk?=
 =?utf-8?B?a05OZ045cGRsUkVaUnhqbkZoWWtIMldkWWM2em1ZM0ZTZzYyY3ZpWkkyQTJC?=
 =?utf-8?B?M0RadXArS1FPVGxSUk9tNzlGSzVCWDlrNmM0N29nRllRU0JKK0pNYy92Mmsr?=
 =?utf-8?B?MzhGczErZGlPZU94cHk0RG0rcFJNM2ZDNjcvVHVSRDA2NEtCZWF1c3kwNzVC?=
 =?utf-8?B?ZjFpWWhQQWQyK0pmMllZblp1VWl5amI0bzVHbXE3dUhyZjRPN1VkTWk2djBq?=
 =?utf-8?B?VmVVTDFkUExiaDRqQW5jVmZvSlVqUTRNU1V6N1MzU1dDZzlwbzZhWXRvc2p5?=
 =?utf-8?B?UEJ5NWtxRkh3T3AyRk54NmllbWRSMUZzQS9CMk5mcTdYR255TTNabHRkUGNN?=
 =?utf-8?B?a3U2djFJMm1oL2dDLzN5bENDR3NuRzU1ODZDdlhWcURkc2QxUWluVTVJK2Fk?=
 =?utf-8?B?T3lmNXRvYlBSc0JIdDlXWmVMRmlsUURMYzZVS3lsQU84cUhHc2F0YzYvem1T?=
 =?utf-8?B?Z0Q3N0tqdXErbE5TYmZpaldKdS9NZDBwWVNSOWRFT1VPUGRWUndUOUVJSWNq?=
 =?utf-8?B?dzV6bFpVSm1DSnEyQU9LNG9NRnRTUGpTTWdQeXpaRmZaNEN2ZStjN3F3VDVI?=
 =?utf-8?B?ZWYwVlRXdldweFdjMlZEMU5HT0FBTmVsMDNXdVgvRFlPR0dhbHdpU3VSWXAv?=
 =?utf-8?B?RXgySDlYSnl5bjBwZE5MZXFQdEtTekV2Tm1HVUJaSEhEcXJKQzQ5NzBSaTFB?=
 =?utf-8?B?TTRpek44TS96Uml3U0hXVXpaYkRFSm5xKytIMi9BbXRtQ09WckUzSGRHcEdK?=
 =?utf-8?B?ZmtlTkU0ZEExMnJhTDlPbnNQeFA4Zk9xY1dqWHVsUXFYakFjeEpJWXM3cWRj?=
 =?utf-8?B?WjdZL2grRldhQlFocnk1WGdLaC8vaHBmd1hsQmFxbjVvM0p0OFBYT0crVlpH?=
 =?utf-8?B?UVhnckJTeVBRTDBqbTV1L0NobFE4Y2pjWTZlZnByQXkvT1E4VGl3a3JQSGRz?=
 =?utf-8?B?NHg0UUlaU2xzSXh6ZWUvME94QmNoUkpXempUaCswR3hwYkFhaFdibUVUdEpS?=
 =?utf-8?B?VHpDL2ZtZnl2c2tEekJCenVOc3lhUE04MUVXQWdkNFFGQ1pYeHE3OEgrK1JX?=
 =?utf-8?B?cEJJMHROd0tnZzlLOC91ckJFdVZQTXZLam92TnloUGNjSGxVN0wrR3dKY2xz?=
 =?utf-8?B?MmRvR2xqZWdQU08zbUNBOGEyMjgvays1Y29oSDJhWFlZWFpKZlJuUEVqMEJB?=
 =?utf-8?B?TzBjRmtZRFZaN2twcXZaUkU0MGdxTUo0TWY5bndQcWUzQzgyZGloVTI4WnIx?=
 =?utf-8?B?dEI3djI4dVBLazBtRGZjZmxBSnNOQjlEVVNPQkkzUURyRDFBa0cybkx1QlFh?=
 =?utf-8?B?UkhLc2g2ZFpwVkZXV2JiSFI2VEczU1VndFBKZkk4UTZnUDRCOU9KVHpaOTRa?=
 =?utf-8?B?YlRRYmJKaTBBYmtvby9HUExXamw4NUtnTFhtdmVySll3WjMwZWswcjlMK3BZ?=
 =?utf-8?B?ZzhMcHhIOXl6Zm85dlJBazNBbnBKRWtGV0d1VXJwWWxHT3lCSnhJdUthYm15?=
 =?utf-8?B?dk5YZ1hzZU1PZC9BRHcxN3krNWdtVGJJYzkwajNETXJCeWg0Q0RWd2FsT2c9?=
 =?utf-8?Q?=3D?=
x-microsoft-antispam-prvs: <AT5PR8401MB100998CFDEA59FC61EE4FBF8AB650@AT5PR8401MB1009.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39860400002)(376002)(136003)(13464003)(199004)(189003)(7696005)(102836004)(3846002)(6116002)(316002)(8936002)(478600001)(6506007)(93886005)(53546011)(66066001)(99286004)(74316002)(8676002)(71200400001)(76176011)(71190400001)(229853002)(446003)(53936002)(86362001)(11346002)(81156014)(54906003)(476003)(110136005)(33656002)(486006)(68736007)(14454004)(81166006)(6246003)(4326008)(6436002)(55016002)(105586002)(2906002)(9686003)(106356001)(25786009)(305945005)(256004)(7736002)(26005)(97736004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1009;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LyUghwkW79viM52++8Zz/geJqPkr7C51odCR1wGV0GHivjLEFf7cNtirWEyr6jxJagsL+lDEdddMCdLOEVLVFSrrBXFyzUpBe79TelYZZ8sbLmVUbnvDmgtFEgZT2Pzco1P/2uRauZ5WmH5vFhCywLXcqDukA/83dBz0WivGN+BF+wqb9wAgOa9kJ4DYJChjsmpZvhecWzGdiZVkRLSw8qsA3Pod7gynHeUsCMWSuUzzIjU9KbnF0I6+nuIUxf3dd6Mp5KpNU5o4WcKTc9D5R1UkEvG/zFma1bY72Pfoubm/4vLg31iGJhHEMTJexPlI0YGzTyLxjFqVeEoG/l7ZIGdT/dGOSUmeTJZLIhX50D+WqgIB6sryKoJGKIEG+5kbuseM+/RtEGE0YNR0nR4cvq1oApWEr8tFFpzZklckKnA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad588d9c-efce-4a85-2749-08d6909b65f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 03:37:22.2906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1009
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=953 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120025
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBKZW5zIEF4Ym9lDQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMTEs
IDIwMTkgODo1MCBQTQ0KPiBUbzogSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFu
c2VuUGFydG5lcnNoaXAuY29tPjsgTWlrYWVsDQo+IFBldHRlcnNzb24gPG1pa3BlbGludXhAZ21h
aWwuY29tPg0KPiBDYzogTGludXggU1BBUkMgS2VybmVsIE1haWxpbmcgTGlzdCA8c3BhcmNsaW51
eEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNjc2kNCj4gPGxpbnV4LXNjc2lAdmdlci5r
ZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogWzUuMC1yYzUgcmVncmVzc2lvbl0gInNjc2k6IGtp
bGwgb2ZmIHRoZSBsZWdhY3kgSU8gcGF0aCINCj4gY2F1c2VzIDUgbWludXRlIGRlbGF5IGR1cmlu
ZyBib290IG9uIFN1biBCbGFkZSAyNTAwDQouLi4NCg0KPiA+IFdlIGNhbiBlaXRoZXIgZml4IHRo
aXMgYnkgc2V0dGluZyB0aGUgUVVFVUVfRkxBR19BRERfUkFORE9NIGlmDQo+ID4gdGhlcmUncyBu
byAweEIxIHBhZ2Ugb3IgYnkgc2V0dGluZyB0aGUgZGVmYXVsdCBhcyBKZW5zIHByb3Bvc2VkLg0K
PiANCj4gSSdkIHJlY29tbWVuZCBqdXN0IGRvaW5nIG15IHBhdGNoLCBzaW5jZSB0aGF0J2xsIGJl
IHRoZSBzYW1lIGJlaGF2aW9yDQo+IHRoYXQgU0NTSSBoYWQgYmVmb3JlLg0KDQpXaGVuIGJsay1t
cSBhbmQgc2NzaS1tcSB3ZXJlIGludHJvZHVjZWQgdG8gYm9vc3QgU0FTIFNTRHMgb3Zlcg0KMSBt
aWxsaW9uIElPUFMsIHRoaXMgd2FzIHB1cnBvc2VseSBrZXB0IG9mZiwgYmVjYXVzZSBpdCBnZW5l
cmF0ZWQNCmEgbm90aWNlYWJsZSAzLTEyIHVzIGxhdGVuY3kgYmxpcCB3aGVuZXZlciB0aGUgImZh
c3RfbWl4IiBjb2RlIHJhbg0Kb3V0IG9mIGJpdHMuIElmIEplbnMnIHBhdGNoIGNoYW5nZXMgdGhl
IGRlZmF1bHQgdG8gYmUgZW5hYmxlZCBmb3INCmFsbCBzY3NpLW1xIHVzZXJzLCB0aGF0J2xsIGJl
IGEgY2hhbmdlIGZvciB0aGUgbmV3ZXIgbGVnYWN5DQpzY3NpLW1xIHVzZXJzIChleGNlcHQgZm9y
IHVzZXJzIHRoYXQgZG9uJ3QgdHJ1c3QgdGhlIGRlZmF1bHQgYW5kDQphbHdheXMgc2V0IHRoZSB2
YWx1ZSBpbiBzeXNmcykuDQoNCg0K
