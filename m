Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD0FA3742
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 01:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJaB7o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaB7n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 21:59:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A2108;
        Sun, 30 Oct 2022 18:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR+grOReayu5n8Xw2ZAdjWuT9/p+vDK6/Mf278zss6EtOPsQ34+oqwgBB19etCZIOHuKaEmeOOnr5c+GUhNI8jVURPuqr8Sql9lJhqy2q0gh4DBMEucqYizZAA7dmdPS2NBcD7PhGUcdC6L3i1drynCNQ7N/CxZb50SRZUBqpW9Idrf/RRVtV6mZ0HNKGnJrj2OgbmxnGs7W1MZhjU35f+0/4rcF7TdbOax4kV2cvCIbyPxYYA8lEkDCkI2/tLLx9olytk6DbMFRuytXtH9JBFoBZsorMp6SRS57TtUbChh04ofTMSXBKjc4r+v78VxRshkgyufW6GhcHvwuO2oeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V3/lJDo1mniiqEG0OuMvYnwB7Eu3PlPZb+Xmvf9L9o=;
 b=C/3nAnA5n2+5MIrVfDuRQMaFUHUarapLXGFCxVpD3OfLsPkzIf9QCjVr7d+qtxwdvgd4Ae2IB9Q5HTkzD55HqMC7gTb0rk6nW/QsnqVLbYoxP7VVIO/dzTRvkPE1qsejwYCcA0U6WsKTxr1NBP5pu6YSyPUrVL/S1S5RWwtwlzdYaULN4J5L/5gfv1aiXybrvYjeQmkyuLQgQ0FfgVsazvy3WuG46yto2D500sVSqvDu3JkHzZKo1HE2oVrrV6mhhJUVRypkN1bYkUoqrkKmVh0G3w4PAOLlujWLVUGY5IqehBfK/vUwHcAY5Yp1THFYaG0TN7pTp/v85cj0MVuXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V3/lJDo1mniiqEG0OuMvYnwB7Eu3PlPZb+Xmvf9L9o=;
 b=oJw5zGM6imw8ICC6B6sQ5sewnxYTUfghUgg/XPmAtHfvvlhotvtJ5Z6u9P7MTfzuwBiwrCYzp7vemBVNnMobrJi1E0hyFY0Reg4ZwpDlaRCqZX4jozQllFw/VL/RRPLjBzh12CyRH8q764zzjlHGuZfDeNyv52tOSO3/bFxRZlT0RnNztyzvJ6GSZMSfd5HWIPCQeSpFb6oeoa3aHB7nNJo2z1IvFxbG8yvBBKh93qY/QLwKYNdhARgAWMJ98mi0nEhjuybxWWOG2GAPSVmOwC+IEfPxye4jhfoTay8ggn0wUW83yklS2UzX+Wlp9oVrTVt66GfQD/oKIiQ7+NcI8A==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 01:59:40 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::5d3f:ebda:53e5:8ac8]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::5d3f:ebda:53e5:8ac8%5]) with mapi id 15.20.5769.018; Mon, 31 Oct 2022
 01:59:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 0/7]
