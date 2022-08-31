Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F5ECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 16:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHaQxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHaQxu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 12:53:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7577D31FE
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 09:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9G7X11+vyZl32VST2qKN1YzALRqGom7aQswoIbD2Ro66ABhSfwjK2kabwXvLAtr25D5bz8rkeuJJ5qI2VkNj+H6Zx/3j558QybP2sGIcKdsCNnOQPjsUMLWwo54TRB6Pnr1j6UygE49MhqfXxkKhAQsNFKzgPRFfFOYPUvoo0m0uk19JwfR3ypOwti/V6KZjzBTqNBnVUOfFU0cT+ZMQ05ELactheyLNcpNFraXOzM+V50MkWSk0L8UkgnWJm077loUD0BNsN/n4t47elIGXogfTLz4ly2SJ8v7Mq6Yy88aGZGG/yFcYezO+hhyprUE1Uzd6pRVfjOT97r9Gm7gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKjcMIgB4I/QGo7scLwm9KexUGXun4+EAcar9igu4CU=;
 b=fFyKY3sn+xdYCNK3USvdWOX7DSRBHQw3pD72/WVDBwYvR/ATpjmtXdiwHOT3+CfiGoTf7z7RGhAbEt09IgJqH2TUrX5QuUl+t1xhYU6+F7bL0QQxV3zCtwwQjlcYO3AZcTz5moq1CcQG/Jxqto78fX8SeXkv3IjcHQ+yx/nO6mGNg3HE6qxalZH0XjKDjvBiWBu2GH/KbOLLF4ZZ8oN5pNi3Ng7vVHwQlZZ9yLHuqtG4budYUd/xgaeeWd8/w7GnyhO/CbZ8yeM+KuJhqLgb7YuHqmowP3NwyTAPwnkSkvF6AP6vJeAr7jm6nH+gnoawjnv6zRWWPEMyX0Slq/hfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKjcMIgB4I/QGo7scLwm9KexUGXun4+EAcar9igu4CU=;
 b=dLoN9jAX38PyhAAhEM0ZtqixzR+h+9gD7efil8WabhQHESdWa5iJtSislk3oRCBnJC7T9htk6PLqkT1kBse+vhk9Irdp5fjLXM6xQGKHD9i54Tmwj/oAU3lfCuJEzYteuq9R8BmfNlABGLNOIQBfUtSlQRgpCUenA/zpP3kyDbshRTxMdbBTNLcN53PhWZOAmEsyoC69gAijEhE8wTdCTrh6Hoq7S6zlg6tPqMMBXXgPotVKKO3ywXgFAKzngiS6rMkhVut5J6v174r359l4Kw0reg7GfSexZU/FG99YRGZ0eoQ+lmlI4Ecl6c37G4mLH0kKmbOzVrEo3l8j4b1epA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 16:53:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 16:53:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Fix double word in comments
