Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F5FA373F
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 01:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJYBTv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiJYBTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 21:19:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88365586
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 17:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5XmkJ4lKeakjqOT3N8PZeF6YO7wBal20g1vkdvvsvzdgoXxtzDFNCUAzZGxJY0bal2PA5E4fdKJ1cgUULdyYHRhxK0CbCCv1TyBqLd6ydp0TQF7TXxB6N6l0VjoLOGO0x+Jg1x0no7nYauwxIeQi57KPjjVH7qUjoZgRHhoSSN8an0zpSBEyBeH2ek7fSuz5O+A9lceNRFHQHBCK6rBGNdAWRUX1661ke6+3K/nYA66rOI1FPTJ1GchVcDQ0ZmWrw/atWilBT9FCjZhPTjbcaMp0IJ10MyPag3hLh3LYuHnq26lN6pjXuCd+loRpihQWoign52+Gs/JS06dMPecVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLWRqaxy06fezX/A/3S34RVXleKTbevwabTqT9LT2Gs=;
 b=jXxkmCIOoxmUXUQm0a4ecmkfYgJ9YJ5JqmtyKo9N+qzPEAC3ssNBRp7jwv/e5WHxud7tvPyfAplAyQ1UtppIWUq1i6wHkCCJeAKBbMcdaYi8vOrXmnEKmVYSw+4rRy7QyQd7+1EuQ7XipvUALNoRcTTL/yIfDg2QFWoLfMawJ4qpizduHVffl5hvimWl5WgHVydSlxFgZ9DsZHOSy1p5cUBDI7wg/s58pP2RyogrS6G5KIxLngOuVsXJkDfRONWdDtnS5TncCOT7f/u3b2XcxA0TgtQfXWCa53pOIREhTRxIv9JqCWvZ/PL6er1hoBdAMMPcb5zscxbs4yY8gspfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLWRqaxy06fezX/A/3S34RVXleKTbevwabTqT9LT2Gs=;
 b=AaFE0ZHdMqs1hgJvzxXhY3vTwo9wxWAz85pyW8ai7kfA+Q5+8Nx1OqN9GDEzdcRzmc4gjJX6I7NYxBfyXnZRu/cjObNBb/1bGJFciiKR0yfsZhMNBfTw/MEbSHJNcNdKCS+YJRSuDe5aRGjewcCMctwEDF1nPnd6GH2C/kk5NctmmnQ+m1EnEOS3X/OWLLn5bqKUyNKZ2beHYvSAqZ7AgIe+Mw2aVBcEO/1kdN0abCZWdKOhvEP5YaGATKPQjpVUpJHCcNtn7aVhtJkV/oRRl8ixXQG9whskVECMyAW2SR2dgmYIchMxHt880SXtWj2qZAqzzM2xxAYDESGSkvtdBA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 00:42:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:42:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yi Zhang <yi.zhang@redhat.com>
CC:     Eric Sandeen <sandeen@sandeen.net>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l60hl7Fc9KsUGQcUgAzbInn64VPZMAgACG/oCAAFOEAIACd3QAgADVjICAACWSgIAClmWAgACdFwCAAZAogA==
Date:   Tue, 25 Oct 2022 00:42:13 +0000
Message-ID: <be4f5e32-7a7f-7b83-b36f-eb3eb5b464b6@nvidia.com>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev>
 <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
 <20221021235656.fxl7k4x3zjbbaiul@shindev>
 <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
 <20221024005000.givqygw4jyjzjp7q@shindev>
