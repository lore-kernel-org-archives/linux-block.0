Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60300C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjC3WyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjC3WyA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:54:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27610ABB
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An5oWzDi3kO9R7I/KIdHTrR9T391K6+hHKh2JbKebKKGbtwppBj+8TO6iiCzR3c9xQXKwswD+Kblm+SYu0RQvr7nogftNz24wtN+OdGDEdlt+7adBfMY6CM0soinIubUaBgcGxATamTqC6NKOgaVjrsdzuCu5bwO8GKjQJLTfT0rFdTLJRTPYfEur6UFOY8LVnnGTmDM5pTg8kFOHFacijGRfBTZGcY7Wkr/bSyjFhgejCiMy9YV40FC8bivNGCrOf+m6NmICCccINWE4cKIkXX6teNyQnCpintGJK46uX2vOePj1fDBnSVAWFs/cTtraNFd5MSCZNjd1ny2y8rTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlSe4D47XMRemEk76ZBwfe/FhDjrgAecqz/Z1gze9uI=;
 b=c4x2aPElETsMULDXR3Egb3QVrjbvVnz8/RHnmcFaWIk65qSP4gS2ZO7nxBUsVhohLn9gZaYUyprIO+MGA0OO9uI9YsGnk+oBSaZQqMVeNU28UjjKakkF7D6s04A/brAqkL+bB/rDhgnBWa9hRsY3Dj4OxacuKjEpxV1pGGLa0z+JLS6VMhCbtW/L4xtdHiDfPQVLCVkVls0EDJIXKOBIZHm2t6rlbXlmvKmvEy5hKiJXgCvW2R3YRmc3NeAkpYiaZwFVFLnBlHMltsK402UntxTdFOU/h6qGKQ0JLNH84omxKXKnwSEHm1VR9eKjxaogVcXddWwyP4n7z4M2mPu+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlSe4D47XMRemEk76ZBwfe/FhDjrgAecqz/Z1gze9uI=;
 b=lqlTLs7ZmX9md5OvmduTi1ZO+3uN8TKTxb8F2pvvZO0tjgWCNGwwz7jgurQzpXknW9u90g4cwqfaH6KuwoaOz4uOmArVaxy+2OJ3M0eaYeEsGf9pxzhNOoUzuKYsntwy2gBTMXiZrFmjV6i9jrJ7urCXFQM3eoIY8IuaGeDUYT8NBKa9d2HajukMjhfiHhBwRCaH4baxQ3bQSB1IoUjfNcVcc82UoLFeBc2ae+NJSEB/sGKfH5y4NZwiJcQuTH8StlGoTC1PFa+sfsWSn/ri9EDg+wh2kGi7joCKgfIHAINlaxupyO4J/rs+jrPlskickiVpZMXFJVaHwqd7YiOLHg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 22:52:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 22:52:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V2 5/9] null_blk: check for valid block size value
Thread-Topic: [PATCH V2 5/9] null_blk: check for valid block size value
Thread-Index: AQHZY08sjeyeFW5nHEyKC2d5OvJdi68T7AwAgAACCgA=
Date:   Thu, 30 Mar 2023 22:52:51 +0000
Message-ID: <dba1e9e7-c288-9579-3976-d04899f7064a@nvidia.com>
References: <20230330213134.131298-1-kch@nvidia.com>
 <20230330213134.131298-6-kch@nvidia.com>
 <002d5d2a-f12f-a64d-6719-250823dc5a76@opensource.wdc.com>
