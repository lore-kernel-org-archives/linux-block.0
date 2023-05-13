Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94272C77B7C
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 01:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbjEMBFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 21:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbjEMBFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 21:05:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC7A240
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 18:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0gZYflpmNQysVtRWIkrKK9Nv7JSfFSFLEhfjnCSTaRixzc8eyPNEV7lHtj4yo3RDGlMINJNCtpzbfBf5LjHA5YHsOPTgXs0BV+R5oB3Xk1C+uaZt/RgySrgf8VlweddH+B0KtG94QLdkI+KfNl1gDkfFxMWL+gg7I/X8Eh3Hv0b/up0n3GBRZUaQJzUfP8DMAabG/ybWY9iC7Udgeyv7TM8lX63QujTqwISrdRO8RK4v6aDOJXoqqqJeCcqTbbDI+wh1IjlebyCrwbA+bGdepp4kMJe+sPO2pSF6xEsG+mMlxXIdp51J71G9wFM8qn4ZqkYOmv+zzkJiq2JWc6I7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT0ERHIFuRX9VpQiV64ZuRCpDYhVXBSOqrI5JfOSn0o=;
 b=oGhXhetPyk/EXu0VZMFlqEpaDqlP4HBDx6wRR2vsqaOM1uoC5+0NN9sR7NqznzlS2XBYDCqcy1CGoFn2fMQn/gygOJZgFLf/lSNRldGvNLcn/izb8+NHQOzcS4HWb0ue+spPGVgip3yBMLvW1MYkcIe2TuMIvr3a7m94vTv88rYn5Qn6ffa82BaisCDwDEr/gBa4qITZr3yhTZQYTRFj2EqcV9NsO4zOfYwgIHV7Sk2u4Pop5KyP26u1RKSCNlxXRfoRhpi9Q/C5/DIO2sBWq5U21xFcPvAlV+5YZfOcNv0fpqucj2v3d3VY6o1CyQOD5cayoqU1Wb5irzKQJa9DNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT0ERHIFuRX9VpQiV64ZuRCpDYhVXBSOqrI5JfOSn0o=;
 b=if+KIC6nmcjU2OzOJn6HdGuBnGJey2VvrKuvt/kegbGpTJVQ3EmJXhlTgNRsB0Rj7F5nPtLZctOVQgACxiDHcXBd7CYRVK0mxASqHmVUlzJa9rmjhd1DpsOtzms7qa0g2fam8Wt/Mc5G5Q9SrFLEzM4YzPPkdr609Wh+T2wbDIt17Iii9guCoyi3xS8UBYie0rfA9HjwY4egC/sP9es204bmT9rYDWag6krD/+SLXAbJ48OzD1ffYTABQQLNyyz9GmbqNKbqkQGK0AVa3JFgA3cpL5R1ikQBQ5iKsJp0OXtQxlzzxR9LcWJFzYLVjt/8gJZtE0cQX3+1gmpIMtfbGw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 01:05:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Sat, 13 May 2023
 01:05:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZhKwGybbeYlqu5kWZNgFLfXlVx69Ws3cAgACxQYA=
