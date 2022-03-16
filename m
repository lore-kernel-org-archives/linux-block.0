Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD5C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 02:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350506AbiCPCzw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiCPCzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 22:55:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722232ED9
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 19:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYIuiY3eDtjG8yrT5/2h5fm1qXGLij1sqdR9PlPFUyzW/qQ9Dumc08JfnTiRDBD/ppwdvAB26HsEDce64BKC12+ih0VbRHqX8ntYgKJvt/Awgbv4coeAk4z8GOF9ItkpqzbIkjPAccAK7XFkSZa7D8BzjuRCdZ4ouyVxDGv2g243nJR3KeyP37zsxNBwKEnKHNhJoyFiRUNizOd/f6vdXMmYc4fHcXS0OX3eCHrq4vWoIZ4iC7+6HyfzIr9rsQtYsKTTWgJ/zqvkqVXGSpAFaoKRwEETEn2LH85gfEypmZh9i06KN7rvCyQOjdbAkbv1lDcnfxAk4mt5yEGipjD/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbMdPXZ9AV8S92AlYjXJg1rP7/61UKixnHEF6bNKL4M=;
 b=Ymkg87U/sbkJ0SBfS+8PE+e/9nVPlbp8ZdPXEK6w7CrwVQSyFsiwft3n21SPXiBYhn9ua0uLi1eRVhr5ZjM45wllX8Ox1EhtLN4Cd9n5VudkwNNokw+JfEWEf6vtSm83N9KLc2DIlT0No6HSBALUAzti8105kF5x650PSMFhDW1VGJjMF5rCLCpQyGQu18sC2Js3n/VLeHiq01ZNmnIldnkEcuvNcJtyK7JEpK4AEpQ3y0bzZCyZPeyQm8iqIhtCqxooh96DTgRgbGWzq/FOm2Cnaz5EVTcthkYwPeuczb/SKYWvLTzEpN9iHHEb6Y1tZdoaT+rk4ic1eQF7JoPfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbMdPXZ9AV8S92AlYjXJg1rP7/61UKixnHEF6bNKL4M=;
 b=dFwol+qE3P67XLr4A01YAibeCknTjOpikeunPSHa8j49abKg8dnX02NZsQ37v0WGIgqDTdihL8we0jmSaVUYbuiY2Jtq7Q5+dOK+qHRyJEEEf5gGk6Si664aRfzrzqwRwpO9VG8gEeHEX3u9xfYWecvK9jVZUQ7w61Ybw8jVuE/flJsXw2JMqRaX4fNoCls0B88zphSvTEKdTwYdKYilGRQjWmfTLsGa/Fj+IY4G1wdVy0xaFQTUqS2PEjQPd49bGwIAgVGEGWe7rE4lA/agH1ovg6gB0x9fUTDslGKTBjQOCkGnWkRtTzLmnckStHOv+eQHfFkoIuCMffXwvEHKkA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 16 Mar
 2022 02:54:37 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::f8dd:8669:b6e0:8433]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::f8dd:8669:b6e0:8433%4]) with mapi id 15.20.5061.026; Wed, 16 Mar 2022
 02:54:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] lib/sbitmap: allocate sb->map via kvzalloc_node
