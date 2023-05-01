Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089AAC77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjEAEc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEAEc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:32:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CEDE76
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 21:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2rX5oj4lWRS/Xxs6NwWa7EaE+34jFKTV3qmT9imNY5yuYVN1187m9a0iOhmKl5DCdf5adqba6jLF8CyMxludUgm6faqWoIIlzzytAPZUDgs3ZZ1jyqplfM9p6uccbQvispSm0yG4uLi4ZA1ZJgsguMDF6qiTHkGTXR2sL9cqH2D4n2V9tMEeJcnjO/rNWGeJkxPaliPZDjJYgG/mHOJMYn7okVHXiVuP4wl1NkndFqqwnHcwcimjGqp+jXo3wnYiMCcx2EW3KAIOmLkakuIouLvtgH6YLqyEGHw3uTxh+IHTYjrWoFGc3bJpG7fLKNu6PQxXUWoz8pHSj9kG8V2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOvZbKMu5BPV5/WemKdZ9+PQtijqLjt+l6sh5MH/keE=;
 b=WpKmk5Wme67zyDedLRJRjSVeZh1UklCczuwXW83JR8qLPX9SsxQuulnD54VZKGZgpR9bJKX1GIjx1aaRcAAHs/jVi0XWZ5y4deDjXvXXUEGLi8gpOk0/x1wWolEFPyTGyrOkrqtdKPz7A63ED8xtf9wDlc5WsNytxZRfTUvWOJdiE9T114F4x22QwdtbumWpbP0MYt9XhCnliX+ocqEa/X0o2YTgTdUfASyJg85AWMMw48/d/lDiShfKH3q/oytG912+PQVoWE7VcDs0qJl1i5iyTAAnR1Fmi2irEGuv/8H/VULfz81iDQD2huW8aniIlI7kUr8ZcbVavjQnJoYI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOvZbKMu5BPV5/WemKdZ9+PQtijqLjt+l6sh5MH/keE=;
 b=G343eRWE+IuR5Utq9f3JpxSavoqKmerOoF2qar7Lg3eyZNO9joC35PDUbef8u0cO6QIENTz5PuGUCvvRF+mr3Ud8gv9j0aNb0VOrk7VXLnNAJp92ybp1MhfKTbb/9xd4LQh/neYf4C/evIZCvuSR2Z1DNIgCbDhBPXOmosvFH9F1RL8dUChPLQDw8oICol1XSsTsFzVDV0D4dT0zA0ol54b/ZeltddHzU4wrFw6iUWnizsv04dKbJGqgriJvNBO6hETcjglID7/2ibSGynzo31LTEht5uZav6fszffedmEQnbBtcGWPIxXSsqp9EEbJhxV1HJQLg++/6FAxu5u4EMg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 04:32:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.029; Mon, 1 May 2023
 04:32:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/rc: fix kernel version parse failure