Date:   Sat, 13 May 2023 01:05:40 +0000
Message-ID: <3f581dd3-ee32-832e-0f13-7e507a7ebc91@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com> <ZF5NssjIVNUU9oIA@infradead.org>
In-Reply-To: <ZF5NssjIVNUU9oIA@infradead.org>
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
x-ms-office365-filtering-correlation-id: afca41d3-8fff-4dfe-0eab-08db534e2b56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72clvBOAUVFQ34undIKKx79f+nKyfg6D21xMcWf7/WDORJMRYJMnAv77ahcHuvNP95SUr+sV+t47ajYUZpy/P+bzZ6CQ0de64dfLu13Q71rhSYh2KSERAE/hIn5KKAL+7cqvpHkYily5HlXUXTKf4BB6+50c7QTsW25EoZtBN5tEyJGWjDE8frvhn8LNGVF2FKm8AGP21a9OENpZhLHqctDzYpR41VnJ6OQtFfvUtMZNwlJOMcJKcl/d6Y/I4aIQ7CpwqoYMTVnQuymy7JoqieHiFwDG53rsRz3ZxEUKbczXxzE7rBMVKQgXJ+9/Po8T2M6tlr1nY8faZJ21fE8CclhdKiTy0J+cZpFCUbzd0msdFu8dHEVEQORkBqiXGVk8LTTbsbXXiXKYl2p2xSykEa2xvnwBDAnXRoVpuIL9RgDcu6X+0eQlhapr//Eh6jAnB1J/4V8zNLFzIn7DOON0KuCObr1a/ma7sCg3faaKLDI2HXlP4hcvOnKBWYH8DCpbqCsYQLb89hy1I22yKQtturb5mI5LzqqY7t3yCyQrdu0yHCo7jTKSgQ3w1kpXmkBK5JQpKKdLLri6chv80t6+2zChaFWnm9hY1hIDRvEWwXTyHzD8PnaSRd2wy0UTd8sDYwmxfC2mlL0AnhWkHzlnNaNPObrwlaB+dPRiuM/4deIBu6Mw3pqSYb9uO/SzkEcG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(122000001)(38100700002)(36756003)(38070700005)(31696002)(86362001)(5660300002)(6486002)(316002)(8936002)(8676002)(2616005)(6506007)(6512007)(53546011)(2906002)(66476007)(91956017)(66946007)(66556008)(66446008)(64756008)(76116006)(478600001)(110136005)(54906003)(41300700001)(31686004)(4326008)(71200400001)(4744005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVFY0tZV3NxUWtkZTFMaFRGR3lUVUZweUl6ekNZZTdJWkQwV1V0ejBBZlE0?=
 =?utf-8?B?Q2RUZFh1V3gvSGlMaWhjM1FLMnRxM1JrT3ozWmJvUXgvUWk1ZlJJMy9HdEJh?=
 =?utf-8?B?QTJYMzFxbTcvZGpvektETVdyS1VOWFpBbkFseW50Q1dVU05zMUZaUDZzTDUx?=
 =?utf-8?B?UnZLNnBkSG9kREN4SlVzanl0cE1NOTh6TWFldFhyR2VVeVhhdElDYVpEOHZa?=
 =?utf-8?B?d1Y1c1R2TFJUdnNidmdUTjVXcTFSVFlwWUJVc21EMzBmaHBvOUdGQ2JlMTBN?=
 =?utf-8?B?RVhobnV5a0VqVUxiM2dXQkxyWm54ajNnRkcxb3kwUFNxK3RzOG5TN0t6ZU03?=
 =?utf-8?B?dVJiNEgrZVdTdjJqVHF2Y1RXblFXc2J1bnprWjJOdW4zV25qVW5YZzIxZ242?=
 =?utf-8?B?Y0pvNDNyU01RcGtkSmNJZDB0S2dCQmFjZjJVQUZXTDNDK1lsRmdtYUEvQ2VO?=
 =?utf-8?B?ckV1ZEU1Vyt3bWNhcmtrTTQwTDAraU5GbFN4MUpMblNucDRvQjJaRWFkQURI?=
 =?utf-8?B?R0NMNWdiYnRoN2dYeDNLWldlRWVzcExCU1c5VXBJNHRBazRicmNFanNvY0c1?=
 =?utf-8?B?TEZKaVBkdTFzdndjaThKdXlEM0s1QVdsTmh1WTBSMFNyRnBQWVdYV3pvc1Vl?=
 =?utf-8?B?Q3Y2NkNTT2tiTGtRVmZHR2hYLzQrWkMyUkNQbGszOE4yRWx0YlRZQUEyd2VF?=
 =?utf-8?B?V1FZdkNMK1VmakRuZDBCeVJUdWFrNGdkRHUvaDBKUDh5aHdRU0RIeWVlRnQ2?=
 =?utf-8?B?T0h5cGlqV0xQcGMrekwzUmRRQTB0cXI3bE45OEl4UG56VXdLelEvTHJkYXdp?=
 =?utf-8?B?djFGdHhZWmlsRHlCYnN5ZWVSL01FMkdqQmdNSU9YTnN1THY4ZE1qYjNuMkVx?=
 =?utf-8?B?bGM0ck5ZSThwT0NpRnJzOWh0TVFPY3BveDNLLzdPL0NUb0lXOXdRK05PaWVr?=
 =?utf-8?B?T0d2UU96czNsK2c4WTlSaytTaXJ2SG5hV0lPY0FGYUMxOW90dW02cldVS0py?=
 =?utf-8?B?bm5IY1lHSUhsekw3dHI0dFZJcGV5NFhIQlV6cG1RM0ZYdnZQZmJSVkhxVnM0?=
 =?utf-8?B?MzRMQlZpWllnQUl2bWVPdDZ4Sm9uYzJPZjFCdGNRRnBtSFZIRUdTSnl2Ynkr?=
 =?utf-8?B?MUdwRWFuQktrR0t0T2lSWnFrRVVJcDFWdWJHZE9rQzRZRGR6aE9UUXU5Slhn?=
 =?utf-8?B?VWsyQ2lnN3FGUkxYbkM5QVFZdno1VjMzUlBuYmZ1TUpVZmRXVk5KTW1EOENy?=
 =?utf-8?B?SVBVQ3Flam1saXl4aVJZbmhKQTZsVGh4YjU4YmYyMWo2TTJBSVJsY3hTc3po?=
 =?utf-8?B?UUd4V0lzbFlMOTV5ZWVXUHAzYUJVb0docW9UUmEvVFdXSy9hMW1wSGVGYXBH?=
 =?utf-8?B?OWl6Ujl0SThhVnRIU3l0WGsrVEMxcUtCQ3NnbFQ5MnhPRnk1L3oyQnlJR2lB?=
 =?utf-8?B?Q1B5d0lvcFdWdVA0ZnlDY2UrQnJUb0gzM25JeFllcDVjd3ljZ0g2bkpXQ0pQ?=
 =?utf-8?B?ZmpmMUZjb0lrL0NQQkFmOFlGbEZ3NWpjWmpHVDlUMGpqdXNTd0dVTW9Ia2JU?=
 =?utf-8?B?Q3R2dkpLbGp1VWxNTlVReHJlcWZpT1YwdFJIcmtTeFhOWEFiRHplVUxIZk8w?=
 =?utf-8?B?R3hXVTVYTlF6ODkrSFkwZCs2MEIyMlpXTGwzejdzcnp3cFRpRmZOZDJINnRu?=
 =?utf-8?B?YjFZbWJXNUM3Z0tieFdlREEyTzNQMlpKaU13RjFodExWNEpURlBMejNPOG5H?=
 =?utf-8?B?alFOMFlkWldaWTRFcUhIbHdoM0oyM3dselZ3bktHb1dpOVdqS2svRTJvSEpv?=
 =?utf-8?B?dkprRlNtUFFKM2h0cUlVK280STkvYTVaVkh5azBBMm5zMlpDVWk4Rkh5K1lh?=
 =?utf-8?B?UnRmRHFRUExIMFZVVmgzZmlTZGorcDFEbVZuWDFjQ09zYytzb0pmWFVUcFpz?=
 =?utf-8?B?UndxbCszSnBoSWFqdm1RdnVhZzhrUTBFejRDb0lOK1NtZVJZclJVc3JkMFB2?=
 =?utf-8?B?N2Y2Mm5jT3o1Yjd4TE42czU0Qnl3T2ZXcnpGWi90eEs0Zk9oZkZHendjSEQ5?=
 =?utf-8?B?Z2FBQzAzZG0zNFJ0WGVkSjBxRzJNWWNrWjRaSitpOGo1SUdQamdUcmRzZU5z?=
 =?utf-8?B?RHd1aXRRR3dFTk1rZlYyWDZOM1N5REhUbnVZeWJBMEt6M003dkZHM1JOYWMw?=
 =?utf-8?Q?+cFxS14dq+7B0xY8KALJzvaLmsD0yCmlzWkP/T0DYpxC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32401DA33014594CA7378E5C198C4406@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afca41d3-8fff-4dfe-0eab-08db534e2b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 01:05:40.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbAcUxRhG7PSH7fxytj8P60j9/D1dq9/9Eu6Uf4c2WcMNbD4+l1BLx6O+m5vDYpfJrMSiNdOtmgZLwAhC+1Akw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMi8yMyAwNzozMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDEyLCAyMDIzIGF0IDAxOjI5OjU2QU0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IEFsbG93IHVzZXIgdG8gc2V0IHRoZSBRVUVVRV9GTEFHX05PV0FJVCBvcHRpb25hbGx5IHVz
