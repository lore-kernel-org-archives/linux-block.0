Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD727C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 21:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiG0VhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG0VhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 17:37:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97AB4F65F
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 14:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeeHaKFIiSpOIjsDRzwr+Xz/ilAZPoScOaj78sTDatCTMPEIgjmlDLJXZCyTXaJrf3tdy9jDhIkSqSRs/1INiIX9IFHmvrtPSMJT01MKnRCXEXs+FgeVFa+vVX2bLVrFqWdg6F2thkqvrm0uTr+1tqstSEkcKokhOr2iqrxzEaS19Sjja25kHj73EG/P7LP3toataILdKPxq+sNUynuQtIjqPqIjxnrVGEkj8YP4RETFFY2dPcyc5poegPpY2Ohrh+wNu2EEkrURS5S/44AIsoadye6VwGTQeOfBGZ5HOfI2IQZ7tTuqgpxpEsxu2rf2sI2Eccue7asKPKrahmiY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3DBH5Zn2JTurskFGWZxQrhAiWnivOBEzuG8kWMbGgY=;
 b=SgpG4mkzuay34kiT5VWsEwgoRmpcF3h4T6qJNoAy9h8nANnhauPGtOW0ZIATv4mIgFlIHxkFuzJmIgVrXbVdBSWAyu1yX/Wsg1Pixhk0wJjT6JJfy1tgGAcqU4BhLOlDOufqElbxpR03xZ4NKOpkuN/qHqrellT5G7Zyfl7H+nWfv2+A2NJeiYyvqHqBiYI2q214RcOiowwVZoUkYDvl0iAgF9rqPltmxuFnfp5M6G1c2RVB2AOD8ToCsH8HhCx5y9xFWKYSHNVf7k+FSarAXA9JHOnISiGPY7kLo1K/zOhkKqL0o3uCXoZUGg4oOZmOY0UwRIk75QiHLYbLTdJFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3DBH5Zn2JTurskFGWZxQrhAiWnivOBEzuG8kWMbGgY=;
 b=O4kFOg/agdu2D0/BsWcJy8hq0AYmVHz9YPWEYihk4dx67PP7gRm5DTePTC/q4/MhwThK+M+iapkbly0RZcG69pLLDVdk96Cow9R0fg8g2OqwE0ZUyvADBPBgyY/MTsNV2pPUqf+zRX4zCMfv+7G8ZW8U5G7ZfV6gR5dbk96CccYmdvrl4O4vL9hIGlOcLHP0xlxFHcL21/NqRudvuV/2ythGm9ojW2wXv9zwFr9kzR2Gt5bVZCr6RbTpkajPcLzU0/RSkrwnMqfuhFOj1xQHQqc+wuz4lH94CcvIEpplHF1SZ/2N2NGNWu/LlyyZx5ubfUq9HdRH2UQd5bdgsj46Qg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BYAPR12MB5702.namprd12.prod.outlook.com (2603:10b6:a03:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 21:37:15 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 21:37:15 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Milan Broz <gmazyland@gmail.com>
CC:     Ondrej Kozina <okozina@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: Errors in log with WRITE_ZEROES over loop on NFS
Thread-Topic: Errors in log with WRITE_ZEROES over loop on NFS
Thread-Index: AQHYobkEh/h8x0MNWUCmICxggYkFMK2SvqGA
Date:   Wed, 27 Jul 2022 21:37:15 +0000
Message-ID: <c1455cb9-44e0-7add-58ac-d63876a22cd9@nvidia.com>
References: <975ea807-667d-3ef3-b3e2-26b22ea74029@gmail.com>
In-Reply-To: <975ea807-667d-3ef3-b3e2-26b22ea74029@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5ceaa0-c226-45f4-a4e3-08da70182c9c
x-ms-traffictypediagnostic: BYAPR12MB5702:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvKah3Ne6PS0gA0jIsExwkSzGgxve36zX39MEubed/cHZ/nuqRrdzrPlnKyd82B63vWxPns3vYTQuLypNI2b6YOeFO+cqzKQYsvgs1HtQe0UaaHFGgby65QK1/qz19S3f2WkaSiteCcz31xAWWCbqYs0X9sfvfoSCe1DarSxW6fstwZWhxjzxrytODe7+g3kurnVyvXzsizLS0gHa4D1WouG9+g8kro7KI8/infEyxCF/S9lHFjD4ADQHhvK0pfdD3xa0//rPC0GuiR77a2SuYi/G9f+ZoB6l/JwMueE4e+NXJCSsEPOIp0b1Mpb4vrd1TafTYl+gVUeeaakB8bL22eyZ4xCRyAEw7eHt1CWu7ic85DWmQ7i3lTyja08aYsV2sfgpyJMV9gwr8neJGN11nhsG567+VlW49LB7AmcxmhW0yfklG/L55Nd/iF8Y4CD/9PZ7NRt9wVPn9yGVNdsOKqXZu0cLSfy/6hWzCdRhk9lIVbuTkt7wtOPMhEHj4pS9TCIHT8YRSEGlurOSQ/gm/Au71gLaXzF29YsKZDaHNsOc4CwXtGESRz2V5DCL2aZSlL50o3Wy2eA64NxTDZpTjy2Vi18wc2aAHN4fURWY7IjqAH3/wVlsLNm6oaMXL2UcAlg6v0gAwjTh+hHcjS369asZGn0Oog+HK9UjojTutR3G/8beJrGnUm3S6HlwX8nBTfWD5HXDMkCnFTa1/yTdZ8/kT9M2o78+XGZBgb1+PuSbFQjB0y52HyUSCrVIyTKCBAzjD9Fw/cUMC1wV7THfrXbZvLWhXlmp4jiOvQRXr9duOYX83QZr6TlqHqDJScxUAqCTpMZX7AoQ7HhHGm3ssZE3WhS2/AhrLU4Xt7d0cZlRhA8fHjHPa4AEi1Foim2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(122000001)(41300700001)(2616005)(6512007)(38100700002)(6506007)(53546011)(186003)(2906002)(38070700005)(6916009)(54906003)(316002)(478600001)(31696002)(6486002)(5660300002)(8936002)(86362001)(36756003)(4326008)(31686004)(91956017)(76116006)(8676002)(64756008)(71200400001)(66446008)(66476007)(66556008)(66946007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBOUEVkN1p6VlZlNkdQWlV0cGJ3MmFXdUQvNmNxdE0rVlR1a1VBSlZHT0N2?=
 =?utf-8?B?dHdmWDErQlcwZ1duRGVEQ1VzSzJhOHJtUUdaSUFZMGJTVjZjclNtRjFpVkJW?=
 =?utf-8?B?aDhrK3Nnak9HczM2Wit2RSswYitRWjhlcXB1L3M4bU8wSUI0OVdqRitaUjBl?=
 =?utf-8?B?MFJmVHZDb0VXSDA2cTl2RGlYZlFuR1lrcEYzNkJBOEs3M3JBVzVXUFdSb25w?=
 =?utf-8?B?UURNSGdxN3c0azNqMElUUG82SFA1ZUEzRlRFSVVXUm84OFo1ZTZmaUp5SXJv?=
 =?utf-8?B?SldnQ1NDUk5WMTM2cGhzSUdUWHBYRGQxbjBWOEkxV2NpS0xIem5WVDdTUEY4?=
 =?utf-8?B?UENZMmU1a0phQkdBczQwYUhiaXp2ak9RMDJFbWlqaTkyQjFsZFBneElBRGdT?=
 =?utf-8?B?dUc5a0Y5SldTL2hXZzVHVWR1WllMVDZZWUQzaEpsR3hIWSs4d3ZKTldzM1g5?=
 =?utf-8?B?cm51QVo3UVVSQklQamFhZjdGcldYK1RQM3NGT2ExNVlNK2tRd2w3R2duc1l5?=
 =?utf-8?B?cHVVSFBuNVVGbkVPZ0hpRDJVTDNWM3NZVGZ1NWxuS210cURJWUxHb0syYjFU?=
 =?utf-8?B?QVhrMUZHRHMxZlNCRitMUEd4VlR4aFV1ZC9EbWdQRTZod3lndkMrclFBdEIr?=
 =?utf-8?B?ZHYvT2hEdzE4N0NOSjA5YWZIQ1c2MkZXZUlpa1dLT2JLNTZGaDZZM0NJSWJ6?=
 =?utf-8?B?ZHVxMTJMYkdvaEJKZGp4R3YxVFZGa0RrSVFuQTlsQ2I2MmtCUmFIRmU3cWFx?=
 =?utf-8?B?TzVJaFFxU3ZNTWkwKzNGOUhKcDhFWHZqZjBBOG5wQnVuSmxiVTBvbHNXU0Rw?=
 =?utf-8?B?QTFrbi9UK29GbTNzKzNiQ0hxQkZuTDIyVWR4Wk5xZW5SYmRLalEzd0padHpW?=
 =?utf-8?B?SEpSVkpyb2dzb3BFUXEzUzhpSUU0Y0hKTHh4V3daamtLWGJrWkJ5SDk0cWZ6?=
 =?utf-8?B?ai9WUVB4TURVTzVHRUZlU2pxVmFaV096Y1FuTXpuTTJmTFh5S0hxMkVneGpa?=
 =?utf-8?B?U3JuemgxVlg4R3g5Z2JBMWJVeFE4cVJxSmwrVElyU05XL2tTSDMwVEhyOGNU?=
 =?utf-8?B?SC9LYlU4bTNsNVp2TFllRlA5KzZRazRXOFRScG5YcmlDbHkrOUQyRXZuVWVZ?=
 =?utf-8?B?ZkZYL2Rma0RBaUJtd2RZOElnQjQxZk1ZL1J2dVpoYkx4M1VucHhaQ3pwNExZ?=
 =?utf-8?B?bnNTZ2JyY3pQQUFreFlPbzZTaU5saEpMb3NDMDRKVUsrNk1CZWROTG9FWHJz?=
 =?utf-8?B?eDVzbTBJVnpPTGZUTVhEZ2djdWR3SytDV1U4RS9jNWZQdUVxQ2VlNDF3N0NL?=
 =?utf-8?B?MzlaWmM3Q1hheFgxY0l5MUZXZlpQUjY4VGJILzhxOVozQTg2cTJrVGJuUnkw?=
 =?utf-8?B?K24xWnVkZXpkclJSZzNLZnRNL2hpVGNxNFNHMjFuN1NDWUZGeVBNOG1YQ0ZI?=
 =?utf-8?B?NFIwYm9IdUZxQWxrMitEY0duZHM3L2NEYlJ2dzZtS0h5eUFXdlQ2bGwzTFNB?=
 =?utf-8?B?WFkvREExUXU5TW9ERVU4ZGh2QkVIS09XZmZ2VE12dVdVaVVqeGc0ZjNvb3U1?=
 =?utf-8?B?aFRlRHlHemF1RGRMTXVrVEZ1aWM2Y3dRT1VON1g3UjhlREo4OUtKZllFOWpU?=
 =?utf-8?B?RXVFdVFabmpKaXJObnJWZjNRTnNycEtNR1h3dm1PMHI0REJyM0Vob2RXK3Ix?=
 =?utf-8?B?b0x0WGVJN0NKaklEMUZaekc3YVJZWWJ4SXJBbHhaaFI2ZHltV1dEaHRacUt6?=
 =?utf-8?B?Wi9pTkR1S05sMEdhMnVNQk85V2c5Z1lJN3d3R0srSk5xRUtkQXRoOG5weStU?=
 =?utf-8?B?YWtaZER6Nlc5cE1TbzhJMDl2aHZqUldxVFRkcE93UG90QytjeFo4UzV6NjBO?=
 =?utf-8?B?bm9ocHZsdkRTRlNhUHhsTmxSSWNDZ3BtMlozbmpwMmNpUzNjUC9XT2xmYkxY?=
 =?utf-8?B?MGpzdEZCbE0yRXRobE9rS1NOdXhyQUtGajZXZk1JUTRwU3JueHlwWTZWRGJu?=
 =?utf-8?B?TGxLalluZXFVS2FwVUxoV1hBajFiSVUvbUkzeUhlUHNNdkZUVkllbDQ4bmx1?=
 =?utf-8?B?ZGdpVjNyTERpVTBSSjZjcDN6MXlrdGpuc0l3UmdQRnNxclJHbnJNWFNhQnVO?=
 =?utf-8?B?YVk3NnErYUtxdDlSZCt3eGMvU3hBSXNJWWRHWks1MDlYQ2dHeHgvN2Uwb2xq?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01A53BA2B455D1498FB4BC7F667D64E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5ceaa0-c226-45f4-a4e3-08da70182c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 21:37:15.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qe7rTddtpWrWBy1CqnfiDGp6sD6dbDl4P9VW6GEFjjSiqg/xHx5pN0o5+N6ZRbaikll6rlZYZcoe+HHtmfh4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5702
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yNy8yMiAwNjowMSwgTWlsYW4gQnJveiB3cm90ZToNCj4gSGksDQo+IA0KPiBXZSBzd2l0
Y2hlZCB0byB1c2luZyBCTEtaRVJPT1VUIGlvY3RsIGluIGxpYmNyeXB0c2V0dXAsIGFuZCBub3cg
d2Ugc2VlIGEgDQo+IGxvdCBvZiBtZXNzYWdlcyBsaWtlDQo+IA0KPiAgwqA6IG9wZXJhdGlvbiBu
b3Qgc3VwcG9ydGVkIGVycm9yLCBkZXYgbG9vcDEsIHNlY3RvciAwIG9wIA0KPiAweDk6KFdSSVRF
X1pFUk9FUykgZmxhZ3MgMHg4MDAwODAwIHBoeXNfc2VnIDAgcHJpbyBjbGFzcyAwDQo+IA0KPiBC
dXQgdGhlIG9wZXJhdGlvbiBzdWNjZWVkcyAoaW9jdGwgcmV0dXJucyAwKS4NCj4gDQo+IEFzIGl0
IHNlZW1zLCB0aGlzIGhhcHBlbnMgd2hlbiBhIGxvb3AgZGV2aWNlIGlzIGFsbG9jYXRlZCBvdmVy
IGEgZmlsZSBvbiANCj4gTkZTIG1vdW50ZWQgZGlyZWN0b3J5Lg0KPiBFYXN5IHRvIHJlcHJvZHVj
ZSAoNS4xOS1yYzgpIGJ5IGRvaW5nIHRoaXMgaW4gTkZTIG1vdW50ZWQgZGlyOg0KPiANCj4gIMKg
IyB0cnVuY2F0ZSAtcyAxTSB0ZXN0LmltZw0KPiAgwqAjIGxvc2V0dXAgL2Rldi9sb29wMSB0ZXN0
LmltZw0KPiAgwqAjIGZhbGxvY2F0ZSAtem4gLWwgMTA0ODU3NiAvZGV2L2xvb3AxDQo+IA0KPiAN
Cj4gU2hvdWxkbid0IHRoZSBibG9jayBsYXllciBiZSBxdWlldCBoZXJlIGFuZCBqdXN0IHN3aXRj
aCB0byBhIGRpZmZlcmVudCANCj4gd2lwZSBtZXRob2Q/DQo+IChJIHRoaW5rIGl0IGhhcHBlbnMg
aW4gb3RoZXIgY2FzZXMuKQ0KDQp3aXRob3V0IGhhdmluZyBhbGwgdGhlIHNldHVwIGRldGFpbHMg
d2hlbiB1bmRlcmx5aW5nIGNvbnRyb2xsZXINCmFkdmVydGlzZXMgdGhlIGl0IGRvZXMgc3VwcG9y
dCB3cml0ZS16ZXJvZXMgYW5kIHRoZW4gd2hlbg0KYWN0dWFsIGNvbW1hbmQgZmFpbHMgeW91IHNo
b3VsZCB0aGlzIG1lc3NhZ2UuDQoNCkluIGNhc2UgZGV2aWNlIGRvZXNuJ3Qgc3VwcG9ydCB0aGUg
d3JpdGUtemVyb2VzIHRoZW4gYmxvY2sgbGF5ZXINCnNpbGVudGx5IGV4ZWN1dGVzIHRoZSBlbXVs
YXRpb24gcGF0aCB0aGF0IFJFUV9PUF9XUklURSB3aXRoDQp6ZW9yZWQgb3V0IHBhZ2VzLg0KDQo+
IA0KPiBJdCBpcyBwZXJoYXBzIGp1c3QgYSBiZW5pZ24gbWVzc2FnZSwgYnV0IGl0IGNhbiB0cmln
Z2VyIHNvbWUgcmVwb3J0cy4NCj4gDQo+IE1pbGFuDQo+IA0KDQoNCg==
