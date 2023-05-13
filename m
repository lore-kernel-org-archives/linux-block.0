Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C4EC77B75
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 01:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbjEMBHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 21:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241754AbjEMBGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 21:06:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B72701
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 18:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig1f9DU5VpzQLNx0TBpTCqp9ynKvP3BK0xfjTdqwmfzQkUVzQHYx5st3BdoehzIlh77vtpoGAwCruVSvkvFUDHQxlNbHAHHHAr7Tol/eDnxX+kdhJaInbuCQfNQZiXjl38hnQmz36QZfROZhuNxFrklu5Tw8dFOq3V7fkPgWmCur96bH9eVeICRbFDqcVrs8Zm/M1hxkw6kXqNJS706WEb5q5vthdR86My1BaN7iIVFS7Ywak05e6lGSWkSvgcxnV+9WJe+4p4WZfE6eMS4ge7tzSQzU2BGZRGA7y12H+Ep5PhgjJccKjiY5zHz8xJWLzYluKzdoXG04kp263eXAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWU73WgG1ZriLRu/A1qkH954iobI4BcfEYDq+1eqZfM=;
 b=dpJ6TW5IE57KNrF7CG+FUxEGEX5Ok1aZ8Wg6fiEdsZ50yF5IfM5WF2PHsPScNCe2E4msFgRtL31+BYrQrkfJIJEGHJwe3Oz3kOu33Ttvrr9xclm7dtmaYH3y/AydvN5FBBBa2nlwbI81A+ZdlRxUV7wE8Jaq05kQ94dxBhR6B4eda60hoJZKejxgiEjgpuKjv6gGzljentZPrIbNA0et9TptE1XwrU6RiXQ6WLYg4SeOzTjYZnC1vTDuE4yfxjJKrKf4ZaJc9ELXRELULz9bJOwDlv5nz+uYDH1hEBQNsDyxsIapGUs6v7bz9gez+zJvXzI90SlfY1t/dVwjbZiHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWU73WgG1ZriLRu/A1qkH954iobI4BcfEYDq+1eqZfM=;
 b=Ll2mvtMEPAgU+ChGA+t323BIRjdUkEXeeBbDJ56kSRpJmqMoyYB1fO0AfOOsFI97tQKpPiCwTh+7LyUSVI4NTgkIOQ5yoFQ9DE86j94GacLTPvLYYSAusMqFejvUNrie4kbx9d08FAwu5a0RGrWacBOsMK2la05pwyl/1AlsoSrN5RAptx5FAGBbC9w60yM48EAA9drFiP6hQbn23bR/H56ZAyH4c2bzSWF0QaruaSojAi5EWM/d/a4f0vivyYUW/WnvU44J+lBfrvhwjDu66JJRsO4iogHr7wQmsuZiFkKSHM92RvDPBrOPKvMcCNemo0UyOXW4X/5DAILbTnfyDw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 01:06:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Sat, 13 May 2023
 01:06:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] zram: consolidate zram_bio_read()_zram_bio_write()
