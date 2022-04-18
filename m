Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiDRWYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRWYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 18:24:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD429CB4
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8QkfcW0bLU2v61hzILFoB5kSyuwNRW/8EJN3i7inyZt/7Z/szs65i0KI+UAGUwf51xxjtl1mOTbjd3W517nJVLKd6ppxp1mGThwRD812eIQDIYoV669ZrS0KH5OfcOjB/rX0R2X9pBjvU51SCac9kQnaA8Pgityr1IvMm4NMAB7YZoOShSiMA6lwrBfMN2KwqBsZZADWixq1yGaLJFaL/jA1gQ2euzehbQyl+VVYer/U3xf02XyM+RKUdzY/h9XX8qa8cjHAmLdUxlqQ93saxLmznWXAdOpsBOsztt51hhSxgehpcwpwH8puBMHDGhQUr5DqbkSUG6A24vvc9RNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ElbYRUWrO4RmiHG/yxYwfQVk7CRxFFICKUhchWOxso=;
 b=lapmiLRqH5wmyPhHQaP8YC/UP/xoPqWM8G9ynNIQIniyLoWqUwjd4onYneofzVkD+MJ+qXZpzgvmypO6ufOIRgwHw1LKQxDS2Hon6rBqBla39ZnZxTaGxehfmNRJz4K2CVa5Vvb02IbkkT/RGTy6h6Q64EpKHQUvKVOLkh4W4pSApm0zMuEyhu8TTJXCj/rN6sU9655MvIqQxoySuu72oAs/JqHkuuzDYWYIYO+kjIfwRCSzqx1Ui+mtcYn3FcTMvS1M4s4TXgz6IbVe5OvaSN7SBmIf8LMGQsa1yXo85le5cPlsKra4mU9pBBmnqXFoIP0UCJ+xCN1WjpvopTKBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ElbYRUWrO4RmiHG/yxYwfQVk7CRxFFICKUhchWOxso=;
 b=gEec6LgFcF562LqTaJFf/6oD5HFYabBhRNLG6qbR9Cu77KS7frp3gbzKYmYeFSOAd+3jLswsQ/Iduo35VslCQGmwnhNVTyqTEnC5af0qs0rxOAQVkrvOtMbBMzwhQzFvOOQ0GdhxigrI0eNQHk22r8wS5kMf2CkxEsrs7M2ln9BjV1wUHHG+KghRdoi0D1OYCZfz0QQCkTvZYcfIjpbKrChZffLmCD52OAy+sHAOGnc8RAefH2FFjvJ32JDCe3RjWolxdbsHA9HtmAJ1v6YS0ib9UOMx4z6PoSPzLQWFV1xkn8DpTso9KqJhRRLr3TCAuFXt33gnk8fzaDJt84/oDw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 22:21:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 22:21:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: Nullblk configfs oddities
