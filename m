Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD8C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjC3TCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjC3TCA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:02:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA956BBB3
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5o/sJAaSfNG4LYG257PIv6OyDaAIFEG8mWVwpHUhnU2X6J03pB1+zIvpZd9bCFe2USxrh4bsEJFH/w5IB40I6LylA9LCoQbIOctsd6DdGBTUXvtgfZXNiTKUFd4WrPTlyF9iPTpvvLgS/lT7OyxrzOePx+xiUTU7Z7QVD7ku9p+pputYQQbW7NY+KvdjCUXTfg9blbLVLxu4QJJaFSXr/5W1zYmdiHzypHm35elRhZ3/GbsWE06EEmImw+h4Px5KweyZXSAnS24LXxcz5z92iphRpWagr4Z7B3hiusBr1sSz49qb1aCeOqqfnbwiGSkekUIGJxGLbYgoxhNJ3plFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCVY9MxWEJI9vDFHnXaTwPhDbGmwux4ydKCpbZzLNWw=;
 b=i+taScDlJOt+AnvbQN5MuL29hqVnsRWmnYra8rkSxnst+xVsqkemVIBu/c7Rqbjeaxic/rXcq4TiB5Ah0lLssigXn3lA+Oe8AV4WTPJFE+BgSy0uk6erv063IWjwZYeTs7KHY2XfI5FnsbVETE9GFkXegcMYOps3BY9iMOygQ50GPczCj5fIunAzxQ/fRTakqD36up9mBmddOc2pbFzyzBk/MRxoCAIoBCFfxZ/C4QIvS5i73NGvJvQEJPl5hLLKWTcKakgr0YK1nN12CtaXHjMZSuwT8ItkLkN4orNl+tPJBJ10jJgBeXssDJginCiA77ZtRezXfueCzJZvPcvfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCVY9MxWEJI9vDFHnXaTwPhDbGmwux4ydKCpbZzLNWw=;
 b=jQjk32lYbIdMe2JarqvniUNFCVTHa6/L3oUlj/rZLTcfVuaSPLX8Hy4aEKckNPkIBH81I6ix9O1BWlujyTKrf2ObTWgaC0NfxKpuKKsicawcIQn3WFiSmZd+fw7u4EzrsyAIsNiSK2lk7Ar1yxeWWbm6Xq4K0J0HsEcrgX7vw0RGTkpYNvcTvjz8mdQLwx7U12SxcjElF3AF6aa29cZL1/LnRV3wGU9I/lAMfWf42n/rrTsqNxhjIXfSx4AL8xqCqKLczd6+3nHXuLRlYvJq0Q14XYMuPP1rhPhzDptMyPtkuK0lGSXwM22Q/hVjzkZ6GTi59hsWaljDo9eSForEsg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:01:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 19:01:51 +0000
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
Subject: Re: [PATCH 2/9] null_blk: check for valid submit_queue value
Thread-Topic: [PATCH 2/9] null_blk: check for valid submit_queue value
Thread-Index: AQHZYsvesRb13sv4GEKpYW4aaVmet68TDMWAgAChzoA=
Date:   Thu, 30 Mar 2023 19:01:51 +0000
Message-ID: <bbe150f5-d1d5-524e-c5c7-a418a79b3b72@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
 <20230330055203.43064-3-kch@nvidia.com>
 <3e67b995-d2fd-7518-2a55-3279bc10d950@opensource.wdc.com>