Thread-Topic: [PATCH v4 0/7]
Thread-Index: AQHY7MuhcoQEt1ynRkGI27mJAHguP64nv0mA
Date:   Mon, 31 Oct 2022 01:59:39 +0000
Message-ID: <dd214de3-2501-e0d0-824e-a3b893dd012c@nvidia.com>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|CY5PR12MB6384:EE_
x-ms-office365-filtering-correlation-id: 36ad19df-8f93-43ef-7994-08dabae39230
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S822Jo4D0zVOLd748o86E8UYMGIy5Gaz4WBLq2PRXAnmbtJF2eL0xGRzBAtxUhlO6lesC1bSew+TTYzc53LTZqs/CyODNJs8AaMkc8fefNX18NSlMQqCEQDMnAwlXa3OCkWdxOAIzrZtm0Cq1TmBof6AMC3ET70xIn4J2b5vFxhedFTd6RSjhL2xSbAAtaxNFTck2gwI8/mY04iNBc8WGU/jgSAypCwNRdFQCiGQqC6Kf9DToBKhiLvETb1kGXqlf4iedxP31qHJsMTmZwBACtz5mGgrmwhldxVo+/zv6RGRdZS9vyLi6Fl9kZfX2KjiR60WuCTjoOW2M8cdet/DSsYhnTJ8Q8duspnK3IMiP5g++Tz2UR0S9gW6QlB3Pks2jpTxBz9/q7NjwN4wArMvpAPO/f1CjeNfdC3xx0Qlr9FLVlmB5b2MHkuTlA09W6LWmybuKqo1ZUXtuha1Ka2KgVM2KZcHAQ6PQGYb3J/3PdxmcXf4sXinFl0ixb/PuzHN/hZOgdyfkj2krXQeLpQpIVU1GoaFmIiJ7KK/BTUAXEvf9hWkyZOWlkitZisVnzlTBPADrMCH11XCAfGHbG1cpMFck6DsSEN/nE9ixhc9vtRWJSPQ0Vhv6ztplK9JvxRWr8qtO0a8/iHP7hI69heChNS8aDOlyC6GMURSytfRda7CwdLXVfYYC2ocCKIVKV/LOJ/ZChlvofhG4HbJUiaYa4YWENWg4/TLUr9CPBnLsuFLEmlPZUTVCIDesBRbw1S9XYwSc7/XOgh4fRGWwlBR70xbh57Vn08eelIUmtI5zOxI5piij/1QoTYO3lwPzQKVZZIN0X1bSVRwY2ZZ9f/6aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(31686004)(86362001)(31696002)(6486002)(2906002)(71200400001)(4744005)(122000001)(38100700002)(38070700005)(36756003)(6512007)(53546011)(186003)(2616005)(91956017)(66946007)(316002)(64756008)(66446008)(66476007)(66556008)(76116006)(4326008)(478600001)(8676002)(6506007)(41300700001)(8936002)(54906003)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzhuV25WOGdqUWM2eUdHT0ZFbU8zYWtZRVFzTFA2Q1l3V2RsbW52RkpGVm0x?=
 =?utf-8?B?cng2RWd2V0VhNWZvdllmWnFNVWpmK3pEZnVPNnNMUWNrS3I3QW1XOGx4YzM3?=
 =?utf-8?B?cmtIZVBxVHRwZGtmdGx2RkRqSHNpUWc0RnVHVUR4T0dSZ1B2bXdVQk1nLzBr?=
 =?utf-8?B?VllCRkVZaFB3U1ZtMmMyWFVCZmhYMFovMm9qS3lmNW9WR21aSmErUjZmN1BB?=
 =?utf-8?B?a3lVdGlXdG1lRUhWaTNUQS9XaFNLanlnUU9pK0xmb3g1aWgzVTd5bnM1ay9l?=
 =?utf-8?B?d2I3MjByQ0N5a25CTFpjbStzRk41eEhyWDNiU21Ca1I2cm1jZW5pRnF2YWw4?=
 =?utf-8?B?eEhocVRQWVRFWmZVTDRQTHBRNjMvbGlqbkxuSDk4ZzZFRnZ6cjlzSDBJSGxJ?=
 =?utf-8?B?Qk1TUEpUVXZidXR2Vm14VGR5cktkMG9iWHA1b2doSXZ4L0RjbzFSTHZJaHRO?=
 =?utf-8?B?aExpNTN4TnF6eEROREtKUURxZTVuRjMrN0t4SVRvRkl4Q2JLMUdwK1V5aXFP?=
 =?utf-8?B?dkVZWDJqWjBmWnFYMEZMZXZHbDBLQ2JoVzEyWjNZV3A2QUJKcFh4VFVlRGxW?=
 =?utf-8?B?M2Z3NEV2ejM5Z2thYldNemJ4U0hhTmJRM1pjTk5mMVJoRUFSQWoySmdNVU1G?=
 =?utf-8?B?bkM1eWE3bWt6VkZiT1ZUTXl5V0lFZTY4QTZ1ZnJWaW9rQUF0Rm4vN2tWN3FJ?=
 =?utf-8?B?UWFPUGI5OFNFYytYVmtNUkFEM1hJNmwzNmlDSnk3WlhSWWFBZEZ5TXVRcXBM?=
 =?utf-8?B?T3IwVm5qbFpsRi9UNTFpOUdGcDllVWkwaWNBSlRLckYwblJRSjZEdTliYWt5?=
 =?utf-8?B?RXp5NTJyelhyWm9UQ0s0a01mTnJGM2I5U1I0S2xib2F4bWkydkNtYVo2YXVl?=
 =?utf-8?B?dllzRUZwTWk2bTcwclRaNCtvc1hyVm4vdWZpVFlKbTJtL3ZEV0JxUGNMSFNQ?=
 =?utf-8?B?dWZ3WDlNNjBlS2dLVVYrYy85VGoyVVZUTFdERVRlT292VEUybDQ1cXduVFhG?=
 =?utf-8?B?WkpOUTRyRVBoQmpUNWZCRDd0UnlQR3pjRGtYOHo4Z21ScG1Oa0NzcldpMjZM?=
 =?utf-8?B?Mk81VjcxTHV1alpJNWx6S0xWaDlFQkpBK04vb2FNbVlERllxbTVYZDV6R1da?=
 =?utf-8?B?YkRBRW9UcE5OeUk1aTRKeERFS09OSlRuQzZXcjZsSWtpOWx5VVgrMTJRM244?=
 =?utf-8?B?eUFOWHFyZ1ZYbFdVcmVoSG5leFRrckNqb0cxaUdjWWp1TDlWSWFzKzB3WlVK?=
 =?utf-8?B?MTJRZ3lZbXVGKytnaEVuZ3RRaUI1a09tYlZYNHQ1QUVOMzhKdTE2VHI2V3VH?=
 =?utf-8?B?N21LSUplMGZNZHdtNHR2dmZZd3kvZk8wRElyTjJWeWdZVW1YQmFabjc5OW0y?=
 =?utf-8?B?dXlBQWo4NXRjRjB4WS9zc2pNVi9GeHBBdTJBT04wbVFnRW5OOS9NK2tIdk5G?=
 =?utf-8?B?UXdTZ3gyR2NHNTV5SjMxN2I1ZDZGZzFNQU96MFNHZmF5eWV4V1RnalZCZlhH?=
 =?utf-8?B?bFEyZCtkWG0rd2ZySFBVeE0reGc5WjVsSVlJbGRHNlJNRyt1TGJtUzM2d0Ey?=
 =?utf-8?B?eFhIUGlvUk5hL1VhRXF1d1NDNXlHTkVFUkExdExRTStSODF2dm8vMnM1WFBi?=
 =?utf-8?B?MGFSLzR5bzhJNDB0eXhBMWNUZ3dBZEdKZmlia2FQUWo0TXNMMjFWV1FEbVlu?=
 =?utf-8?B?Y2oyY1JUeFJSbEI2OXhZbFdqVldMVSthMngzRmhLaGZZT21BbHF0dk82a3dQ?=
 =?utf-8?B?TkVrZTVjaUZSRUtlNjdYSTdiRjg0alV6VXdBVUdvanZnZVlpK2JoQ0VyaUll?=
 =?utf-8?B?TnljZjJiRUVocy85aGw5d2QxSnMxSUpCU3R4eTN0bGVoVTRFeVk1WWlHQ1p6?=
 =?utf-8?B?dXNuSVFDa3hibElzOFppUVp3OVZPMWU5cW9MNUxxY1RwQ0RmYTlQZThDamZo?=
 =?utf-8?B?Q1F5MXJOeWVFWUJqemFETWJyc0FRdnB1Y3B2TnJqbjlDUlBUSG43WFY2WEk5?=
 =?utf-8?B?OW1WWVNNdDdiNVJFYi8zc0xaZnArZzY1akRyamFVNFovV2t0UmNzdVdxdC9N?=
 =?utf-8?B?cHNERmlZa21xQnYzbkgvR2lxYU1GZEx6UUJUQWhJRU9VY00veHRCaDFNK292?=
 =?utf-8?B?OURFTGwyMWNIcjhINHhseGw1VFltL256M0w4N2U5RGg2VVlVSnpNNzByZ1Ar?=
 =?utf-8?Q?WY1/phM9VF8gneijVnpJ5YvJIqYtEQAaeOmVP31qcf/S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B131514179C9E4A87E8E69594EED6E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ad19df-8f93-43ef-7994-08dabae39230
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 01:59:39.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkf3AZ8bnSIt+AbR8Zy9u9Fn9f8MC3WeLfOMSdPjLlOO0nnkT42iELd+AJAI7tALFO7Tz1ofk1IzTUKoAndjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMzAvMjAyMiA2OjUzIFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gVGhlc2UgcGF0
Y2hlcyBjbGVhbnVwIGFuZCBpbXByb3ZlIGxpYmF0YSBzdXBwb3J0IGZvciB0aGUgRlVBIGRldmlj
ZQ0KPiBmZWF0dXJlLiBQYXRjaCA2IGVuYWJsZXMgRlVBIHN1cHBvcnQgYnkgZGVmYXVsdCBmb3Ig
YW55IGRyaXZlIHRoYXQNCj4gcmVwb3J0cyBzdXBwb3J0aW5nIHRoZSBmZWF0dXJlIGFzIHdlbGwg
YXMgTkNRLg0KPiANCj4NCg0Kc3ViamVjdCBsaW5lIHdvdWxkIGJlIHJlYWxseSB1c2VmdWwgdG8g
Y2hlY2sgdGhlIHByZXZpb3VzDQpkaXNjdXNzaW9ucyAuLi4NCg0KLWNrDQoNCg0KDQoNCg==
