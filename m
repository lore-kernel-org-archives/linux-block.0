Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D6C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 00:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiKPAyW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 19:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKPAyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 19:54:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025C2FFED
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 16:54:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM1/S97HFMS3TRm9NuykhGWb8tzHb/lFq+GYoojkfB8WWT3z7zupydPcRmU6o4pmM+XgsACMH2g+EMSaAlDgWx1NEjoo5+7N129BXFb/8GhXDpUlXswkJ6LMGon8ZDALdktyD+Z3dL/E1D8l4e22ZYgIyUu/TBLLGG4FojMQjRoONGzrAFmy22eVNWlH7aaobvYU2m8RMlDwR5bStoMQZ6aGEGkHX3IE0Mkxj4k5nTGOJgqWdm0JhSsKpUBj3+3I/7tPSdPsxZFbllKFhpoShbvAPcsshYUtOqk4VMyUXkRaj+VDUdq2YCXObZosFqT0u0XVUGS2P0+h+YX1pkIN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuykjkmOV/ea2rGZSJZJFesKcVuyy2zT0OoI8+JM9tw=;
 b=HieBQWtGIEqgpuMVxd3TButCfNGE1Cr28m0dgUo9hYXuDwxepgM1SJBoaw8V1KyhePmG3El+G5Ij61XkxVDuthuYzfuRwWZcTaFA4rkhQIdFpo1K4x2CF9+l9J/raaiZoy7Rw13DcH02BuqE3a+C3/wAz6UzUvPynb5HGNL/YN7tycgA9GDgH3CENUqCzlPPXnR577oEruEBzcJP/7s1i2wRhIZB4WBEaBj38b5Hxc3P02UYINa/6CsRO1xdMxSQeUrK+rbRpP9TSnq9f0OaqfyDYn5IIz/0mWo/3L719FARwnk5REJSZET2c00X6xq1Sk1faoSuhGmTUfpJGUu4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuykjkmOV/ea2rGZSJZJFesKcVuyy2zT0OoI8+JM9tw=;
 b=oqc3INOsHhcF/VdqSf83r62IbiSYdXgPH3mRe2MbfKIENGkD1BxRCjI/Sog2EAxc+XuhJmo7V994RlhJ1WaWwJKc9P1X7bDsu763RLnd1x+sgwsY3xORYGTGba8/afWx9/rCRT8/9APSfmJBep+Pqj2T919OBN6SZCIyCvsRIEfiQkZvHernQJRNWrKDXvIHoIGYtPHrUgYjCJ56O+91apKAewVbs0JCP1odrZTy/M52UFRBJcGhpL1dKNY1hgUt7pxxZgg7mrwvTup7S9OloyanRY7FZTb9hV4pmY/B08ZNgR7ajKe4OM0ZJqQk+VpHpBlOeUbHaeT/NXcbsC7P1g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 00:54:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 00:54:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Topic: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Index: AQHY+VAokBGuJELIQ0OcoKmIBV0HOa5AuUkA
