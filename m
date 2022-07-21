Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2DC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGURCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGURB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 13:01:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B27641D3B
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 10:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGExB3V7QeLI62rDMMkTs0zlGa2OlnFkIpsc291SUY/Ma8/bJ/KNaE7pK8nIPQk22qTYVfBp2jW8HicRdPszKs60SliBX4uB4IB7A3TPb3cr8WhaO98zSZcK1uc7ebhqkd24Zk9N/1lrTOHspGBvY0WdfFkOngdRVMJt6mvb4n6AixETdwwMM+SKhWJ0CSHU5lcj/DydPEZjssm4kluv3we4bBgnpabicizWfWpGX/KbahGdcY4kQXTKlXn7/I+mHD7g7osiWbFHJ6d26jQaLSWaMi0lpPLTW8D/12qEZ4Q/VAI2P+3ZoY+N2NO65Hn6bFd/u9zPjoN2zKGVdgy5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsIP9vT6cq5M4JYGVuyvIyx1uX+b2jhT+LWfWfwJwl8=;
 b=aFz8pfv9oGjWAUSp7p0Teb+GMWtbplfnD+UqxmUGCiEO7iMEToLjnQ/q96ZWYUix5ppXcnAUXpxMoqC8W5kGrBoAaG+YqbpvzTPzhuhxnC85WTYnIvpekLydVsenGk3eujKLsdr8MzhxR8Zt9kvDlT+5jGQebUypVOisj7POrjq3HSnFzpwCiG6fyWbU9fDVX5y5j3TpIIKZG3nC9TsRwju21/H8vjEI9Bfs9sG4/JIYXLIqrso5tFlwfQVCBbLuQz9S0jgL3YR4sqQz9ciijMuH1QEIwzFO5byV5NE3I4w0hdlX6Uge48KOMhPg/54GhFRS3DiHSKUP/DOAV7mMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsIP9vT6cq5M4JYGVuyvIyx1uX+b2jhT+LWfWfwJwl8=;
 b=VwiGOLX0rUUK/kqVW0nSKA4BvMLAlsed/YugiQy95GDXQX2FTrrjNnOkNguKTeKFt93jX3o5VPE4rQFZEbbfSHlQ9VmILqbNlTpj9vVxvJ2mv2x0DJcfJDjJmr9N8Ycllm3fQUjHYI55sKqqU7CUJLeX1RoAVzClrPz4CVH2YW3Jo3ocBzCg+z2UTSZsxPmqsgSYF45iVKkd92dEBcSHg2YLgS8Au7vwJTnrXaACPdJbaXebSMt6kdqXj+//5oSRilnOPEc1bUWBOuCkpraZIuimMDhnM/cy+LeiZSASOiLNvC/VoWU4THP6WpXKcn4D2HLPgX+TVxZOTn6IrK6B0w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4602.namprd12.prod.outlook.com (2603:10b6:5:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 17:01:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 17:01:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove __blk_get_queue
