Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 05:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D02611F0
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 05:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhKJFVM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 00:21:12 -0500
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:3681
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhKJFVM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 00:21:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMxlI7jIypzclcmbG4atQ5tklUUDb3AnejhDcMO3gkGNIBsM5/vvTV+KcQZWfSCfuK6TrW08yVTixd7O+ahxr5tqtY89M0VNyqbPw/5j/TGdd9DF9T3NPBTvx9qiIYqqKVlel7cZ3m93PIFFstiWzN3b7DRbDBUGuOF83IBHcPzQKynUbHfMGSsJWavSSXy8lWudFE2868KLS2R6FFjpa7EuCDAEnzICPmTdvNVY/pEMXJg/JJlJDDb0r9O20wwZl73dzBuUy+QaqIPR5QYTkM7UP7x48zxgF3NDB8thu04FOn5+LMbQLqyy8R+wkgF5nWbSTyf43QeMDmnP/4dlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/xzLZF1LiuV6q99iMwozHg59HmtMSgfG9UnhhC/3MQ=;
 b=TkT9yCIpr2bCpThK62WGefhrpiJeZtiEgPAx+4/XrKh3R308jEytwnsS2ViwlVUq+1GTdkhmKIWMprw+DlpKAVvZ/7Xe6snQqUKTsDurjmjy08E3vSKWSuqAHtwy31gW/cZ3fAadheLbya3hShY+NTxzbG5OYOvH04/kU8usmNrFwbtSByZBalH6c7LXS23LbjBioXUmUb1XsnZiSxCR1gyP1zt5pxwTQnrEt6YkfyUD4nRzILNHh/96N0QdiBHk3T7CtVrSJwJRjVr7+Lg7NqgrAGqMacNtmWR+5QHCdNDqPq2+TqdRVHwwTWeIxaB366W6xYDpT9TVPfjvaPilcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/xzLZF1LiuV6q99iMwozHg59HmtMSgfG9UnhhC/3MQ=;
 b=JO5qKC7eEORNUG4jf/jvUO9LTzNfRxj/T0nAWqFi2Gou/Nh+iXf4+Y2z69ayJSUfUJaNnfQNrmQmVFua2zmsy/1t0C4799LQg54xJ2TUB0XlXGcQBlGaTwsTRhT6bqXk4OZs1jT7aEmRsRTNmt2ZG6eLn7C9BzFW1f2hQ2Q8PtvM1Vn2W770Lq+QeQgYwKHU5li2T4mK+gbjtEgRgVEBNcMU1av7r9uKfldXc37RaSDE9l8o32k3McwO6H8dKELQw+89SCD2Czzc4q0078H6q16eaOs1YypOP6CGosDFB2axJkxAY+Hbm+yGOMC7QRk2qk+m04iKmAQoRiQhWU5opw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 05:18:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 05:18:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use enum type for blk_mq_alloc_data->rq_flags
