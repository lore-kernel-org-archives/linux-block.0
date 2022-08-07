Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DCDC19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 09:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiHGJaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiHGJaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 05:30:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A3BA0
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 02:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbEWjitlAVWCEXkY4ELr+vwGhbxm/tQG3fgpD02jJyiJepZThdotZvg6YP4GwB83c0UHHpv3nvj8iVIUTn0Nyd6KoMW4/G5OnPwhl5WE0rffavcQUWX0Y6ru0B3/qQ65eskpLkMbVXlR4++aLj7r+VQIF4yCvU4WZiuyzCBPEP7REwj4Hmjq0Dqtaij/G8OrijGW2l9+PrBBVKjreeJ9G9vQrbsYeYKuRTV6o5mxujiWQocwrlyi9VJ8iVzNpe2Bm9ccOq4gCdkPy4MbcZYoc1SoCoR0D0sh/j/oSpoC+ZXGc4SJGmrXCvqYvZ3uN1LXJdGeg50zKn5CciLSvjRGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlsdIjxZ7hj692WZPNvYkXiRlJ8nvVLRgJAasrt9vo=;
 b=Fz/FplG7dzH+i1jsI16I8uq8mzQPOwC/idJu9CmLj3PQxve+vy7TKGtz088dhjfvu+2nwcsepTrE9qKOno8M3bbVwvRJTzH866N7zElNrXM2uCv51jyLgim9Jzqqlm47BrK/GhMkuOjgfx4RRDItVBItn1GKR7eaE7D84rl6L/P2SJq2nUQDeKyPWJjbZQADSpXBGEyPzxkQpbQAWcjn8IVr1o8ImcpDedFtppVk3P2PlFI+1G2pPeXS924zXgIMoQFG3X7WvvvdW06cybMBFQoaMj98MBNLwkxSS/OTGDGVMJe9RIDdf4k2so4vlcW5XKRcSTlLn+KoxYISmS/VEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlsdIjxZ7hj692WZPNvYkXiRlJ8nvVLRgJAasrt9vo=;
 b=VH8+VTZVuf6bqnQX05s0Hb7cTu8Llt9hO5HSqxIiT3S5tpBg40W4Ml1K5v4LO+wfFlRxPULCLH4lDu10s0YblpMAlS+zjNfZp7bzdaJJVkXDP7Ge/yLkPmceewA4u/ctO0AzDLhYm1fCsuwaIT/ALwKEj2PzJnl4l1DkqlcyEZw0mpxGWvPwzEX4d69QoykP2j8TYGfMFa1X+a7Z/bktBexRZngznc3xvqnDWtuz4Ay/kxoDsvfsMOegicLN8x/pyznlcN05YPkZtu3lz8AlsKBmn43VWpDJAUKaHL2JRao6K2S0zjOLfyF9n7Klyzne8yg9mCkGxGWmfkPriNPrhA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 7 Aug
 2022 09:30:11 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Sun, 7 Aug 2022
 09:30:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] block: use on-stack page vec for <= UIO_FASTIOV
Thread-Topic: [PATCH 3/3] block: use on-stack page vec for <= UIO_FASTIOV
Thread-Index: AQHYqagJxLt3IvjrREOBGr8vVgAWKa2jLUMA
Date:   Sun, 7 Aug 2022 09:30:11 +0000
Message-ID: <f5d8cd7f-cd4e-f105-9700-543fb3922ac5@nvidia.com>
References: <20220806152004.382170-1-axboe@kernel.dk>
 <20220806152004.382170-4-axboe@kernel.dk>
