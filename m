Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEECC41513
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHHU0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHHU0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 16:26:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8B132E0
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 12:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtRGdNvIBr9KS+LMfrWEVt4YW5BUOxoUq/pWQ5GfNdWizz56LoE9Xwdeh2R0l4dyyN8tvV3l8LrXgcub0FUSxS00QHFThvnfzy085IkdjJA3Wr86F/XmfgPOKdv29mVeSb6PSabGpoK5/REHuZfGqvqsuK4ji6Y/rTiNzqk9kY7ndUWW73jeyr/UnxZK99WvY5dAok9GIrnZng3vvSor11anZC01W6AtUqhZOVbPpGVswsGKhfNxIfjM3w/6WWZCdKcIkG8nfDd8K11/PWvZtxruWIv22Zc/lhs1ZwwS5ipB/uoOJXnr4ucdW7SbcxoPaSz4mo6bZs9fyLiVbcMO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMJsNKQUZtymdHH2GIIDBH9pJZkNnJpqIPPKhUU2X6k=;
 b=U7in6K/xvj1VhHwcOUXHzSwpff8X3panp0ebeikbLaOwKJ9cm9TCRplRkaRXydgGQGVwVQTwOVS7ItYvXdciEeQNI+ZxThswQ4yLHsIdRiyhCsJB3t1rBFVx95mwlbheZDx33RY52mPJS6o44S89cx7XIZNwbjjkzm6+wKqZ4WN8UPBgjb4pAwtWVmBJH2okIWpUdn7OVYzsnxwFPcayampj2VmTyw7Ib3C/nRQ1BrP1N1ABjQBFgp3QwcnGOtCOM4rNuEfDievQ9G/069AZ1SSzdi10fe7INlXwWUjmUIDBMt1aUrMFV5S1HUTPnH2MuG2GBW6xWbxwO6QuAmK6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMJsNKQUZtymdHH2GIIDBH9pJZkNnJpqIPPKhUU2X6k=;
 b=ZYrRcoC6Vje9b7A7rVAejbIZY9Fjd3CijMpwvLV2iwe9PhoAq0vcEQZ8x6nujj2cmNClBKEwLz+bHgiPoS3CYfUeydB+i5saOKgM4amTFl8l9xYN/za+zpJx5t/RG//MnfcKlZBRUYy4NdLddltePrddhKKcJ4QPcrHp3LQQMK44+i/xwrj/qV9aGE74F5dbqpDvx/FCQptGOkeR8GrVcLfFjf0y94RAZTcpeGnYUKbnGroKVNRxjoTONRF1TsM6pzawFtcomo5uy4a8rXLeABPKYJCTxtlKZEO/cLvL4uubo9d34bnznMhWp0dte6dZYwHyp04wPqgG+DOQxs7gwA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:39:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:39:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: get rid of unused plug->nowait flag
Thread-Topic: [PATCH 1/2] block: get rid of unused plug->nowait flag
Thread-Index: AQHZyiOmE7S65bfMD0CSWlcLRuMTIq/gy9EA
Date:   Tue, 8 Aug 2023 19:39:29 +0000
Message-ID: <5309a2c6-8165-4c50-4e2f-95e66e800ff5@nvidia.com>
References: <20230808171310.112878-1-axboe@kernel.dk>
 <20230808171310.112878-2-axboe@kernel.dk>
