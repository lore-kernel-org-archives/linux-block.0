Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDFFC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 16:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CDA6115B
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 16:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhIIQSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:18:36 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:52961
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236606AbhIIQSf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 12:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA4a+6gDrmNptFzugaw5HIt76fvo+5XyvDPKpTiDXXadrcyBoSC+oCYPkDi6KlMaEPSFz1MFanSFMhc4rBFA5QsRdcTM7dnLUyZghumnXDRqmPyGlhTNibTyKYJRLR3zpa4jwCxQMts/nZiZmY5ZTaSPoJcR/VD0Mi0z8OrYZopnTGwVJ4UyR1Ytz2irG2FXLACb6QctIhxhCIdCb/NoKMEZNDAaNrKdpwhG/Ypz1IFtZZg75FnuKk/VsA4522RdXRKZcvDjTfHHmx/WWv9/S824jMmAjWf3cWOJSzvAHElZHLTve7mGcl+8c2KWjm7dv4krehK/e9Sc+fFg7gNHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bJCGnGVEB08oHEMYbWy7s2m/qhD7U220rHC8bv0G3sQ=;
 b=W8R2XIkDmBD12NTXFpesko+H/XzKmoNfWbESRxs/He+HHU1Ss54WOz5b63ZNFAfwjrnV6MFuLspNmGI0LnP569xKlPc/4W2ca3HwKHVQJQ0c4d7XeaYnnglv0my4DzZ/DKmN3wsCbqihluPFfEP5168LbygOpuC24ow+X2A3EjF79CQKBJM6Rbs8GawCfjzOBk9aHTbnUcWpa09LV73WP0Lp06HWWjhqwljBUFnKDej9uPQEGApUmtB2TfE0rTzmVM5m/pjUCTOmwphEaaGVWd9WWAIG3FyHicvwWDN8Y/9ou7+P+jvdMMos5FoO5EKUAz25t1TRHzoyXcHtvrxjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJCGnGVEB08oHEMYbWy7s2m/qhD7U220rHC8bv0G3sQ=;
 b=Y3f+D/Eeb70E8KNPjrP8mA+E2qcupVmxHKlYPD76KPiYQdZxtN8DZG+iIQ48g5lmRvAOQ0S/AnoblThEg5vtu8Pg58PPpjFK4UoiUpfALX51TKl38fLaSrtFJlJedlB2CqIVb01BiznBZ6WUsLBd9eSSToH5Crj9WnpfkdJLgDASNIfm7DWI7HIl/sohrxRH9ywADML1OxJ02UmSk0/XB1oIR1GOFD+cqdGLULwFIhWrIELYsgtvM6Cf0cmgQ+YZ7EeMIBiIbry5cJViLnywMku8wQZM/e+V3RqDp/NVQc5olwrbf/HAfZd7vANfcEiIfEETfI2aA4zUDwW82F6myw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0221.namprd12.prod.outlook.com (2603:10b6:301:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 16:17:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:17:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] n64cart: fix return value check in n64cart_probe()
