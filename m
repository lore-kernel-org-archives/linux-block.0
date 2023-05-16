Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA5C7EE22
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 00:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbjEPAtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 20:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPAtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 20:49:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB075BA3
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 17:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc58stLz8aYLeByproU/X4jA1yDnQAAmoyHmfPOQ4uBlqtop7ojIdUzXWh21n3QHbEj8LEQ9XxOXt9kyO7QsMrMY3Q36AFwK3bYUCzp+W/4ZBGbRkD3sK5zwwlICtHF1iCEafTdv2Z/nrk5wplevzBqoYN28+/HAXrxDLX9RxT8Nmy2wEeBwR2juGwMShzSqYu+Vl5GWweqkmB8jloXIXTFNPkaFSY20ZfFE7zI1PNPG24q9NKsxBccA01euG0A3t/a4ek8NUlLrfT7g5MI2RBWfoYDnMOxQv3QTz+AwzHPwy/IPrkAwRjpyY5v2RqzaPHMvDSwrEF9RkR/ICSGEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ppo+/8bmzkUSn/9LZfgcUJv1GcVlUbcRo4r3ATfTn0E=;
 b=Br1LjbEq/HCJY2HWAnbdw2mgSlUnB0qd/TY/3Vj8hO1ielGjsi9fM9erDGDlpdknxs4pho3YIkQoatYKRNgkT2VhEylHdUiobwv3m/BJOKMIXku3jzmbv9pOoNCp0qomL4T0uns1jUpdkYxdm5/oU/XkyZYnFsifpqh2pfsK7mjNeXnbxTb6a1K4L87ynUWPTml1MUxtfqiKIqwLGcMRozV7Lrg5gi5eNEYu1eHhdJecHu7bSqQx+2kh9a3N4WUhnVGTpSfB7yaMrBNHaoUqJuJjRp/jhmZxy+4n8Wm/NEI77daMr9zLkkBMc/k1RepmUMcZKNJCSLKepMBeIdLgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppo+/8bmzkUSn/9LZfgcUJv1GcVlUbcRo4r3ATfTn0E=;
 b=E3KlRozbst4+SR5fM07R2zhvVm2d+iQGuW/FQzaSBHBAbpt/MmFxuax94GmOtyxqhZ7VmwFAl/bql27HkkWXdGiJa1eJLgll//I84uuwfgZv9JgHi96tXzFHVxEj94q99VZdLzXVaRYKnnBVtlAWM3IyqKvsEw9U6FKF8evKuINOeEBSYGwv4Y8qXyso/8M8NyM+EtiSG2XiOaioTskJqQviX8AjY9fYtMvt2pCG8bgX/iYpJ1P0aFv/beS/v+MvVIPn8yqaRAgHY2HSszruOPxDVigEaBo1xBE2vbbN28FCzWWIXRyOI0RMybp0EvkhbMUk3ta2gNQf1dZcc99hzg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 00:49:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 00:49:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Thread-Topic: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Thread-Index: AQHZhAM6arOvckiW302hDIuLZU+lkq9V15gAgAWRqQCAAK8jgA==
Date:   Tue, 16 May 2023 00:49:04 +0000
Message-ID: <58bd6d84-ce9b-3e0d-3601-49474d93f5b1@nvidia.com>
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
 <20230511121544.111648-1-p.raghav@samsung.com>
 <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
 <d8b9c4c3-9782-6451-44e9-ef737d53e1b3@samsung.com>
