Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 07:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiA0Hr5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:47:57 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:40929
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237524AbiA0Hr4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 02:47:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id+Gw9mWlOQVsN/Sxe0jaUgSFIU38ghRbRyCcqaX+QHK1ug8l2lOZ3KkdXPDvOpkTfaDbEsnerpovydH1pZLc+48ldCZZyuWAo/pkomDElcaAdOI09r1CyEVDHdpNc4JdOgURWACt4ffpDHkzJn++EM2H5e+0VTlzid4Jmytj27eB5NAkXeUPWgR0SwNpadn2rM+ZXIDI8A/0Fc2YCwz7znSX1s9ikE/zlIq4v9Be6KOp6E5c4R1P0BFnDZFVHBzySzp+ijXRQ/nPOEsAUlUBHjDLo8AlQxPQq+PiUfmCQE1KzqKr++3VipfxfHxcbw9fBiOV3CJQx19ThZ/1mZ6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueZUn3jOS5JPi7t35a0bXMB7VxyFga97OyKbWC27vEk=;
 b=Lpn7vBae+tmPWescaqSdSkGKZANsDy8jKrjlWEhssnBGHlo4dlvIcJgj07FjyIXmMnSnwcS+m0go1LW5ZvDhmSMtbYxT5Rqwog0aYGWUNsdDOD63e7lEJiXFPegJD5s/EvZtZ4LzKkaUC11Tt0sVJpzxWNFgx1czb32XlYcBXcU3PLlMAZJxQyYQ0vsBdXaqXgIcxYJBa4vOU+u9CyAGjvNUzMVd2aDiQ/RJSFs5uDPrUPKq2lTCV0SK6mttLXcZG3UgVIo9rrgFJ+O5pyfBQ+w54Na6At3lgNP6UlVoK5dnC0Oji8GwLs6T0sPXGHd+EO5QBX94idzksqfArHNXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueZUn3jOS5JPi7t35a0bXMB7VxyFga97OyKbWC27vEk=;
 b=jnEJAE9dvUMRtK2JW46UDgAArjum0GVcnb/e07Yp2g2GwelVKkLec0c//gBozSG8dsi2mOscUwMBYZwBQLP5afh+6utu/G32g/Stj1zrKxg9NhYONeFbO3QJSCqyEuGrNLxrxxqnRkSAqi4WFOJRNu0+EI+0D61fQ7yzsMs4C9Rg1DbK36/TuXVh/yzNlNhUKAB11bgiTsCMhr59KZnw1tBEk1vM5eSFBrHfZTN866FoGM/u6QQ10Eq3CQXbrExK/UGoZimwDLc5vLxljnazvu1PEOGu3oJSHCnRQxnCnVJx1Ac9UR47pTgfzTvWQKX++4Qs0GiyKSro+jFwi4/2QQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3027.namprd12.prod.outlook.com (2603:10b6:408:64::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:47:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 07:47:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: check that there is a plug in blk_flush_plug
Thread-Topic: [PATCH 2/2] block: check that there is a plug in blk_flush_plug
Thread-Index: AQHYE0xYPs/myjOAy0iDs/ZVMl7zoKx2fccA
Date:   Thu, 27 Jan 2022 07:47:52 +0000
Message-ID: <0736f7e7-91fc-dce4-e37b-413846409157@nvidia.com>
References: <20220127070549.1377856-1-hch@lst.de>
 <20220127070549.1377856-2-hch@lst.de>
