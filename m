Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF6FC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 05:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKBFvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBFvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 01:51:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B93C1F2C6
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 22:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XARNX2SfO2C/KtSW4s+Q54gG7YPw5tiWQlUnONOqnIXtoPlnV6fgo/ITdSSi+LRATgk7xIANwKzlBxHHmdnO26gDKH480Kj1OQyfj/prSK03e6pMh1fIK/x+dcK5VoMhN9MWDfCHYN4lxwxo7FBvwdIClBxP2CDR+MCiGfCSVMqSeBVkqkfa6m7vA+Vbg8eiHB8dF2BgpqoiQgb/D+DCKt57Eyctz1Svxo4MF7gg2X84RPs8VUv4xJ6G1zoeImQqKY79rUInic8Yn7gjuuWoGj23idobd5HbNHCr/O18PU1MnalsakzgXTdSU9SzTFdT0rW/A6AkC6V0NZUJ6SOV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zlASNf9hXkPBFC/SKUl6d88WONy212dOn4HuwecVh0=;
 b=UpsVZJ82hHRxj9dThy53uY1kKWfWsksrsF0bjOOVaYsNxJL5ykRdiMftSBufjhJleQA2KTQnHNWD1H5N0Tia9Fq3724AdkelvV5msKhkXWyUOf0K0knnRTPR+o9r8ytamDk1WtfPwpFC+ZQNtc+oBonhaqO9kbhbVLpf17rZpxozktfJ+I7B+Vjz14z0apl4npupUdiedvS0OZ9tvH+ffjgb1bkBeC3X9eJgJE6HQn/xle4y5VjzvccLiPO+uaJxxVAUFivAwKg2DWANGxgwKAFOpHuJ0bctAeDdZt5M8s4cFVk5Xb9aapbCLBlefotVBWn9c9fiwNsrkVV2LdFcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zlASNf9hXkPBFC/SKUl6d88WONy212dOn4HuwecVh0=;
 b=r3Qi33Vf83++7UZefkNdpbohjqSREUSk3i0l8dS7U/6HpChFfJpzhYOgVf8yz7ZcnPGL07IueXee/SPhzNSsvIOYBgdCyChAAbjhiuHNixFBIE1a1pO9aFCmB8yVRA1OBs4IU4SQKOfsQvAGn7po0V2/lphAQbi9B7i6PCMZvMwCL9sTGHiJz7lXUjaNlGBbxnVSc2466ItTrw4jPYxYpg5Ss/kIgzmuEEK1s9ODcQqKralq1foLWrvu3d6E8xSI4ilY2rQRumg67LJ/pupPBMtrHDchcQdOfBZNKnh/jX+c+Mm/7pnLwLD1Jt/9j0+GXsQkID46jtZ0i1Ok0+/+qg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:51:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:51:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