In-Reply-To: <002d5d2a-f12f-a64d-6719-250823dc5a76@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4062:EE_
x-ms-office365-filtering-correlation-id: 737a2892-736f-467c-d9bf-08db31717dba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwtpinwgWmaHuzDQShClJUTI3Be6GvVTBWK26a6Sd3HOkBohQhqWgBTG3yWxffyL09r3Y1gGV8FEx2ecX+F7IgTtv0MM9qvDkLy6Ocn26BtLB9M4idCoJZHoYby8qzBup2jRcOn6JwjQLpJG8pgE1kDWTv7Z3sM/L92s++2mEcOewpGohbKFila4kQSQdCBm8AKdnpcwhMSKApGgUqQIsEWXKF95AfmAX3+fSGoQoqLKOgt0Ilsjv+Z3oNCdD0Jk8lncbWs34fGWBeVOx7pQNLe5cNvu8WrRIU3deYqSjILh+3jPhU7u8m3fjVxMdD9zqDcWq1SLRvp4VFuWQwLaFpasILyTvCN7RAPglJA7spkV6+ADgdicj1gwIeMx3iuOTevSUeKpZCtsexa9NiHwxyN2LKLtCvgayO+uRb6fZJxp+o/tZp2QUI0MbLFT5IYFOohz19Yiht20coIROYdu4dYFUd2Ql1MYcqGi1yplUcORlqq03Ig6+koMInuBRcDk94KUIBAaHQEcWBHuxfO1AgHITSPUCQL9BmgbE527UHrRwAtoNBZLoXIldhHPmb8dO0EYthca/wT5o4ciH4sQhtE/LW0knDGnnG4z9tWAbzpv7YNfbgz7qUzsvra+mr55Cz6b6nEbGO4a4CKXO4w8WsOpLnRMd6Qg4jL7ebvrftAuSu2KffukI+A/8/TwJ/iR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(38100700002)(71200400001)(53546011)(36756003)(6506007)(110136005)(6512007)(2616005)(54906003)(122000001)(478600001)(4326008)(91956017)(86362001)(31696002)(8676002)(66946007)(66476007)(66556008)(316002)(41300700001)(186003)(76116006)(64756008)(66446008)(83380400001)(6486002)(8936002)(5660300002)(2906002)(31686004)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUFjMmdma055OXpkN3gwT0E3c2V3UnR0WlJ1ZDJwckNRb0VySnNPSUtPVkR6?=
 =?utf-8?B?aStFNFQrT3Z6cXdNQUVXcEQwMmlpSUx1anlXUUJsMUF4WEtyclcwbUtsZEFo?=
 =?utf-8?B?Nmt3SXBRTiszUjYzUXJCY0V6TjlUUWlvNXVVTjBlRHBEcEZDRDE4MEFmZW5Z?=
 =?utf-8?B?cjRkYXRpVDNwMmx3MnNCUWpPMlI0YUI4N2l3TDdiR0RBM3llWXk4NDAxQnNu?=
 =?utf-8?B?ZDM0ZkxscUJhWDlmMUd1L3JCWEtVUUJDY2lBTDZaQm0wNEVDOHN2M1ljU1hW?=
 =?utf-8?B?MVFyalFGc1p4QlRtVnR1RS9VRXg1VzBDdkY3d1BOc2Q3Mm9lRGxncG4yYW9C?=
 =?utf-8?B?TU80T0VzWjg3Y2dSYzJacHk0NHJMNk9mcTBsV2FLaDdlcjZjQ1pGQ0dRMXRV?=
 =?utf-8?B?Q2R3N3VEU1pCSHBvcXJGL1R3V0dKUStSTVIvRGt5b3NPVXRoS201N2RWRUZB?=
 =?utf-8?B?NWM4cjVoV1cyWDc0Z3BFZTZKODNGSGlwTnY2bHJPUUpPTXFqdy9Ca3lsWm1y?=
 =?utf-8?B?RG92ZGRycXM5N0p5Mkg0UG9OVUppbmUxNGgwK1lydEdReUlsTDArWmNJYlRD?=
 =?utf-8?B?SWE0bVN1cWtrWXhpLzBWUTFDa2FLNHdubkg0MklQdzgrNzRFeWg0bGZPYjh1?=
 =?utf-8?B?eUQ0dGNkS3lpUmVpbGxDN1YwNThvcXRPdUJ4ZjdRSEdka1p4aFg0ZnBSYzhT?=
 =?utf-8?B?UkFQRGtielNlTHo4UTBrUUlCWWlxM2FENnJYbURramMzcFluVnhWeWJnVzlo?=
 =?utf-8?B?Qm5ib0JqeTJIQlJnM3JnRk1IZE0zYTFWcFBERlVZY0VxWUdYN0tETCs5QWhD?=
 =?utf-8?B?VFhTNVBrU2FJL2JEMnpPSkg4SzdqbXY2ODI0N213azFSdDIyN2FUTjhCamJU?=
 =?utf-8?B?Umcza3d1VTBxeVhPL0Q5WG9nYytQOEoraTFYalRqbTdVYjRGUzJiZU5WNkQ0?=
 =?utf-8?B?eFY4bFhYbXpxZDhpUWhzdk0xZEwxSUF1a2wyZGpmdUZHWXZkaVBtejluZ1Mv?=
 =?utf-8?B?NnVCK1g0MEFqckFWak5LTkVoYW1QWEQvaTNvV0ZUTXQwNlZLNUZ5VXh0Vkh5?=
 =?utf-8?B?Q0F1dHEvMzNEZkpJMS9vVTFyOTdlMnl6Y3NTNWlOcE5lQW5ES1l4Y25vWW43?=
 =?utf-8?B?TXVVZVNET3AwS2hmWEhjZXk5RzN3bTl0L1JZRXprNm5vYTMybDYycXZUcDMr?=
 =?utf-8?B?bjNtNit2M3l3elhIOTBJQkw3T0hJMXdiblFCTWxEN3haWXBDaWpac0JZNGtU?=
 =?utf-8?B?N2NON0FQUWhDcXpxRGZraWQ2OVVoRDUwQ0ZXSnc1VTUvVEVuY1dqN09xdER1?=
 =?utf-8?B?bFE4aGpmS3NMRWkvOUt6L0FrdGU0cXhhSW9yNk5McEVpOXVBSEI3TWZRemFU?=
 =?utf-8?B?V3F2UFRQUkRJYXMreU91M1gzVmJtSVZmdU02M0FwMG1TeXQ0dHdEZlFTSXUz?=
 =?utf-8?B?dkJSTi8vdlFEdHlnU1BlUzIwMksrMXk3ZFJyQTlPTi81c0ZMVEtMRXRJekJp?=
 =?utf-8?B?TEFpRm1NV25KZWxsd3cwcHYybEpiSUk3bXlMUGxQdWtEQ3A2bC9xRk9RNTdh?=
 =?utf-8?B?L2l3SEROcTNnNStFN2lnNkh6ekcxb0Y3V2xQczVmRUh5cC82MkV5V1M5OVBv?=
 =?utf-8?B?T01xMGFwQmFDVDA0bmZnZEVZeEZsSFNydmtHOUxYRjNTVEcvSXdEOWVEZEdS?=
 =?utf-8?B?L2orK0luMU9Hb2JCNnVUcjJGYk9UZyswRlNXWTRrN0F0enFFL3BNd00xSVlM?=
 =?utf-8?B?VWJPeWRFbG9Eb29LMTNzT3JVdEZ4ZFgvbXI2Y3VnbVMraTNKUnF0VUY1UVlT?=
 =?utf-8?B?S1FWcW5vNi9ESFA3OVIrMUxGK1hUczhMNGo5cDJaczFpSmx5czBhQWpXODNv?=
 =?utf-8?B?elFMMUhFWURnQ2xHZHZzbWNlQ1dmbG1pYnJDZTE0cFp2azZWWFZrcCt2bWpB?=
 =?utf-8?B?Z3FsVWdIVC9GOHhjVFc0ZDRwRUp2ODdFMm9ZS2JwMlZWZjlzU3lTRnlIQXMy?=
 =?utf-8?B?MDJqNndQMjQzK0VuOXlWVlB6dWlqUHh3cG1EdnAxVUNZaUtuN1IvbnlGaWhk?=
 =?utf-8?B?RkJsdUsvR2s4b3lXdk1YTHhCeTB5MlZDKzU0eFJvVXFwVU03SzZBTTV1bTIy?=
 =?utf-8?B?ZjBLZ3dSaFY0bENkTlFIcGZFZjhIckhjTlVLSU5sTDFuRDZ6S0pFR3kxck1z?=
 =?utf-8?Q?FZVyB6bklzIq8f4V/UF2VdPAxfjpUd1Sk07cYQ9/dVJd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B3CB4E8BEF2B94CB2DAF7B70AED435B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737a2892-736f-467c-d9bf-08db31717dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 22:52:51.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Z9d5FWNYWYIn4GdlPhlngKiYRHdyb1xZxPYI3MbH8QvC/EWSRLAeY43Rm7+nENIpls5F2vLP/jnHmSDTPoXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8zMC8yMyAxNTo0NSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDMvMzEvMjMgMDY6
MzEsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IFJpZ2h0IG5vdyB3ZSBkb24ndCBjaGVj
ayBmb3IgdmFsaWQgbW9kdWxlIHBhcmFtZXRlciB2YWx1ZSBmb3INCj4+IGJsb2NrIHNpemUsIHRo
YXQgYWxsb3dzIHVzZXIgdG8gc2V0IG5lZ2F0aXZlIHZhbHVlcy4NCj4+DQo+PiBBZGQgYSBjYWxs
YmFjayB0byBlcnJvciBvdXQgd2hlbiBibG9jayBzaXplIHZhbHVlIGlzIHNldCA8IDEgYmVmb3Jl
DQo+PiBtb2R1bGUgaXMgbG9hZGVkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ibG9jay9udWxs
X2Jsay9tYWluLmMgfCAxNyArKysrKysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5j
DQo+PiBpbmRleCBmNTVkODhlYmQ3ZTYuLmQ4ZDc5YzY2YTdhYSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL2Jsb2NrL251bGxf
YmxrL21haW4uYw0KPj4gQEAgLTE5MCw4ICsxOTAsMjMgQEAgc3RhdGljIGludCBnX2diID0gMjUw
Ow0KPj4gICBkZXZpY2VfcGFyYW1fY2IoZ2IsICZudWxsX2diX3BhcmFtX29wcywgJmdfZ2IsIDA0
NDQpOw0KPj4gICBNT0RVTEVfUEFSTV9ERVNDKGdiLCAiU2l6ZSBpbiBHQiIpOw0KPj4gICANCj4+
ICtzdGF0aWMgaW50IG51bGxfc2V0X2JzKGNvbnN0IGNoYXIgKnMsIGNvbnN0IHN0cnVjdCBrZXJu
ZWxfcGFyYW0gKmtwKQ0KPj4gK3sNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJcmV0ID0gbnVs
bF9wYXJhbV9zdG9yZV9pbnQocywga3AtPmFyZywgNTEyLCBJTlRfTUFYKTsNCj4+ICsJaWYgKHJl
dCkNCj4+ICsJCXByX2VycigidmFsaWQgcmFuZ2UgZm9yIGJzIHZhbHVlIFs1MTIgLi4uICVkXVxu
IiwgSU5UX01BWCk7DQo+IFRoaXMgaXMgaXMgb25seSBjaGVja2luZyB0aGUgcmFuZ2UuIGJsb2Nr
IHNpemVzIG11c3QgYmUgcG93ZXItb2YtMiBhcyB3ZWxsIGJ1dA0KPiB0aGF0IGlzIG5vdCBjaGVj
a2VkLiBBbmQgZm9yIHRoZSByYW5nZSwgYmxvY2sgc2l6ZSB1cCB0byBJTlRfTUFYID8gVGhhdCBp
cyBub3QNCj4gdmVyeSByZWFzb25hYmxlLg0KPg0KPg0KDQpJJ2xsIGFkZCBeMiBjaGVjayB0byBu
ZXh0IHZlcnNpb24uDQphbnkgc3VnZ2VzdGlvbnMgb24gd2hhdCBpcyBhIHJlYXNvbmFibGUgc2l6
ZSB3ZSBzaG91bGQgbGltaXQgdG8gPw0KDQotY2sNCg0KDQo=
