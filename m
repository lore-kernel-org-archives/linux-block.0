Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529FDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 08:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhKWIkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:40:21 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:12128
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233958AbhKWIkU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 03:40:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ7Z3eNPYn4qOMAhd5a69mUqTPqUfObUm1CYFLoRiddxUU+fz3Wl2cZx8e6TrI6GGEBi/oENL3sjv6VFX0+DtlofTT9EOhl406xmhWG/0gRAMQvcO41XO+KkgU1YDEiMjytjU5v5qA5PFLf3npdF6IP13H7o/bI09BB6d+1nxSCgVgw7HDvqhGpc+qQKCcQHpWs1oWPOVu2H7zdmP/Pisx9ff9n+DK6qV5Aa+KdyyA8GVF5LKqZjYwrECSVWvvZWUxPyXQwCfvdw6w2fvNwIv3apf6PpqfJ1/AqHKCmd7gtFxwk+L9kV4eEGOmwijT90/6Fac1Ntxsdh2EXKvBnXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMazYwjUf/t6UlxHpuvQovUSh8G7BVoKcQvOzh3NCiE=;
 b=abICL8bT+MvVyB3KIwpFFtjmxw9K6GF7DPNs6rlfGy4d0GaryicPp/ZgrrDrfGfG50Sigt/OB82SOf4kQqQKcMI1C1BYinpHbpEYZdGd+DbhoPSsU/BH/p8PJxc0iKv2Phu4FFUgTQQIYEdHlupmKc7tP23gd/EvyEa7Th0eGoufY0LfJ75BFAsQIkeguH1zlIBNhSLoc0MkSvQdl9qFvadQHBZFzmrZcsAaszD8CX9DEbqxFCWnhi7+UTOLe77eZbLac0bKSntNDE7uCt1H/4I/mER3DaxwPBpkQV7E6nnF+vRx5cyL6tWq3nq6EhR18/iCpuOqAQp0vsCA1itYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMazYwjUf/t6UlxHpuvQovUSh8G7BVoKcQvOzh3NCiE=;
 b=IliqJSaarHH5VnoEB6M2tt8l/ejGbIJpFo4buXyGv+Qgh+4QDmi5OeqJqX2pD6EEABU7ER6sc2L1nS3otjvaK/Nw6xgpMAbx8oOyWxY7n/ew4p2foxA68SfnsTVUh9Su7kwDukZDun9cVsA+3dGUfRVct/mx3C3gwidJ8kr7JXlnTiLNulAKV8Qq+gY3QFEMyWaAtEoucaU1HntuaYgWKNi4TZaO1raCx8W16PzqfKCFf5u+9EPbErP01f0Q3Ff4JJSY/8leGhu3ogZBaIwCaPtyn4fjlFrlRZ44ofaOdjanp/8pnn8OQ1GFYWO/3hC9APqqzO0AYX1ISk76Ki2ANg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 08:37:12 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6dd2:d494:d47f:5221]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6dd2:d494:d47f:5221%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:37:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "kernel@vivo.com" <kernel@vivo.com>
