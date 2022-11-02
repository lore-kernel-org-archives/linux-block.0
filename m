Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F04C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 05:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKBFoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKBFoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 01:44:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD625F56
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 22:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy9DLJDdYlKqTDLdWLwuIULqq8fhec2KnlbY4oyYOtmRz/H0Sdmb6KlRmbG9+EF9jnZQThfFvP6ttLDoX+DqCGiVV18OTc2hIHUWvgf9SoPpArVbcmCj5ZwLtHH3t4JXG72DU9ggpLE3wuMHwDptlXjmvkTjJyXp40ZXyR7/yTVS0UunAzoAI/IpgzSeIeQ3ulmKNs64e2eGzfiQWgsafJYMq7aMa5zWag04uT5s9qMKOm0aGat8QJd2TsptJG+0jYAR0qjs+g7xxBtwcTQCY+bECwQ/HWb8d7PAW+UlynvzgxPrwiYBX59knyHmJTj0cFAD6qR9Ijduy6GuvWGISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRLR4Et5ULttqNjEUGFoEibJvaAxFFJ1sctz9VpYV8Q=;
 b=CGTyiWMlpy6Xu0GUh98GZXl3/6V8DgmunxCDJBTOLG91Cb3U2TY5aflWrx2yxOqKFn5kduSK/mwAJ+3LiGo8a5r6kMDQzXzGRwvNCI928byW9pocELJwU3ybn4v/Z+IBMQGGE0LCCBQzlAaWgnwI6/syqxIP4RHIn9QaNFh7IkxsWzsIYOGoLtuKyz1QK1igOpGyppSOEtZlTcif73f/nQab+1hzlknaTfSy5lV851Txji8fmdxSbudaJGJc6dNOIMOJKfbtiiIqtTIdXI4RcnL/cpEHQ6rwz5vlylj8GBcMr53PembG/1fk+iBit4caE7dCgaB9Uk2+qOAXAD1GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRLR4Et5ULttqNjEUGFoEibJvaAxFFJ1sctz9VpYV8Q=;
 b=IDL7Jl5uRv0F2kYfwv4N1r9iq9EI4i06vF6sSjOL1jVELZyA18J/bpnr5y4/UT71RwB6MYQpZUXuIM8xL+RdtZOlO4ZO2u+msmu9eNlOMQDUzBkrnCXz0HwXA8UQFuCFf4NFL8D+snbV26XG+XPRILzaqmnK9B5p71PPG7LX6pv+U0vthxCluHdLUIFEbusbL30HtFsWANuglHIsJRB3vEHRGugiqOwl1gCmXNpS4BBl7+V3QfKHl03d1hhkF5Uwi7jxb04LJqBr5g+WWkqAqQCfKMObGLou53VRUAwiHnuSpv//95NAAbDaMPWiflmH/sIUT9vIE7rXc0Mr45aFYQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:43:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:43:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests 0/3] fix and improvement for xfs log size
 change from new xfsprogs version
Thread-Topic: [PATCH V2 blktests 0/3] fix and improvement for xfs log size
 change from new xfsprogs version
