Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4972C433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 08:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbiBDINz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 03:13:55 -0500
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:6377
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344149AbiBDINy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Feb 2022 03:13:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUDa7Z4Py0d6B7Cw6kIHV1kYsbpIt0pG/18nVBwTML12MMO+8oyQ67A9fTlhnDsgqfLX4YPLuNFsbsks1SKidyifecny/155O26lIBFbHnC8sFe1+WSOnMDAlW3brJrk8XfxUHAh2/sQQkvHRRkdv8CyTZbT0C/JGCVip+9j+oYjWj8AJYGbwMViNR3F0F8taDvIZbMJfcvG44jQ5HK3FGPhrUGa3Yu/Jp6XkSUFwXmaBOr62xyWx5q4fee/kwE1njgLNCC+XnjwMLXolbwGDbhD8PN1Eqv9QwqpRvW/EloxfbZDtZDCHCxfdedmE9DBta2+JXnwd+vOfHFmby9d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pjjRIA/Ys4Ha/buEdRmR7ttTNjOaW9AoUvI2q0oEh4=;
 b=aBoGBXkvRv6mWpCgVvY1Jkd7EPV6b1vEE8ZyogVuI+bMyiuUfWHOv0ju/6pXHx2RmceA6fRKZGp9KBpXC1GFH7LYx3F61JAZWbR/SBaToMb7dfijckowmuLa/yf0HKQu9kbVnh7tDpecmEQ4i7ypi71+Z0PhJzMe7QrCA91V6igCEjcTpM6LFl2fvfblnD805x0DhvlhI3yoKLqGyOBWp8nlIrhOW6Sh6Ccvv5RuD9t5WrrQykdPb9Zh0jcsmBL/EAMCimi4riWCDp7ct2beVYjaQYP+59KaJY210jZe1i51Y/ghKmKaRYFWSxKu/PEpJUqmY06t06mWdhu0Dh/X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pjjRIA/Ys4Ha/buEdRmR7ttTNjOaW9AoUvI2q0oEh4=;
 b=SF/YOfCBn6QZtkxERQ9Ixfu+wCcOgupvKDPSWZx9z5hLy8cehOdMfy7dHLnIGz2Gu77dTlJ90Epj6SCOYTGEzT5eRZcv6L0kg43wPdh6+hLo18boLFIZQudOaBSJ961bBcoavuumKq+2whLLxSjAaUWHEZ6mRcPYMh35Bl6DYSnl3PSRDH/LFPL8aRjBZGU+I6Zjx0N1/hiBc25ujQt7J2TEbT5aN9haPH9R/3zAduZ/rOY18YYDgzP6AVxU+7Xa0rwjf9jKpO5VCNf1Tw5SxJD+w9RqPH6lBzXzHq3A5zjDCEgmSvztDva2p4vVcbITMr1a5ffkpyTkVlBH6pBRhg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:13:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 08:13:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com" 
        <syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com>