Date:   Wed, 16 Nov 2022 00:54:18 +0000
Message-ID: <029c9660-3e8c-a9e1-cae4-2dd14b06d36c@nvidia.com>
References: <20221116001234.581003-1-alan.adamson@oracle.com>
In-Reply-To: <20221116001234.581003-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB8131:EE_
x-ms-office365-filtering-correlation-id: b9c077a3-c0f3-493f-7e41-08dac76d17a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgpBGg1x0wsHNRvjOlEJMpuyJQ8ZEi2FqTxUg5eqOHsEp8adA3DFAynJHkKN5g3pilGICHxmyAuf1Y3KrfgIk2tAesxxsGfYU0v6Ad7aM9s/ioPrQ1obnABM3Y2Q/MZADCwDPzmoSrMZI/FzF/rlSXbmTGReu0fLwP8zEwpg8NTyv1sm+Ywego3iZzTU/3vQ08iL16uxuRnJB+w34M6f0QgHORo/OCH1qo8tZGPWcbc5E3dbs3NVxBZerBlJKKkRg0+Ll9IQlOHwFj1ZexdCQtXHJ2KIvzIW95+3Osf7aa2+kqFrVQh+EuF7W1PC9NjRH6z0dYGoeRKK9NeiV4zyQJWVnT7wghgIAmxKHe2ifdw/qcy0J/EY64YGamNmAMhMjvriICq3fgiPt5Y+rwYZ37+3ZIBl9uk+wXzHYupZOVxRBdMlrLLRERGOPkofVyg+3aJ7a/AyFP/7YQQhlmmDuvcP4p6HLtbtJEHYTwKczJ2Pfsb2BYdzJH8ogBh4Z99ZaB42qDJwM3w8hd2NsfevG9QLNd+248V0yEmpRMI0i182DMkwQkT1YuMld5W7MT1+idmPCfTdP3dvxKP3nvlkFzmStByqHCmtB+WHlMJ3QKJ07yMFPhAVXyCW9cYxXo3Mvvq4wNuYEAEbifokjMSI5EYyIpF7W2NTbmSu4taKvF951OBTnRzLmxcx8MeYZX87lF4OHrOlTrEQ5P0dmts8zz7s1TU/6WV47ncf5pf0/ZigfhfLQ8PUpX39JWq8ujAUZVT6Lhld63Wa1imJdO0HvczW3atDrp5dkbiRTWCc561RT9o+KU141d4G4DkBMAs4g36AAijY4BAHtkbkEuNO/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(31696002)(6512007)(6506007)(53546011)(38070700005)(71200400001)(2906002)(122000001)(86362001)(4326008)(91956017)(5660300002)(41300700001)(38100700002)(6486002)(76116006)(478600001)(8676002)(186003)(66476007)(64756008)(66946007)(4744005)(66446008)(66556008)(2616005)(8936002)(83380400001)(54906003)(6916009)(316002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkFLOFM1bVpBR0dZczVZc08ycWo0S3RQSW8veEVlQUliMHBITFl0cEIzTnBB?=
 =?utf-8?B?OWJsV3RodUFLRjFXdlpLOXdPNndxd3ZhNzhNU0wydkx5cXZSM1pDZkhiTnZw?=
 =?utf-8?B?aCt6bHBVd0JmU1ZiSnJjVGJyaXFMTGV5bFdub1hWUTBMSVV2K3Axek92WDZV?=
 =?utf-8?B?aUh2TG91VjNzcFFhSzl4Q0JyWUtZdCtaSExWRm40MWVLUmdlTXZaOFNHZTIr?=
 =?utf-8?B?UGhaaThQZmlXMFJBYkJGNzE1dzIzZHQ0cWdBaGR3bU9HMjEwcmpzRkFZbUNl?=
 =?utf-8?B?TGJsVjJYdURsQW9ZSEFRaFViQm13Um1OZjdiRmpYM2dLa2NRcms4aGhyOEdP?=
 =?utf-8?B?U0lRVE5ERXpnZDE0WE5GKzRjYzkvc2NZUEJjZlRuTHVWWEZWV0hzL2dKSmZa?=
 =?utf-8?B?OUIydStmamdQNDk4clIvZ2tyUExjL1ZxRVRMc3lCSzl6VEdDemdFcHVZWDlL?=
 =?utf-8?B?V0JCaWF1QTQyS21maEErVk40OU1tOVBiSFNkTHZ2N0t1cTJuV0E3RUp3VWI0?=
 =?utf-8?B?MksvTHQ1NkUrNnQyNnA0MFMyQzZWRmNqS3BpOXhlVDFKenc2dEI0NE0xNERm?=
 =?utf-8?B?WnpxeDlCWktZWllWN0h2QUJNOHdiRXc5R1NkTng1NGgwLy9JY1pEQ2xIQ0s1?=
 =?utf-8?B?eWl4MnB0MExZRkprM1lJUXNhRUt5dmloRGd2RTA4TlBpS1NiU0k5bnRXVCtG?=
 =?utf-8?B?ZDdwWTNlakRtekJ2WW90aUNDUTdTaG5ldHRXbHI1OC9INHJlcjFqMXFTZm01?=
 =?utf-8?B?UEwvdERMQmUzem5WdW5raUw2d0Z0NW1oRWNQNy9yN0Z4N3pGa3l1QjNuMW5r?=
 =?utf-8?B?U3BjcThQcy9GKzdWMVgvV2s3ZDM0bVFkbGpaYTRzUVRsTkswU1pra1I1L2ND?=
 =?utf-8?B?WWFhY3BGQ0xkVkV3V1dkQ3JJZjE5aDFPSTROU0pIMTVCWVhYMjBRanZva1N0?=
 =?utf-8?B?MWt0RExxVEVLblRWUHh1S0kwMDQwZDVhMWRxUnZHZk9XRkhkV1JqbTZ4TlFj?=
 =?utf-8?B?U2tnRVhHc0doZkRaRzBnNkJNdk9yTHBIb1R2dStHSzNoeUpodHY4Z3phNTBX?=
 =?utf-8?B?anhkZ3pjT3pLZStuTk9jdS9zNVdzd0M4Rmp0UjF0OFEzV25rZ01OV2hieVRi?=
 =?utf-8?B?UG9nMjgweU9kRkRtcWRONjc0d3VWcUtSTFdHRUZsTjBxTGlCcmlYSU9MdlE4?=
 =?utf-8?B?dnk2T25BK2lnOHpkMEx6cFE4TnZMZXhJQnFQWE1MdlNTd1FHbGhYV0RERDEv?=
 =?utf-8?B?dkxhOUEyYjNJZ3AyZGNOV0xRdUJ6R3pidFhtZFlXcGNaVUkramRZdjJDUDFG?=
 =?utf-8?B?MlllWElzN1FydGw2WkwzMnQxaW1xSmpBQjJGZkk2TDgxbURha0YveDdmZkJq?=
 =?utf-8?B?OUVhNU5JQXUzc2hHSU04a3BrKzZIaEYrRjZZK2phbVpva0g5M0tWNTVnU2wz?=
 =?utf-8?B?emN0cmhKT1lUWjdWOVRuV1ZUMlJXNEpJaGpYNFlTOTgzQjNjZHV0QWEwZTYx?=
 =?utf-8?B?VGZyN2h6V0REejdLVUp3bm1JNVlJeWM0RU1mZys0L2ZPOEhVQXR4RlJnNjdr?=
 =?utf-8?B?ZmVyWm1sYjRtaUtscFcya01BMnRSTnRUYTBqd2h0OTllM1FwUTVLVitGd0Fh?=
 =?utf-8?B?Unh4SXRHOWJLeFNSZ3Jtci9yZ05CUnNaK3o2QTN4VmxtOURLbW1JcjUxNHBV?=
 =?utf-8?B?NWZGb1dacmV6Yzlxc1hTekMxMnduL3ZWK2NjOW9CZTEzYXROMStnNDZ6Qzh1?=
 =?utf-8?B?OHVFWk9yTk45clVlOVlwQnkrRm56K0NuRm9DSkM5ejAzbWdrWDVKTHdQOVNj?=
 =?utf-8?B?ck1FVW5Gc1NHRnB0OENHMFhFRm91dFBrcDB2SmlxS3AwSkoyY2dGdmlaMVQy?=
 =?utf-8?B?R2V3K1EvbnROZ0hvUTB4NlJHanFhS09qMHR3bjRteGQ0U3VGdXZoR1JGY2Rj?=
 =?utf-8?B?dk5HNFUxQzI1aWJpd2pxWFYyZnZKWFVSa1RLVnRiRklUbDdrc1RScEtRRWlD?=
 =?utf-8?B?ais4WXpQTm5mZlNiclFKelJXSTlWQktxWURXRDYzdTlUWHBZbVlabUFNTFBh?=
 =?utf-8?B?TlZBem9ZMmdUUnhaejBjNlpSREJBQzNhblVENWJTcmt4Vm1BclU4YnZpRnkr?=
 =?utf-8?B?aTZyRmpNRUZPSmxNRnEvZ3NJdGlKNTlkQzcxQ0JXdUpHNHNZVUNYQUU4UDZG?=
 =?utf-8?Q?SHP3xM+t71oRs8jRXNIvyKERhof/LFp9LPCyxsBK4Srt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09415BCC09D3DD4CA0A00B8A3B810576@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c077a3-c0f3-493f-7e41-08dac76d17a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 00:54:18.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4WrOojm+YhG7xZZzjiWTAL8fJpCHV2n288cPKtUFLsTVvhtA4YIVfGL3gBb+G7R2QYrdZzNCnGx3VMmpAofmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMTUvMjIgMTY6MTIsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4gQ29tbWl0IGQ3YWM4ZGNh
OTM4YyAoIm52bWU6IHF1aWV0IHVzZXIgcGFzc3Rocm91Z2ggY29tbWFuZCBlcnJvcnMiKQ0KPiBk
aXNhYmxlZCBlcnJvciBsb2dnaW5nIGZvciBwYXNzdGhyb3VnaCBjb21tYW5kcyBzbyB0aGUgYXNz
b2NpYXRlZA0KPiBlcnJvciBvdXRwdXQgaW4gbnZtZS8wMzkub3V0IHNob3VsZCBiZSByZW1vdmVk
Lg0KPiANCj4gV2hlbiBhbiBlcnJvciBsb2dnaW5nIG9wdC1pbiBtZWNoYW5pc20gZm9yIHBhc3N0
aHJvdWdoIGNvbW1hbmRzIGlzDQo+IHByb3ZpZGVkLCB0aGUgZXJyb3Igb3V0cHV0IGNhbiBiZSBh
ZGRlZCBiYWNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1z
b25Ab3JhY2xlLmNvbT4NCj4gLS0tDQoNClNoaW5pY2hpcm8sIEkgdGhpbmsgdGhpcyBzaG91bGQg
Zml4IHRoZSBpc3N1ZS4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQo=
