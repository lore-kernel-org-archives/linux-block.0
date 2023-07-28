Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB9FC41513
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjG1Reu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjG1Rer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 13:34:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA373C1D
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 10:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8zIWBFv8p12BThf0o9n4nnUvhfM871Vm4EilPR81VNLNB90r+f4qIxPBU38dfw0gdY8rnLOT38DRs3IYA0s3bGLEoHUx5cX33FgWzTSKXTqfFXwovXdoFyMtuPqygv7Mx29Bxy7Y01j44IxXYLorH1yr6asuBJmtbrVbuxPk3WeswA1lXvow88QcrWpeYXhGwFBNs1oTmGeoXkAZM8BTm6xoeptFZMn62RoKlWz8VwcfjIVVf9lwpMoOQjOQQDJZL7T1QTVVhFbmkg7xhPwi0xJmjc/ulVZfTinukhkjpnIR0VkzyHO9I8SfNW1A5rHCbG2004DBp390uaGr8Q0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FQGBFyAZ2OjJ3feNN1x8tXDdhPdou1KxUMnXwVd0O4=;
 b=Lwp8Gu+cTOFwxvRYgxc9dQsabHkgoMn47mnE/CZ5fe+1Z4AnoehyLbeY260MChBbxvcrIng7qyoLFfoQ9qWFYqqJB/nlqe1VlohxMxfmmP6i8T5ud09IL9XqGlvbEJYePwvCNQGCkd0tl+IB9Jpo3MKl2RW4fw+qHmFFu4qfydRRNo4QsQJvmTl8AiAm+mwfwmz+y3lHUzSbDG0Nyiw+C9DkZvrCFUcXH3MEhXYYiTknFlaT9f3PY4wqRl9CGBgqw9FoyWgxK15acb3O1kAcEhFpiQ9nWJkrqSW2es3xsnTcwrXVzRZ2gLzEchmSI3BACWay5PAqZ2z4cW5cPhZHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FQGBFyAZ2OjJ3feNN1x8tXDdhPdou1KxUMnXwVd0O4=;
 b=BLr4SAPncJA57pZURv942Z2AQQN0Y028ByCFtiD3gnC3YuL3Yc0YfmofCdurx9fu5vOoJVvDAuUZpJGEwD5EMVnaNbsrtcXnpRurpNkWQkCZbsIT8nBwFbCV0YIEwAuIsM+Ri1k5l3DXoRE97mn+H0upyw4ZFVstYYEpzkLNWBJy6Qj9jMHLJgKRVi4Cy2+0zUX25pEZg0uM8SDhMpa4Bj7QdQmwBeinkjtsLLWwHbq25MgEfJfyuBUkiGQyvwOpKFUtnPOugaklFC795FFT4H9rpNWvw5V0+7m3UMavRZZtjT9IRHxAs+pkbfhQsuiG5cPyA5lhA/wjEGDGTaRBXg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:34:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 17:34:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests 0/4] clarify confusions in blktests contributions
Thread-Topic: [PATCH blktests 0/4] clarify confusions in blktests
 contributions
