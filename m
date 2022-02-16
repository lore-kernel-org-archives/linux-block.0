Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E74C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiBPJR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:17:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiBPJR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:17:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D93224968
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxwdQLifMvkZoN4CX5IvhP0uwtJmjVBkBGbDnp3nPRcxCNtTIbl7jgIHxFsZEcuqK5ljS3Kxh6UE3TBRrXcvtTf0BZI5TirgCoZ6Hb0IpCwkbX9SlVXkqjghagSCN25zyZIf9ZowAIjd7Fz3WYJ/j0A10EWVzjTefbTuDaGtOd4/wWWQC44624Knb9yw2Sqruc+7PDBnTD5TTVs5soOabdUjX+z0aqcVF48SoRr5sIQXGO9zCQL7WnlZRivrLJ6yx/K8h7tAO9ePOV3Ul5KgWvw+9UA1AHRXdxNas/To0f5KXtyV2C2Q9iTOD9omekKEMbzepgn+1mnDiDLOuq1xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fi5hycy/9BZPz5Th4lzwchHdHE7ngjQ8NxUlHBmgZw=;
 b=b3E7aCU92ghZHiF9aykhZhrP74U++xDA9Kemu+PvPs57q7Bvc5eTYm5cbsQZt3f+qiZvt9hKY7O8tHli+ag+Fnw+QL8vALOASPimHmRyuIVt3uzlmpW5+UnLZOBdyMNTi5Kjmghja1/BrUcu8h4TiCQhTx6rhcqddoTC4/DIaH4VQOfTmd0k1vaMHX2gXM/8ij3MnWn/QlLyAHN6UiZ6l4/a68LuTBtdGoRwsa/jqPexpblhH4GFbCOzEIIjtneBqSUtzai6DeRS+ScOjtUS2dmuil9xFeNSo1uP9Eh6Bq8v3vBlFQkafTKR+JZmuBdA+qeoLHSUxTyhahzYo3tq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fi5hycy/9BZPz5Th4lzwchHdHE7ngjQ8NxUlHBmgZw=;
 b=pACBv0/KCcOMdMbSDC81g9S+ji9a2WVocVvRFa2kdrRS6XwGlKzNCJXn5OXXNAhxerSd2DXxk9fEx78/+Zrzlph9t9bIQBScC5BhBbQPqwFlAdJj9302AvdGGkZNslkg739zJTyI0CS3ZITBxhBziqasgCSzvtqDEfhQnO4EKZcxg/QLK19cXmHDio2YSIxigQpbDPg5RAnC6a+kj9kSkzz4qcxMlhAlB5TudQ+Kq2gRBZ6CPY0TvebLHt7kuqVG8nJOzGLkcCYZgwf9KRi0vRo6uI/OO2S3ak1V1euR3r/T/nU/Hu1KqSQMm27wGO7899Od3ldjnBNX+YL/7N5i8Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:17:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:17:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 5/8] block: merge submit_bio_checks() into
 submit_bio_noacct
Thread-Topic: [PATCH V4 5/8] block: merge submit_bio_checks() into
 submit_bio_noacct
Thread-Index: AQHYIvA5BtVYwAS09EWZ6txVTEIRxqyV5jsA
Date:   Wed, 16 Feb 2022 09:17:44 +0000
Message-ID: <40e340da-810a-fb22-8a92-6e82b9ac8e78@nvidia.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
 <20220216044514.2903784-6-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-6-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f7a07fd-e884-4300-ab76-08d9f12d310f
