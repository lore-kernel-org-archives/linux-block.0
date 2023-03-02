Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6E4C6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 18:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCBS34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCBS3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 13:29:54 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1C17CD3
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 10:29:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDTxtJDu+wMkNVy81sK0K/L378Siv+96b285k7ywrEDuNDU84IILGAegWaET2xeh3JPuFMENkCRoZgkSmGMksc26ZpCsk5EBbO0CdOVByVfEP6I+ahVJmmGTvrU6cy+gBmmY5t+P3Spurde8/4jenjl6LAYXvXaMcjZ4hIblfsYH5emsut0O7uhOje/Et8fLQztpeLG+MA9ywmkLeOrNAIdJEspYg/wZ/Bmh2XD8YPo2Bb8QnzeanbIIgGSMAlez1dKsny1EgfJYIUM8Cyh2DXplIMgqO0Z5uTCY0CILRXt9+AlzrclURdqCTN9J/UxflwU1tUVOO+PvJ3C5P7Q3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V4SFRCpIwGIebnN53Ax3umwHUN1vjX2UaUKS8TytlA=;
 b=CIXEsCznpihnBBzo0jLzOQU7/CVd5TDVzG4Xq34EZIM5QEufEIzaWxsy5Ho8uWHI4gRYNXsqdrJC5yk5rRyNsXKvhEgCQPRwU/iZppMi9pKc/9h9liZD33wRDJqAcu1BbKXT4Fjpflw87FSFlG+dYOLGmTe+z0mEKXimtLZdbcmuVrKjwdAUqBWeB++yCZ1Mc6NtVIPrELTteUeD4JKu1v9AerXhBsgC9FeAUW0nQ1babbCUtKz7GSlOKN+AXYuVXHEGJ9kAQ9UAlHNXo9tOTXU86v4kyrIQ/isThIcrnEtrQpa1gqvTeKNyZidnzRDTMKcHlwABn6rVwna/c1yOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V4SFRCpIwGIebnN53Ax3umwHUN1vjX2UaUKS8TytlA=;
 b=l01ToNtcipZ4MdVCGJo0GbhbXJWlBZeq5vKLa40bIszpI7L7EpFSo7wqgCpcTpWdLmBsUb0QDqfyJZPIAeBsWbRYD5gxOvWbO1lgntqBFeJ/+3f5fhAXKzHp9aKK/mJVV8LG0ELMxcJkujXprvpA90wdh+k1k+UI2+zzUN+cjGxewlzUtfYQAUgiE6ndhIMBzqLK3IcblXJfTYGVGMXkvhS0GLLW+F7s5U+FrjGLk+Kw3UZYk05+i1AONZOW6IaRZGautyfaww+YJKVLjU0S3501LLCTfofC+/H54GIJU/cpSCV3PltqUlNxxX5geDd1s72gsFSl8fKFBKGxIlDe/Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 18:29:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 18:29:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>
Subject: Re: [PATCH -next 2/2] nbd: use the structured req attr check
Thread-Topic: [PATCH -next 2/2] nbd: use the structured req attr check
Thread-Index: AQHZR/WSz0GCfLQoikuoZhfPo+9SuK7n2giA
Date:   Thu, 2 Mar 2023 18:29:51 +0000
Message-ID: <449b9a62-d76b-8d1c-6cbc-14fbbb9fcd69@nvidia.com>
References: <20230224021301.1630703-1-kuba@kernel.org>
 <20230224021301.1630703-2-kuba@kernel.org>
