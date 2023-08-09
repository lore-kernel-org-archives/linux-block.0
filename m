Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F8C001DB
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 02:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjHICHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHICHN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 22:07:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2571BCD
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 19:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMmZih5T+5A95aIglMfErk/jfaSWoC5FwFs7YLE4rLoO6Ymi3VoEkcTtAKthGpqocscsTZIT0b503JPZw3DbgbX9TWBNz4vIjN+EWpDduMHV+LoLlcPdTJ9mMI/nu4UJqpEP+2ilOb2q4voimrzEtxxIxq/I05adJJfXlaFTcpzzUtreeXif1P9CtOZuftRQQAM21tG+SzQThoGGwvaKYz3DvThB0+9JFiW15cdenHuaO2tc71V4XcG5UaomnMiqjOgYpYO09HttINIyWIIyFt/VkvKtFgfMDqLJWk7DnZQl5KUpRjbTZeT4Iz258zeGpzJQBs7xaKMrl2JhBhgYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96V8eZw8f5WMTKkcuGKDEErEsyNPIx6pIzAsu2V6OeY=;
 b=l56oToC8In/zW4Nm3BhYKgUVztm6W15XaUiVjR47jqkMIzg6GeRw/EIhyjHEj+C2lfPj0adQ/vLY/PU4Q23EEGu51LZWIHPRpXwgHndUN0WTHlMRGhpw+3HDgSemzxDWV5mwuegTWCOY5PXGiyDzeA/8lgj4IuDvK9Yuao0ZSjh2RzgZqVI//UUD3I1vqLXqsibEiEY8W5isxvMllDffbRnhsizOEbpQ+N5BVs2AtYtGzM6frnvlcRXYmRdggfo4VznsznfIrLB+XGtd6Mjv9RCtNEwbyYFNKEwlvUR1QZKvq+VEBtuh3rXqS1KhNYBX4NR6ikwsO8vXAyisssCL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96V8eZw8f5WMTKkcuGKDEErEsyNPIx6pIzAsu2V6OeY=;
 b=kdOFBzS9iXeHBcz3oVh6cW5gx4YfdzY4pVDRSdzqziaHWkx7ZrVoJrWLsB1FLzN7UTTkfFp6VDzFUhWDrH7lwmylYiHKEbmCyO1U2qfRTsoFjAhcJ1iPdhBdqVOtdYUs9HjLyr8WFcHYK44wE4fxoVooXOOCT61+P96Lq1IyF4QM+oKxn8M79S4drpVSaS03QYVGzZ/pmq22yQ4c/XCoMcLU0Mku0EGmljazqsamJSFFKJv3GvsXRNNY/8NC/TM3tE+hkRilvH/eBK9h4sbwKalINrE/VTvPQFCJCRUIlb0kQs33quk/6kl1ZYu1XCx7/1xi/64pte8quO9xETIpxA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:07:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:07:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition
 code
Thread-Topic: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition
 code
