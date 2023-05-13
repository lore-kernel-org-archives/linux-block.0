Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF6CC77B75
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 01:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbjEMBGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbjEMBGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 21:06:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA145D2D2
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 18:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDy91SubWRotZtcyZXrXAk3lpB9JAZyqGWs8HL6CiKJnGv6odONg4Q1GXbBwJ9KaYZKm+fwrxrnoOwp/R3QTy52c3Dw/KKPM7GCBezgXncIfE924HBkj9kBMXB5d/LaRlS1vREggL/xAiX/z7VyeqeToSbpd4KNsyHxyKeieQcXviASpIIYk6zojQuKnfKEL0vpDBPM3qqLRzCXyhU4SSkItIQNe01arvRx3cDP7XIBfZw4OX3bjaO+b8ca56PY5VnEdruFJPRRf0WwbO31IqDxU4jYLE8F4hLOpR7cjNXOLHdKBu/itL8DQ0kfEgnP8h2elCKiIAabdHu2TiAwwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCt84HROGIvGufhMaVTn7IUTmyZHbbZLE3MctV2Dls8=;
 b=WMcdR0jPN97EKSqsWdsvXh2QNGN+ioJ36KUv1czjyGlHotQKDe7A6M5Hw0C+dgkwaXYHTHJIjBcKDzfDotZYVVQ15sayTOE9Is2m/Dtr1WGBsS7yatN1o2jmVeeY41vJYLw5suBe0vBHCYF3Hv39yMLVnUtBU2nqWN93FPNR6Zg9tyarzl8JpyHofD7eBQEwIU4yI41D8SN/xOzzInq67bLPiuHRWjSUQYCmGa1+/VNQ8QUIF8EEL9Np31kh44+mBhbZLi0MnU36Ands2/PQ4t3SoMD1I4sIoSX9PFwMDoyd634KSD6y8Bi/s4u+5dO9EhOyAMnsm9SPSPPtnD6pWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCt84HROGIvGufhMaVTn7IUTmyZHbbZLE3MctV2Dls8=;
 b=hTlt26pcoipeVA+r1Xw5YcY39rl8BkRNPR11mQ81/o5OBd0HJP72vbqQs/A8bagNpqZyfsoOAOMdypS71fdYTKu/9ni5lzvD/4d3bG+awGo5Lq7vxGXE/J8th9kJVBBuu+E8uKqxGxyicyW4+INuMw98Bg0XQq/7JR0SqdSu+8XFKsxfAqQCWzn/H1Ofw1QI2Cc4BojQVoMNFwTkM2zjp1p/enG/0Ilq05HkEpCZ4xoGxS3aET5GF7VpPPv9iZK88n2+nbWw7mXtAecppSEymuGfQw7w17nOgLCkgvWGsJEVMhvstA5mqWFAs05HH0v5ikYyFaO3wd7BW93U8n4V/A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 01:06:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Sat, 13 May 2023
 01:06:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZhKwGybbeYlqu5kWZNgFLfXlVx69Ws3cAgAAA44CAALB7AA==
Date:   Sat, 13 May 2023 01:06:04 +0000
Message-ID: <b55b03ca-7967-faac-20c9-5c1ca6dc171b@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com> <ZF5NssjIVNUU9oIA@infradead.org>
 <8a661736-2c79-9330-1371-b6f539a9a695@kernel.dk>
