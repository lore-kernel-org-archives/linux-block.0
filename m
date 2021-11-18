Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B26661AF0
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 07:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbhKRH6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:58:06 -0500
Received: from mail-sn1anam02on2070.outbound.protection.outlook.com ([40.107.96.70]:44133
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244115AbhKRH6A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 02:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqcWHYvlIt3Tpal3Sk9I8o00WIIE98pwWr6uyuX1V7Mo1jOAySSUtISfPjfdfKFpzR0uK1rJiWzpxHRHmXcIAfCnX159reJIqjLcAeiTT/K4o1mE9QJW7eZmMjHuwO4ZuLM/AE/Fuk6YwGxDKWFJ3Goz0W+B+uinFH+EO8KmZv+NNn/outh2WKSYK9+esMN4KHZmGyYiSF+CiBTituiIIaXLViF0AFW22Oi4Bcrrt4TpLshZKzH5fqJFtd0gd4ResOIYdQ7dPTfPbeG3gI4M3P1dkasWCm7Fml6x9oi2lzmh0FCkKa3rl3BVp8ljdReZSdBCqVmQeYcCrfNd7myjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woqG+vg6SzV+m0DKj9XlDu3kTyTdYyMJb3oHJCMeOOI=;
 b=VhWkBJj6KIUhZOifBo2H/GxS7X+p1zQ04HNPXVMXXnfyeUbbblRiQS28ujP3ulP+gypCDIVpKNIR36MZaIqPnuh3aFpsSC/BK1c5bXMjVR4iiTZsWiaOclbhc7KJYoPRXKVk5xFdL7+WccaKARgCBwnAjSykD6CYN+6EEvjZq6jdkk13kOOH6mnYQJC0w8eNcWP1QVAgaFX2+ZWSg1OjpAtT/XFSQwissWMp437opIjLAabRfmHhWnUUOo8ZpdRQ/f8rfZXKLnyI668BzVI6aiOgTsFUYt+ZYFPyI/5OO/9w/rEglBbh6mh4Wi+FrXxpVJL6jJwZ5OuSozNg3A1wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woqG+vg6SzV+m0DKj9XlDu3kTyTdYyMJb3oHJCMeOOI=;
 b=QdPZe1hfHJkS66MvqyZToTKq4cvLbVCwnhTjuuT8sUJhJNFNzz32wKJv59bpikXr1NH0BgclzL+bYW4iR3d/O7hl7UOgTio0X44QInmzgGBvfxX21XNoib/fqPI/2pwBIGtPw2TUEJtlBMw66Q+WAB2VeShkwdrzdfJW6NgrGhMIdxtJ+Jgjf8QJRkvUUNqX8vYJYKlKdn+diO3V9d2mNvHZBthhCVFV4h4SHsZyNoDPhJaRng9ROav7RsQYkvlYpI0PULlbASbEAwnR9vOjX57RavRj9kRBNqkZFoUF9kstxkLWfK85wTkFm5PxO6JBvyX0X354rMHd5IRkQZD7kg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 07:54:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 07:54:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
Thread-Topic: [PATCH 2/4] nvme: split command copy into a helper
Thread-Index: AQHX22SOGPBtyUlmuU2driZ0roXFSqwI7GGA
Date:   Thu, 18 Nov 2021 07:54:59 +0000
Message-ID: <afbeb978-407f-3311-1e03-d723efcf157c@nvidia.com>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-3-axboe@kernel.dk>
In-Reply-To: <20211117033807.185715-3-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08e5821-d835-4af2-40c7-08d9aa68b83b
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB1262F8F8682FD289B8767F20A39B9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMlHDBFAXCj6ass4LGvzfR0SXE24uISGmo1xrFHTWOsxOllQzBFhf1Y6mhuQ7onDZd9oGfac/sTM3JegHA1/fjOUOD6bpOvuC3OTwNxrqhvDPu53p4Iw8hOv79iYQoJ6OMkL22TX88JqbBdBs+JN+6NDEIr6DwfOX4h6U4uXra4pJ3/aaBiovLhNvfSUlfetWCK16IMx0kxkq+l/35qJXICWBdzyKlY//5mg2XHhw2hWTJ8InPmd9Ee0wtRxWmkR5V5KFuhl5lCd1TwfzZvsQVXOC1LSvj6P2YGkOsLIXZFwrF+XH6ovQl/EBjYeTaiHmem6zYoVxgzSybomFxPcxHFEOzKzz+CuAd3Yzcaob2cWekFMh9+eRvp5IrHSm+INKVDZmRxsCNXQZLlVjF1jHRWOnYZ6HjSb3/ohGoEQre70uPxw/Dll3OkGfqtn+bM8dy4o8QundYvOMILdW89fyJPcJjsYZ/M7eSqkSqpMNZjzVGkrZBOUTQBRi3HK0H1g4z+bE7QFRoiMAvzsPk0JVRg1F+qkd2tk62zqwG1m64CgrsZIPRLa4bSA+fHa3WxlHVK4FHSmsgJ3rFHag4+xq0NLX9pJNeLnHTT+pLr5TOhK6ygH5+5tbVOeZUN506dEstcMMggPOwVsVoBprEwvWydCd+gZgO0o9vzPn5fMns6Rb/KjBw6cAisnHb/4sq8OEVWl2m9JYIq8BRtGmlQhWQy+PJLqHAuDZsWUr+6K5oQWKQt34vIVn7uDol8jJVY5VuQLQBNlnNfp/uFcnEJ8ZLKh67miuyuuyI8eKFpcIwU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(110136005)(86362001)(8676002)(66446008)(38070700005)(71200400001)(4326008)(6506007)(53546011)(66946007)(66476007)(5660300002)(2906002)(64756008)(316002)(8936002)(91956017)(508600001)(76116006)(66556008)(186003)(2616005)(6486002)(6512007)(31686004)(4744005)(122000001)(31696002)(38100700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXVld0ZjaGRhUmhCUy9PaFNsR280YlBTUy9INWFBSlNMam5seFFoVUlVa2F3?=
 =?utf-8?B?enJsY2xEZHpFSUEydGVnT095T21yek9kY2g5Q0hzQTZxTUJXZDlWL3NQcldj?=
 =?utf-8?B?YkM0RE9RTXQ4UENCQmhkZlE3ZHl2THR4T1N0UmhWZW1SVStWNXNIOWJhbVEy?=
 =?utf-8?B?YzlNMDhQU2tmZ0lEZ3JmMGRPU3R5L2FtUmxoZVVJNFQ5bDJVVUZyWVRjakVa?=
 =?utf-8?B?dFNrZFp1aTV2WHluQStDT1VzT3FUeXJQblFjRzhKUmdnMy9RaytWUUJJWEdn?=
 =?utf-8?B?YnZNWWp2Z2pOS295aFdKYW5oUmJWYkxIL2dMOHZGdVR5bXBQSXMrQUF1cVBE?=
 =?utf-8?B?Q1VSY3V5QUtpWUgvRmpUTkdWemRCRXN1QTVDbWxuVmRyaElXbjlxYkZOMDlH?=
 =?utf-8?B?YW9wQ1RDRGtvaW8yTVpxR2IxcVArK3lsVlRKTk1Md0o1ZmV1YzZ0d3plVXkz?=
 =?utf-8?B?Z1ZSNEcrRmhzZUZUL2VnZGpIUEVheUpoOUluWHB4WWNBZm1kZzQ5WW9ZbFk4?=
 =?utf-8?B?aDdTRW5acjB6YnV1MnJBZmpVVCs3RmV5YzJuR3IwdVBNTmZkQnl1UVhQTC9y?=
 =?utf-8?B?Tk5ma2IrdjJzdmM0YXdwMEZXN2FraENtcFpuNDVrcXZudGRUc3l4czJKQ29M?=
 =?utf-8?B?Y0V4RDUraHlyZndHWXpYTXhFTnBod3lPb21ZYk9wQzdpckpJRUV0S3p6cHVq?=
 =?utf-8?B?UWFjb096MDl4UUcwMnQ0cWRJVDR5U3ZHblRzV0NQOXd2a2QxalZTTFY3ZHZh?=
 =?utf-8?B?NmJ3d0V6Y28ySG5jOGh5VWJEbGwvcyswVkp5UTFkWFB6L0NJdWQvTnRoanNz?=
 =?utf-8?B?NWFJVm1DUXdRUEorLzZvUTM2TjBHejlEaFJwcjhGM2hsVUVwYm5ucTZKbmsv?=
 =?utf-8?B?Skpobmxnb2lsR3BGaEI1ODM1YURuSFEreWZjb2pESXBuOCthTElnZ3BZTUFk?=
 =?utf-8?B?a3M0K3VzMVp5dmxhS0hCSTA2SW5kVEVBeitNK1pROU5mQnN3RGtaZjNFSWpa?=
 =?utf-8?B?c293RnNmNDRCWGp1aWF2ZS9RMDRhVm9kYnRyUFpabENIUlNLZTJqNFZLOUdB?=
 =?utf-8?B?VXg5d2lVWlNyWnJNTCtZNkJCc2hDRXNiaExVVVllcVUzWWI5T2cwQXQrOWli?=
 =?utf-8?B?TEFlWDR6V0xkbytEZWRSaU5obklaUFlwSUE4ZWp0eTJEN2ZpMTJuZ3ljb01U?=
 =?utf-8?B?ckp2bGdDS3JJaGRNNzZneTYxbDhIYXlteDNLWGQrVUwzbXFVaFMwZVZPMFgx?=
 =?utf-8?B?MmdUMXlDY2hsQUtpQ3dSM3lmZXFiRWRWT0d4RFpGZUNvQlRPNTdXSkdCVmti?=
 =?utf-8?B?NjhsSGZBY1JBbjhWYVUwMmlQRjVUUk8zVS8rdjlCakYvUHFPM1pPcjhYVW45?=
 =?utf-8?B?NUxZdFhtZVpuZytPTWttR05ZTW5vMlllajBMcXdTQzl4clF1SUsvcG45emN1?=
 =?utf-8?B?dHJ5TW5qcElFbHNrbW1Fc2JBK3ViS01PcStPOTV4cEd1ajA3Rk0xMndZZkZp?=
 =?utf-8?B?WXBCV1Y3bHFTeGp0b010RUFZZnZGS1NNeXgzRmdUSlBuM2Q3VkxhMm9kU21W?=
 =?utf-8?B?ek00QjN0ZWtPQzFHQll1YXZETmlhdXRkajc0S2ZiZEdSTUN6WDM3Qk43cDMv?=
 =?utf-8?B?V200KzdJWm50VlF4MUlLTG5WK0R3ZGJ3Q0tGY0h1Q2dzbXM1UmNzMzRycE5T?=
 =?utf-8?B?OVozRGlEb2dnNkxpSTI4SzM1K0RqNEh2SDFxbVBia2F4bVpYV004eU1QN04z?=
 =?utf-8?B?c0VmZWZxZ3R5SzkrZXcxbVNlQU5Wc05ZU1BCdStUNFJPSStjRFNrYkIvKy9u?=
 =?utf-8?B?T1hoY0VaQ2hYUno4Wm5xT3g4Skp1bEZDY2lmY2JsYjJ3aWlaalQxcVZ5LzdI?=
 =?utf-8?B?dXJrYndDVVpwNlF2MDFyN25DSDNKVjIxdHM1MGdCWVVBREMwS1J0TmtLMDRB?=
 =?utf-8?B?M28vbm1ibXNMR3BCWXhrMzNRQlhoZ2crd3dTTGpybG1yYjRGa0RXaGVseVF2?=
 =?utf-8?B?d3Bjb0hRRURGcG02ZXRQaDl1a1lSVEM0Ums0TE1IdStTc2F1V1hTUU5ZdHJo?=
 =?utf-8?B?eDU0Sk1rVTFQQkVFRFkrNDhKdUNsQTgxZWRmWHlHWXFVcCtvdldrYWhaajJI?=
 =?utf-8?B?YXFJQXA3ZzVJZHlrMGZPSitlNU00Q1VFcGxVV2tWdTJwcnhlMlhXaDE4OHVs?=
 =?utf-8?B?elpYU3FoNjR5TjVpdnZVaXdCM3hUd2V2WW91U201aFA1aldrd1JOTE5ENEFJ?=
 =?utf-8?Q?ITtHGh3LhJ0Vq63cKKFdtaegUkEx/vAblUGhKVVi6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53FCF3400E1204BAB4E745D08288CE6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08e5821-d835-4af2-40c7-08d9aa68b83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 07:54:59.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQMAYvBN5ISRVEIu/0EX2rEvdCp5CMSEfY7LFzzuo8SPoV1iCFLOTg2AbJvQ+hAQ0I+NbYCPzGFyL6jjRh5Y6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMTYvMjEgMTk6MzgsIEplbnMgQXhib2Ugd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gV2UnbGwg
bmVlZCBpdCBmb3IgYmF0Y2hlZCBzdWJtaXQgYXMgd2VsbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gLS0tDQoNCm1heWJlIHVzZSBudm1lX3Nx
X2FkZF9jbWQoKSBvciBudm1lX3NxX2NvcHlfY21kKCkNCmluc3RlYWQgb2YgbnZtZV9jb3B5X2Nt
ZCgpIG1ha2VzIGlzIGVhc2llciB0byBncmVwDQpYWFhfc3FfWFhYKCksIGVpdGhlciB3YXkgbG9v
a3MgZ29vZCA6LQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KDQo=