Thread-Topic: [PATCH] block: use enum type for blk_mq_alloc_data->rq_flags
Thread-Index: AQHX1bauWZ5Tky/hVE2ZhhYxdHtkZKv8OVaA
Date:   Wed, 10 Nov 2021 05:18:23 +0000
Message-ID: <af649c32-e758-48f1-d1cf-e2e2d0426657@nvidia.com>
References: <1a4b790b-8074-1f67-24f5-662400b2976e@kernel.dk>
In-Reply-To: <1a4b790b-8074-1f67-24f5-662400b2976e@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd89d4a5-da6a-471b-f433-08d9a4098479
x-ms-traffictypediagnostic: MWHPR12MB1581:
x-microsoft-antispam-prvs: <MWHPR12MB1581E60E9FAB76A19F19383DA3939@MWHPR12MB1581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZCxsWpt1Y8gbQPG6LItsaUz9oUkK4kQaSHkaN6zPdnjXLOi9iKYKzfoPlEP488bq8Em6EYISuHdJb7nKkvVsbEfRZIiwgZ5LpQIR/Sb4HrIub+sdX+Hi7E9hHFwo5N9Ytl1aOull6aDzFZwBen+CiLLLVT18YLQGVHAsA/zyxknxSm5v3H5ilvSQqBPVSrWpDNznqd1vkicN2t8HTFG9fAeLdzfOovn+BK7N/YUWxS4qx5M4qrPbqny4gLAKG1N2shcPpdK9THUvWVGe8t/MEPBWFzMM3n+a0/964KUIwxJIFC7IhW60vxvwUtQWRj8QPLEwUEzpebKNZEmnbDT7hc5tGGej/d7+aRHGq3+ygTVoR3N8dnWHVfOwsEsAwIkblhU6/BvnaYKDYMdaOiV3uUkf5qfVJLv4B3yuXq51AybMSOBzu3/da+jc53jPxxhRedvsjOsJOxUiS0ierYpDdtOmEvvqhiLZGvXC2gVKeUtzftDRH+ca/MEXnizJywpwM90nr0+MQzvo74W1dVPbhfT93ABStWNB8vYXr/QN6gXn/+aY2wJaNQnzZfpZ7l8UKe+iEoLEg57+NSDpmJX+yn+idJ+iVOEYxhsCY/ACEeDhEuUhU3ohu3Z2hBzG5EefY1KemowfAgZ6UQ3Zogtl+t3YYAr4AQw1i4Rl4jOd+kqhE7YxgtPaZYqIOYQqmmvnz/eicvBL30MIDnP8zObNkbDYAxceAQqzd4W8XT9lwluyb+cfY6Mv3WMj5Xr9/Thls5KQv8IVtxbnnEeUGMYlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(31686004)(8936002)(66556008)(66446008)(122000001)(76116006)(8676002)(186003)(64756008)(38100700002)(53546011)(6506007)(83380400001)(31696002)(66946007)(38070700005)(71200400001)(36756003)(316002)(4744005)(508600001)(5660300002)(6486002)(110136005)(86362001)(2906002)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BNWnRrRVFVdFZUREVacWh2RFVlNGtkUCs1RlVxakp2TFZLZmNEZDRLajN1?=
 =?utf-8?B?Qzc1ZjlYVGhRT1c1eXFjR2ZVNGVjZ2lRVzlQTDNVVlRDRkdOR25BWGQ4Qk5q?=
 =?utf-8?B?eSs2T25YVkp3VTZtRFRhVjZKSUFHNWxBZG9OMmhERzFvQlFXSitlYmt4UW9L?=
 =?utf-8?B?WGpEVjBMVTYzUURmb0xLbjd3djVramVMcU1WalRYMHh0YnI0WFM0TVhPM2I0?=
 =?utf-8?B?WjVJN2loM3B4dTdYaVdLTW5wRnYzaUZ5c2VVYzdEeWF6cWU5UlU0MmNiVDR1?=
 =?utf-8?B?ZjB3WUNCeFVweG5TNk1UVlpYVkJQUWlnaXg0QVBMSXowSVVxZ3VCNXZPTFg2?=
 =?utf-8?B?UDVGN0I1ZnVOSTBDWGgxc0JXV3A5L2QwWTlqSnRrYzMwcjU2aXRPazhWbnhF?=
 =?utf-8?B?UDlxNUJyOHhQTU5LWmRtR3gxRFpvb0RJVjRHWTlJN0xHQUxVa0FDSkdQU1V2?=
 =?utf-8?B?cTdMZG9vVFpqN08xVHBmK2pYcFBuRG1tVkNlWVc0TVozeVJWVm1UZVdHRitt?=
 =?utf-8?B?UHpXNTloZDFwaVJoWlR2OWt4TDc1M0dKaGV0czNsM2VSTlNTbVlaeWtaQWpv?=
 =?utf-8?B?NkVnbEhnVTV5eXlwajdyMnJVUTdNRlhrT3BMR1huZEZ4dCthVWkvdTArbERi?=
 =?utf-8?B?dVE5eWQrL3Q0T3VKV3lxaFlYcEd6NmNmV0RpcmtvU2RXRWc2V1R0NkpsTjBP?=
 =?utf-8?B?b0pTYUFPRndPL0ZqREVTRHI5Zk1pQnIydERwd3BJWG5yUVYrVkdiTnZPMm5Y?=
 =?utf-8?B?VUFZWXdVYzhtNzY3NDFEMkRMTXA5SXR2dFJ3Nm9rZnMxOXhKRnhJUEw2NXNt?=
 =?utf-8?B?VHd5T3lWM0VXWnk1MTh6cHRnSEFrZ1FlS016eGZhT3NHaWMzSkZlUTVKeHV0?=
 =?utf-8?B?MVR3K0p2NnpqSG9XU1FSaG1tL01jM3lCZEhETjBhcUxGbHpBVTRKMjJJV1NZ?=
 =?utf-8?B?M20zR3RyUC9NVUtPOS9xemE0bXJLME9tbnlCTGZaRGtzTHdSMHY0NHIzTS9H?=
 =?utf-8?B?VHhsd0JZYmFxSlQwUVJTMElreTMzbk50N2FHQWdMU2prWDVXcnN3cElRVi9O?=
 =?utf-8?B?SGVmOXQ4NkhNVXhUbk55RFErTFI2bVh6ZGpXdHZxVU4xNU9yZUVTWFdhS24r?=
 =?utf-8?B?NE5CS084WTMyQmJxWXNYaC9GYlR5NFhJa3dmK3l6MHhPVjBVYy9YdGpRL0N1?=
 =?utf-8?B?dUdPZ1Y4UVh3SEV2QS9UTVVaVXJxYWlrUHh6TVVCa3lXVlF6THh1Q1Z2WVda?=
 =?utf-8?B?T013UitlZVpYUlFqWmVNa2tSckhwSzBNTTU2VmJCQjVBdnYwd1hINFdhaUtG?=
 =?utf-8?B?L2hZN01aVG9lNkpYWk51eVpvUkErYzZMR0s3dXdmYmpNRzkwVXBMb295NFIy?=
 =?utf-8?B?alZLMVN6a0tmMk9mekdLdmY4Q0FQTU5lRnBzMHNlc0UrLzcyb1h3bVNrdlQv?=
 =?utf-8?B?Z0tMbVVSR2ZxWUJBS2Q0TnhMeksraUFRbU1hMjFPSEtpSmovKzZYV2RxOFFK?=
 =?utf-8?B?QlFVOXByTWR2Y0k2WEpwRy9QRUd3cDJTVWNCS0wyZnltaTcveXFCdUNTK3lE?=
 =?utf-8?B?QXFrUmp4QUlBYXA4QVNVbDlUU3pYSTNIT21MRUJYcHYzZkZoNlhGZjZiZjdl?=
 =?utf-8?B?bHFUcFFNbXlOWUZwajJ6U1A0Z1B2dm9rc1pNVmRGMUV0N29paFdFU053RUxa?=
 =?utf-8?B?OURpeWVVeXRkdnhnVFdUbVR3TTJmdnJoYWdxSVhvbHpFTGpHUjJCT2UzdFFz?=
 =?utf-8?B?Ty95R1k2TFhLdCs1bi93Rkp6RExsQ1AvQVFqRjdxck9tWEVXc2pUczR5S2xG?=
 =?utf-8?B?MEgwVy92QVlZcnlkSXU4SE5xMWdtaTMxR0ZOUHBvOHJLRFNGbnJtc3VjVGFU?=
 =?utf-8?B?NEIvN3p6eGJNZThVbXRuSm5xWVJ5c3R6OGUyNXhpZ0Y1ZFFjdnk0UFFLelBt?=
 =?utf-8?B?Ui9tWHV0SDQ2T2N4MWNJaUszOGlLSE5KQUZndEN0Q0JncE9oWFNkTW11a2ZX?=
 =?utf-8?B?bEREZHl2K2M1TDBhMklpU05CVUNrUjByR201c0JnN0NMRExSZjh0a3p0d21P?=
 =?utf-8?B?M0FDMWtFVEh5UFBWeTNlQ3Vab1R6UmwyNlUwdGNnblZkemJmcE1FZktUZ3do?=
 =?utf-8?B?Z0lwSHBYaWtua1NZcWxlUzd3ZzV0R2tFTmF2U29QVlA3eGtBMk1rMWJiQld5?=
 =?utf-8?B?MWNTWHllbWUwcGloQmxxUmpFaFRnazg5QU1nQ0t1cHZWUktZaVlYT0NMbEY3?=
 =?utf-8?Q?20igEb8vJtNy1c88ofjBTXJW3czYg1XXFtEQrwTzWc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D20726D98EEC54EA57BDD8E23816A4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd89d4a5-da6a-471b-f433-08d9a4098479
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 05:18:23.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNcmcQYGHaUJDOhDTb/QBNLYCbLCgZjv42mRUotL/CJv/W3vcrwNFnyCdk0cOrL7ul9vR9QCLL7/yNknSaw88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvOS8yMDIxIDI6MTAgUE0sIEplbnMgQXhib2Ugd3JvdGU6DQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4ga2Vy
bmVsIHRlc3Qgcm9ib3QgcmVwb3J0cyB0aGF0IHdlIG5vdyB0cmlnZ2VyIHNvbWUgc3BhcnNlIHdh
cm5pbmdzOg0KPiANCj4gYmxvY2svYmxrLW1xLmg6MTY5OjMyOiBzcGFyc2U6IHNwYXJzZTogcmVz
dHJpY3RlZCByZXFfZmxhZ3NfdCBkZWdyYWRlcyB0byBpbnRlZ2VyDQo+IGJsb2NrL2Jsay1tcS5o
OjE2OTozMjogc3BhcnNlOiBzcGFyc2U6IHJlc3RyaWN0ZWQgcmVxX2ZsYWdzX3QgZGVncmFkZXMg
dG8gaW50ZWdlcg0KPiBibG9jay9ibGstbXEuaDoxNjk6MzI6IHNwYXJzZTogc3BhcnNlOiByZXN0
cmljdGVkIHJlcV9mbGFnc190IGRlZ3JhZGVzIHRvIGludGVnZXINCj4gDQo+IHdoaWNoIGlzIGR1
ZSB0byAtPnJxX2ZsYWdzIGJlaW5nIGFuIHVuc2lnbmVkIGludCwgcmF0aGVyIHRoYW4gdGhlDQo+
IHN0cm9uZ2VyIHR5cGUgcmVxX2ZsYWdzX3QgZW51bS4NCj4gDQo+IENoYW5nZSB0aGUgdHlwZSB0
byByZXFfZmxhZ3NfdCB0byBzaWxlbmNlIHRoaXMgd2FybmluZy4NCj4gDQo+IEZpeGVzOiA1NmY4
ZGE2NDJiZDggKCJibG9jazogYWRkIHJxX2ZsYWdzIHRvIHN0cnVjdCBibGtfbXFfYWxsb2NfZGF0
YSIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiANCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
