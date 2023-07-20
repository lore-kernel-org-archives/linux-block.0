Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1355AEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 05:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGTFbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTFbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 01:31:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E31710
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 22:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYs1oTYWLYA2H/qyoDmZCmoQOeEtL2O1JK0vDM0Dayi+4P9MxGZlv9tV+DVoRUyGF7w2cDCkeBb+1MAJKpg080ueTH7AE1fZOdWwpDW9xUz27kh0AfhvVde+yEQBrbk8ebDWW8TOv6M74yHcb1obY4wHulk/ACksHAxtLnL3s1/Vc5bmGJnZateaOS+DaC6gTLcZFkT24qbvFF3ip1HCq4yqgHyIY8Z9wwZkC/FqXKsh2ZRYGHSnMmYlTpq+8tkFE/R4C2JwTk357nqxswhhkXEKInmcgK4fSzoLLdMSftTcfX7mENpNiVTMjy4a+hyf+xCciZ5I+LfGznJyZi2ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYHOho6ygvPn7QBvnp/lIs1tGwYalTrOb5n9ml4wLEU=;
 b=QPIZxaAIfy6ck3ghsWrAgHTSgj6yCrUlRXLHbc9E5Whz85u3a7+Ov1lyEA5AX1aGkrhhz1UvieewzT0e5oet2OYsxBkaiaswy5ezMepPAbcYGY4W9+bV66VlY2lbQTKtoaoa8yaYNTNQorOtRWdDSpbJ8Mk3XDSjzqqbNaRlsmU1uceWMMdpNQBAyCX010qqrFgNgk2BWECA2e6GDUz15+eXYJ/DctujkvdKv7FbxIMHpZM6MS9ogrTWGORKVVUlOGIEm1mZvxk7/H0xYx6RvhojRwTnkPpNMb8mC9MNvnHOZV96e8yw+5BUhkpTqPvD6gQqOs+d3iz01VCFdqhM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYHOho6ygvPn7QBvnp/lIs1tGwYalTrOb5n9ml4wLEU=;
 b=rXukEnki1tpiWpQGzMtDsAZw/fRcUomG8WwSxCaySa25fsEFcW8UM937HQ3SaJCPiHWG3gIR+6/PqFa34KENuUAHUbs6kwJ5yynHrBkJvdzi1iFFatk1SyBm20MDQS509yiRbooiaaaPV1KW//M+RoMHSqCxF8YAG2HVyK8lDp3UCZDXAPw1gUTy3TQgtHgOeUtK+Fv5TLes1sa+jpZny81K6EyJlK+TW2mkLbmwHwu8KIs76N43RMF0syD8R5FyjOSiK3etJx3vGAUUKy5n9w+T6RH/1aP0iSbWO+T+knqvZNlZPqNT9qbH3ChNbgBV/fdkAKenWqVA+bwxtqwyUQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 05:31:00 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::5484:e893:c045:d3f4]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::5484:e893:c045:d3f4%6]) with mapi id 15.20.6588.028; Thu, 20 Jul 2023
 05:31:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] brd: implement write zeroes
