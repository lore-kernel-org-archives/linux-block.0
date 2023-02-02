Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD566C05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 17:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjBBRlQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBRlP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 12:41:15 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608022A22
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 09:41:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv0ipsQNryLSmsEslBX5Fy15RPI2k7WSqc36lZKUKI6e+nf3u6UYI1FdjrStmIzSOEbgeh6TGWqHc+CWYfdORuEll3WTdFMay+t/VAC5lV18HhJ6BJoDgEWWHUCmp3Vin+gg8JJbLdu4eWI6Rj+wmTkgGz7Z0MvcAQ11QXgMRnYY1XUKRGY4zvHTpLJ7GEIGwWvASyZJwT3+kFmcm245sOF5o/t2vMTd8h5Ua8x7IjVxhe9hOchgHJkt2WUlYLO4xcFFjdghGbI+b+rMWRie/+7HCr+xivwu59SFFzOzijm80r+nShUwVuK+AtxmBsYd7nXsxSG+0uR+q7eM9OWgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTR+4vFc9TjeYSo7Q/JFP0n9zMwsekBK1yJ6P4oqhks=;
 b=QjKzw8zJid6mfMhXip/i094530QO7HdguYM9MBw9F2eWKbasykmPmv8sPiMkus8peMCHdv3bhMUpp2cS7OhjZPQ6p8kSn/MUv3GfC+DkMeWMNEqGRPHN1oyV0Ofowkw/GwzH5JMfgzYyWWiQ36dK6p4RAn0fLVkSKObWaqyVlt022RabAWPq2svxkIAwSo6xLYgbunTDEh5nvsvyxMiBIPPlsiBr02nATH1KjvmU4iR6nojCCYn70EaBY/1vmBDwqtQaC831xwy7vIqzHXl1Au+/Klmza65ankeP872m/r9Icrlaw+jZwW5F22V2y7bXd+9r64HSNQjKO10V+aAftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTR+4vFc9TjeYSo7Q/JFP0n9zMwsekBK1yJ6P4oqhks=;
 b=Bera+ImNZTHr/M1ARzynUYzeCNBQMw0mCKQHcIYdnnS/Y0u9pITVWG94cLvoQ4Ga8IYLuh7o3QUxXZXY9UpmXc22/lYXYGTdQrampjWSTBTdmwUbxZiLpQQMxo3oE6GbxUp6QH9nlqYNQJtm2F2fNLVM0yCSzdxfCK4mjOO/iMMf48sTWvtXHHlntuoaY+9T5LzbwHSuitFM/QEafERDAeArHUxJ1iZDiSqw83Z7nrL6GI6XCxUyxLiw5JNT4IqehdIKOTnvSP9fzbO2fv9Ri5vgfKeIRg3l8/oYKXK5vHT9lvllarSKSn3CsK67U+wdOvTBIdi4qsG/V18aaUp11A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 17:41:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 17:41:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Thread-Topic: [PATCH] null_blk: Support configuring the maximum segment size
Thread-Index: AQHZMrPK2gDTbmCbwU2CQVjx2fYr/K65FJaAgAACFoCAAt8BAA==
Date:   Thu, 2 Feb 2023 17:41:12 +0000
Message-ID: <abf5b18b-6891-d9b6-9c34-b23050b6f107@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
 <8bd89413-bdef-7fe0-9e19-4419e9280f4e@nvidia.com>
 <5f5db20c-e66c-5295-0bbe-d71ad730dce2@acm.org>