In-Reply-To: <d8b9c4c3-9782-6451-44e9-ef737d53e1b3@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB8234:EE_
x-ms-office365-filtering-correlation-id: 40b11562-8a24-4b4b-83bd-08db55a758f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DatGqIywYdYm0Q0s9t33OePuYOlPFwVNhudYBaGWY/CfZMiEBKzK114LmDmN6oG9hDizVaWfZmhABNCSZTIIiKyCvIMGrA58PGjROcEw4ur3s5cuPx77z/uqHwellzqhpUsXry6Q0WAWtbLIvyCTV2sqNB+GZRlOrQDF7ShYcAjf8Sc2ZSvMs/T25fAMLlyN9gebS5v/VaFpADE5z0bPKrch2uhYebH3b0u3wvqZaJU8pUJ2f5GdfTBPoGWRyBZrAo+2XnoGe26gc1QrSFi+pzPTGAzyqcSqHCqC8ufDY28KXv7xhR0k7ehtAJk10JxZjLqsBJ9wCiZmw+GokIWozQ/rYCjXURbfnjGzM7tPy9axbSnJ2o0IOrtNEfO0otZmewV+VplFaBaZIHXVxMYb6kz7D3XPiH8w048yWWJTDjqHt7yYxT44m0uH0j/dpN8U/NDl84NJFEOVGZ9xEb83y5wBDcR/Rfxeq8+sq5xXWSA8SxhzSxkMzXdVQSpARtMu0lPvkTfrA2uG0fxWSCFnGvth9JBEvPlPGeiMFkeBkSsOZxI3fWT/uEJbblVQuOokIRCO8Vfc+lfr65bRzf07XLeJb1lGehTk9rs0IN+Xom7F29Hct6USubWQ0uvJvyHi9N9FFPpiAac6VKd1+lmmbX8YyM//+jyYcvgNnElXxoUKjcc9xBXdbwKW/Leqg1DP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(53546011)(478600001)(6512007)(6506007)(6486002)(71200400001)(66476007)(36756003)(4326008)(41300700001)(91956017)(66946007)(6916009)(66446008)(66556008)(76116006)(64756008)(38100700002)(31696002)(316002)(122000001)(86362001)(38070700005)(4744005)(2906002)(31686004)(83380400001)(8936002)(8676002)(5660300002)(186003)(2616005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0hrbWp4LzdVbmYxQ29IRmVvSmRwWkgwYk8zeVo1YnM1dXBHYXNLbGVIeVY0?=
 =?utf-8?B?eTliNm5KYmdqcTluOEpkNThTTHVXNm52NmJsYXVjWWtUbE9ra3FJaTNPd3dW?=
 =?utf-8?B?RzFQUzdUUmVBT0oxOFhiMXpXQjZEaTM5UGRxNlIzTERBaW9abG01c215ZWFo?=
 =?utf-8?B?TTEyMVh1c25WZkxXT2ZYbEVvOENpMzRtRUhwckRoc1FDd052eUhCK3l5cytz?=
 =?utf-8?B?alZOR2tLUmw4MjFSdkxPSzlQcm5PYVJiWEU3RlR3SG9EK09rYkRTSnFrZU4v?=
 =?utf-8?B?eDRvMDd5SkVLNTdtSDd1Sk9YRHpNNm1SNk5UbGJndXFOT1JoUXB1WUIybExt?=
 =?utf-8?B?ZmUyTE12aTdBQTNQZm4raVlzZGRmTFQzNHNzRURaSjJyaWVRQVJsaDVHbVVG?=
 =?utf-8?B?ejhZZ3JGUmlmUktadzRGaE9nbUJQR0FrbkozMlQ1MGkyR2ZNY1lKbk1SaTg0?=
 =?utf-8?B?a0FqOHp4UmNCeEhuZFJ5YVUwVTFkb3F4TzJHaE9ZNGpyYzY1cjJ5Y3M4bEQz?=
 =?utf-8?B?bFg5YWtTaFA0SGtiRE1UcHhQYmhSKzdZL1FDWitBa1lRbFZZY20vSDVjZkNl?=
 =?utf-8?B?a2s3TlV0MDQ5QXhCUThocmJwZUVyR0RTcnNBdkFPanZ5UkRVcHRLUDUzVTRL?=
 =?utf-8?B?NkVrTU9MTjI1Z2JhNVY3Wmd6RGlDalovS1ZPcG5Mb3lpeDFlYUNxdlZoSjU1?=
 =?utf-8?B?VExMaFdUQjYvWXZhbnNKakpyM2Uyb0x4eWM5cGRsWDdjNEFGNCtwbFBrWlc1?=
 =?utf-8?B?azhzakNJRFF6SVFvZ1JoUG95QVRVR2V3MGpWTjJYNjI3a3ZibDl3aGZwYjZv?=
 =?utf-8?B?ZGJCL09peGNXMDM4dk1XdTA5aXZrcElYVVVoL2NjUHRlU1FaekRoUXdqT2Fj?=
 =?utf-8?B?aTZ5UTdaNjNXK2tlR3ZRWTRQei9nL1MxMEJ2UzFOVkswcmRCMzlFSVg0UEN3?=
 =?utf-8?B?a0h6SzJMQS9uKzVwZjMyOFpNbEJmNXBFdDVXYnAwYVpkUXJ6TlhYZ1BUM0Rv?=
 =?utf-8?B?S2F2bll3Z1VDaFlEVHZhNEQvNlRFK3dGamlMQjU4RTdHZGdEZEhXMmlLY0RB?=
 =?utf-8?B?WHVOQk1VY0dsSVZPSnpBRTlQNVZmYU1DdmUrSkFpYXFJVmxOeGt3UlUya1dU?=
 =?utf-8?B?cHR1Zm9mU1ZiYkpFQW5XajFPdk5qMFVFMFhncFpGb210aERnYklPK3d2Yjdw?=
 =?utf-8?B?UFBPTGE5bmhnR3QwcjFHenhVWDN0czZBUG5GVlVjT1F5cEc5SkJxbHY3TjlN?=
 =?utf-8?B?bGI0VUFYWnY0K1gwckFvNGc1Y0xqNWw4V3o1UkxXMWhSZDRLSXhsVWFpakY5?=
 =?utf-8?B?WEJEekJaYnE1SVBFZnBpQkxLQmw3SjhRaE8yQWRyVDBQMG16blhoaE9ieXl5?=
 =?utf-8?B?ditLNzlGN0ozbDJTVXpEMVJscWZLNW03dEVJYkQ0ZFZQcEVQN3d4em1OL1RY?=
 =?utf-8?B?N2g3NU9UMExjWkpydmNxaHpxVTJvOE50QU1KcnZtY3U1OVRLRmtHbmRGNTNL?=
 =?utf-8?B?WnBWdG43aUVMejhvem5Dbmt2MXFNekJwTmRsQTBidlBJUkZjTEhKa1dJa2tY?=
 =?utf-8?B?N3NVZldiWGkyS3ZZckNVVlB2dmNHcGdyaGRQTDZhZUhtMjhITVFmcDVFTmNx?=
 =?utf-8?B?TkZaVVVHY3BwdHc0aTF3MG5MSWVSVk9QQWRQVUdRYWgyaTRibWZLM3hya1cr?=
 =?utf-8?B?TCt1dFNxL0ZTcGkwbDVlQVordUY0ZWlGNThPUkV4cHU5bmxIaFVtbXBDamRY?=
 =?utf-8?B?SGVid2NFL0hIdkNRSEpDNnFzMEJDcHNqQU4vdjFBZE9QRFhKWDZZbXJHcFJU?=
 =?utf-8?B?VVRtc1lDME9uL29JU0ZzUnE1VE11STdlK2FvY0tGVU50RVRhZHozNUs2amx6?=
 =?utf-8?B?WFZBY1RHNTJOQVRndlBtV0tpbGFaYTQvbDhtZVBMa213dDhmNno1NzMrbkda?=
 =?utf-8?B?N0ZQMDZqZHFBN2Vqc0hRV3oweEd3aGxKYjhWczl2Z3EyYmZiSHRJdU9LWnIz?=
 =?utf-8?B?L2cycWcyeHlsU0o3ZFJGMk5VT21zbkhQTUpQRHhPY0gxbFh3VkhHb1VNSkJl?=
 =?utf-8?B?Y0RKdDhIeG1uK0lQdXpTdlFBOEVhY010UDJGNTVuYko5d0Qxakw1b1BWUXV1?=
 =?utf-8?B?WDBJQlRwMDZtWGZhTmxTbW9JWmJRaERmckZCS3hqeHVydTZrK2Z3RW1iTHBo?=
 =?utf-8?Q?etFgKMJ8xSABurinl7sfPl2dtjRkAIVm/qSRfbFVM2LN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462976B1B0E4C549AEC01069DCF7B753@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b11562-8a24-4b4b-83bd-08db55a758f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 00:49:04.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKGtUj1w2L6WNO5yccpR3KPx4VF2stssQvY66yIPnxC2Fhhidv5O/PzGuMBZ+QS/xKVk4wGP5GE60J3SRVu8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xNS8yMyAwNzoyMiwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4gSGksDQo+DQo+PiBJJ3Zl
IGZldyBjb25jZXJucywgY2FuIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIGZpbyBqb2JzIHRoYXQNCj4+
IGhhdmUgdXNlZCB0byBnYXRoZXIgdGhpcyBkYXRhID8gSSB3YW50IHRvIHRlc3QgaXQgb24gbXkN
Cj4+IHNldHVwIGluIG9yZGVyIHRvIHByb3ZpZGUgdGVzdGVkLWJ5IHRhZy4NCj4+DQo+IERpZCB5
b3UgbWFuYWdlIHRvIHRlc3QgaXQgaW4geW91ciBzZXR1cCBieSBhbnkgY2hhbmNlPw0KPg0KDQpO
bywgSSBkaWRuJ3QgZ2V0IHRoZSBhY2Nlc3MgdG8gdGhlIG1hY2hpbmUgYW5kIGl0IHdpbGwgdGFr
ZSBzb21ldGltZS4NCg0KRmVlbCBmcmVlIHRvIG1lcmdlIHRoaXMgYmFzZWQgb24geW91ciBudW1i
ZXJzLCBJJ2xsIHJ1biB0aGUgbnVtYmVycw0Kd2hlbiBJIGdldCB0aGUgbWFjaGluZS4NCg0KLWNr
DQoNCg0K