In-Reply-To: <3e67b995-d2fd-7518-2a55-3279bc10d950@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6608:EE_
x-ms-office365-filtering-correlation-id: 198ae4a2-1bd7-4fc3-edc2-08db315138a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cdTu7SRQQlnYwskQL6Uu6u3hv0GFhkB0CaPbYgSzGPIIMUQIwT6qom4L4US2kTgfZqdnn4vDnKDsK/RcIjlY0GpMrxU0x39JXAHjTb/Y7PzDpjTFuanzempW0Qz5smc0NkH0FFLJdgw3lDbDvneh+9U80zlNgi4MhZ2QhaRb38OIwHlxZdN/3ELixgcfIc5jBzTVfxZwJapeE/b6v0VGo6jEDGKVLF4jjpDqqAd2by3FNAR7vzHXxKAwg10EfnmRgRZqdnUKHjgbI+rEWuPkoh09t+7DnbqHLSAyNuXn+AfUfmN/S0xBwb7QE5Bbt7BiNydJQ3wEvd2oEpXmmXxeChMzhwjxhxdLzKF9l3O3eyfLUvkwe9ELEdGSFs3ySyyR2iFYh3pkcF+SwulGv/eZXKb4o6aGXwzjnfr2MoxIBQsSeGIICaVSj28nqqjtk/suhMaQu5SGx7WDQGF7MUfFRkZMs/UeQ7qzNrHnekxVJnq522KhqqkkpA8TTWLfRWqL9FjRm1g/A4f909OkGLB4WYpSPWUcGBxWtYITxHrwNxRDbspkm/05YBfjc7NzktwHL/zgggQl2PdpntnQ975l2CQ4jlJuCKb1nof46TMeGYlbIbiJ8Dl84r9uaN8hL5NgSTgHoSwWOVfYVGCLzGSaXeIo27cSMIJKUBllWsrZdl0zc07U3cy8j3vrqsN/NU2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(2906002)(31686004)(83380400001)(2616005)(66556008)(110136005)(91956017)(4326008)(8936002)(36756003)(478600001)(66446008)(8676002)(6486002)(66946007)(66476007)(316002)(71200400001)(64756008)(54906003)(5660300002)(76116006)(41300700001)(186003)(86362001)(122000001)(6512007)(6506007)(31696002)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhrODdkOFk0MXQ1MFd1SXZ0Mjl5dkY1NlJHbmdZb2VTUERZL1A5U0tsbC9D?=
 =?utf-8?B?TzJyYWVBZ3Y5Wk43ZXhidGR1ZkNOL0JYcFczN3dLZUFrV01LTHhTWDlPNHM1?=
 =?utf-8?B?VXFRbHlRbGtXWXBmTitqSXhSSHNncVNjeEFlaWNNMTF6NUxHbVVwRUNSYk1H?=
 =?utf-8?B?WGY4OFJDNnMrWXRVU012NWR3bzI1Y2E0bm1tRjgzeXlIemMrbjQ2eGcwQ1Ix?=
 =?utf-8?B?Nmc0TkNNaC85UEkxMkppMVR1NjV4ZDlwWmJuamVPU0p6MzBUM2NqWnpjVU1D?=
 =?utf-8?B?alVUcE5oajJSS2hZcXdVaUlSZ0MrZXdpaXBTT2Jvenp6cU4xNjVhY2tnbXY4?=
 =?utf-8?B?ZkVxU1JaV0QrM1hlbXRSRDBGNGYyemVnZnVNWG45YUkzZ1NCVzlPRGhUY0Vu?=
 =?utf-8?B?emgyS1ZRSThqSWNla29mS3NSRFlIdkFNVURRd2R2N2tFZ2I3Umg0U21zb2JI?=
 =?utf-8?B?RTgvaDJ2Mm11YUdYajBCTWdEVE5mUllZOElEOG5VWnBKZXNEQ0o2bTRPREhs?=
 =?utf-8?B?OXNOMlZvMStHMi9kR2FZcWZHdWs5dDc4UVlIZFRNaVpWV3N3Zm1tNVZwc2V4?=
 =?utf-8?B?dTU2K3Z3WXFvdCtVZWhCaUl5Y1BZSkd1OGV4b3U1aHcycFIvKzVJMXh1d0dS?=
 =?utf-8?B?RWg1OUJ1cnZPL1o0ZU9TNUJMazlJMWJrdjhNTzNaeGlBZU1RUmgxanUzYzZN?=
 =?utf-8?B?NDVZWTE2VS9zdFpYcWQ4OFMyMU9mOEFtSUZqdFNLS09zMGlEUVk1NUtMVTFF?=
 =?utf-8?B?UGQxR2Zia0Z3U2g4UHZYMHRxSFM5aGw2V1hBT3UwNkdyYXBORXo0OVdjTFhk?=
 =?utf-8?B?MjhVUlp1MDNFWkRjWjZmZ0ZtQXB0Q3d3Qi9SeC9OT0ppcUFOZUUrcWZLbmJz?=
 =?utf-8?B?Mm4wdVNIVVlpMTRHK1lLWGRVdDBVM2M1ZlNGN2Qxb3lWa3huSHl2UzU4R0Mv?=
 =?utf-8?B?bTVDckE2MzZUQWVKSng2NDgzaExsYWtQRkNHOUxrZStCMFE3WVkwMm43eDA5?=
 =?utf-8?B?dDlNUDlWZWNuZjFsWXhveVF0WXkrN21WdU9kRTVRZnc5VEVVOVJWUGQ4MWZF?=
 =?utf-8?B?ZUJud0YzVWlnQTlvbGcwRkdmMUFxNWpYTmFEQ1h0VWpxMWJRZlVOcnNPY3Vo?=
 =?utf-8?B?QTdyRXlRSCtmNmVlanRjbzhqeXhiTVRnUjZMMlYrK3hINXhMOGlsaUpSeHVU?=
 =?utf-8?B?ZHpoTDA4eHB2MXNJWGk0b29zWVFtRXZnYk1NU0wwaEJXdUt6cGUxNytHSWgy?=
 =?utf-8?B?SEZvSnBCeWhuZmNwbEhUTloyemhONXpDZ3VsTk1rSDZJYWJ3WVNFSCt2L1Z0?=
 =?utf-8?B?bTZaOUtLSlNPR1JzOVp3SjRqZHhhcVRleTZjTVhtNTMvQlVGN015YjlabDVs?=
 =?utf-8?B?VVVEaHpCVU1LckFBOTNzVTlNeGtaWlpsQjRaRmNiditHNEU4ejhlZkdkVEJj?=
 =?utf-8?B?YStUaGs1emdYRmt6bmo1WGE1aWZZZkplRUkzTTJWQVBaSnptK3lYaFNvOWpt?=
 =?utf-8?B?WHgwNlp4TGI4YVFWUHVMWVRhYXZwam5CTkxWL0xHVVd2SFN3QnNqRkR5a216?=
 =?utf-8?B?a3lkTTUycHF6SE5TVkRVTXBCbkRKSUY1a3JmRWZoVTZrcU53VWJ6NCtuWldk?=
 =?utf-8?B?ZmpESW5ZeUM5L3c0U1ltamtGcWY4WFJxdUhocEY3Q0htLzBsT2JPYjhMbkND?=
 =?utf-8?B?UG1UY3I0N0E2QzJtRklmVUFqWHNPcG9FZGpXelJaMjRYakRvb0ZYUmtuUVFO?=
 =?utf-8?B?UVRkNStMOWpvSmZPalFNYjBBa0huTmY2RTZ6Uk9aR05yaHVXbUM4d3dOMS8z?=
 =?utf-8?B?TVE0ZU9sS1Uva05mVzR3S1Q4STYzc2hDVkFWZDZIYWdsNThaWFNhR040S0Z6?=
 =?utf-8?B?WG9jeTVFNlJuaHArUXp3OXFtYlZzWE5UdTFlTkxFbmx4NnB5TC9nNURSOWU4?=
 =?utf-8?B?aTRKL0dNcExtcWVmRHFUWDc2Z0ZVVlZreGVjeHpHQ1EreWVXQi9FZ29VWmRD?=
 =?utf-8?B?VW1pdXhzSFRGTnFYaVBqVzBLYjhYdHVyWXRRWWdoSFdtSzZTazNZN21hUkhh?=
 =?utf-8?B?eFNackxTcWFHSXJ0VkxFRFNxNUF6OUN5TXhsRDVEMC9TRlJsWU8yT3RZYmxE?=
 =?utf-8?B?WWwwSHljQjU2RkZJVHJTUlh0dkNsRWlsQnN0ZlVrQ2Y1dDFvV1RpZmU0eEkz?=
 =?utf-8?Q?fshSmNBSyzrYk37YUlnmQcY+QlLwZi5boZACQwDgpz8S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF957D2F2D027E4CAB88E3BEBC3A5DA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198ae4a2-1bd7-4fc3-edc2-08db315138a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 19:01:51.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSDcCDZeBkXqfqbes22CXdHjoW5uKlIb+YOZ6si6irJ/CsEwKBo3nvrRALdiPdalEDkLzHnwHLkMx6+4svXCGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IEkgd291bGQgZG8gdGhpczoNCj4NCj4gKyNkZWZpbmUgTlVMTF9QQVJBTShfbmFtZSwgX21p
