Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A1C636D6
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBFPZh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjBFPZg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:25:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01E298C1
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gft0g0VcGtVz/djDOUabXhfUBlMgSzGHWZrY7aCoeR/vwNv0WNQ/0CKSSP91moCVQX1UP4OrGjqW13P9k18AZ0IgVXjwZY0fg4vy/E/XRpVRja0g3qTa/6cABqHDac+ixTPbXdEagKXG9mFUGd6HQihPG+zoZAnlfFzJKrVmKALDiBi2gvqc8PDluAOEP98vDhfzyvfPO6ZUw5vrKVsXjxHkE+LnE3ubjja5DN7Z6cHiaMBVeyvbevoVIJOjjKuyoYbrUWn7P908SybMJOzAnLWN9yiqQDuCvg1pfl8HUcKtix/zGfATc+GDEHqNoIEGBvwyDEpgAK5xFv4BOrk8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJnN/Dii6B0UxvrNxnKNyjzEDnOmeMuVv1vpmDZQ5iw=;
 b=PC/KvJZQKstB5PC53gCbOJRWhHyQ7EHEzh8Ht5qhqmSUd892TCnuTonEWm7kjYzX3bAsy/pQkKueMMw/4g/qASppujj9mYykHlykStsMKyYcRbkEvbExPOkCFOqJij/6O8PTC5pjztec/dTx5GFbHuaOrDO+KHHw+JaEfl+WX1ZhAfn7LWd7QaoVEuOYcAFzw35wlE5gZeuDJtf9wc4Zo5saiuC99B16RpeK7je0oIdUleGZvwVOmxHHTEmaPd4IliSYB9YDkPyb6/rV7LIdk2EjewWugfZvyMNV3vhW+//LXs88O44pf3NFwBHIop/HebQLVbVnOQsLiZSdIdoYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJnN/Dii6B0UxvrNxnKNyjzEDnOmeMuVv1vpmDZQ5iw=;
 b=MYjkGVe416bzAng6Y2JuCzxjihkYXWLp8WIhH7DGPKI3d2YpvWrCfvW6iy9imBctNL3gBrO52a5bwxbMwpNUGIANI9nApsf+d3sfYTouBBYYGUKQI6feHeenGN+n/90nWBWCMOoiIQ3YBpj4Ai+0+3qY+aIbNhy1peHc60i61YZfMTdth0JysmN/Sd9Ld142e1NJKA36+un5KNqSAMjW+UNyB64aolutBB00WlZ5G2wHVpFZIh3Z2u+3klBAobisJsZtVXKY0hjBNlmbOt8mA9dUg887tl6dPUV9LoqTp72LmNDxJi37+yz6QiqsnjaAHSS22jn6KsLB50uoKKuyRQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 15:25:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 15:25:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-cgroup: fix freeing NULL blkg in blkg_create