In-Reply-To: <20221024005000.givqygw4jyjzjp7q@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6649:EE_
x-ms-office365-filtering-correlation-id: 96e82595-96be-4ef2-9a37-08dab621c243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLf/pr0hk9WH79BUFUpawp5Ma/MIDEG2d+RB2RNpeAXesWwLg5lGeXP2Z8Qb5Wvt5mKXjN2puHvGKMviY0DxrOG4hIM1HxclRX5XwrEq36yRrKedQ1wAk1QMjPB30lb2ExUR6PmUIynRQZ/vnhWJxqfSGRGfQD2OpXM9FfCgli/iuM4aaaG5a14h3Q9KCLLvedbiRfZ78h8kOmvAh9FrXv/iV1jSZU7bROQJ5p0Z7C57dBB9/WNh9mt1q7rVc7jqdb3/wjN7vPUtv5IgCPh8uKwvjo2LwLrDlRh88T1mLZBaCkQSURYP4pNRF+7A5NKxpUNuJKQOQISFFrrBmg4mTRCArOizg3Bk6M3sgqp0TAhca9lVxzVPrlCQjVtiO1coLsP7jNS9EoDJTbb8AgGEkyLq26w8nXvAJaB6O24xapEZQXCvdTMLKku3TUT12YroaALs7WqTnOjaggRqje4w9rd/gYHSDOzix6VzwHtaVf3nwdr7cYFkmrjuOOyDCxK2+Yda0TA/+8mIsRP2cZW36DuRnHF42otrOSrly8z0+XOChlb1k6gZd2FPb86w2nqquLBx20Pl4lscxg9h3QNc6M3kqBFhq8cZx4zkRtYxaLmQIRSd+jj2XrbZvs6Kp9QnOHDhcUcutV1i3Exw44F1IurJs+cYUODj8Z3uInyFOw3f6jFS4MBC38NBQX8SYwM5b2s3RXUhOAPumXUZ5CpR/JFGWOBvtD3bOo+0iC5q8F3xt87kGMbhcoq1IoyZR154YSHbBaVVxjwFSKQ5FHa/YiCA5dw+yHSDAHFCnwrGrdOFvZ6BZku22W9ayvBAEU5ewQHs3KGCgzNA09BW0lEp4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(66899015)(2906002)(31686004)(36756003)(38070700005)(110136005)(66556008)(66446008)(5660300002)(6512007)(8936002)(41300700001)(316002)(76116006)(66476007)(8676002)(4326008)(91956017)(66946007)(54906003)(64756008)(53546011)(6506007)(83380400001)(2616005)(31696002)(86362001)(38100700002)(6486002)(71200400001)(122000001)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkVkemtGV1pWVVdJaEpXRmpJMkdmUmZ1KzNaL0RMRVM3ckhJMWJjY1kyanFm?=
 =?utf-8?B?MGZSclhwN0MvTkpjblJOeHg0SE9wa1EwSFpUcVJvOEJtRXo3UzhTY0t0TW1a?=
 =?utf-8?B?YWlDR2RDYzAwMlZ2alAzYVYyWUdGQXA0QzcwV1VoblZ3RnBCMG1ML1prdHow?=
 =?utf-8?B?WkQzRTFFbEl4UnVMeWhWd1VRMnltVXd0V25SUTYvbHVncElwQ3l4OG9Ed3Jw?=
 =?utf-8?B?dkZHbFd0cFgvVTFrb2VFVkJCYk1HVmVEbC9aVW54eDFXdzR3K0trYmdFMnJh?=
 =?utf-8?B?MGhmdzlwZWZ2MFVYZ3FxUDJvQWtiWVNJNkhLaCt5ZUJRTG83N1U3MytCQ2Y1?=
 =?utf-8?B?YkhSeTZzVE85N2krTU84TlY3OW5JL08zZ2hSdXd0QjNtQktSZmZzN0ovYmJB?=
 =?utf-8?B?UDFqNTBJUXlaU2NabGdyS0VZMWxFeWx3R3JaV2lmUGlPRmlKNU4vSXJoVy9U?=
 =?utf-8?B?YkJ1NlcwcWdmNHQrRVdFblRFY0kybzlQTUhXczlYZUlqTy9MNnlqTjRKaDAy?=
 =?utf-8?B?S01CemJKdWVCWndncGg1S0c5S0pGM1ZRRmVHMUIyYklidWZPdlFMVzFnM1lq?=
 =?utf-8?B?dUoxelM0S1N2MHBwalBMMHM5dHZVbGpRWXV3OWN0WUYwelM5S1hma2p1V3JF?=
 =?utf-8?B?bHU5K0tvcFlSS0JZWlZVS2NBemlSMWoxNmZjQnhYSk1hNi9VRFkxTHc4VVdt?=
 =?utf-8?B?WjZDZnA2ck01aWVheGNpWXFtWmF3YzJzcU9oZ09hSzBMNk5nRUJjTHdJWVBr?=
 =?utf-8?B?OFYvYnZacnFkbFcwMTZFbS9rMDgxRWd1d3Y0eUM1T2RqeXdkc2ttSld6d0hh?=
 =?utf-8?B?dmhOMWhoMk1JSGdKdXBQbjVsdzhjL1F4SDZodlRNY2pzT2hGeE1sZzNPcHl5?=
 =?utf-8?B?NzI4cVFSMktLMG91WUtvcWU3Y044WW5sRFdrbG1wL1NYUGkrODlkQjE2MXBO?=
 =?utf-8?B?L2VEYnVra2lWR1JrNjhzR29Xd0ZITXZPS3J0UmN6QTJYWWJPQ3UvOVJhUUx2?=
 =?utf-8?B?ZHBhK0dvRXVUSnp1YTdISW5pSHQyaThsOHpQamVlTWk3NTlZd2ZWMTZtd1dw?=
 =?utf-8?B?YlYzeXFUTVV6ZXQrZkJweWVISEdiYUFVcGNESWlvMkhqVnpLaTc0RzFsVEJ1?=
 =?utf-8?B?SmxkYnNUbzJMU24vTWxvV0JJSVIvSnQvVUZMU0pxNUFuUEFwQllPaTFwRWsy?=
 =?utf-8?B?WXljaEp3QVR6ZVNKNnU1WUxrY2JvUmlrK1NLVnZ0TzJobXRpNHk2Z3IzL1ov?=
 =?utf-8?B?N2JZK3U0eW1pemt5UnhKcVJVMHh1bUVEQTQ1eUZaL2V4T1VhUmQ3SVVGdFo3?=
 =?utf-8?B?WTBFbTBhUk5KU3BxQWVzenNJd0FMdEtSdHF0bHM0VERFV0VXMHZmOWR2TEdR?=
 =?utf-8?B?RzVQNjlPSVBpY2hEQklmY2RFMGRhK1VEQ1VjcnZJdXZIbEJsTHNvekptMXNk?=
 =?utf-8?B?dU95K2lYMVFUOGpObnMxdzRQcnRzcDdNSmNvdUpHTFI2K3lzVlAwZURrT1Zp?=
 =?utf-8?B?MWVzWTF5clk1Y1FBTHBoZXZWaXhkYnIwS3lpemxSU255ZG5PcW41V3J4cU5U?=
 =?utf-8?B?aUdhWVY4bEV6eEFyNU16blR6NHFkVXFWUit3Q2dRZWZKMFIvbmdSRy9kZ0w3?=
 =?utf-8?B?TVNuc3B5aXFqN0Z1SnlmNkRVRFFENTR6Rm9iNDZxNDRzdTNRVHhvbzBQR3Qz?=
 =?utf-8?B?c3JnbXNoMUdVL3cyTGYvUVRvRXlpc2JnWGM0Y011OE9QL2pXVXhYNHJaVWoy?=
 =?utf-8?B?eThndzRBMnNqRFJTbGwzaG1Ob3hhZTFPYWZpWnpBam54U2k4ZW45Z2JsZjRC?=
 =?utf-8?B?QXRMOFNlRzJSSTFRd0laZGhET0FOS3NaYjF5YTV2WWliVUpubkZoeFM2c21s?=
 =?utf-8?B?OWMzLzFURE5VelU1V3EwM052MTdxT0hsb3ZnOGpHcHRLVXdTWEh4VFZwOEky?=
 =?utf-8?B?RjNSSnJYek9ZMjVTMGxCeUpFQjgwN2dRbHNML3lKa29JU1JIaDZibUJJK01Q?=
 =?utf-8?B?S2hIbU44ZjY2eWJ5UHdhMVBoU0ZVdWZEV2JPclFPdG5HaC8ycWtSVEtPTjY2?=
 =?utf-8?B?WG5iRUlLVDBKRkJHUmZiaEdxSFM3WXpCZzZ2UEdNMnRWK2E2bUptM2M5V2c3?=
 =?utf-8?B?UEordFk1VGxucm1DRDNaVFVKM0pCVTF1dEVjWUFKK3JIZEhKYWFIQ015ZDNn?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAE5B2E82E2A3B40841F51609E44F2AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e82595-96be-4ef2-9a37-08dab621c243
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:42:13.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAHkw6FMgC+naTkWsZglL6+9uF1MFIdbXhwv+ZmiqHPij4364VJzxJjhk8PUteUioF8+9Z8isf9F43GxLIFc0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

