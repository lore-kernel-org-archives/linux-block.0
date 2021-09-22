Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 05:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF4C611B0
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 05:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhIVFqo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 01:46:44 -0400
Received: from mail-eopbgr1300121.outbound.protection.outlook.com ([40.107.130.121]:55729
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232060AbhIVFqo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 01:46:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNGx3vRzZEoGuPsjJQndkTDJw7mgAwtwUrFh6VWO0DsccoRhpSZx5IM+ekAm0CHsdika4Ubi1Luq7NM3bZxKCffrTzns1YnXGBGMnSuqKn2PM7532svqEW7GSza/Mx0/E1hbauthkMyAHVUSxGuhFeUCflzU9xTDThpZPJLb+v4HYp4jPm5LVpyAfQS5qeJH0r86oJj/Ix976eiu91AQz0bq5App+a4/qfRJ0lxlCSLFVVl0Dsd3lFYisnq2r6HjaXTdVHRsyg5DxnokO8ETpxTOAulOXAjVxO/fz6lTWaXyt7Vc4n2t8U+0N0/7FenY8VHxBnG4K1vgV2S3Kuor8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Qw7BfBq36tfxg+HC3DI59Nb84bJegktOO5KK4bxb0=;
 b=jApCyZ392wDkQHyxKQT4r2z5PyDqXW4bu3U8SsDBEDD8tjJ76Zjq6XnbRyM1g4EKA505CzHvlxPbsv3mREvaSx83MLIUNCL29431Y1Si2TVDLFUCp9q6Scix5t7fKr+gBaFWyulLzb+848+Wlfzim/3itGnNPmYjwZ2NAfnV8S1pF+/6wHC/H01fXw/bginF9mMgl4smWBQVq7qJUCA/veF+tIghDtTx+SFvcH3y7bYS4PBZFbE5+52hUiZqJFicqfuJw96fbvN4TQYKpHLBKAvkCL90o2SveE9K1VzcUM5j/IeSoKHsn4qawVdxvNSi5pfuB6zQYUD9HAaUUkVmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Qw7BfBq36tfxg+HC3DI59Nb84bJegktOO5KK4bxb0=;
 b=fwTsTJmQu4KE5vYP+wJf6ci7u0tPgBGq/r+B2c1KUzvc2FBpEWqcxUhI6tVUymBBGj/IVZeyeSJY/cbvMfICV3rZNEafZEBMgsso8XzGWwzr9uCPy9cz3tm7WyeE/d0g5pYgiw7jLfh19xaRbMBre/dkIEegFDjBJ9gnG1Tz150=
Received: from PSAP153MB0518.APCP153.PROD.OUTLOOK.COM (2603:1096:301:63::10)
 by PSAP153MB0471.APCP153.PROD.OUTLOOK.COM (2603:1096:301:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.5; Wed, 22 Sep
 2021 05:45:08 +0000
Received: from PSAP153MB0518.APCP153.PROD.OUTLOOK.COM
 ([fe80::e060:1f09:dd2f:87e7]) by PSAP153MB0518.APCP153.PROD.OUTLOOK.COM
 ([fe80::e060:1f09:dd2f:87e7%5]) with mapi id 15.20.4566.007; Wed, 22 Sep 2021
 05:45:08 +0000
From:   Prasad Muppana <Lalita.Muppana@microsoft.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atin Mukherjee <Atin.MUKHERJEE@microsoft.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>
Subject: RE: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Topic: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Index: AQHXqG2BZxdFFy/L80y8f47JknRQoausbnCQgAD8A4CAAizuIA==
Date:   Wed, 22 Sep 2021 05:45:08 +0000
Message-ID: <PSAP153MB0518090A749E26814966672684A29@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
 <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
 <YT7rL4PhovDOHfHO@infradead.org>
 <75f77917-a8ba-0138-750b-8dedd8f7ce7d@linux.microsoft.com>
 <PSAP153MB0518F021C769875159C3A03984A09@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
 <792dd48b-a246-0456-58a8-00d739201251@nvidia.com>
In-Reply-To: <792dd48b-a246-0456-58a8-00d739201251@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a7a00045-dea2-422a-bf62-a3a055c323d4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-22T05:38:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c9976e-bba0-42e5-b7fe-08d97d8c22ec
x-ms-traffictypediagnostic: PSAP153MB0471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAP153MB047196868B4D153660653F8884A29@PSAP153MB0471.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SK0R0SAcdsoa6CX7saC/En/CePBDxydCsro7fvNHh8d3uz7aiuWDvP40yHnRk5XMRZHJFf0cfj3CwWUhysybrwaGrkQh86kwNFXVC+AVwZ3IV5w8Sxc6QJFv5wkgjPiV+QkwTUgPAjbGIyRx82VcTcZz+FjN9g2uP1aEsyGBFEWu5ECIu5rvNivLjkYYV1ZxUFygWkzDHxizoUYDtNU0bnlenl7wBIxritawuL7IOFQuZRNiZtZfOmSAmh2x0y4a4RPeIX9GNktMCFM4MSRm4/D2b94FQmTcFv8KiH/5aI6eAHF3HLY3rdqUN9ih8TaW7N/xnO7RNCQv55wLrcYxPcqXm2aLxX9EtXMcbNJ41SGNIN4SVS29t8LnjapMoWwCRQ3DdcXIREHifiKr96LtQHxJ2szYHpvcDZh+AtK0v6V2sp7q232TWYh8fc770uwD197YZAqPHShiN3qVJVRHU01BPzFQvvf+SNc1WZOT4Nh6AFCScevRAPSOmPqmmzTvof05GD/WhjnN0wrqJVFrP8J8Za8oTuc2oKoEgxwU43W/oXwFFjOklYPLYmrfNTtkzsDo8n+zQCp6I1gEq74ito2zhYwBxOtcBbDeCiNqza5yfQhHreKVSdQEIkV24E/2+CLO/R7PLUT27hHOIZEnJAjSU7yvHOiR8amkr9ZEuer3F0IJ4+BvX71p03NomOaOwxiaHb8AHPGkC5632ULfYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAP153MB0518.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(107886003)(8990500004)(8936002)(83380400001)(316002)(55016002)(7696005)(82950400001)(8676002)(38070700005)(110136005)(82960400001)(122000001)(66476007)(66946007)(2906002)(52536014)(66556008)(38100700002)(64756008)(76116006)(6636002)(66446008)(71200400001)(10290500003)(186003)(26005)(86362001)(53546011)(6506007)(5660300002)(33656002)(508600001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRMcE1TK2g2ZStmYUtaVncrdFE0cnV2ZkxRVHJOWVIvQnFkZFd4a2VvWVhi?=
 =?utf-8?B?QURlZkVpTmxLcDNvS01ET3lkakNnUU5nMlMwZDBGQ1dIVE1GNVVpUGo5ejIz?=
 =?utf-8?B?VmVleHJyTU56bC92R2xCckVYL2Jabm1CNmRTSFQvZlp1ejV5SHNiZFF1SjRz?=
 =?utf-8?B?dkFENVMvR3RpMzRmUFpnZDdMT3RyMWltV0kvb010cVdEcEZ2T2NSaWZsUFFx?=
 =?utf-8?B?UE8xNFpBOFV0Ujhac3hId1gxYjRsVEEycmNLblByV3NGcTV2M1lNUXF1ai84?=
 =?utf-8?B?MUdUemxJakhMVlJYNVFPcnhWb3gvOTdTSnRJdkpEdkdOQVlnM2FSdU81eUxB?=
 =?utf-8?B?d25DV1pJaWJva3Myb01DN09MazlVbmNmZGpMLzlvV3djbGRvSTA2a1JnaUNP?=
 =?utf-8?B?VldlVUNqSyszVjd0S3FYZzh3L2NRUE82SHNZVjhoTVEvS0FIS3p2MUVDOW1s?=
 =?utf-8?B?MnAwbVo2dTBIRDdGVzQxc1NlTGJxVDI4TFZ6b2NFd2V4aVg2ZXB1aURLNU0x?=
 =?utf-8?B?NG5hZGdPd1VnZGNxTjVNSndLRFdyS2w1aURMbTdBWkxCdFA0MnhoMkNnTDhY?=
 =?utf-8?B?VFZTTmgxbWdSQ0lIcFRvMGJ6dzFOT0pUVjhDSzlIYVFHZDdHTUp1dzhCNzF2?=
 =?utf-8?B?ZTBLYmI1MDVnbzBUT1hLem5aWnl0SkhZcnZqdUc3S0h5V1JLTkE4bWtGV1Zi?=
 =?utf-8?B?ViswWUthdy9HREFTQlRjTlZuTWZnL0RSZ2k4dmN0Nk1YYXB2R1hwTkhweHUz?=
 =?utf-8?B?bUtaMkNBakVjdVRySkRRYjliVlhQT2E3SENKSmczWjZtN1QyZ054RXA4RDJa?=
 =?utf-8?B?TldNVjZvMDhtSnc4SlJmcGdqRG94ekd1TWgrZFpWYlB4Snc3VHJHdStvaVBP?=
 =?utf-8?B?NUUzeVdLYktTbzc5L2xhTjNHbDBNSDJWQWF5YnoxbnBpWTBvNE44OHhCbnIw?=
 =?utf-8?B?akJKdXVHRU8wNEhwR2VkQk9zRklCR2JJd3BZZWRCQVA3VTM5WndpZ0tqU28v?=
 =?utf-8?B?Z01sTnBZYnNBdE9Cc2tLUEdLa0M4bkMxOUptb3ovMGxWdW5zdEY2TUVOdFNj?=
 =?utf-8?B?NHRCZExlUFdtd3VJc1ZmSUx5NTR0aER5U3NRRWFRbGxOd2UxejluVEFOMDVJ?=
 =?utf-8?B?VE9JcmZidXN0QVg5ZE8zREdMQ2I3OGRCK1o4bnYwREI2VnlDVTk5eitGak9I?=
 =?utf-8?B?ODRrMjdML21zTGhCTXF4YU13Z21qSEdkZCt3UE9OWmU0KzRyc3B1emRtNjlq?=
 =?utf-8?B?RDBLRC9RQ2FNMllBZnc4b2NtNEExaG1iYU01eFFEWFcrOHU3TDZaSXhXMUly?=
 =?utf-8?B?OE4zclZaNXZmbGpaRTM4R3NjbXpraStzNFQ1cG9oRUJqeC9xVnVUZ3FsaFNS?=
 =?utf-8?B?dWhUMDRvUVltWTQzaUVMUDEzZHFkdlVzaXZWbUhHQ1R6cldUcEVnNDB6bk5L?=
 =?utf-8?B?Mll3YS9yRU0yeDlQeEN1ZVYyMCtNOU13dVNlWFAwblNkU3cwb1MrMnZOMUth?=
 =?utf-8?B?eFRNaVZPeExYR2dranpNVXlOUlkzVkVYMlRLQ3loR3l3WnQvWlg0cG82ZklV?=
 =?utf-8?B?dHJHMWtrRHdWOFZUWm83dms2L2g4VDJKTzduV1lOSXd6UEtvaG0ydHFPdzJF?=
 =?utf-8?B?OHRvZmZaazhiZzlTTkk3K1h1emZ4OWFRUEoxclZnZ3ZIeU9wVTR4U2tKNmx6?=
 =?utf-8?B?R3dBU3crTTB0Nko5R3JBTVZjWXJUUHlxK2Zhb2J1TGlaWmVrYVd2cDVWNmp1?=
 =?utf-8?Q?zLgVzSpKCvkuyPKKDH8DORuCN0KLWZYDS/lfg+Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0518.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c9976e-bba0-42e5-b7fe-08d97d8c22ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 05:45:08.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdVxG5cccY6jliYYNehA1KaVZJWKHainN18mcwDfXnP3seaO2uVzNrARSTvNn+WYbHukuZUWsGG5RwI/dH1L4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0471
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgQ2hhaXRhbnlhLA0KDQpUaGFua3MgZm9yIHRoZSByZXNwb25zZS4NCg0KT3VyIGRyaXZlciBj
b2RlIGlzIG5vdCB5ZXQgcHVibGljIGFuZCBzbyBQcmF2ZWVuIGhhcyBleHBsYWluZWQgdGhlIGZs
b3cgb2YgdGhlIGNvZGUuIFBsZWFzZSBsZXQgbWUga25vdyBpcyB0aGVyZSBhbnkgb3RoZXIgd2F5
IHRvIGdldCBzb21lIGhlbHAgaGVyZSBxdWlja2x5Lg0KDQpXaXRoIFRoYW5rcywNClByYXNhZA0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxj
aGFpdGFueWFrQG52aWRpYS5jb20+IA0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIxLCAyMDIx
IDE6NTUgQU0NClRvOiBQcmFzYWQgTXVwcGFuYSA8TGFsaXRhLk11cHBhbmFAbWljcm9zb2Z0LmNv
bT47IFByYXZlZW4gS3VtYXIgPGt1bWFycHJhdmVlbkBsaW51eC5taWNyb3NvZnQuY29tPjsgQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPg0KQ2M6IGxpbnV4LWJsb2NrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYXhib2VAa2VybmVsLmRr
OyBzY2hha3JhYmFydGlAbGludXgubWljcm9zb2Z0LmNvbQ0KU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIXSBibGstbXE6IGV4cG9ydCBibGtfbXFfc3VibWl0X2JpbyBzeW1ib2wNCg0KT24g
OS8xOS8yMSAxMDozMCBQTSwgUHJhc2FkIE11cHBhbmEgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkg
Q2hyaXN0b3BoLA0KPiANCj4gV2UgYXJlIGluIHRoZSBwcm9jZXNzIG9mIG9wZW5pbmcgdGhlIHNv
dXJjZSBjb2RlIGZvciB0aGUgZHJpdmVyIGFuZCBzdHVjayB3aXRoIHRoaXMgaXNzdWUgd2hpY2gg
aXMgY2F1c2luZyBkZWxheSBpbiB0aGUgcHJvY2Vzcy4gQ3VycmVudGx5LCB0aGUgTGludXggY3Vz
dG9tZXJzIGFyZSBpbXBhY3RlZCBieSB0aGlzIGlzc3VlIGFuZCBtb3N0bHkgUkhFTDguNCBhbmQg
VWJ1bnR1IGN1c3RvbWVycyBhcmUgYmxvY2tlZC4gU28gd2UgYXJlIGxvb2tpbmcgZm9yIGFueSBz
b2x1dGlvbiB0aGF0IGNhbiBtaXRpZ2F0ZSB0aGlzIGlzc3VlIGFzIHNob3J0IHRlcm0gZ29hbCBh
bmQgaW4gdGhlIG1lYW50aW1lLCB3ZSB3aWxsIG9wZW4gdGhlIHNvdXJjZSB3aGljaCB3aWxsIGhh
dmUgbG9uZyB0ZXJtIHNvbHV0aW9uIHRvIGhhbmRsZSB0aGlzIGlzc3VlLiBQbGVhc2UgaGVscCBo
ZXJlIGluIHRoaXMgY2FzZS4NCj4gDQoNClRoZSBpZGVhbCB3YXkgaXMgdG8gc3VibWl0IHRoaXMg
d2l0aCB0aGUgY29kZSB0aGF0IGlzIHVzaW5nIHRoaXMuDQoNCg0KDQoNCg==
