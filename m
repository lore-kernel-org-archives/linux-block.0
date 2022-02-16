Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A26C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiBPRfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:35:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiBPRfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:35:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383F2AE288
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEnTGUIJQnYyMG/hRp8AP1Doe28FWD6pVC2/Aux4QXYCS4htphUVERqTAkYmXnGmHai9Iek5hKlcAzj1zrdt1HjkEJoUxpyTDkfd8IoxInr3DRvy5bI/hFYs9c42No69mwIhq1trfK7NHLHA/vu7vbA9UZ2ltz3iKK30fva+JeLhCs7bLyiuKrpSz1K9bPvidskhkkclvHNkR2jIK1+W1HIXqH5vvRdRAek6Xck1eiWfnD4wqB348v/W3OqmFLdXFEEdvfmZX24OkA0d1Y2ZN/7r95vCuxe1DA8Mc9xOkdMrsKYOPz+6Vn4Dbdz7Tk5y0GyOXi1F75+a0T+8umC2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWskIJCuQmKpbwDyeEWx+w1EDwVtg8F4RMk8eW/97o0=;
 b=S0E1WMvO4qkXBeHp+QTFEkKxFwRUMnB+ZOe4Arkn+cOMxQ4K67uwGV7nl0VDYETrGQNE5p1qI3cVQEvnZHnG+30193bfAGQB7m8UAi1UDYmo9sJCua18r18+IdiPAm6xVgKm2a2AOQAip9JhHQ6BFL9DmgqD8FxspZi+lLjXsjUlwQK7YLE5WxDMdWYtZj8l2LiP8jmaJpxDoUepDqdGi2Pu3ngIwhuDTzRL6O5RodBemhBXXtWg3+4ZDG5kyyPLD4koCitzkT4f/0Pbu+YUm34DyoHhBGA4YlFvcMfmMWY6MLvT1W4QT6KV2Y/eKANpKy1uMwjBw5fwdVQ32ehdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWskIJCuQmKpbwDyeEWx+w1EDwVtg8F4RMk8eW/97o0=;
 b=gXZHIJg2Yx+Ru61SA+qFHW5cEhU8M+fTo6WhuesblCy63i7RWd3itJaz85ah/OqUD72miz6yY/zGh5s4hXJIuo1cgpOalpv0lYaZ8ipUlCo7U0aCHa1D8ic7j8ftOz+OmoPXZazvDosExpOd33S9Sclp1mLddCGJS00dxTsJpXAG4xBvais/niroQW1KuVVCQU2UJuKQkY6tyEkb1FdnWTaojBZESzmMp3KAIbH2U/W28Tb+1kDVHmmlfWt9rUQX8/CIekXhBtvLitP33Vv2ag0sNUzgyqthY1rC+pKJc7/uxm+lS/L4NKch7yLRKKIvZkP6O39Y054zC9YALY+vLw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 17:34:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 17:34:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [[RFC blktests]] test/block/032: add test cases for switching
 queue qos
Thread-Topic: [[RFC blktests]] test/block/032: add test cases for switching
 queue qos