biwgX21heCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArc3RhdGljIGlu
dCBudWxsX3BhcmFtXyMjX25hbWUjI19zZXQoY29uc3QgY2hhciAqcywgICAgICAgICAgICAgICAg
ICAgICBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVj
dCBrZXJuZWxfcGFyYW0gKmtwKSAgICAgIFwNCj4gK3sgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAg
IHJldHVybiBudWxsX3BhcmFtX3N0b3JlX2ludChzLCBrcC0+YXJnLCBfbWluLCBfbWF4KTsgICAg
ICAgICAgICBcDQo+ICt9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIG51bGxfIyNfbmFtZSMjX3BhcmFtX29w
cyA9IHsgICAgICBcDQo+ICsgICAgICAgLnNldCAgICA9IG51bGxfcGFyYW1fIyNfbmFtZSMjX3Nl
dCwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAuZ2V0ICAgID0gcGFy
YW1fZ2V0X2ludCwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAr
fQ0KPiArDQo+DQo+IEFuZCB0aGVuIGhhdmU6DQo+DQo+ICtOVUxMX1BBUkFNKHN1Ym1pdF9xdWV1
ZXMsIDEsIElOVF9NQVgpOw0KPiArTlVMTF9QQVJBTShwb2xsX3F1ZXVlcywgMSwgbnVtX29ubGlu
ZV9jcHVzKCkpOw0KPiArTlVMTF9QQVJBTShxdWV1ZV9tb2RlLCBOVUxMX1FfQklPLCBOVUxMX1Ff
TVEpOw0KPiArTlVMTF9QQVJBTShnYiwgMSwgSU5UX01BWCk7DQo+ICtOVUxMX1BBUkFNKGJzLCA1
MTIsIDQwOTYpOw0KPiArTlVMTF9QQVJBTShtYXhfc2VjdG9ycywgMSwgSU5UX01BWCk7DQo+ICtO
VUxMX1BBUkFNKGlycW1vZGUsIE5VTExfSVJRX05PTkUsIE5VTExfSVJRX1RJTUVSKTsNCj4gK05V
TExfUEFSQU0oaHdfcWRlcHRoLCAxLCBJTlRfTUFYKTsNCj4NCj4gVGhhdCBjYW4gYmUgZG9uZSBp
biBhIHNpbmdsZSBwYXRjaCBhbmQgaXMgb3ZlcmFsbCBhIGxvdCBsZXNzIGNvZGUuDQo+DQoNCkkg
ZGlkIHRoZSBzYW1lIHRoaW5nIGF0IGZpcnN0LCBob3dldmVyIGl0IGRvZXNuJ3QgYWxsb3cgdXMg
dG8gcHJpbnQNCnRoZSByaWdodCBtb2R1bGUgcGFyYW1ldGVyIHNwZWNpZmljIGVycm9yIG1lc3Nh
Z2Ugd2hpY2ggSQ0KdG8gYWRkIGluIHRoaXMgc2VyaWVzIGVzcGVjaWFsbHkgZm9ywqAgd2hlcmUg
dGhpcyBwYXRjaCBsaW1pdHMgaXQNCm5yX29ubGluZV9jcHUoKS4NCg0KbGV0IG1lIHNlbmQgb3V0
IFYyIHdpdGggcmlnaHQgZXJyb3IgbWVzc2FnZXMgLi4uDQoNCi1jaw0KDQoNCg==
