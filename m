Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126AC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 05:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKBFrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBFrs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 01:47:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC724947
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 22:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQuconVhWad3Uu2WQ42xxMZgmJrl+QzlvhryrmaVoJY5YC14GZkBy5777sBBjBT//jx94PIGGfY94yvohUHlYFZs79YwaowT28epd647yJVfpDbmP0ySkNWfYEKlLHFPipW5Pw+dDbU29FtDWeltb88SQpudlA2x40tTrFPIweZlwPWkrTJlkBbIbT816zeS7OAd3fLmTe+ZnZLZWYhBYyk7E1TEvrZM3X1ypLyRkVfc0iHNTLm0eNrjKtmjpoY2oEpNQv4Sz31YqHWIOl5B8ulw4VBQY6yahX58SkywiifPVvsM6QbbXEVoX4zg26Sf/1AmStAalilBqNuKkFq4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mwi8sJ8rDNHtN3ByCPQnr+JQRCyfFD2UzmLWx/TYWU=;
 b=CJCFTwxdV4BdNRefPAyq+G2tyB8pgsqigO5oP/hBmm6QA3Tseauo6uujQXMYwYTanGB8jcdV2AQZDgZN4M146phVDn6zzMLo6rKwpQLVxjYpNq/ytCE4HlpDexbVzt1MvVbDTvCGW+n27jkouDef0YhpJ1efnHxOCjqhDqYU2NFG4Q/KKSfguTFb9Gt0qMLd15dd2skNSSwUP1SfzAYH95NnI0C3hBVdmQ9Z3hvfdK0wmRVFMErrBdnnCO+cB6RJ29tENtKuxXpf4W8QuiNkYvLNQEmlU7wSTnT/yXrgIqsnTArADNUate91z3a91foeqJkAVbL3gycKqG35JoDrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mwi8sJ8rDNHtN3ByCPQnr+JQRCyfFD2UzmLWx/TYWU=;
 b=T65rk/1B2PbdwFCr0fzx3etaZUdc84kyhDfSINnF03Zm4qxPaK4xCJsBWLCYhuNnyhlHKvTOrQsjMDjuLu+4xwFvOn9Nh6YmzPfSyrr0L6eNta2mlrBAqMWO14c3dLJ4r+HlbnFl5ed01ZtIPdoKwYjT3q4jOmU5kkEDNc7wYyJgji8QsYWks6wlNIZUCR8BLYzTh0vxA87v1eupSVNeOwidFYTVRu3wg8jq1slZ4C6T+IR/hn75K8R3/x2XRoRZ2aQciJ8pQ5gQ8Qgjmh3DoUZv9HoqzLme1Dc4f2fHZ+ruGZzCpNbD4Kdz6YYgaWNf4J668KyPXwi+KatKdaMxXg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:47:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:47:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 10/14] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Thread-Topic: [PATCH 10/14] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Thread-Index: AQHY7gMAKYZGnOUW206Puo4Bf4wzXq4rITsA