Thread-Index: AQHZyiHR/l2NUeB9gUWGx+bnvYwgYa/hOCUA
Date:   Wed, 9 Aug 2023 02:07:10 +0000
Message-ID: <723ae935-2374-fcc6-5a27-36cff41e163b@nvidia.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-4-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-4-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: c3c9cfb0-cd0b-4762-5826-08db987d5771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6EPPa6f74U0BZxo/Uk7rVGLuph8Mv7lUguUFj0F7HJw7xUTVKwDfXqES90aVQUdjNLOmNTsuQ7TkEwQym3GxQ4+elYDx9tOph3S+LyWmbzNThu+0LNr8jh/m4IhCjptQmac713mDAe/KkIg0NTYpjLcBCPXkyJoRf/9jqyAh49CI4drV6+fJPBH44QuSYtld4ATn5qUEsG+AR4rPsKWH4ofBiHrWo/cMuZUfXnO60Y221yjfQUGQxdHuzRjWV67Gq8pSPajeXIhLvcyW8rfj84B8ilJ3i5QMkeU9MqLB5cbHuhG6rmGS4AKYr7gfvHTPGmdWiwtqI6LvTCFOkpp2MEj+bQKt29mt1BM61o6aT5huNvroiihOeFy+arI30iCN3QfffBrevv8/3w9RnjCvxtR8r5SsTssOYbnZx8JVmzDWP1INrgwc+UMMaFWGj+jgYy8GTwKgcSxuqeDxuUTcM2ProLAXmazZnu2Ey17w7BriObjFIqh0rFAShx5p8zOCB3uYTy1K1jfSp6win+5uEpJPSe0fAmVBWzkHrgofxUl5TcQm7t0wunCPvm9WZ9y/MsqtaeNJjTw6zTzWTN36gKeWz6YwM+EiKEdJCtPl8yrLXO9IF/q2AuQDCnPyWWBsWgUg7LEKXPGGMQN4HnK6aneW9CDAWVk9i/rFhz5p939e87eusSTHuqNujdMfHYFPF4ILwEE2Dgwyb7CE6h1Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(1800799006)(186006)(451199021)(8936002)(53546011)(26005)(6506007)(8676002)(38070700005)(5660300002)(66446008)(64756008)(66476007)(66556008)(122000001)(66946007)(478600001)(38100700002)(36756003)(110136005)(91956017)(76116006)(6486002)(6512007)(316002)(41300700001)(71200400001)(2616005)(4744005)(31696002)(83380400001)(31686004)(86362001)(2906002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWVDSnpjak5wN1ZVMUdiOEFyb1VDSk1FNFU2eUk0WWtFK3BxUHNDQzBqY3hD?=
 =?utf-8?B?YklpdUU1Z25vV09vYUs5R3FndDBYN3FXR0w3b1M1OUhtTDhLSVkrcFRRbWxB?=
 =?utf-8?B?SzQzbXFZTEVyRUMrSk0yZEJlZ1B1NmpVT3M5R1lQTDdxZDA3bE9LaGV5MHdi?=
 =?utf-8?B?YUNqeFFMQkFuV1JUenB0VE5CeDVlOVRnMXRkeTNlL3RIQThmWUhSNHE1MlBj?=
 =?utf-8?B?cEd2WWoxZ1JnV2JKVjc0dHZQdEl2MzhJM1lvWHlLNjNRbjZaZGI5NkJldDFZ?=
 =?utf-8?B?eTBtTkpLNDBXRnFRTTYzcHlBVFN6d0NlY0pZRnIwMTYwSEdNOE44UllacjBs?=
 =?utf-8?B?dHBraS82VjJqN1pMaENnVnBJMjNCMW5BcnJWSGg1T1BZbG5aeGphckJvRUlW?=
 =?utf-8?B?OWIza3Bhb3p1T3B0L3dXSFd4SGJRK0VMaDRNU1h3dE8vWDVmdlg3T3paTm5U?=
 =?utf-8?B?NGVNNGNmSk9YSUsxZFdmcm0vRnUwZ3EzSWYwZzdIOFNDTlhDb1hldldaSmVm?=
 =?utf-8?B?VnBIeWZlUU1mbDVTclJhQWFuTHpPUnpEaktoYlcxUU53T05VSWwxaVZNQWQ3?=
 =?utf-8?B?M3FudUhuZW55cUFGamJwWFZGeTBSZURJV0hqOG1tQVM0RTdlT1R6a1R3V1NH?=
 =?utf-8?B?N3ZkY2NrREl2Uk42ZzNZZVJnMGVFWlZ0eTlVanpwekh5SnRRRE8zMXp2ekZG?=
 =?utf-8?B?RE9HU0JPc3FtUTdlWG1xWHZ4YlpOM245SGxIVDVUQTg0eFJJMUQvd055S1Yw?=
 =?utf-8?B?dHkwdmNxYldqS1RhZVlVZDlBRmhXM0NSZVFlcG9CV2VkTmxQanZ6OEs0REo1?=
 =?utf-8?B?Q1J5MzFiTXdsdThvb3BHZlVkUW11dTZkYlJmYzY4NThyWFRCU0paWWYxdE5L?=
 =?utf-8?B?Q0duWW9RSmE1SWFSdmNFQWorSDBQVmRpZnM5b3FaVFlJNUJpWGFwN2FIenB1?=
 =?utf-8?B?YW9vMmxNUUtiQmdEM2FjSmY4UFlyT0ZTNC82ZGlBNjBjOWRnRlBYQmdtakIz?=
 =?utf-8?B?eVc2NENadVNXT3JzY0JURFJNTGFWamhScWJxNndOekRFeUNMQlA1bjR3R2Vs?=
 =?utf-8?B?dmREdXBjVHpCZkhLa3A4Wm1MNVZyK0xRdllYc1hPdlFNcUViYXpPbFh5UUU1?=
 =?utf-8?B?eFpEOE0wNWxXbFEwUWcwNXg4UUg0eWRWSC8ydkVFdmVZYXZPNUNPb3VvNjJq?=
 =?utf-8?B?RjZaWndSY3RsYVN6UjRiZnNEczBIdWNOYXhlalZUaGw2L0M5bnFoV0NvL01W?=
 =?utf-8?B?SzYvVllOWWdwOE85NDMzSUZhbFBRc2dhUHhXYlhTbTlGWnVpUXN4WXZ1enFC?=
 =?utf-8?B?YlRqWVpVTnJiT3p4TFN0enBGN3h5MDQwNFJkVVFoU0FFbGdkU0RvK21TYlpR?=
 =?utf-8?B?MXBtdVIvSlo4cEk3TFBjQVVpRTlYQ09ZM1lQYlhhYkltNEw2alpwaTc4bEh1?=
 =?utf-8?B?VDJ5YUc3eUpkaE9oZVcyRUJONkVuSEdZMUtLeDZQVTZvUXRIcjFRcXd6YjVT?=
 =?utf-8?B?UWE4aThtK3V5bVFPaytPNnEyVnBSOGY0L3JibmozNzJ3YjdTeHc1OWFmUTdN?=
 =?utf-8?B?RHBQRWloVWlUZW02WktMeEF2NktJdjV2TWJpUmZPSi8zZjR0TGFzZ3BjMUtW?=
 =?utf-8?B?TWIvaEF5YVRkWTlkSnVZaGJZaE4zeWRQSU5MYjlMQXk0VUtwWCszaEFMTUNX?=
 =?utf-8?B?Z1o1T0FDMmM4Vjc0SEs2S0JUUDNnVkFraG5aeWlBUGtGRktJVjZnY0RPdjdn?=
 =?utf-8?B?UXBhbTVLdFQrYXlrMFBxR1YxSDE2WUptOTh3STkrc0Y2OFg4SHVFYThaWWV0?=
 =?utf-8?B?UmJjdi91bnFKdUxPSU9XMEFuU1lNd1F0VWNtZVJ6emJmYmlvY3I1clVQY1lm?=
 =?utf-8?B?bkl4YUh4d25aOXRwTkdIZElXeDdzN2J2UUVCWWN1dGU2Yy94RmRJT2RGVmhh?=
 =?utf-8?B?RkYzVEV0dHNFMHdSR1hUZ0lSeHkrUk5DVFRMMUErWHZHWmpSYTJxOEJTeDJJ?=
 =?utf-8?B?UGJmWEhwamtralRDM0NPNHZQUDAyT0lkNGlJemUxdGFvRTlaWVc0WDFPc2ZX?=
 =?utf-8?B?NFp1OWRBbVBQNnFNWHdNRGxQSXAwODZvUGJsY1pLMEpRejBId3poQmxQaWt3?=
 =?utf-8?Q?W+meLeF+sJdVhuHdZCB4y1btl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C591F422AC2E4846BAADD267E2AAE6BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c9cfb0-cd0b-4762-5826-08db987d5771
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:07:10.7877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3yhir2vu+SkkCI6fBHbtQN603wV++ElnMEKpzvJjWr8e8h6y6izRSJB0Wo1UsVfz0eBJ6bwnXqVfNVzpy02pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC84LzIwMjMgNjo1NyBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFJlcGxhY2UgY2Fs
bHMgdG8gcHJpbnRrKCkgaW4gdGhlIGNvcmUsIGF0YXJpLCBlZmkgYW5kIHN1biBwYXJ0aXRpb24N
Cj4gY29kZSB3aXRoIHRoZSBlcXVpdmFsZW50IHByX2luZm8oKSwgcHJfZXJyKCkgZXRjIGNhbGxz
LiBGb3IgZWFjaA0KPiBwYXJ0aXRpb24gdHlwZSwgdGhlIHByX2ZtdCBtZXNzYWdlIHByZWZpeCBp
cyBkZWZpbmVkIGFzICJwYXJ0aXRpb246IHh4eDoNCj4gIiB3aGVyZSAieHh4IiBpcyB0aGUgcGFy
dGl0aW9uIHR5cGUgbmFtZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxk
bGVtb2FsQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQp3aHkgbm90IG1lcmdlIHdpdGggcHJldmlvdXMg
cGF0Y2ggPw0KDQplaXRoZXIgd2F5IDotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
