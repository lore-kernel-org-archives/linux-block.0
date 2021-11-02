Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C9C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 03:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BC660524
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 03:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhKBDJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 23:09:57 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:46689
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhKBDJz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 23:09:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfedN4O7zxjYtIs/AUgJQuGpVsYZXFis0A2DstIcql7dI4AecC/Bb/AWu8qnLuekR8bZ0SphBaTh6IEl+uzZCZwl1ku3pkk3wgNbvySO5E284QF1569z1xyIySvtxAFuXPOK5A1chOcDUrnhZgkbJiJva9bIS+RhB6i7mlwm3hTmNs6J1QN0VafRCiSjd9n4o/4LDXOmXFGoZRSyl6+xmfnL5zrpKevGS1jisw9xJ8waikxXkBcxw7x99DTvfIUiOXB3S2vrZSjDr/kEofZlQMXbG6hKdApza2m2pDQoQmAbV+yPtsbzS9cyZ+qD2yXX1cvVP1ZmV/ajD5VZT72MsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFihyJjcELoClfLaOwXM8e5NkWO9QL9oRb/RJBljK7M=;
 b=HWdd9Gf7Ow4CiCSb8hOvAQff4AQ8Plvrn2xPLZLhqh5Mtfm2Bv0zgzp7bCkk2JRaQzrBUk+4fqgbFrT9O4yFZI7CN+7mQzxpR/7wtLzhL8Ar1JMoiptsLuZ5V3S+5sHvcOuzPS7l+7aDn3VUdqIkRNNhZjiIUl27ExgcvmvTT5OEc7BILjhZmJio3T7sZfWtP58qOZPVSZxQnKlBKYo7fnXt8LbOoftaTurEm6RCfZlOr9v2Oo+lCLJm3mvlVreI5H3ZKszWQigghddquOvaUdKRrjw9DHuzvwGEER/fVicXClFTT4BvJeBP5d/cnOiltbqmGovLcSswgJkfKEvfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFihyJjcELoClfLaOwXM8e5NkWO9QL9oRb/RJBljK7M=;
 b=Pa4dLHJjTOaBpBTJRbdjVaY2gtvxRrQQdX7pP5dfADWdIkYvzafLEJapYwEVsSb2e6lzK7kACwAFSzseuQYwdfNwcliRqWbBz/XIS6pqgVKbXelU+b26/GrDfnE6uX27Euf/y6BjaRFPoyApPgTSgdbPM9HhGIeuNjRZnWxk283L3+LbYlLXGAkq5tIXAoh9ZoHNb3N6lkBBr4gZtlQ3l9w87Y0zEhvnFLe9BwB+RKriEZAkVV6glOuJcxbDR6PTQ3l977AI0zVL4gzxhJ6ftJSyUWMPAVLNnPQ02IBfKVjtf8/7VOswQ4bfmFjsftuJpqSy6J91knEety01K4F4OA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1263.namprd12.prod.outlook.com (2603:10b6:300:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 03:07:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 03:07:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVqvunZKAgACtRQCAADgYAIAADJuA
Date:   Tue, 2 Nov 2021 03:07:18 +0000
Message-ID: <9e22ece3-d080-945d-5011-b0009b781798@nvidia.com>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev>
In-Reply-To: <20211102022214.7hetxsg4z2yqafyd@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08436bf1-fbd7-4034-a55f-08d99dade157
x-ms-traffictypediagnostic: MWHPR12MB1263:
x-microsoft-antispam-prvs: <MWHPR12MB1263E46A0706C7C7717EDB75A38B9@MWHPR12MB1263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihbcwd4JFjvI3/8w2SagdKRyN+OXfYgqC1FHmObeU3ulN16SyTLYVgtoR3Bdf98/U7hrZd1aRWdDye2wPAMu18EmDS+qkIWh5djhsO6H8QLKsSv62uNtDCkhd9iaOlNYIi9+U2NuLnglWvtQ55C58wk8XDR7l27O928AIeYTIV4jj36z4XRmPtmXXKkf0qLv6hppezkezhpi7GpCuJsMoImZfRywX3PjJCK8IqSNw4byDF7rhh++uyWxKDPTbGPqT95HZN98POCOKtOs3RxtPv3tHuSGQgZZfFislOhNqCwujMX5fNQi+jL8DWTFZJPrJIji3/gfYyrKY0DA7PlX8KuYOg00T+UHecrWkLg1krSZ5f7o/a1PrHasbHEIS8nrvpu7ociziHPDFt8rHm78bhT2WC0lnd3SpYvMeYv7ka8irXp8Esu2kRn3jgKbdlrLFlOT/lsKe8uviOFfnfbJAb9W8aJIPvkw2mAU4YvKJV/NTOVrN9c9BVBD6UYYGUdeIMbdwIsXqt4tAaRA9QRTOWWbQwxI2MG7BWLglmBrKl0I+q6Abvb8YaYQZs52tFXBm8V6U0NBM0rzWcH7I4JGRtWsuVNK/3jGdJgBwn5u2B3nzVyNaiPvaIVPu1LYltPxyAV/QiC0mgA3zFktGobbmsbfYSAhpA7RkKP2ATEMao8XVZgM8iiz3bMabsYWSyWgvTkYZ325EImoySKs9JB2TgcDYmW+7kg4T7wpruNZiKgwmm88PlNKRCzIW+5M+NTCi6MVK5bqZlSOTZuAgL+8xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(4326008)(6512007)(66446008)(64756008)(66556008)(66476007)(71200400001)(66946007)(2906002)(508600001)(6486002)(86362001)(316002)(6506007)(31696002)(31686004)(38070700005)(5660300002)(4744005)(122000001)(36756003)(54906003)(186003)(38100700002)(2616005)(83380400001)(8676002)(8936002)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWtjMXhHUGx5U0xBZVRZOWxidjJzOVV0djJmVk0yM2F0YXhWNFRkUW1XaEhq?=
 =?utf-8?B?aVBPaGdNMUc2MHBQNE1ST1R3K0wxbGt3OTdWWFVWdGJLaG1pTEZsN0xiOFZ4?=
 =?utf-8?B?b2xuMktBTjhkQjJXV2xncnI5MGtNK29qVDVBa2o3NlJiWFB4L3JhRkxzWFdF?=
 =?utf-8?B?VVJMajZhUkFDcEtoVythbFJZem5icEhocHo5d29jVkhEUHJDNEFOeU9jN3E4?=
 =?utf-8?B?cW9TNjJtQWVDVW1wdmJUbXR5MkdVR2wvVEVjTVRZN1F1b0VhL3VNTjdPZW1w?=
 =?utf-8?B?YlV1R0V6N0FMSUZybUpDUXRYc3pOL05OaDBlcjQ3cTlnNHdSbVQ3MlBZY2I0?=
 =?utf-8?B?QUFPTHZsbHlzRXVGSytLdXphSHFXWkFZWGNsTEVKaEl0ZTl1V2tSZzJYWHBD?=
 =?utf-8?B?bUl3bjZuc29aMC9CZjRTY0pKRysxN1B4SkRRSGI0UENiWGprSW1GU3hFUTUv?=
 =?utf-8?B?UjVDbWZ4TTlzYmZxdUxqaUFxaVNkRnNveFQ5dXh2NCtydVNKenZLMGk3cGNo?=
 =?utf-8?B?eldGWkcwWE85bEppaE90ZU9WNWV2YThpSmYwUzdjYTEwSldwMjFrK09oNU4z?=
 =?utf-8?B?Qk90T3E4bkJMcE10NFhMSUNqbmo3eEl1YlRieWh6UWhoNHV2SHF0Y3IyOHlL?=
 =?utf-8?B?NHl0dXRmVFk1TFJFTXAzYkJRUWpoSnIvUHhwWXdjb3ViSCtVbXlaTEI4R2d3?=
 =?utf-8?B?MDQxcHd0UFlxYWhXK3lHRUd1WjF3Q0xveVpRblIrN2p6eE12RElMREl1WWZ3?=
 =?utf-8?B?aGJkajgyR29oWDJPSVpjUmE3UTZ1UGtLMXVBSXl0TUp1L2lndXRZa2VKdDRl?=
 =?utf-8?B?SXRmVTRPU1JhN2l1YVF0cnA2UGN3L1pyYVpEcWhXK1pDZ05tc3lYajJCM3hO?=
 =?utf-8?B?SUdjWnJobHBGWnFKUWVleUN3dExqS3VvY09BaVlFeWludnhqa3BUYUF5UmRh?=
 =?utf-8?B?eHdjSzRNU001TzM2ekdHdlk5ZWhNaGFBTkpSc1orUVpFWUZ5N1ZHU1AyanVU?=
 =?utf-8?B?ZUdtZXBOMkdwN1NmZDJpNXM4Zlc3aFNHM3JTZ1M2VnhxQjVyS01jVW10TTFy?=
 =?utf-8?B?M01TUk1TanFWdFR2WkpmQVg4UnpjMlBMd2lvTjZjWC9Mc3pIb1dLbjVRVDJh?=
 =?utf-8?B?aUhKRVl1cUpNdnBzQmFhK0x6K0hxVHJXaHJwNHhNL2VuaitBdU92akU0NnZ0?=
 =?utf-8?B?MnJsNjVta2c0TS9GUTZiNVg4ZW55NVlqR3l4Sk43R2Zrc2RlUmFiZ3JVWjBz?=
 =?utf-8?B?WmZJQ2t4R0JvdGg1SWhhYytja1RLaXJnS0pDMEcwVUpuK1hYVlhabHpLeThy?=
 =?utf-8?B?S2h0eUw2MCtYOGNqV2lXY0NpMDRlWXNRV3lkRVo1VnRDcmMrTDVTQ0M3NlZr?=
 =?utf-8?B?aUR6bm5sY09KMmVKRTNtNFJ4ZTdSSzNoOGFtTmJZb1NzRnhQcFVNU2xtakIr?=
 =?utf-8?B?RVgyWmJFSitlTldPVHNmR0hHQVpMZ0h1U25zWXE4QmZBQTlNVExjWlN1NWZt?=
 =?utf-8?B?cFc4N3lLdW8yclA5R0lmMStuNDdZUStMdXlOVEp1UWZlUmduVlpuWklrNWNw?=
 =?utf-8?B?eEFkT0d6MFdWUmdQeXg0Tk5lYlZnZ2VnOW9sdU5yZUVMRktBWHdKVnJaYmp4?=
 =?utf-8?B?MDY1OUNGVmVpYUlySTgxbE1VS3B5MENXWVNXLzEwOW9QdWNDdjc4M3IyUDUv?=
 =?utf-8?B?Y2xqVTFNcHV0Y0U2VlZZNDJUZjNmMklEWFVEOTVGZ3JneHJzY2NxTnBiMUFi?=
 =?utf-8?B?MjRUQjAxNU44bTNTWnJvdlMyRUsxUEVSNndOQXR4cHdTTDNIMlBKT0VlY05S?=
 =?utf-8?B?Y2xJUmZ2eUgxUmgvRm1CaWYrYXVMdmwrdkpLQlgyMlJHTWxUVnBQVzNpQVp0?=
 =?utf-8?B?SmhSWHNLaExUcU5vSS9HZ0FtUVBRYjJ5MDcrdzJxK1VWeUYrdmVtbmZ0cm05?=
 =?utf-8?B?THAvYW9FNmxPbjVMaGpwbGwvOGRjVXBOL2FmbmxBNVcrUmR1ME1GZWpYMnZL?=
 =?utf-8?B?ZE9CRm9Xa3FKbzhnZFBhUkRtMjhYS3lVSVQ0UmRsL3V6VGRiU25uYXRUUUh3?=
 =?utf-8?B?YXJYanJ5REIvOFBYblNBNnhrMU1GV3lIbkIrdE9RUUxFaERYbjNDaVVNSzBD?=
 =?utf-8?B?SzdkcW5GZ2EyZE9vc2dEbzRpaDllR0Rmc3ZRb2paMUdHSkF1a1dHOG9mZGpx?=
 =?utf-8?B?cWQxQ3J2bG4wMHk0VnNsK25UTEpoQTRubDNWVFdWeDQzeXNyN2ZNWGE5U3ZB?=
 =?utf-8?Q?ODt9aMPPR3uFlWWqjoiclcmYd9fJcM4pPb2WYZZhm8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1319863C7F3E94ABD0760E12CC63990@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08436bf1-fbd7-4034-a55f-08d99dade157
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 03:07:18.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x2I6MnpFz4elWX8h+Az+g1vi1oYfVAXDDNF78Dr0V2LDaqZ6Nk31U05ba0sm1z0L3VuINF+iTEErXXRrGKwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1263
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IFRoZSBOVk1lIGRldmljZSBJIHVzZSBpcyBhIFUuMiBOVk1lIFpOUyBTU0QuIEl0IGhhcyBh
IHpvbmVkIG5hbWUgc3BhY2UgYW5kDQo+IGEgcmVndWxhciBuYW1lIHNwYWNlLCBhbmQgdGhlIGhh
bmcgaXMgb2JzZXJ2ZWQgd2l0aCBib3RoIG5hbWUgc3BhY2VzLiBJIGhhdmUNCj4gbm90IHlldCB0
cmllZCBvdGhlciBOVk1FIGRldmljZXMsIHNvIEkgd2lsbCB0cnkgdGhlbS4NCj4gDQoNClNlZSBp
ZiB5b3UgY2FuIHByb2R1Y2UgdGhpcyB3aXRoIFFFTVUgTlZNZSBlbXVsYXRpb24gKFpOUyBhbmQg
Tk9OLVpOUw0KbW9kZSksIGlmIHlvdSBjYW4gdGhlbiBpdCB3aWxsIGJlIGVhc2llciB0byByZXBy
b2R1Y2UgZm9yIGV2ZXJ5b25lLg0KDQo+Pg0KPj4gRldJVywgdGhpcyBpcyB1cHN0cmVhbSBub3cs
IHNvIHRlc3Rpbmcgd2l0aCBMaW51cyAtZ2l0IHdvdWxkIGJlDQo+PiBwcmVmZXJhYmxlLg0KPiAN
Cj4gSSBzZWUuIEkgaGF2ZSBzd2l0Y2hlZCBmcm9tIGxpbnV4LWJsb2NrIGZvci1uZXh0IGJyYW5j
aCB0byB0aGUgdXBzdHJlYW0gYnJhbmNoDQo+IG9mIExpbnVzLiBBdCBnaXQgaGFzaCA4NzlkYmU5
ZmZlYmMsIGFuZCBzdGlsbCB0aGUgaGFuZyBpcyBvYnNlcnZlZC4NCj4gDQo+IC0tDQo+IEJlc3Qg
UmVnYXJkcywNCj4gU2hpbidpY2hpcm8gS2F3YXNha2kNCj4gDQo=