In-Reply-To: <8a661736-2c79-9330-1371-b6f539a9a695@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7433:EE_
x-ms-office365-filtering-correlation-id: eba4b8ee-7538-44e4-65f6-08db534e39d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RWB4mKtgNHVsE2tAylXP4BRIRR4iQc4F4uAzTvamYIlX8yx4QahVfL4P8h31Q9I/jNRkaM27Di8n4Hqdzb534el38qUhiXDI4w9QAQ5TDT14BjJDKtOrFFpk12PBoXQQQJxFUICQvwRxr15siPT8b9/Z7oVLz+x9btIvkoFwnokAXzrAyrsyXbJyK8Gpue1fX8nSRiQNy/JIYT1mXzDcHbgiI6ZuTKOZW2Fhk/lzb1yhHlSctcANYyZNprPgmYDQOzPJGiocLTaDtj1BDPzJS6yRwEUkjQ4vg0Wc6FJgyTi3jfgdBRXoIw3l7sVWo+LpU2hq8y1GXgcFgDfkCBUbvWyiaNNrta9yQGlUh9tco2xWCjUU9UbQWL2SBJhDGR+WXv+XZN6TQmxMdj+wT7UdD6+f5/TUpDGz9qIaTKhOnvmkq8NJfB7dRjEmx7pRNFctmDjVlo9mwNToAsQVG9vxHkMhsRrCDpoaRbiFphTgdub3CArgHXTMwRPh3jfzYDqBYk/ckRo/qILFHyfkalrbmgmwOjInuU1FZh1Crx3kZJHSk3iEl1B5jAaZrC1+e9Gu15Q2zmFB8g986R8QZa/9XQFTlzxDAb+3+kIRVbD5mMJnrbGz/xVrTZ3NoZOAzRibFhG7qSyoLedGABcZuukoNjf1dPfvBhg/qa8rwGLsgZcV1c4kc+WdmnGk6pV87oo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(122000001)(38100700002)(36756003)(38070700005)(31696002)(86362001)(5660300002)(6486002)(316002)(8936002)(8676002)(2616005)(6506007)(6512007)(53546011)(2906002)(66476007)(91956017)(66946007)(66556008)(66446008)(64756008)(76116006)(478600001)(110136005)(54906003)(41300700001)(31686004)(4326008)(71200400001)(4744005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnhxQ3hvWDFodzJIZzlpZ1U4bzczcFczT1pWL01GWk5GYkRtc0tNWHZBMFZO?=
 =?utf-8?B?ZG5BUzcwajhybWtUVk1TaldNYzRHWE10QzJrdUltSEpoZmppL3p2TnBtUWh5?=
 =?utf-8?B?UHNXZ0p6TjVza1N3N1NGb25LQkZObmp1cEpzbHNCYlRmK2VFUndIRjQrVXVU?=
 =?utf-8?B?V3ZXb0NOazNKcUNPMlcxYmVmUWQvbWc5dnNtY3I3dmcyNHB6bmZQaE9VUjFS?=
 =?utf-8?B?VEZNbmlkbG9UaFhzNzUwN3hjVld6TXR4c3d6MFRKSWJUU2d4SWNidXIrWjF3?=
 =?utf-8?B?YjliNlZBTVArWDJrSXpFRVY1V0tud2dIR3FmOHVnN3VyR0VJYyt4SERDK3g5?=
 =?utf-8?B?cFlTaTZYQVpRbmUyY3g3d2lCSkZxeHB5S05xUEJmdTRoT1orSXVQOUplbWhl?=
 =?utf-8?B?dnp3a2V2VXRlNm1maVJNai9adndIWXJEdko3WVEyMEhOdVU3ZFZVRWNUbTJG?=
 =?utf-8?B?dkNjMnVKQTBOZWNFdDA2WUNZM3hkMTdGeGkyUm4zb3FJMnlJMHozRENPVjRo?=
 =?utf-8?B?djdFR25OSzVqREoyNDJlb1NWNlh3Lzl6S2xhRUxPUERvdDZHY0cxS0k1NXFE?=
 =?utf-8?B?ODduQ21Ya2Q0cmRUajIydUxWUzhZbGpHYzBFTjRVOUtmSnB4Ny9qZDRDU29B?=
 =?utf-8?B?bU01TWtsMUxZYi9QdUN4K0E2M3FQcDYyZTFPbUZXYWtVZlQwZTZJcDhFdm9X?=
 =?utf-8?B?d0gxSDNuQ2NhSys3cCs4WGZqcTMyaExzZm56dXM3WnBMeURQTzlKdFd2YS94?=
 =?utf-8?B?dlBkenlnU0tCUEJ3UlRoUHdJa2hEeDdVWFoyaWFkWTUxaDcwR1lFWTZ3OFhR?=
 =?utf-8?B?Q05zcUFqTFhpZnRGUmF0aFBsejhneVJtc2ZSTGh1eDZFTW1OSXF0M0o1ODhi?=
 =?utf-8?B?eURKenJnNzlzT2t2dGo0TzM3cERqSjVCOEhnTklTYk92MTlJb1c1K0NVWE44?=
 =?utf-8?B?U0NtUjlBRVpsckFUQ01ieHdGOGtWc21iVkpyc1pSckloYUozTDloOWFNVVpu?=
 =?utf-8?B?aVJwK1FSK0xneXZHNzd6Y1NyVU1rdEtEeFE5eTRJVVBqeEM3R09wTnE4aWVp?=
 =?utf-8?B?Nlo5V1cxT2RNRGlMaVE0eW9nWW9vVFRkbU5uMEVNMkZ2UlV3THorOVJKQWxa?=
 =?utf-8?B?UGJ4cFJHZm1TN0ZJQy9WNG1aaHhVcmFiUFl2MHBvcHowQ3EwQVJwWk1sbG5M?=
 =?utf-8?B?RFNIMG04K2FHczlDZVNIRWhkQlBJWG0zcUc3bis4K0lQb3djb21FeVQrSWQ3?=
 =?utf-8?B?T09VUkxtM0lWVis1R3NSSmlrQnhRbUkzdXlRcWNqdy9FM1hwT2RwTkZPNW1v?=
 =?utf-8?B?UTRDdkFiS2VYWk1EbGY1SDVRQ21uSmJ0WkhtRzVwWVNWV01zVjZnWWJDa0ti?=
 =?utf-8?B?M2UvaGFRMEZsY1ZpQW0zb1h1RlZWYzA5QW9hOU9RRHhpeHd5ME95bXJHakVs?=
 =?utf-8?B?UmFtUDZNWGtQMGN2Q21Gb3JlZlJ0K3BsRUluT2dSek54QUlJSzRoU3hwMkdl?=
 =?utf-8?B?eDVjVVdHWDFKUXRkcFQvNkhUOUI0a2N5ZjJ3V0J1S1Q0NjBWeVMxR3ZtUjRO?=
 =?utf-8?B?UTlNQUcwTEovVldVVGNhZnNIV2FFb0h3MEdVNVpRaEZtaGZtWHRZbXhYSy9j?=
 =?utf-8?B?dmdHUDNJMzU2bVNjS3pKMHFEZEtJd0RtNGJ6U1JzaXhjcHNDSDkzUzRFalU3?=
 =?utf-8?B?V2RIcHhheVRURmpBRkNkKzBMZGRvRzdCVEFFS3dTNjdYYW82UUdDRTNuMXlR?=
 =?utf-8?B?K2V4Zk1ITTdDbWtKaXlvT09aTnBNT2ozMVlRUUJQeXc1LzROa0hVNy9SclEy?=
 =?utf-8?B?MWc0UGZoczIvaGs5QlBtcFprSVpJSGFwQ3h5eE5JRzdBeXNxMVhrdjdSVkht?=
 =?utf-8?B?T1Y1eWx5WU5ud05MeFVlK0ZnRE15dmpkWGJjQXpZb2hpaGhBNGhZQ0hHNktE?=
 =?utf-8?B?NmQvL0g3UlUrcC9ONnZSNDNVUUIvaDB6ZytaRDVIQ1pwalhhM1hsckI2VThm?=
 =?utf-8?B?K2lBeXhVQ2FvZ0k3amhEYmViMVVFbGk3RG5pdWpRbllycnl1VDlhMnhDSXZx?=
 =?utf-8?B?NUlKcjZZMnVGVXMxUktrdUdDTkl1eG5mVlVEQ3M0Y0ptS1hGWGNrN0ZoQWRO?=
 =?utf-8?B?YjZab2o5UEZsbTFJanFZQjdEQnRERFh4b0lROGV3ZFhxSElWbnNJemFTTmcr?=
 =?utf-8?Q?e1kkrdAI6AigA11HudFkws4MG+ub8dlWbQm8TNB+GN1Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C5A0E5B46E32F4B8ACEB9593F5AD1FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba4b8ee-7538-44e4-65f6-08db534e39d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 01:06:04.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nN2jK+Py3goYPVpNKGn7HMJdFhEuvwA9/kZXSL9P1bLyUeiFidKy+Y1Onc4TOFUTdUCUm5grFdb7vff4XCMprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMi8yMyAwNzozNCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gNS8xMi8yMyA4OjMx4oCv
QU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gT24gRnJpLCBNYXkgMTIsIDIwMjMgYXQg
MDE6Mjk6NTZBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+IEFsbG93IHVz
ZXIgdG8gc2V0IHRoZSBRVUVVRV9GTEFHX05PV0FJVCBvcHRpb25hbGx5IHVzaW5nIG1vZHVsZQ0K
Pj4+IHBhcmFtZXRlciB0byByZXRhaW4gdGhlIGRlZmF1bHQgYmVoYXZpb3VyLiBBbHNvLCB1cGRh
dGUgcmVzcGVjdGl2ZQ0KPj4+IGFsbG9jYXRpb24gZmxhZ3MgaW4gdGhlIHdyaXRlIHBhdGguIEZv
bGxvd2luZyBhcmUgdGhlIHBlcmZvcm1hbmNlDQo+Pj4gbnVtYmVycyB3aXRoIGlvX3VyaW5nIGZp
byBlbmdpbmUgZm9yIHJhbmRvbSByZWFkLCBub3RlIHRoYXQgZGV2aWNlIGhhcw0KPj4+IGJlZW4g
cG9wdWxhdGVkIGZ1bGx5IHdpdGggcmFuZHdyaXRlIHdvcmtsb2FkIGJlZm9yZSB0YWtpbmcgdGhl
c2UNCj4+PiBudW1iZXJzIDotDQo+PiBXaHkgd291bGQgeW91IGFkZCBhIG1vZHVsZSBvcHRpb24s
IGV4Y2VwdCB0byBtYWtlIGV2ZXJ5b25lcyBsaWZlIGhlbGw/DQo+IFllYWggdGhhdCBtYWtlcyBu
byBzZW5zZS4gRWl0aGVyIHRoZSBkcml2ZXIgaXMgbm93YWl0IGNvbXBhdGlibGUgYW5kDQo+IGl0
IHNob3VsZCBqdXN0IHNldCB0aGUgZmxhZywgb3IgaXQncyBub3QuDQo+DQoNCnNlbmQgdjIgd2l0
aG91dCBtb2RwYXJhbS4NCg0KLWNrDQoNCg0K
