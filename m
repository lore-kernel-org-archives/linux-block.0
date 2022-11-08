Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644AC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiKHXH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKHXHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 18:07:11 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80465847
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 15:07:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpZl6QiPNwJRP6AOG9JKQeQTGbfQGFwn+aPad20/Z0BpRM8dbHCPNPzeCpbaKJrZGoClZr5mFgTX5aV8MdmZWBIg4VO12IjQQkx4iCemBkFjLsAbQ8DLWnpMv80McBGHOWHC11f81eEfT0PWJWCGXjwFRqAtnyjKqbqnzWuh6sVpf/zHG8j2bgFlFwvUQwYNKD2s4AxXtPdIyq2rco76OTWPY+VJIKi7fMDbLXVDycQ9om6j77ma5c9o/SHwXJR5vlvA/9R9G5MdBG5mkwfRSrjRBJE/cTyrnHo6eg5bCYPyHg4aSB8UoZKenSSzTlU1/c4UcM3xobjEjOZdFvcVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsSkYlTQTC5qgtTCWph1AUrq+3wx5X2z9/1pYo8GkwE=;
 b=fu7iAk+WQDJrme0MBYT7SSi4i0yZYiUvtRCFV9AqlBxBvETatwMTXrFRmr6o4tcBfkvDkyqtzKibh/mWr5q2rmG+PTXalgkAippZpqSwa2nPy+j/uvJtapMNGbQ9mtnk2LvdR4Fo9o0QoAGo7Z8EPfbtdp3fF6VtbsdIJGVMVWQ5XH37t2FDKkhp7jlhcIJZltZOpZuvjZ56AIOLGY4JpBJQ2z2hr6BS8ZL4/NPc129UP/5nDLE/EEumD85ZIkIpFjLkz+gWni31fV7L4tCEC6a3uZb8IiymBolB4naJ5QeEVG7bguDMZwlr4d1dJ+sDw+3d55pIb6hEH7trpcBh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsSkYlTQTC5qgtTCWph1AUrq+3wx5X2z9/1pYo8GkwE=;
 b=EX826ysTWYq3RqouMi8s+J7j4nw9r4j+KcKxhi3RXJuupMizcFU/pFBsWNJcf2YX6dqCUSlCODN2/Io1+zlFfPmrBJNNYXCog5jM0KFZbSCr0mqXPpzYDC+aPwz2c9G4CxokdZhTMC1IHo0z5I6tqmWLvCo8aJvrXKWXG420ofr8wKOClo7Y0RNXbdY1vBF+yJz4OIqo82SCc5SCN+C4zO2plt2DAsBCt8k04cmzGDR0j+XV81C9IpygLPrgwwdWvAH1Aaa2FhFHM0TSznzPwyE64apNU6HWqalF5CCYmh+fEw6Zr/jJ3FC+8kbmAb7G4uTLFtLPpDXzHcXIXjrTtQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 23:07:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 23:07:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: Re: [PATCH v5 2/2] virtio-blk: add support for zoned block devices
Thread-Topic: [PATCH v5 2/2] virtio-blk: add support for zoned block devices
Thread-Index: AQHY8yefNtd8QChdjEKaS9bbgEljh641p1QA
Date:   Tue, 8 Nov 2022 23:07:07 +0000
Message-ID: <7efabde1-110c-56e4-ce69-33ef61825850@nvidia.com>
References: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
 <20221108040718.2785649-3-dmitry.fomichev@wdc.com>