Date:   Wed, 2 Nov 2022 05:47:45 +0000
Message-ID: <376514a6-20fd-0d4c-d689-2aa6113d5d44@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-11-hch@lst.de>
In-Reply-To: <20221101150050.3510-11-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 209b2c49-2315-4e8f-9229-08dabc95c433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zp7+afEMXAp51WoTe5Ko0QqDf6aslNy/PeYu3UHhnNn1Zs4CZR18jRF7xtqvInl3R7o8hHoT8JnwP4QA+nOMYUrrx4mZEIpWmC7Uu2KEdEfywvhFYgq8PepJAHBsglcCMeK9QwipRv6LgUEMoFVXmW7p4wuN8ojCVR3J6ruBG5adOHyNj+cvZlmgJRihlmGeoE/EBjeC5av77Cy0PCsFYUsgwo6AFQX8obrLQSBvTSm+7C08FTqnCax7eOM/PjqmRYen4jsCgZpMqZuA5AFmQ6HVCUgM9NfOsYJU9ittlUHyvKwpRa9IGO3CoThmKLeJbpbQb5kRN2rFlDmOk/J+gowYg1hEOXVNnWAlBprKiZPkMw2rWsjfZlhHalLS88v8O2jyamE00kCJGG+ZIosBxJf8kDMLu/g4K5Glaqs2vEwWES4EaNwdP4TnggWD6AvaQ2u8DrTjoZDxCTJACkRGNQhxMeMYwGpY//4RUGLRsFLgoONq7mJ2wVeAnvU245Dm+iOTAZfzJiW5M8gQOZ1s65GDbcilb1NpJp/bLJwnPNPagt07cW7iZM3PLIcWgtFLcfp8Cqj8C96SjFo9P71DxYweh48zhgdZWBEJZOJniW57pN85i37i9Sk0oViXdr9PuYx5OMxGwEoYJSXdq96yVa4aRo2UGD7y5Ajp9f2ZhQvOOg6UjriVvCaAENjt51yyplpA2Da7svRGDfqTFjgBLR49D4A2BlXgDLSBbulH4vIO2jnhY3+PLfKWauh3vyDiCNAwa+3p1ivCaKELR2Vz67knurekAuVW/G8lXQ1iD0AfIYpRerXlLR+ys21J28PGX1Xei48NML7RnhGH1IdDug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(4744005)(2616005)(86362001)(36756003)(31696002)(38070700005)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTlESnRmbnFxWXR2aW1rbDdON0tDQnJ4SXlRRUczK2NzZHdJdXhmY01CaU9I?=
 =?utf-8?B?QWtkUVBuMGVTRXE3MnR1eTBwWm1VRURMV05ncmd4ZEovenpEZmNaMG5PdTlN?=
 =?utf-8?B?L3c5aTFhNDNZK2hTSVlJM0RINWxQcU9LdXlBQ3hQZUNqSGhyVVpsbVF3d25i?=
 =?utf-8?B?ZzdNODM0RlN3emN5UWNteXMvY2kyRFJ0UVA0TUg1Z2cxUkRKa0dVbTM5dVdW?=
 =?utf-8?B?RVZtNjA5dFRxV081eW9Yd3hMb2wxbnEvY3JQWlM3YzZRcHRuSDYvN0gzL1E1?=
 =?utf-8?B?ZFVwTG8wcytqT0FEZmQxMlUycmdJdDdGVlNPNVJVN2xkVWU5VkxEdGZJNFMv?=
 =?utf-8?B?V1R2WGxlZGJsMTArUm5IVFI0ckd4WWV2RWwrQlZvZGd2UHl6cmFUTUpMTmFX?=
 =?utf-8?B?bUhqR2dPRko3a0VxVkVXUzdaVXRVZ0VvT2M0WVg0RStyU2F1Vit1TTRyNVdn?=
 =?utf-8?B?bS9OcGxLK0FqUnpQZys4eGlFaVdmZkJPY2d5cEFoTy9hV2ZySXB5U1krVUgx?=
 =?utf-8?B?cUE4eE9RTEdmaGM4K0xwdkh0dmJPMmVOeE45cXdUVDdZY3N0QndWbG1ZVndL?=
 =?utf-8?B?TitONDBWcENhZS9FYklvNGZ3WU8yam96WEViNGVXMk9jSXBsZjdiUDdHcGZT?=
 =?utf-8?B?M3RGQWF1SXk0WkhiSnNvM2FBaldKVElvSHlqUGNPUmpjd2xjL3ZqYkVkdmFw?=
 =?utf-8?B?ZmZFcTBZQnM1SVJZNnZ2MkxWQ21yS2p5eWcveGZ3SEVLTWhrZ0FQazkrTCtJ?=
 =?utf-8?B?YUphWG1xM1N6VkpnWGlHUGQ0N3prb3ZEZjBrUGN1d0RoclNrWTI5aWo5c2dC?=
 =?utf-8?B?QzBWbjgzZUxBVTJxNmR5YnBTWjNleStuekV5dGVrVkp3Tm9DMVRBb1JwMk9L?=
 =?utf-8?B?YlYyckZ0NVp2ZGl2T1BDL3VQWE5zY2V1ZG5NMFF0T3FaNnVQZFhMRkpIcTRx?=
 =?utf-8?B?OUcwN01YZlUreTVFanM1ZnFIY2FkcTNjcWZBOTdRbjR2bmhleGZkd0RXZjRq?=
 =?utf-8?B?NG8vRThldWdJSlMwTU5jcHZCN0NZeEZjcUZNTFpoRDBXWVBiTEh1dk5kVFl6?=
 =?utf-8?B?S2FFdjBvYlY0ZGRTU01nd0kwRzRzV25RS256QlBtLzFTYVpZMXZsMncySm03?=
 =?utf-8?B?M1hVU3c1dFFBdTZQVW1zUlFZOG5DRVFPWUlrdGRWL1c2SDNiRVNxRjlzVXZl?=
 =?utf-8?B?RXdEcm8wMHV1K3BVUjZmeURlVkR3Z2dUV0Q2UkdabzlsMmVrTWYxZEF0NWxl?=
 =?utf-8?B?N05DUjNVd0tuVFAvdjVJeWZxRHF3OC9OQTY2SGpXZElrU2FZQ1BNZEpqbXJx?=
 =?utf-8?B?YnRsTmJ5Q0c3ejZ6S01kSnNvTnowR2Z4KzQybE5vZUJaN1E1aVB3R2JQREFM?=
 =?utf-8?B?ZnhCZSs0T2pBMjJMU0o2bmQweGZsMTcxbXU3WUs3c1g2Mk14OWhZL0VLSnEz?=
 =?utf-8?B?MWpiRWpYNktyZWlGYjAwMVVJQ1l2SmJySUx0MDJJSkxPUks0NER1UHl6RDZu?=
 =?utf-8?B?MmRLeDFUa25lU3FQaDg2R3Y0WXFNVnJjRzQ3cS9uWE9PSGxKZTVkZnIvaGo4?=
 =?utf-8?B?dnhWQmo1OVFmZXQ2d2FYN2cxajkzdkFpQnZKUUFlbGozK3QvRy9FZGRoditB?=
 =?utf-8?B?YzhiVG12Yzh6d2FWWWtVbGlObGlrd1E2SnI0bEwxZi9qdXFUTndRWVloZlNv?=
 =?utf-8?B?ZWxxTnJrNlhaOGh2QTErNm1oYjNTSzAvMEcrck5GZjd2aGpiRTlpVlJ5Qzda?=
 =?utf-8?B?SW5sTDljWVhIRlQ5cnlBeXV5c3F5VHBYV3krVzJKYzliQmE2TTJTS2xWSGF2?=
 =?utf-8?B?OUJQUmFuclNaazg1WVR0T3RQQ0lWYWVxOXZtSVdxUjNRdHdiaDg3cUFSN3hH?=
 =?utf-8?B?eFBRcE9lbTZTVUtiVUVsa1A4T0JONVlPL2xmRGxEZ0NEQ1dteXJHSm1veml5?=
 =?utf-8?B?dEhvcWVweEFzNURuRWV4RW5XTUcvYUtFUG5xT3NoQnRFSGY0WGI2U2JWWnFB?=
 =?utf-8?B?bUtUclRrandJR1g2dFAzUlRmQlh3ZVp1RFRkeE1GUVE5aTFzbUlHankydHhh?=
 =?utf-8?B?NXlLWEFvNG9MTTk4NDJEZFp0Y2JGOUNZT0dZYkltMGQxZUl0Yk1VUVE1dnZi?=
 =?utf-8?B?aTd5WXNyNFRyOTlTc3NXSyt5cGdabTJ5UkNWUjBCRnlib0dVSDJHNk50RU9T?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0EDD0640732804792076F5895C58095@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209b2c49-2315-4e8f-9229-08dabc95c433
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:47:45.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abkWG3vrRd3WAb00Z4c4hqATSeawa2tJut/7H9al5E4kqE+OBw0DvLF+tBIUfPoqs5YqsxbaRfAqnLKsWyYyDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZvciBzdWJtaXRf
YmlvIGJhc2VkIHF1ZXVlcyB0aGVyZSBpcyBubyAoUylSQ1UgY3JpdGljYWwgc2VjdGlvbiBkdXJp
bmcNCj4gSS9PIHN1Ym1pc3Npb24gYW5kIHRodXMgbm90aGluZyB0byB3YWl0IGZvciBpbiBibGtf
bXFfd2FpdF9xdWllc2NlX2RvbmUsDQo+IHNvIHNraXAgZG9pbmcgYW55IHN5bmNocm9uaXphdGlv
bi4gIE5vIG5vbi1tcSBkcml2ZXIgc2hvdWxkIGJlIGNhbGxpbmcNCj4gdGhpcywgYnV0IGZvciBu
b3cgd2UgaGF2ZSBjb3JlIGNhbGxlcnMgdGhhdCB1bmNvbmRpdGlvbmFsbHkgY2FsbCBpbnRvIGl0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+
IFJldmlld2VkLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IFJldmlld2Vk
LWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBSZXZpZXdlZC1ieTogTWlu
ZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVj
a2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