Thread-Topic: [PATCH] block: remove __blk_get_queue
Thread-Index: AQHYnMv1dRVYG1yxekuczv63nlUYea2JDZGA
Date:   Thu, 21 Jul 2022 17:01:55 +0000
Message-ID: <002c9815-87cc-4ff3-be69-515106ab6ab3@nvidia.com>
References: <20220721063432.1714609-1-hch@lst.de>
In-Reply-To: <20220721063432.1714609-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a503a51-5dd1-4629-a34f-08da6b3ab795
x-ms-traffictypediagnostic: DM6PR12MB4602:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HV2SKrGpDftHeLuUsSMWlfPTHR1mJ9vZMV/5mBiJRVbp3Jc0n6L/2jgw0ZAYAUe9CRyq9zcrZABepJHsuWAitlQuXjc5wPioZi1uau0E1wvgEewe4D6TSxKTmi/vSWZH/JNFMHAsf0ArDPUGT7Exsck2aIB4YmEZivAPTwT6KR8G+CuLXV0V8oSCAb0sYAb6pW7OHM69TRgSjjbX9DoctFp4OdUZYFU7OItiIFjN+wwGdAQYhuxB7dJguVWObihqQspp5ofRZX9cs49Z21iaM2CufafQHH9OIiRPbfYItwDnV1TinUCfO0VJ8aY3qN+5Lm+Y3FXEIifr9zWzjdWdCXbncMRfunHceDy69OkMbHi1lxFbVX/vm+rQkDg4oXZZWVDFgkqEav6SNEtz+zGPNBBcXzrRjC8+JwhJFEVe6UVQ7spE7Wi8APp+vnyQc1/gqAd1X2bgC0VqqVcIjNm8+IqALYtxkP0Ap77caNCHvfJj3AhFEi23n8yjifz/xIG21NQfAG9/rkCR+fXpKbtahubbc9Lfin/99ScVDHWPcrNYKJyOPV+cPxICLVaym4Dc7LY0CO0VUNhOOYD5554QRsBVfVfqKb/pMp6QuBa9lARQP9hec6tyg64x2CS76XkYv03VKWpehNGUNz71hneLmtn+8k/GDH0LihKammm6bC98Ls7zdazsbPfUKGp2nwrxXLCdcC3zSA5/TokdZav3F5Jrl4t9iy0uPx4wTzmy8/308L7hMMWV2R3/B5vsp3R1Bts+f0EX1HlvtzdOTYT5/SuLmY+0VHLbw97sgwEMKbY7yOD4QT6BAYXRLjkOiWX6nw2yEYjRDdBsXj1J8faBLvwAdXdrRPu75b7LFkhGW5ItB1PzbWfJZqNGHKdqA82w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(8936002)(66446008)(36756003)(31696002)(31686004)(38070700005)(5660300002)(54906003)(6916009)(41300700001)(478600001)(2616005)(316002)(186003)(91956017)(76116006)(4326008)(6506007)(8676002)(38100700002)(71200400001)(6486002)(2906002)(122000001)(86362001)(6512007)(64756008)(53546011)(558084003)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0wwWXFxTlZZQlVHc0lROU4xMjFnL2JCVFl1WGdiNEMvY1lUMmFPWnphZ0Zs?=
 =?utf-8?B?akZ5K09xSnUyMnJ6cWRyWUZYR3dNekhVZlNhNk1rc1NGTkdka1pHSGx4QUs4?=
 =?utf-8?B?NXJsVWNKYlROdnhRWkI5WTBzOE92UjdMbTBSa2swZ05SY25GeDhIUVovZTI5?=
 =?utf-8?B?dUhENXN6L1VUQkdoQlROTmxqa2tlU1N5VWVYbWNpc0ZHU2NpRCtrRUcvdDln?=
 =?utf-8?B?VGxnajQ2Kyt5UndRalA0VXVvTTV6Zzc2ak1EVkF5SFFwalhTVFBWcHFOL1c5?=
 =?utf-8?B?dDczT2NzRWQxL0t6Z0V0TDJ3STRqTmNFcENXM3BJVXdrQ1FkQ0VJLzd5N01B?=
 =?utf-8?B?S3lBckl4a1Q5Y3VybTBGSG1JQmxLeXpxTkRjNXNGOHJ1L3lPYkw1cUlJRlFo?=
 =?utf-8?B?N0ltWGRtUEY2bDI1a3FneTlsSmgvNzVHeHVRM3pjNHA1UzM3ZHQ1elY0SS96?=
 =?utf-8?B?MkU2cjBFTjhxYXBCd3Vaak5LdHJPdTF6SUVNNWdwcll0MlpuVUVKSGd1NnpZ?=
 =?utf-8?B?MkhrQkd5cXpiQVFwVHhNeTcyd21wTm9NLzJ5ZmJUVXZOS1FBQ2xzejh1eDBQ?=
 =?utf-8?B?Yk51allMNUdDeHNsZ0Joa1ZOL3puNWs0RzlhdElLcXFWRHk4bzJ4M1hpdGY2?=
 =?utf-8?B?VE4wbTNSUndmL1pFZU1XZzRBWTI5QlpBYnNYUG5CUllqS09yWEJLbm95S0Jj?=
 =?utf-8?B?aFFLMFBlUEhXNExuR2plYTY1YlkrRTJOTXNYOWVtWklNaEs5bDgrUW9LWjVD?=
 =?utf-8?B?RUU0QVgzQW1jYzlrYmIyTHVqc0NGY2xaKys4YXoycEVLQzhhdmNmRXp3V1c5?=
 =?utf-8?B?WVRCTDFFNTNpeWFDVlliZDhvc0hqcnRTb0xxeUJ1bm9BempUUTQ0cVpERTli?=
 =?utf-8?B?aEFhWVc2RWVnNDZoNnNQSEd0Y0d3U0owT3FNTUQrelZzdnVKMVByZjBRZFg4?=
 =?utf-8?B?eUVpUmhTZm1ZRnJmbWllMlg1NlZraTM2QVRGSWxjY3NkSlNDUTA3bWtZUTNP?=
 =?utf-8?B?My9pMXNOT1lVaUZFTzhoRDBaWGFUbnh3elk2YXJ6MFJMRGVtNW9NRDQybUhB?=
 =?utf-8?B?NjQwaHp4czVMY3VrQ1k1V1hNQzYwUjFOUHZQcjgzUmdab3N5ZjNESHFtWEtK?=
 =?utf-8?B?bmF3R0tyem1HNFlaWkhDa0dVWmk3Y0J0R0YySGlmTDgrbE1MSUJBR1hDSmsr?=
 =?utf-8?B?bG1YUlJmNDVOaXBDVXdoajM2QVFaaGtjZ1ZQVnVDWDBqYXFJSzZDU3pIWlJO?=
 =?utf-8?B?c0RIR2F0U3hjTlEvSWh2d0EwWnk4YUdwR0M4UUFLelRsTElIREMxWC9ta0ph?=
 =?utf-8?B?OERWYTVyV1dCdmRPelRXdnJqV0M5Q2lnQ3dsQWpDa1NDeXR0SWhRSmVsQldu?=
 =?utf-8?B?T0lqd0pML3dpZVkvRWtvL3pTNVJCdUE4Z0N6ZFBGc25Gb3dCeDRzWnI1YnRu?=
 =?utf-8?B?VnhOVnUvazFOVlNZdkpsWDhkZDh2dTFpR3lESkwxMUU3SWM2TTRSdkdCMXhE?=
 =?utf-8?B?cGZFQXZLdlQ3YVlvczZkRFV0ZjJqZHNDcXgycXNkbDlQZmpHZ205UEpLcjhM?=
 =?utf-8?B?UDdhRlVnVGJ1cnliRlNyYmMxZGphekJObVhJMFFMTHRjZWFaZzBYellvZE1a?=
 =?utf-8?B?cUNFWkRpYnBDRU9IVTBhRFhsYVlKMjlxVlFuemJkeUdtY0dYaUl6ckNrb3FB?=
 =?utf-8?B?SUFiQVQ1dFkyWDdHZkhzcGVtUVl1VnpvS2VNSmtGQ1VSaDkwUVZXNHhPOFBB?=
 =?utf-8?B?TGQ5blE1Ty9qZUVSNGRyRFV6TUprMnZ1QkpMVmppQzNKVFVsMVpvSnB5SnVC?=
 =?utf-8?B?S0FkaVlZaTMzVFRjVDZRRnh3YjVkcThRSyt0cmJQdzNaeTBpaXp5aFJRejVr?=
 =?utf-8?B?SlNrUHV2cTM5QUlkVVV6Y09ZRE5IM0lqTU9jRDZxQ3RISzFJM0JuWlhVRWVB?=
 =?utf-8?B?b2JlZ1ZVODBMTGZET0x4U0RkeHZBT0EvZWsxTG1HZG1xeHpUNWFJTmV5eENs?=
 =?utf-8?B?VC9FNlVKcDVuR0tmT0toWFBVS1NxMy9EMnBmU1o4M0ZEamh4bUpmc2lTS3Jp?=
 =?utf-8?B?dXhLZlNJeURNQnFpYTNoT2ZWNnZKcDEzRk5UTXFqKzZ5aXlNcCtjbE9RU1R5?=
 =?utf-8?B?S05TMGVyZ2w2RVExMEpnbDNNNlhJVWJBT003aDR4cjBIZVVQL3FWempwbEpZ?=
 =?utf-8?Q?LIA25vdsVjiBG7D1e5CrVXaM8wBLVjKCJ2uOeCLaBjLx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22AB0DAFA2B67843A283FC75459BC201@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a503a51-5dd1-4629-a34f-08da6b3ab795
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 17:01:55.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtjF4upAvhUtsdmXnDejXniemrl8rmfKe8+Wf+bO20lwpDQl8lH+303qM7TMrJXnrc32eyxiMh0YcJFlX0LJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4602
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yMC8yMDIyIDExOjM0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gX19ibGtf
Z2V0X3F1ZXVlIGlzIG9ubHkgY2FsbGVkIGJ5IGJsa19nZXRfcXVldWUsIHNvIG1lcmdlIHRoZSB0
d28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gLS0tDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