Thread-Index: AQHY7mbXAKFWnxvSgk6T1dRblML2Qa4rH2WA
Date:   Wed, 2 Nov 2022 05:43:58 +0000
Message-ID: <03ff8fbb-0cd6-34af-3e85-c630661df445@nvidia.com>
References: <20221102025702.1664101-1-yi.zhang@redhat.com>
In-Reply-To: <20221102025702.1664101-1-yi.zhang@redhat.com>
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
x-ms-office365-filtering-correlation-id: 7e740e79-d93a-4267-0b6d-08dabc953cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQOLmC18oPW41LhXDG9JcqX8D9bR9Tvj/CvAPS2nt7vHTv1z5gyiCMh+bMXdjHTt//AXE3d49vyS4B1rJEtHGvi9ZaZVoCMFBNvZqAoKU1cSPmyk6Go3oYyEkTIyHiViEOtmAWHj0O9K9lqKJI4O6cW99ZWenIQ/bXp6kHmM+hWLfRey5gd1ULH3PlupTiztOmU1FCR4EyE2mgTseBXXgTEu97iLx35jnMSYpL+FM8as9DGPvL3z7GWFuaTv1ELB2Vr/bt8KKLvcqL4NhczzRIrxV9kywYUqkeVvBx2wv+5wIALjGXjWDkBFQRBlT7jKErWJmpaGOS/ShnYz4DuFpnSoHRtIKAyWmAv5zLS4RUTlEJmwutp6D+UGRJ5FwRVMhG2CXGL41ujNiLDXphzb6nLUJnj+DDh0XMq4rSvx0ulGzUHoWi7XuiDIu2Kr1bed4OHHvOCwL4JTH1nLQJc+ouOWyKVHYjQsYxd4jmGbrGbkVYYpVtIZBfq0HFbsWuVaclMtp6T+qCFLR6jGMGj/YLyimlvssWobZ+cuSEdyKMRp8IV+lrqQ55jb75LRG8CfHe79EVLwlYEncUKfPQXnv5laYIZ7LJj2tv/dQbEcJBYVRY7zc7Yi4/pJjCBZsfgZdUJ3FfRhEt1qHUp8+6qvtwztX1hm6aOckRy2qLbbZ+BNZpWhCMm+hX1B5X/yvb08iyIzQnrq/Cl363TUBdUrkLdzlv65pi3MDDHJczXYLu6bHxeu5cTyyLI2jYSYLnbHkoZvEbJRDedSrrLb+UDnKnouGkDW9s2QYTmQ3Ck7/90+CG1Br2FpaKdjPiUtNw5ts8WqgkBWyuiEmMrQdr6rGpfHw2Q3NzW/BJ2nX7klW9ugJQznpzuQVx2KuJ11kNlif5D3IQL9vixJbC29MSFSq69ShNGUB9GBJ/rasaWynSw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(86362001)(31696002)(36756003)(122000001)(38100700002)(38070700005)(83380400001)(53546011)(76116006)(91956017)(31686004)(8936002)(110136005)(316002)(478600001)(4744005)(966005)(6486002)(186003)(5660300002)(2906002)(2616005)(64756008)(8676002)(6506007)(4326008)(41300700001)(71200400001)(66946007)(66446008)(66556008)(66476007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzVpcXBvWDRGNmxvS2ZNWUJKeTArZEsxYVFtNlMzeE8rM3pFNXNNVzdCbHFZ?=
 =?utf-8?B?RUp5T0hXcDlDNHpQeDNaOWdBdnl5dGs0allQU3hHVDFhWDVPTUZrb2VXNXpO?=
 =?utf-8?B?M1VOS1d1ejVkMi85WXRzdlUxSUE4SGVrdVpVRkVvWFp0TTNZaVBCSXpDWWIz?=
 =?utf-8?B?c3c1Q2xYcmZEM01wbTBNdmkvWVNJb0tQM2NiTjhIM0QrK2o5ZGFlRUkyQjZY?=
 =?utf-8?B?RjRncXMyaXZOZndXbmFtdE5ETVhzVzBvZmpVWTVBNml3OGdOd0RPeXdiYWwv?=
 =?utf-8?B?VW1raEVJZHhMdEEySGR0Yk1SRHJva1RaYS9YWlRXcklFS0ZvUEd3VVdSN0N0?=
 =?utf-8?B?Y0ZiNHk5U2lLVWN1K1JJWFBGOGtwakZnN3lIZkNyOC82SWJXU1JoaGtOZlV5?=
 =?utf-8?B?akRyRTdtTmp5ZlZ4N1N0bW5XaXhJemI3N1Q1S0pzWlNBN3JNdzVTUkFVMjE5?=
 =?utf-8?B?MTFsdXdDZmg2dFNRckp2ZEY2MTdQS29hdDg0Ym9XdE9JZ1ZmTTVneVBTSHpp?=
 =?utf-8?B?cEpyRlp1K3VYaFg2c1F2Y0xpNlRlZTF4eVRxc3I2ZG1KWWw2ZkR1ZVlXVlNG?=
 =?utf-8?B?Vy9KTkhGNmRlbStDQzlqZ3BmTUUyY1FTL0xJaVhsQ2tuS3lYK1hYamVEelhW?=
 =?utf-8?B?ODV1d0JkVUlEdTRNRi9zMmVsNlV4YXRmZ29LU2NEUlN3RVNMeWc5bXdpT2M5?=
 =?utf-8?B?dVpscFBwMUpnaFlHTVQyRXJ3L0ZxK1ExbHBxZkI5K2QrL2ZmbGtWcW51SDI1?=
 =?utf-8?B?dHpXd0ViTXZLeDROSVVtNkoyajh5NlNCTTNoTFpiOXNHWG9zbGdjRkloaFo0?=
 =?utf-8?B?LzJLMkJmZWZ2dForY0tCbU51d2Y0L0ZoNnAvNEx6disvRkU0TEg5ZUNjV0JG?=
 =?utf-8?B?Vm9TUzJMZ3dnUnpBazZENWJpSldHUTdUK2dZZ3Uvd3JvZmpvVWU0ai9hMDhs?=
 =?utf-8?B?UVYvbWNCY2ZySVFOUU04NFcybDYyZGRIS0I5ZWc0Ymh2ZFlYeVRQR0FqWEkv?=
 =?utf-8?B?aElPR2xrUTJmSGEyd0VSZ2Y0UTRiTzl4dWxsL1VXckpmemUySmRWaWRMemhu?=
 =?utf-8?B?QURIWWdmejZ6YkQ0Wm9MTElTWGIyRi90ejA1cWJXVS9lK1cveXNKeUdHRVU1?=
 =?utf-8?B?YVIydnNwdmNlQzRlVjV3Z3V0OGgxN3RaTEpCdlNNaGxHalpUaUJqZmpxZkNu?=
 =?utf-8?B?dTIrR3FyZCtkMnhFMk4vMDA2NWJWdnRwcDMwY3lKcU93NlFJZzE4eFU3ekN4?=
 =?utf-8?B?cDJNTXZ4dGJNMjBKQmlkbVNTaS9wdkJrYVdQRUFjSlg5SndpNDlRY2JpWHhV?=
 =?utf-8?B?a3JKWTZFWkpOQWpkbEJzM3VlelBjR2E4TFozWkVwL2JrNmxKS2xlekRmbmx1?=
 =?utf-8?B?NzZxSEdMZHp2Z3pEVFpYV3N2ZVdrQ3p6d0N5Qml1ckpNc0FhUHgzWHpTNFlO?=
 =?utf-8?B?d2UvVW4rYnQrYXgrN0d4ck5RNjlXTVN3cWRYczVtRXZUWU5wMFRySFJNMTUy?=
 =?utf-8?B?YWhHMk1VUkVyQ3VqTVZBanczR2ROU1p0bldaQVY0R1I4RmJWZzRocERlTllY?=
 =?utf-8?B?aUVqSU43eXVhUHRTNmNxUmplbHdLWDc0dVZsNDhVS1FqVENMamhTdWlZNS9t?=
 =?utf-8?B?Tmk1ME1XQU5DdDhtSnJuSU9oU2xrTTE5SHNzMGxVekpTNUFYQktGUUdvSisz?=
 =?utf-8?B?UHFUcEtRc2lHZ3Q1bDdia1FLUGVJc0w0Um1wNnpwcld0L1lhbGpqYVJ5ZWJR?=
 =?utf-8?B?TXRsaGVMNmtuV2JCSHRvZllCdm1zOW1sSUdNOW9xTXBsK2JHTFo0Unc1QU1V?=
 =?utf-8?B?UTNQVVZ6T0RQOENieDFvOThONFZLU1FOMUxBMnM4N3kralBiL1VWenBUeFRM?=
 =?utf-8?B?MVoreFVuV2cxcmVRUXljd3NaZmdES0h6MVBUa1Y5QlhQK2xVNTJhS3JYQmxn?=
 =?utf-8?B?cnlKSXRpQnFUdGpVNDQ5OENJTDI5eGIyZy9qZUZuc1l1KzNQMStSeEpnbkU1?=
 =?utf-8?B?TjB3elNqSHpvcHA0cmVQbk1JNHkyQURvSzlRSHV0clJjenhjZUFOSXVXOHlM?=
 =?utf-8?B?WXdySmZ4ckUxQTFWV0E0Zmw2TWIyenV0blVmeUVOQ05BVEVWekZwSWNubXlN?=
 =?utf-8?B?U3hKUC9BQXhiY1lGMFJka3VZREVhR3FhOTFJc2xmdWZPeW9ITXZtVm9oZHoz?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <448AAF3BC5EDCA459D62BE53BD6EF5FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e740e79-d93a-4267-0b6d-08dabc953cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:43:58.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZ2Hoi41qLhJfigJbNsK9FP7sZiKpaC/SJa2usWCLk+Mp9NYeOOsl0TRF/rCN4Qr2wNFVHKkuvnpv/aUhBPFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAxOTo1NiwgWWkgWmhhbmcgd3JvdGU6DQo+IEhpDQo+IA0KPiBUaGUgZmlyc3Qg