Subject: Re: [PATCH] block: call bio_associate_blkg from bio_reset
Thread-Topic: [PATCH] block: call bio_associate_blkg from bio_reset
Thread-Index: AQHYGZeUytTRR2ku7EOkgGIuxe8Pa6yDCxmA
Date:   Fri, 4 Feb 2022 08:13:52 +0000
Message-ID: <fadfe7ca-f4f2-6d01-0be3-07406549fff9@nvidia.com>
References: <20220204071934.168469-1-hch@lst.de>
In-Reply-To: <20220204071934.168469-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e19fb08d-b0a8-4939-3c7c-08d9e7b647c9
x-ms-traffictypediagnostic: MWHPR12MB1326:EE_
x-microsoft-antispam-prvs: <MWHPR12MB13268DC99062BB0B0AEE4B5CA3299@MWHPR12MB1326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEys1Nq9LM2FVATUxu9Zjmr7P7PoWKifnuK1s1MzcGNas4VUIf7Cwp+0Nk5Bgn/VNTkEF/DjrbjxLm2bJWwGOR9pxvq6MQ+RN7R1wwvfuPqeOgikW2izhXpFkl1u7SYBXifaznutMONrqn7cPBAfYLmIlhRApLoUWfwlCeD6jzV1mw/e5w2UqZ6HF/pgYt0t6rm9eeh3GQDL8VFa8XMLQQoAMrZyaR7HuDpkbGS83Ulcp+UkZVJAUus60UB1B3Bc6EockKba4CINlKZ5Ju24F3Z/UZfQckQKLHIhB1CyfoXgBszCvkWzmceLPaq3EwXXYXNfNf4XHp3cDkVuCqCjLcQAQta9sxrsb4IOVUCnt/A1PAmxN7ItnroJ3lEH1uxdZIVbDmQba3zx8lUPqgQk8VNgJQ2K5mTnapzZHK1edSjJR8JI8nkAza70T1Cc5rFfdpZJfrHlPC5wXQU4PGdDa8ElNno7jnPbo1Wja23P77FV61oVE0zio3UBKwIJmvMsS/crM42jw64BTTCOMtSxQt/hb9+l7z8iLh4hqvVhRsxBx6b+xZCBk944W+zQba7uIcAGMyFuUUnHwHs4MMBLfq6UKQxyvnwQQvl+nKbuAy8gPqEw64VtW0Di5ieoQHYYrttnKPT/R2Rp0QxGHiuPJGfOp60Di3VAB7KjRkxuH7dXZAgs3nNWOVyy2ONqi2mdFdGWsxIDEyJtvc399pErAQ+n5vpnOQHfn7X89wrzm4r5Jxiny4+iSWgBrI2QTaqaBU6/pP6f1V+MWpj7TN6sPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(122000001)(5660300002)(83380400001)(6506007)(71200400001)(38070700005)(186003)(36756003)(38100700002)(4744005)(31686004)(2616005)(66946007)(66556008)(76116006)(66476007)(4326008)(66446008)(54906003)(64756008)(8936002)(8676002)(110136005)(91956017)(6512007)(2906002)(508600001)(86362001)(6486002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlBQWk1VEg2bWtnTno4T3RnUmVkZC9tbmJYUXpxT1RIRDRxYTF0bGxLMDlH?=
 =?utf-8?B?SnR4ZnVLdmxYU3M1QTJ6aDI4ZmtwbzNzQkJEakRSanpOZFJiUFBXdjNlWXEx?=
 =?utf-8?B?S0tWRGorV3c0bXE5M0o5VG1aYnFsUlBhYzczSDU5S1UzSng5K3dZbVdIZkRY?=
 =?utf-8?B?UEh4KzZtSUpJckxMU0duWjQ5T3NUUVlWejBlYmhPejJPRWl2ekhhR2xhaWR0?=
 =?utf-8?B?TjFxZjZSYXk3OGJFL0tQWVNIOGpwOGhPQVczQnVHRGJadXJaTllOcjM5V2Fk?=
 =?utf-8?B?RStFZy90TDhVM2E1WVFIWllVZTJubytWRmJjU012cjc3MnVxQUtLS0hvR3Y4?=
 =?utf-8?B?TWRTaGIyQXZGdzJQbXVXK0V4enUwNXFFOWNlRFg3Z0sxdy9mMHg5Vm94V05F?=
 =?utf-8?B?YU8xd3dKZHpTbHJzRjlKTUZlTGJ0d21nZEk2LzMzUlNJdit5L1czalFQWWVU?=
 =?utf-8?B?elV3SlA0UzAybkU1MTNpV2FRNzdqYklOMWNrbVJBRWIyalZrbHIwTHZVZDR3?=
 =?utf-8?B?OGxyZ3NUaFVYaDVvZDZ2R3ExamxuWXFzZXFlOEZtbVBuWE9ZWXYxaW1KT1Ew?=
 =?utf-8?B?ajlxai8rMGthOG9rK3l3TFU0V28zQktuZlY5VThsaDNET1o2QW9NOUxXcVBF?=
 =?utf-8?B?cW9xajEvYU5lQkFnbkZiUHRQdzJWSGJqbEdVU3Z5RU9mMVZCbXY4RVNZNXNO?=
 =?utf-8?B?NDBZcmhNTG5LRk5TQW9YRSt0UGdoeU5tdWI2Z2hTQldlMU94dEhMbWdxZCsz?=
 =?utf-8?B?eUJGNVYwSm1HWkNNTXpqVUpoTXhRUVdFL1dET2tRNmo0MEhEcGhIVVJJMm94?=
 =?utf-8?B?WmxGckl5VS9yZDhoZDE3WTlFcmdSbk1kNThiQndRazJGMWtQOHpBU3BCVlB2?=
 =?utf-8?B?dVRCTG5PZEpTTHEvdGNJV0J6SllDOXJVZnJ1UWtqQ1pQdFNyU2g3OEMxdXBp?=
 =?utf-8?B?bEhjNDRBZWxOb05mQlFOTkRPbkFOcUU3Tkd6aUkyT0xpNWNOWmZpUEVQOWhj?=
 =?utf-8?B?OVJqbE10TnVVTXppbURjQUFCMktkZG9HaEd2U1BVNkRPa2YvVjVDdEFHME9t?=
 =?utf-8?B?QVFhanBQUWw4NTI4aDRMenBVM01ELzQyVGpmVmE5RkpBZFovbURxZWxlOWc5?=
 =?utf-8?B?MVdMQ2NFM2RocXhoRW15ZGNzQTVWY0lhdHVLY1hSVnZPVUdkTTJCS3dTblhy?=
 =?utf-8?B?aXhMRjByY2F6Q0NsT0ROcm5ZenF5ZFdmODMzUzM5dFU4TzRBTGIwYVpYZUEw?=
 =?utf-8?B?TXI5K1I5bGR2aDhEN1lub0R3TERGalkweGFnYjE1UlZDb3R1RXRreTJlV2V3?=
 =?utf-8?B?WTBKL2ZBNUt3UXErZmxzM2xJZHFFakdKbmZ4TTRQV2tWdmRxTm4xRW9MQUFx?=
 =?utf-8?B?SFk3THg2bCtGUzlGYVhGVnVLMjZzRk4zMmkzSG1BMTdJTElINm1VNk5vNEVi?=
 =?utf-8?B?VFNmMmRmNjRqZFR2M2l4N1orL3FHbHg3OVdwMnVBRHBrRDZoWkp4bi95ZDFm?=
 =?utf-8?B?NUtvTlhVcGRhVWVrR1hvYkZtRUVxZDk3VjdRd3FNVzd5Mmd6ZWJ0b2lxcjlt?=
 =?utf-8?B?NCtYL2VCL25kWTNKZ3hocXAxTitkVXRGTDFjcHdqc1VnRWhRTDdMd1dZOEFV?=
 =?utf-8?B?cXZvTEJOWVo2bW9JNTJaVkJtZUJ2eXJCWHRUNGZyV1lmSTZrVFpOY2lSc1po?=
 =?utf-8?B?dCs4WCtZNHpCZDR5dzY0Z2E5OWlXUlFUamtlK0JMK0ZqQkpWdGdxZVI5WER0?=
 =?utf-8?B?NmlFK0wwT0w0emIwQlVvYklmcXZIVXF2SFdHQlA2SkRraFUramRLNlZ4WitM?=
 =?utf-8?B?THBGbHBTZEt5VGJWcUszMWJZb0RtbEVaYzd2V1hTc2tJNitva0lCSnY5dEJU?=
 =?utf-8?B?YVU2TDQwOWVEcGZoWk03TXJzaGFGWWRjZGx4akJ0ZHVnTi9zRjBGSDZTUFk2?=
 =?utf-8?B?WjJDdzNYaGNkTWo5RDQvZjJ5NmhNVFBLdmZkcllBWTF0Njd6cGx6ODR3YmE4?=
 =?utf-8?B?S0lrbFJWY0RIRmhoUUY2SjVaSGsvcWYwSUxqRUQ3OEpvYUN3ZHh1TDJrT01j?=
 =?utf-8?B?SHowOSt1K2gwcHpxbjVXQklNaktFWHg3djdQMGc3Uk5tSEJLa3dReHowdVF5?=
 =?utf-8?B?U1VaNkhCbit1aXRoZkFHTXBuUGJDSEtRQ3oyMFBZZEpZL0trcWoycEUxMzZN?=
 =?utf-8?Q?1OlYINybUI9HZzauJQ6xLyeccRZyBCmVhJBPEutu6AXs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B81589CD9B46B4895120807EC2B41F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19fb08d-b0a8-4939-3c7c-08d9e7b647c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 08:13:52.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTZxr2IckLQhmPEGqWE2HDzNntzI8LP0T4/B27f7B2rdWSb6HSxTmqYxekebWxcFCLmhsAohoKDoZm45SZKbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8zLzIyIDIzOjE5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gQ2FsbCBiaW9fYXNz
b2NpYXRlX2Jsa2cganVzdCBsaWtlIGJpb19zZXRfZGV2IGRpZCBpbiB0aGUgY2FsbGVycyBiZWZv
cmUNCj4gdGhlIGNvbnZlcnNpb24gdG8gc2V0IHRoZSBibG9jayBkZXZpY2UgaW4gYmlvX3Jlc2V0
Lg0KPiANCj4gRml4ZXM6IGE3YzUwYzk0MDQ3NyAoImJsb2NrOiBwYXNzIGEgYmxvY2tfZGV2aWNl
IGFuZCBvcGYgdG8gYmlvX3Jlc2V0IikNCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCsyYjNmMTg0MTRj
MzdiNDJkY2M5NEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IFRlc3RlZC1ieTogc3l6Ym90
KzJiM2YxODQxNGMzN2I0MmRjYzk0QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpUaGlzIGZp
eGVzIHRoZSBpc3N1ZSBtZW50aW9uZWQgYnkgSmVucyBvbiB0aGUgcmVwb3J0LA0Kbm90IHN1cmUg
aWYgSSBjYW4gYWRkIHJldmlld2VkLWJ5IGFmdGVyIHRlc3RlZCBieSB0YWcsDQppZiBub3QsIHBs
ZWFzZSBkcm9wIHJldmlld2VkLWJ5IHRhZy4uDQoNClRlc3RlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQoNCi1jaw0KDQo=
