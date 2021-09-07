Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909EC433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 18:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA3161103
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 18:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbhIGShU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:37:20 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:23136
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230354AbhIGShT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Sep 2021 14:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsVTc+bV8oX4Ix1zmFNFgNPyeLSMKb4ezgrnFKwjdW19dDX55jjgJm1fB79VLh4yxZWI7MjE/KDurz/4GCoN9srhyOgb48P377rvs6Xv88v8C5tC9BuKCnq0yPhOhByIzQMDIxl6Atq5aVBl1zgKq+RKCcIBfbev8lGSOd6XMK5sFhupenCSkgJ1VM8LdkdKKSCd45M+ifoEtnMB+jsFc/EmRAikXz5xWVgzooQPeqTPtviGonH7baA5G2YlePO3zbuI0qt85U4Gd3xzvy/lB01sORfQ+yj8denyIW+8Ddk0l63fwVazYXY1Rqi57kLTUBYEVXVdn+BIUpkDSIWUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BhTDmxB1vxMFaCq6fGzR+Q/3uABorBgnRT4+iaGHT8g=;
 b=OHGxMX2rzwVk3dCBNkZhwe7aPqx3uSYKbDsF8sfXmdOHsG0yjDKLb4g21wXAi4BUoO+Lk8+twgQl1Vh7NFD/Mw9B3MUEqVFpKrZyOvvR6Se+PrjQDsPWXW6XObo55iLtuHYewC+4y3Z1JjhJuM3atHSyQ82RutuBjkXAa4kCPAw74ZlNodU+Tuq1M0ojH7o+0+YoT2vcfJta0MUj+zKCHxp5MBb1leHmT4qkjvTtHUt08iCpeqObHhMq8qhu/cS9K++PfbOsZSHc2cxMD32uSo84aBoxlf8J/CJ9/w/fzNM7HpoSeNDGh7z24Dn46CjbtM7bpPQH3HCfGLFLpjgS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhTDmxB1vxMFaCq6fGzR+Q/3uABorBgnRT4+iaGHT8g=;
 b=FciRoDYNqwVfkx0bvlN9ntLZ6vRlALZkUUvU268nMzYZQIzI3oqGHk+Jo3Kxq4ReRSMscokhqesB34UC/vDkrbKJPwAdnIIAuOsH50O4aEdUcT8atLX/rxe1mxwXTeGBfbbIY0oeW46ZFlbYT28PLritHtLxRSDSdYZmHWuHp5wHMp3odVxOF81/aRVYlsR/VXpCY9qvbqlvwpr/fugSVzriRkz+L+zhW8wn929QWZA6qqrTBHdgx4/jKErEslN5WMWod/LobMg9N9TQDCq6QrvoYPPA2V+nyMKbjk8QTvLAg+0MuoQexw9srhGdTypAzOx6j10C7+/AfMe1iVBMgw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0157.namprd12.prod.outlook.com (2603:10b6:301:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 18:36:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 18:36:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: move fs/block_dev.c to block/bdev.c
Thread-Topic: [PATCH 2/2] block: move fs/block_dev.c to block/bdev.c
Thread-Index: AQHXo/LnssXEgD88HEeuevm/lbxDKauY5owA
Date:   Tue, 7 Sep 2021 18:36:08 +0000
Message-ID: <2eda6fde-af0e-fc84-6a98-6aac79457b9b@nvidia.com>
References: <20210907141303.1371844-1-hch@lst.de>
 <20210907141303.1371844-3-hch@lst.de>
In-Reply-To: <20210907141303.1371844-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d6fe8ac-b3e0-440c-9cef-08d9722e5bed
x-ms-traffictypediagnostic: MWHPR1201MB0157:
x-microsoft-antispam-prvs: <MWHPR1201MB0157615FB14A8CE695161661A3D39@MWHPR1201MB0157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHULUEz69aXvDUx0cBFYoyj+c7O1SwZSqjM2H5WZN5Jx1qRVQqxJWq7sahak7IKFXdx6iQtN51aAGuLJE4MVfxeSTnOd3xHYlssC54bKmPwA7tmpK6rCM2z47KLmIsBqNMh3h1gk2shX+9BQsT2AnO6Cl98HkqyWAiCyZPYnZUjxfQGWdC1HoB5QaWMfaUwYVpLw3vNxRk9ewctgpr9iWcUBz3x/8tsyNgu/YpAXCcFtq+OK/UwK2iRN4afMxO9/OtY9OA9Z+DpoqQcpTN2RK5G877CoiQU0cm+2BhLxTnbKVRQ9S2BWDF6dKuX7b6Iu+vSmtqB0M9rRhnNxckvgI+OsgofyzNd/MYvriph7flqHkhRB5fdF/OhQUNCUWKWTAJ/EEFtPSxbwb/09bkjfZhKG+K9C2+v7+pNEpcbLk3B4VXti16H09qrXPqF1ELkmB9AGY1Cgzw2PsY5B/xT1Tiq37G8RAcjWvnWMnrmOJJltqu9u9PYnx5q75h/LpsUSOZlJ0bLB9eI6heBnWhuEbWdDqQoWxaYxANeNEmyJfEUbmlP7B6pijFL7JMLKOslzXQv8j8mD/qNjMWUmx3e4pcmIPqHPyR3UyI77+8a/0Cc1dqZPLjlMaaDm3abChl/jPbrr7H/iQdNVKAwnT0OF5W+CberDet7Ur3Cwca5elpb/dJlS+bkEtmgnNMo5GV28WlyLS40ot2Q2a2Qa8LQGGZQ+tebd3mUBoDDKohpCCkHgrbFMrKNGZzIQag8eD3j00HlPuJrn2Mx+PZUNRLOxfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(66446008)(64756008)(122000001)(31696002)(498600001)(558084003)(38100700002)(110136005)(91956017)(6506007)(31686004)(76116006)(86362001)(4326008)(66476007)(66556008)(36756003)(2616005)(66946007)(186003)(2906002)(8936002)(6512007)(8676002)(6486002)(71200400001)(83380400001)(38070700005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWd6OUwvdkU5TkcrWXJENHd5dEQyanJqbTI5dHdpcHBXZmphZzBnSzhEdlk2?=
 =?utf-8?B?RkF3S0Q1VXpXbmp1eGdpaGVLMjI0VXVrOEovNlUyUFZabWpDbGhXWWdpN3NQ?=
 =?utf-8?B?UmhVYXorZ2FOZUdqaEFrRmhFZWNUVHlEQ2lwVXJKNzREM0JleUROS3ZOc0hx?=
 =?utf-8?B?a1FJTTlVOHc1M1NEazVoRHFBb2cwSGdOV2lubGxOOFV3ZEZUbWh4OGh3Q2xI?=
 =?utf-8?B?SnFCT2ZKTkcxcEJDdXlVRk5FeUdkRGhFbjRId3JaY3pGVE1PcUpHNmJrUEZu?=
 =?utf-8?B?aHNYVjVkSDN5TVV0NlBTNGJDZDV2KzRWK2NTMWsyMDRLL2pEY1dOblBYemZQ?=
 =?utf-8?B?aXJ1OTdVaEZOTm9iZXdpbGhBN1dNaW82cUUwL3MvL2hycm9nSjRSOHZ2bTRl?=
 =?utf-8?B?ei90QWYwRUU4OFhyczRHOFBrUVVDOE53WnNuS091RnF0c1k5amRYNUV2aXJQ?=
 =?utf-8?B?OFBaQVR0dSs3ZnFaNzNqTGR1ZFlOTWw2ZlN2WDdSSXNla05NNmN5UEF5Rzdx?=
 =?utf-8?B?VTFJblpCeUJmSnJna3h4M1hPOUwzK051K0ZVclFmbk9aa0ROV3hFNE9wR2ty?=
 =?utf-8?B?eHh2ZURzTjF5MzZETGJjZFVnd2piNER1WFVMODQ0WnR1WTI5UURGZC9VdmtG?=
 =?utf-8?B?Ky9XbHo2Q1VIQXQ4bCs1V0ZIZzN1eGY1dG42Rm9qMjZBZitsMGxvUGs0SnhO?=
 =?utf-8?B?d3F1Njg2Z0tZb3kvZWtSSm5DaW5GeHlaV1FkQ2ZWck40OFV4aUh5TUFXVG9H?=
 =?utf-8?B?cVM5U1NvTTdhbEFoTVhZVXowVDEyRDFDL1BEMjAwZ2toVkVSbG41ZENNQWlJ?=
 =?utf-8?B?b2xPMnNmeHZyK2Zjamx3dHUxUVhaeFV4Z2R0L1FVNzVDL2hlNWI4MWdxaVBH?=
 =?utf-8?B?dGFlZVl3eWhkVU1yUWVSb1YzVkFMYzU5dkYydUpuN1JVWWl5dlkzSVAveDNI?=
 =?utf-8?B?NHlWb3lJTmhuTDNvQ2tiTTRUcHVvbG4zNUtVWFB4Szh1dVZTUCtUNDhEa0N0?=
 =?utf-8?B?NmlsVlhIMjZDN0lTRUozSzNmN3YxeVBpMlBYaU9KdkNrcUxZTmx5TkVLcmdL?=
 =?utf-8?B?N2IzbTRTMHo4ZzBEd2pBWWJlKzBvTG8vUHBOc25vM3lsZk5GR2RUQ1o0dkNN?=
 =?utf-8?B?cnd2RW5oTlI0ODA2UUlwL0Mzamd6ZWM3RjgwVWFXd1I3RUs3OEJ6bU84T0Ns?=
 =?utf-8?B?MWZLd1h0QzFVak1IVEgxR2JhSTN1VTd2Q1lieldzVTdrUENROUh1dHlRVGtP?=
 =?utf-8?B?ajhNQk1jVUlHZzhETjdhRTB6bW9XSTVJanptZ1R5M3ZnTzVGcis5RTZZbmVR?=
 =?utf-8?B?WHJ4ZWZlaWVzUnZpZEZadXZaSTJacDFhS1BHRnRsT2hDK24yQml5clhDclJH?=
 =?utf-8?B?TlQvcWc5WXp5aEFwY1c0Ky80RXBOQnJZQjRPK3JiTHMvTjAzY3JpT1V2Y2pR?=
 =?utf-8?B?WFRCaTdvMVhCeklzLzIrRFhxR3ZEVWxVNkxIOE5qNUNiNE9WcHRoNXovc3oy?=
 =?utf-8?B?T25LTzNIemhFZEc0ajFZcDhtZUpnaEFPbG1TNWZyTzRjVVkxRENuNFlrTXcx?=
 =?utf-8?B?bHpLbmRob3BtRXVvN0VScmVUY3lkdUVpdUhrc3IzREFoVHpqRlY1WEt2cFBC?=
 =?utf-8?B?YXlGUFA5aFV5MDRrRlAvWVhvY0FkTEJubHp0clpuQjNtNlgxZE9ZQ2RaNUI3?=
 =?utf-8?B?U0I1dUxpWC9kZVpqTlZVYWtOK2pPTEUxaEZQR0I4QWJXR28wc01QUFpxT2Vh?=
 =?utf-8?B?NVJreUJWdzZ6bGllRTl2a0dqTnZpc1htM0ZWYnBnNzV5KzJESm9MakFCV2x1?=
 =?utf-8?Q?2AXzc4NoHHfSdE7V1FqrorxErd6nmAEEoz0W0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4DAF27705E6B44AA916BCDE0EC52629@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6fe8ac-b3e0-440c-9cef-08d9722e5bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 18:36:08.4667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpX7IvEuGk8OAZUr4unkMchV2WS6ycaZtfSx30YdtdWDKQHqcHZOE9hUv+w4WE//t+fKVbTHWUzwhRaePDI4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0157
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS83LzIxIDc6MTMgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBNb3ZlIGl0IHRv
Z2V0aGVyIHdpdGggdGhlIHJlc3Qgb2YgdGhlIGJsb2NrIGxheWVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+DQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=
