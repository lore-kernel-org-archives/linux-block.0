Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 22:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358222AbiDSWg0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiDSWgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 18:36:24 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF82DD49;
        Tue, 19 Apr 2022 15:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBoGauQHPi0w47lkW1bUlC3bbSh5jzPakJIrXPPv1oPyEpbH0SipYa+RZla0OqwZYNYL2nsLOhYHq3VQ5nIfUEqMXuVUASxtilxke4wPj5NYwKjYsCBtf0J0aS2Mi5ohv6xlwRuYtVdLBQ4jVgskf1kOJ98NVeoSAXdBmYDXnobYQTfvrcHAg/dGC9jn+dzHiw3bVwMyYIFd7kiww4m7dZdMQ48Gl6tCJCh+j29u2PnJsQam9XeUXvw2rrzZItSIJGGlmxSrM2VtrLUI4j8gjAuR0B/ADSZ5Swb4Kk9p2/G/BNDix/GaQ+zGm8ZffA8b95m5Wq9oRjkzg3uEDeFuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt08UKiJ+tL8JV7sCUrdsrEOjz3B/yvfb1NO9OM4kSU=;
 b=GnPv0H2oxx/P+/vBusd3BWmELCNmc4cTgt5/oZB8qFOjqHfCSs8kWfEycWcL02yDR3IQ5NmRHJHyoxx6W1ZrSdtDWq6iKyAA5HsHHoFwiLEr2vkGAzoK/rKciSipxNOue3ifqUbu9vMldH67pUGGzllCC64qoSZTM2C68boN/lqLwE4+rixL0R24Rqzz9oRjwiHdQk1SGCtd8tIWx2zTIZdej3eY2fC6k5ukfUwK03bpqLs0eWqOS5j6Lg/vX2UxENArIpPfI4zTsxgODjzpanuP+MNppPHcaaNcWLGhspMoIiaDtV1RMZCgmVlMf4sbg0HVbGl/qMJNro/90bjucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt08UKiJ+tL8JV7sCUrdsrEOjz3B/yvfb1NO9OM4kSU=;
 b=ku4d/kpexsIz2bdsl0yBdn0K4jNyWWZKunCnja5166OXE7wOXhnXqXLvksY9BJimEHED4/bRy1TdFeT3uixW+V/GdPDhMVOouJkthUQ1KP9fHWz8ZodI0sSY8hIeBsQJaRXqK9U/4El7dXq2gUiQKwBG8hIu9eV28hx/9uR2RKdbGQREWAojovhSos8ULMqH3iTrt7mz6OHMQLSSyuTsyeRmh6ORDmWh6zz6a4NmKflXb/ZgK1srf3OYBJNsu3o7A4c8m1J3Xj91DnGSCr/OG1kWFMifXoWHqxMGFIk0CzgFiuMU8TSmVpfCYkI30P5hSd0yZ1Xco2mjyFhGV7iB9g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 22:33:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 22:33:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH 3/4] loop: remove most the top-of-file boilerplate comment
Thread-Topic: [PATCH 3/4] loop: remove most the top-of-file boilerplate
 comment
Thread-Index: AQHYU7db/JPMoGOkLEGzIVrfLE5oQaz305cA
Date:   Tue, 19 Apr 2022 22:33:39 +0000
Message-ID: <5df0b974-18c8-d75e-c1d6-8237d1c1a333@nvidia.com>
References: <20220419063303.583106-1-hch@lst.de>
 <20220419063303.583106-4-hch@lst.de>