In-Reply-To: <20230224021301.1630703-2-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB8605:EE_
x-ms-office365-filtering-correlation-id: bee12aeb-5eb1-4c7b-db1e-08db1b4c1ca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfVNO9b9yQMmhgfxDf6Pva0TrZfWIfirofR4m8VtmbyCn+awLmE2AU2TDv5gOzvf+ptUhpeWFXD/2qxPKoh5AT6QaU6GU7W19TWZYuvdg0NSN6sfUFh/hNyW1s8WSJPLKSKAp6I7xH42ykuoa25sU/90cQduNsQbi+z07gfJ7L/QdQRzd8g3csOoSKh5fEMA+S4XjmP92Gp5hpq750A3aMRguEba1Woeoz1U1nVMH/TInz8sSvMdCFPhr8PqQ9Kty6Y8vwJmEVOcyBM1fgDgT0MFsaLgHsI7R4qm0a7ipCn1w10xU/8pV5M6o2ZVY0pVufE+wSp6k69wYfmFcKuDeXPHrq+bZdsLy26pPgJwwnaOI5G0fTO6VkYVMXNt5t1kXEkqLPSiQjRVmU0bzAkNKmghbTaKBj/iqjUA5SuU7sLnOvH/bqdqffkw37YL3TCisCUrORpwJX7JehYZ8Fqp0ZUrbWcO2mCiq+1AZpSEIEBg1ThBnBuvPaCLgI7uNOZxAVWWYxNfRkqzUNiIAz0BlwC0X6X0T1/Y2nkorpKk0bH/jM2vOy6JeDFsZr6cR3wu+FaV0ZEWGcvXiKYvvs27OEBzxkGReEAmOphGO3PYaP+Q/lP5hzdCWXNRStzvkyFU+g2+CeUf9YMEfcjCylhN2pWsjnf895SsKGVmAkQa8IVGQv9GApkFMuGdOZ4VyZcT8+B6TnHCGY9XdpiRXoUvxEdvwnUv+tAkqDZ1Y9f33l8y4uSPvm8M0t3YuQUkJVZU5MzNhDSNK9P94y7f/SMgBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(31686004)(71200400001)(36756003)(38100700002)(122000001)(5660300002)(8936002)(478600001)(86362001)(66946007)(31696002)(38070700005)(2616005)(26005)(6486002)(6512007)(6506007)(53546011)(66446008)(76116006)(4744005)(66476007)(186003)(64756008)(66556008)(2906002)(8676002)(91956017)(41300700001)(4326008)(316002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0EvQjlsU2xKM3BCUFRLTnhidlgwSEJDWWJYV3dBcE16bzAvTE1lV0N2OFQw?=
 =?utf-8?B?MmR1STRoVVMxUW5saDhJZUkweE5pcUNGYTh1OVl3eHcrZmpTZ3pFcTFhUm9q?=
 =?utf-8?B?QXAyNFE3MHJNbmt4Qk9DUG5sN0g0cVlFU0IrY0RNS3hFQ3l0aUVJY0ZiZFVQ?=
 =?utf-8?B?SHRYcW9BVU5TVVpqbWt5b3ZuampyQ0hmUjFGNHd2LzVmNUhya2l3Qm9CNFdT?=
 =?utf-8?B?eVBGQWxOWTlEUkdMOUt4aHNkSk1LdnZ6VEtGVjdjd0QwVVB1T2FwR2ZjcXE3?=
 =?utf-8?B?VmRHcTI4aUNBdDVUNHhLdnRDTVpTdkhWUVBCUnk4YXhUTUNDMTZGUU9MSXlw?=
 =?utf-8?B?OWFLeStNclo5dzQvSjNqc1plOTBRcENhK3lMa2k4WlIxVlE1WU92c3g3dTNH?=
 =?utf-8?B?TWlkcEk5bWI0UHErZE82WWlMRkZ2UW9HU2hXenY4SFR0L0g3UEhyQTBURW51?=
 =?utf-8?B?cWpudG9vb0V4SGRBQWUwelVuckdPeTFZYVMzbndjMWxhdWNRNFREYU5hTE5j?=
 =?utf-8?B?TTBXUC9pV3pxdVBnS3N3V2xLc1NKeGVXc0QvbzlJbW15ZENURjE2YTh3SHJj?=
 =?utf-8?B?eVVaL1Z2Mkk0RjFEU0JWTXU5c2hib0w5eUZwdE5NQWVBbFlJZmdVdUp1TmRl?=
 =?utf-8?B?bXptNzh3NVpPK0N6dk41NVlnVnFXY1RCbGNWVHUxWTdwRWZScTh6aU52T2NP?=
 =?utf-8?B?elJiZEliZ004L01zTjR0eEVzaUxUYUxScWljYUNZSnI4bWJPQk1kUlQvbmxy?=
 =?utf-8?B?bUNWQ3dCbm9QUFduSXhoV2JGWldJbmRsaXhRN3NOczhkWlRtUGZNd2JNYlBy?=
 =?utf-8?B?eGdaRnExZ25hTlZCTm8zQmNXWUV5bWZHK3ZMZm5xaWllYjE5OEt3bDViclBw?=
 =?utf-8?B?VGJCS1FBT2ZObnM3RkJRclJwZ21selRRMFpDRUFsWWZWM3R5d09JOC93cmgw?=
 =?utf-8?B?ZFVzSnVRUDhtM2t5OW1MelB1RVR2S0ladUlwNW9HcTFTYkZidVNPdlBSN2NJ?=
 =?utf-8?B?eDZFcGdhcisvdzNEQ095MXhtYTYvNkJOZlBMSUQ2c0RmdzBiK1ZmM29hNlZn?=
 =?utf-8?B?a3pkSWs2Ui9oYXlhSndNV1YzeFU3cFZ5KzgxbFU4b0Nxa3FYUWJJQnlhUEcw?=
 =?utf-8?B?cUxwR21HSkdWanZPQ200ZE45cllKNHl2bjV6Y1BIbHNlNTZ2ZjlSWjd3bm5R?=
 =?utf-8?B?N3Nwc3pyZnA3UWV2Slk1Vk9lRTE5Y3BucXVNZWg1dnJYbWV5Qk5DMzdXYVlT?=
 =?utf-8?B?dmFPaEU2K2FueUVWcU5uY252Q2dGaWs1a2REN1pVbllkdG9JNTl0Qmx0Q0ND?=
 =?utf-8?B?YVl2dWFTYnFvaHhJeU1Ba3dGRHVjMDVTWVJIS2RPeHdVdmhhQmt2a0dERnc5?=
 =?utf-8?B?elBleDU4UjdTbkxQbGNhT0dWZ0k1MElQbUVKWmpOYS9idlVxUUhJcTJBUVBV?=
 =?utf-8?B?NWdEelNEdHVTc0JnWWhacXdDbWdrVHBRMVIyWmc4SGtOcytybWo1d1NqUDA3?=
 =?utf-8?B?eUI3U3AyeUxTYWoxT3BFMkEyWkMzTnFwUXN0Z3hHckEwZGRqazZIQzMrVWpL?=
 =?utf-8?B?NEN2L3hGaWh6c3hiVldYbVA3ZWl6ZjYzRHQvSVZhZWtGVEM3SklpOGl2M1Y0?=
 =?utf-8?B?Z1JnSkRNRk9MVVJmOHNFZGgyTWxTUnd6dWdTUVRxVDl2cHlvd2xERk1Rbk9n?=
 =?utf-8?B?MWVCV1p0bnNCamN3TUppWEdESWxUQjNPWlZ2TngrUWJ1TG1JY0QvdUxWdHNs?=
 =?utf-8?B?Z2NVcjE2ejNjWGpTMjRQaGR4bWZ5N1dDQVp1amFjUDlFOExuYnR1Yk13ODBE?=
 =?utf-8?B?aUJETG5SeXd1TUFDc0UrUC9aL2dCYkJDdGpTOU9teUVzazl3QlJtcC8zRWNr?=
 =?utf-8?B?ZlBCWVl0a0E4LzlMN0RQcHpyRkkvWmlwK2pUakk5UVFSWWhTRjMyeHhBYW5x?=
 =?utf-8?B?M3JldHFDZGU3SUV2UkM2cXJ3amY3YXdsWkVpblJDc0d1QXNqaStiNXI1RWFr?=
 =?utf-8?B?a1Z3M0d5UlRHVnRrbEVjb0lnQitmNVQ4S3ZTK3RINitFaGVlVlkvdU5nSTlx?=
 =?utf-8?B?RjkwOVR6c1V3a0g1clZVeHNQR083S3dZVVNvRFk3SDBzbXRnUFc5bHUrcFRX?=
 =?utf-8?Q?AxdC2RCrtUH1Z6l4vt8j4oCFA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE9FF31DB55E9F47A0DA88BE034396EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee12aeb-5eb1-4c7b-db1e-08db1b4c1ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:29:51.4659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzJYaxesfTT+SxmgPausMPUbJD9IaupWAlml8el4rG47+gvpgPlT6SfY++jZ8oqE3GMpBuQu8b+AAhZbgYcQyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yMy8yMyAxODoxMywgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IFVzZSB0aGUgbWFjcm8g
Zm9yIGNoZWNraW5nIHByZXNlbmNlIG9mIHJlcXVpcmVkIGF0dHJpYnV0ZXMuDQo+IEl0IGhhcyB0
aGUgYWR2YW50YWdlIG9mIHJlcG9ydGluZyB0byB0aGUgdXNlciB3aGljaCBhdHRyDQo+IHdhcyBt
aXNzaW5nIGluIGEgbWFjaGluZS1yZWFkYWJsZSBmb3JtYXQgKGV4dGFjaykuDQo+IA0KPiBSZXZp
ZXdlZC1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0NCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==