Thread-Topic: Nullblk configfs oddities
Thread-Index: AQHYU2ydI4s+Wsq5v0O87IRvshUvLqz2NtQAgAAFpwCAAAHtAA==
Date:   Mon, 18 Apr 2022 22:21:21 +0000
Message-ID: <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
In-Reply-To: <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e89c7a7-cb00-4c1d-691b-08da2189c421
x-ms-traffictypediagnostic: DM6PR12MB4251:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4251137B6F308723ACD6A5ECA3F39@DM6PR12MB4251.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvZybfB38zXKmHAvYfVe7wk4WI9bWCLAF6MPTeylKGDYHEgogcZaXKgfYVY1rQJsfEP5yasK3bGocqUKHdWfhKob+1ji+AzXXWyRUBCuAJEAIdsjwp3pPQlzaA2ceOGoZgI13tDkSGomIygqX9WHT0HnWptLLSnDjNiPLrasfkrSnVKGv5D8sjbYe6HNNBOW2AN+qCh2/Lqt7kZlOlHdvudJ46EKfX/VJY11ox4LxtXNNLMP/2ptAbNoHuGUH93w1XZKrOu9rhH5bd1+Dm0MRYMXIYBSvLbpcvWKl3tSUklgd2seQ1nplt8QLF60Q0eMV5LB0aJb3f0mctyjAf9bdt31Wi8T3jAuwHaKj5z8noN2cW6lMxRCp2oo2gfP7lYELA0HV4qO5ZgPjYsvZr0XslIRuL6pQV3TTNO/p1juPf5JMNpNnV1N312bIaG/jzrzeTTdUcaiiNoHDAKl8jEg2FKgYx2YRnlm3D6MU0Vth5Ns7TFltQFbxlGOUXQfziYWvik6NIZ0KCMQG+beM5npLm4qYWIGtmRAegeJFxZWjqHGuj9U+2vfAGbXnEnM7NJfUcsO2HyxdCsoZTBbghWn/mpSv3SCiFl2bxtAlWNmVhzG1k3Zk3iG8+9eu4mV7jL9XgQrEIqyc12WJ8jqy0/TlH0u1c231MgV7IXdWH1iqR4tSQez3E00aFkswL6cty9y56OyYBh1heHiZM+C7jmdKSZ1mslN++5J8tq3ufSHnUEKUpjv8chze8j4JPq5mJwJN6a3n4F2fRwFl+fQi4VZH3EDPmp2aShth0J690RJwwXrMZSaeaIIKXAyc1EIiUfeZwQ5GH0rRh2fxCcLrgl3U9n8nl1cXREPCD/xMmSmnls=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(66946007)(83380400001)(53546011)(86362001)(5660300002)(110136005)(66446008)(8676002)(64756008)(2616005)(76116006)(54906003)(36756003)(66476007)(91956017)(186003)(71200400001)(3480700007)(2906002)(316002)(6486002)(508600001)(966005)(31696002)(6512007)(7116003)(122000001)(6506007)(31686004)(38070700005)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3FOamRDb054R3ppZU81WXJSQkxqWmQ1bmxPaTBlV2F3YTZubHRRNFhJUE1Y?=
 =?utf-8?B?R0JyVGlCdk1Wb0tOekR0YmFrMzBsZXZWNzlGOXdLOVNETXNiMTZUTzRJT3FF?=
 =?utf-8?B?dmNLK3RURExsd0pLOXVrUnI2L0ptTVU1ZlBORUxzWXhZZERNZU1LWmRlV1VK?=
 =?utf-8?B?RmtMa3F3MEhtNTBqdEQ2ZUtWUVpYWDlJMEt2OHlpQUt1V1QxS3lraVVxZnNz?=
 =?utf-8?B?Mjd6QlpRNWRScm1aUkpyNkdva3JtdUJ5UVJhbW1wMG5xL1ZGOVBBYkc4TjlL?=
 =?utf-8?B?aFloY3B6Z3BrODJhdGRCejZlZ3dIQWFpY0t6SVVYUUpWUm1ZMTdWMXErRUlI?=
 =?utf-8?B?U1F6dWM1cTJ2Wmx4WEZsZUpxTGFwRmpoNFJwbzNyTWxvV2VEaUczVDVUNXFX?=
 =?utf-8?B?OGMzSlIzNFVkdzRjMmZLUWV5QnpjZy9IellwYnl1clRpaE1za21saE9ac1hD?=
 =?utf-8?B?VnBuQmk5SXI4RXFKMU81MzV3cEhwQlZlTU91NUd1MHFaLzVTVXVaVWVSRzhM?=
 =?utf-8?B?OU9SeG5QaE9QUHJYcjBRRXEzVVBiYVJNTDN3SFZzWlBrRzQxZUNvY21ybSt3?=
 =?utf-8?B?OEJNbEl1VnhjM1RxNmFkWmxSb1F3REZpQTQyOVYyY2wraWs3RUhqNndPMzdX?=
 =?utf-8?B?b1k5LzUvbDZEU0k4WUtQZkoyNnprVTU0N2IwTVNaU3FFTkFUc1NCTEFIRW9z?=
 =?utf-8?B?OWp4dkMxT3Mwck5PdzR0Wmx3ZmswRDlNbkFMSy9vazZmWHJXdEF0UE5vV1V2?=
 =?utf-8?B?WlZPNERBbzRiRkU3bHgya2VUWCtUU3M1ZjREMitCQmlPYUhGWS9wZ21xVTc3?=
 =?utf-8?B?NHBRMTJvSG4wYk1KQWlCM0V1eXd3bGRsUzN0cU1zTzlwS0pKekJOUjA0MHhK?=
 =?utf-8?B?OU5YNFpBeDRxamo5Z2V0WFI2d2pMMG1jNGI2RkN3UmNPNnJaT0MwNkxrZndt?=
 =?utf-8?B?Qmg2QllQekR5WkJPSGdpL2hNQjNlOEJIWjNiTExyRjlTTEtWNkdhVHEvYStq?=
 =?utf-8?B?NDNaV1VrVW1WeTFsWldTYjM4ZHF5ZVJWcmRETWRBQm1peG4xYUpPbnhZNG9N?=
 =?utf-8?B?U1VQWG11SllIRm9zMWxvZXJIdWJpMlZKZjFYK0JhdllURDZEaGtPK2ZnVC9U?=
 =?utf-8?B?K3BneFFXdE44ZDdFa1hKNE1iWlNsYVRLVHdJQkdlSWFwS1FBK1RMMDRqdWsz?=
 =?utf-8?B?dklqaHNzczM3UXM2TWxISmJCRWRLdzF3cEVVeENXSk9od2xIOHBTS2phUUxx?=
 =?utf-8?B?M2JYRUk5UStoZmxJeVNibkwrRnJnb1RLREd1a2ZCTThkZnpTTU9sYWZnSkQy?=
 =?utf-8?B?azFnVms4ekk2dUQ3anFvRE9tMHQvaFdYV1ZTbFp2bzRzWERnWUw5WGhEUnRr?=
 =?utf-8?B?MTJmU0E2L3paZWYvVlNwYTQ1T0QzWjBMYW15d2xiblVOYkx3MkZQdkFZM3VK?=
 =?utf-8?B?ZEZhL3NnK3E0eFJaM0JYczBibGVQM1JKWTBoSTYzMWZKNy8yZE5qeUxESTBN?=
 =?utf-8?B?STFOeURJQ0I2clh0emd5eERzSlFkMG5hYzJGQXFkYjQ3U0pxazlQclFaZHdt?=
 =?utf-8?B?emNuODE5K2tKNkJ2QUZDbTlORmlWWUN1Q3hYRmx0aEtZbzd6RldnODVjekMx?=
 =?utf-8?B?RWxCTVhTUHdmaEgwRHgvaWpkcXkxSWpscnJpcHl6eHc2di9HT2VxcFkwN29u?=
 =?utf-8?B?UFlRM3piK25nVXZLT01obHJUV1czei90UFRJbXZERTYzbmVCeUpEWVBRdENh?=
 =?utf-8?B?UTIybUlmbHdCK1Z1dXhvdXlyNUZHY0pFaHpBOUNmVjlPZWlEdHlDWDZCdG1z?=
 =?utf-8?B?d1Z1TDBvdXdQVXJxS2lSRHViYmlNQWllQlh6M3NQZi9TZk0xOHBLSm9jeVZ5?=
 =?utf-8?B?OExKSzlsOEJGOXg5TjEvcER4bFB3T0NtSGIxSndPUjJFRmJCRkFEMGNiaklE?=
 =?utf-8?B?QWdqbmF6L0ZtSGZCak5KQzZleGJEVXd3SE55T1p0c0tlMVUycXB6ZGoxZkhq?=
 =?utf-8?B?OHdFdEtPam5ZSjU2RFFDZ1VIMm1YckNSeldaVmFydUdSWWZHSG9FaFlNQ0po?=
 =?utf-8?B?V0p4OFZscWdEY2pnRXE4ZDNLemxWOVhyUUthQUF0OFlIalBGcHU1SkM1K0c2?=
 =?utf-8?B?azJtcXl4eWxyeUZIVG4wN3VIR0FDNjZLNll0TFJpYkxUam9ZUEtqR0lwNmhZ?=
 =?utf-8?B?Y1NRcmI0K1FEYlpVQnBWK1hreTVWeEJzQlNmMzFWU3ZobUlZL2dHNk1RWGpp?=
 =?utf-8?B?TUY3blB0bUtUSFBKTmNTMjMrR2FQTVc1UnB5bjdYWUhrQWN1VVBWUEFtZDht?=
 =?utf-8?B?b0xvcGZEcXVzQVYwek9nTU5VU2FsaENhdGhkT29TMlp0ZjdkZUphY2xTVXU2?=
 =?utf-8?Q?4dH4aUAzvcEg0lxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DC145049D017E4799284FDCE6D21E5C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e89c7a7-cb00-4c1d-691b-08da2189c421
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 22:21:21.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvfL42NGZeR2Gq4yqm8TuMFkITrc/twBE5nLpoJRZCKMtSDHOSMA+nuya/MPgEN6T317KCfSx7J9P/ZHu6Fdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOC8yMiAxNToxNCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gNC8xOC8yMiAzOjU0IFBN
LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiA0LzE4LzIyIDE0OjM4LCBKb3NlZiBC
YWNpayB3cm90ZToNCj4+PiBIZWxsbywNCj4+Pg0KPj4+IEknbSB0cnlpbmcgdG8gYWRkIGEgdGVz
dCB0byBmc3BlcmYgYW5kIGl0IHJlcXVpcmVzIHRoZSB1c2Ugb2YgbnVsbGJsay4gIEknbQ0KPj4+
IHRyeWluZyB0byB1c2UgdGhlIGNvbmZpZ2ZzIHRoaW5nLCBhbmQgaXQncyBkb2luZyBzb21lIG9k
ZCB0aGluZ3MuICBNeSBiYXNpYw0KPj4+IHJlcHJvZHVjZXIgaXMNCj4+Pg0KPj4+IG1vZHByb2Jl
IG51bGxfYmxrDQo+Pj4gbWtkaXIgL3N5cy9rZXJuZWwvY29uZmlnL251bGxiL251bGxiMA0KPj4+
IGVjaG8gc29tZSBzaGl0IGludG8gdGhlIGNvbmZpZw0KPj4+IGVjaG8gMSA+IC9zeXMva2VybmVs
L2NvbmZpZy9udWxsYi9udWxsYjAvcG93ZXINCj4+Pg0KPj4+IE5vdyBudWxsX2JsayBhcHBhcmVu
dGx5IGRlZmF1bHRzIHRvIG5yX2RldmljZXMgPT0gMSwgc28gaXQgY3JlYXRlcyBudWxsYjAgb24N
Cj4+PiBtb2Rwcm9iZS4gIEJ1dCB0aGlzIGRvZXNuJ3Qgc2hvdyB1cCBpbiB0aGUgY29uZmlnZnMg
ZGlyZWN0b3J5LiAgVGhlcmUncyBubyB3YXkNCj4+PiB0byBmaW5kIHRoaXMgb3V0IHVudGlsIHdo
ZW4gSSB0cnkgdG8gbWtmcyBteSBudWxsYjAgYW5kIGl0IGRvZXNuJ3Qgd29yay4gIFRoZQ0KPj4+
IGFib3ZlIHN0ZXBzIGdldHMgbXkgZGV2aWNlIGNyZWF0ZWQgYXQgL2Rldi9udWxsYjEsIGJ1dCB0
aGVyZSdzIG5vIGFjdHVhbCB3YXkgdG8NCj4+PiBmaWd1cmUgb3V0IHRoYXQncyB3aGF0IGhhcHBl
bmVkLiAgSWYgSSBkbyBzb21ldGhpbmcgbGlrZQ0KPj4+IC9zeXMva2VybmVsL2NvbmZpZy9udWxs
Yi9udWxsYmZzcGVyZiBJIHN0aWxsIGp1c3QgZ2V0IG51bGxiPG51bWJlcj4sIEkgZG9uJ3QgZ2V0
DQo+Pj4gbXkgZmFuY3kgbmFtZS4NCj4+Pg0KPj4NCj4+IHdoZW4geW91IGxvYWQgbW9kdWxlIHdp
dGggZGVmYXVsdCBtb2R1bGUgcGFyYW1ldGVyIGl0IHdpbGwgY3JlYXRlIGENCj4+IGRlZmF1bHQg
ZGV2aWNlIHdpdGggbm8gbWVtb3J5IGJhY2tlZCBtb2RlLCB0aGF0IHdpbGwgbm90IGJlIHZpc2li
bGUgaW4NCj4+IHRoZSBjb25maWdmcy4NCj4gDQo+IFJpZ2h0LCB0aGUgcHJvYmxlbSBpcyByZWFs
bHkgdGhhdCBwcmUtY29uZmlndXJlZCBkZXZpY2VzICh2aWEgbnJfZGV2aWNlcw0KPiBiZWluZyBi
aWdnZXIgdGhhbiAwLCB3aGljaCBpcyB0aGUgZGVmYXVsdCkgZG9uJ3Qgc2hvdyB1cCBpbiBjb25m
aWdmcy4NCj4gVGhhdCwgdG8gbWUsIGlzIHRoZSByZWFsIGlzc3VlIGhlcmUsIGJlY2F1c2UgaXQg
bWVhbnMgeW91IG5lZWQgdG8ga25vdw0KPiB3aGljaCBvbmVzIGFyZSBhbHJlYWR5IHNldHVwIGJl
Zm9yZSBkb2luZyBta2RpciBmb3IgYSBuZXcgb25lLg0KPiANCj4gT24gdG9wIG9mIHRoYXQsIGl0
J3MgYWxzbyBvZGQgdGhhdCB0aGV5IGRvbid0IHNob3cgdXAgdGhlcmUgdG8gYmVnaW4NCj4gd2l0
aC4NCj4gDQoNCml0IGlzIGluZGVlZCBjb25mdXNpbmcsIG1heWJlIHdlIG5lZWQgdG8gZmluZCBh
IHdheSB0byBwb3B1bGF0ZSB0aGUNCmNvbmZpZ2ZzIHdoZW4gbG9hZGluZyB0aGUgbW9kdWxlPyBi
dXQgSSdtIG5vdCBzdXJlIGlmIHRoYXQgaXMNCnRoZSByaWdodCBhcHByb2FjaCBzaW5jZSBjb25m
aWdzIGlkZWFsbHkgc2hvdWxkIGJlIHBvcHVsYXRlZCBieQ0KdXNlci4NCg0KT1RPSCB3ZSBjYW4g
bWFrZSB0aGUgbWVtb3J5X2JhY2tlZCBtb2R1bGUgcGFyYW0gWzFdIHNvIHVzZXIgY2FuDQp0ZW50
YXRpdmVseSBub3QgdXNlIGNvbmZpZ2ZzIGFuZCBvbmx5IHJlbHkgb24gZGVmYXVsdCBjb25maWd1
cmF0aW9uID8NCg0KDQotY2sNCg0KWzFdIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWJsb2Nr
Jm09MTY1MDMyMDEwMjA2ODg0Jnc9Mg0KDQo=