Thread-Index: AQHYIyzc45hy+g0RfkiYkFOSAXYNGKyWcKSA
Date:   Wed, 16 Feb 2022 17:34:49 +0000
Message-ID: <44ef4a68-054e-9b96-b40a-f9d1e65ddb0b@nvidia.com>
References: <20220216115947.85220-1-jianchao.wan9@gmail.com>
In-Reply-To: <20220216115947.85220-1-jianchao.wan9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 345c9031-3a18-4244-6f87-08d9f172a250
x-ms-traffictypediagnostic: MN2PR12MB3902:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3902AA22CEEAF5BD56A828D5A3359@MN2PR12MB3902.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwM2a1bSs63bxkV0i6UbakLTumMo48plLNXoncGPIjICOFgvovTInKr+nZAvgOXxaq03ocpWxkh6I9v7m2yXiQhQ0Tg6B9L0SBmE7RTVE/0L3vglTC2C3653lZ6Udq69pFTm7hzd1Yp8J5c4rSsdOSPqZ2iRtRMv1nkbOc93uGT3fGWXu4hrLZQLZJAGFtOnSDF5/t2PHqON+pLCWXDohRSE5Dn6HYZdRmH3jpTI2YXH6hVF4riJuDBk9GPp+NNe6Hgi2MMRtmcrzEnftBrHfBCUMobpMbNwLiL9ciCEuaVljd0hDJplg5ell555Dfp2rOpUOBjnSY8LsNhr0udSH0hOh+71X4KxETH9P69jWdbVZoy3oJlmRq8eS6rYLvWZuSFy7AsyjJHrsFmoEb4xuBxTmrPvJbdGvSfmEsmn10ufj/gkKMWvbmwV2p/YJ8IQZpec1GfA1c66o/ofXi5W/oR+SeX5bUKC2UuYYEcwm5VZ8PJLmwID5WvpKFRNYJAGKAoC9s6ZKKLoE7LLeE4Uumhl7NrjyPyCoMHfAHCbUWKIjv3lidQDD49IGScUw4qZp45Qc9sEku1IZBAOERAEoKs5l70PFLPMG0HORyNUgUwUXzJ36dq9tmw/CTBLvE8V5ebN93GuoSN+hVAEECVL0m/z1bJU0pxQ3C0rlh5Amf3a4gzWYS80POvQslNS4MFI9moE16EtmL8k7q15eqGGEo4xxOjIhhMpOaZD4w8TWqovLVShtP4w40G9yXFRKZl0PxwL4QkyWPEIrfi7MLH6hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(8936002)(53546011)(6486002)(38070700005)(508600001)(86362001)(5660300002)(4744005)(38100700002)(186003)(36756003)(83380400001)(2616005)(31686004)(2906002)(66946007)(4326008)(76116006)(91956017)(8676002)(64756008)(122000001)(66446008)(66476007)(66556008)(71200400001)(6916009)(316002)(6506007)(54906003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2pBMStibzEwNlhhN1JBWWplR01veWVqN3pad2JYNDMzR01iV0srMHVKbUZn?=
 =?utf-8?B?Smt2amUrdE54enlYaHNUZnhUU3ZSTlFhVW5PbDkvQStZMEF3Ky9CVUh5UXFk?=
 =?utf-8?B?MTZRNTFoOUV1WDVDcmtDSTZpMVk2OGpaNkVBM2pTTEZxM0VQMzhmaDEvZStp?=
 =?utf-8?B?ZDdxNmxtM2FxbnJIZ1hIMi96NS9QZml1WTJCMHh0enlwNlBYTTlkT0Zwb2dG?=
 =?utf-8?B?Wk9nRFVIeDAzUmw2K1VTcFlpZkppY2FZUXVVUklmbUdBWHd0YzdIWG1aS0FX?=
 =?utf-8?B?OGZFVEZIc0o3TURGMW5NalM3bFA2a1VFNFlid0UwMDNreXRFN2NqQ04wQkZn?=
 =?utf-8?B?c21GdFREY3NTczl4RER1N3dzSDc5Nm81djI2d0dSSDBUVTd3OCs0eVNYS2dP?=
 =?utf-8?B?aHpqN09XYVJOVHdXWGgwbFZnWHhCSDRKMkpNWnZEdjZXT3A4WW5CVkRqMUFw?=
 =?utf-8?B?OEM1VmNzRVpDeUgzclYzQkQ1d1lqNzFzRjd5SUdoSzlxWlVJUUtwdm9NTlFV?=
 =?utf-8?B?b1YyaVB1KzlvRStFNWtsQjViZVJWZ29ibEVobTBQMG5sWEVIZGNiWk1UVWly?=
 =?utf-8?B?dXFUbUNWemMvNXZ3bG9DT0JXV1lxSStOOVk0Zyt4cEcybFZXVllpQlJ4TFkv?=
 =?utf-8?B?R0c1SGRNYldaTUc2Q0NWNk91N2ZEbTJXWEMxNTlwUnZueGdYM0k1M3pXbHUw?=
 =?utf-8?B?SjMyQzZCMzk1Y3JOQWhmSzFTZkZ0dUs0OE16anhoeHMyR0VqVlFWU1J2MEdO?=
 =?utf-8?B?aWg2cG0xTzZXZ04rMVZlaXpEQVM0UVVEckpOZXNsUkVac0xCWjlGVlREMTcw?=
 =?utf-8?B?U1FHMGpJRStqeHoyaCtTQXFUSitObUZwQVRhWGNWa1hFeWJTZzNady9hUktU?=
 =?utf-8?B?WXJuc1FJM2xGK1N2NGZxTU9aVVFEQkpCb3ovTytETzJoZ0dhQlVmWDBKcXBB?=
 =?utf-8?B?U2RYd1BFMmx3UFZLUGsrcUVTKzlTUDdGVWVhZndJZ2ZNd2JrUTA5aFpzS2FD?=
 =?utf-8?B?dVNYUjhBMUh4c0svWjQ4MTVHWmtlSnQxQlVpTDdUdVZEN3UxNGNkMEpJTzF5?=
 =?utf-8?B?RDRva1ZzNWYvVlJRcUxoUWNyQm55dFcyR1V3b0FIVXM0YzBPL0I0ZXVSZ3V5?=
 =?utf-8?B?MUx0RVdMb1lVczV2dEZwQzZick5tR09aQy9kMXh3M3lMUnVqck03cUxXbER2?=
 =?utf-8?B?bkJCKzZFNW8zQ0wzWkhJaGI1UGovWGtMem40VU8rRzVINGFxTzA4YWwvYzJP?=
 =?utf-8?B?VzBUNzNnZks2a255aUZtZ1VYNjZxTTJCSy9PUW9UYldrU3V3VzJnd2VzVmMz?=
 =?utf-8?B?emdDU0I3SGFXNmhNVVd1bmovR2lUaUh1NG9NZ0tDMEQyY0ZFQ3Jyb1haQUhr?=
 =?utf-8?B?Nmpwc1EwZjluNXJCSWpGVENGbW5ONDkwK09UbXIrbWY5RWROSUdzNi9pL2lL?=
 =?utf-8?B?M09pcWtDVnRrZVJQblphZ0FESVdUMG5nVElNeHdYUDJGTGVBTkxuNVVpTi9l?=
 =?utf-8?B?VDQxcnJ3WE9qVXQrUHVpNVhYSFFXYWoxWit0T1JzTFkwMXRWd0thTmNGWHph?=
 =?utf-8?B?MGRqZGFPYWZWN3ZVeExNTno3S3l1R2twMmlubCtydnk5SFowbFdaakQxOXVw?=
 =?utf-8?B?M3F3WGJ3RXVWbWVXRGplT1hDRVdORDNqb3lhYnM2aDJvU1E4TEl3ejV5ZWpm?=
 =?utf-8?B?bGJVREtsSmtwYTRPYjg1S1crNTd2YnpFbHBoSmdHcmppbGhPT1BrRHhuWitQ?=
 =?utf-8?B?ZGlWdi9LNDU4WjhyK0RYMUt1Q0NsYkRZbEw4YTBhTnY5T2dhVXBHY04rcEIw?=
 =?utf-8?B?Y0hQejZKN0l5N3NjRGMzWmhVQlJoV083NkhBdVh1ZnE4enBjMmNPRXdKTUd4?=
 =?utf-8?B?OXFUaHgwQkQ0MnF6NC9NdEs1RE1EU2lGeitEVHlRaUJMWiswOUw4T1JEU0lE?=
 =?utf-8?B?RW94Uyt3RHVjQU1zQ1l1VC9Oa2lxNXE1Y3RCaEEvcnRVRWZEdDNNRTJEcDdy?=
 =?utf-8?B?c3liUlJaVFZzYXdYaGlaYU1EbDlNQWZwclU0OWhUZUw4bCtIeXYvbGpRdHhl?=
 =?utf-8?B?UlNHeEpMR09rb0FsaGh4TEgxd0ZvMWQ0blFZZ3p0Wm1XZDI3QzhwdVlVbC9W?=
 =?utf-8?B?ODJlenRGNGxoUm1VMi9ML0d0WXNRZkF5MDViSkFsRmNRY0YydkNYOEVucVVQ?=
 =?utf-8?B?eUZCSC9vVlRjWk52dEFzYXN3QzVEVFlRWjFKdHhMWEJKaVU0bHE4WWg2VDky?=
 =?utf-8?Q?x8sqRSmK0DYt/+BEt/ZBpJimnxzj+Finj7Jlp6ZUq4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F8B69813DFA84C9E6EC2A0AA036C66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345c9031-3a18-4244-6f87-08d9f172a250
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 17:34:50.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuwOGzQNUip5l+jAFRWXZ0q49FQNk6BZaB/r+iZZNSEdBdUTnhZpS6uMESViTVqbufQcLTYpUcfOHOVB/KRalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNi8yMiAwMzo1OSwgV2FuZyBKaWFuY2hhbyAoS3VhaXNob3UpIHdyb3RlOg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBXYW5nIEppYW5jaGFvIChLdWFpc2hvdSkgPGppYW5jaGFvLndhbjlAZ21haWwu
Y29tPg0KPiAtLS0NCj4gICB0ZXN0cy9ibG9jay8wMzIgICAgIHwgNjIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvYmxvY2svMDMyLm91dCB8
ICAyICsrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHRlc3RzL2Jsb2NrLzAzMg0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9ibG9jay8wMzIub3V0DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYmxvY2svMDMyIGIvdGVz
dHMvYmxvY2svMDMyDQoNCg0KQ2FuIHlvdSBwbGVhc2UgYWRkIHNvbWUgY29tbWVudHMgdG8gbWFr
ZSBpdCBlYXNpZXIgdG8gcmVhZCBmb3Igc29tZW9uZQ0Kd2hvJ3MgbmV3IHRvIHRoZSBibGt0ZXN0
cyBmcmFtZXdvcmsgPw0KDQotY2sNCg0KDQo=