In-Reply-To: <20221108040718.2785649-3-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5125:EE_
x-ms-office365-filtering-correlation-id: c9ddc098-8572-4e25-f974-08dac1ddf530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7kS4xmOBX814WNdj8oGVF8h5kWk4hH9vShO4KnJ6AELauX6pikSYRreKD3lB3QPivbU8tgSj2s7AqMzMjd0a81tojiOw0rd1+ztuV8YOB24ksbkSjoTx6r0VUL1EdUgOMKY4qRNVIIYB0o7mzqZEV+8hwmqLpWq/CQfVLE7GHUkJQUTuF20Ck+wEI3rMNj0UuyhTUl5uM+FQQw1bloZHq4jLqUoIu8bNuqHD7C0o7EqFC6jYhBr6lD3YN2UGFq9CCmUvkPXCRjHMzWn5AbeQ4H1IAGmwcutwyXw7YVkTeWSVJhn218dYXz6gkYo8IXTyXWetRHg4wBHn+ADvCv/cHj1tH5mqIFpFqsjtITP+uO2lMsuzVYWdSYIOllcFjVMvXJDOMmk2D1t5d1xUha+EzoLy/oQGkGrAYTS7Agr8thlNVQffSm0O56E6keWX0Umw2keEsOlhVH6bxw0dcZAv4FjezHocSrA2xMg5LsJLPHQ39dwKQCo2yDInS4zwmYE6zEVY/aejB7xlfoeFzi/Dxk0yGQrUlSZ03iO6UO7beI7zvbKVkrvM3vqbtXf7U6bAzfjB3NdFf1XZSWotzn6TAQx7fxZZuIbi0HQJelvmO+3o5lYBuC5IyctbV7VUMCQZBvykgLkKybYdD9gs4x2CQhIfjQpOzbwJ0xiZWhs25UsYzJ3sG7/QlJAg5ES1OrB7wMmD40/mo1l+CVhDisT7yMKgWBTYFmFM8itp/6qIYVflBKRxzh3lqwCNqndq4CSu1iKv4GZwrKXlQtJ1g8MBhncAO7PQCDXa7zOFJLBptdoewS9W0TGPcquPVRECBw4NHy54dVsrvL7pS4y2nDHoWCzxRB/fK7oZuIHyjEaxpEwA9vg3NhSNd+UIOqugNkTjiMhR7k6STx9NkYJNSZBlwl8OPo4K/nWThNTFyn6LBQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(86362001)(31696002)(36756003)(38070700005)(4326008)(186003)(5660300002)(2906002)(2616005)(53546011)(6512007)(83380400001)(6506007)(38100700002)(122000001)(91956017)(66446008)(64756008)(66476007)(66946007)(76116006)(66556008)(316002)(31686004)(6486002)(71200400001)(966005)(41300700001)(110136005)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFJXOUVTZTlYZjd4UjVOZmgwWENKU1hOSGNKR1lBOTZlTkNrT2VENUV2cGtY?=
 =?utf-8?B?ZE9uczFCZG8vL2Y4ZXdxazNDNnpFZ3NOcmN4VTZKS00wek5kRU9UblBkNVB0?=
 =?utf-8?B?UzZVWmk3K0pDOTROVTBlWDk0Mm9SM2pjTXN2MmJiS1MwdDlmWXRuaGEvTUd3?=
 =?utf-8?B?WkkyeHdjTkZIaHVNR1V0MG8xU2hHOHd2VlZwbCtRTGxXb1F2c0VZRHd4VTIx?=
 =?utf-8?B?MGRZMU1ZWVU4bWVVeTlNYnM4VW5DdXRva1EvVmd6WUkwZnFFTDBFa3R0S0pj?=
 =?utf-8?B?eVBKMmpLa2k3dyt0YjczNTBuRnEwUmdpV0x5YnVmV1Y1WXRCRUYwdlIrc2dG?=
 =?utf-8?B?NWE5QTBzT1F2QThEb2Q0QmcxOTZmZktlS0wxcy9IQzhBazlLazdTTEhueDJN?=
 =?utf-8?B?U0hEdkVJK1V0c01CdUJlY0t5M3Y0L3lSWE9ZZk5LUXBPU0tabDFMZlJGMVdm?=
 =?utf-8?B?a0EyUDhmb1JPdEFGOGtwczFnRzZsd3FQeHRjbWd2bVRkUDJPOTRndnIzVFRW?=
 =?utf-8?B?RWtaQnRKTjYvTkZ0citmdDJrOEhIcHZZTUQwZVYyc3Z5c2RUUkp1NUs3Vktz?=
 =?utf-8?B?YkY4RUlGaWJiYXJUNVV6Vzd3YVk2V3hJWEIxM0lSazJHQWJaV3pYQlpVZmY3?=
 =?utf-8?B?NTg1OUNBcUxMUVJKaGIwUCsxd1djOUY5ODN0T1l0NDhDM2dMeVZ2V3NzcVFy?=
 =?utf-8?B?blJvMWZuM1lReFQ4UklIMjVaaU1oU09BNCtuaTFTeXdjYkRocEtQamI2Kzhh?=
 =?utf-8?B?ZWxyN0FiNUdoZEcrNmxZVDMyd09IeGNyU3hSMXJFSW1ZQ1hPbG5vaFlMZFpw?=
 =?utf-8?B?ZkFhWkE1MXRpSHZEekxmZTQyaEdadjVCdVlqWVFXOVg2UW11a1NXMjdnWi9L?=
 =?utf-8?B?VWpPTGVHaHVsc0RiN0NjWldpU0NLZlBkS3B6WWwyRmw0NWpPTmFwUjQ0aExt?=
 =?utf-8?B?Y3E3WE5USmtlTlE1R21QMzd0TVZXRWFkNnJCQVNLa0Jpd2J5bnpGNmREQ3ll?=
 =?utf-8?B?Vm5ZVk9wd2dnUERGd0dOSzM3UjRLSnVuSm1hSGk1N0dld3BrVTJRWmtCTXF2?=
 =?utf-8?B?YUhGM1lpRGFLd2YreUVEWmk3b2F1UHEyaHp3ZjArSjJEbDlvQ2ZMZ1F0MWE4?=
 =?utf-8?B?SFczRmNxbFR5bDhGUUdRU01Yek43c2t6L1M5VWwzWXFwUllLUTlJRC9Ebk9V?=
 =?utf-8?B?aDZiK2hoM0MvbmxoRWlUeUlHSW9JZWlraTA1d2p0eExwdGZLekh6eTZ4Y3Bs?=
 =?utf-8?B?UHFqaVVGVEp0SDNuYzFBdHVCZWUydUhWWTJIOC8yb0NUam9oYVRMd1FlbkpO?=
 =?utf-8?B?ZUxZMlVISjVCdTdUR1Bsdi9rZlhZYTZvMnJKcURaR2p3VHdxckFSVWxFNUU5?=
 =?utf-8?B?dURsakljWXlLck5NOStXeG5jbStQaUJ5clB5RCtOci9Kb0tKWFJvdTU3Smh3?=
 =?utf-8?B?RWNrOTVDS2p3aUVDRTFDaHU2akpwMWRDdFNHTTFlOWZibFBSR3lweGVSa01n?=
 =?utf-8?B?Q2RjK1l4ejdvc2dXcXFpdE4vdHRvNE1paWttcUdqVDRDbThIR2VXNDZMSzla?=
 =?utf-8?B?a3IvdEwzbDcxbjJpeXcxWnpkcmdvb0FFMHk4ZE9yQnkvVUswSVJQY204YndY?=
 =?utf-8?B?bzNmUWk5RzlCK1dEeExXazBYOE1QeDdNUGN3Mit6S1lFanBsOVp4WThQa3Nk?=
 =?utf-8?B?SDE0OXV4UFlVclFXVW9tNjdSYUt3TlBjcFpBMnlRaUkyakwvL2tRSXFIK3JI?=
 =?utf-8?B?NW9ZUWU5Z3ZPaEx1MjFSdUdXR28vbE92UjdLLzdpZ3VTM3Z0OENoaXdTTUp0?=
 =?utf-8?B?cDhsczN5b1p5UFVUbzJUUVNaNzZzNDNaemUrK1h1dDRLRlhWRU9NWHFYMmhH?=
 =?utf-8?B?ellNQW83Sm1zRlprd0hlVCtVamN4c1BPR1VIVTBMbXBGbk9Iemx0dm56dTdY?=
 =?utf-8?B?aVBCTHArSFpTU0dsSDliVTVmVXYzRXFMQjR4Yy92NGhpbzY2VDAwcE1zR1I3?=
 =?utf-8?B?c2tyc2VYNi9aS2JrS0lSVURScEhlUXFnZDRZdW9zOGZZL0lleHFvNG8rRUYx?=
 =?utf-8?B?ZG1uNElqNHFPSEZKMDJIUzRGNTUyTERWTjdPaVJnWlhQWm1CQko3b0VWOCty?=
 =?utf-8?B?UGNzSG1HZmZybFk4QmdrZkw4ajh6eWJiak1GcHd2bDkvWDBIaUdaZ2tKSk1w?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D043CEABCCE5214E8B21BC0E64D2086C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ddc098-8572-4e25-f974-08dac1ddf530
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 23:07:07.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /07youajgTLQvXFFl357v4zAvpNbmiX/hpb7F5ll5v4MbeagaHwidOc9dIP3KTQeMmly906bAHOYJElS5PsWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNy8yMiAyMDowNywgRG1pdHJ5IEZvbWljaGV2IHdyb3RlOg0KPiBUaGlzIHBhdGNoIGFk
ZHMgc3VwcG9ydCBmb3IgWm9uZWQgQmxvY2sgRGV2aWNlcyAoWkJEcykgdG8gdGhlIGtlcm5lbA0K
PiB2aXJ0aW8tYmxrIGRyaXZlci4NCj4gDQo+IFRoZSBwYXRjaCBhY2NvbXBhbmllcyB0aGUgdmly
dGlvLWJsayBaQkQgc3VwcG9ydCBkcmFmdCB0aGF0IGlzIG5vdw0KPiBiZWluZyBwcm9wb3NlZCBm
b3Igc3RhbmRhcmRpemF0aW9uLiBUaGUgbGF0ZXN0IHZlcnNpb24gb2YgdGhlIGRyYWZ0IGlzDQo+
IGxpbmtlZCBhdA0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3Bl
Yy9pc3N1ZXMvMTQzIC4NCj4gDQo+IFRoZSBRRU1VIHpvbmVkIGRldmljZSBjb2RlIHRoYXQgaW1w
bGVtZW50cyB0aGVzZSBwcm90b2NvbCBleHRlbnNpb25zDQo+IGhhcyBiZWVuIGRldmVsb3BlZCBi
eSBTYW0gTGkgYW5kIGl0IGlzIGN1cnJlbnRseSBpbiByZXZpZXcgYXQgdGhlIFFFTVUNCj4gbWFp
bGluZyBsaXN0Lg0KPiANCj4gQSBudW1iZXIgb2YgdmlydGJsayByZXF1ZXN0IHN0cnVjdHVyZSBj
aGFuZ2VzIGhhcyBiZWVuIGludHJvZHVjZWQgdG8NCj4gYWNjb21tb2RhdGUgdGhlIGZ1bmN0aW9u
YWxpdHkgdGhhdCBpcyBzcGVjaWZpYyB0byB6b25lZCBibG9jayBkZXZpY2VzDQo+IGFuZCwgbW9z
dCBpbXBvcnRhbnRseSwgbWFrZSByb29tIGZvciBjYXJyeWluZyB0aGUgWm9uZWQgQXBwZW5kIHNl
Y3Rvcg0KPiB2YWx1ZSBmcm9tIHRoZSBkZXZpY2UgYmFjayB0byB0aGUgZHJpdmVyIGFsb25nIHdp
dGggdGhlIHJlcXVlc3Qgc3RhdHVzLg0KPiANCj4gVGhlIHpvbmUtc3BlY2lmaWMgY29kZSBpbiB0
aGUgcGF0Y2ggaXMgaGVhdmlseSBpbmZsdWVuY2VkIGJ5IE5WTWUgWk5TDQo+IGNvZGUgaW4gZHJp
dmVycy9udm1lL2hvc3Qvem5zLmMsIGJ1dCBpdCBpcyBzaW1wbGVyIGJlY2F1c2UgdGhlIHByb3Bv
c2VkDQo+IHZpcnRpbyBaQkQgZHJhZnQgb25seSBjb3ZlcnMgdGhlIHpvbmVkIGRldmljZSBmZWF0
dXJlcyB0aGF0IGFyZQ0KPiByZWxldmFudCB0byB0aGUgem9uZWQgZnVuY3Rpb25hbGl0eSBwcm92
aWRlZCBieSBMaW51eCBibG9jayBsYXllci4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBI
YWpub2N6aSA8c3RlZmFuaGFAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgRm9t
aWNoZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYyAgICAgIHwgNDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
DQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaCB8IDEwNSArKysrKysrKw0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgNTQ1IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQo=