Thread-Topic: [PATCH 2/3] zram: consolidate zram_bio_read()_zram_bio_write()
Thread-Index: AQHZhKwMUvyUfej7BUeoxeUjGqNpY69Ws88AgACxNgA=
Date:   Sat, 13 May 2023 01:06:44 +0000
Message-ID: <d066c2aa-4fd1-bf62-7ecb-5feadfe1e79f@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-3-kch@nvidia.com> <ZF5N/Pg0f9bxhY2B@infradead.org>
In-Reply-To: <ZF5N/Pg0f9bxhY2B@infradead.org>
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
x-ms-office365-filtering-correlation-id: 76d70623-0b71-4899-9db1-08db534e51e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oTja3wcGBx7clezzPygxdRE+GlMKB005F61xQmYI301u0aC3IW9ps2DAUF6VpYF3Qgkx0tk+veXpgeQzpvRjsbl6mq2iLkSUG4i0wnE1LXut0LvyYPFtZGIuUXj/iD5OlnvSdoWLYzEs8lq2HemiLjaIHiVtUPpnL92ogO351CevVb7vbLapDXVgU4SWXht6M+suNAwSkZZUYq3Tmv/RCBN9wC2Le4KcN0E5rOf9W+5PyAkGW35SLMRRhqRWt3286EJ5l1oLH89INtYeZ+UuTSUATdXL30TSQAsU1ysxOO04oPuW9z5Yog5K3j0ctgDm92ylcq7Zb3yCKfCPzc7za/Sro6rhFvvOHymTAHlnVs2EQVsUZIuBiQRjhOIpvLzoe9EWu/wy73HQNNQ4NPuymEw0/NmvMh0yC1VBn34fMGrM1xIwcg6wtu5/RfqoRMlMtWyVs8zXWDoS/FQcvXMgEsFMdb8Iyzrd2+9Micvw2ifU2UZfoENlScphufYauX42hz1elPutyXjaUeLB7M7dueOM3NrQlTlhS6APOoHuAlLiQNeMbVpPkiRnDCpoWFX3szMzD7HhpOwIniBnkozw3VqWzQ1QjAwE73qbjulnSxDddACOznlj2mWtM/mYzU6bDuty6pfsMoiy4zarLRJBH4GJxKLQRkzwSbmCKODb4rb4iO1dES90MjTxDMT62iQp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(122000001)(38100700002)(36756003)(38070700005)(31696002)(86362001)(5660300002)(6486002)(316002)(8936002)(8676002)(2616005)(6506007)(6512007)(53546011)(2906002)(66476007)(91956017)(66946007)(66556008)(66446008)(64756008)(76116006)(478600001)(110136005)(54906003)(41300700001)(31686004)(4326008)(71200400001)(4744005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlRGRnI3K003am5wY2E1bFE0RlIzZkxjUUJZWVU1L0ZUZVlhRU1GY0hvc2ph?=
 =?utf-8?B?S2xTY2JPWStUaUZNVXoxQW5TS2RUSHlGQ1RRKzNyaWoyTHZLaFQ1eHVvRjUv?=
 =?utf-8?B?U1B6dkI0YkJXRng2c2pnRDVhWjBJTzlWOUc4STZ1eFhaU0h6c09DOFlFcjdM?=
 =?utf-8?B?TXlRdktUZkhjd2d2a2htbUNPRlM4bzJlUTBxLzN6c1drZlc5QmhsMWh0OGJj?=
 =?utf-8?B?WGw0YXNRT3ZVMUcvQzErUUJSamlwUU9wMEFiNVVjTWQzem5wbEJxMGF5R2k5?=
 =?utf-8?B?SUdkTWxpbWhqb3M5c0xrMExjN28rN08rektxeTFiM1VqSnFQcWNXallDbTBH?=
 =?utf-8?B?QUdlZkFnRm5PeFEwOGpxM2NZQmt0bkVmaVJsQjVtV0VQNHFsajJhVllhUUFk?=
 =?utf-8?B?Wkh2SGQvWWVSL0Z3azM2d1J0Zkpic2xkcGRBRFVxdk9pWitIcEk1bW5xVTk2?=
 =?utf-8?B?SW9VL0l4RmxtZ2lYK3grTUpTZm53Z3NteUFhUkVyQytST2dSbVduQU9DTVBM?=
 =?utf-8?B?eENUaEYrT28xTWxPcUM4NC9CaHl2NzArTmQ3WlQ0dFdpQzIwR1RmdC94OWpm?=
 =?utf-8?B?Z1c5cFk2RElOMWVKTkxJdmFQajV6NmRZRlgzMnR4clFyYVN1MkcrMVlseUVO?=
 =?utf-8?B?TlZYcW5kZjRmbklwK0xkYnB0dTU2Ylp1NHBtTEQ1MDFvQ25ORDlKbHBnSXA1?=
 =?utf-8?B?NTgrQk5oaDRKTUwwaGRSd3F3ZXBIQVNveFU2d1dFWmtvVDJhYmVGcWZsUllt?=
 =?utf-8?B?ZHV1dUkxUUkvRmhYMm4reWN5MmEwNkpvRzB6VURYMmV6QnpmU1poclI2UlhY?=
 =?utf-8?B?TmUyNExaV3N6emt3Ly92eUtNdjE4bHFVZXVqOURQeGtubjJtWjhWS0dOZUFq?=
 =?utf-8?B?Z2hFQzFYSWNSVHBTY21oOWo1UGU1dDJYbTlHaWMwVTVscitNN1ZkUDZaSHZD?=
 =?utf-8?B?bndid2FzOTNpNEVTeFJLNFpucklxWHl4QlJCRWcvRFBrTFlNTHVPdkVMYS9B?=
 =?utf-8?B?UXNIWm1pWW9rYVNQZFA0QlJSZ295Q0Jsck9OZUwyQmlBYlN3aWw1UW96S2M0?=
 =?utf-8?B?NU1ncFg5YVBESzhCOGIrUklQTm5jcm1WV0lOY2ZQTXRFejFxNnMxYmcyRVBC?=
 =?utf-8?B?UWlEVmVCOWN1bFlQVmxPdzhiSXhUQ1EyWHFhOTdpNC9VRjBxRytWczhCR09P?=
 =?utf-8?B?K0o1UW1xaDR3L0xJbUgrV3RtcHpKVS9FVTlqS0k0VUwwTTJORjBGbnpobE52?=
 =?utf-8?B?MXNUNmFDd3NxNGEwL2lXeEJSK0V4WklCMzk5aXNReS8rQTlNSTdnUS9KdnRS?=
 =?utf-8?B?WDY1bHdRbVBEd2FpZXBobmNYYUduOFdxeU1aNGxzS1BaVWxRTE1aYnoybnpD?=
 =?utf-8?B?VSt2d1F5b2tMc2ZkQlE0QjFLcms1NVl3U0t4ZnV3TnY0U2tZNkZJNnVmNDZ4?=
 =?utf-8?B?aW1HMWYySE56TFZvUFF2OUN6eGQvVkxjSVByUzR4KzI5NXNydTZCOWdNTFkv?=
 =?utf-8?B?ajVwb2UvWnZXazJZZU1Cb3Urdlhxd0FUanU1M3hVazhxS3VnRVdWUWNONXds?=
 =?utf-8?B?NG9JYk1jclMvVnFUQlAwR1pZNkUrTmIyY2RVT0hEL0drTDBaTGRqWHRnTmxi?=
 =?utf-8?B?cElOc3BnZzgvelVkUXFxMzR6VjdCNzg1SG9qd3dwRUxnYWJEOXZuRHBpZXQw?=
 =?utf-8?B?TVJWa3FGMDBjVEwzdEVUVmJkRUtLaFdZYmthS0lySmNVL2dMOUo1YnNEOUtB?=
 =?utf-8?B?TlpIaXFUMW80Y28xekRmd242eEZCYmhOWnozTTlCNThLaDNDbWRaMXJXdGxK?=
 =?utf-8?B?d2JyT0VkRWR5cGJOOFd4V3FWeGdKRDBxRUZVVkZLZjdVb0NUMXJGOHFBSlZI?=
 =?utf-8?B?cjF4SzQ1MVlDZnZyL25KTXhvdEdUR0JoMVRLZ0x6Z1p3dWlmVWJBQ0ZVWE1u?=
 =?utf-8?B?VDBjYjIvOHBhNllpMm9GOGlYYWl4SjE2UitRem15c3VoclRGZ2xGYk1OQ3hw?=
 =?utf-8?B?UnZxQ2EyOHBHQVEvUTIxUk5kRmNSMnNNZm4zeWJrSWxVbTJlemorQmw2SGxz?=
 =?utf-8?B?NEFhbXE2bXkyY3B1T1gxWEhtbmtpQU90R0ptTFY4Q01HV0tTVnZPdEpadmZC?=
 =?utf-8?B?eWRXZGVraE03ZXpwTUY0MWE3d2dGQUIxQ1ZkMFh3Y0FzR0h6dlA5NkRSMTU4?=
 =?utf-8?Q?lMB6I/1xFuNfeiHv24Z4AVxEdYqowCsBpDtg6znibjdG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E7CEC2B94DE5740B4405953CD5DF9DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d70623-0b71-4899-9db1-08db534e51e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 01:06:44.9003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+yYdHoqTJBwwpYl5U6ueGAPmIH8/GpZ7RcHxOTpkpgZQsEJxXWwBQ/d852tHPQva/WSVjzctsOuDBqbyVlLOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMi8yMyAwNzozMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDEyLCAyMDIzIGF0IDAxOjI5OjU3QU0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IHpyYW1fYmlvX3JlYWQoKSBhbmQgenJhbV9iaW9fd3JpdGUoKSBhcmUgMjYgbGluZXMgcmFj
aCBhbmQgc2hhcmUgbW9zdCBvZg0KPj4gdGhlIGNvZGUgZXhjZXB0IGNhbGwgdG8genJhbV9iZGV2
X3JlYWQoKSBhbmQgenJhbV9idmVjX3dyaXRlKCkgY2FsbHMuDQo+PiBDb25zb2xpZGF0ZSBjb2Rl
IGludG8gc2luZ2xlIHpyYW1fYmlvX3J3KCkgdG8gcmVtb3ZlIHRoZSBkdXBsaWNhdGUgY29kZQ0K
Pj4gYW5kIGFuIGV4dHJhIGZ1bmN0aW9uIHRoYXQgaXMgb25seSBuZWVkZWQgZm9yIDIgbGluZXMg
b2YgY29kZSA6LQ0KPiBBbmQgaXQgYWRkcyBhbiBleHRyYSBjb25kaXRpb25hbCB0byBldmVyeSBw
YWdlIGluIHRoZSBmYXN0IHBhdGguLg0KDQp3aWxsIGNyZWF0ZSBhIHZlcnNpb24gd2l0aG91dCBh
ZGRpdGlvbmFsIGJyYW5jaCBpbiB2MiAuLg0KDQotY2sNCg0KDQo=