Thread-Topic: [PATCH] block: Fix double word in comments
Thread-Index: AQHYvVGxi9E3afihhUq3N9uViKCXZq3JOdGA
Date:   Wed, 31 Aug 2022 16:53:43 +0000
Message-ID: <24fda989-dfc3-bc1f-19ca-91062ea9b70f@nvidia.com>
References: <20220831155216.2552-1-dengshaomin@cdjrlc.com>
In-Reply-To: <20220831155216.2552-1-dengshaomin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20c36749-9d40-422e-ffb5-08da8b715d44
x-ms-traffictypediagnostic: CH2PR12MB4311:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdOYI6RKYe54I1qmrcXJp+fAnSds/Tjz+6WkGNmknyriwq0TnERX7hsqmPqNQzcgpIfye9TSlt9AgYfmkrzbHg/MtJrzfNboOVLftgAiYc5bF0NbYe8xXvPjznDMKNV7lXAFRf+subtU9yk5XR5lvXN028dVHG3LiM2xwjmi9fhah4AC0wmvUIouFs5+71FDvIPKIf8Af9rwzW4ffzmGlMA8vcdcRwRE7iP27zAwWJ/vGJO2zHCJwyXKQmtLMz3QzgkjPbpjzk179ggyPqHsHMLyITpqyIqmU1EuOIEjo1Cy8fMlWbv83ZZSd5QwhRRlzONNeYmuuvY9uEgnCWoV6C9NR9IkkcKT98c4ilcG4lQzKxQsaw3Xg3p7tnsbuItAqpghB3414Wvqh8MmE0jgm4IQkpHv1tOXFWEohEqBfO4NR7sk6MYTkKJ3f85trf7+x3W0p0EkmT3QyU1mqBi+CsxV+PPqyH7/iBl2Kl9p1YDnLctPcGOJ//8jJwOTfTBYciV5XviFwty7h2EflDNYpNUA0k8RVViV3+OpJ6e/wiqNW8V2jBxafWdfHvwXN5rzoVV352KH2zQYSp+LM0ExfD0PuRPhhYMqOhJmvU9kflMYe5XlOhSAK7bcIsmz+W4kKBZE7mxCbHgUQU3FQfaIC8Ypt1poUfBzVeyjrdD3oiOlfoH1xSUXGp1kSmtiPgt/J2daBL+hGahNz+SxTegDXtJ8XIoCR8+kdFhpS9POwVJbYN7IB2xxSIsa1f2HKbjZOkrUmj+W52cdFhYNvplReiVYUOyuOmbepZSPBuIVEhAAAt+oIp2yG1YJq5cpWn12wU5I83jUxp/TztDc78xCHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(6506007)(66446008)(558084003)(53546011)(122000001)(76116006)(91956017)(38070700005)(66476007)(66556008)(64756008)(8676002)(316002)(8936002)(6512007)(71200400001)(86362001)(110136005)(478600001)(6486002)(38100700002)(31696002)(41300700001)(186003)(2906002)(66946007)(2616005)(36756003)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGdiSFNobUdnbDBoM3FEbkx4NnBQdDB5U2FEWTZDc1RpOFdvdFFYREhqU2tQ?=
 =?utf-8?B?TFJiMWEyaW1MT29Gc3d5dURGL1I0L1FQZmJoY0VOK2t0dVV2L0xublFzM0RZ?=
 =?utf-8?B?Q1JMazFJamV0MW5VZlNwclE0dWxPaVdhTTNGNmNnTzEzUittMHBsRXRSYnZM?=
 =?utf-8?B?V1lWRVpkNW1DWi9qQTh4RzVsMzlDaXc3WDkvMzRxaWQrdXNpY3B5TWt2OUQz?=
 =?utf-8?B?cXJJakF2MlIwaFAzQ1JjUCtsRU00bnpPbFJPTGszY2NuZjVvTHluenVnbWpx?=
 =?utf-8?B?cW93YjVtR09uM3l2VUlTVzl2UFZMaHR0YXhaSGkyZ0t5TWxYZkZWZEVUdnRw?=
 =?utf-8?B?YVZZWWlqeGdnNmltTElZOWlINTFrdkZNUk1qY2xtWk5kNEVPY014T2xXZDcx?=
 =?utf-8?B?SWN3UWY0QmZuM3Jnd2FOYWhadmRGZlVibGw5SlRBRHMxcHhUY0lHR3d5NWF1?=
 =?utf-8?B?OXlBa0xDUFVCcHJKU0s4VUEyazZmMElPZHlEUXliK3FMTENYSFg0NjRtTHZk?=
 =?utf-8?B?MFhnMWZOL2d2bUZLYTVIMEZMc2xoNHFpRHExeDMzcmo1d09jaVU1dE9jUGtz?=
 =?utf-8?B?bFdpZVF6TkIxYTdRWjNHaFdjbjJWR2d4U1pLeTE5dEVtVkpmYzNYVFdtaU45?=
 =?utf-8?B?eUJqTnVBOU5xb3J5Sm1ZVGRCK09YMXBLczdPdlZzMkk1eTdYRnFwTWhHUW9o?=
 =?utf-8?B?YWZ2d1EwaEFReHN4WWZHeVRzMTJIL3haWUJPN1RGbkdMdmxVeks4ZnhRWkdx?=
 =?utf-8?B?TDl0TVpPclhsMmcwSmlKWkhsMWtxRnRTQXFld1lEemRoSFV1ZWRjc1AxUlN6?=
 =?utf-8?B?Ky8yMkRPZXovenpjNG5UY0ltU3krNUNjWDFxMHQ5YjYyVlQ1andhaDVIU0hX?=
 =?utf-8?B?R01USXNONUdIL0IxS3pDTVZrbmd3V0xweU00MUhWTW5VV3BXZDJNUzdCVzAy?=
 =?utf-8?B?b1B6L1pDR0p5MXF1dThDMExWQStVL1c2Qi9SMmZ6bGxzaEdKYTdhdDZtR0sx?=
 =?utf-8?B?SlVuQStLYndiUDN1eG5tUkdvMEpyMlNMa2NrTmFjdGloMWMzczM3YVo5Wlh2?=
 =?utf-8?B?MnJoVW9WaFVDQjZycG83Ti9heXNHMGZaaUl3d1dYUjI3MnhwYzloYTZYeU1t?=
 =?utf-8?B?UDR2b0FmNEV6blJaZGduS1RzYkxZOTBiWmhiUHNOdGxxL2pnL09PL3lMU0Fa?=
 =?utf-8?B?ZENuOHVLQ0hTVzV5Z3lFT2FXTDVKYmt5VVZQbGpNYXczbmJkWXIzNFFxNWx3?=
 =?utf-8?B?U2xhdVZJbFlKbHp5cFovVFZsNVAvbGVNYi9GNG9OamMvcUtQdUR1cG1iUTVZ?=
 =?utf-8?B?QVM1U29GQ210a0pidzAzS1lNdTJ4ZURrNHVKeW83eXNORXBXdjF2MW9wOGFa?=
 =?utf-8?B?YWNCK28ydkRJVTlQb0dRUFovMWhxcVAvRXVrbkxpY3BpY2xFV0JITzhCdzNQ?=
 =?utf-8?B?c2NvcVVVcGJsYTlOWVhVaTJoakhkRzJHSUNKUEszTWVvSWp4NldVbFRHVU1R?=
 =?utf-8?B?RE1jUUtDMG0yVTFPOHphS1pPWE5jaDA1eU9YemJ1Z3NwdHBhbisxN1Y3YjJH?=
 =?utf-8?B?R0JVSUhTTHF3bkNMaHZMMFhTendIU3c1MU9abDczZHQyanFZRXNzSU1zV2lV?=
 =?utf-8?B?TjdPSUluM2lmSWJPZ3UzbVUzK0VFRTBzeithQTJJQUQrbno3TjhDRWVJNXJX?=
 =?utf-8?B?YzBWdVlBYVB4RzgxNWhyYmt1ODMvTUJ0dmc0YUFwanRXUVoxa2ZYMXJCQTZO?=
 =?utf-8?B?TWx3SkZtZ2lSVU9TR0FGS05qak5DbmZWY0tmNVkzY29xUHY2Y1hSTFFRcEdZ?=
 =?utf-8?B?aFl3aHNieVc1d1dlbEE1Z0Q3NWlMYXNmaWdzNXEzRkx1dmJmaXE4ekFER2xr?=
 =?utf-8?B?eTJnSkVxMXRXdWFFTHRRT0t4QW5BOVM5VGVJTU0yVUxrV2poUkJMOVZPS0Vh?=
 =?utf-8?B?ZXI2aElrd0J3R3hpZkNzeSt6YklabDcwWDljQXAxYW1LbFhiaFRjTHFJbytH?=
 =?utf-8?B?OG5UVU5ZaHc2NVJxRU5kNVYzV0RpWk1YcDNNZWxEZVNtU0dqbDZ0aXRCcFJ3?=
 =?utf-8?B?OFhRYkdNQTZGSUlhaGg1c093ZFEyV204amd3b0wvbGc4OUUrTmRyODIvOFJo?=
 =?utf-8?B?Y1psNlR0bHk0aXRpVzZsekpjWTRjY0YrYTVIblNGQUR2UWp2Sm9vUkJSSnh4?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26E21EA2CA0DFF4E9BAC722E0B8E9BC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c36749-9d40-422e-ffb5-08da8b715d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 16:53:43.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vdq/kEe9TpFK5A+sO/P7TH5iaSrqeHtaYE+D2HDC8llTV2Z1Ilbay05evEY5uGY0Y8t9jHXLJYbWoh/FgZkjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMS8yMiAwODo1MiwgU2hhb21pbiBEZW5nIHdyb3RlOg0KPiBGaXggdGhlIGRvdWJsZSB3
b3JkICJpcyBpcyIgaW4gY29tbWVudHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFvbWluIERl
bmcgPGRlbmdzaGFvbWluQGNkanJsYy5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
