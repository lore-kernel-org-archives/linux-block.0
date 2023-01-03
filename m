Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70737C53210
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 05:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjACFsK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACFsI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 00:48:08 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B22323
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqP5v6b7qJwrRJNV360DBjsAlZz1G+ZuUGB50GZ1j0VPUEgvDPxjQf1/3G2h7OBL9KXPSnXXdAJAbtlmJ9nTDAoXEEATTREkE7q8nOdtqRT37jA5e4yOIvJPKdsOCpjM+wp+fg0XHfW/ZTmYRYbs9FbaKxK7XF/smwwgsfE6s0wNCsWuA6klIet8mvLmb57AlLfc6W6pFglNgcKsx6ZBuRl1vnpmMA72xgngmQmdXvN1MJuMZ9/by+jdF2e5P831hy9EVAOASOnd47U/vDrtaL6J7omR/7cGewUZI6/gm8VT7w5vm3qsSdQhWaRogJAa3B/LQZnFowCe74E12qhRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO87vFqOqE950f21kvgOR02DF8VYrr1VXyjLhaC8Fro=;
 b=OB2sBJ86UVW2kgESK8FqsZmtG8vtjwcd3HvH/lMUyAok2KrES8dz9SX/Nx4h/jaSLI0JFpv0vT+EEHiWUyjWHgf2/YoZHidnmRmDQQ1M5CrdfXrbcN7rpwt4gagt87j8QpEaooTrshK7x3M0V2rczMrHM0K2rHVvrOCcPKIZ0oVDJPj046CY6RIqmCyJblQqfI4NZOuispiYFPko6/S5TTZIsgD8R4HRIirjV2vzLuLXFLY4BPEDjZnqA+hVaMBw9NfMlQQIe1KtQcHGw/fO2qMP/fGjfg49hmHwAWNonE8NaaycqQgO/77neee+sztU6EvhvcbQtzUpxMRAr6JVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO87vFqOqE950f21kvgOR02DF8VYrr1VXyjLhaC8Fro=;
 b=Dg7m1Iu8ZK20trhlzL6ovf3JWiOsDNPH6kh9smCH87JJ+kTcQsdayCcTAUcY5OA84cKUgLuJxIh+OvCkjEIq6ajv0LqfZ6xvBODOLMK11G5xQ8thjBcZaqYJe3hGAKbq5imMLaBsYpJ72zuCDAUYCsIzi7Cz3mBfhCJGk/wOcc1cAZwYAOIuBu8sdyPpv8DlW37thOuPtOuv0tgtsNYfWatF8pSHYlJta+PQWkSd+63cOpC5UzwTwr8X1YmXpaid1cX2nSTJnfRmF75LFFEu2OiaV4fnHuP/jr+rLc8/xShGiGLHsqmARX5H01d/9WvV9DKQzOuUk4ELHi3L4fjfFQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 05:48:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 05:48:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Joel Granados <j.granados@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme
 character device
Thread-Topic: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme
 character device
Thread-Index: AQHZFSf0H+fDTNpsdESApHiXav/82a6GSwuAgAX4i4A=
Date:   Tue, 3 Jan 2023 05:48:05 +0000
Message-ID: <97d80332-cf4a-b6f0-dcb7-a0d30f23ca3c@nvidia.com>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
 <CGME20221221103454eucas1p2facaa4072e0c8f395162f37fd74fcd18@eucas1p2.samsung.com>
 <20221221103441.3216600-3-mcgrof@kernel.org>
 <20221230103713.sf7y77ds77473rl3@localhost>
