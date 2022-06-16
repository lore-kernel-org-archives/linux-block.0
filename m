Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D636C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiFPRxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiFPRxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 13:53:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36231A078
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 10:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+UCBitoYd5jjl7Y6C8yBpuRC0vVCeecDctZnEls6+NkNu92vvYaNvmeuBF4G3k5hDdcFG879oKTZ4BGy8bS8bqrb3ea9N9+6JkqlSGWOZ1iBZpHs4Y6/rq+BrdvRmMc5YwrI6E4ZblSGvygBNzQAoVBTOHj/V9oVDruwCix+qfywqaYbyX3MCNi+iiSC8UMDhHMWM0NBcLkAzb/9VN/H7MTmhCsDP4e2Nop5sYBTdSVtIXllfWcAqnJBhi626J153pbsyWrb9JkVMNgToG4bb1Q+hRpnOh3mRysXaQvX+wvN8nuchaow5S8rx8brJlsNamXGdiRgekHT2hGqcRHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqpJEJuw+zomruEmVflTl1zP7kC6nS4g/z5PutgVHw8=;
 b=BNJLuBKOWYAssSNhw2YAB6/soCPPud5XHCLYnk6Cnq0rU3+MIYzsV1/8qaRPeLSS+jjrOQq/pvscHIZ2Ic+WUAVKamAwAoUUikCI5kWitBksGDGYLKylJcqxCDChtE/XdwzctvbIJNf41TQDtsVfT00a4TA+xyho1rUesA9X93a4/r06xo/AsLXFER7RTjL1JSpSwjLimihJQiOu7hw5DWfsz9ol5ytHuj7vRtKUjn7lTzoDLoaHXki8xFMdipzsc7MhokMmy/zzjtSEdgr/gRe7i5Bl460iSwE4/A1q/RoeQZbGfUVC8rkPZ9nFXWtcPax+tSWr92JMKfEUjcVMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqpJEJuw+zomruEmVflTl1zP7kC6nS4g/z5PutgVHw8=;
 b=USuQnU1cSh/mxPNoNLbyW8dGb4vyWuZHvlcQ+AynzNUmrgZ2y5c0FJAd3fpu2CwODze9iWqiPBRPuN4MhNEWpSLH74JoQd/sBb01Lbkvw5c/+NR09HUCTN/9OASB7tZQowJxkfrV0DkA6b7w8BN4ROCuRj2iZvYS5sWrgbIKmiDox5biGxqjTSsyT6oI4sZ0ENEFQ9yPP8NrpVhp737zmjlaXFJoW0mOd+KI7v08sIh5xt953lP2kA6NEpGiWSxzuyZAsKbi0nAJCv9m5dKzn9OS1tF4wF+goPXdXW5/SmBD+PBNdOG0x7l91oQnH1uXw5hx7cKVtiHppTNLv4//JQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 17:53:08 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 17:53:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jan Kara <jack@suse.cz>