aW5nIG1vZHVsZQ0KPj4gcGFyYW1ldGVyIHRvIHJldGFpbiB0aGUgZGVmYXVsdCBiZWhhdmlvdXIu
IEFsc28sIHVwZGF0ZSByZXNwZWN0aXZlDQo+PiBhbGxvY2F0aW9uIGZsYWdzIGluIHRoZSB3cml0
ZSBwYXRoLiBGb2xsb3dpbmcgYXJlIHRoZSBwZXJmb3JtYW5jZQ0KPj4gbnVtYmVycyB3aXRoIGlv
X3VyaW5nIGZpbyBlbmdpbmUgZm9yIHJhbmRvbSByZWFkLCBub3RlIHRoYXQgZGV2aWNlIGhhcw0K
Pj4gYmVlbiBwb3B1bGF0ZWQgZnVsbHkgd2l0aCByYW5kd3JpdGUgd29ya2xvYWQgYmVmb3JlIHRh
a2luZyB0aGVzZQ0KPj4gbnVtYmVycyA6LQ0KPiBXaHkgd291bGQgeW91IGFkZCBhIG1vZHVsZSBv
cHRpb24sIGV4Y2VwdCB0byBtYWtlIGV2ZXJ5b25lcyBsaWZlIGhlbGw/DQoNCnNlbmQgdjIgd2l0
aG91dCBtb2RwYXJhbS4NCg0KLWNrDQoNCg0K