In-Reply-To: <20221230103713.sf7y77ds77473rl3@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7534:EE_
x-ms-office365-filtering-correlation-id: 22744f72-c066-4b07-b2cd-08daed4e15fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1meo8aMoVi4JtHgZUPI/DYvikwRB+YRX+EDMogfBA+heLurvE9c0QlQLraFicmV6NbvL1I2/rZFB9o/Cq6D6EDshKlj9E8IQQZr9HEvxORv/QKp3eWLCz08TxTFI1/jB9auKppUloVQgP9BMF67DB4mqQQimFkr3oqWNUmZ5cVJXJd8iugYHB+x0Fr/vfU+h2QzV90yMmXgPhqIGmdRqu5iMT8duiVzmAbZcjLTBFSvw/1Or6q40HcvYRiWf6/9AdLeCETyQoib02CqIvh/AD6rHh6BrB6lMxpyR5UH0O39ZM2W6R0Nxy+qvMiM76xWHyubuU06bE+5YG6bgJVD3SvEGHc0X33jnn1FEp6OlgKFdba6z3jFdYWUCSWaTs1SzMTTg13pBWNYV3+A+IWw7g8n2ArhU99RUXbyAH1eV/kjYqPFQuCoz5zTeIIRUAVDpAAye4GBc1xTXz/mZdQmvLbJFQ78Ij4ADjVLc0vQrzNJ8G/V3f1unLaFwW/xKp7X/W2zmMFuCPsOsYWvM7PFSwV53zgNWpLkvUqIeZrWa2nx+41dCkbryakge6mEXAxAmEkR1xRcwXsvTw75CMV/TUnYIznUWqm08890Dns4GwnsLQIOfUFr2PtK8d8XVDwtRRnkoqsKNy8+PD7bStguX94/xYbUjE95dlTkh3UAQsess+7cJYGUmed9jhDXLwzMWoTSdKm55KU+oaUlOU0SeBQk8tpQNIF4mcYyW/GtynCqPP9CeQERnyeMb5I/99B+ahIu8VTal8wPm1uG7uHNojr+psH+ClTZlVx8vgI0Pu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(6512007)(54906003)(316002)(71200400001)(186003)(110136005)(4326008)(2616005)(64756008)(91956017)(66476007)(66446008)(66946007)(76116006)(6486002)(31686004)(6506007)(66556008)(478600001)(8676002)(8936002)(41300700001)(5660300002)(83380400001)(4744005)(2906002)(38100700002)(36756003)(122000001)(38070700005)(31696002)(86362001)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE8wUTYwT1N6QVE2ZWhzQ2JyaktXN0Fqbzl4anA1cDJFT2ZpdG0wV0htMmZq?=
 =?utf-8?B?SG51Rm9vTDhOeFBNK0pZVWE5WmYwQlJDZm52MEh3bXFTSFhRcmpoekJONE5R?=
 =?utf-8?B?QVhrRUNCaGQ2NmE4T3pLMW43V3BXSXJMWFF0dGRHVlZyYmFBVGFHZFlUcHE1?=
 =?utf-8?B?WDZnZER0Y0R3U3lIM3BDVGJSRytSSG1rR2cvYlNpQVExS3VaTHM2Z0QyRUlm?=
 =?utf-8?B?azF0WENKWlRVM2lnTDgwMmpJdi9iVEdMeWc3S1N0dzY0TExzeDVxM0xxQjUw?=
 =?utf-8?B?cDdsL1BzcEtJMUhDdHZBNkZKaVFacUgwdFhsTUNnR3FLWU4zbm50WjlIM2lx?=
 =?utf-8?B?MzV5T2cwbWtPVU40VWsyWTNvOEEzcFlHZVZVQmtsQjJrODdVRGh0RzNqM056?=
 =?utf-8?B?MlBjOWVhdEdKY2ZJUTVRS2JhSXczb1ZvcHhhR3g0bjlNNzNhYkduWFQ3Tmxr?=
 =?utf-8?B?MzdOYm1BL3M1Qm9xSk1jcEl0amRiQld4TGczVmppcVYydHlqTVd6cmY0VlNq?=
 =?utf-8?B?aDNGODNZUlQrTTU2V1UwZUpxZHNseGlhVFdYZ1RKSytmT09OVGl2bjE3Nmxj?=
 =?utf-8?B?YXJaYlRXb0dPcUJNOTE2ZEhrcjZXaURxTGI0NlVhWEl6V2Npc3RtdUtHQkxk?=
 =?utf-8?B?OVgxb21ZVGQwUDU0SUxqMjhZWi9qaWZCZkNzZSt6UllYRmZLVnBOa2tISWh3?=
 =?utf-8?B?NXJvWXFhWXB0TzAwbzFZMDdLS0dVTit3eTMrOUxNa2RHOWNHQkkwa3ROV2RT?=
 =?utf-8?B?NFprR203eFRjOXRPOEZXTVJSdk1DTzYvYWl0WHZJckR5OVZ1MkFVQWIvMnhS?=
 =?utf-8?B?NnBVbkRwM2lHQTExOWIzcisxRXZKdHg2a21SYnJkdDd6eE9DZUlGeUdiRDFs?=
 =?utf-8?B?bWpXQVB3YnVxcVJJZ2pLWEZPK1E0b20wR2lyNG45bTlHdmVFaDdCTXpCWjJv?=
 =?utf-8?B?RzBvYTBxTXVHWXFzbmY2S2RYWFBRUlU4WitlRHR0MWMzZWpnMkdHb3ZDRGR1?=
 =?utf-8?B?OHJZNFhZMVVJT1lPSG1JU0I3Um5hcXBYUWU3Uk9TSll6bVJ5WXFwN0I4bFhv?=
 =?utf-8?B?ODFvY3ZOVHdKalVxQk1hdW1iTHBmYVN6NFdqOHM0NEUreHN0WVpzNVI3alVh?=
 =?utf-8?B?RmdsUVk0cDhESG9UbVhGRWtjM2pPRzZjellVTFNiNWhUOG5EN3Q0cW9wSW9S?=
 =?utf-8?B?ZW56SWJzeW5IV3BPeUFBei96QTZkZFpGUzkzTmh1dWNZVXFmNWJsSXo0aVV2?=
 =?utf-8?B?d2c2Z3pwZzJFSUgyR0JlZzRUOG9FT1UramswZGJkSWVFWUtsMzdPYVRrSU1I?=
 =?utf-8?B?eWEzWnpMMzJRb2xnSHRJU1Z1Z2ZsMXZoeHc4VmxVM3JSdEdZWjArOXZQSXkv?=
 =?utf-8?B?OFBnMkFKaHpubUo2ekU5K05QY091eTJCenE3STNOVEVnREh0blczYVhUTUdu?=
 =?utf-8?B?a1dsc09hTDlzZHBoRDZxM244RzZTQkg2OXZ1a3ZTbmdsV3RBd2Fob05SSFNM?=
 =?utf-8?B?cFVmL0wzWkJ4R2dmK0RKWGloMHhLSEN1aWVpcHU2ZVpXY1JrOUJsUUxSTTlD?=
 =?utf-8?B?U0tTbFJwQTZrSWJKNGg2ei81cXBMVU5jODArY0RSM2IyMXRtZU91VG9sZnBB?=
 =?utf-8?B?UE5tOUxJNnVFUXJnL2hjY0RWUWorQ2ZMTmUrZzlFNlU4TjlzWnRqMlI3aXlU?=
 =?utf-8?B?eU44bVF0d0pjQ25IODFTZEZDdnl5czlsSzhMUWYxYjVUdUx3a0R0TG9HWDZE?=
 =?utf-8?B?YWFTVlhiVUdGZ0llTkFiRlZNaSttWktydWZiNlYzY09sZ29LWlp2blVwMGNu?=
 =?utf-8?B?NmhSZTNWOVZESXJZeDR4b29GcSs4VGEzaEk3NTVkRkJDa0ZWQVM0TXVLUEgw?=
 =?utf-8?B?SnJXdWtMbFlXUzAwWUFrbDN3cnhMUVRiQ1VqMDlhOXo3TEYyTUNMMVJQQ2cx?=
 =?utf-8?B?SXFmTGxvNU92a2tjMXFxcWFSZ0F5TUhDUTNpMEFubC9EOVZOV1lCRWZPbGpj?=
 =?utf-8?B?RWNSQlFLMm1WdlRFQTZ2eGhnUW14Q0FFZzIzOE5JY2lHRUJEaFVpQmIvOFBu?=
 =?utf-8?B?SUNBeUxnSTZhbW43MW5aWXFyUHFPd1p3L0Z2Q2dHR3B0NmlrUjQyNE5tSnll?=
 =?utf-8?B?WHZGOFdDVzJCQlZMd0Ura1BudjYyR1dESHJJVm56N1BHS0w2T29RK08yaDFF?=
 =?utf-8?Q?BvwrfD5GFzUG6GNwAOEPXHcQROiCx5/U6PQuqSbT6us8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE6854DB0094A44BBF64DB095302012F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22744f72-c066-4b07-b2cd-08daed4e15fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 05:48:05.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjITIgBRcWnJHuDUG1cQ5nmU4+vpqpEQzvuwdh7n4X0U3TEaFonfkI7r2avpXo/483ZQU4/58xQe2NRUy3/Fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pj4gKw0KPj4gKwlpZiBbIC16ICIkZmFpbCIgXTsgdGhlbg0KPj4gKwkJZWNobyAiVGVzdCBjb21w
