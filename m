Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6CC19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 09:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiHGJ0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiHGJ0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 05:26:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62023B1EB
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 02:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X47wZmBCOoqIInAJkxYFq0YKcca6ydry2QihNOLcNdDzEGzWc/WDn/WAGS17rcVqsE5Vv7lZIHBmCbJLOA5UVsCxDerwdI2ULy6VDO4Ml8gVKeHSkF6YQ9ZGZoDaHf7BAXlyqk/axP9OPQv92WfAr6XRuyzPv9arylvmPP1I34x3JI8AT7dd9QfsdaywDlpqDbasHDSuEET+PDGdJcNP+9GPXaJ+J6eiRiO7mgZiOJcsC8Nbo0itohU5xDJS2Anbv0B8WK1U2mYlnwxeYvcjCesfVADUwXp6uWzwo2T8ZQr9kIf1DmCMcXY4XpqbeLG9zLgoNykO9VvYJCRTFBr8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjORiTiipSmM8TBI0zaYMdKGW5j2z7gP8NJdthuarkU=;
 b=FyDAoVUTzM/iucXpzNXw+beHDBe6mgmtIy4Xccj1DUxNbn5CC/r+muDtHdHoVH46NT67Y6wkkhWKLdePu8izyloj32tEnEwjsqMDcPgPBX7Nwd7TX/BZoHZabphXWHjGtclc4uNFwFD8EUSJGaxzZFiuno15AtvQuRDxld2YQgKKF5q4oO2J6UpE2Yv/zGmq0vccj62hqytmk+rYs5TxZmePdFV+dU2t/mU/msruLsBrXnW9zTe7Gt9msF+8XnatjZxmLQNIr4JwuA8fBt2H8RnqMpaCjr9gD9wuLLFKrYRVE3PrxVbHc6jLfvSzDn7fqIvS01clWYxVaWuQ6WEypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjORiTiipSmM8TBI0zaYMdKGW5j2z7gP8NJdthuarkU=;
 b=ulroMerC8Ky4o8rykCU+6mcTMXLZ40Dx4zTX4fJDyolp8o+taZiGVv1UJFImQ8NaiKhcCHBqoj00i0S72ipi/VKXgSjR8vWG9FBcaCFfhdk5T6W2fPWvrm0asj6Bl8hBar+wjVyK+XJPSxTTytmylfN2uBMs0p14zPLlCh8yIgFbTbYZJGUwfiK4KUxcs3og3ZmP0PLavWI68UnSYhkzMBdWf2bhTAaghA19wBF1kiBNkFkP8i1BSygEbhBbxp02pOqvNg0m3LVv5J2+uqAXc7cEdR88svvI1amkm2/5VkvDpo65+QHxjsgo9s+3k3gvgZr7BwHR7JVSNljkNc2CLA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3545.namprd12.prod.outlook.com (2603:10b6:5:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sun, 7 Aug
 2022 09:26:33 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Sun, 7 Aug 2022
 09:26:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] block: shrink rq_map_data a bit
Thread-Topic: [PATCH 1/3] block: shrink rq_map_data a bit
Thread-Index: AQHYqagGcTFb2zkaVk6sJpaQGoZbO62jLECA
Date:   Sun, 7 Aug 2022 09:26:33 +0000
Message-ID: <b2b935da-7869-71ce-105a-ba1b1beee8c2@nvidia.com>
References: <20220806152004.382170-1-axboe@kernel.dk>
 <20220806152004.382170-2-axboe@kernel.dk>