x-ms-traffictypediagnostic: SA0PR12MB4575:EE_
x-microsoft-antispam-prvs: <SA0PR12MB45752AD108F4E291EC43EC48A3359@SA0PR12MB4575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YbqyEvZCJ8A+scXexuk5XIAEo+gFdtHsQslvaQ5CsbTfnA19lS88TdBziLxZNsO+hGDJSuykl8BbQvTc59UCRDEjizQMHjpEh1GRdk2w6cQXdZo6GlubchlKfxjuhS/U+36tDjBkW0d6OiOsYR59OMCsusNh07z8UGwVkBe3UKrFGkCNfELLhuO9oLVQKz9aqSclFr8CRyFTocjrnGMxZ1m3ZUVHFsemnBLNTeY6XuogkN3yqVs9zlV1NJCxVVA45sko8fcE+b+AEclcgD6IX7f5DLCijJvHMicfhWovB6LAu91Dv2mrBDHkIOkWjwn28G7A2SAVFKHAnkwiAIVjtTxyfKyxlHiehLkAF7iblHN/8/ICI0gDWw+4egEWkAWA6MNtvTvh28e4GYF5OmbMByXivqHmaiCzkjWmtFnIp+9BtftHtOaS52jcQK1tLKdi321RREZpoxuh3l4V81/Gla1ciXdWmZbqxgIi4b/Z2wWxZBswgFDfmUhMhbTdDpFIc1v0nUfAmbySZ56p3Z6JovdGWEFXqEs9h0mFcFGWKLpUSm9/8Yc+4skqMn3EtJCTilm8q3As7ElUzwXRF3BGi8EYHFCBHUV6lUJ2VUPkVodo25QS3CdkY/SAOyk7RTgXnRWi86QTEzOu5xHe/Mo9idAPdJts0DQZoOKm++OWh8CCvQ+z7EJJf+4rBBiz+oGKQy6lSKL7B84xw7q5UoqQIOsqN2uKMSgkWcfXPbVfD/lRpZNlx4GuBzP9YdU7HEYAEU60f6B9Sr/VVzRaUGs8qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(2616005)(122000001)(36756003)(71200400001)(66946007)(316002)(91956017)(76116006)(508600001)(6506007)(54906003)(6486002)(558084003)(6916009)(2906002)(66556008)(66446008)(31696002)(53546011)(6512007)(66476007)(4326008)(64756008)(8676002)(5660300002)(31686004)(8936002)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2ZYTEQxMUdudzRjc011ekdEUGtZNUxTblNZbUtSYkNkSFMvMVZYRzl4TUtJ?=
 =?utf-8?B?ZGJlQXRrajZYVUlWOGRpR0M1SEh0R2ducW1ZOTNtTnlmd1E4SXh0eTEzMVZw?=
 =?utf-8?B?cmEzaS85TC9yWHRPbDFSY0xKQ2RIRVBOd1lCR0QvMkRIYmRhVDVxTHhLU1hq?=
 =?utf-8?B?TzF4LytEMXV5TFpQQmQ4ZzFCK2tScHhqQlFXUlFEZGRBRFkvOU8xZi9keGZw?=
 =?utf-8?B?V2pJYkZsajNDdTVEZFkzRWtaL1NHSG1QUGxIaXlBUy9ZUmdtOTIvY1FHK2NU?=
 =?utf-8?B?ZW9UbldVcWZoL1JmOC92KzdEeHlGRTZiN1FDckgyNUlEY3YzUnBldUNXK3o5?=
 =?utf-8?B?VGdyVDMxaWp0Q0N2UVRrSnJlTzJqNVJWY1RGZDBDRWh4SWorMmlkUXRqanY1?=
 =?utf-8?B?WnZxWXhjZjAwdjBPRW10RkFkc1lNMWhxQU14OGNlNHBhYnVJcnpuMmlGWStF?=
 =?utf-8?B?MG5IUHZEMEJocy9vT3M1Q3huc2tVQzRLWGVwMGp6SmwxNHRwdDhnTEhHUEFC?=
 =?utf-8?B?aFQ1Q1lPLzhvRHBFbmJ4VS9MRUdEazBaNjhZNk9EckpLUXRhc2owdGFLaHYv?=
 =?utf-8?B?bGx5U0V3SjN6cVR6Q0pJbi9QMDNMMDlJR3NDUFB2S1NCaW5ZNk5GWGswcmZX?=
 =?utf-8?B?T09yYVgxVUI2SDJBZXlQald0MnZMb1dpWGZVSkh2SmdEaVpWR3o3VTZhQzV2?=
 =?utf-8?B?VmkwTHgycHpXdUJJZjUvbmhsaTduT21LUnVINmxhV3M2YWR1L2s5Q3BCYUJU?=
 =?utf-8?B?cnZ4QmRjWTFTWklxNXJDSVo5TWNjUWNDTitoaDBGQmRaWktHTGowMDU1bi90?=
 =?utf-8?B?RURORGtkM3lHemhMSWI1dlpoU0VJc1RHVlFCZTVINzhnN29rc3ppS28rVUZV?=
 =?utf-8?B?TVJzUEN0cTZ1WG1TRUR6QXpCRStQMURBRndaVGR5aWc1bndQdDdJd29heSsr?=
 =?utf-8?B?NkNZNHZYWFRlandjbjk0WUtpM0VWTkdRcFJZOG1WQm52VUk1TTBxVncxNlp1?=
 =?utf-8?B?Y3ZEUUpXM0JNb0I0SHJMM3BWdUxFYUl3dFp4bmliT2NmZ3lrZ25nRUNVa21C?=
 =?utf-8?B?bThnZTBaYlFyTjB0eTdDZmhJbnk0RzZXL1JmdG9CbnRBRzNvMDlBSlZaZ3dZ?=
 =?utf-8?B?ck9CanVjMk5XUTRLOGttbTJtcHBGVUljTnAwYXdMOTVUb2V0VzA2UndBekd4?=
 =?utf-8?B?NHVkMVNaZUtJUitMQmVCbnF6Z1o5RkQ5SVFKbGkzUjFYU2xoNWxNQW9PTnl1?=
 =?utf-8?B?eXpKMVVxcnJwWCtDME40TVV3SDcrZ3VTQXBUVGRGbGlMcnRkejBGeFBVSGht?=
 =?utf-8?B?aEZVMzkyaHZNSXdnM0UwdXJkMkMxK3UzbzFlbmN1cld1UzM3NUk0NFBNV21z?=
 =?utf-8?B?LzJtTGU4cTRPa0dXZm5Yd09JUGRTcUpVMHF0Vi9OdHAzZDRTUkp2ZUNVVnky?=
 =?utf-8?B?dzR6K21HaWdsTzhqazk2SFFhQjJBb1Z6NWJIM0F5a2xpajRjNmI5and6aEUr?=
 =?utf-8?B?S0VTUUFoblFEeFpaOWhuTFp0cFJhcTd0VUxuUTgwSk1HemUzL0w3R0hVeWFJ?=
 =?utf-8?B?T1p2aDYxTkFyaEJFWFpiWm1KRHBOUDJqR2RvbzIvQ2s5QktzeFQ3NHgyU21J?=
 =?utf-8?B?R2ZySG1lYjdCMUdyWVM1TDVjMFZLRlJDNlpRWVVpTzAwZVhSZFBrbyt2cXBD?=
 =?utf-8?B?M1NxNzRQS1hoVSt4RGxIM2VaQW1udTR0YjVZUEkraVFvWERWUkIxK2R5ZFFm?=
 =?utf-8?B?OVZUWEF1b1ZodlZDcWdqbzlvR0tWK0tHemVLcS9VTTlnUEVxR3BQZmFzUTNo?=
 =?utf-8?B?c3BzYm5acnJvb0JLMXU1WUdkbkt4YXBqRTVtSkdVY1AzTnlQeHM0ekR2d0lu?=
 =?utf-8?B?SHJRNUp1ajNNNjhYQkkydTdoS3paQ0czWFRJU0tBdnlWY1R6U2JvQ2Z3STNZ?=
 =?utf-8?B?OC9vdi9Vc3VsUktZaUZ3ZHdwSkVDMEZQUWppQVlGbTYrZ2MrVWplL0VqZGJk?=
 =?utf-8?B?Y052OWpYZGFRMTZyR3cvemdsOVVBSHdsMmpJYitCbHBYQlZqZzBwaHpNZysz?=
 =?utf-8?B?cnV2OU1QUlVqejRsUWMxMlhGMFhma2g3eUluSzBwYjVoZklqM3JqK1g5OXhI?=
 =?utf-8?B?a3luajEzeWwxeVpOcUxtRWtSc2c2RStjaDQrZWo4QUFmTFVyWmpOWXpxWXRu?=
 =?utf-8?B?R004dGNERUpTL1VUbElPRmJ1TEtGQWt5bFI0d3I4N3g2bXZJeFhldVVQK2VZ?=
 =?utf-8?Q?22EtrDsepUVkappz5qrrgYjAlh6OgA9M/KxNPIVPn0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2302F548155EE449EDC104290C38B30@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7a07fd-e884-4300-ab76-08d9f12d310f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:17:44.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoiOMkto0pXlwbuyI1Yuq+WwLR7Ym+vCMzYroDGY2D7hNF12iHy4d9OSj3Rc/sWXZe0Jo3WSTYeDkJ8uAFxcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNS8yMiAyMDo0NSwgTWluZyBMZWkgd3JvdGU6DQo+IE5vdyBzdWJtaXRfYmlvX2NoZWNr
cygpIGlzIG9ubHkgY2FsbGVkIGJ5IHN1Ym1pdF9iaW9fbm9hY2N0KCksIHNvIG1lcmdlDQo+IGl0
IGludG8gc3VibWl0X2Jpb19ub2FjY3QoKS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5j
b20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