Thread-Index: AQHZwUOwWU2s+eqDc0Owh04tBUwD3K/PcQsA
Date:   Fri, 28 Jul 2023 17:34:40 +0000
Message-ID: <74263a59-8898-2cae-a80c-55b4d45e9033@nvidia.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|LV3PR12MB9403:EE_
x-ms-office365-filtering-correlation-id: 3bb348fb-33ce-4f61-3bd0-08db8f90ec3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZO5QTwb3drVgKb7f/nlNo+KcjlCxX6gCts1zRYvOecwg+/V8EYdOTc0bHkMNg00PbE+CAsDpLR3O4qhT3onn0ecFbain7DDIhZcYw4NJwLvV4v5T2zwQo3s2WKyLSQ84Z0nEDdCvwMF3Tai9XMrPiXy+6PoQ383MXxcWBk4KfwJApFukIccIdLRVUiY2mZNi9BjAzHtSiS0YmUuETpZMV2+2Igffresttjw7h1SMTGWCqHSsIuES2VkQdHkDwzqGtoxEeaHPq99v2kxVRvdHtudqsUONTwIsy+2TFusAkkPTuPu/TUK94ptS4S8rk5nQuaPwjAKVtRqBBV5meeMIuoKLN3IfzwhEr5MKm+hVHk5UVtrQ0oBQ2SS8a4p8RrwFTaZJzh0tCtKsF+/ZdYihahI2nKhJLADBG6K5ncwkGEgDK8O6vJGv5aypFbg1i9VeRdPT1stWYKJOBm0DFiTGT/Tq+oOGhu+qz93w8MZ2CMdWGnhFBdYywq6oIFdDO6JVXNaIkZZlWvMGFUUDU9JG0tMko2ZsMt0D9HlJKkkOthQYAEG1BZdkh9Wq3vpo4529HyPHcOBTMY7pmln0fn8iKwOmusThYLWwVMcXP9wX6rJH8ggk21r4hl4QFSLrJ4ei2ZY6rrIu6c4bZdLeitBdjkGEo7LGQ684WhsAlTUytfUIJp498KFwQkpgke1GtUzb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(38070700005)(2906002)(83380400001)(71200400001)(6486002)(2616005)(36756003)(38100700002)(4744005)(186003)(5660300002)(86362001)(31696002)(31686004)(8676002)(66899021)(41300700001)(107886003)(316002)(6506007)(8936002)(53546011)(26005)(76116006)(66446008)(64756008)(66476007)(4326008)(66556008)(478600001)(6512007)(91956017)(66946007)(110136005)(54906003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzFNcGEvakN3OHEyUU9mQmVxczlxcGxkSXM0TFJSY0JHdWJsU1NlZi9jclNP?=
 =?utf-8?B?UW1LcmJFcUd3MkdvVytMU3RGMWxZUzdlQ29RTnZtTExFUldLcGNiejhNYnZD?=
 =?utf-8?B?QmNRS3VEWDhRUW9EMktjQy9OdXozZkY0NFl5dkhRWm44cy91aWV0cnhROWNW?=
 =?utf-8?B?czlEMlZRNEV5OEVxb0VicWExRHk0NFBwV2pGemJEbXVNaVp1QzM4NHpnVGZv?=
 =?utf-8?B?R0tqdjB1N0JGSVczWkJQSkprS0ttYlQxMGZmaXh1RjBtVkxJYjR1OHAxK3pC?=
 =?utf-8?B?Z3R6MGQ2Qjhya29TQXdYekRZeFZsalZ3Lys3dTIyRHp2TlM5TkZUZFdZRkpD?=
 =?utf-8?B?RUdxNTBpN0M4VEg1WVlnSDVpTllCNzVuYUltRzBrLzN2MVRsS2R6aUk1NlRZ?=
 =?utf-8?B?eFhKS0lvVTBKSjAwRGdnaU9wODhvaVJvWUxvTmF1Q09QTm5UTDByMjJheHpq?=
 =?utf-8?B?YzJuRjZKUmVQNEpsaG13WWhnS2FialE4dkpYRFFNenpWRlA1Wlg1RFRLdU9F?=
 =?utf-8?B?N28wT2I0YVdCUFcyUWgwZ0QwK0VkN3dFSkFpNzZDbGxQcEFwQTRmL3Q2ZnRj?=
 =?utf-8?B?S0JVeTVxRG52MjBuSzVFR2UyL2k5VG42N0ZDK2Ixd2dPVGlBRmVHRzJHOTI3?=
 =?utf-8?B?SGpseTMvVjhFK1J1NmlEakVQVUQxbldYUCtmUERqKzdETU1LVk5UUEVOL2VM?=
 =?utf-8?B?T0ppSFBjZnlVT1VGOE55M1Q4SWg3ZDBMcldsMUEyZjlnUnJ3bWNvSnBMR3ZW?=
 =?utf-8?B?N0hXNE02MEpTazIvWWJERFJYOEp5SzhHbzk0NkttWk50bEdra2lMSXZubTZ6?=
 =?utf-8?B?c3YzckZBaUxwaE5RUmhJYU5pQzhvQk1jMDgxTmRrQjJYcUZJc01GZU9FTnFq?=
 =?utf-8?B?c2ROMlp6UDhwamNTTmVFOWZ2ekJ2K3dDZWxUUkdHS3FXQk5NZFFBUHFkeGMv?=
 =?utf-8?B?R0ZFTkxPVmpzdmdrYnZ5NkplMnZBRHlsbWIzd1JUQmw5UWZ0U3I5UTFwMGpk?=
 =?utf-8?B?VUgyZVFtbmRJK1duaUorVi9ERVBPN3RMSFdhM3UxVlBQZ29zWWt6L3FRZjBq?=
 =?utf-8?B?eGxYVHZWWmpYdjlsVWxReU1HM0l2OWNRYXVQdzFIMi9NekM4ZTBnd1g1MEYr?=
 =?utf-8?B?blFLN1A2R1ZIVEVtQk5RUHg5Q0FmS1NjaVhxaFluTUtwOUM3Z1hFdjZwbzg2?=
 =?utf-8?B?a0IyeWpXa2g0UkZRSWNmcnBaSGJGeHlXVUttOHpTQkllSEt6M0RaYXJJeDlD?=
 =?utf-8?B?Qmw3VitXd2FYdGF5cWhhT3YrWUw0OWZuNjQ1T3p5MmlNVG9DRTRiOHh4UXRP?=
 =?utf-8?B?RmFCTG53ZEJxc2FRdGo0U2hDRXZhWDRjY05lKzdadVBsNVdoVXBKdFNMV1JQ?=
 =?utf-8?B?VWNqMU1tYzljSHRxMTY4V0tBWkJLaFRqYTVKOFFqQ0VKOTZteTZUTlJ4eStv?=
 =?utf-8?B?RW5LQkdRSUIwQVcrUEcxZ2FDckdybWUrOTMxWU00TDFZQ2kvWDBBaXBQeElD?=
 =?utf-8?B?UFFoeklMc3c5SHZNUDJmWGtGY2s2ZEZhdEhlQUZDR1NFWEtMODA4ZnpqZVFB?=
 =?utf-8?B?UU53MnlEbk5rdjZvYjZUYWJpZFdDSU5NU0lNdy9hRWUzejhiY202ZjNXVVpZ?=
 =?utf-8?B?cGJvNWlIL0NOSFVQV1dBQ1B5aG1BbEJ4Szlqb2Z5R0luZnBYNUxNM0t2NDFX?=
 =?utf-8?B?aFkzQ1V2WStiVTdZSTBZUVh2QUxWMkJ0eExWekQ2RnNlRVdjc2NJZ2NQN211?=
 =?utf-8?B?bkZJZFRUMjJJeDBiTk1Eam1YL1pSS0VKbStpU0JETTJuZmRzRzVHckRhZ0hO?=
 =?utf-8?B?b2YwYWlkRW1ndTJqbHpsTFcrQ1gwNW04L1R1TU1sNFJDakoydkRWNDVqWm4v?=
 =?utf-8?B?bmxwbHVkNldVaTRXUWdWamUvK2oyZVZNVmUrL2o1Z0tKN3JVQndldEUyUzRP?=
 =?utf-8?B?Y1B3WmNKQ2pjamxVYzUyYXd4YWlWRkM4dTYxZlY5Z3d3a1hlM1VsalpTQkNZ?=
 =?utf-8?B?Q1h4dXZ2VTdXSlRQOHdZUkN4YUZXbElsZUprZnlYWkhDTWIvUHU2UlFLenk0?=
 =?utf-8?B?OGQ4QXFMemhyak94QUZ2OGVLS08zRXVJSnkwNlRSbkRuZ05JdXdxTTc3bE1K?=
 =?utf-8?Q?zMMyaqxP4S3XzHJu9vLvMt4/9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E3B9A8F009AE846938B44AA1352A365@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb348fb-33ce-4f61-3bd0-08db8f90ec3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 17:34:40.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyppINECZBzej6rpnBmlL5V50yXWhwb6WK6NRutPutay239vMzz5PZquHi/bCjmGCDf0MM3k2WZuXAvqenRY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yOC8yMDIzIDQ6MDcgQU0sIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBJIGhl
YXIgc29tZSBjb25mdXNpb25zIGZyb20gYmxrdGVzdHMgY29udHJpYnV0b3JzLiBUaGlzIHNlcmll
cyB0cnkgdG8gYWRkcmVzcw0KPiB0aGVtIGJhc2VkIG9uIG15IHRob3VnaHRzLiBDb21tZW50cyB3
aWxsIGJlIHdlbGNvbWVkLg0KPiANCj4gU2hpbidpY2hpcm8gS2F3YXNha2kgKDQpOg0KPiAgICBu
ZXc6IGRvbid0IG1hbmRhdGUgZG91YmxlIHNxdWFyZSBicmFja2V0cw0KPiAgICBSRUFETUU6IGRl
c2NyaWJlIHdoYXQgJy4vbmV3JyBzY3JpcHQgZG9jdW1lbnRzDQo+ICAgIENPTlRSSUJVVElORywg
UkVBRE1FOiByZWNvbW1lbmQgcGF0Y2ggcG9zdCBmb3IgY29udHJpYnV0aW9ucw0KPiAgICBSRUFE
TUU6IGNsYXJpZnkgbW90aXZhdGlvbnMgdG8gYWRkIG5ldyB0ZXN0IGNhc2VzDQo+IA0KPiAgIENP
TlRSSUJVVElORy5tZCB8IDE0ICsrKysrKysrLS0tLS0tDQo+ICAgUkVBRE1FLm1kICAgICAgIHwg
MTUgKysrKysrKysrKysrKy0tDQo+ICAgbmV3ICAgICAgICAgICAgIHwgIDQgKystLQ0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KDQpB
cGFydCBmcm9tIG5pdHMgbWVudGlvbmVkLCB0aGlzIHdob2xlIHNlcmllcyBsb29rcyBnb29kIHRv
IG1lLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K