Subject: Re: [PATCH blktests] check: ensure to suppress job status output
Thread-Topic: [PATCH blktests] check: ensure to suppress job status output
Thread-Index: AQHYgTdItl7HBEZ540Shvx4a749IVq1SUXKA
Date:   Thu, 16 Jun 2022 17:53:08 +0000
Message-ID: <8a10e932-66c9-0f0e-dca0-9fc109a14b68@nvidia.com>
References: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d92db68c-dde8-47e7-3f49-08da4fc1124b
x-ms-traffictypediagnostic: MN2PR12MB3502:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3502F4A1C8E90586B188D540A3AC9@MN2PR12MB3502.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkE9OY2PJ4y5+X/5faEga8ueRTvqOTahm2TL2j6P6zAFyCDF9/wxFsz5wIJj6EN4InPdWtIbTO74nrOe0DPaP+3sOFXPAPNJI6biWmaH3XS4M4sUvw8ogAn3HjscvC8/j7bRT9RSQEGt8c8g7Ott6X7vkHf6rLaOqy8AXiGs3QNcDGP7PJYKNcK9C4YZPM4o5xCZf/Oi4vAefGPANvXbLo9AjPDOa+MkQNnwWXSneAefxhgeDLPmjyxVKGlWI797JORCsuE32LQ/6nb7Oe9D6B+OqX42CzXsDLuV66lsbY37QICHO1P4pFd3TD5geLug1ccdN21g+6QpiVYeYh+rbhFrNMqfX3DDOovh1wkNUfr2jCAYAI4olIDsamMHomOCqsyKuIEvnZ8ayGw2qJBLiC6VBNbp6HYp0Qk0Wkcm1EUtR4TVXJSaNBtmwILCgaLU/BCX4O5d45Uf8asHY9Y4N88yaQpPIC64HhqyJ5lGFL784SyLO66G7eU3Nbl2IMaL61mZ64k5dCWkL/KdL8cer3vBD1pwrw9TppF7A8plJ7huFvEGB+WwGOYXzVrS8e/3JJgfVsp7RRi5HV/NyKNkIWpri6/8wiVrB+r/W0Fx1iVhSuCCh1UdE8823eOHzOHKQa11fer2vcTThooE+vNe0hncLNIABXA3uAoZjubhsiynRVIqvjqAZKlKx0BSOjEFAQKtAZTWJEPpo7mUGFmAMRFyXBIycPsCPCjGaCLtSzOLOzNBOuPrUjOzvfNrWzj2bu3Goh0cEcphWg7aeRTu0LLlhSgoi+0oZPln0ZkbyRMgaRbqjcC5BKYkXpkqHT9Qxm9AiKze7wIG5AIenlaxaE8CyPP2rLkrljFqU5FRo5w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66946007)(66556008)(64756008)(76116006)(8676002)(4326008)(186003)(66476007)(66446008)(71200400001)(508600001)(2616005)(966005)(6486002)(83380400001)(36756003)(31686004)(316002)(91956017)(8936002)(122000001)(2906002)(5660300002)(4744005)(110136005)(6506007)(38100700002)(53546011)(6512007)(31696002)(86362001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUtFcTl5S0pwS0VlQ2ptYlc1U3FQUEVRY0poUjFFN0hObmFyOXNTUndPRWpP?=
 =?utf-8?B?MlU2d1o5YkpBblAxODU2dTg4UWpnVmlEY0p2SThQWFh2a292WVFWNTZHZVlQ?=
 =?utf-8?B?TEtUcnp5SE9SSjEzUmJSbFlPZ0RCVEh0cFFBZ1B3ZEFid2tRYXFTMkNMbk5H?=
 =?utf-8?B?NE1ObkNXcWk3VTBGVzl0aW9hd0o2UC9pVHErUzU2dUhUWmVSU2dkWTUzYzdz?=
 =?utf-8?B?TE9DK05qd1VlL3BwNDYxOVBGTjBuckx4NEg4YzRJSS9vTUtFNkZ3bDhrVVgw?=
 =?utf-8?B?M25PdUd5NjFIYXVuQWVUVGVJTFp2S1V0VVY1Nmg2bFBqa0RBZjJ1bDlXcWJE?=
 =?utf-8?B?RHdacC94TkFHQStnYUo3MlluL0V1aE1vQ0xoZnM2a2JwcEhSRVBDK0o3Qjdr?=
 =?utf-8?B?SERVZldYNGQ2bi9vUmRpa2g0U3lsSHM3QUJRSFV1Y0M3SjZHRER5RWRZb0l5?=
 =?utf-8?B?Z3J6QXBCeGFQaUR3VjJRMTZrakIvRUswNkdNdEtCU0I5S0k0ejJEZjhBWFhs?=
 =?utf-8?B?ZXBlMU9yTnBkRWlOckhOZVI0VUhubWVmMkNCRzk1QVJrTE5hdE84M25Db1J2?=
 =?utf-8?B?eVdlRkZWaUhrUVU3cFFsM2hkM0hqbTFZTCtYUzJ0VmdrajduU2R1Q09qWHZN?=
 =?utf-8?B?R0xPTkp0aC9GMmFPZGZVR0F5bzlUUFFKcDRDVVBkUWREeE5NRDZCWDcxSjVi?=
 =?utf-8?B?OFFERjZSTmhFSkJWOHFtQm1ZTGdXdG5ESGdkZVZPSlg0a3V3YnFRRUxCTmFX?=
 =?utf-8?B?QlBRc0l0UDl6dlBJYkVpYWxrODRzWHBwa1ljT244UEs2U2pDRUpSUDd2Rlpv?=
 =?utf-8?B?MWVuWEp5VlJ4N1FubkNZbFNnUXV1MGlsVmlXTVlMREw3ZEMwdkhCbTE5WlZZ?=
 =?utf-8?B?azRUR2hCUjdydXMxRlI5QURXaGFMbTRvUGVMTGdiOElEbzA2dTcxR3hGQzNJ?=
 =?utf-8?B?MW1Pc3hTeUh4T2dOckxUZGQ0aHp5RFNnUWU0N0NVbnd5LzNMamgyT2tHMGVY?=
 =?utf-8?B?Q3BVeWhwU2toRmJCZmxHYTFGUEVkMFFlVVRIcCtFdFlWdnlsZW9zdm5pSVNI?=
 =?utf-8?B?N1RCNXhVRmVGSk9CWGRvZlU1MmZKQ2xzb0RVOGh6L3JQQXZMSk9ZenFjRTVL?=
 =?utf-8?B?WnFpZ1pOTXcyaGQ3eHNTL3hrMGhTL0F4MEFMd0NHZWZoQTdZMGZvZTBqMHBy?=
 =?utf-8?B?d0RNVHhQbmFDNU0vdi9PMmwvMGJxNWgzU0FhdHdHbXBOSkNEZU16ZEFYYmJT?=
 =?utf-8?B?QVY1M05WUCtmYXpPcTNobjdIWDZWdk5NenJic1FobGpmRnhpNXdvcHFGRGtX?=
 =?utf-8?B?VEttaWVMd2NHblhhbHJkYS9UK1VJTkV0a1hmeHRsWXUzaCtNZWZwZWp2K052?=
 =?utf-8?B?YTlabFowNElNVGt1RUdmTWNtSFZ3bEtqSk1wZW5yL1ZaWjR5dDdOUG44Nncz?=
 =?utf-8?B?YzVqTldEdEFMMUp3TG5GbzNiR2NqTkNKWkpUV2JsZFpkVjY2Sk1HVFVFa1Aw?=
 =?utf-8?B?NFRTZk1PVFR2T1RVZXRrOEl5aTlsYllYTlYvTVBUMkhiZ1hEWFltVzVScGZS?=
 =?utf-8?B?eDJGcDNyaHBrUjJIY0JKRi9tL20xZ0V6MTVmb0FJV3p1Rjc2Y3Z4aGxmYk9h?=
 =?utf-8?B?ekc5Y3RwdEwvWlovM0tkN0k2WTBaOCtvcFg1aVpESHg5NUFucUJXQ0RBSStv?=
 =?utf-8?B?VGV6eURWcHVvUzNKZjRVVytLZTlINU1BVHp3WGRDaFVhRnN5c0JqVUVuQ2JP?=
 =?utf-8?B?T1ZUYzM3YjZ3TVpubU5HVEhRQnVweWhaY0N3T290ZUg1S2taUGlYMlIySFYv?=
 =?utf-8?B?KzN5NThXQ3diU3gxV29zT0h0eXBKd3hwcXBmVlc2UEpraEpyT2c0UzJ2RDdu?=
 =?utf-8?B?QWZhS0p3SnR2cmtnTDlHWmE1RjQ1dVc5OHRjckJocFhZTWMvR1F4c1hWVDVT?=
 =?utf-8?B?WlU0ZkowbjlVYzQyK2lzRmducHE5Wmk4bDZJU1ErL3ZOSWJEUjNjUncwVDhP?=
 =?utf-8?B?c0sxb0hicUlXN3FPL3lmSHJ1RHhkZ1pyKzlaWEFWUTVxQXExb284WGhVd3Vp?=
 =?utf-8?B?a0c1SU96MGVLUGZIaXpMV0RnUDFkZUtKcnZhVnNIRm1rRTBOL3RHN3MzaG5O?=
 =?utf-8?B?LzExd0FFYk9Xek14NzRlejg5SWxhK0hueGdMeUlZYXR1TlJRaXdiMjhKV3hY?=
 =?utf-8?B?eGpzZ1dxcm0vZWM5bFl2dHY5eVUvTmc2OHVlcmdyRk93RngvMnZReEQ5Sk80?=
 =?utf-8?B?em9VYXFCNU10RElGRHVJQkJBYTc5UU5HMkNnZHNvWFcrb2ttT3ZSNnU3QS9j?=
 =?utf-8?B?WXhXcVJOTXlTNVYrQVpRZlFFaklhRTBUaENvc3c0eXBQOGc1d3E2cUJrZGM3?=
 =?utf-8?Q?SWJ1ZdolDvX9oZThG6NY15fAYMnf3yxlJe1KP+Ji9eEcp?=
x-ms-exchange-antispam-messagedata-1: g2qLUnQ90RMZag==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32548A09069614398358C9E4AF7EAB8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92db68c-dde8-47e7-3f49-08da4fc1124b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 17:53:08.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jA0NYF2txghY98KEnELGxJ+Q3ehiBloIHkhka9jjYoFlapCbiYPwEoKvVsnIsQtTQv/oQhiCKT1VRbw5mhtmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8xNS8yMDIyIDk6MTIgUE0sIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBVbmV4
cGVjdGVkIGpvYiBzdGF0dXMgb3V0cHV0IGJ5IHdhaXQgY29tbWFuZHMgd2FzIG9ic2VydmVkIG9u
IG9wZW5TVVNFDQo+IDE1LjMgYW5kIGl0IG1hZGUgc29tZSB0ZXN0IGNhc2VzIGZhaWwuIFRvIGF2
b2lkIHRoZSBqb2Igc3RhdHVzIG91dHB1dA0KPiBkdXJpbmcgdGVzdCBjYXNlIHJ1bnMsIGVuc3Vy
ZSB0byB0dXJuIG9mZiBqb2IgY29udHJvbCBtb25pdG9yIGluIHN1Yi0NCj4gc2hlbGwgZm9yIHRl
c3QgY2FzZSBydW5zLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjIwNjEzMTUx
NzIxLjE4NjY0LTEtamFja0BzdXNlLmN6Lw0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBL
YXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
