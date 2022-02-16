Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B5C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiBPJMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:12:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiBPJMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:12:37 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F5966ADE
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6fCKCMoPuuNwzf4QHf1AkzU/YDoSp2uR/2nqHfDzxjg8skbR21V/4eMMg/nZo1VFp483/CnhZkkARdnEJDxQJb6rIZ7Ij/OBrJXSP78HguBqibRAUXxThjjPBnp5rRPGqBROfFgLy0cY2lQrabMc7VGhJrOWdEle5C57AXF74yl/mtH9lIkzWjMOPRYr4uj7SkpG5RUvq6cZbJD0fAjuIoE4FGMEZBHwZXzHCdh7NX645Keofk4s7yoLYOq0u8B3es07clzSdp4A3aaQ3N08jseCc36dYY0qAT4o8ZTt8xjFAAHlLL6lZR3F6tRmPendufXqnE/HIQomuQQgjiXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUMVSn+dL0bMvHACHrX4jykZUWTSylIblUGgKr6cjZE=;
 b=nm0cBE/ATun81/Ox8j/K3FWCA4mgL1k+eHyrWIfqmMIi3O+KqO4BcFtG6LLWiCM0wr5+6IeFGZ6qtnflJ8vpjJUsyP8k4ud+gY0kVP1qUdcxGEoq140ftICFjFWUziDIVhzJrQd4QPh4nemy63v/LYnreecNzqOXiV+36ikVNbi/4yt3FZobAcQ3diEZlXv72H7yqm0kBsrQ/SaVGk7PffzyTtkLvgR2+5R3QQ+dy8wM8bw/F9vVCrpQS3b1Zw6B8tyfyAgyOZA/OIUPXAC9X8uGltWrNDtG0dS/au7CYwHCOJROYqkCAd4M5MWQNlLeUECyB3GAaHu0C3GIwh6k6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUMVSn+dL0bMvHACHrX4jykZUWTSylIblUGgKr6cjZE=;
 b=oYGzK6SgxPtf5X/OX0LSG0NQbOdwzyNyjzhnkWYlk75EpmI+5M5XKhJJbR5FOufR7JeUZed9/Jd7uYoLL41hzGGWPJps8Jvz+sSUe17ZjOz1DDyZlr9l0f64SNrNxzWMaEUyhdBsY2sVDMFIoNHiyRYh275I2VqiAL3Z4pKpjJiZuVjHbIbsBC1sfW8vuTDdeaVDIKPzriwcFr3vuc4/rbDtrMtMhUoQrGLbSBzd+QmO3YMH1KqKxr1L73/ZruXgzXvlWq0VTUep6htsOB9oIJ97Oy7hAy7OgkgdqT47pZRyvYRvCUfxo8JoxQ+y7Jw4iz8oNjjNA7m5S9Z86ET8pA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR1201MB0069.namprd12.prod.outlook.com (2603:10b6:910:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:12:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:12:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Haimin Zhang <tcs.kernel@gmail.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in function
 bio_copy_kern
Thread-Topic: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in
 function bio_copy_kern
Thread-Index: AQHYIxE0/IIgYxhY8EW3m7YIWmu8s6yV5HiA
Date:   Wed, 16 Feb 2022 09:12:21 +0000
Message-ID: <47002290-3064-7de1-25e6-0716a89b94c0@nvidia.com>
References: <20220216084038.15635-1-tcs.kernel@gmail.com>
In-Reply-To: <20220216084038.15635-1-tcs.kernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0800a30c-ae1d-41fd-5e13-08d9f12c70a9
x-ms-traffictypediagnostic: CY4PR1201MB0069:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB00697E1195BEB8468F4AE896A3359@CY4PR1201MB0069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DM8vRnGLhFROgo+yPcltW0oWkEv0dg8wFqy6409Ca3g3wSXzVNgxO4nI4MHRg2g/WK/pv4+xqrhIo5fmYqucOD3O93DVif51WkKU9YzfIdXr/OZfL3Jvc/n7kxqXLUCVKb44GOsg2CWyZdDbbxfJFwadieChHNw0uTd+ITFYkeEJaES+NvF2mvsJwrgB75XGmBemL9e3a7MPh9E8l/BZCQvZi9p6/Ut4R3fh9S9NFF34xICfWZsT2YLZgv/ydbKufjS7G5MZs8z0aWX/lNz32BNvQcF2k9jUMnoUji/7cXaRJTItTP8HQWwQCRvSJKBR9M6MyDlblksvxl8r0XMzvhm+iyIaP9z+AiMst37o7wCKM73o5dwE7rRtpMqdr6pVL3gCl/+ipskwpctmbNXCK1oiJahZJEWoqEH+1OnIb+38U30n0JJpjxR6kWmUdJSekOM1wgCDb+zFpEwGfBWXpBivAZEm1mMarZbTdlwbIAJ7sVFW/a2L31G+6CDZvDQEGbDEHjiW+i163WCvs0dSB+/czssFtknREfSXYLBhb5dmT1aZ5MuhgzeObgVfBXxdlTp3EJdQBRCWEMSLZroWd8k6tnpiCs8Pxto0xPo9Rb2LSCGCjFVLgbFQ1qz0yhAzE5jvVhAQG5j4kBtYTJLmey2DzhRtccgJba4BYLgUA7kyuw9/REcXnQg2nmZKCrRlV6PsQZ5243/iY4d6Q9jNV5ltsgFt+PWRoCXHRjU5roOIxYB9NscXkjSGiolfX5Q0RKVh4TVBNMRxkoGb+pA5OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(36756003)(71200400001)(38100700002)(54906003)(2906002)(6916009)(83380400001)(38070700005)(316002)(6512007)(6506007)(186003)(6486002)(8936002)(53546011)(76116006)(91956017)(5660300002)(66556008)(2616005)(66946007)(66476007)(4744005)(66446008)(8676002)(86362001)(64756008)(4326008)(508600001)(122000001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUNsaUVBVE1tUDhoQzdrTlB0ekVMTlgzMnA1QXRFVE9EbzZxRFpIQU0xbnBV?=
 =?utf-8?B?ekV3RUViNk1qYmJDc09CZUVvUXpZM1A0TG1xd1FCWUFNczBMZ0NQTnJHNTE4?=
 =?utf-8?B?UmpwcXRvck44dTZvTW5wWEV4Rm5xK1orMlVBeVppU3dxNDIwaThQZEw3Zkth?=
 =?utf-8?B?UnVWNExvcy9SK2tBSGJveTBNcGZUdGQxN3c1WGNWd0hKUGhUcU1tSWN2d1Q2?=
 =?utf-8?B?VC9IV3F3SU1OTUpzUDVaNXpveU13R3JBQ2FNRkVFcjQxY001N1JPSzBoUGFt?=
 =?utf-8?B?NkkwMVZwc2pudHZSNWExNkhUakh6OFE3YVBHSW05UTRxZEdWRExvdDNFQXI3?=
 =?utf-8?B?RUhBMjV6QzBPZUc1V3lzbkxpdkR0UCtPZk1tejJmUi92eG5xajNLMmVveGxH?=
 =?utf-8?B?OWt5TXJnUlBBb1d1dGJpQmJhZ2s0S0tuMHQyR1Fwc1RmM1Q0dlNMSUk1b0xx?=
 =?utf-8?B?bEdnbmNkK1ZVRzFjOVdGUWRoTmo1TXhiMElJeU05eUNVbTVoMWoxeVFBZG5V?=
 =?utf-8?B?MUkwcDN5eEk0Tzc5SDlYaUZzTTVPRjQwU1RIOHVGNWhGY2lsWXYyNnZIbG8r?=
 =?utf-8?B?bXdzc1JyS24xK25XdkU3RTBibFVEanNMMXQreEFmb21lQjNMUkZySHlUQS91?=
 =?utf-8?B?ZUNFOExDYWkxNjlMamVSd09jdTY3MFZsMHFna0hZN29IUUlmU08zU0d2WVhV?=
 =?utf-8?B?WTRKdWgwalFlNStmekFheXVWblc3ZXBmQjAyRkhxYURyNUxpVVdrNW5HVHlS?=
 =?utf-8?B?dWJLeTdnNnFPelVZRFJtbnplcE1pYlRVVTZ5SkZ4blRSV2FlbnRLUWhRS2Rp?=
 =?utf-8?B?bjFieUFPenRsT05MQ0dMTHhYSDUvNXY0QXdZNWVpQVFOVFJzUE5TdEJyY2ZX?=
 =?utf-8?B?UUhWUzVQUmR1UFIwOVlvQVRtWktsTkkyR2JvMGloTmV6Ni9QRGdCbmpVTmhk?=
 =?utf-8?B?ZVVkb0ZKNUs3dFRiV2tmeW5MMVJCVy9vemdReFF2ZmRDY3NKVEtkcjIrRU9l?=
 =?utf-8?B?dnJ3L3hRbnJXbXRzMmIzRGlnbS9vS1hNZyt2SUpuQ3pleWRUMkN1Mkt2eGFu?=
 =?utf-8?B?cHU2SFBWd1VZd1JyZHg0SkZIL2NQc3NpbFRYcUo2c2hWTzJGL0pDVGVOcldU?=
 =?utf-8?B?OEtHWmlodWxhd1hCWm5sdENGQjZ4eUdjeHprQkFQamcrS2xnQ1lwWE1XQTF4?=
 =?utf-8?B?d0FPT0V4SGd2dkQzUms3N3RWQm9KNU5taFQ0SkVIcVkrdFpxQXBVa3hXU2E1?=
 =?utf-8?B?K2ZaWGdDVTYyUWE4OUthMncxOUswMnJQdmJwVkdOQTlrdjlIUURCa2ZybWVr?=
 =?utf-8?B?bk5PcFlGU0NuWFNxZ1ppUGtlRFN3ZTJvTVIzRmttckg0U0s5bGVoUTZSZHJ2?=
 =?utf-8?B?dGQrMzRZNkN3UmVybzc4QjQwM1czaFdyWU9wdzdaWkYyOEZ2Szc0Y3lhTXA2?=
 =?utf-8?B?YlJGaUdGWDhvcVVBTEZEWUVNYW9FeFlnRlkvbEdrLzJZWS90MzNqYUFLV1V5?=
 =?utf-8?B?b1kzRXdrTEFjWTlWY3gxUlovOFMrSndrZU9qZ25lTkJiWk5oK0RCOWlac2Nn?=
 =?utf-8?B?M3A5WFd3WS9hdVgrOE9qemRBak1OVFhiZm9LNnhiQ2gvVTdZbEZxcGxSTEVW?=
 =?utf-8?B?UXozTlZnNGJacytaVG9MVFFsMnRQQWtqS0FzVVJNZE9NSFFQaVBzZ2ExNm1j?=
 =?utf-8?B?RkNQK3RVSTBNNitYbWpIRy9HZW1CR3ZxaC95eENBbFRBMzdSWWF6eUoxa2Ew?=
 =?utf-8?B?UGx6V0FXTUg4V1JzTnRpYm5lM3RCSDhoUkFjeGt1U1dUUjAxVTkxMWNqMldN?=
 =?utf-8?B?S2o0Y3ZGUlh4RUc0TnE1TFZLU2Vpa1JORkFFUUUvbml1VjYrR082S0w1MDRa?=
 =?utf-8?B?UDhmVGNRUm9GVWdsVk5hOHFnd2hBbnFqS09NNkJUMkJuci9XTnFMVmRQemlX?=
 =?utf-8?B?dVFHTTEyeW9pMWxvdGx6SE1pQ1ZwVlE4aWlYY1NkQlpjQ21CTHhnSUJZS1Nm?=
 =?utf-8?B?aldEVm52U1BrdjcxblZXOVd3cHJlQ2haOXp6TUhZYWpRU0JPbHRaODZMYUE0?=
 =?utf-8?B?bzBRemVlSk1ObkV6ZFhnL294NzZHRkxZWUFIUzMwUGdKWmgyWG5wYmhpR3FX?=
 =?utf-8?B?ZkNidHV2VG1TUlhHTzRoYnAxYktydE1qdFQyRVIza0FKMDNpZWFoMjFBa1VU?=
 =?utf-8?B?TTgwN2w4YXRkU0VzZ2FYYUkyeTMvWHN0VVFaYThVUTNFdlBrMXJlenYvR2Rj?=
 =?utf-8?B?ZkhuOXlPRkVuVE5JUEl0Qy8xeDFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F986B69AB8B5CC409E22E6A3432042EB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800a30c-ae1d-41fd-5e13-08d9f12c70a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:12:21.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89PEBIkl1PLpZ/U8m4vYPZNwKq285nbV+gULasTXrun9NQ8//3yZGpym1rZ5Ydm7b5Kh0IQ/B0w0KpNQ8OG6JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0069
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNi8yMiAwMDo0MCwgSGFpbWluIFpoYW5nIHdyb3RlOg0KPiBBZGQgX19HRlBfWkVSTyBm
bGFnIGZvciBhbGxvY19wYWdlIGluIGZ1bmN0aW9uIGJpb19jb3B5X2tlcm4gdG8gaW5pdGlhbGl6
ZQ0KPiB0aGUgYnVmZmVyIG9mIGEgYmlvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFpbWluIFpo
YW5nIDx0Y3Mua2VybmVsQGdtYWlsLmNvbT4NCj4gLS0tDQo+IFRoaXMgY2FuIGNhdXNlIGEga2Vy
bmVsLWluZm8tbGVhayBwcm9ibGVtLg0KPiAwLiBUaGlzIHByb2JsZW0gb2NjdXJyZWQgaW4gZnVu
Y3Rpb24gc2NzaV9pb2N0bC4gSWYgdGhlIHBhcmFtZXRlciBjbWQgaXMgU0NTSV9JT0NUTF9TRU5E
X0NPTU1BTkQsIHRoZSBmdW5jdGlvbiBzY3NpX2lvY3RsIHdpbGwgY2FsbCBzZ19zY3NpX2lvY3Rs
IHRvIGZ1cnRoZXIgcHJvY2Vzcy4NCj4gMS4gSW4gZnVuY3Rpb24gc2dfc2NzaV9pb2N0bCwgaXQg
Y3JlYXRlcyBhIHNjc2kgcmVxdWVzdCBhbmQgY2FsbHMgYmxrX3JxX21hcF9rZXJuIHRvIG1hcCBr
ZXJuZWwgZGF0YSB0byBhIHJlcXVlc3QuDQo+IDMuIGJscV9ycV9tYXBfa2VybiBjYWxscyBiaW9f
Y29weV9rZXJuIHRvIHJlcXVlc3QgYSBiaW8uDQo+IDQuIGJpb19jb3B5X2tlcm4gY2FsbHMgYWxs
b2NfcGFnZSB0byByZXF1ZXN0IHRoZSBidWZmZXIgb2YgYSBiaW8uIEluIHRoZSBjYXNlIG9mIHJl
YWRpbmcsIGl0IHdvdWxkbid0IGZpbGwgYW55dGhpbmcgaW50byB0aGUgYnVmZmVyLg0KDQpidXQg
YmxrX3JxX21hcF9rZXJuKCkgZG9lcyBhY2NlcHQgZ2ZwX21hc2sgZm9yIGV4YWN0bHkgdGhpcyBz
YW1lIGNhc2UNCmFuZCB0aGF0IGlzIHBhc3NlZCBvbiB0byB0aGUgYmlvX2NvcHlfa2VybigpIHVu
bGVzcyBJJ20gd3JvbmcgaGVyZSwNCnNvIHlvdSBuZWVkIHRvIHBhc3MgdGhlIF9fR0ZQX1pFUk8g
ZmxhZyBpbiB0aGUgc3RlcCAzIGFib3ZlDQooc2dfc2NzaV9pb2N0bCkgYW5kIG5vdCBmb3JjZSB6
emVyb2VkIGFsbG9jYXRpb24gdGhlIGdlbmVyaWMgQVBJLi4NCg0KLWNrDQoNCg0K