Thread-Topic: [PATCH] lib/sbitmap: allocate sb->map via kvzalloc_node
Thread-Index: AQHYONURAwS7rutiOEajpa7iFSj8zazBUK0A
Date:   Wed, 16 Mar 2022 02:54:36 +0000
Message-ID: <cd8cce7a-708e-fb39-bc7d-4f086bda3cba@nvidia.com>
References: <20220316012708.354668-1-ming.lei@redhat.com>
In-Reply-To: <20220316012708.354668-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de561163-9121-4c23-5745-08da06f84edb
x-ms-traffictypediagnostic: BL0PR12MB4900:EE_
x-microsoft-antispam-prvs: <BL0PR12MB49007C6EE9875F092CD28208A3119@BL0PR12MB4900.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GnVyga9QbFYJ0i3OW6fUE9V4GrCGuwWYGw6uHPH2eKsCQJYlsfvSwCJ5/yEr+ctSoA1BAjgOjO1HR4pe74hV0dZSCnn4Sw4w5rCadh/MxBLMoJWz5OKPWdSSsn/b6an7REPFgSlwg7pQHqjvjfct5uEFxTE+XNqhXEHX6f+Z79U1QCE6IjVytKXbgda2ppVD/vXeDB58cb7hqdGDG42cC9X07n3mhuerwPkQqS/85Qn5QfTA12Ko4NGtaswaMz8ARiBh7fIV0d86CxD3wKDpUx9q367Slv7LoyiGS3lHGJRUMllHKeBg8f007nw8LChMBTLveS2WdNyD6Hl7V/y5yLP7eMm/e1dtG1VZFKdcpAETFQoCfxnRwWiS+7cp+XIGGAhGWpAmEF7PeWo6nJNjikbApCEBWUo+n6mL4PcBUik5yAaCB8DQzxPVzkcedO5POBTNb8NXVmNZT1pmuW8brsCvkFL8rwh4xBKmnR0F3/mHB/aNtEbTaa2rvRPUsWxs5JzHDP9W8cET/z6JE5dLvq6GX4yEXyg8oW6/ozsQLkwDXLOBeOUeE7w72okx76wm7Rd+5nGdyRPg7VS1yRGybE93dRKNlpZPloCjeEaZVpBzf9nIDGhkDjapwQfqdCJw+9iBC1JDih6ECTDEIZGlwPaFpZy6V6F1CyjPKCJIHS2hWfquUBgdPrOF/KT84R8GXDK0t+HQotjAXGfI/xUUEDwP6GRHI8IQtN73e+ov8a2fEbRCB3qkU551mtD5UMdJlqF/f30WZx04hBGothKA+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(64756008)(8676002)(66476007)(4326008)(66446008)(66946007)(66556008)(76116006)(316002)(508600001)(6486002)(54906003)(110136005)(38070700005)(122000001)(38100700002)(86362001)(31696002)(36756003)(31686004)(2906002)(53546011)(186003)(71200400001)(2616005)(6506007)(6512007)(8936002)(5660300002)(83380400001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RENZOXRWSWJPeEJRUFZnVnhaZ08ySlJ6akNSL3dLZUJjKzJ2cWxoc1cya2xC?=
 =?utf-8?B?ZUdxWlBienRWMHBNemZJNHVBMGFMblJMV2o0T1dHcEZXY2c2alo4dlF4V0RK?=
 =?utf-8?B?U2hBZXh6eFZOdjBkQjF4TFhYYXpXeUMvWkQ1WjlhNkJTVzU0Rjg3WjlyOXJX?=
 =?utf-8?B?OW5WQTBYKzRjeVB2bWFIaHlPbVpEaFpQSDZaRlE1MDBySTllWEVjckNERFBJ?=
 =?utf-8?B?ci9BdHZuenU3MnlXQ3dSa3dnYTZxejF4OEl2SDc1NXA2L3h6WmtLYTYyNHd2?=
 =?utf-8?B?YzdwdXVrdUZKZENSSllrTmVZbDlZRDJEMTFSZGtGZWpnYXBnSzBQYWhMV21Y?=
 =?utf-8?B?WUFLTHNwT2dJd24wRlhXTEdjVjg1cEMzNkd5MGc0aXdORlkwM3RzamdVSWZX?=
 =?utf-8?B?MDJKS2tUMTBDSldvdG8xT29VNmlFQlVVb1JDQ21POXQzcm1obWFHVFl0Yzly?=
 =?utf-8?B?bDVldEQ4WW1zOEc2dFBKZlYwZ0F0UTNWRVJXMlpoSkVxeEZBekxHTEpzU2VB?=
 =?utf-8?B?a29xVDQ3ZlVEdEpHOW0rTTZtVUFSUFBVVGRvd2xtQUhWQ1AyZnBWREp2MVRD?=
 =?utf-8?B?MDRwZkFoU1d0VzBQZ3BZS25YYWZIcTc2SXhOa0F1bmpHa2xqS0l3ZXdXUVd0?=
 =?utf-8?B?ZWVqV3E1cE5xaU5IWXVORFBMTFVXYktZbWNzR245QnJNYTFJZEYvYzVOZW5i?=
 =?utf-8?B?RExLTi9rNnl3MG03NzB6REVsUEFNbUJId2kvYzFZeFhCVE9adG5rMU5DazQ4?=
 =?utf-8?B?QU1PeVl4Ti83dnJxbkljSmtvSmY4ZXdTNVFPeTRocUJSUW51NHFVNFk3blRM?=
 =?utf-8?B?ZGtLdEFBVVk3ZU5PdXBQbEd1WGtvYmNrQ1FFaGxtb2I3ck9hanpqWStNaWtF?=
 =?utf-8?B?NFNTRHNRUjVIZmp0Rm1pbUhwajFFZW5kUGFNYUs2TmJuNXRkYzY4QnRoNXNx?=
 =?utf-8?B?eU8rS3Y5blNiMTE1ZHFrUlRsMTArQ0RnR09IMFN0VzhQOTJpbE55SFhSNHRP?=
 =?utf-8?B?cDcvaTZub0pOSkpXeWlrdTRGOXBKcjNIMTRJVEtsVXVGK1RmbE5vTDdQSU5k?=
 =?utf-8?B?dGFHNEN4V0gzZnltdnoyWlhzeHB5SG5md01jSFEvdUplTEZDaGxSUmJieXdh?=
 =?utf-8?B?cjNjVEpMMnlmN0JRS05kUjBZS0N2SGozRVdMSEVib3RNaFE2UDI2MGdacXFY?=
 =?utf-8?B?Z3NlclBzNWtHZUQ5bVpJbjIvNU1QTFl5cUV1LzdTNklKSk1vRjRxdU1SeU1m?=
 =?utf-8?B?ZDNCdzBmY05iSkh1T1BuVTdTMmlRYVZVWU9SNDF0VzVRSDkvSW1Wd24xR1dv?=
 =?utf-8?B?OXQrdkJLV3Jid2w4WEVWSnBYQmFVaUtRQ0VwSmppQy8xWDNmOW02djZ5Y0lj?=
 =?utf-8?B?dnZsZUNXaklxci9Qc09DYWh4aUNucldNOU9OL0RYOTIvMkQwRnUvWVo2R0d6?=
 =?utf-8?B?YVVZdmExaUVWOVF5RkIweWtHN2h4Wno0M1NucWd0R1JrZ1VwRFhZMzlhQ041?=
 =?utf-8?B?WG5Wb0NyMURZbHBXWWlWNjBLb1g3aW1PSmx6cmY0eW05ZzczRW40N1pVYlda?=
 =?utf-8?B?dTRaYzF5RDhUT2g4SUZ2YTVueU1lUlAraWlHZGcxdmNSbEFjTmExQmQxb2Z6?=
 =?utf-8?B?SlJmV3BWTmpRMU8vYTgwbGcwZENVRndYdll6a01DenlsYzFZbVFVWG4vWlVi?=
 =?utf-8?B?SHBPSVQzNjIyWWpTUUlYVy9VcCsvRzBndDBmdklQV09yV1pCZSttR2RRNjRY?=
 =?utf-8?B?akJoYVFXazBIOFVuZW9MVkxNcktabzF5cTVOVUVONERnVlp4S1ZOdnBqclBZ?=
 =?utf-8?B?bjlPUFNOOTlrdnlVVUhiSnRibmJCQzFBMHY3NUl4SlJUbEhoVDNkcTdJUXNm?=
 =?utf-8?B?dFRaZDhJL2E0UDlPVktEdG1tcVlYc3pSTXBQNVl6ZXZlVHVhV2RuRmppNEM0?=
 =?utf-8?B?WXRUV1BtSWZobEFqNllGbGVVSmNKS25ZTFNrMXlhQ1BhV3ZXS1BkRWUyTTRD?=
 =?utf-8?B?Y1Q3UENHMlBOdFk4blk0ZUxsaFJhM003RW1lUmpLeHozRTRwUHpDYjBVWjNi?=
 =?utf-8?Q?t1lxHr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED866C292974E44B3B75219BA7DA44B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de561163-9121-4c23-5745-08da06f84edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 02:54:36.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y93BbDMHVv34A9Fmaw59vrs04qDXqa9A2lVt2+LH++Zh3irXCPNBRtxE56TtpJdVxwpu64iKO8wxhUXaWuflVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8xNS8yMiAxODoyNywgTWluZyBMZWkgd3JvdGU6DQo+IHNiaXRtYXAgaGFzIGJlZW4gdXNl
ZCBpbiBzY3NpIGZvciByZXBsYWNpbmcgYXRvbWljIG9wZXJhdGlvbnMgb24NCj4gc2Rldi0+ZGV2
aWNlX2J1c3ksIHNvIElPUFMgb24gc29tZSBmYXN0IHNjc2kgc3RvcmFnZSBjYW4gYmUgaW1wcm92
ZWQuDQo+IA0KPiBIb3dldmVyLCBzZGV2LT5kZXZpY2VfYnVzeSBjYW4gYmUgY2hhbmdlZCBpbiBm
YXN0IHBhdGgsIHNvIHdlIGhhdmUgdG8NCj4gYWxsb2NhdGUgdGhlIHNiLT5tYXAgc3RhdGljYWxs
eS4gc2Rldi0+ZGV2aWNlX2J1c3kgaGFzIGJlZW4gY2FwcGVkIHRvIDEwMjQsDQo+IGJ1dCBzb21l
IGRyaXZlcnMgbWF5IGNvbmZpZ3VyZSB0aGUgZGVmYXVsdCBkZXB0aCBhcyA8IDgsIHRoZW4NCj4g
Y2F1c2UgZWFjaCBzYml0bWFwIHdvcmQgdG8gaG9sZCBvbmx5IG9uZSBiaXQuIEZpbmFsbHkgMTAy
NCAqIDEyOCgNCj4gc2l6ZW9mKHNiaXRtYXBfd29yZCkpIGJ5dGVzIGlzIG5lZWRlZCBmb3Igc2It
Pm1hcCwgZ2l2ZW4gaXQgaXMgb3JkZXIgNQ0KPiBhbGxvY2F0aW9uLCBzb21ldGltZXMgaXQgbWF5
IGZhaWwuDQo+IA0KPiBBdm9pZCB0aGUgaXNzdWUgYnkgdXNpbmcga3Z6YWxsb2Nfbm9kZSgpIGZv
ciBhbGxvY2F0aW5nIHNiLT5tYXAuDQo+IA0KPiBDYzogRXdhbiBELiBNaWxuZSA8ZW1pbG5lQHJl
ZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29t
Pg0KPiAtLS0NCj4NCg0KbWF5YmUgY29uc2lkZXJpbmcgdGhlIHRvdGFsIHNpemUgYmVmb3JlIGFj
dHVhbCBhbGxvY2F0aW9uDQp0aGF0IHdpbGwgbm90IGJ1eSB1cyBhbnl0aGluZyA/DQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