In-Reply-To: <20220419063303.583106-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbb24241-5a6c-4147-1479-08da2254a679
x-ms-traffictypediagnostic: MW3PR12MB4411:EE_
x-microsoft-antispam-prvs: <MW3PR12MB4411599796DDC98C7E3AAB4FA3F29@MW3PR12MB4411.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0v6TsIirTF/m6GTjBCSqIFcIQeHIxYPPaiaOS5xxlrZGUWpqJU2rOLGfzZmMYVcBiMZhf2OU+Gt31+wt6q0FVtRDRAyYIyBeUS00B1NlDLr0frvtJDKsLA2UxeeIeokS3VFDnMcg0m7QHo45srIua5g6qLVbEk2CWzNhH96DGGhC2A2wViApVDUTMGVwUUpapH8JUj3WMA7tLl9ylBz4piJPSZl2VWwI4Ny2BT3KkcQo+hd3IEeuJvA47pq8bSIxPEbWbdEYdfZgfRKKD489smbVSvRLCfNyskSqSIkRuH6u475DfN007gxnTswLOmhOzavIWWEsgv3BBDjvoo6ZVGqGXflmCwGw/SX9qet+Otonih2ziF1m1Set0OOhR4xaCNGYvvB2MXCfFn5nYjZADsP/XPs6zXQrub4x762j65x5TiUOnRHVchhJ0yJYqQNSYSUaWjOMkSedeSlbdf0G5131p/KbrZ6HBlvpj51oRZFgvuMFvNQ+MTwjHb6+b8EMb45ifQ7PRh6CvTp6ZFA1C8KeZd2yKL8fgij+QfHPhD6YV8SJ3cW7WtBSXq1WPYjEh+1FWMOhgb6H3iXFe0unNnqDVd4lVUrY/nKRnWrZGCN3CSR+Z/zPIqtpv39eNMf7CLA38bPKCXDOxhfvEEUf+v1lHHZXUmxVud4FwnRQPDyqMIueVPjnvZo2KJcHr3ztFhCYd7J40nDxHoZEnvCLmbKGKkoKsVkMYPlXopuLCWM53e3Oqa6hnf5vPlew52iqv27mxct5SVyWPtWGorbaeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(64756008)(8676002)(86362001)(71200400001)(122000001)(66476007)(66446008)(2616005)(2906002)(558084003)(6506007)(8936002)(6486002)(38070700005)(53546011)(6512007)(38100700002)(31696002)(36756003)(110136005)(508600001)(66556008)(76116006)(66946007)(31686004)(186003)(316002)(4326008)(54906003)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3loK013clR4VEFtUVByYThCVDlvTkpYRzJHdWRTcnNaV2lsUGx0bGlybG9Q?=
 =?utf-8?B?YndqTnhEVkxwUmdBa1h3Q09YMVZHSHcwZ1diT0w3TXdqQUFjRVNSMUdYdzRR?=
 =?utf-8?B?UkUvdFVwY29pOWxmS0tHSlowOERaZjZKTXBvMXFmZXRaSWp2SFFkN1FMVTRt?=
 =?utf-8?B?akxVa3pkaTltQVlhbGo0dU5tZnhIdWtORHR3Vi9IM0VSazlaYm8wSWRZbmYr?=
 =?utf-8?B?L2RmUEFScUlyZnkwN3VmTWttSCthMGZxUGNXeVFXTE1aRjBmU3JWTVBSMDQy?=
 =?utf-8?B?WlFEb0NaRlpncjRMOGNKdzZjU2NKOUlXS1E1NE9OZC9oWGJTQ3RWdzdIVjZt?=
 =?utf-8?B?QmFaRTg3aDNITDJZc3RMNEpPS3BQTVc5SWJWMHhJa0w3SjZiY1VoMzAyeVp0?=
 =?utf-8?B?YktGMzUvRnJ0dW9tbC80MVVEdkk2VDlIY3NiZmV1TzFLdzZaK0Q4eFJCaFdT?=
 =?utf-8?B?RzRsMmllbFN3Ym9qSks3VGdZQisybmtJQXdNMjAvVUtxV0xMbGx2dTRuS3Zv?=
 =?utf-8?B?MFpOME9xZmxKV1Z0UWp0YndMR0lCdXhtTnZNS1NlcjU3OEVwWUdNYzN6OXVz?=
 =?utf-8?B?UW9HYUE0L3UvMWpQNmZsR1dIanQ5NVhLZWdPMFVwNEZQWjZLWFRsM0psbWpE?=
 =?utf-8?B?NlBhcEd4amZOd2sxNDhZcnZIalRWc0dRZEFiTmVIamc1ODdBd1ZnSVVYUjBW?=
 =?utf-8?B?UU55WUdzUTZncll0RWt4Y0JlOU4xUHBrSTlKS1Vtay9SVVVVVmFLNmtVS0pZ?=
 =?utf-8?B?MUZkc01JVUJYYUQrdzd3ZjB5UmpnK2VZUFcwdU1WZlZhWDVMT1JNaWw1MmVD?=
 =?utf-8?B?NFV2cUZiOVJ0ZDdxTnVsSnF0SHd2ZWhvWXBaaG13ekpRQlRjY2ZaT2NqZnlv?=
 =?utf-8?B?dmxMZ0I0cnk1aURseS95RFRDUlhZTm5qbnoydDJHV25jQjF1QU1xTXI4dGlH?=
 =?utf-8?B?MWdEdEJiLysyR3VuMlM3R1dTaWZUc1BtbmdYa21CQzNTN0NnK0t0NW91eExj?=
 =?utf-8?B?QVNkMGZHOEdmeVZEUFhmd0FUZDNKR1lkbUZHUXYrRVVxNnhuWlB6V01JRWRy?=
 =?utf-8?B?eCt5bWpoQ0wyaTNCOWNmQ1NCZVovSXZYbFdMNldKYjRSQU5GYmZjS295RzZ6?=
 =?utf-8?B?VWQwNEdrcGY0VmRrWlRqdTFrcWh4S1lxTHRmUzZoUXh6WWJjcFVXWkg2RnVY?=
 =?utf-8?B?cXIrWGdjQkxXbzNNSFhOMWxEajVweVpPWkFWSmRJbTVNVzFQanJRMFlraFha?=
 =?utf-8?B?TjBoU0dVUkQ3aldvY0Z3QnMvZ1BveHJuSG1VNEptT3FuckI1VFBWMkMrQXFq?=
 =?utf-8?B?NGl6bVBtYjI4RENNNWNJeUFRK1RmUUVwMUVSUmUwcTF5OG5UUHM2aXZWOXlj?=
 =?utf-8?B?c2g3ZzN2Ry9yRFZpOE9MMDVLd3hueVhnN0duWE53NDQyUTZnYWNWT212c2R2?=
 =?utf-8?B?UUpEaS9Pc3ErV3BxWE1lbEdVSTQyaWRXRllodE5VOVBOODZLTEM2am1MWUdy?=
 =?utf-8?B?UThLUXM0ZDYyejVXLzVqb0NNMTkvRVlaOC8wR3RwYUhud3RpbERPSzk4MUha?=
 =?utf-8?B?S3I5eXZmbURmTS92N05BRStyY2RoK0EyOUhicFQvSDM3NEI1Y2ZpQ0VnNHJK?=
 =?utf-8?B?K1c3MkM0N3EyWFZPTFhOcTBjTWp4WVRrcmhBQXA3WU51ZCtJQjROVjd2eFJU?=
 =?utf-8?B?bUVLcFFQNVFLNnc3STdkZVNSMm5HOHg2WW5ldWl2a1Z1V0VORTkydWkyRzZo?=
 =?utf-8?B?RVBHVG5GeGhEWHdXdUpkT2tNWGMzNUhWVitmc0ZQdC8xN1p5VzRRRjh4UmRR?=
 =?utf-8?B?OHdmVFZGVU5VVkNIVUtLTlovVUdJYlhzRVJGMlJrOWQ5YjRWT0xOYTQ4dCtq?=
 =?utf-8?B?WlJlREpvay9nOGFUdjVKdG9uVXZVYlZlNXZuNHozMlZFeTJDN2dmMUxyZ0pT?=
 =?utf-8?B?L3hWcjU4VlM0QXFPWUZHSFYxRitybEhOSTZuTDVlRFlJOUo5MFlUQ2NmTWZS?=
 =?utf-8?B?V0RmVXA0czJNSXBTaERjbjVyZ1VNd0ZtL2pLWnJSQnAwcWxJbFRPUFdMK3Ez?=
 =?utf-8?B?bC9pUVdVTllmd2lXYndwR1ovN2dRRWRoRlgvZjZjWVNwMCtPMmphS0t5bFkw?=
 =?utf-8?B?Y092eWM4VGRQU1V5THVSclJEUTg5S2szanliRGhKUytYOVRFanhUd0RvOFV6?=
 =?utf-8?B?Ni9YTEwrVitwSk1pZm9OdlhRUHk1aXZ0V292QWw4MDlZS2JxNG5QcU1JR1Np?=
 =?utf-8?B?N3VTUndLbGEzeGplRUhJS1pzR1kyL29pcHo2ZjNyM29FREEyNnZtRThKaVo3?=
 =?utf-8?B?NDQzbDZEbGtEOGFSUmNWcE1vU1lWQmdzTjNjWG81MWUwdkNyM2dIQXh2T3lO?=
 =?utf-8?Q?doG3HkwQf81XYJgJGLCyCMaXcXIDEzFenrJFSExOUC6LR?=
x-ms-exchange-antispam-messagedata-1: 4At7+iYg9oa8Hw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD8D1026B698DD47B467F9B213D54244@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb24241-5a6c-4147-1479-08da2254a679
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 22:33:39.0803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftmGpAlBWu3l9ezxtOaaP7r51noI9BxPdbL+8zu9KLaUfnqUqzBxJwUw37YE5xPvLirEJQEvHDWN7HEXtFxOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOC8yMiAyMzozMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFJlbW92ZSB0aGUg
aXJyZWxldmFudCBjaGFuZ2Vsb2dzIGFuZCB0b2RvIG5vdGVzIGFuZCBqdXN0IGxlYXZlIHRoZSBT
UERYDQo+IG1hcmtlciBhbmQgdGhlIGNvcHlyaWdodCBub3RpY2UuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=