Thread-Topic: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
Thread-Index: AQHY7gMLJSf+co38CkiTlvexqD8bva4rIk0A
Date:   Wed, 2 Nov 2022 05:51:34 +0000
Message-ID: <a2a5debf-c87d-5014-a259-4317cd1fd95f@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-15-hch@lst.de>
In-Reply-To: <20221101150050.3510-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: 10e8387e-347c-41c7-ebeb-08dabc964cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2pnVBQt8bfn34LFYL8RAe6oxRRnoXtScnz3tvm2yRjfzDwUC64/gWd5rwrbcrIe9ie2uFdYTryAEYVaf0geSl7yOSn8VjqNTaDf5tI2lPC/BIcgBS7iDDpsotsc6OdBN1NtrrS0ttoHgzkzTrqDtnWhgkMgAasGQqWctM5V+34STPUgg7OQ+I6xReSUY7Z7oZRppVjnORPFTvLZdzKoD7hixRO6x7nQA8fpSaYGtLWgTv0KMTgwRs3MsxoeqOmABqnpdCk0+bcu0ToKr2RhoeCLz5A8jWC/Ut2CKdghxESWoyIR1keIo3XpkIQ7jW9IGbcQiNymBn7xvGNnlmkDnIMzxRbO+I/7rlDzoJOugnAm2+aTbI+E9+CkJjvBWCTT9d+thaE/8XKr17VbC6jXh+E6uqDBCx5/GK1NcvBAmZFTD86Azh6LR0rF7zKhj8eoqpgbws7mxX8oTbJVLFl8ZQJSB90ujR3+XqWBZRwHnbBIdF+tS4dIs842aXdybkxg9weuXJh0h6YS3mE17bbF6Ig8fR8i6ZRYCnkBvwq5qqMIanS4UVll92j3i6Drtfu4LFXbBv6O9IsUp8BZzxAtEV34V3DmeC0T19dlRIU5yzUMWa3tCyWOMiFx+0NTXzwFxmzMEfYNk7Rvniyqf/G06QYvT8KnoIH9jVSKm41NjAN1xv6PWMF25oIvAGObonCdozcI+J3Kl0gZwy6ZnBorfzHxmh/Sou+uF+d+ZntFr9a9DubMt0okc51KNIHSf50lXqM3eXbDPjnjRlhCgvpmPlbGTti908HMpWZsSLlREjsxuzfZlV5aeipAMlES+kh5TK0l7VhX4wP/xnLwWbtNFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(2616005)(86362001)(36756003)(31696002)(38070700005)(83380400001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlXenBnT0hBTDVoMGdIN2Frb1FlZmNRUDUxKzk2OEljYXZaOWxsODZMZERl?=
 =?utf-8?B?TlhiSTltYVNaNzIxd3g4eVRyWktrdjQzZnZ2T3JVcEZZZGpmSXg0MVdsL2Jk?=
 =?utf-8?B?RlRCcFhrMVErS2RpWk1DRXJxazBJd2xFWGFveXVTcVR5SXhYdTlBMlgzYVFo?=
 =?utf-8?B?ancveXAxWVFsM3FtVWZCZFNCazFINEZNc1VKbUtYYkhwYzU2M1BZVEpNT2wz?=
 =?utf-8?B?T3VkakZnalQ2WlhCcHp1eURTWFlPeFFqWTQwdENlV1UrTzh6VmE4cXNSK0pu?=
 =?utf-8?B?NWdVajBPdWliUTVyT0x6N3hPYmt6VkdUeVFuMm14OVZlNUlybzlyZ3V3NTY4?=
 =?utf-8?B?bXlibmZYOTk5ZlVSeFdqTmlUZVBJalJMMlJDdFBzQm1Xd2o2azNJV3FiU1ZN?=
 =?utf-8?B?Ty9hdE94ZExIUC9lTEMwOHBxM3k2WkFXYlFtTW9zM1hhTDZpQWcwUnR2NnNk?=
 =?utf-8?B?ZjkyZ3haOXZiSVNWV05TbzhhdjkzOGx1cVZ6YTgxYVhkQ0piMDdGSnYySGF1?=
 =?utf-8?B?RkxMMXQ1TmtPekdLbnVsTFZ2NmpCOC9Zci9IVDgrNVd0a1ZQL3JMcHcwazEw?=
 =?utf-8?B?M3RpZDRXNzBrb3lUUHFFWFY2OVpJVWRHUVMvcHBQb0lobWRzbVR6VzdRQTdD?=
 =?utf-8?B?NWg2akFkd05UWmg4ZTZmYVhib2tkR1BvYzRTdkdDazVxcjEydkozM3RvZy9O?=
 =?utf-8?B?UFlzN0FySEdFWlRadWovUFdoMnB6ZWdoWU5hekgweXJNcCt6Uy9TR21nY1hk?=
 =?utf-8?B?azVsQmhXSlVkMnQ3M25paWIvUjdlSlluLzJGSXdScW1MNU84KzFHTGx5NWFV?=
 =?utf-8?B?aUhSNjBlYmNFdDBhMUJ1TnhJdDZ5L1p4cGZwaG1aRHMrZklwSHJBeHZneHRu?=
 =?utf-8?B?ZUJ0WVNUbkJQekJXTUxuWGxWelJMeXZ2dnRNVng0N25oNittZm9HcGRSejNo?=
 =?utf-8?B?RTZwSWhENzYzMzM1ZzRCLzFTQzVnQVFjS2RiVUU3cmFEYUYyK3FzY2JXeGlV?=
 =?utf-8?B?U2loYkhSdDh6N254eFA5Tk4xcVJzRGx5SlVvMXZXNExxNWc2MVduZ3J0N3Bx?=
 =?utf-8?B?VjJBbW9jV05EQm9yQjV0U3Z1VTNXSGllcEIxUHgvUzd3ZVpXZlJnVUZjVHh6?=
 =?utf-8?B?SUx4LzFrRDVaRVB1dUE3VVNTbVgzZGFyZDY3bGdkZHJUckFFaTlUTWJ1cmkw?=
 =?utf-8?B?UlRxeldoR2xSdWFpKzk3bFZTQmJiN3pKYlZkZnJNZlVCRHdCOFhsdG1BOTZI?=
 =?utf-8?B?VjdOWlpUNThiRVlWS2FyVFhtN09NMExMQkJweXBZblh0R2drVUlQNjdZN3cr?=
 =?utf-8?B?M3pabHQxY1RvZzZ5R1BMaXhFNzJKWWNHWFBFcXVSdGphd0hoTkV3bWl3Wm1S?=
 =?utf-8?B?UWxXaWdWeU9wKy8xMk9pVHZuZzB3cWJEMXFhUDFMU3hDSWxkMWJxVmM3UGdW?=
 =?utf-8?B?eFlpdTRPbTBaQWVyS2tUaElNTWw2TDZtOS9LQjlJVnhocDFPU0lsSVZqYnZD?=
 =?utf-8?B?S2FNQjFRVnE5aGhoT3ZXbHVwWU10OUF5MHIzYVBDRExXbEFUakZtU2ZGUnM4?=
 =?utf-8?B?WitJdEM1MHBZem1NTnVLY2IzSHdaek9UMlN0bG9Ja1ljQng5SnhyTkNjTWFs?=
 =?utf-8?B?MlcrSnprQkhUb3JrU0FzVGlNNDlwSW5KUUMwYWZVSXVtdWVGM1BSVmFZZmdy?=
 =?utf-8?B?ZHFNNXJVREZZQnRBUWdoRDJxWVkwMkdkcHJmUkNNSUd2OVhtYmhSQUlHRUov?=
 =?utf-8?B?aG5tL012enZsZVhiTjBscWF6ZVIxSFRKbHNaWmpPaThoUXJDUEF1ZzlBNEdk?=
 =?utf-8?B?dk1LZnZoYXFabDNlUXlQeElZQjg5MVpGVzk4WlRIb0RxaHh3UHZTbEtpSXhZ?=
 =?utf-8?B?UkRRb3didjRxVDBZL2FuNmg4ZzJ4NnJHNW5uYm1Ock9QT1g1SU84cStveUpW?=
 =?utf-8?B?K3cwY0czQWJTNWlacldVdzFweHNrRDZxdmVpZEIxUENqTm04QURhRWJ5UGRU?=
 =?utf-8?B?UTMzZ1NnWmFLZTM4OWJCN3FFVG5Wd05IY2ZkSDJCU0hEbTJlSmdBUEtMR0sz?=
 =?utf-8?B?VHpjSk5oMGFOQzNzVk84b2Iyb0tPcHBGTG1aVmdybFlpMkx4Sy9xMlczeTF4?=
 =?utf-8?B?M29hblRxRVZaMS9xVVZNTG1VSjRoK284SzlTRjVKRE0va3RZK1pSZXFmMUtN?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C4D8C32AF473344B8ED96300989CFFA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e8387e-347c-41c7-ebeb-08dabc964cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:51:34.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H26cH/nJ9BHdfkwkbnya8yyIDTuykUEYAX8W72gKtG8PIFzMpE96fcsxIM+izWzozkcQRv2CNdxr6opNaT6nlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZyb206IENoYW8g
TGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4NCj4gDQo+IEFsbCBjb250cm9sbGVyIG5hbWVzcGFj
ZXMgc2hhcmUgdGhlIHNhbWUgdGFnc2V0LCBzbyB3ZSBjYW4gdXNlIHRoaXMNCj4gaW50ZXJmYWNl
IHdoaWNoIGRvZXMgdGhlIG9wdGltYWwgb3BlcmF0aW9uIGZvciBwYXJhbGxlbCBxdWllc2NlIGJh
c2VkIG9uDQo+IHRoZSB0YWdzZXQgdHlwZShlLmcuIGJsb2NraW5nIHRhZ3NldHMgYW5kIG5vbi1i
bG9ja2luZyB0YWdzZXRzKS4NCj4gDQo+IG52bWUgY29ubmVjdF9xIHNob3VsZCBub3QgYmUgcXVp
ZXNjZWQgd2hlbiBxdWllc2NlIHRhZ3NldCwgc28gc2V0IHRoZQ0KPiBRVUVVRV9GTEFHX1NLSVBf
VEFHU0VUX1FVSUVTQ0UgdG8gc2tpcCBpdCB3aGVuIGluaXQgY29ubmVjdF9xLg0KPiANCj4gQ3Vy
cmVudGx5IHdlIHVzZSBOVk1FX05TX1NUT1BQRUQgdG8gZW5zdXJlIHBhaXJpbmcgcXVpZXNjaW5n
IGFuZA0KPiB1bnF1aWVzY2luZy4gSWYgdXNlIGJsa19tcV9bdW5dcXVpZXNjZV90YWdzZXQsIE5W
TUVfTlNfU1RPUFBFRCB3aWxsIGJlDQo+IGludmFsaWRlZCwgc28gaW50cm9kdWNlIE5WTUVfQ1RS
TF9TVE9QUEVEIHRvIHJlcGxhY2UgTlZNRV9OU19TVE9QUEVELg0KPiBJbiBhZGRpdGlvbiwgd2Ug
bmV2ZXIgcmVhbGx5IHF1aWVzY2UgYSBzaW5nbGUgbmFtZXNwYWNlLiBJdCBpcyBhIGJldHRlcg0K
PiBjaG9pY2UgdG8gbW92ZSB0aGUgZmxhZyBmcm9tIG5zIHRvIGN0cmwuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+DQo+IFtoY2g6IHJlYmFzZWQg
b24gdG9wIG9mIHByZXAgcGF0Y2hlc10NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5l
bC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+DQo+
IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gUmV2aWV3ZWQt
Ynk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