bGV0ZSINCj4+ICsJZWxzZQ0KPj4gKwkJZWNobyAiVGVzdCBmYWlsZWQiDQo+PiArCQlyZXR1cm4g
MQ0KPj4gKwlmaQ0KPiBJIHNlZSB0aGF0IHNldmVyYWwgdGVzdCBoYXZlIHRoaXMgc3RydWN0dXJl
LCBidXQgd291bGQgaXQgbm90IGJlIGJldHRlcg0KPiB0byBkbzoNCj4gDQo+ICIiIg0KPiBpZiBb
IC1uICIkZmFpbCIgXTsgdGhlbg0KPiAgICBlY2hvICJUZXN0IGZhaWxlZCINCj4gICAgcmV0dXJu
IDENCj4gZmkNCj4gDQo+IHJldHVybiAiVGVzdCBjb21wbGV0ZSINCj4gIiIiDQo+IA0KPiBJIHBv
aW50IHRoaXMgb3V0IGJlY2F1c2UgSSBub3RpY2VkIHRoYXQgbW9zdCBudm1lIHRlc3RzIGp1c3Qg
c2V0IHRoZQ0KPiAidGVzdCBjb21wbGV0ZSIgc3RyaW5nIGF0IHRoZSBlbmQgb2YgdGhlIHRlc3Qg
ZnVuY3Rpb24uDQo+IA0KDQpZZXMsICJUZXN0IGNvbXBsZXRlIiBpcyBzdWZmaWNpZW50IHRvIHZh
bGlkYXRlIHRoZSBjb3JyZWN0bmVzcw0KYW5kIGtlZXBzIHRoZSBjb2RlIHNtYWxsLg0KDQotY2sN
Cg0K