In-Reply-To: <20230808171310.112878-2-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5111:EE_
x-ms-office365-filtering-correlation-id: 94768d9e-14d4-487f-8255-08db98472ec5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qyGSiFNPUI+nSDu+d0zzqx4dJiy16unAuMdEdXGmSg2ZwLXuD1K7hbelLeu0G132hae0lg4v3y+NLdfKtBbrw7uHglTh9bqo+S2CrQAiWOND7q9nolAdW0OrrZnlDAyNdOOA+8NcX3sNBFhWp5SpCw8kT20K0Lx8B01K2V88zRBIyvUoaMo1aZfVhjd3APt6LMgJXTIx3G7hUjS9HCgIBjhdryu6gDciVcV+iPz26yGCl+oSn60qB7DvuLk66QoNx9IhJqngnoCVzQ7ys/Fkn+MhotfmQr2gYiH9i2y6iNMOzJKZfFM2O0l2+Aw5gbm97b3gtd188XSG3KrojGfKjardjSiwWecP5cOOdy5XttbpsPEQnH/2aoLi1SX4PwtDsJho11PD8LJ3TjnWPtM5+xPdjrKznk+6yxjUs54lKdVpuxvRs4UVlxnRbDQF+4YIrzYM40ybb/p/u/4aD9+6Uor3YIskiLHC14lVYjR5l92du7oBI1m5GRDjJaA5LITuk/+pgQncqBuZinFfXvnvZ8aUkerMwlWFHKisaiL+bYOETGB3s1KZEbN43pkXCemhIlrAo0xHqBEpiCeZ6sxGQYhqPrMb+2Gxl081diuvEHGjEiWwOEhDbK00WE01zGHObaSi5c0HXy1coXGNxNIcWcS2VA5rh+OTA6u2xWwO/o06dn4/1bZhM+xXcok64HwW1s5bTFSb0UO34Ovo704ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(186006)(1800799003)(451199021)(2616005)(122000001)(478600001)(83380400001)(31686004)(6486002)(53546011)(6512007)(26005)(6506007)(66946007)(76116006)(91956017)(66476007)(66446008)(8936002)(316002)(2906002)(8676002)(31696002)(66556008)(41300700001)(71200400001)(64756008)(110136005)(38100700002)(36756003)(38070700005)(558084003)(86362001)(5660300002)(26583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWU2VitDZ00wY2FqK2djTUZvU2pmalREN0ZoMUt2MGpqMElOY0ZYNGZhdW1Q?=
 =?utf-8?B?OWZxZU5GZHRlZktVS0prR1dVbmdvZXJ4ZnJaVmhiUGtuRHVJd1VoYW1DM1R5?=
 =?utf-8?B?RS9DR0RWQWpZanlMcnpGN0tJeEVkdEtpTVRybmVRUmZqcmhpejFGVUVTWFVY?=
 =?utf-8?B?UFBLWHloWlU1WkQ2ZE8xR3dFQzB6Yld3NS9IWUdaN2IvNDVFdTU1V0VvdVVF?=
 =?utf-8?B?WWN5SXZ4Z003b2dackpFK3pJczB6U0EwcUVJTHVQQnVFdHZuNmRVRGNmaExZ?=
 =?utf-8?B?VXhYcGJYQ2lMRDc0bC9qbXZwRW5DaWYzaGJUTk1Dc25hdTZNZy9RTmJVTmhQ?=
 =?utf-8?B?STlCSFQyeENzV1hTQTQwVUU1c1N4bE5ISkJ2dWZGN3FmTzlkaXFlbnZtR0M5?=
 =?utf-8?B?Q0hXS1JMN21lL0FCK255YWVlZUVKK3M5cSthSU94MEM2TmNXRzAzTEE4cFE4?=
 =?utf-8?B?dzZ0andhbzNFSHZKaWkrOGxrQTM4Tm1KVmFOOGl1QUJUUkdRWFhCbjZ1ZDRa?=
 =?utf-8?B?aVJ4MTBmWHhsT3Q5UnJzYllCRXVFUGxGYjVIM05lcjBMQVpBek01UkMvZ2VS?=
 =?utf-8?B?RTYyZlZoQ0o5WlBTcWlYTGx2N3JVV1FQaDFmZStrMnA0QjFGZnErdE1paG1E?=
 =?utf-8?B?dTM4TzhiWjBXYkNpRUFxczZlQkk0WEk3Mi9VMHA1cExha3E0UzZqR1NsWmF1?=
 =?utf-8?B?RDBqSktsY3N0Wjd1bUxTUFhpSXVZa2Y3RzVVYXlkVSt4VHZmbDZ0bXFyVFJK?=
 =?utf-8?B?YlV5cjFnSTk3THJmVHR4eUhEZTcrbXREWWUxRmVrajllOTMvUTRMZVpJMlEz?=
 =?utf-8?B?SllUeU0yc2RneE9Ya2UwTG94R29WVmpsMWJ0OHFGa2lYVFExb3dKaDNIRVps?=
 =?utf-8?B?M3l3bURTK29JOEI3TmYyVWdTbWM4djk2MHU1bm5FNzBsTUdUdmt4L1YxTEZJ?=
 =?utf-8?B?bnowenVYMHJSY3FhTllYNFJPaGNVamxqVXEvdmx3NDBydlBHUFYzNEUvS0Fu?=
 =?utf-8?B?YW1uT2lwZlFOd0pOVWp1d21kUGZPeEFESVZaTXJmcGY5cW5VVmQzajVFSm1T?=
 =?utf-8?B?cnpvRld2cEFwTTBrcDBQZlBMSFV2MEZMbHhyY0J1QkFGRmovSHh3NUNSak1p?=
 =?utf-8?B?c2NUa3RMRUhqSHYxQ2hFL1VPNlR2cjBnUHdqYXlYSkxrOC9iMFpPNGU1ZE4x?=
 =?utf-8?B?RHNZMkgyc1gyaFRoWmtFVWRQZisxZ0drMGJ4TXo1WkdiTUczTGtaMysrcHZP?=
 =?utf-8?B?OVcraFRCTm5mSXZtQm4wVjVQczBZOXhnY2dQYUhBVXFiZXhxcGpZM3lWeGhZ?=
 =?utf-8?B?ODExREFHck9VS0hLdzlwcHpwbWF6aW5YR3QzaXk0RTdzL3lUaUtTU1Raazh3?=
 =?utf-8?B?QlZueGZzWlRFMzA4NlJLOUZ2blBvOWZrYjNzZW5oNW8yWlhQM09aMWdHLysw?=
 =?utf-8?B?aWhFTUkxbmxuTVUraXR0Kys3eTJ6djRwbmoyd2JkeThqMS9ZYUdPWStyQTRY?=
 =?utf-8?B?MjJmbzUwOFBiMmovbFl4N0x2WlFReEJ2cHBMZkJ4TGVnL0hJbmRKVUJrY1hI?=
 =?utf-8?B?b1hubFJxbldwekl0MTVBUlJzTGdJWFAzUHJOMmhXcnpOaHhCMzdqQXA2VTJh?=
 =?utf-8?B?M2c5N3JMOElnY1V1Q3RMVzVwZmN0NXJ4TWp5WmROZGQ2akpGeFZqMUVvWmwz?=
 =?utf-8?B?bGZ1Z2pGN2JTcGFMeVVwTXpsdGl6R29JbkFQZFRwRlVNdmdBeU9qTTNjTDdY?=
 =?utf-8?B?V1c5UEdzKzJDUklINWRxYnNydHhLSG1QTGpUZ0pFMk5idWpJWS9RMzIyVnBU?=
 =?utf-8?B?WjlmUkhIR3RlaWFheFlxU3VXZCtZYkhPK3JMOWQxa2dMWHhaQi9ySk9weUJS?=
 =?utf-8?B?SHo5VHhkcWZsby9nYjZKZWF2MC9VSzNrV09CaitWSXlnSGtoZWEzMmJRRVhp?=
 =?utf-8?B?QUZtOS93THB3SUV4T0lraWtVaXQxbHJRdHRqQzJEa3VLMHh5Y1IrQTY4M3lH?=
 =?utf-8?B?YXNPK0ZXQzhndHZwb3M2aWp1R05GMGZOQ042Uk5Jak5Kd1o0TGRzODFLVXpH?=
 =?utf-8?B?MU5WWU5nV1J4cThVMGkzUHE0V3ZoNlIyTENSdnpIdXlrRkViR3p1RHdvQmda?=
 =?utf-8?Q?anDo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <436429DC8CA1EF4386A0EDD7BACEC680@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94768d9e-14d4-487f-8255-08db98472ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 19:39:29.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15RkaWSpxKCoD9ewua98EzWu2sQii3WYbtQ2b1ZaW8ckKHMMVE6qySlkgzV97ZgyRMhV7CXtJnA2S38W5IY7VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC84LzIwMjMgMTA6MTMgQU0sIEplbnMgQXhib2Ugd3JvdGU6DQo+IFRoaXMgd2FzIGludHJv
ZHVjZWQgdG8gYWRkIGEgcGx1ZyBiYXNlZCB3YXkgb2Ygc2lnbmFsaW5nIG5vd2FpdCBpc3N1ZXMs
DQo+IGJ1dCB3ZSBoYXZlIHNpbmNlIG1vdmVkIG9uIGZyb20gdGhhdC4gS2lsbCB0aGUgb2xkIGRl
YWQgY29kZSwgbm9ib2R5IGlzDQo+IHNldHRpbmcgaXQgYW55bW9yZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gLS0tDQoNCkxvb2tzIGdvb2Qg
dG8gbWUuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