Thread-Topic: [PATCH] n64cart: fix return value check in n64cart_probe()
Thread-Index: AQHXpVkwZNpNFSpMREyq7qwIWmGsbaub4aYA
Date:   Thu, 9 Sep 2021 16:17:24 +0000
Message-ID: <3cf4c5fd-d1c5-7f80-6197-c82c9cda6240@nvidia.com>
References: <20210909090608.2989716-1-yangyingliang@huawei.com>
In-Reply-To: <20210909090608.2989716-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90f0f726-675e-4405-c620-08d973ad4f4c
x-ms-traffictypediagnostic: MWHPR1201MB0221:
x-microsoft-antispam-prvs: <MWHPR1201MB022128F4BA56F4A2941F7797A3D59@MWHPR1201MB0221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzRC/+CukluO/sBqpQcL9DM5wVqjOqxQj35lOWUnQdUa+fbNEZopiRrSbsJ2Ho4Dpk5J6NnvSANb58bOhx8IK2baJob6E5WJM+BMOMYWvLHZXLUwulwB9EI4pJB01Mkdag0B5KPOGqNTsj8gJV8+GpTg2M9nd/+1jZwO3m4vibV9LlFQ2hrlMkwH476z8a9CGSj/hmOycMm5BSByecZaHbvDGGsbD61cr4fbYoGdiVIpg6K+BBKzW/t0FqzqR54CFxvVf1XBbzmjD8LqMYNwxp+sMjZni4bUh16vB2gW3n816KBkosxj+CzkETPCuIm0WUk8wQu0u5KM+NezUG0by7LNNsfTm2+X31Gi97qnL0VKBsPB+XmPiBcjF3/i3hcUpfpjzdfMpJkMIb7yW/EwOYRVCt+FsWjJ/FI5C+KXx5io1xYZjbbgx2Z8wWjBTpvEvf6SxAbCkHj/G13/yCfnKfRH53+sOqUnslRn8s6utLZuCcAHiNMEG1M+9+5cd80cBcNHX/WuE8m7yVKdDd1Etov9AT5X3yF5EanEs9kGRF3fA7PQokQRWfPolcq66UlzYReBAzIpQChhBAFt6n3w6GGLd1KN6oaldM/l5kLij+hLHarLs0xyfjMdpkHDJURlyKhsWgLYhSpt9X/yUaibuexMGDUkx7S1Y1aGXf06Ur3tHzmj7XB729wF9X98t5lEfVUvCr2zXgqYNFgwqtuYnPLE0knhkcuHLn1YQyAC+MBBY66HSZgGxYvxsgpDCHL6rBRpgm4C0a8u+Ln09n8nxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8936002)(83380400001)(6506007)(110136005)(122000001)(76116006)(64756008)(66946007)(91956017)(53546011)(6512007)(86362001)(5660300002)(478600001)(8676002)(66556008)(36756003)(71200400001)(2906002)(4744005)(6486002)(186003)(66446008)(38070700005)(31686004)(4326008)(38100700002)(316002)(31696002)(66476007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVoydDczd0lYR203ekluaGlMVEJPV0twWEx6ZC9SYzUyN1hvZm03NHBPSFJF?=
 =?utf-8?B?YTdPcy9Ka3hhK0MyQUFwd0k2V1dnVUs4NTFHLy8vbzFZSXgxVnp4aDNkcUJ2?=
 =?utf-8?B?U2hQQnVKY0NpRmY5bFZScy9meUdGZTJIQlRKM24zdDh5T1J4Ym5HRHEvb0hX?=
 =?utf-8?B?SlllbDRCY25hTklUbGlPTUFremZMVmRidDJ3OEJZZlBadjBFVHA5SEJlVU1j?=
 =?utf-8?B?TmEweTQzcTlxUG5MOG1JZ2o5MExZN3VTbUp6djZrK1V0SjBUOHQzWEJBZzRl?=
 =?utf-8?B?emdhMENFQ2FBVmNBN2loNENGWUhrR0s1NEtnRzk0SUZBL09hQmpFWXpFYXRN?=
 =?utf-8?B?T2J0eGFTV0JGTDNNalhUYVBVbWtqSmdaeGQvMEd3ZVRoSnlxS2x6aDhQL2xI?=
 =?utf-8?B?ZjVFU1AxQ0djeG9DSG5vUVlJajdOc2lNa3BLSHVQcUNVQktYaWY2TWgzZnln?=
 =?utf-8?B?bWl2NlplaFR5OEg0dER0NTdmZS9ZWkJueWVHcFhXZ09CekRVVlphUHZSRUhP?=
 =?utf-8?B?RUNXMFZ6dGxvYmprd3JrMWpWcWM5ZlR6bDljVHRCZDdBY1Nta1EvZTE3bXRH?=
 =?utf-8?B?Nkc3T01wQnJSMnhvbjk5RDFpMkpWRGNiNU82cnhCclBHZU10TG9oTzdDa3dj?=
 =?utf-8?B?VEVwVkNzNXpDcFJ5ZVFDQkErRDJNclgrd2lEZjF2Zy85Q2pKNVRWSFBBcFI1?=
 =?utf-8?B?WEovSnYxb3BPRVBsWGxtMWVKbC91WWlGY2dtdUZsVHVIZEEwQU81N2laZ0Mz?=
 =?utf-8?B?TFpOY2FtWlRBQlQ4UFJETzJNNzRhbDlDTW5HZUR4WWdaTWRUTVo4WG5kRHdl?=
 =?utf-8?B?czhlK2ZSbDNCUW9jNWpxS0orR3F6RzlzL1k0OTdzdERKMm5wb28xTE9uNkdy?=
 =?utf-8?B?aGVsUVFubWRJWE9wZ1B2S0ZmeFhKOHVybEltaTRLRENFR3JXR2ZOMHpUTmtP?=
 =?utf-8?B?TFIycVoyOHBJK1ZSUytLUWhKaXErc3FqSVJ0QmlDekNJeWJPUXFsZTV4MVhW?=
 =?utf-8?B?UzFtR1BzR0NzUnJxd25mS2FTVFlzVFBmTU1yVUhPTWJXU0VGMnpZQzgvWC8r?=
 =?utf-8?B?WXUwNXI2bGtIZkUyRUwvOERIWnJwc2ZqL0R4SUhHZFdSQk81Q3B4R3FTOVBl?=
 =?utf-8?B?MFB2c2FabklZeEI1Z1Bid2xidHN0Vy8rOXFIQ3FabkpLdFRZZytUQVBtb2Vk?=
 =?utf-8?B?cHBwS2JOMDBPbHFNTldPclYyQldrUDFJdVB5V3RtcmU2ZEZ1NjMwSmJlSEY4?=
 =?utf-8?B?aCtYelpHalY2Q2RsMjlVQUpXQkRzNWpqYXArY1lEZmV4ejNzcmxTUm9BNXBa?=
 =?utf-8?B?VHRNdlFTZGlJbkpESkNJZCsyM3M0bVVlbEswTk1XSzMrZmRJOHF0YmRoUG8v?=
 =?utf-8?B?YTRMMXR4Tlg0OTZ4cDJrd1UzUHI4dDkycEZSYkM3c3JHQUs4MmJJOVhCTDU5?=
 =?utf-8?B?bmFkYzc1NC9RVERRSHoxbVBiVmpGTi83S0UrUzJtL2NxbTNjbUNEL2F6TDVK?=
 =?utf-8?B?dXR3UkdJWHhNdWhxZ2gvSFZxK2hoem05V3ZuOWpJRk9FWXczemdPVGR0M0dT?=
 =?utf-8?B?bUx1OTdFejNXQVpzeGlkN2NDQktjTHJCWDFMclRZK1lJRWdDYThEVkU2Uk9N?=
 =?utf-8?B?bTJXRWtVZlBPT01XaDVTQlJPQ0VtUnZZcXlqcS9aRHY3QlhzMlB6VDdBeG0w?=
 =?utf-8?B?U3ZlTTVyeUltSzJpTDRBMHBrOXlyNWhhRGw2ZWZNNkV6TE1pVE5CeUZMUzdB?=
 =?utf-8?B?L0xScTZ5MHA2czdINXZIeEl0UzgvSVFjZUJ4bU9lMjQwSnBtcW04OUhMQ0c3?=
 =?utf-8?Q?T7AdfEkYA/eSreBNqxUmfy7BojBFEcVP/vWPw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACB5CF965DA7BB4E98A38C22F4559411@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f0f726-675e-4405-c620-08d973ad4f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 16:17:24.5704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2L7303i0E8MQFklPfLVumE7mOcGFSOh1wReH8SFJix0YUk0xkQTMT9Txr016RZelHjZkJB0Cpubf8pUN3Nrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS85LzIxIDI6MDYgQU0sIFlhbmcgWWluZ2xpYW5nIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IElu
IGNhc2Ugb2YgZXJyb3IsIHRoZSBmdW5jdGlvbiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UoKQ0KPiByZXR1cm5zIEVSUl9QVFIoKSBhbmQgbmV2ZXIgcmV0dXJucyBOVUxMLiBUaGUgTlVM
TCB0ZXN0IGluIHRoZQ0KPiByZXR1cm4gdmFsdWUgY2hlY2sgc2hvdWxkIGJlIHJlcGxhY2VkIHdp
dGggSVNfRVJSKCkuDQo+IA0KPiBGaXhlczogZDliMmEyYmJiYjRkICgiYmxvY2s6IEFkZCBuNjQg
Y2FydCBkcml2ZXIiKQ0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdl
aS5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQoNCg==