Thread-Topic: [PATCH blktests] common/rc: fix kernel version parse failure
Thread-Index: AQHZe+NtCiineEKtVUyonuZGkixj9q9E1BMA
Date:   Mon, 1 May 2023 04:32:24 +0000
Message-ID: <35a949bd-2003-261f-f68f-236c3ca4400e@nvidia.com>
References: <20230501041415.49939-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230501041415.49939-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL0PR12MB4963:EE_
x-ms-office365-filtering-correlation-id: a2d6f4c9-e548-4c5e-b04e-08db49fd1001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qB1+AC/x56X2euGksjJ93IGMDAz4EGTCN721p4qieOh47q0QhW+ApUBWVd+2/McuRPkX9Ih8LKG6Ec8k4BD/PHfpXeHfZpG4pGvVGCJaQ61mWPJfUHjva0LRUG0mzW9y/FCJPDmnyJ1PE2FrsoEMqNgn5AAn3oNnyXofkfrWN/tiZGf2bd7u31+OCQlp8uF66e1VeROvWgNir3ASJ532+buM0VmQoNGlsepAFd6JfyaA/Y/P4Ed1gFYyJZ/5zl+oXZNMDv3oCpVi7AqlQNZvw8t6QMO26IB+TbynD45zPKQopDZ0UO+141C87ZMvw6ZX5yGwXIP5lxpJ0lK17B1FE0I/uVW6Ks9C3Z2bGk/eSCKjqT/KZGI0DjOKogsDKmqiGQ1yZMikyH+NMGg4UbG91O3y5vrFyeEgynyG7m8V0tFgwwfu72Vyd9y4GrsDXxrPASf9R020v/3+N/POzIh3E6aybDiNNq7e+XCC5Ya4IAmzsleODcOd8eGH78Tz0oCn4DbRvCwLauVswRakEBUW68+DsFFOhjf0lIsX5JwJteOq9aCWwU97pJB2F/HQluj6cv5GLxYpOFMYivJh/UaojXFvARGGSL1AjrVY9avlC0/sjJFQK9agzFAf10IV2dIpkKeie/tPGS17kMyf1SEU9YYzGgy/8DAUbgeGYfHc1psOtW2YXgCwT3AJzCIIDJdw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39850400004)(396003)(346002)(451199021)(36756003)(86362001)(31696002)(38070700005)(122000001)(38100700002)(5660300002)(8676002)(66556008)(66476007)(66446008)(64756008)(66946007)(91956017)(76116006)(8936002)(316002)(41300700001)(2906002)(83380400001)(2616005)(71200400001)(6486002)(110136005)(478600001)(53546011)(6512007)(6506007)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJIQnB4cGdZSGhsWWhYVDFDdmJmOURHSWg2RFlQcHByaWJtM0lEYnNUbGJB?=
 =?utf-8?B?d1Vibi9ZMG8xV3FZaEpIMHpNbmw5eUlodEtyYjR0OUNxbEdYUjBncjBDR1BF?=
 =?utf-8?B?MnQrMnpMYUJESnY1cEdCeUpudVBlU1lramtmMnYzTVRiNEN3TDVXLzdOOFBS?=
 =?utf-8?B?blhuWUlTTlZ6amNLTEtITFVieW04c1NzZGl0ZzVXd01HL2dFY2JrMndweU92?=
 =?utf-8?B?V0V5U3J0TDdKb1daNTZMTGpFaEZweEZWdjZxcnE0UFVFaWlWZUhIcU13QStF?=
 =?utf-8?B?d2MrNWlwMHE0WEp6STNVNnZaYTJhNlRwZUVnb1FPb3JUbER0cjdrcVFMcnJq?=
 =?utf-8?B?TEh2VXU0NDd4R25wMXZ6a090aVc3OEZhMVdYbzJhWmZ2RW1qcVNDMEd0U2ts?=
 =?utf-8?B?N0NWU2tGSVpndUJTMWszdDVCcjduM2kzZUp1OHVQVlI4M1ZyVll3Y09lcGdm?=
 =?utf-8?B?L1dVL1pYdmJrREU1K2Y5NjdIaW5kbm13b2RuMFFCdHBKd05LaCsyWCtxbk5m?=
 =?utf-8?B?NFFtNVl3MGljY3RjWW5OK1NrYWh4QkhSelhlZFNsbmJRVkxsQjNSTkd2a3Rm?=
 =?utf-8?B?R1NEMlRoUXRFR3lxSnlmMkk5KzBvaCt1MDMvRCtjS1BCTDIzQkdpSEUramhk?=
 =?utf-8?B?QkpwNkcvbmpuUUpNai9CTEpuU0ZidkFOK1ByVTVOTVJSKzRZamx2WG9qbTlH?=
 =?utf-8?B?ZVNPVFduV0lvZ2VLN3BoQWNYT2FZNlNQeVRoZXdmZVJnR2lXVmM1YVhRSVBr?=
 =?utf-8?B?NDFpUEY2dGl6TEZXZnhmVnFGSk4xcHdudWNQTVpXY0pHWDN0cnlIdXNlMElz?=
 =?utf-8?B?bFFyVWhLZ2c4NmxqVDVSSTFjU21xTmhVcHRaQzNCSkV0OFhWVXM3UUNLOVZU?=
 =?utf-8?B?NThwM3FhS3hZVGh1M3pLZytqczVuQkFQRWc2aUg0T0NPemFVeXhpSFI5Yjlt?=
 =?utf-8?B?dHd3TVJPTjlWQ2xSeGp5NXlMYnFrYnFORnA3M1dmV1hpNWhVTi83V3VuZGp0?=
 =?utf-8?B?KzZzQlVJa0V2UGo1MGFFcndUbUZicEFzeG85T0w3b05HakJzL0NWVVh2blVj?=
 =?utf-8?B?czl6RmZnU1czRFY2RjY5OHRCMTRlVEVmNW1CUGZyQkxTWWowUTVsQTFaMFdB?=
 =?utf-8?B?SHZFNHA1SXJNbkJhdnZVQjNQQlZicXBONUlwbXZKWnlNWlpyWmc0YVd5VjFk?=
 =?utf-8?B?YVZ3c0QxT3RyOVlBZkJPazEwa2VMTVNTVzlWazUrOWNZMHFZN01CWlRvWkVT?=
 =?utf-8?B?dUtqK1czUHpRdnRIUmxmbDhDdTJjdXRabUM1YVBtWERFdDQySTh6ZFcvMVZq?=
 =?utf-8?B?T3cwQzVHbStTdURyRktiY0RDd0R0ZWpoRDEwdFk2VnZoY0ZPUyswazR3bG9T?=
 =?utf-8?B?THZJNEQvZW9PMnNZekIvMHZuQjYxeUJXbzdOMi9CbEZaT0xKUDZ4aE1qL3l5?=
 =?utf-8?B?VTZ3UHJ5T1ZWamlCT0VmUjFQOXNMd1pBbXVuRHY3bXllRUo2aGlnbmVyVHR6?=
 =?utf-8?B?eStydXcrY0N6emx2M1ZvODB1aEV5cU1aMVBKWUVVQXJ2YVZINWlxaWo1dDhC?=
 =?utf-8?B?VXBNRGNSSXBIZGFHZW1kMW5QVVo2WElQa1BERWtMdXU2NWRlVzdTWVZsTW56?=
 =?utf-8?B?ZlZleDU0ZzVsUEtvaHVjaGRZd0dlVlJRdml3dFE2QkIxcGpJUW9zL3g2TU9n?=
 =?utf-8?B?MXk3MGE4dHJrUGNWdm15Qy8vdGdJKzhRTTF6ZEJwS2ptMmt2UVFYb01DWWhy?=
 =?utf-8?B?SG5RRlVwd1hKMDBvcWMrOUUrWm9mWjkzcVE4MkJIMEFHd3JraVUvdHVzV211?=
 =?utf-8?B?YzJ3Q0dlMHVNMWtiVUVaUkhpVEJGeGdtU3h1Ny9iYy9lNzBlaFd0TmtxcmFN?=
 =?utf-8?B?WFU1ZzNRVThwOXM5MndsdS9HUWRXRnlrY2kwdWtsNUcvTGhxdjlSSlZmbU0r?=
 =?utf-8?B?c0diYUsvbHk0VktyRXBDTXlNN0lGSWlUaGR4eFBxNVMvMGttWlJCS29CRktV?=
 =?utf-8?B?Uy8rTGs3djAyVjZYRElzYmFxcHord3E0eGl0bmQyajQ5ZHdLK3pYYVlNelI3?=
 =?utf-8?B?YWh6QU8vRE9TbzNzRHJUNVh5UHNCZmtlVGZZQm40VWFidVJJUGRleHUwbDUx?=
 =?utf-8?B?UkpGSHJZMFVXYUhLNXF2SFZqVEtqZ3JVRkhpcmJKZEZHVldSWkdyYnhMYmNI?=
 =?utf-8?Q?/37e4dJXzWwkUZv9PFTyojNqOWtBGnC933vK+264R+6C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <820E0D524181484FB63E80B29BE9B079@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6f4c9-e548-4c5e-b04e-08db49fd1001
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 04:32:24.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQxbOSrv2Yke1uaWKaiuooPb/hOeEb7JnUHWotp5OiWTZwTlu04vtm1SRWIq9/OUiYSE8p00R2TaWc6PEQmFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8zMC8yMyAyMToxNCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFdoZW4ga2Vy
bmVsIHZlcnNpb24gbnVtYmVycyBoYXZlIHBvc3RmaXggbGV0dGVycywgX2hhdmVfZmlvX3ZlciBm
YWlsIHRvDQo+IHBhcnNlIHRoZSB2ZXJzaW9uLiBGb3IgZXhhbXBsZSwgdW5hbWUgLXIgcmV0dXJu
cyAiNi4zLjArIiwgaXQgaGFuZGxlcw0KPiAiMCsiIGFzIGEgbnVtYmVyIGFuZCBmYWlscyB0byBw
YXJzZS4gRml4IGl0IGJ5IGRyb3BwaW5nIGFsbCBsZXR0ZXJzDQo+IG90aGVyIHRoYW4gbnVtYmVy
cyBvciBwZXJpb2QuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxz
aGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0KPiAgIGNvbW1vbi9yYyB8IDIgKy0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL2NvbW1vbi9yYyBiL2NvbW1vbi9yYw0KPiBpbmRleCBhZjRjMGIxLi41MjU4
NjdjIDEwMDY0NA0KPiAtLS0gYS9jb21tb24vcmMNCj4gKysrIGIvY29tbW9uL3JjDQo+IEBAIC0y
MDcsNyArMjA3LDcgQEAgX2hhdmVfa2VybmVsX29wdGlvbigpIHsNCj4gICBfaGF2ZV9rdmVyKCkg
ew0KPiAgIAlsb2NhbCBkPSQxIGU9JDIgZj0kMw0KPiAgIA0KPiAtCUlGUz0nLicgcmVhZCAtciBh
IGIgYyA8IDwodW5hbWUgLXIgfCBzZWQgJ3MvLS4qLy8nKQ0KPiArCUlGUz0nLicgcmVhZCAtciBh
IGIgYyA8IDwodW5hbWUgLXIgfCBzZWQgJ3MvLS4qLy8nIHwgc2VkICdzL1teLjAtOV0vLycpDQo+
ICAgCWlmIFsgJCgoYSAqIDY1NTM2ICsgYiAqIDI1NiArIGMpKSAtbHQgJCgoZCAqIDY1NTM2ICsg
ZSAqIDI1NiArIGYpKSBdOw0KPiAgIAl0aGVuDQo+ICAgCQlTS0lQX1JFQVNPTlMrPSgiS2VybmVs
IHZlcnNpb24gdG9vIG9sZCIpDQoNCkkgd2FzIGFib3V0IHRvIHBvc3QgdGhlIHNhbWUgZml4IGFz
IG52bWUgcXVldWUgY291bnQgdGVzdGNhc2UgaWYgbm90IHJ1bm5pbmcNCndpdGggcG9zdGZpeCBs
ZXR0ZXJzLiBMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
