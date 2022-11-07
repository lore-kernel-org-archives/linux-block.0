Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F4C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKGFoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiKGFoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:44:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4DB4A1;
        Sun,  6 Nov 2022 21:44:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqfXSqkyOQZc67pAbIGH3w8graV5tzwA1EZx0W/IBCyv2QhEZMX9AbyORslDWj+rCyY+kNSnMISz3j4StPf+GANFZHItEYKudauy6+4XrknazUJ6WLAGsi+iR3vHdUjfbQrCUeksZqF3rU1sA98SNE2xkRTHDsJBt4GphRlVgRs8v6JZ+KEv3VcakNzMGBkzPeTHCWLNRwlFqQ/eUXgYcD5FUMrFByYFBFEN0cR9ydqiffqHnoL8iWogdVfbkKWGoayX7V0mCWe/0VnCIKjAPq77XleCjkJgwunXlYAu2WrPWnULV0Jye1kAECmvnDHUOxLm1Pyh1VwXdQJaph6BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/xAGveqzJUAIX8sKb7vXm1jOfvwYXjr3JcIja+0IoQ=;
 b=Rwh5NYlniBlHhKlWR+zOJ3CDynMDqDkLeu3tKsDSOdDLOWhNomWWDvIMAVqZWzbcJLnKq4uvcq0qUE5QZwozd6+F3zYoMtV+w1CFXyYWPqzS7lxLR1adfct6x6usSI0W81okD+hydn+n4o7nzGJfEm78lxFAsPDL3mdZEldHtYX0PGMmWxgRbXagRh8elQL7zjnrmBbcT77ShbdRcokgTrr8dslThJQEAaJO0sh+Nz97Ydx7eSLsGC1LSUiDdkocWqQkM9rHbVNtjv4SV2y3+//s3Mk9mm07BnXcD8vvYi5JuSLzppam7GTh1NYypQFzcvkQD/wPWxv3ESVKsbtOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/xAGveqzJUAIX8sKb7vXm1jOfvwYXjr3JcIja+0IoQ=;
 b=NARdBfElaNd3DIhsn270E2t2LNMW7QF9K8XmfuRsvTFZuDrpzvJP54BwYFJ1K3/TaDjhhWbuJ2K7oD4EE+VKa1vFWD/U1PKw8m0EiXPBBfaka3fGoHSkRfQWoDXxJpaXnNsr5zX984vQTjG10bLhj19Is9QA/VQbDAp2PF4CY+oS9wTMuCnZ6oZyX4bFr42ubVaGimuDWVY76BrZQh5NSBYdyrboDbPfmlmWKSKAVGcxnqADzanGSiIQVgxaeKSd7qoKId7sLjMu1oMdJKj/oc/etfSx9Tg6xfV2HzYljHy37t4ZVBv8GIMzURJ40DK52boZWGJVRDG8jfgi99DhhQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 05:44:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:44:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 4/7] ata: libata: cleanup fua support detection