In-Reply-To: <20220806152004.382170-4-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e46863b1-c567-4b56-0f4c-08da78576cf4
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BequZFENRbM7/lqxhxgYpewTmcWtZgEDL0tlJynzWqAbJC4qX0OqIylMl4fDoEIX94S/qzL0nmTMUBDgjvnnNhqdXpl0+f49YSh+5ksqmWLSzIatPE1cKrZ6pRuEVW6+wdGxHbMUPLTTj17NL6j9shL6GCxEkODhGqot+47XnsYvQm15+x6xr++l38geQ5RgusvnfZuJpu++xh+BoqflhFCf6oJCoy860GhlcEfRuQQmLcYobsvKTn3XGZEkZ66DFxgXeDAx+KgU6wjeeBh33WyRT1g3/t9gCCozWM7OkuiPKk1MfGAH84SVO/0XZvwtLBu4YLSfbgvzlLTOQt2YLh+PhBaL1T9v3x55zHXUfU4kInZmhsH/FqQ2tQ37PUKEyI81e+W9/HpA5O4OJPIpyvBOBAqw89ueC9yF1l42+uuv+EjoQL9I19HufgXMyOL+/rMxi1th6xdTVkUjc279LxlEy5qoGy0E/0uzjlnK/sz8U0lurAeP9HfHGcj7fExbp6P/jBqghwYotokH+1Lp95PGkfWMKo+1uvySR+jA7cIppAENUF0e9vdH8RPe77gOqs4BUVKwBkv6ZE8knYbliAmzWA78/aMsGVr2dUCRKz+LFhvsi2PgE2X+zoKiGqTm6+OI6UDpktCEjWEnmkKIdFB2bE34Zk59z+dLA9j1bJ0CVsYbFUUekcKtZre2cxbc8uXf5BMnvJRjNrF/12YdrqgnhBjlfFn6SB7X0077K5ffDO1+KqvrdMHQ2wqgNC147YuictMsM6O0vV7Zs7NzFeWZ3mpGTFdNYEdmSfAt5r3t22jmao5fnxnmY2bAuyqYe+n4Oi2uBsWRL9+8e4YJUmxet87/uJQtJlFuMZotzNItkDk04UVX4x9Lw0l2Fa8u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6512007)(41300700001)(31696002)(6506007)(38070700005)(86362001)(26005)(186003)(122000001)(53546011)(38100700002)(2616005)(83380400001)(66946007)(66476007)(66446008)(76116006)(66556008)(64756008)(91956017)(8676002)(4326008)(31686004)(5660300002)(4744005)(8936002)(2906002)(36756003)(71200400001)(478600001)(6486002)(110136005)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVl0NmNBR0V4d2M0RS9ERTZDak5rK0FIQjFvMm1XWldzSGk4QndIVzhNelFF?=
 =?utf-8?B?V3hOYkV2SzBHdlFvWm5EamF4ejdiQXV3VHIvbnAvSE55VTNyYlBYU0hEODBY?=
 =?utf-8?B?ekFoVTlvMk15SkdMVGo5bFBQR1ZLL1hVaG41aUsrS0luZVlLSXQxSENyYjRF?=
 =?utf-8?B?aXFERHp4YWxzYVNEYWp0SkVjQ3JQZGtFeG5TMnRod3hOOU5IcURVRFJJVGRm?=
 =?utf-8?B?RkRrc3o4Y2pucDN6c1VQd01PR21iUkdWYndlNlJ1WG96LzRiUUZvc2FLSDN2?=
 =?utf-8?B?WFFxNnMrZUF5MW1MWmEyY0t0R0RNSXF1Znd1NVRtNVJ2NXVTOHVPSm9rQWlU?=
 =?utf-8?B?QVJZZ04zYjd1L1h6TSs4UVZYSHI0cEdwWUJoc2RMcCs3ZFhRTmNYTk0wT041?=
 =?utf-8?B?SytxUFUwUWErZlVMSlYwc3c3dXJQWmNBb0dPcG9WMzkzMXpvazVwTUhMcUx5?=
 =?utf-8?B?emR3eGsxR3U3Mko0c0d2VkhPVEljYk9WaHRNUDdYdnZRTzFCK2hVa0NUOURT?=
 =?utf-8?B?NC9ESnd5dWt2VkUyc0hoUU41R0ZNMGwvNFUwQUkyd0VScnZiTUdDR2pBWnJx?=
 =?utf-8?B?K1A3YUhVeSsyNlgvQ3d1b1p1MENmVWp5WW96MFdWNTN3QmNLK0hKT1Y1S2Vr?=
 =?utf-8?B?Y3krNmlGdU03ZDM0RVFXaGVGLzJ2dmUxK3RLSEYxQ0s4VmxNa3JIRzJza2xs?=
 =?utf-8?B?cFVzWkpGTGxHYlBxaklXWEMvWFhGWFN1Z29EMHlmWlBySERTbzd4MHRrOTdp?=
 =?utf-8?B?WjlpaFlmUHpMZ2F2QVpwNmZ4UWVCZVpLaVhEY0dhcnpRWnJWUzBwUzRFenRv?=
 =?utf-8?B?OU5ia0IxMFdIQ2E0Y09GUWFnNFVlUU1lUDd4U094Nk9uQTJoRXBhRWNUQ2NT?=
 =?utf-8?B?bkp5THA1bHk5ZlRaOXA2WndnSHBaRnFGclJVNTM2N1hJTnZZbVgxblRBbVhH?=
 =?utf-8?B?cEpVYi9PdU04Q3lPWXBXZzlBVTNpa282c3VxVWUzMmZockFNVUd2UFQ4Skdu?=
 =?utf-8?B?SUdGRys3b2o5bjM5eDhkZWIyVDNNT2hoOGVrWG8xanRBdzI3NERVV1ZBQWdE?=
 =?utf-8?B?V0I1ZUI0QkpvVGN2d0dHTWxrZm5Td2dqT1JtNlF3U1ljaE1wUng2OWtVUEpV?=
 =?utf-8?B?RncxWFVnb2JCREVmZ0JVTWJmZVpod09WOGZWa213S0tuWDViNmR1cmpRb1gz?=
 =?utf-8?B?OFp6UnowbFVudi9PZk1ESm1LZFJIOUoxT3JTc1FVeDJkVWFPeHRsazAzWlBo?=
 =?utf-8?B?SUpWZzFVRUYxT1RtSWhMQm10QUhpaktNMy9SbWt6K3M2cnp0R2NiMHBMb0pB?=
 =?utf-8?B?M0VYOXNvckQ5Sy9pTlZkMEs2bDNVNFg4dlEvUWhkSitDRjhpQUF4MklYZHk1?=
 =?utf-8?B?VmtwYmJBd3JPRUttZzVBZS9JcTc4dXRrWDVVTWRzd3FHTnJiZXhRUGRsYlkz?=
 =?utf-8?B?M3E5czg5b3p3bzJybTY0ZlhGTWV5ZkxZZjBUUS9hMVk3ejBTVnErMHdqSHJI?=
 =?utf-8?B?c2NCak9jZWQ0RXdRc0Y2a3FEbjZsOVBueW5Yd3JVUlhGOWdwZE8yRnQ0MStr?=
 =?utf-8?B?Zk5TYzU0WDBxVUNCM0JvbmVFWXlCdFlVV05OQjN0eWwya1owK0wzampUVW1z?=
 =?utf-8?B?aTBEWVNQQ1NOTUdUcjExRVNjaFhudnF3RDNlOTk3UnZxclBmRENJSk5UK0lt?=
 =?utf-8?B?MlYrSVlwZHU0aGZaQVhmYUdydzRIQnh6SGxwS2h1a29rdGs1K3BxaXVnczcv?=
 =?utf-8?B?UU51MkVrdytOZktVUjBUUlZTSWRiMkFJQ2JEZVYzaE5ZNWhYNnJEU2ZhU0xi?=
 =?utf-8?B?Y3lzZ0N4ZUVBTWdzb000a0UyYTJHb2Q5V2hpcTRnbHdMRzlNODUyS0tvRGt0?=
 =?utf-8?B?Tk9la0FQa0RwakNTdUJGeWdac0ZMTWpmS0xpRnZqazNiTm5XaER0V0taSzJS?=
 =?utf-8?B?V2U5dHB2bXFRMXZOdGdWcUVVMTE1V2swQytXZXBnc2xkZlQ4L0NST2g1U1Bh?=
 =?utf-8?B?b2xEMjFHaW1GSXZ3MHlOc0VEZ1RXVGFXOWhwVVZrOTVzb0NocmVaY3RxMndy?=
 =?utf-8?B?ZGZ4cjNVSFNwRGMzL0VGd0ZBZGhmN25TUzhOSHlsd3JlU0xIdVNXQ3pTV1hm?=
 =?utf-8?Q?oBY4d8OGDhCufRZuBo4nZugIf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <212D91D0AACCC3498D96B5AFB61BAEB4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46863b1-c567-4b56-0f4c-08da78576cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 09:30:11.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aA83b94K1cNZVU2ZkzyBrNtEPXXaTYf4fxfg0ftqWNnRII6Wb5iTKPTQ2kTsPi9XRkfKLdKIYM5gXJ6/BMZeZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC82LzIyIDA4OjIwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBBdm9pZCBhIGttYWxsb2Mra2Zy
ZWUgZm9yIGVhY2ggcGFnZSBhcnJheSwgaWYgd2Ugb25seSBoYXZlIGEgZmV3IHBhZ2VzDQo+IHRo
YXQgYXJlIG1hcHBlZC4gQW4gYWxsb2MrZnJlZSBmb3IgZWFjaCBJTyBpcyBxdWl0ZSBleHBlbnNp
dmUsIGFuZA0KPiBpdCdzIHByZXR0eSBwb2ludGxlc3MgaWYgd2UncmUgb25seSBkZWFsaW5nIHdp
dGggMSBvciBhIGZldyB2ZWNzLg0KPiANCj4gVXNlIFVJT19GQVNUSU9WIGxpa2Ugd2UgZG8gaW4g
b3RoZXIgc3BvdHMgdG8gc2V0IGEgc2FuZSBsaW1pdCBmb3IgaG93DQo+IGJpZyBvZiBhbiBJTyB3
ZSB3YW50IHRvIGF2b2lkIGFsbG9jYXRpb25zIGZvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpl
bnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gLS0tDQo+ICAgYmxvY2svYmxrLW1hcC5jIHwg
MTQgKysrKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