Thread-Topic: [PATCH] blk-cgroup: fix freeing NULL blkg in blkg_create
Thread-Index: AQHZOjwBFpmGA/5DME6wuCRP3wSzf67CCecA
Date:   Mon, 6 Feb 2023 15:25:05 +0000
Message-ID: <4ca38ebd-b87f-9eaa-eaf4-84bf5240e779@nvidia.com>
References: <20230206150201.3438972-1-hch@lst.de>
In-Reply-To: <20230206150201.3438972-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM8PR12MB5464:EE_
x-ms-office365-filtering-correlation-id: 3319336f-1677-40a1-8a08-08db085652f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYGeOUTSgACoLelGOePdaLe3D2stqFslWzAIMpfmxGlyKUqhX40ACRa5ufgqqqCMxVxtQP8QfPpcLOPISFK+19WLImM1kd+TX65TS4offe4cbEW0ZvNE9JAiayveAYDyQa58owQ/O5TzAKvCp6DUyUhOZo4ZIbMa2kdibNRUPn2FD1rFahYxh0F/c/ZKT9kqLsJhoOHXS3kSmPsxco/Uqz+5hwP0Tay+4wzuZMWwbynLdNyVt7iX5QtqmjB9VgXJOBeOy0Zxs73BjWJ62TJB5ldz/JgPyRhdwY+RBfYUczBx/DQNEmfiBPWiy3sNwzDyWac9pfpZh+e10dDEulYpPEqH/hW6+PDArcLcsgXvXgizrwvLUqJU2+oFCXpvMpnI0yFRPuC06fYnePx1Ta6us+BBJWgmXPQgFWglastGdndizDDcQXxfSJAp19yP6Zki82Ds94K0+4X0iQUXObQY2BAOmWXL53azBJJ1Qo0Vbry+1kGHlInTyMH4KvmHUubSFMoGeBXdDK3XUeWI3BsxYLjahX0W1vWMsELZnEaB1gydZ1yYUEfBkEHqLEkGEKOr68sXiNRIwRAlxmsVJ43wtcRJpvTgWQEZXKFFSEz/RIPXYn+IqCjryyd7Map6Vpjh+CjQKfShm6ujgW5eSthXndDDRxlgVCMYilcdqYickTxIIPINAaes5PJTjOOJcR52eIrQQqjXyirRWhL4JiJXAREwocgQ8pXmp3wzCnXoRFu4k76is+0jFClRmBci7KtTjBkwcLQBwr22Tc/Xxd2g0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199018)(38070700005)(66946007)(83380400001)(122000001)(38100700002)(64756008)(66556008)(8936002)(41300700001)(66446008)(66476007)(6916009)(76116006)(4326008)(8676002)(91956017)(2906002)(4744005)(6506007)(2616005)(53546011)(6512007)(186003)(71200400001)(316002)(54906003)(478600001)(6486002)(36756003)(86362001)(5660300002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG8zMTNDUm8wTkJoK1hpQXMzWC9GWE1LWmp1M1dkNjZPUFZsTEZNdkg3cVFj?=
 =?utf-8?B?a0JETUlhMmZvWjUvQUgxd2JzL3B4K2F0UEExQ3Rkbk9WWGhyTmNZVHo3RDBz?=
 =?utf-8?B?R3ZOT3R6WXdTamdONkdDVkcva3RYUHdRN3d1Q0F3T296OHpBYUIrN083bEV0?=
 =?utf-8?B?NEdnOWgyRjZpa21sOTVvc2NTM2QvU3JETHFVdG1JdkdEN0k2MWhiT1hpS05D?=
 =?utf-8?B?MzJmd1ArVlBGekpTUGU5Y25lMm8zZmY0YW8xUlNnZGpXSnJiNDRHUmg4c1Rk?=
 =?utf-8?B?ZjNVRHJBZjlZV0dkNTlhSWdlR2lhQkV1akVieUZnUkNnbkJISk1KN1hPaEFE?=
 =?utf-8?B?bDE2WmdpNlYzUmJLWnZrNThCZCtjT1ZjVi90RGJxZlkyTVpCUnVpbGQ3K2Rz?=
 =?utf-8?B?dG1EZzlWYzd5RHlOcVc2blFrNWxwb0tyTU1pK3NYWDZyTnpYWWlveVppWjFT?=
 =?utf-8?B?MmRXUkZ2ZE5zUW9Sd0xQSjNaZXFsbDRJbkRoMzlSWU1hS1liRVBSS0dSVmtj?=
 =?utf-8?B?ZDhuMDlleDgwNzVHQmU1QTVwSm14Um5CTzk1TjRNSjkrdGYyTVh6dWVnb2dx?=
 =?utf-8?B?cU9ENGFKc01XRlhEbzJXYVdYWlVLdzYwaklWa3hFbHgzdzNkenEwM2ZrcU1Y?=
 =?utf-8?B?dWZJRFBRb0NkbWNqc28waWhMVjJyQXkzRENLY016NVUvK01UdHpIQWJrUExO?=
 =?utf-8?B?RVE5WTNkVlJYRDRDZno1ZEsyaWxEaWdZTWVSTDdiMVZqNHlmZmllTW5EZjkv?=
 =?utf-8?B?Y1NoM1FOVWc3NFZoWGUrd2pEUnIvejhBY0FzYlZCaU04SHNkVGx3eklQZlg2?=
 =?utf-8?B?WCt3aDhjQ2F0bVY5eFEzTDByZXZIc2pFSEI3NnFMTU5vbk56S3dSOWVtU00x?=
 =?utf-8?B?Z3NLZHJ3VldneDltc2pvMEFvWnU2cmpBT0NCVk5ybEswbkdEbFdpVVlWbytO?=
 =?utf-8?B?VzVEbGpZNXcyTTV5UWZmRm55dUxFNXUzditDM3h3LzVkdkp1Y1paZVJrcWJ2?=
 =?utf-8?B?aTRUY09UbGduZm14MEZod0RTMktFSEpQcno3V1hzTmY2TVUrUzZVWFBmMG5M?=
 =?utf-8?B?dUdOa1pOcytUbzljRFZBeUVhUkorTStBOUk3ZUJzSGt6aWFia2lKWTNrYlBz?=
 =?utf-8?B?ek03eVgwa202SWpnZ2tmWE5kdFVrY3N0cVN0OXRFbTFZdGNseFFsVVBGMHRU?=
 =?utf-8?B?U2pEVXFJWEJCOWpZQnoyN0c4T3BSYit1dTZRamxORVQxRFRXL0RHYzVqZUIz?=
 =?utf-8?B?TkFCeVJlOVNnWnUyck5GSk8xRFowQk9lSUluV3k5V29UVUlOMHZleEQzWEtR?=
 =?utf-8?B?ZklybXNwdE1ObFEyb04reDczWTB1UlphU043dWhES3NxTkNSR0h4cXM1blRF?=
 =?utf-8?B?WUJ2eGMyZTY5MlE1WWUxOTJLWUtIMm9sN1JUQzk2dSttbDk2OTdSWHltdzUr?=
 =?utf-8?B?bGJKd0pKVVlzTlpBeGgrZGpMN2hTL3lHWXYzd1Q4VmpMUStMSy9HRmw1TTlN?=
 =?utf-8?B?YXg2T2VoblNWZTIxaThSSVNxZ3lJMlBhVkVBZXRpSkdYN0JyRnp0c1JhYmtW?=
 =?utf-8?B?M1RHNU9sY1djRldyK0ErbklBa01LUTAxVjZXS0hwUnlYZ00zcS9ZZ2lBMjRS?=
 =?utf-8?B?K0o4SFhVa2ZlYlBCNFBURmRjTjl2V2RLTmlWRjdZQ1hJOWxJZ0piVWgxSVBx?=
 =?utf-8?B?NFNwN25lQzd1NVV5emhuUWFWdkJHNm1adkE1cTl5MlVVYnM5M0l6RTFKOVhv?=
 =?utf-8?B?blVWRi83N0NrNDFPRHgrOUxGbUJtcjl0ZStGQmlVUW0zUEU1a1drclFwYUJx?=
 =?utf-8?B?b1dZcGd4VnBCa2txU3c2SWoveUgvekZSeUF3dW5ERHdHcEVxKzI2ZS9qZ3hx?=
 =?utf-8?B?cEtKM2dvKzcyemNCaE9pN0RnQXEzaThSQmI4RmV1WHBmZWZWUldFNm8zUUNZ?=
 =?utf-8?B?WTVqcUY2ckNRdHlvcDlJZ1c5RXRwRUU0LzZJY24wa29EaEI3OVlScWd0ak9U?=
 =?utf-8?B?UitDa0pnUURPektqUzJJYzNNVDBpOEhqekphaS9oeitQbVFvQXpEVGV3N0Jl?=
 =?utf-8?B?eGxQYjFoMFpvWFI3YjUvOUhUOFByQXBKWnBzdU94QXlQN0pwM3JoY0pCSy9n?=
 =?utf-8?B?SVFIaGVkc0JkUW9iT09PVkJUVkh4RHo0SERvQ0pOS1h3MEdtc3JhV0xidCth?=
 =?utf-8?Q?Hn4z4/qt7Ittfxu/BH+ujRS4tm+rCkKVcneCvwlAuykX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <949B5AF903B7844E8040016A004DF710@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3319336f-1677-40a1-8a08-08db085652f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 15:25:05.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +02km/tJAf9X1FIIbGgmxcRKM4B4jdsK8Nj0Iepc2JHnWDoMQvSvCNcfFRQCTcjAR0kIccP9BS/aT9Tvu42Bhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi82LzIzIDA3OjAyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gbmV3X2Jsa2cgY2Fu
IGJlIE5VTEwgaWYgdGhlIGNhbGxlciBkaWRuJ3QgcGFzcyBpbiBhIHByZS1hbGxvY2F0ZWQgYmxr
Zy4NCj4gRG9uJ3QgdHJ5IHRvIGZyZWUgaXQgaW4gdGhhdCBjYXNlLg0KPiANCj4gRml4ZXM6IDI3
YjY0MmIwN2E0YSAoImJsay1jZ3JvdXA6IHNpbXBsaWZ5IGJsa2cgZnJlZWluZyBmcm9tIGluaXRp
YWxpemF0aW9uIGZhaWx1cmUgcGF0aHMiKQ0KPiBSZXBvcnRlZC1ieTogWWkgWmhhbmcgPHlpLnpo
YW5nQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPg0KPiAtLS0NCg0KVGhpcyBzaG91bGQgZml4IHRoZSBpc3N1ZSByZXBvcnRlZCBieSBZ
aSwgaXQgd2lsbCBiZSBncmVhdA0KdG8gZ2V0IHRlc3RlZCBieSB0aG91Z2guDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