Subject: Re: [PATCH] blk_mq: remove repeated includes
Thread-Topic: [PATCH] blk_mq: remove repeated includes
Thread-Index: AQHX4DQjLuoSCaJNkUm3l0JNyBkMZawQyjWA
Date:   Tue, 23 Nov 2021 08:37:11 +0000
Message-ID: <140942ba-b46e-6c88-4be5-5c0fae104f66@nvidia.com>
References: <20211123063340.25882-1-guozhengkui@vivo.com>
In-Reply-To: <20211123063340.25882-1-guozhengkui@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6590de4-7024-4a4c-90bb-08d9ae5c71e1
x-ms-traffictypediagnostic: BL0PR12MB4707:
x-microsoft-antispam-prvs: <BL0PR12MB4707BC73B4FF806C8DF52B6AA3609@BL0PR12MB4707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9/y4kOD2zYAsB8t2T/pYuzZr7lD0WS9d3f1KyFJ9clRGFRGRCELE4KV6jI8GG1ujJOJL5urPeKmBrbLtg3dQmDgIp5sHGqiPeMBnLgXeewvlHCqN7fhANxMOXIit/CmtID5W7ohkaBhp+H2Cr8mHbnKwO8d/dH8gv21N4ai/MPz1UsmiGroI77WS1MTuurRYMONUtMrNe3F4kDPXWnozwS5CSN4n7BOKpp7Mvba3cf6C7xoaN4iK2m1SWUF8Velit5DtwVfIGSyoyExiUf0FIv1rmEDNRQXrs9gFrx7JCtqW98Q1HiKfyGJ12Yywhu5z/9/ImgooLClIJ8f9mU4Ferg2yqCnZqXCNzatIUMcCVAUO57Daqox3bSzrtJmdF9aDtpqmcMIrFYX3nYXH2ID7f5XjBKE5qDqLMRdQQPuSCkerX+eyMwkMjYDIq97ZLtzlqdrtBwmm0g0/2RXFRXwte+el2D+XY1qnA/K/x35VllxQLu3MCAD7wKiv34U+yk1AUwfyv7+Nt9o//qhJAxXT/rfjqx60tS5CVeV32YGM215FCNeQQPVyXc81W74PeWQolUJVUtee4+4sPioFpLjlkfBibIF4R2NX/JJGvvOYhIjVbXge9LtOaK8qJZrBFYEK8iShd6Xn78L0UJtkO36pUUCMzVrSK4BsbTS4HLlTMg1AqAAd9ETXIil1KATpOD+hWYFAmhja6re3mNaeDKIPToJI4LWYGWZElogMYoa7xWSDy/dkcARupjW6HGNvpzxehgxPsev5f/O8xR8M+jVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(76116006)(122000001)(2906002)(66946007)(36756003)(110136005)(558084003)(8676002)(38100700002)(6512007)(186003)(66556008)(64756008)(66446008)(4326008)(31696002)(66476007)(316002)(86362001)(31686004)(5660300002)(2616005)(71200400001)(6486002)(53546011)(6506007)(38070700005)(8936002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXRLaXM2YlJDNnZUc2wyN2VncEUxODI4eWRuaWtUZ2ZVNzE5bzU3T0FPd3Y2?=
 =?utf-8?B?T2ZKcFQycEY2d2dzbVJFNmVTMDRBUWZoVmZxamJoclo1cW1pamRlKzUrZTRN?=
 =?utf-8?B?UUpkK1ZQRXF5ZlVyM1lMTVBTMzR3NTVLeWpkTzg0RVd4dm9ySEU3UW45em9Y?=
 =?utf-8?B?U2tJSjhBb0FuU0FVZ29hTGY1OW1nMFVoSXNGSDgzRXNxckR6STRHRzNhSHpq?=
 =?utf-8?B?a2o4QldhK1l5RmJFaDlNM2lvVzB3S2RpNUxyU1RSRHJDWGJYZktwdzJ6N2xP?=
 =?utf-8?B?dHkyenVUZ3BEckJQVWVOM2s2bmNMNXhBMG5IVkJDa2h1L1NtYlIwOTdJWHFL?=
 =?utf-8?B?UDBxMnMwWG51Y1BPZTU1UUQybWlyTHpYSi9NZ3QzN0lodDMwRHl5a2FsOCtX?=
 =?utf-8?B?SkU3eFFVS2lURCtBWk5ZQ0lCcUdiSTJ1eHJ5b3c3NFN1aXVPSURrWnA3eWl2?=
 =?utf-8?B?Zjk0RFBIaUxROXBRemt1S2V3ZWNQbS9UekJXUVBZWE1Jcm5RWkxRNlEramdn?=
 =?utf-8?B?VEdJb2M3QTlES2htM1V5MUVrVHU4eWUvTGFIV3J1cUo5SDEzbmRmZkY5dWFX?=
 =?utf-8?B?bUFKd0gzZjhaY205NmV1YytiRzBkV3BHY3BZMkErTWNCRTZEZEVTTmlmMnNC?=
 =?utf-8?B?d1Flb212aEdIYlFIQk5JVjhNVnBNL2d2Nmg5L3FqRzJneW9YQmV3YWplS3JM?=
 =?utf-8?B?S2RxdytFOVdxYXhmcjd6dzlmMW9GU3RvTDl6WFA2dnZGVTF2L213K3lrSjJh?=
 =?utf-8?B?cHYzSE92K0syTXdNalYyd000YmpPQXhtaGdrNTR6U3N5eUJac0xvdW5IVEpV?=
 =?utf-8?B?WXJzQ1VkL0xkcDNPQ3p0TzFsdWNmaGxacmxoem4rWlFYekwxc3JwQWFzU3FF?=
 =?utf-8?B?Y2xpTDNtS1N0TGJoRlh2TUR4QllmcTNtSStTRW5BWTRQaTZLbmxWZ3hucG9C?=
 =?utf-8?B?RnhiVXRwRzh6R2cvL3AzRUcvellZNzFjNkJPZjRuWmNlMXZsdmozNHNidXNI?=
 =?utf-8?B?dWJTSTBKbFp0UWthb0lvem9TQjI1dDRoS3RjYUk4TmlhZnlwSXhDNUZZNHBW?=
 =?utf-8?B?NlgrWkJyczRjcmgyS01sL2RDUCtqRzNaMlZuZk5zRkpGUVNvT1RlVzRDcTdY?=
 =?utf-8?B?TXBhSzBZRlJBTjJ3SFE2R1BJSUMrOVErcmt5M3Q2R0xYTncxdXdOd1l6ZFBl?=
 =?utf-8?B?TzNJSStuSW1DeFBqVndZdDBUZDNXTzNIUGtaWUFmaHJtQ3hkY1ZEaEpPeGVN?=
 =?utf-8?B?VXIxcFJrQnpDNWx4RkpsVEdCN2xNc1N5UWdLWERvQkY3WERnN3d0ekRLank0?=
 =?utf-8?B?NkVvZXpnYi9Nb2JiYldHYVQ0QUFIaGxES2EvSkcvaUFkUmRHN1ZvdmdvYnNa?=
 =?utf-8?B?Njh4VlRNQzVSUEpETW1kVnE3RUQ2YzBnSkM4UXJ5dW1VV3ZpQy9tNnAxYXl2?=
 =?utf-8?B?N09Wang5LzNaeUU1K0hKUTZaTFg5N2hQUkZhazA0TGRtL2hONWNiYmJXNStF?=
 =?utf-8?B?bXk3VnRCMzQzbGlXSjVMNS9zRUl5aUJFbVVlM1RZRXpwdHF3NFlmRlBrSm40?=
 =?utf-8?B?czg5WHVZcGJFRTkrSEZ5SktvTThUc0lOUitoUEtrV2ZtcmVmOVcxMWNQc3hs?=
 =?utf-8?B?Zm5EQXpYL0tpaXM5dkVNNTZvSnVoanhJUGU2Y0N0S2RxczU0T0c3TUJNcFhP?=
 =?utf-8?B?RlJLbXdqQXJ2b2pCSVVKc1NGREpGYytLeFBlelNUTzZ5MWFHSFNEb203V2JI?=
 =?utf-8?B?SFpLZ2tROVdRVG43bWVvdm9GUzhadi9nT1hnZlNDNTNZOWhZK04xdTUvR3VH?=
 =?utf-8?B?MEdvSmZNSEY2VlBvblcwUWVVTWVZeklrVlJLckFoVmNSdWM2eE5aQTZNZjB0?=
 =?utf-8?B?SWxlSm9MRFYxVlVQZjJZalZ1UWo1YXNGRnRMMGZ4U0JMYTg4Yis0VnhBTEdk?=
 =?utf-8?B?RDl3SjFDNWN1blBwTkV2YitibXdyd2NCN2lMQllQUTNVaVFLN2xSWk02YUxs?=
 =?utf-8?B?NitkTG1XKzVRTWdBRWhCMEowa2IvVFB5RGNEcDZEQjhWazJhSWRJTk5wMWdR?=
 =?utf-8?B?cE96RkZKcUR2OVY2NjEwMjdGc2xzTTNWVEw0T3A3bU5iWGFVUXNETHg4M3J0?=
 =?utf-8?B?M2dIeFRqdzU3SVcvakVPYjZHeGNzcUh6OUZwdDJZSzlKNGovd1BHZ3NtK0gr?=
 =?utf-8?Q?6YHK0iZu1d/9GW2USfUExUkFCu3lPSr9tjWZV1tmretd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB4779F42CE76247A9E9B4C0E74B12C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6590de4-7024-4a4c-90bb-08d9ae5c71e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 08:37:11.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GA4LnI6RAuhUiMfQrsitcwhfoM2zZW8liHlmYySoHOd8NE78u6MF4WZgZJdZsAgWly4F2SG3WuOix/Hs/o6oJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4707
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjIvMjEgMjI6MzMsIEd1byBaaGVuZ2t1aSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBSZW1v
dmUgYSByZXBlYXRlZCAiI2luY2x1ZGU8bGludXgvc2NoZWQvc3lzY3RsLmg+Ii4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEd1byBaaGVuZ2t1aSA8Z3VvemhlbmdrdWlAdml2by5jb20+DQo+IC0tLQ0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KDQo=
