Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD9C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 00:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiF1AVK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiF1AVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 20:21:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B601BE8E
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 17:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzyT1GZuRGveVKWlCJPXfn8U6xgZHtTQezOobB3ry7qiUdlA8Nny2j1DTMgzliwvKEc0aJ6TIuNFrKVNg2GNioEqaPOWYh85PM4ezlLebeCvaMWZ2wZnBHQ445xxzxQzTDDRMvkkyu3hmH02+0lRjRVbbPIfDleqB8N0IA22mgnL0DPsbzkSO7xcjuzAi40NKNZBnLina82VFRyy5hwy5d1OL3MJSX3pY3KsOrBqK0EkLQ5tzjKL6Dv+CkbC6PEDWvXZ2vW+8/7iE2WXecj0c5L7xW7WXxs0UYiQ9eCj7a9k+EVO2g0bTt8aOa9ITIAiE9qnFBy3V/Z/8cxbiaOiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amUrF/dMGGkAuHxrXcXnfZ3Ae+cWw1Bf55Q6MmxdbvY=;
 b=CG0EmXkCEke7sCQ/GsIDYb6oiS7TeOWqAcQmKr6JHHNtAG3VYh7TRVu2OQw75jeniDdt+LeOoQZ/nXnKpdYD9ENqe3jWC7vHf+Ki64P3zOyD5rRbWP8CVb4Ol4Ghyj3KYtdqfVdig8de18uT0Fg456fJCuYAXCXM9iuUYsNK137VD8hInkRL4w5uV0rAK2TClhoQFSchOCi7JjS6QphGLDtsTD1mo8Sp5Nx4BuGHvQoxq9QAMIiKeWoEgKXwhFcZxwYxymKKAlhKCygeSb64/wZPRralG08g/hNYjSyXArkrul+4JguXwlkxGRGAENyKCI7n7uu3QbQnApZH2txnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amUrF/dMGGkAuHxrXcXnfZ3Ae+cWw1Bf55Q6MmxdbvY=;
 b=l+n6E/g/CzsV3qZoiLsPp8nzQBcpwzCJTLt8E2vQmg1IsejNc/SdgFwi2ZE05+5qz7918JpBkqghHyBlqm4ur/TqyBNRqF+dNgpTSKw2pO12keGPoiRkADhv/h68/Y/SZI+6ewnSVTwIUIARtQ/kDfa0gG6Whqx5p4zJXkeDJzAf+DgmM1TO8ujyCcxndXUTG/VhQv+6I5MKV2otO82R7Op/ecOKe8zvKxEHDWomZTv2IHopi1hsNsY9fKigE6FsPPs7tOMeq4MAQDYb86e22hbu8KMzsaQjyEgdovwjxd56KtCulwawLJ3GHc/COFyZzhbIBk89/Co4SzoV3J7ZSg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN6PR12MB2671.namprd12.prod.outlook.com (2603:10b6:805:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 00:20:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:20:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v3 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Thread-Topic: [PATCH v3 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Thread-Index: AQHYioTxZVJbLpnS9keVbRvGBfy4SA==
Date:   Tue, 28 Jun 2022 00:20:59 +0000
Message-ID: <f46ae8bf-33fc-fe75-2390-05f7245ffabc@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-3-bvanassche@acm.org>
In-Reply-To: <20220627234335.1714393-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e856d33d-df60-4b15-a82f-08da589c138e
x-ms-traffictypediagnostic: SN6PR12MB2671:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEOk7JuVJ12r7j9N3L8tqmOyqQeAsOKNEsEi9gQW7oFiHpn+t4/RXFKCmcJqNvi2HWcWk6pwDvZy1FbnIFXplz1jnV/EuIP5Ol4EXwDOPM0LakWXouS82A+UwGp3YP9o0uKPIAroOrP0WxOrE0ZsmCggv8HhDVMmIhjFfaWXBP5j00qbhYe30+fiRBFpHX2vbUf3Yx39U5QeaGhWPFxTGCnTHc/CtDIiir5XGqNHJ5/gad4OJtq1+GLMbX2bf+lR87IC1uGpbaa/ay+ATWprEn3yfmq6VbOEaOHweTiHO6fQcFQqED0xgbSfNO9GaoEIDmKeFSaNbWqbjdYgsul/AovovtVXAmEYqWWZAwSYxCL+J3juzwQQO53aj4SYheEJLwy2SxT3Rn13CKigYYa0KAOkWLcMp9sYVYymbFN9YQxO7vj54MLisAS2TFzEKNUKMkdMyEsPnK3dY86hvX860ueo4Gdqezr9gYDGUb68ycRUqYxCAMx9GIcuaWjq28cl2iyCBFK8RGc9+XZ+UuH1PE71dTOhU8fLy5Qx/u8cf9xft7elevgkA5hnUeEsRXtyn+OS7L3MII9+2gYQJcflLI63iLYs/RgYbL0H8nw74jN46EOxiA4IF81pcRahncUzAPhZlATrjI6MHgEjowfj6t1qxY3PE8JG1B3XqQvOhGsW0aOzEIaMOrFPIfmSDEoGQ03WxDvAs+MXEcNeqKD+pgkMtAu4jkU0um3ewtVIhenLfthypyozgtV8seZU5aJaREx2ofCOVk0tfzAy+bwmBQPtvafR7H4y+O2K6u+skQfojlFi6aBNGil1rpXFArVPk7H5Hpz67z4MuLyzntjJoRqEmp+XmMFyCRBnFfVL3d0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(36756003)(31686004)(66476007)(66446008)(38100700002)(4326008)(5660300002)(478600001)(71200400001)(110136005)(8936002)(66556008)(6486002)(64756008)(122000001)(2906002)(86362001)(76116006)(316002)(4744005)(91956017)(53546011)(54906003)(41300700001)(66946007)(6506007)(83380400001)(186003)(8676002)(2616005)(38070700005)(31696002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHI2dzdmNGUvdFJKNWs4dXJuWjhLOTBmelFCM1FzNGhtOHgxZGJpSjFVQ083?=
 =?utf-8?B?R2tRaHdQQUV5Y1pEZzR1Yng4VUFlR1Q1UHVrTlp3eGpZcDRtekZRaVE5U2VP?=
 =?utf-8?B?dnJQMmJmTXpCZmxpMGY5SkFOdDBIeXIzY0dDTllDdEQrcWJFLzNCQ3hiNTE0?=
 =?utf-8?B?QjFsVDVTeDNIalRvb2VHL0x6MTRBWHhmRm5CVzRsOHlDNmFVd3I0OWtoenhi?=
 =?utf-8?B?NHlreWVDVDdFNWI0MHlrZ0FTNXkrbkgzRVoyMm0yRUZMSktJS2kvRGR5c3BC?=
 =?utf-8?B?Y1dsN2NPZUJZVnJYL1RDYVFNdGwwWjcxVHlyenUzbTZYSFhnTldZNjYvZVJG?=
 =?utf-8?B?bTMyWHZ6eEt6STU1emtKMCtWVmRFbFRpdEV3enBUM3JVd1RLSHhEREgxNXVD?=
 =?utf-8?B?cllwNVdCellBeXFVYldYSnkyYThKNStGYytzNUplLzh1L3paOTVaQ09OQmJr?=
 =?utf-8?B?ZHdxYVptK2NRWEI0M24xOU90cFRwN29hNUFFMDZ3a0k4bUlvdUpXRmplT1Jv?=
 =?utf-8?B?Titkcy9NQU5QME42bXdhVFJPOHVDa25zWkJwWDFBVFBJZ0xwaWVPemovOUJl?=
 =?utf-8?B?amsxRFphWGtYaGtFbWdycC9oUFVHQ3hSUEtLRVFwaWtOMldoMWlrUGhMTHp5?=
 =?utf-8?B?SWlySWh5R0NWanpxVVN2UlErY0N6OStFWml0L01HVFl0MUc2YjlZV3RycGw5?=
 =?utf-8?B?c2R5YU1MUGRxbkQ5aWc5RE9uWlNIcjI4ZjIrdFFRQlRNY2JxNExMdjVPcEZ1?=
 =?utf-8?B?Zi9nL1Y2Lysyb0JKUEtHMUdqbXJGaGNELzhlSlFrTEpqdTVIVDZCRys4ckkv?=
 =?utf-8?B?UjhGS1djelNZbFQxOWVzVUdOZFVsT1htcE05UUwrWXNPb0V6dmlieHRjWEM4?=
 =?utf-8?B?MVlSUnRXazM0QUVYaDNZaXFqUE9pZXdjZURhU05maDBNV3djZXdPeXZ0dU1o?=
 =?utf-8?B?KzkyWG05clVDRi9aYVEwRFhDcFVyRnRQRjBMWkozRVI3OHVtWDNVbjhCdTJB?=
 =?utf-8?B?dHNzSC9qNGlHWlNLTkdJMkdEc2NqNFpocFlVRFRLVWRmVjM4Ni9PUElhSzFs?=
 =?utf-8?B?ZStPUDFMcXFMUDNCL3Nrb2lGUkkwL3ZrTjNmc3JLWkVlQ3VQZWEvSFVMS291?=
 =?utf-8?B?M1pHZzFkRmEzUy9vd2JncFpnWFR2NkUvNlNnTktISFZEOGR6TUpPQjJQRW0w?=
 =?utf-8?B?aCtNa1cvZzE5OTJLd3BBSmgrVFpKWDRobkRXcEs2QWJXazQ5ZFNwdENpaDYw?=
 =?utf-8?B?aEVqcnRkSHZKL3I5bWhmQU03dDVnMjJxTlB4T0JmbnhIZDNieWg5aDNJTjRa?=
 =?utf-8?B?MFh2Mml5dFJLakYrbWs0SEVLMDVFcjNyTndFK1Y0UjZhRVdYa25wSVNTaXll?=
 =?utf-8?B?dEpxZ3RFeGo3N3Zwa3E1TVdqcHVKaVBTU2g0YUJ6YVV4bGIvZGhnL3FlblJ3?=
 =?utf-8?B?REt0UzV4UjlIQkJCOVpwZHJRdEtsczJNYzZkZ3JrdmRVZnIvcVhpRlI3UmNv?=
 =?utf-8?B?R1lkZzdKK2QyZG42UEVPMTJLL3R1WEJOV0dzV0JvcUZ0dzBXWS9OamR2czAw?=
 =?utf-8?B?YmlLNXZBVGh3TVMzRjVlNC8vRlpoTmlJWjkrd3pRTTlzTCs1WThscENEQWlP?=
 =?utf-8?B?WVFMeTF1MjhHMUcxUGNIWjN6QUlPRUpvYmNmUnplbXo1YnllbHJqVlNzeVha?=
 =?utf-8?B?eTZzR2lwNTEwczNnRHR2VkxWMW9sL1lQdlVqSlZKQ3RNSGVtUjdoNWZkMUNZ?=
 =?utf-8?B?ZTZKYVA5eUNsVEl4dzNGUThmbzlhVlBtUUREZTdTaGNBakYzSHYwMmYxYTJl?=
 =?utf-8?B?SjJ3NHVUY24zbDljR3VIbGgyazNCeGJiNHhWaWd2Y0FWZmRpUEswdzJaczhy?=
 =?utf-8?B?MU1MckhPcEdIVkNDRWNYUWdDanFzR3p6cVFraWRWd2Jtclp3TWgwcFBxaXl1?=
 =?utf-8?B?S2dZWDB2M0JkSDdwL29GVDFBaXFEYlgzQVJFUTc3WE9EcDRCQzlOc0xrQlJv?=
 =?utf-8?B?Q0MxNUhxcThVcVFjT3hFYUxRVXpTcU1QL0dRcVdFY0IxMC9Hd0R4VFFZSmdI?=
 =?utf-8?B?cTJMdVBqMlpKV2tyRlFHemJHWUVqLzQ3NkY5ZlNIVlVvZjVYWHQ0d25LeFU0?=
 =?utf-8?B?c1JlYWRpQkxjamV1czVodng4WFQ0WWg4NDJkZ0NudFozSFBFV3g1bklMQVB1?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46BEA384769E8540898B86BE11F64C5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e856d33d-df60-4b15-a82f-08da589c138e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:20:59.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nX3kn0yUlUmzZfJ8Ex3BDyz66Vn/+Gm+lJV1F3OKsF/H/RCcw0h0/2o/IT6axUtRwK+FVOyul1bkuMJJ5zd/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yNy8yMiAxNjo0MywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBJbnRyb2R1Y2UgYSBm
dW5jdGlvbiB0aGF0IG1ha2VzIGl0IGVhc3kgdG8gdmVyaWZ5IHdoZXRoZXIgYSB3cml0ZQ0KPiBy
ZXF1ZXN0IGlzIGZvciBhIHNlcXVlbnRpYWwgd3JpdGUgcmVxdWlyZWQgb3Igc2VxdWVudGlhbCB3
cml0ZSBwcmVmZXJyZWQNCj4gem9uZS4gU2ltcGxpZnkgYmxrX3JlcV9uZWVkc196b25lX3dyaXRl
X2xvY2soKSBieSB1c2luZyB0aGUgbmV3IGZ1bmN0aW9uLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERh
bWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJh
cnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