cGF0Y2ggYWRkcmVzc2VkIG52bWUvMDEyIG52bWUvMDEzIGZhaWx1cmUgd2hpY2ggaW50cm9kdWNl
ZA0KPiBmcm9tIHhmc3Byb2dzIHY1LjE5LjAsIHRoZSBtaW5pbXVuIHhmcyBsb2cgc2l6ZSBjaGFu
Z2UgdG8gNjRtDQo+IA0KPiBUaGUgc2Vjb25kIHBhdGNoIGludHJvZHVjZWQgb25lIG5ldyBmdW5j
dGlvbiBfcmVxdWlyZV90ZXN0X2Rldl9zaXplX21iDQo+IA0KPiBUaGUgdGhpcmQgcGF0Y2ggYWRk
IG9uZSBuZXcgcGFyYW1ldGVyIHRvIF9ydW5fZmlvX3ZlcmlmeV9pbywgdGhpcyB3aWxsDQo+IGFs
bG93IGZpbyBJL08gc2l6ZSBkZWZpbml0aW9uIHRvIHRoZSB0ZXN0IGNhc2UNCj4gDQo+IA0KPiBW
MjoNCj4gVXBkYXRlIHRoZSBuZXcgZnVuY3Rpb24gdG8gX3JlcXVpcmVfdGVzdF9kZXZfc2l6ZV9t
YiBhbmQgbnZtZS8wMzUNCj4gdG8gY2FsbCBpdCBmb3IgdGVzdCBkZXYgc2l6ZSBjaGVja2luZyBm
b3IgdGhlIHNlY29uZCBwYXRjaA0KPiBVcGRhdGUgdGhlIHRpdGxlIGFuZCBkZXNjcmlwdGlvbiBm
b3IgYmV0dGVyIHJlZmxlY3QgdGhlIGNoYW5nZSBmb3IgdGhlDQo+IHRoaXJkIHBhdGNoDQo+IA0K
PiBWMTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyMjEwMjQwNjEzMTku
MTEzMzQ3MC0xLXlpLnpoYW5nQHJlZGhhdC5jb20vDQoNCg0Kb3ZlcmFsbCB0aGlzIGxvb2tzIGdv
b2QgdG8gbWUsIEkgYmVsaWV2ZSB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcw0KdG8gY29uZmlybSB0aGUg
c3RhYmlsaXR5IG9mIHRoZSBuZXcgc2l6ZSBmb3IgdGhlIHRlc3RjYXNlcywNCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