Thread-Topic: [PATCH 3/3] brd: implement write zeroes
Thread-Index: AQHZun7OEB9FzcLPl06+3qRAEA19d6/CIb4A
Date:   Thu, 20 Jul 2023 05:30:59 +0000
Message-ID: <a38eaa35-efc9-48e2-7aaf-9eed83589103@nvidia.com>
References: <73c46137-c06e-348f-3d37-8c305ad4c4f3@redhat.com>
In-Reply-To: <73c46137-c06e-348f-3d37-8c305ad4c4f3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|SJ0PR12MB7006:EE_
x-ms-office365-filtering-correlation-id: 41cea78c-571f-45d9-a210-08db88e2804e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4K1t3rmIAeB68JFOcWRFya6wYW4xnqYj6STS/jWGU9c8icq2+U8OAp5ZX+Kl7jjp8jAF892Yhpi9VQ82wZZZv4wIH1P5Nm5poRe1ytA69mw1J49QtqNuY5NrVLPj1yRPhrkZTZXoI1F+zXiKDnMP9bUZYb0aQbNTbw6eKbssj08tpkHZa8b+AL0qnU60FJcN6BMtcgKxYx/lA43EK91dR1s3hcIoXdUUhTpfVvheUsvRsyyxOaQUz1+7u2K6nFc8Yhr7dYjebYIYZrC7nia3rH2Nj/7MWLDp/GkTOy5PXDs/+wufeaNW6pmYPcBaLFQ5jLQgBctBk7yAFkra4GAIWBJkNKgtYc6Y7kr7eYRtaOyloRUeYMivsng3aJZE8pMQsgdSON7VaUd5U4pnSAGrg484/6IAv8pyRflFTVSH26ZjGqQasYnYXt7d7gNcXPCqtmskKpIu6FXUoSWPAOLlaNjbvQjSLCsul5RjCJY25mMfPDMqTo2X5DRzMLLEOSFXSEdX0VjqwnqIeyhHZmYDMzx23KiQicJRlTSvXPpgtLSAxkj2OYmhOurn/65/2YanL+EKX8+GtiFLNr6wpOgq9Ju5JlBqco1wb++4DS/T1qzWyUI+616yEo4LTw4fHE6NvYcMLrqD3hRPrTuG6ojNjYynZnXwAEpl0hGCgwjM8U57xg6N4V9hjmQ68f+uIYb+bBHSiYUNHq4CaOO69+F+BfQx+aCO7/nfEk3iuSHTQUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(83380400001)(2906002)(2616005)(86362001)(36756003)(31696002)(122000001)(38070700005)(38100700002)(4326008)(316002)(66946007)(6916009)(64756008)(76116006)(66446008)(66556008)(66476007)(71200400001)(91956017)(84970400001)(41300700001)(53546011)(186003)(6506007)(478600001)(31686004)(6512007)(6486002)(54906003)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVB4cUpMWlRNZWhQblRzdTMvK2VMak9uMmowenJvSDIrYUdPNGc5VHRwc3Vv?=
 =?utf-8?B?cWVDTFhWUGVYRjVpZHRablZlQXUwK3IxSlBkZW9haXMzUjEvZXByOFY2Rkk5?=
 =?utf-8?B?SXMwazNkdXppTWQ1ZTJVSUxyUHdJZHhacTB0NVQ5QUJHSk91aUlDZzRPa3M2?=
 =?utf-8?B?ak01TmF5MHBmbzZRME1vTkNEZjFOUlhwQWY1SFVScDdqd2JsNnhlQVVMVVJy?=
 =?utf-8?B?VUppRGxMVjl0K3I4U1pIT3B0M2FQOHpRSU1qTkJsUnFWeHZGUVVwb1N2UGt5?=
 =?utf-8?B?dzVmaDFtKzQybHRKMy9wSkthVGE1czExVVBZcXZFbTNFb1NvSkVxcmh5M2Fj?=
 =?utf-8?B?S01TOVVGYVBXVlhYQ1pXSUZDVHVvcDFLa0EwbVczWUsyR2ZCUW5YR2g3MEpE?=
 =?utf-8?B?cUk5a0RkZzhrVzVYc3Q4aGp6Snd6MncyYjBUeEUzK216bGJZZG5xekE1MjZK?=
 =?utf-8?B?TWUwdDFqSlFoYmlnQU5kTk5HTDRRa1VNdWxyanZMZEsrbFBOU3NtUWFsSWhm?=
 =?utf-8?B?UjZPc0lyZGVjRFllQlRORk5wYTBpU2hVYkI3czExRjZDd3g2ZUtZNWs2cCtV?=
 =?utf-8?B?L3JoejFOOVh2ZGFqM2R6RHgvdCtuL3VZSkgrZlJHNlZDODd6UUI5clVoV3VP?=
 =?utf-8?B?enlZa1NSYW9YN1NCeHczWlRmWUNLVlQwU3lDdmVkOW1OMHV6dE0rQlRLNDVs?=
 =?utf-8?B?RFFFaklmajdRYnNDYkQwbkU1RXZOZkVscllIZ2FPNEk4MEIremZ6TjhSVnU3?=
 =?utf-8?B?aCsrbnBRekMrYno5dEc0V1ZYUU5OczhVRFFwa3g5RnJpTnA0T05pZXMvZ2dx?=
 =?utf-8?B?V1ZrUHNnTEVnYU9DUlltem1ZdFdCT3JJN1VFdTR5Ry9HTUkvWDZYVnF2V1NQ?=
 =?utf-8?B?c3NwNWxyZmxPc0h4dmttSWRmc25HQnNCTW5ZSGc0TkkwWEZwM1ZvWnQvU21H?=
 =?utf-8?B?UWowU1I3dmRTUzhIWHJNd3U0SnpadWxXOFJDM05tRGI4a3VCTHBDdXpPZTdi?=
 =?utf-8?B?Si8vMGIxa1N1V1RkYlJwUlZwNlhKWWg4bjlUM1N1YnVOV2puT29WSUI5Y1Ra?=
 =?utf-8?B?d09XdklSWkxCK0RRNmdNSFZVQVdrTUdBSjF3SDZQK2RhR3l6Z3JaaVZOanVx?=
 =?utf-8?B?MHBTb0Q3aVlqYXJDaGxtWDN6ais2YUUxZjN1Z29VdVgxaWplMFkvQ0pRejB6?=
 =?utf-8?B?UnNYR1dCeS94NmVqc0RmdVJnQkYyYlQwVGdyaWZhWVpQRGxYVXVHWFJrNzRl?=
 =?utf-8?B?bkV3QkRYOGIxWmh5NFIyM0N5dSthZVA5ZlV5WU9EM3dnMmlMR0lEZjBWVHpn?=
 =?utf-8?B?enpRQTFrTjhHNDF4UjFZS3NkMVFsTEpNL2VQU0NBS2ZJUmo1NkU1NFVzSXdT?=
 =?utf-8?B?UFlRUzlxRlVtNldkQjhQcythaCt4WHBUWDVlenhaQ0NtMis2cllXNWV5dGpk?=
 =?utf-8?B?TXhmNkU3blpFM2hNcm1OT2gvVTc4ZHdyaEM0dnpSNFNMVGQ0N3gyTUs3TkQr?=
 =?utf-8?B?NEE4dk0xODREWUJjOWVEM3FvK3hqYUtyWHhzLzNZcmVIWGJhOThBM2pnSFo4?=
 =?utf-8?B?azFqQlhQSmZsTFJOL1dVT0pUNTNwKzdaQk9Icyt5Z0tVVStVUlQwd091YXls?=
 =?utf-8?B?Rm9KaXZobE5BcXRJUWhUSVMzRnpzYXlLenRIWDJkK3IyMlg3ck80QTdZVmtZ?=
 =?utf-8?B?eHlHb0ZjOFF0bnNSUE52Y2RMUlZlcWUxOG14a3p3eTBlcHAvYUhzR29aMUJm?=
 =?utf-8?B?dnZmUEV0QXNHdzhEaUVjSDkzSGQ3ZnQ5Sml1SC9md1BZcnRub2NPUWF2Tlk1?=
 =?utf-8?B?TmlVTXdoN01rUzU5UzBSWURGV0QvcDh0T2czNnVNZGxHYloyV2IyTDBJcElP?=
 =?utf-8?B?azl0UjUrZjlkWkUzUm9jQ3Nrb3BuVVlha3dzVWxhNFBBd05JWmxVcUFYZ3hp?=
 =?utf-8?B?ZGRxaW15WnRweERqRWFYS01qWTJwdzQ0NmdIZFNNdHlmeWFPVGVnUGpiR3gz?=
 =?utf-8?B?aC82TVY3UDZ0N1U2YnFIUnRSK1o2YlRXNDN2SVo4QlJtSHFUNEcvSjMxOU1C?=
 =?utf-8?B?dy9KWUJDa1FEOFdCY0lGc3ZyVXFGV0FGOXhCbHkyTk55Z0V4dCtpUzBWTGVG?=
 =?utf-8?B?cmhLMVQ5Y1cxMWRHaEIvTURpVXNhUUlHYkpTNnYyNGRzVzd2Um9Db3BubC9O?=
 =?utf-8?Q?F2swu4ZPtQJwQ1ScznEHQrL65lePl4L9D/Wu94Coynz/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21AAFD1E3F92044F9D88A3BF9F8A7155@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cea78c-571f-45d9-a210-08db88e2804e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 05:30:59.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Am1Gm4pmb+1pSWk0MooOEUduE56h3L4ImWMuucfKxRioAmhoaQTWSjvCpHi6aACuQ8RCp1ecWHmpZa3SYPCtLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8xOS8yMDIzIDE6MjEgUE0sIE1pa3VsYXMgUGF0b2NrYSB3cm90ZToNCj4gVGhpcyBwYXRj