In-Reply-To: <20220806152004.382170-2-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00dd5eb4-3e30-4fd5-82e8-08da7856eb33
x-ms-traffictypediagnostic: DM6PR12MB3545:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8eqQ7xHGGN5AURH800hjAeFHBCwYV2UiWTsgqYEo7gtikHsv9rRIk2pBFuc+tkBxHuQOoGr/7y27B0U3TW35RyFmCB9c78iOAKB8fguLoJ0ITjpBW11pyWoTCu4ShZkYf2nZhFnrVgg/XDhel14uxIe9M9m86rBXn48zCKbB6ScO2LprVv4Aq4GCZohuTizz4oriaezPeafA2C+a0kLC8q8ZqiWOUpG2ZsryDh1ltXmfHO2xWf4OY/Q4GdtzJESZq7C7pGWYefpjw8HN8JTuc5w6UHUW8358LeDJNo13tYJMqjpVzFimMg2G7VgSuzh513mYbHeFCCYjCW+ESzYSfogX6bsSCiSt9ygUUIPmpzRCL37fWX8JMhJtBunRCVzfq3WwuqbYFjIodSgpebKFDYgNI4d8JcyZ0SGbaGSl2SHQa8TP04F2Jmnzr0zH2RyAcJSGuaEaFUXbYungNZvdE75XQsH1p+mEx0KDu/B9kjs2LyLgMu//h1LLqHtr6pYazLZs1WDsVXl1vcqO0U2phCdImnsN0G1k6pgyIsOr/Ob4Hv2jX7cj6Cnc3I20221HzSsjX3sYBvwYl15DeYC4zXxumvP5pN09faOQt2S3Xc5rsmIBtgDI38ARdUsddjHPQaicPRpmjjCQRyhcZOKDP9ck22hdX+smw8lEvM17SxGAZyTPpIsTnRpOOo8LjeFoa8nSuEg8GMU5iGyszsctjp2rMBz/j1g34z2Ay7yiBPuGxQ4LqNnjGoRGjEw/KgA3PGnzeyVh3XWnydR2SbouaOSxD3M0XAqjdI06s9MHxQQNjggcn/y5schWCP0te1OU3YRO/GgOGSCC6fv4AcHro3kE+lDoi1IqURP4YM1y6Bj3j+z2GTxQdMMJDjNorecf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(76116006)(66946007)(66556008)(64756008)(5660300002)(66476007)(66446008)(8676002)(4326008)(6916009)(316002)(54906003)(91956017)(86362001)(36756003)(31696002)(4744005)(8936002)(2906002)(122000001)(83380400001)(31686004)(38070700005)(38100700002)(41300700001)(71200400001)(6512007)(478600001)(6506007)(26005)(186003)(53546011)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3p5anlIRnRwc2xrbnEybEh5NVhMR3RmUnRYQXpGN2ppMFM1UHprR1lsRTcr?=
 =?utf-8?B?UmRqTXlIdzlPbm5mczRhakIyOHcvR0hzdmlJWThQcllFb2lZV0N2THloalov?=
 =?utf-8?B?MnZBZ2ZzQUt4d1YvM0ZXOVIrK1NLdFFZS2xkWkI4U0J1TU9PWldHOVdGeEhK?=
 =?utf-8?B?TksrTG9aRVl1UDJQVSs2akZuUHlDTGs1eHE2QmZPQmN5bi91U1d2YUFxdGRt?=
 =?utf-8?B?dVN0M3dNYkNsSEoxdGo0cmorTmQzUitkQVFjN213SjJLUHB1b1dKRGNYZUpQ?=
 =?utf-8?B?N21BZWZJSVNBemJLYncrVDhzeTJJd3p3aE55VzF2Y0pzc2NzRTd4OUFaM1N6?=
 =?utf-8?B?OGMzYVlaMnZLVjZidlZNOTNxeUVxRXUzMU5xUlhwaDdmeGdHSHBmN25iVFNL?=
 =?utf-8?B?eE1YOGZaNHJRSGlwRm9RYzVENmlyZWNtUkxnYUNQbXZab0RSZ3N2Sk5oazlz?=
 =?utf-8?B?N05xYks2dC9zTGVyMXRCY0pZKzh4bmdQUjBadHZQVytuUnhRajQ5RHZSODJQ?=
 =?utf-8?B?ZkdpYXBBNFkzYmdMKyttQUIrVGluQ2lYcHIzU0gveU91VDNwWVphVkdRU2FR?=
 =?utf-8?B?VkVYaDIwZEFUK3dnZzJjdE9NTEhJZ1pMRTRieXRCczZ4dGxCWXpzYkg2K2Vn?=
 =?utf-8?B?eXd5OU5zb1lxSTFWSnBCNXNFaHVMZXRrOS9iL08ydE9DcW5md3VhUmoxSlZu?=
 =?utf-8?B?TUxMUzVGa3U4enEzWWxHLzd4dXdnZ3I5ZTZqTE9PSGRTQUdXRkpWb1hoRWt3?=
 =?utf-8?B?ckRMVGZuYTJmQVpEeWVMTUgxamlWbW5jRVJXVjQ5U2MrbStRU1Q3Qnk2d0pU?=
 =?utf-8?B?cXpWbENUWSs0R1VIeGhjVUZhN0hHaUJMSy9hUDFFL3YxUGpLM0gzYUlVVEQx?=
 =?utf-8?B?ZU1ZdnhnN05uWktOU082NTU5OTVVbTJZcjBnVG9jck4vY1VDcDdabDBnVHdj?=
 =?utf-8?B?YjdoK1B3SXJrcFcyTENpWjJPc1hWa1UvWVRmVEMyVjNKc2lxZkNkWTFEa0Qy?=
 =?utf-8?B?WnBScDNDbkx6VlNlZlBMcUZGdkU5NS9rT01iVThTbUJrZ2pYL2VDaUJRU3Ix?=
 =?utf-8?B?d1pzNzc1TFM0Q1dxbFBEbjFtMVBmak5sbHNNOExNQkNMU1pKRHpYWkNnN1hH?=
 =?utf-8?B?OUd3ZXJuQUw5cEdsOHhGUVdYdnVHVTEzZml1QTQrQ3NRYlpuVGZKR0xTaERY?=
 =?utf-8?B?SlFUZUpLWWFKYmVHbmRFdUZYY2tUQk5HVDNPY1IxQ0dRTnFzRjAwVHFxcnN2?=
 =?utf-8?B?VlJSWnJBWTA3TTNpbUFJL01QZVF0UEFIcmJCeFcrVTh1QVgrNlRHMjBwSHI2?=
 =?utf-8?B?ZzNsMlhvUzZPYzNpV011OEdEb3R1Z2NSak9OY1ROaVdXQVpCNk55MFpickdu?=
 =?utf-8?B?QTdtRDdIcGl1MHB0bVFrdHpxczNXUDk3Q1pZdmJKc1dQNW0raTQ4NzRGZkpZ?=
 =?utf-8?B?Q2ZNNUlORzVOTGR5ZE1jK0szZXY5VnU0dC8zeVNsWHlBYlVlYkV0eEdDcnJn?=
 =?utf-8?B?MTZxTHkrYVpwbW5VcUNnVVE2d3FvSzNMM3hacmUzUld4b1I4bnM2Sm92RitZ?=
 =?utf-8?B?VDdJMllkeS9xK0huQXRralJVTE1Ja3d6YS91bG0vZlJwRDBranZ0WkxIaHpV?=
 =?utf-8?B?UlQ1UnNYUmhYSXBNRlZzWlB4MDZTSmliay9UK0RjUVd0eWh0a3VCWnZQZEEr?=
 =?utf-8?B?bnpQdFQyTU5lQk8rdUtGakYwZk1zNXUrQ3FZUFdWczg2bVNPTk4yYUg1M1dD?=
 =?utf-8?B?TGpPUG9kSTJ3MVAyM2xMVVJnVjM2YVNaT1VuNzFUempaWGdickZiZ2w3S3Zv?=
 =?utf-8?B?SVZVSVNhdnV3MWpSM0RQWHA5aCtCME43c1A1ZVZLa1M3b2hOWkZBQkZKbmZS?=
 =?utf-8?B?Tnc5UThUb1BXQWNlVk1MQngxQXU4TmRuNGJVaXAvbTJveEp4L3VLeStsNGds?=
 =?utf-8?B?bVdHQ01VcVQ0cmZkdXh2bjVoY3VzeHZYMTArejlrSDVQT2NOcFZaM1pIbjAy?=
 =?utf-8?B?TUZaZUlLajFFS2VnVmpEQUlSdnZVL1ZSaUt6TXpmRzNpdXFWeTFIOEFtQkt4?=
 =?utf-8?B?SDV5Zzd3Z1UxRGhlZ21LUDlWRE1POEdPVmRqOEwzNFUvVHJnc2RzcGxJQjZF?=
 =?utf-8?Q?/czzG8PfP6bFeaKbBrvzmoMEp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EF8BF5FECEEED419AFB269CBA7087C5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dd5eb4-3e30-4fd5-82e8-08da7856eb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 09:26:33.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq0iwPuZK5Wmgfr+FaZ/mtAwaStT/UVtTYLYfb8Gy2bMI3xEbkFbcdz+RLKGK+uZ3VgLtPUuImTl16JB2+DBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC82LzIyIDA4OjIwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBXZSBkb24ndCBuZWVkIGZ1bGwg
aW50cyBmb3Igc2V2ZXJhbCBvZiB0aGVzZSBtZW1iZXJzLiBDaGFuZ2UgdGhlDQo+IHBhZ2Vfb3Jk
ZXIgYW5kIG5yX2VudHJpZXMgdG8gdW5zaWduZWQgc2hvcnRzLCBhbmQgdGhlIHRydWUvZmFsc2Ug
ZnJvbV91c2VyDQo+IGFuZCBudWxsX21hcHBlZCB0byBib29sZWFucy4NCj4gDQo+IFRoaXMgc2hy
aW5rcyB0aGUgc3RydWN0IGZyb20gMzIgdG8gMjQgYnl0ZXMgb24gNjQtYml0IGFyY2hzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