In-Reply-To: <20220127070549.1377856-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88388728-f3ad-4652-a74b-08d9e16952a6
x-ms-traffictypediagnostic: BN8PR12MB3027:EE_
x-microsoft-antispam-prvs: <BN8PR12MB30279A6010B7E6EE7034BFA7A3219@BN8PR12MB3027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPx24H84LI+NKyTAhFva87nZ2hMaHtmdveNLLKgg12Ts5jPJ/2eY/7FVcU4E5lmNgYhRDqpSkzJ9MMsQYdxhmKyRzfQ1XkaHFLeoUJt6KLPjweJs/NTxLMrIVvSmzmOzd2mdBtJV8f5EpunOJRJcq7l1AEC6KtWGsZZb2EYtvOfQwEoVnwuCw+DgnXsvdf4wcIUHwkBMzovVjg3bncmqXXwVRHDpkoi+9sOnFQvqUMcO7a8U+Ratmaku7BvttrQLHYQOcV+qZ9MCVPArCzNdTx3J8bObwdJIhQ9Qmjpo3mo3ILD93PrfhtrKiGcexK40Ae308EgHIHsr4ATi00c7jFGLvaqyCrFcMwFpKOQgnOOuL4T+Q5kWxLPRvvWGVZ16oHf7jOF3vUywHkcP7n2dJHL7UtbC0FyHFXx+oMIRsn3uEgClVj3PRSNOUvrB38hoXBBqVp9WDdY2PnI8QoDThMjbrqeMPGdDyP0kezpKA72+luovC0FE7VtI4VLgPHYHJCNLe3aJOw2X1kIqVGYSOU6ZV0Bnwvu7FfOjEyxLR2jzZh6U12sn25JT0ss0KeVM6+DS6/N1E6pe9Lk94Vqyje4IeDGApkbLFIPDjyJiorp66FmNZY6fAHdkzoiPPbUBDvvs3I+jqMD4bv3z7QNd+e2dSnahT50+TTHf2Dxs6h0qQvWvEFFjdz/FQb4L8H8s2o3cjL8j0DUWBxWsj1CF2K4gzhBNeN+BnfOEWG/YRCUZqeJ82H8sckFf7X3iQqkxfNzza1MvytHcdxU8LeDS/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(31696002)(31686004)(8936002)(8676002)(6486002)(316002)(4326008)(5660300002)(110136005)(6506007)(6512007)(38070700005)(2616005)(186003)(508600001)(71200400001)(53546011)(36756003)(122000001)(558084003)(38100700002)(66946007)(91956017)(66476007)(64756008)(76116006)(66446008)(66556008)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am43Vk5lTHowcDFFeDNEUUJ4NmlIUU1pOWl0OUxTcEdkRUxXTjJLcWdQbXMy?=
 =?utf-8?B?NHh2YlBuMjVNN3ZVSmE4Q2I4KzNaOWVWdzJGU1ZNZEk5VmZ4ejNZY0pWOHda?=
 =?utf-8?B?dFd2djZtSE0xeGxoSXBORGJ5NlU1VGhEVXA1N3VDQzNjd2tRT2tqcXBPaFdU?=
 =?utf-8?B?VlBSZStoUFJBdEZWVmRVdGJxNEtEeFdqbFByVXo1RGJHMXdEVDVPNmc0UGtv?=
 =?utf-8?B?cUVJYW9qOXkwUnNLaFdiTjVZSnA3OEJwdWhUTkRTSDhISjlSRFpBa0FQUzZm?=
 =?utf-8?B?ZGVVMHZEYnJHMHdUemxJdTVTRzI2b0NSSndZTHVmME1qYi9Db2c0dG4vRGYw?=
 =?utf-8?B?NWppRFhldFo1VisvYTVYdjVjMGxlMFFQMDRONlBpVTFDakg1VzBST3lzMTRt?=
 =?utf-8?B?cjIvY0Z4Zk9LVkI0a0h6b040eEhxeXBETEFBcHdqbUl5Z3IyekVaNzIxU21B?=
 =?utf-8?B?Uit2dENVb0JKYmwxMUJpc3JuSHlaUkgza1d5UTNxcDdYZlYzU28rZ3dkb2p1?=
 =?utf-8?B?cUVpa1V3S2U5MWpNZGVHakVwZGl3N0NCWjFnWC9IMUFBU2VnOC8rNGtNelFi?=
 =?utf-8?B?WjhRV3JXTm5ZRW1YNnM4OXdYZk9qUW1JaG94b3plSnQ4dklRRFpyOGhuQWp6?=
 =?utf-8?B?R3U1anQ0WldSM2ttTDFWVEFHem01L1FwdFFQWm5Md0QyT3lKM3duODVXYjhl?=
 =?utf-8?B?RVI5YTltQkgvaGlVRng2L25CS3czbUtmUGN0SWRlTW01cENzQlRaYTBDVXlt?=
 =?utf-8?B?SVlzV0ZUazNQWmJnOXM3cEQzTm5EL0RIbHhBRUNRcHVkUERNb2dKY3dseXpw?=
 =?utf-8?B?TWNUYkVEKzEreWJMbDV2R0ZjeURJais2Vld5eFNacFIxZ3k1ajJFYmdiY2d1?=
 =?utf-8?B?SGRNN1RQTjl3VWs3OUFYZlZvT0RIQzNqTnBKdkpHNnd2SlpMeU03ODg2aHBQ?=
 =?utf-8?B?RXVnbUlCUjJQZFhlOFpZV2ZMSFk0d1NSYlNLa1N0K0c3NVdLMncvT3Z3SFJ0?=
 =?utf-8?B?MVhtbU5vNWJuRWRwai9FZXNaSmRHcUtaRWFqek1qN0Q3YkpoTEVweEZFRnlQ?=
 =?utf-8?B?RUh1ZG1sK1JlZzMreFZ0YSt4L0NWVHdsQ29sRkZvS3VNSzFkcE1hQ09DMnZi?=
 =?utf-8?B?WkxXeG1NU25tYVRnZ1Y1S2syTWVoLzl6bkZwYmtzQ212bUZ5N0xmYVdBUFds?=
 =?utf-8?B?YjdvMitRVFAxZGg1ekZFb2tVbGhpRzUyRXlrZjhDWjdMZG96Nnk3RWE5WFBV?=
 =?utf-8?B?WSt5SkRDUEdLdEJIclJVajNMNWduanBPS2Q0aWZXQnRySXJFKy80RTBtOGpa?=
 =?utf-8?B?c3pSSVJIZFVnQ0ZQTFBnZlV6SURqcW9yTDYwZXV0dXRmK1k1WHBvVHQ2cllW?=
 =?utf-8?B?QnhoOW1IR3hhYVlwSVFiNVh6TnV1Z3RPaVhYVDNkYjBqL2NWaXRXbGRLbzcv?=
 =?utf-8?B?OVB5cHhoZUNiN2V6cWhqOVNERjFQSTlnM3hjOHZ4V3pJTVlpYzlSZlJ1a3E3?=
 =?utf-8?B?RzdqL1VETFczd25sSkFES3luN2JvYXo1WE9qUGY3U3lyZGN2ZndxSXlCYzZN?=
 =?utf-8?B?ZHA5SGp6QUtNeGRjdk5JM20yNTB6Tk1BeTJvTlZ4NCs1T0FLa0hvQkVmeWFj?=
 =?utf-8?B?RUJEYkVVYzNTVzJLcllySFROaVNuL2xBd052cklONWU1MnJockJFaG9JaTMx?=
 =?utf-8?B?UFJEWkVsSU1Sa2thWmpnemlqZTZMelpIaXlyUUswcXZobzZ1V0xmYWk0T3Bk?=
 =?utf-8?B?RlM0V0k3aXRuOFhoWC9aRjk1Q25rd0IzNU1rYThHNFJYMG9qbWtWM1g1eERh?=
 =?utf-8?B?Z1Z1WnIvVWdWREZwNE1kM2c2cG5MRE51T1UwRU1nZzdjWnNxOUh3ZUozYW9U?=
 =?utf-8?B?R0IxZkxFSm40UmszM09zTWlrY29vdGRwTUVFMmErdktjSVVGb1JHVDdVSDBI?=
 =?utf-8?B?U3ZtWG1KOGhQOVh4NGdRVFFXK1JESWw3VzBBZnNyQVRLRzJNRDA1NlRYMWtX?=
 =?utf-8?B?dHVxRFY5MGFydWkyMkdOY3luK2NMT0d1UG8rN1EvTmFRdkhiTjVsYkdsK0pv?=
 =?utf-8?B?eElvSjJTbzZSKzViTkVXWHJKNW00Skd2cExqY1RpL2Rkc3pIanptZitVQUNJ?=
 =?utf-8?B?VEhmaVpFcHhzalNnQXltZGhwWmV5ZEt1L0JWZFNHN0ZZSnV5VGgxT1gvRzJv?=
 =?utf-8?Q?/zS8W4gsCypdWoJAb0k1uAUHPd+Vjxn8ROJaPtyPkP+c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF6B7143DE3056458C81819B6787F10D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88388728-f3ad-4652-a74b-08d9e16952a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 07:47:52.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GmOLpjyNa9TIgkU7diBHox2eK/MBLgO+Cxfv+xDMY3vM7fwkDBtUnLzQs3q26FWfFpTFS1fSsgZuYSudffmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3027
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNi8yMiAxMTowNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFJlbmFtZSBi
bGtfZmx1c2hfcGx1ZyB0byBfX2Jsa19mbHVzaF9wbHVnIGFuZCBhZGQgYSB3cmFwcGVyIHRoYXQg
aW5jbHVkZXMNCj4gdGhlIE5VTEwgY2hlY2sgaW5zdGVhZCBvZiBvcGVuIGNvZGluZyB0aGF0IGNo
ZWNrIGV2ZXJ5d2hlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQoNCg==