aCBpbXBsZW1lbnRzIFJFUV9PUF9XUklURV9aRVJPRVMgb24gYnJkLiBXcml0ZSB6ZXJvZXMgd2ls
bCBmcmVlDQo+IHRoZSBwYWdlcyBqdXN0IGxpa2UgZGlzY2FyZCwgYnV0IHRoZSBkaWZmZXJlbmNl
IGlzIHRoYXQgaXQgd3JpdGVzIHplcm9lcw0KPiB0byB0aGUgcHJlY2VkaW5nIGFuZCBmb2xsb3dp
bmcgcGFnZSBpZiB0aGUgcmFuZ2UgaXMgbm90IGFsaWduZWQgb24gcGFnZQ0KPiBib3VuZGFyeS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pa3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FAcmVkaGF0LmNv
bT4NCj4gDQo+IC0tLQ0KPiAgIGRyaXZlcnMvYmxvY2svYnJkLmMgfCAgIDIyICsrKysrKysrKysr
KysrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IEluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9ibG9jay9icmQuYw0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+IC0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL2Jsb2NrL2JyZC5jDQo+ICsr
KyBsaW51eC0yLjYvZHJpdmVycy9ibG9jay9icmQuYw0KPiBAQCAtMjcyLDcgKzI3Miw4IEBAIG91
dDoNCj4gICANCj4gICB2b2lkIGJyZF9kb19kaXNjYXJkKHN0cnVjdCBicmRfZGV2aWNlICpicmQs
IHN0cnVjdCBiaW8gKmJpbykNCj4gICB7DQo+IC0Jc2VjdG9yX3Qgc2VjdG9yLCBsZW4sIGZyb250
X3BhZDsNCj4gKwlib29sIHplcm9fcGFkZGluZyA9IGJpb19vcChiaW8pID09IFJFUV9PUF9XUklU
RV9aRVJPRVM7DQo+ICsJc2VjdG9yX3Qgc2VjdG9yLCBsZW4sIGZyb250X3BhZCwgZW5kX3BhZDsN
Cj4gICANCj4gICAJaWYgKHVubGlrZWx5KCFkaXNjYXJkKSkgew0KPiAgIAkJYmlvLT5iaV9zdGF0
dXMgPSBCTEtfU1RTX05PVFNVUFA7DQo+IEBAIC0yODIsMTEgKzI4MywyMiBAQCB2b2lkIGJyZF9k
b19kaXNjYXJkKHN0cnVjdCBicmRfZGV2aWNlICpiDQo+ICAgCXNlY3RvciA9IGJpby0+YmlfaXRl
ci5iaV9zZWN0b3I7DQo+ICAgCWxlbiA9IGJpb19zZWN0b3JzKGJpbyk7DQo+ICAgCWZyb250X3Bh
ZCA9IC1zZWN0b3IgJiAoUEFHRV9TRUNUT1JTIC0gMSk7DQo+ICsNCj4gKwlpZiAoemVyb19wYWRk
aW5nICYmIHVubGlrZWx5KGZyb250X3BhZCAhPSAwKSkNCj4gKwkJY29weV90b19icmQoYnJkLCBw
YWdlX2FkZHJlc3MoWkVST19QQUdFKDApKSwNCj4gKwkJCSAgICBzZWN0b3IsIG1pbihsZW4sIGZy
b250X3BhZCkgPDwgU0VDVE9SX1NISUZUKTsNCj4gKw0KDQpJcyBpdCBwb3NzaWJsZSB0byBjcmVh
dGUgZGlmZmVyZW50IGludGVyZmFjZSBmb3IgZGlzY2FyZCBhbmQgd3JpdGUNCnplcm9lcyA/IEkg
dGhpbmsgaXQgaXMgYSBsb3Qgb2YgbG9naWMgYWRkaW5nIG9uIG9uZSBmdW5jdGlvbiBpZiBldmVy
eW9uZQ0KZWxzZSBpcyBva2F5IHBsZWFzZSBkaXNjYXJkIG15IGNvbW1lbnQgLi4NCg0KPiAgIAlz
ZWN0b3IgKz0gZnJvbnRfcGFkOw0KPiAgIAlpZiAodW5saWtlbHkobGVuIDw9IGZyb250X3BhZCkp
DQo+ICAgCQlyZXR1cm47DQo+ICAgCWxlbiAtPSBmcm9udF9wYWQ7DQo+IC0JbGVuID0gcm91bmRf
ZG93bihsZW4sIFBBR0VfU0VDVE9SUyk7DQo+ICsNCj4gKwllbmRfcGFkID0gbGVuICYgKFBBR0Vf
U0VDVE9SUyAtIDEpOw0KPiArCWlmICh6ZXJvX3BhZGRpbmcgJiYgdW5saWtlbHkoZW5kX3BhZCAh
PSAwKSkNCj4gKwkJY29weV90b19icmQoYnJkLCBwYWdlX2FkZHJlc3MoWkVST19QQUdFKDApKSwN
Cj4gKwkJCSAgICBzZWN0b3IgKyBsZW4gLSBlbmRfcGFkLCBlbmRfcGFkIDw8IFNFQ1RPUl9TSElG
VCk7DQo+ICsJbGVuIC09IGVuZF9wYWQ7DQo+ICsNCj4gICAJd2hpbGUgKGxlbikgew0KPiAgIAkJ
YnJkX2ZyZWVfcGFnZShicmQsIHNlY3Rvcik7DQo+ICAgCQlzZWN0b3IgKz0gUEFHRV9TRUNUT1JT
Ow0KPiBAQCAtMzAyLDcgKzMxNCw4IEBAIHN0YXRpYyB2b2lkIGJyZF9zdWJtaXRfYmlvKHN0cnVj
dCBiaW8gKmINCj4gICAJc3RydWN0IGJpb192ZWMgYnZlYzsNCj4gICAJc3RydWN0IGJ2ZWNfaXRl
ciBpdGVyOw0KPiAgIA0KPiAtCWlmIChiaW9fb3AoYmlvKSA9PSBSRVFfT1BfRElTQ0FSRCkgew0K
PiArCWlmIChiaW9fb3AoYmlvKSA9PSBSRVFfT1BfRElTQ0FSRCB8fA0KPiArCSAgICBiaW9fb3Ao
YmlvKSA9PSBSRVFfT1BfV1JJVEVfWkVST0VTKSB7DQo+ICAgCQlicmRfZG9fZGlzY2FyZChicmQs
IGJpbyk7DQo+ICAgCQlnb3RvIGVuZGlvOw0KPiAgIAl9DQoNCmNhbiB3ZSBwbGVhc2UgdXNlIHN3
aXRjaCA/IHVubGVzcyB0aGVyZSBpcyBhIHN0cm9uZyBuZWVkIGZvciBpZg0Kd2hpY2ggSSBmYWls
ZWQgdG8gdW5kZXJzdGFuZCAuLi4NCg0KPiBAQCAtMzU1LDcgKzM2OCw3IEBAIE1PRFVMRV9QQVJN
X0RFU0MobWF4X3BhcnQsICJOdW0gTWlub3JzIHQNCj4gICANCj4gICBzdGF0aWMgYm9vbCBkaXNj
YXJkID0gZmFsc2U7DQo+ICAgbW9kdWxlX3BhcmFtKGRpc2NhcmQsIGJvb2wsIDA0NDQpOw0KPiAt
TU9EVUxFX1BBUk1fREVTQyhkaXNjYXJkLCAiU3VwcG9ydCBkaXNjYXJkIik7DQo+ICtNT0RVTEVf
UEFSTV9ERVNDKGRpc2NhcmQsICJTdXBwb3J0IGRpc2NhcmQgYW5kIHdyaXRlIHplcm9lcyIpOw0K
PiAgDQoNCndyaXRlLXplcm9lcyBhbmQgZGlzY2FyZHMgYXJlIGJvdGggZGlmZmVyZW50IHJlcV9v
cCBhbmQgdGhleSBzaG91bGQgaGF2ZQ0KYSBzZXBhcmF0ZSBtb2R1bGUgcGFyYW1ldGVyIC4uLg0K
DQoNCj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ICAgTU9EVUxFX0FMSUFTX0JMT0NLREVW
X01BSk9SKFJBTURJU0tfTUFKT1IpOw0KPiBAQCAtNDI1LDYgKzQzOCw3IEBAIHN0YXRpYyBpbnQg
YnJkX2FsbG9jKGludCBpKQ0KPiAgIAlpZiAoZGlzY2FyZCkgew0KPiAgIAkJZGlzay0+cXVldWUt
PmxpbWl0cy5kaXNjYXJkX2dyYW51bGFyaXR5ID0gUEFHRV9TSVpFOw0KDQo+ICAgCQlibGtfcXVl
dWVfbWF4X2Rpc2NhcmRfc2VjdG9ycyhkaXNrLT5xdWV1ZSwgcm91bmRfZG93bihVSU5UX01BWCwg
UEFHRV9TRUNUT1JTKSk7DQo+ICsJCWJsa19xdWV1ZV9tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMo
ZGlzay0+cXVldWUsIHJvdW5kX2Rvd24oVUlOVF9NQVgsIFBBR0VfU0VDVE9SUykpOw0KDQphYm92
ZSBzaG91bGQgYmUgbW92ZWQgdG8gbmV3IG1vZHVsZSBwYXJhbWV0ZXIgd3JpdGVfemVyb2VzLCB1
bmxlc3MgdGhlcmUNCmlzIGEgcmVhc29uIHRvIHVzZSBvbmUgbW9kdWxlIHBhcmFtZXRlciBmb3Ig
Ym90aCByZXFfb3AuLi4NCg0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIFRlbGwgdGhlIGJsb2NrIGxh
eWVyIHRoYXQgdGhpcyBpcyBub3QgYSByb3RhdGlvbmFsIGRldmljZSAqLw0KPiANCg0KLWNrDQoN
Cg0K
