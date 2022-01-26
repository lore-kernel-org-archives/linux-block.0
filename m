Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C6C28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 05:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiAZFMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:12:47 -0500
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:32321
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231923AbiAZFMl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 00:12:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJZ6RWqfhcBr5h7VLOt/8FY12TdWNTKS3D+7//LfnwS8LclCGNILVS2hKTIsCp+JVIYSKSnKgyVA4pbNs0x3L2XAkbKtAydwyctgQVMwOBu925C0FnT6vCDSWZ6S26UXDGSpBCeF14PkFEln9/Qo0CQr/4xtCstfTmJT2NK+XVR+y97kI+X5HMwvK7X2XuetaGSDyQi1/WLwog4UJ5h07GNxh+2OyU6WBB2u3W+bQU8bzfKaMYEutu9Q38AnsTGAsiqS/eKcz1GiwxiIz9/KTh13Q4q/7rtSVrWZlStiHSnjiKH8qvYxr2I16E4SRwgaM8kh9s7CnBeHA+EUoZY3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nbembBlaHvaziijkjeHXTz9byxpKZFNfKGANonxyQk=;
 b=HeuQsYsnGzFOBRrmvxmdtfXCgP+uOWkq7m0/K/QHhLN7B+pvQAJi/ac37enhrbEFA7yplb4GjuxPhzmI8x5uWarVWBSh2a1GQ3o6/IF9tixasc+TTLYb7lNMb9IGtyazyw706vwE4KkKbMPPEso7DLMGRbAhWWJyiseY/MLnDrhdm3UlcBXGmFvAbqTO7CFKjcyz6ricPyZQvY1hLs//4Rct/bK92BflSmEF/tMKZ2YSdLXc/ozGcZzWs+W0jGa3SvDZYStpWvNawlgD8HjUgItr7gp+aUBtBhUwJ3GF0FUgp3de2CeL3n0sLGjgVot5UnG78YOqJ/HOO/ltbkjLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nbembBlaHvaziijkjeHXTz9byxpKZFNfKGANonxyQk=;
 b=AoNoJ/3cIolLBOadSVyJ8Ikm+9DKOQpzGfBchO77KhPNxdXVBjsBGoM0i4uUsAj2N0NShm82BiEJi2zYS6hPzDUpcovqzJQ3u+PgcHZFu/NimXjH6w2t4o9ExRHjxowVYx2DHaV75aRcuSWpwQfJkwWmCS7VnKgsB9xUneNSlGppreXGs3CND9XNJklzRQli3P3aWyilj9rBw/55x6GwOUHpyLiTd9AEDBx5QJ5kI6BWGhGb15IjMSaEoW4ImuJKGrmhsYFUpfxqPjc6jytXzlfYDli0oretR9QwHaBmtHpCwFVysnSTbSe0kFt5+QV7QNsuaNFnFCuo9IXpWVvlsA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB4790.namprd12.prod.outlook.com (2603:10b6:a03:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 05:12:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 05:12:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: remove genhd.h
Thread-Topic: [PATCH 3/3] block: remove genhd.h
Thread-Index: AQHYEQZTC+xBCLQqlEq1F20cejHepqx0xKCA
Date:   Wed, 26 Jan 2022 05:12:39 +0000
Message-ID: <63503f56-11ab-c24d-f665-da2f37d9fe8a@nvidia.com>
References: <20220124093913.742411-1-hch@lst.de>
 <20220124093913.742411-4-hch@lst.de>
In-Reply-To: <20220124093913.742411-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1f89a55-42d5-4d3d-c9b6-08d9e08a7956
x-ms-traffictypediagnostic: BYAPR12MB4790:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4790E261B9493EFA110DFAD0A3209@BYAPR12MB4790.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbME6AOEosWAizmwHtVFiezFCtBOvNefZJQPaak9esd5LQeOOoSxvytGI/xgzZRsvrBsPkhBZ5D+5spCkjWM3kLmfcLKp+rNYkCWc0/lZXl8k99wxunYHwA4JMIAIw4n59ZsarrS0+D3E0LVadmA3jddR2NizJgkZiEJztq/Eo5xtldoaHBPqoIXUIzloVgVjq2hNaT1n5u+2sj40tYXwIGXoyBtUc1NoW/TD4Y+NCtLiPuVPsQyDutgPg4jCI73JXtsJ0AP4/tbnn5aCTdfXQbdVIZkQ5TvYtGYP8ftCgG/Lw3SlShDD0+fw10XrkUi2Nuggqse0uQb2huTSNr7N6wBiy8zOTWDtQKmRYwKOLS0UYMWs+CCZnQTCbnx6OFOzGc+FyyJ5DXPTnJ+n6AgXSPJtUTIyuG1OuWYNwbR3Bof1slfGY9L+5vf8HIxBK5Kq3f+x8jCQLhOlfcOM10AwHLgag2jh1sP3KouMdIeP+PBH8eL5NlQMGFXayz+EpPySwBc8Udv7rE6V9cHb6UCNErvnm8S3DVzQb/c6unhKe5lpob9kKjrC/grJ1KN3ewRl0N6wgluum46ExXMA4N8DP6t301Yv/f0hdH6LyeDDpoUHGsyGfJmyoGxYX5YSqJl+pucgViBfQDaLTwwHpgC3q/iv8hPHzpX/nCIZLa0kFXsTr648OwRTH3P4aN9a9mjVkLWyan5bZvueVp43Hdhb8rvr6L31Dh3vX49jjQNzUQQTnoG+Yc6mN7hfTZJ83uy7PeuyiOGmDZAPatMyYsFnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(91956017)(31696002)(4744005)(508600001)(4326008)(38100700002)(54906003)(8936002)(6916009)(64756008)(186003)(5660300002)(6486002)(316002)(76116006)(66476007)(6512007)(53546011)(8676002)(2616005)(6506007)(122000001)(38070700005)(31686004)(66556008)(2906002)(66946007)(86362001)(71200400001)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGU3SnUybzVYNHBra2FtRWNQdjErZkpjNDVpOXJaeTYveXl5QTd3RVNFQjV3?=
 =?utf-8?B?R3dMUDdwcDVYUTlvcDNiYjZEYk1HdWxBWXVOR01TMy91ZUI3Q1pXQ1FYRzRn?=
 =?utf-8?B?c2pCZVlweTV2cGJWK0c2WlNaekxSRzhmZVJjWUczL3hNNFB5VFVHbk9rYlZr?=
 =?utf-8?B?ZW1OVmk1dFVDdnF2ZjcvOFBuNG5WZDhIbkRmOFgvQkk5ZWRVeDVuTUVnTGpS?=
 =?utf-8?B?K1RLUTBpRmF0Y293eGlSR3l5WVRTWjYvYVd2R29YeDVFbkZvTm9RaWx6eldh?=
 =?utf-8?B?cHNSazVrbi9DaWdRSkI5ZngxMzZESUVpTVcvc3o0VkpIU2N0a2l4amRCNlQr?=
 =?utf-8?B?QzZ2aTZ6MVpsWWN5a0JzcVZra25zYzNJdHd6bTlLMmtQZHdmcXhvRlcrcTYw?=
 =?utf-8?B?eHRxaERkYXc0UXJvc25RNkoxT1RBVXhYMmVZeElsc3J1N2xrcklmeWFzdkJS?=
 =?utf-8?B?MnBHeUVCOHg5Z1dSNW1IazJrdHJoUXZreksvc1RnUDJmeEsvcmVGVytxQ2E3?=
 =?utf-8?B?Uk1EOE9ML1ZDMlBSb2FCNFlmMkNCSkVXSzVYUUtKSWh2dlBwQUUzWkRSaHNr?=
 =?utf-8?B?aDFUdG1tdCswMHBXVUtJR0FUYUhGQVhYbVZkUVQzd3BoM0FwcXdrTENkNmho?=
 =?utf-8?B?Yk1sT295QkFFNTZpSnUvZG5zdnJGeGM5VzdoSU5vUnBueEpwWFg2ZEc1ZjBu?=
 =?utf-8?B?Nm1ES1VNTmZHRSs1a3N4SFllOVVXR1M1WXJMdVg0V3hNRjhWNVhGdHJSTmYv?=
 =?utf-8?B?V2hRTWxGTnEyRjZOMitpVytjUmxNMVp4OGJYSnhYcXplU3ZKd0MxeW9lZlBw?=
 =?utf-8?B?ZU9BL0ZMNjZxWnUrQnBUZFJaaGtFSEhQZVFOazR2cWFxVzNTQU1EOGtONUdR?=
 =?utf-8?B?amFpc2M3UW54d0UwU0ZVanBoaWFteUh2NXVVeW9TMllvaDl2cDNtbGpHa1pP?=
 =?utf-8?B?YTdQOVpYU1ZMa0c0NnBhbS8zTlBVUmVDdDI5Wm1tb3VwT09pV1MrcXJmcjVS?=
 =?utf-8?B?RkJhdFdkNFNjaTBZRkEwb0s2RTRrWEMvK0N6S0JQcldCNWpuUnhQbzZCTS96?=
 =?utf-8?B?NFdTUkZ4WFV0aC9wSXRhOGFYa3hvWlZTSXFCVmlrdDh1MDBoTjNCc1YvRmlB?=
 =?utf-8?B?Vld0QjRWdlN1UHZJbytHc1Z6NEMwdGptekp1dWE1aWRCMG5yUk5YR3c0bDJK?=
 =?utf-8?B?bHFnS2I4WmtPY3VVS3NYREdKQVlBczBoekZnNXNiSnMyOEVNdWliRzlPdVNO?=
 =?utf-8?B?NmJZVVNxeldhSWMwMjMxWHBhelVhZmwyNTUvR2x5VDhOVHZjSFVnaXJBcU8w?=
 =?utf-8?B?SXBTMXlrZEVXS0RFbENzMEUrQlNIbnNuNHFCSzFFcC9XVTIzMTFodHc5WDVz?=
 =?utf-8?B?dkxOUGFETnFwTnpIRWxPMlJXeVVmSFEzSEVLOHNhRlN4RlpweXdtVVRiWTVk?=
 =?utf-8?B?ajQ1dVVkWlBJNmhHN0pFRXJRbmNvNDV4ZVB5V2NKejh5VFN6dHVRMmY2NGpz?=
 =?utf-8?B?YTk3YUlLKy9MUFEzMm9BTkFlTnlCVmx5czh0WGhtWVNWU0lYZHVKQnJOY3JI?=
 =?utf-8?B?REE5a1VsSXB6NVZLYllJTHRyUGpPWXJZZ24yc1NYMzdZZmY0L2t2aUJsb1h5?=
 =?utf-8?B?T1A2RXlubHpVZGNGTERBUTRJZVBNQWE3NktiemI1SmdYYlNZVFZrSEF2NkdY?=
 =?utf-8?B?d2pkbllZSTF0M0lNZ0tqTDZ5d2hVOTUwRTFwQk9wUzhOaHA4NnByOVJ6WG1n?=
 =?utf-8?B?dHM5dDRNOTAxdTRWT3MyTnU2aHNTNjU0YkJwSmVBU1I3S1I1WTk1N3dGNVFW?=
 =?utf-8?B?TGZnYXZuOXJLMWRXeXMzT1ptMUlNS2dwVVZFRDdYUjFmYk1lRDFrTUhTNk1T?=
 =?utf-8?B?WjZnemdmdUMvWkxSY2RTMzRaNGNBdTNlM08rWUVSbUdWZlNyQUtqTHMybFpq?=
 =?utf-8?B?ZUlUUU40YmdjUUJVK0tmd2dnUDVrK0g0ajBVVHZ4S2FGcnNISFNkNys5Tk5p?=
 =?utf-8?B?RVgzL1ZyQjhFS2VHaU9LNUkxK2NxdWU0RC9BRmI1SXVrVHVYYjk0bW5mRTRj?=
 =?utf-8?B?aWZpaW9KOEtOVTFOakk3YVBaNlBmU3JXTUNIOXpWNG93T0paMm1sTmtYNHFn?=
 =?utf-8?B?UjMyZVhqbS9WR09jdVhjR25QeTNxeEdaUXIxd1RTekp3N3MyUzRETTI3NmhG?=
 =?utf-8?Q?ZnXbbgOgLWu+FJcN7xN/9LBVQY5LeON92UztgRAvjbO3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42551B6564212D4F9D0DE63B6D444A79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f89a55-42d5-4d3d-c9b6-08d9e08a7956
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:12:39.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOZyRWdLOj/M9xpWRbf/MoQXKQ51Ecy0V8xp90vKBZgxIBv126VPscjuJ7cWNHnIyYV/Pdv92iIONmVbFAvRNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4790
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNC8yMiAxOjM5IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhlcmUgaXMg
bm8gZ29vZCByZWFzb24gdG8ga2VlcCBnZW5oZC5oIHNlcGFyYXRlIGZyb20gdGhlIG1haW4gYmxr
ZGV2LmgNCj4gaGVhZGVyIHRoYXQgaW5jbHVkZXMgaXQuICBTbyBmb2xkIHRoZSBjb250ZW50cyBv
ZiBnZW5oZC5oIGludG8gYmxrZGV2LmgNCj4gYW5kIHJlbW92ZSBnZW5oZC5oIGVudGlyZWx5Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KDQoNCg==