In-Reply-To: <5f5db20c-e66c-5295-0bbe-d71ad730dce2@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB7961:EE_
x-ms-office365-filtering-correlation-id: ec1857bd-7a99-4523-77c8-08db0544ad79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owFdcpD5ss7k7RBjkf/uzTHrHIJzxjNoFEpaAGRuJT5JgUKHv0c71kN0Ha0chNuSzL4SDC2ENSqLrnVAmjw/PJ0bRxOFE00ft8OMXOhpSqJRotb4z/EEs/naL2XUVggM5QPCF749yQrr+91pS3IcoeaxaHrC8rV4/vkuQImqhQmlykIBjxOsVMyPS+O4TukHRO+kA/YTIPVmjdgS6l/fJMKa2+SzY3LhaUGwDxyIdH+KNMzqfDbFD0PtYUaZ7Kf8jSlNHXLcxKkANIKEzJaXCT6hXb52Z9/dDMPbWta31vGTYE6mMBfVZppq0HKL7G1MQgmG8/vuFTcgaTI52A0srifRw/TR2Vk9MW1AOwlHkgp674NwvpIagKH8EERX0zZjtKBmKdH4Qsv+zfdZ502F513mRQS/pHy9Gdu+T3ItRqt4lTaeJ5v7kCUQtXOhNyY1y8AxpWAsrDdA0o/DXOm0YC+u5iTDWqUOWTbONY396xKQ9TXtp/CNxnVzhO0bBytINlTFLWHoHBIWyntoGuUGnoKySCkSYgBytFNwFId4yzCK3P4t1DTIv/7qqHNr/20DPGK2eDYs1ck8/eATA1oyR8ES3Nt2jQy4EwXpii/ku5WdGC5bH1ccyLSBphqEkYM1zG/X9I4gOORBVh+P9lLAklSDNSGu7qHY3A8xCWx6LRDt7JXKOUBLphqBH9oXUtMAddN5+5s/fH2B6lw+aGMjXfqS2dvJT7MMJ1nzH0yrD1WCVG8XmPPJ7YIgZzKbWfKGYv9rmEbcZ9VL/cuUhawAB9oWD21U1orm19NwnOpTCR2xSRNkCKXO6ILpdnO8l73LufiwnD2HdzQ5gTkHtzJ2hSIt6Sb/cAv5H9e4OGqIC5ONyrJCFrROWpfnMl75bagelMN3xIsptkO5LKSachVQ2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(31696002)(36756003)(38070700005)(86362001)(38100700002)(122000001)(66946007)(6916009)(66476007)(91956017)(8676002)(76116006)(6486002)(71200400001)(66446008)(66556008)(64756008)(54906003)(4326008)(316002)(8936002)(41300700001)(5660300002)(4744005)(478600001)(2906002)(186003)(6506007)(6512007)(966005)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0dZbVVuUkhwSGMzTmRLYjZFd3B0cXdPS3IwM1drRktzM1BtUGZ1MjZtODRh?=
 =?utf-8?B?UlRxSWxhU1Z5eEcwdjNVOTZkVUh3SURxdytHbGY4M1F5RXpyT3QveFR2djIz?=
 =?utf-8?B?Z1BzT2lpMEhDOWRRYVVGWExjV1NoMGlOMmM1UnJwNzA0SU9RenloTlJkL1Rl?=
 =?utf-8?B?OXo2MXQweHhsS3dDRmNTMnlGbjVrbzR0dDRpbStvNFhCWDRXUmpVK1dVcHEr?=
 =?utf-8?B?cDgwQ3YzTVRKUnlpRkJwTmJMdUI0TzRvNzNYVUN0ODlSWVJlK2JNSldJeGFV?=
 =?utf-8?B?d2J5YjZ5SU41TW5wd3VWN3orOEdhR1l4b2s1SFNtektFWGEyVUlPK2MyVmxr?=
 =?utf-8?B?aEtYdHdKT1oxWE9EamRPQ0NlVkxzMTl1YnpBTng2UnBVUXJtd1JmU0NxYWZU?=
 =?utf-8?B?aDNIVlB4SFR0YzVOc1Bnb2FlZjdMZ0Nsa1dkcnRSRXo0ZDliVnZmZjluM2Fr?=
 =?utf-8?B?NEp2TVMvblZpQnRSRUZNRVBzeEpSKy8zdE5yYmozN203b1hSUnlhU3BCNFdZ?=
 =?utf-8?B?c21MNlI1VjF4SVZ5b2VIUkF2clJSeUp5RU5aQmh0NlFJUW5VdFVLVitqNlJr?=
 =?utf-8?B?TGdITFlLRGFQRXJweHd4L3ZvWldXWDVBUFdna0prMGY3SXRLZGtnZzRHRzRM?=
 =?utf-8?B?V3pVMWswR3FEOWt1SWRaLzlmaTh5Ty9hQnBXZGNEeEVabS9OaUgrclppMi9F?=
 =?utf-8?B?WmhMWU84OE5UZzhtZVhLUHFqYVBkeGhTWURDUGlpSW4wbzJQN2lqUFI3TUpz?=
 =?utf-8?B?c1hFSjR5TUJ3N0hyc1RodUtpRk5kbjY0S25WeVpnU2xYbjU4ZndDVlFNdXJL?=
 =?utf-8?B?U3AwZTRFNmVsVkQycFRRak4xSXhkZGQ0YmhRQ05XR3NjU29CUUdQd0FqMGhu?=
 =?utf-8?B?TElZMGxJaGhDQTRpenZPS3BDWG5EZ0JjdmkwT2NoTldDYnRNemVJT0V5eHVE?=
 =?utf-8?B?NUFMVGF0cE9VS1BvNEM5QlNFZzg5TzQ0dE1BQnEvS3NrOVpJZzFhUXpNQU9L?=
 =?utf-8?B?QWZlTzZCeXpQeU9jUUsrSUhzZXJsQ2NrRmIxdFk2TkhESkozVVAvRGE0ajhh?=
 =?utf-8?B?NnpyeUdDNE45Rm90cHNFOXBoMEZNUU53bmdOSVNHcGFOaVpvSURLK25yc28w?=
 =?utf-8?B?Wkk1MVVCcVZuY05udFQwQ2VQYUhnVVNNOTlIYlNLamMvbVBvdkJTK3gzRXNo?=
 =?utf-8?B?ODFFaWZoYXdFK09iUFFySnVuZkZrdkw4bFprY01zMTVMYUlXUkV2dnRJRG9u?=
 =?utf-8?B?dk5NT3h0REpOK1N6Q2d1Mm5HdUJpeWs0VnY2bmpZZjdvUjlZNlVKd3E3MDcy?=
 =?utf-8?B?WjhkWDc4S1F0SVBtNjhoRDRSMk8vL3htRWptSENtSzNmcWxmSC8zdVZSWHBr?=
 =?utf-8?B?MFR1dDZrdDJsS1NEZDVENmJHdWNzNWVVdG9nWWNhR1ZEdmZ6djZVSFM4eVBo?=
 =?utf-8?B?YzZoMjNra1JQcUZqSkhjV2I4Y0VNNjJTZjJKUzBVMVFQL0lhc0ZpTHI1WTFo?=
 =?utf-8?B?VmZNditMcWVlV08vRHRFY05ZV3V5Zk1FbEo5ZnhhMHYwMHdpZnpaY3k0Tmlj?=
 =?utf-8?B?V2taNTdQcFBBYnl5T3JqS2hCOFJoUjZqdy94N1ZqUGdJTVkyM05lbGlEUWth?=
 =?utf-8?B?eXJ5WXpwVDc5d1JZa3FUdEh0RjZmVlJkWG45Tnh2YlFVMGNGVlkyN0lKSlYz?=
 =?utf-8?B?dUpERUdoMzJMU0hjMWlEd3BIQlQ2N2hJZDJlcEhublVXb20wa043QWo1UlRq?=
 =?utf-8?B?UG85a21lWEQwNVRKZ0J6SC84QnUwMDRuK1ZkVzR2M1hrL2ZKSlRlbWVTcGg5?=
 =?utf-8?B?SEZmNDRvcTAwMTN4aXU4cG5SbWdrdUhBaW1LM2ROZGJtbFBQalNQclVValpv?=
 =?utf-8?B?VWpPclNCbktrcVgvdFZVU3ZqQ2UrQUgxeUVuamdPQXJ1c2h1VHdtclUzSVhl?=
 =?utf-8?B?YXVFWE5jcmR3RXZQc2tMM1dRamtKU1Z2bWs5YjdvYTlCUDRmRzc4SndqTnRq?=
 =?utf-8?B?dFcyM0o3SkMyeUgzOUpoTHV1NDB6N3lMbEdLbXkvSFRGNHluZFdKWU5JUUxY?=
 =?utf-8?B?WVI0UHNWb2lwRWlTakZRVlVncjRpUnArSUhjd1crbGtBZ2ZMWC9EYkU1RjZP?=
 =?utf-8?B?ZHBOM3VsQWE3amlPKzJPWmRlZDJLalVBckMyVFZzcGNoR3M4ZmZKSk9tMzVh?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BEB8A4DEFD2664982A53AF2A02E5A9E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1857bd-7a99-4523-77c8-08db0544ad79
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 17:41:12.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAGbhAx17NsUcj3NNRGI+XTCb3q4sklCkw/RgienV4mNj/w4wfoURa50lKlVpqpxTN5IldwbBl/4ll9pZjblfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IEhpIENoYWl0YW55YSwNCj4gDQo+IFRoaXMgcGF0Y2ggaGFzIGJlZW4gcmVzZW50IGFzIHBh
dGNoIDcvNyBvZiB0aGUgZm9sbG93aW5nIHNlcmllczogIltQQVRDSCANCj4gdjQgMC83XSBBZGQg
c3VwcG9ydCBmb3IgbGltaXRzIGJlbG93IHRoZSBwYWdlIHNpemUiIA0KPiAoaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyMzAxMzAyMTI2NTYuODc2MzExLTEtYnZhbmFzc2No
ZUBhY20ub3JnL1QvI3QpLiANCj4gDQoNCkkgc2VlLg0KDQo+IA0KPiBibGt0ZXN0cyBmb3IgdGhh
dCBwYXRjaCBzZXJpZXMgYXJlIGF2YWlsYWJsZSBoZXJlOiANCj4gaHR0cHM6Ly9naXRodWIuY29t
L2J2YW5hc3NjaGUvYmxrdGVzdHMvY29tbWl0cy9tYXN0ZXIuIERvIHlvdSBwcmVmZXIgDQo+IHRo
YXQgSSBzZW5kIGEgcHVsbCByZXF1ZXN0IGZvciB0aGVzZSBibGt0ZXN0cyBub3cgb3IgZG8geW91
IHBlcmhhcHMgDQo+IHByZWZlciB0aGF0IEkgd2FpdCB1bnRpbCB0aGUga2VybmVsIHBhdGNoIHNl
cmllcyBoYXMgYmVlbiBtZXJnZWQ/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0KDQpMZXQn
cyB3YWl0IHRpbGwgaXQgaXMgbWVyZ2VkLg0KDQotY2sNCg0K
