Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C8C433F5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 06:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C4F6117A
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 06:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhKJGka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:40:30 -0500
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:48832
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229731AbhKJGka (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 01:40:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/6wJMwcHCcBQnOIiMOikqBqCwqVWe0xQC8zCUC9mmpOzDcACxLS2XtO08EGEZiAzXyP/CH/dgzEE48qZuWW9Jnot/Dmf+n39XzA80Jmxcpsu/dveihKacmgVNhN9RIpWv/hy0lbdPD1AXol1R0IRGvKdSCqf7aPVe8OHHWGY6Zn0F5ybwnfhE+HfYpq7VDh4e2ICOL2svsFG/NDnds+Kn1ZFJ4UZhX8SXfFKX/7fY4tNUgYnTcKbKG03uhu/fe7D2GeHDiKDJHXrjp+1WFXIW7dy/jCRwzcnPA4cl/L9smnW6H3+fq977RZrxakUnaXYpUz7IK5I3jMVNIYX00HeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a263IcMCMuHVLjqcDOnmtBXCjhU1awMu59Hp6tgZEM0=;
 b=DMquNikdz2e+xNSrKKbZTj+mCzLzDB26THMi5Tqb5F6c7aXKqWgiryfOKdMWdx1QCrwqMlD+epVLNyobPrOVkFPft2Rp+XkTq+ypYMxz1/23yCCiXKv6hJTeoyBxQIF+RWRr2bSt/P0Mo5iQPq4UJ5YCRyTO40ayou+zKTTzQh57M44MBZF35oM7natHx1spg33Rl5b1DMu+6PNvHYLRwd3Ho14i3R31ReOqPqoRIOPlPM+1h098mqsYReDiiYf8erjsY58Avn14HC4mcX1ONStWhOxqIWeVRXwiFitwXbEIbt4Jg7HvCz22rKfwD6OqocNw7pe3zd2OtFXJva1B9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a263IcMCMuHVLjqcDOnmtBXCjhU1awMu59Hp6tgZEM0=;
 b=E5OTA0JmFrLeh8hHihwPynD6wDNtSvW6OhGvVT2xugweVzDly23FzdSF3D75gNpu3uTLa0Ox++W0YMwpyLH1C6m0Pmd/GiHSzwTu3rQvpMFOWITCMtYQF+xFTj68J8rwkIimcwT3Z3gBGpZOJSuENnwDwOHf2MhTzHvvA/4zCJGmvIchizRZbRNPzITtlymVFInYO+3ZQIjWZlQSE0aZxcWgNFn4uiJXdrUAwMXdlRSsXfMft8gP9OGTj4Mwy4Y65V+icN9WJ8Z75QZkG53MaONIG/7BfLZLLQBapvxVBbV0ePSmVfVqbUv3+/q4n55ZSWJri0iSB8eqG35ieb0HWw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0016.namprd12.prod.outlook.com (2603:10b6:300:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 06:37:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 06:37:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Thread-Topic: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Thread-Index: AQHX1VdH0Pclr2/Y80CWqxAKXKRRwKv8UDqA
Date:   Wed, 10 Nov 2021 06:37:39 +0000
Message-ID: <6181461f-ba46-f277-2dd4-683013122995@nvidia.com>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c068708e-73e3-4f8f-be4a-08d9a4149725
x-ms-traffictypediagnostic: MWHPR1201MB0016:
x-microsoft-antispam-prvs: <MWHPR1201MB0016989C67D1E383E8315E8EA3939@MWHPR1201MB0016.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Q8WoeJmMDx48f2OZAhSxJiPbrw85rVFtjk3ct092gn1DlCe7V+90DtOq1ciDVomZyz/vUHUTAgoVdguKts5BflhqqPjELzB+jrGm6g3IlzPZQZRhqOi7+cZgQppk2K/oGP8n8WYiPNrF+NVZ5xoZlbFxcyiZ67pa8tV+BJEr7jzw+k/Cba3nmTABsKg6l5SjmU+pbIR5yYOkFHDe7hIFxqMQFUP52aAD2bnBNSQvPI6Bmp39LgV52TtLD/u/2GP8i6Stq555ZHUqduriew9WuFWfA/qOxYsOBnYJWU8z1rap5tV5DzmC8DZrKRIrcU2LGKP3mZJaVwIAqNthyj8n2Xr4PP0Fe2Tff2r7zVMejGeue3x20980qxyutFMhayD7tNzfXV31BVpHYTfuS4AXAsItpkqNWpdn0sLprGeA2ejk7CLH82oBrzAM5HBssuvzBGGxg6x7lUl/evq/3cE8MCBUShv8W8UEUVJjbvZOmNF8pfJblo044mnvn4iCaMo/XG6stS6auuGckJhDRjWgH3ed8YEExXOOE0TxLIuZO6YYShiWu0sSlSzw2QqNFo9IqDBWux7f16EJeUy2nxCCFjhgIflzFL0eRuOSvC5+1IihoEik9PY7olIMghd6MDX2b3/0Tdd98BsNOShLcbk2iAH4QLO6k7l6OKldQcse2yywKaVx7G5nmqEeCdFSK9wn1I1Yf0eXQmxsqipbf7DPouXtPkcVZCT3u5RcX0T0D5/ESZzzAFvqZM0k8+5BO4VzWtjVg8cjyiAQoY4LDGGUH+Y31uhMbXUlNFLYp20Syvl6l7CgXszLq4ccuMttt7eBVxTNLrBjdZalmLkVwfCQX0CtL5zmit+tZMF2/jWb6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(508600001)(966005)(8676002)(110136005)(31686004)(6486002)(2906002)(8936002)(4326008)(4744005)(5660300002)(86362001)(38070700005)(76116006)(6506007)(66946007)(66476007)(66446008)(53546011)(31696002)(36756003)(66556008)(38100700002)(122000001)(64756008)(6512007)(186003)(54906003)(83380400001)(2616005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm92TmJXMC9jbHZiNXBjRUtaQzVmWHduRUcxTlQ2cUVXYnB4c3NUVUM4QUZK?=
 =?utf-8?B?S29tWE1sKy9OU2JJdDVoTDJrNExha1lwVzd0LzRIazQ4L0VrdW1yMGtPZ2VL?=
 =?utf-8?B?RTBaSDkxOW1kZUdyenVJSktJNEdGRE5YMm5TenhlNXkzeWxDSHRBSVFESW9U?=
 =?utf-8?B?bEpKZm9TbGdMNzNSRm9hZGdDbkhialpsTG94WjI0eTJwSXdQWkwzcFFaVjgy?=
 =?utf-8?B?eGRjY0RhRlp5YTJGbkcxaU85bkwyNWFBUk5ld1JpMndJNnExZHEwU3BKcDNQ?=
 =?utf-8?B?REo4UHFadmdqT0hRMXppdTBmVEkxejZLK1VkbzdXNDVFSGJSMHRDNnljVmFh?=
 =?utf-8?B?WkErMURkTkZVWjdxU01RNklmR2xhb0dOTk54bUxKQmVNQXBVc3lBeXNnY1F4?=
 =?utf-8?B?MFRJMmdPalcrbVFiTU90eUxDNlNnVzA4VnVjL1RzSVRUODBzdlhaOTZtL3N5?=
 =?utf-8?B?TjgwRjJxaXB2eHo0YmJuaUpKV2twamVlWHVCaFlUNWV1bWRtblo1eHJSZFBi?=
 =?utf-8?B?blg3Q3g3RTVIMXQ5UlpwTk9rWG1IU2syWWdyTHJUSnpqcW1jZFgxaHhBOXhD?=
 =?utf-8?B?THl3TWtxaFhqZUszQWg2SmJKb0pmd004V3E1dk5URTk3OHY3bnpjRjUyZ0pR?=
 =?utf-8?B?bHo2SEwveE1TT0lHTXFET1grbjJJYnF3YmxtaWNhaDF0NDlDdTdFdWl2MjR5?=
 =?utf-8?B?bkRqdmtqK2dyYlR4eDRzT1kxaGJ2VktRU05NNkZIZDBFalg3Unh2ZkRkNUxD?=
 =?utf-8?B?WVgxeDJ3bnFyK0R0UmR5SjBxT01RRmM4RGlyLzZOSXAvVXp1MmYyeng4bUVp?=
 =?utf-8?B?Vy9CZGNaSGpUbWlHSjFsQlVmL0hCTTBqMk54NzBDYXRucU1YeGtBLzdBU0Zk?=
 =?utf-8?B?SnJVOFpLbm90dU4rUnUxbHF3TTlFVHM1c0JVK1diLzR1Y3o0aVMyK0VqcDV5?=
 =?utf-8?B?Q0FoMlRydkNvbkZZcHFiWEpyZGxoYUpxZEhYa1NCYjNzWE9pSWdJa2IxekJI?=
 =?utf-8?B?UWVDSUlhTFlpRWw3Q2ZVb3BocXBUbEgyVXBNOHYyNnpUdXhkcVVjVEtrblFn?=
 =?utf-8?B?SUlUMDdZenVGRnVOYUtKeldldzJuSjNmdUtEcWNoTzJQb2d5MFFRSUQyaEFi?=
 =?utf-8?B?bEk5TVp6T3U5T3htWG5PdEpNRFlKK1Y4YytzUWVqRnBFQ2cxMU5zM08rY1JM?=
 =?utf-8?B?OENWQmhnNUd5MVhkazBvcWEzTk9jVkRrWmlDcFQvdjlPRS9SVDkyc3ZKSXNi?=
 =?utf-8?B?d1pVM0pMeUpNdW5IalY1Ni9yMnlPbWtXV0VEWWJpNk1NMUNibXVGQVN1YTlQ?=
 =?utf-8?B?dUwxUzBvQ1oxeXp6ZEw1bXNTLyt6N21KVUtxVEJHMDBkaElIaktPaCtsTEpa?=
 =?utf-8?B?UWdRNWs3SXV0M0lTNUtyQnJOaTlwSlRvVENvSG5UZWt5MFdEZ01iM3hEdHpN?=
 =?utf-8?B?Z2NBQnZmZ0xNbS9KZW1wYllDTnl3bmIzckprM3VUVUN4WEpuTldMV0NqNTVC?=
 =?utf-8?B?YlM5YWR0K3g4bFBrV0h5ek9mamJIQ3UwdnRJbmRWYTRKbHN6a3RwT1VQS2hi?=
 =?utf-8?B?N2xZcDBHKzdLd2JKSCt0ek4xKzlGVGprUVVUU1kwcjBpUFVxQkFtMTBjUWox?=
 =?utf-8?B?NDVGNmNxNEFjTW1CRWZBN01UenRwbTd0UW1iSWpHaFJwbnpBZ2VhVlhtVXF5?=
 =?utf-8?B?UEphNDRHQzIyeldZQjI3OTQxWmNVOXUyM2ViS2Q2eURPV1FPU09adWFlR2RP?=
 =?utf-8?B?aWxncW9WSVZYT3ViUWJ5NlRTZThaT2RYellLUURRVU5iUmtXcTdJZmFobTZH?=
 =?utf-8?B?b2Y0RG9uMkg2N2xZMDd5UCtld2laZlF0Q1pQNVdnOFhzbStqWXpwNlhJVzFB?=
 =?utf-8?B?cjEwVHY4SHhJTHNaR292R1NHRy9yQ1NDcmlMTkFOOTBLZFYwNWd0aDZjQzQ2?=
 =?utf-8?B?ekRjQ1FHSTlNczluZXZmN1RRN2U1YkJPbzJYK2p2ZUNkVnVmT0lPbzRsNmxy?=
 =?utf-8?B?QTF4UUp0SmJJaWI1R0dTVldHNkZyN2FpZzIxNnExSEhYOEJRenJEaUoxWnhw?=
 =?utf-8?B?UXJQMlZvNEtUSFdoMmU0RnhqSEJ4dXVnaE1RZ3F1R2Rja0FxTE1JUUNYWDVH?=
 =?utf-8?B?TXA3NDFMZkFCbmxWb2YzYTBPMk5VcXpnMzRkaGxTVnZXRzl4TVlUVCtBWUpm?=
 =?utf-8?B?M1UyTVVDUmtoN2xQVEoza0NNT2NybEt0YXdnVEx3UEZ3K2h5Q2llQ2pRM0k3?=
 =?utf-8?Q?b+4VgKCM7gyGsSPJ/eZu4psDEkrne2JrhBa84hwu4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FD6175B2DD40E4F875581DD587729BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c068708e-73e3-4f8f-be4a-08d9a4149725
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 06:37:39.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kl8fnAu0uegR4HlRzt6XYxxAxW1UzlB2nmmkw1YIIaQuBioQr1sF8ytulgDG43RhmcQ9NxZCczCy1s+TwXfsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0016
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

U2hpbmljaGlybywNCg0KT24gMTEvOS8yMDIxIDI6NDcgQU0sIFNoaW4naWNoaXJvIEthd2FzYWtp
IHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cw0KPiANCj4gDQo+IFdoZW4gQkxLRElTQ0FSRCBvciBCTEtaRVJPT1VUIGlvY3Rs
IHJhY2Ugd2l0aCBkYXRhIHJlYWQsIHN0YWxlIHBhZ2UgY2FjaGUgaXMNCj4gbGVmdC4gVGhpcyBw
YXRjaCBzZXJpZXMgaGF2ZSB0d28gZm94IHBhdGNoZXMgZm9yIHRoZSBzdGFsZSBwYWdlIGNhY2hl
LiBTYW1lDQo+IGZpeCBhcHByb2FjaCB3YXMgdXNlZCBhcyBibGtkZXZfZmFsbG9jYXRlKCkgWzFd
Lg0KPiANCj4gWzFdIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWJsb2NrJm09MTYzMjM2NDYz
NzE2ODM2DQoNClRoYW5rcyBmb3IgdGhlIGZpeGVzLCBkbyB3ZSBoYXZlIGJsa3Rlc3QgdG8gdmFs
aWRhdGUgdGhpcyBmaXggPw0KDQoNCg0K