Thread-Topic: [PATCH v5 4/7] ata: libata: cleanup fua support detection
Thread-Index: AQHY8kL0YEb+/TQ+Pk+cqF5tAA97+q4y83KA
Date:   Mon, 7 Nov 2022 05:44:20 +0000
Message-ID: <c9abd10e-c1fc-a111-f2fa-c5d39ceb03f4@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-5-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4468:EE_
x-ms-office365-filtering-correlation-id: ca1a6fa8-2c3a-449b-9fcd-08dac0831e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IXG+/pLE3mr5i8TYZPaBjiWqyGR6CMAA0+vdMt4J2bNh5nz+WtQEbg4ArsEAgdKQQODVqsb6mBnaW9iB3h+J3jbmuYLaAexdsV/T26CcJlkZt1D9wR3G36UZspJeqgXtKRJJL2Hxa1+p8xmNAiJnLQhVm/qxwREearJwLF1BB6eyeVTS3vERI4y59v9XHe2d4muCw521s9bE9zdbRDUE6vU28NcD++T/JRGVUE8r06yDzOD8vGQAzUkp8cHa70F4jZwJ2I3VY5ozbn0zqItYSi7hduB7bYi0bYiKLnGImV2VbvLB5SBroK0U5/pHoVMEaOt++4K597wayFDaNAwRxyfrQBKoKNWtRlTHZvJW22ypgs2DydSB7ynB/XU8+qURbCK5BjRg/dzpa/iZmiUeNXbiWaa6Vfj5Xicfd5o9cu63UPwE6DaUG2BFWi7MZQ4/CALXlcXfHaeWXvNqyP+hWWcAakGaYAErJ6BdksUBJjjtmRWdno88k4wznzq7Ne1qpbwuZuvVypKqtlsQbcoz5WqGEp1RTEjofQQg8qFXIvYINdcky0sv6yMFvR4Hvv8ELVBv1yLVx/M2SB7WURWtmar9gTfOot1jLqZtgjvnzQBjeVgqL3rpDLVHYPpBojasa9Kh/S7jthzBEh/TgSclssgAGmuSTtvL9oVRDvZBV9QuhLm3Lt8jntkuTtYgis9H3IMZJ8AxyqlLAqRW1+UeZPg2t+5rTAzWGjH2Qkp3JdaTcoUepttNVh2B98odd+T3d2bBCLimQZ6U6Me++8V/FjZqTYxErEt3kuHA4hjqq24lnG/ZLaFzCseuO2GNQJkOI2oNrJu6EZ2AjSdpfq+VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(2616005)(186003)(6512007)(38100700002)(6506007)(122000001)(53546011)(83380400001)(2906002)(110136005)(316002)(54906003)(478600001)(71200400001)(6486002)(41300700001)(5660300002)(8936002)(91956017)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(36756003)(38070700005)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUYzQUhPUE5aV2xhakl3bi9ZUmlzLzQ0VWdWdUJDRUVtVFllM01TZHlTZENh?=
 =?utf-8?B?S2FPQWlSOXp1OUhQSjI0Nlh5WFViMmlhL1ZTNWlvaDhhcFZ6aE9kTE0wbW4r?=
 =?utf-8?B?VDJqN2hBaEt1aXIrM0gwbUlGdFR4cStOemJjWDR6cUFuZk5nd2hkbnBaRVd2?=
 =?utf-8?B?UUpGVWx2T0RyZGp6ai83dzZBYzVSa0lhRjJsYmVpWTdOUjVNaXRxNUdMSVBG?=
 =?utf-8?B?cDl1bjUzQ3FTaFUwM2Vka0ZLNFkyWHpBT2Q2MDB4bkx6MkprSzI0a0V2VXRy?=
 =?utf-8?B?bkNDaHZ4KzVoSTJJSVJTMEYxZytYNUtEeFFYbUtTREZ6VXFzMFBUUk41UkR1?=
 =?utf-8?B?dXV5K1BrbUlnbGIwUEloUlQzYy9CVDIwUVhQbW01NDJWd1RWMzlNbURyV3Rs?=
 =?utf-8?B?Q0VkUkdZNGtwNlZ1N0xNNXpYRDJOZ2o1cklld1J5MnU3dUlOUlRNNFZGamdl?=
 =?utf-8?B?KzhRV2ZVMTM4TWlydFNzV1JnaHBvUGdER3kycDJ6TjZoamx3dDhYejA4R2dw?=
 =?utf-8?B?ZmZib0t1dzJUYS85Z21CUVl0dW0rRndnRGhUc09IVXJ3UFlaYmpHRDFUSHZ5?=
 =?utf-8?B?VWYvY0xuZHI0NHVZcytPV3p2N0g0SUdZZWpITWtHb2tpdnJYZkZGSFNES1BQ?=
 =?utf-8?B?Z2tLOFZSYWdIM0taK1dhNTd2RTAxREFzSCsraXFNS2QyV0NJMlA1d0lFSVJ4?=
 =?utf-8?B?T2FtOVovZ2hObFlhSjE2NUk2VHJ4UEVDU3lTRUlrQTZKYWlBOW9pZjJSZ1N1?=
 =?utf-8?B?V3QvakdkRUJOKzFnNC9VWjVScEE3Qlh0T2gxa0VkcFJlWG1pbDhwd0ZwcFE4?=
 =?utf-8?B?VUk1MFBZcUJ1NkVkd1pZV2hpZkZuLyt0RmtvZ3IzODlnc1oySXdWSk5aY0F5?=
 =?utf-8?B?cVFCL3EvS0RTSzExRmR2a25YNHVvb2pzbldoMWRnN3p1ekY1SllWMkx4TWd6?=
 =?utf-8?B?RFBjclMxYytwQ1FhcXBVdnQwQk42SEl3UkRoQTFaeExZanBVNlk2NENnN0lH?=
 =?utf-8?B?KzFLT3UrUTVuMWhOVWtENjNHbVZWTERoODdEYXh6T292aDU2V3dua3ArbUNj?=
 =?utf-8?B?aUl0MzJYdHhObDdSdVBBSjJ1eHBUSFVOM0UxRWVHaHM1UnJaRWxDaGhoanV1?=
 =?utf-8?B?U0h6bkdkTGROQjRQRjgzcmJUUVhwTzlpekdWcjFTcEVZQmtHcTlubVJnZnlT?=
 =?utf-8?B?NzgvNU5CODI1ckdDZGpWZ2Q5K2E2OHJLMzRLS1FzWVpEdE9tVk92UDZMdVBQ?=
 =?utf-8?B?QUxxM2RDUVVEbmFPbVkwNkJnd1QxU0VyblZZeE02RG9aOUtXc0E4UDJGSUJu?=
 =?utf-8?B?RVNMMVlyUDJxY0hiaitKK09MY2hydWpLMmV1UmN2K3gxZG9kZENYS09Udktv?=
 =?utf-8?B?L3lNelZTMDU1dDhiNWsrTHFPWENHWVVFalFUb25FQnZqRGhybHpPNTZXRWk5?=
 =?utf-8?B?bTgxTm40SkJEbmdJTTlPN1FxTENjU29jWjkwalpzb0ZiZmNjMzBXTHBDS0ta?=
 =?utf-8?B?dXdqa1hOeVBkY251QUpDUVJIeHhqaWFkNjNrMDdnSFhWN0RzOTZ4aXVYQ1ZV?=
 =?utf-8?B?Z3UvaFg2MGNWbnB5eDNLWHczeFMya2l4enlxYXN0WUJkTXlxSC9aSHFDakR2?=
 =?utf-8?B?Q1dqVnU5eFVJQ0I0Q3JLSDZCOTYxZFdFa1NZZmRiRXY5TzdUSi81eWVHMWZB?=
 =?utf-8?B?b3oxSGFQemhFUVh2akZObStkdUpRSUNQOTlzcGR0ZFhmWnpScFh0eEsrWk03?=
 =?utf-8?B?N3pzaUVNWmljQzhiYUNmanIxNXE1N2wvM1hCa3RzQUNQQWZUdWptR0FqaUQr?=
 =?utf-8?B?UG9hVnYrREVuMkd1TDhPc2ZUTTFVdkYyOFd6V3gwNE9EYUsxNWovQUhIaEc1?=
 =?utf-8?B?b1BHWVRZU0ZOellKRGsvMkVpYUtEbjhyQlFTUitKZjFHVmJCdTB1YUg2NmE4?=
 =?utf-8?B?aTkvQnAwZjg5WU4rbWxTTnBwdURJL0VxMDhYWWdhNTUxVFhXajBTZUxYUDBn?=
 =?utf-8?B?dFpWeGRJVyt6OGM2aXdvUndyQ0JMOGQvWDJPOTNrNDBEV2FNQ3lDcUxHQlVh?=
 =?utf-8?B?SlhNTVl3VlM1K01MMTN6d3d6OGEzSFJXcjd0dVIvM2RjMk95aGFGWU5EVjhX?=
 =?utf-8?B?WkF3c1dQVVNvRDdFRmZEV3FKUktZS3B6VGdzK0NpR01sNVZ0RkxFaTFIayt5?=
 =?utf-8?Q?L2lwoTi6v9+mL5LGkxW6ivRSYcAEBgZdNjLiasMPcgJj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F75A0CF93516B04AADE6F7D00555CDC6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1a6fa8-2c3a-449b-9fcd-08dac0831e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:44:20.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MK8G+DEknRi93JETBHk/OHoO7LJOCXF236vh2WcV+EL/1/Ry46catV/tUQ5yoe1Bj8vks6EokEFqL5ViUaPwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBNb3ZlIHRoZSBk