U2hpbmljaGlyby9ZaSwNCg0KT24gMTAvMjMvMjIgMTc6NTAsIFNoaW5pY2hpcm8gS2F3YXNha2kg
d3JvdGU6DQo+IE9uIE9jdCAyMywgMjAyMiAvIDIzOjI3LCBZaSBaaGFuZyB3cm90ZToNCj4+IE9u
IFNhdCwgT2N0IDIyLCAyMDIyIGF0IDc6NTcgQU0gU2hpbmljaGlybyBLYXdhc2FraQ0KPj4gPHNo
aW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBPbiBPY3QgMjEsIDIw
MjIgLyAyMTo0MiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+DQo+Pj4gLi4uDQo+Pj4N
Cj4+Pj4gSSB0aGluayBjcmVhdGluZyBhIG1pbmltYWwgc2V0dXAgaXMgYSBwYXJ0IG9mIHRoZSB0
ZXN0Y2FzZSBhbmQgd2Ugc2hvdWxkDQo+Pj4+IG5vdCBjaGFuZ2UgaXQsIHVubGVzcyB0aGVyZSBp
cyBhIGV4cGxpY2l0IHJlYXNvbiBmb3IgZG9pbmcgc28uDQo+Pj4NCj4+PiBJIHNlZSwgSSBmaW5k
IG5vIHJlYXNvbiB0byBjaGFuZ2UgdGhlICJtaW5pbWFsIGxvZyBzaXplIHBvbGljeSIuIExldCdz
IGdvIHdpdGgNCj4+PiA2NE1CIGxvZyBzaXplIHRvIGtlZXAgaXQuDQo+Pj4NCj4+PiBZaSwgd291
bGQgeW91IG1pbmQgcmVwb3N0aW5nIHYyIHdpdGggc2l6ZT02NG0/DQo+PiBTdXJlLCBhbmQgYmVm
b3JlIEkgcG9zdCBpdCwgSSB3YW50IHRvIGFzayBmb3Igc3VnZ2VzdGlvbnMgYWJvdXQgc29tZQ0K
Pj4gb3RoZXIgY29kZSBjaGFuZ2VzOg0KPj4NCj4+IEFmdGVyIHNldCBsb2cgc2l6ZSB3aXRoIDY0
TSwgSSBmb3VuZCBudm1lLzAxMiBudm1lLzAxMyB3aWxsIGJlDQo+PiBmYWlsZWRbMV0sIGFuZCB0
aGVyZSB3YXMgbm90IGVub3VnaCBzcGFjZSBmb3IgZmlvIHdpdGggc2l6ZT05NTBtDQo+PiB0ZXN0
aW5nLg0KPj4gRWl0aGVyIFsyXSBvciBbM10gd29ya3MsIHdoaWNoIG9uZSBkbyB5b3UgcHJlZmVy
LCBvciBkbyB5b3UgaGF2ZSBzb21lDQo+PiBvdGhlciBzdWdnZXN0aW9uIGZvciBpdD8gVGhhbmtz
Lg0KPiANCj4gVGhhbmsgeW91IGZvciB0ZXN0aW5nLiBJIGd1ZXNzIGZpbyBJL08gc2l6ZT05NTBt
IHdhcyBjaG9zZW4gc3VidHJhY3Rpbmcgc29tZQ0KPiBzdXBlciBibG9jayBhbmQgbG9nIHNpemUg
ZnJvbSAxR0IgTlZNRSBkZXZpY2Ugc2l6ZS4gTm93IHdlIGluY3JlYXNlIHRoZSBsb2cNCj4gc2l6
ZSwgdGhlbiB0aGUgSS9PIHNpemUgOTUwbSBpcyBsYXJnZXIgdGhhbiB0aGUgdXNhYmxlIHhmcyBz
aXplLCBwcm9iYWJseS4NCj4gDQo+IENoYWl0YW5pYSwgd2hhdCcgeW91ciB0aG91Z2h0IGFib3V0
IHRoZSBmaXggYXBwcm9hY2g/IFRvIGtlZXAgdGhlICJtaW5pbWFsIGxvZw0KPiBzaXplIHBvbGlj
eSIsIEkgZ3Vlc3MgdGhlIGFwcHJvYWNoIFszXSB0byByZWR1Y2UgZmlvIEkvTyBzaXplIHRvIDkw
MG0gaXMgbW9yZQ0KPiBhcHByb3ByaWF0ZSwgYnV0IHdvdWxkIGxpa2UgdG8gaGVhciB5b3VyIGlu
c2lnaHQuDQoNCkknbSBmaW5lIHdpdGggYWRqdXN0aW5nIHRoZSBzaXplIHRvIGl0IGNhbiBmaXQg
d2l0aCBuZXcgbWluaW11bSBsb2cNCnNpemVzLg0KDQo+IA0KPiANCj4gIEZyb20gWWkncyBvYnNl
cnZhdGlvbiwgSSBmb3VuZCBhIGNvdXBsZSBvZiBpbXByb3ZlbWVudCBvcHBvcnR1bml0aWVzIHdo
aWNoIGFyZQ0KPiBiZXlvbmQgc2NvcGUgb2YgdGhpcyBmaXguIEhlcmUgSSBub3RlIHRoZW0gYXMg
bWVtb3JhbmR1bSAocGF0Y2hlcyBhcmUgd2VsY29tZSA6KQ0KPiANCj4gMSkgQXNzdW1pbmcgbnZt
ZSBkZXZpY2Ugc2l6ZSAxR0IgZGVmaW5lIGluIG52bWUvMDEyIGFuZCBudm1lLzAxMyBoYXMgcmVs
YXRpb24gdG8NCj4gICAgIHRoZSBmaW8gSS9PIHNpemUgOTUwbSBkZWZpbmVkIGluIGNvbW1vbi94
ZnMsIHRoZXNlIHZhbHVlcyBzaG91bGQgYmUgZGVmaW5lZA0KPiAgICAgYXQgc2luZ2xlIHBsYWNl
LiBQcm9iYWJseSB3ZSBzaG91bGQgZGVmaW5lIGJvdGggaW4gbnZtZS8wMTIgYW5kIG52bWUvMDEz
Lg0KDQpBZ3JlZS4NCg0KPiANCj4gMikgVGhlIGZpbyBJL08gc2l6ZSA5NTBtIGlzIGRlZmluZWQg
aW4gX3hmc19ydW5fZmlvX3ZlcmlmeV9pbygpIHdoaWNoIGlzIGNhbGxlZA0KPiAgICAgZnJvbSBu
dm1lLzAzNS4gVGhlbiwgaXQgaXMgaW1wbGljaXRseSBhc3N1bWVkIHRoYXQgVEVTVF9ERVYgZm9y
IG52bWUvMDM1IGhhcw0KPiAgICAgc2l6ZSAxR0IgKG9yIGxhcmdlcikuIEkgZm91bmQgdGhhdCBu
dm1lLzAzNSBmYWlscyB3aXRoIDUxMk1CIG52bWUgZGV2aWNlLg0KPiAgICAgV2Ugc2hvdWxkIGZp
eCB0aGlzIGJ5IGNhbGN1bGF0aW5nIGZpbyBJL08gc2l6ZSBmcm9tIFRFU1RfREVWIHNpemUuIChP
cg0KPiAgICAgcmVxdWlyZSAxR0IgbnZtZSBkZXZpY2Ugc2l6ZSBmb3IgdGhlIHRlc3QgY2FzZS4p
DQo+IA0KDQpBbHNvLCBhZ3JlZSBvbiB0aGlzLg0KDQpBYm92ZSB0d28gbGlzdGVkIGZpeGVzIHNo
b3VsZCBiZSBkb25lIGFzIGEgcGFydCBvZiB0aGlzIGZpeCBvbmx5Lg0KDQpJJ2QgZXhwZWN0IHRv
IHNlZSBhIHBhdGNoIHNlcmllcyB0byBmaXggYWxsIHRoZSBpc3N1ZXMgbGlzdGVkIGFib3ZlLA0K
cGxlYXNlIENDIG1lIHNvIEkgY2FuIHJldmlldyB0aGlzIHdpdGggcHJpb3JpdHkuDQoNCi1jaw0K
DQo=