ZXRlY3Rpb24gb2YgYSBkZXZpY2UgRlVBIHN1cHBvcnQgZnJvbQ0KPiBhdGFfc2NzaW9wX21vZGVf
c2Vuc2UoKS9hdGFfZGV2X3N1cHBvcnRzX2Z1YSgpIHRvIGRldmljZSBzY2FuIHRpbWUgaW4NCj4g
YXRhX2Rldl9jb25maWd1cmUoKS4NCj4gDQo+IFRoZSBmdW5jdGlvbiBhdGFfZGV2X2NvbmZpZ19m
dWEoKSBpcyBpbnRyb2R1Y2VkIHRvIGRldGVjdCBpZiBhIGRldmljZQ0KPiBzdXBwb3J0cyBGVUEg
YW5kIHRoaXMgc3VwcG9ydCBpcyBpbmRpY2F0ZWQgdXNpbmcgdGhlIG5ldyBkZXZpY2UgZmxhZw0K
PiBBVEFfREZMQUdfRlVBLg0KPiANCj4gSW4gb3JkZXIgdG8gYmxhY2tsaXN0IGtub3duIGJ1Z2d5
IGRldmljZXMsIHRoZSBob3JrYWdlIGZsYWcNCj4gQVRBX0hPUktBR0VfTk9fRlVBIGlzIGludHJv
ZHVjZWQuIFNpbWlsYXJseSB0byBvdGhlciBob3JrYWdlIGZsYWdzLCB0aGUNCj4gbGliYXRhLmZv
cmNlPSBhcmd1bWVudHMgImZ1YSIgYW5kICJub2Z1YSIgYXJlIGFsc28gaW50cm9kdWNlZCB0byBh
bGxvdw0KPiBhIHVzZXIgdG8gY29udHJvbCB0aGlzIGhvcmthZ2UgZmxhZyB0aHJvdWdoIHRoZSAi
Zm9yY2UiIGxpYmF0YQ0KPiBtb2R1bGUgcGFyYW1ldGVyLg0KPiANCj4gVGhlIEFUQV9ERkxBR19G
VUEgZGV2aWNlIGZsYWcgaXMgc2V0IG9ubHkgYW5kIG9ubHkgaWYgYWxsIHRoZSBmb2xsb3dpbmcN
Cj4gY29uZGl0aW9ucyBhcmUgbWV0Og0KPiAqIGxpYmF0YS5mdWEgbW9kdWxlIHBhcmFtZXRlciBp
cyBzZXQgdG8gMQ0KPiAqIFRoZSBkZXZpY2Ugc3VwcG9ydHMgdGhlIFdSSVRFIERNQSBGVUEgRVhU
IGNvbW1hbmQsDQo+ICogVGhlIGRldmljZSBpcyBub3QgbWFya2VkIHdpdGggdGhlIEFUQV9IT1JL
QUdFX05PX0ZVQSBmbGFnLCBlaXRoZXIgZnJvbQ0KPiAgICB0aGUgYmxhY2tsaXN0IG9yIHNldCBi
eSB0aGUgdXNlciB3aXRoIGxpYmF0YS5mb3JjZT1ub2Z1YQ0KPiAqIFRoZSBkZXZpY2Ugc3VwcG9y
dHMgTkNRICh3aGlsZSB0aGlzIGlzIG5vdCBtYW5kYXRlZCBieSB0aGUgc3RhbmRhcmRzLA0KPiAg
ICB0aGlzIHJlc3RyaWN0aW9uIGlzIGludHJvZHVjZWQgdG8gYXZvaWQgcHJvYmxlbXMgd2l0aCBv
bGRlciBub24tTkNRDQo+ICAgIGRldmljZXMpLg0KPiANCj4gRW5hYmxpbmcgb3IgZGlhYmxpbmcg
bGliYXRhIEZVQSBzdXBwb3J0IGZvciBhbGwgZGV2aWNlcyBjYW4gbm93IGFsc28gYmUNCj4gZG9u
ZSB1c2luZyB0aGUgImZvcmNlPVtub11mdWEiIG1vZHVsZSBwYXJhbWV0ZXIgd2hlbiBsaWJhdGEu
ZnVhIGlzIHNldA0KPiB0byAxLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwg
PGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPg0KPiBSZXZpZXdlZC1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
