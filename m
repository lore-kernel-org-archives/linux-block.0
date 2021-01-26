Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C3C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06E322B51
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbhAZFeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:34:23 -0500
Received: from mail-bn8nam12on2139.outbound.protection.outlook.com ([40.107.237.139]:26014
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731472AbhAZCSy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 21:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AefnTo9mdlqVpwPxXdJM7SXfS4sy4nmdSuCUhinRkXNbtjwAHigsPCSOHpZIw/nW5gCe/5fE9Tf7mj9UYodbbHMVHPv7zNso7HYee64q5LWb2ILpleFRIGkZwcxycnR98AMUv18pE/Qjguv/g3wHK6QFI8Y8qSDuef7lNBOSiCfEQZYvv5XbK8oVB5ggjoTMc9mxw3fHEibQZRZUOSntnSu0684YJR0FXDW504WyKKX1zVL9fz1mkvwHEDA/hT9YSgebONrJ4QYxoA8BcVAFZYKHl1kenw97qAshJ2OhJqotegwZIV3mL/gr70h57cW1h3gIp/PNmw+TzY9Huyd2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N97zgKVWbsnVwWYUXw4oyuR/HkAQSy55b467yoj205w=;
 b=hhI7746al3JRCR+wawDYvEiNEO1G+QovNqmXm+AphgYHzSkbHRB9f6dXZ9e+Q64G4Pd0wMYoiaMzPGQpSm3sHYEU5/k3mZ2i3kLkmBTacxfP1SzBq/Mduih8ABIJ/BjSzhiWhQM4OYkvpCB7uU9KqyMcQ+nUtjtLkPv9spVexlu9S3eA6WaZxzHEwuJswMg6CTVyNQmJY5BF1eML96KgwKiOzvCMJFGf9VcORq8gQ5fZs0GePPS3AVhROvFhfJOzQJK5q9uAuO+cznB7yyulbnZ1rPSwp6SkQW9fxPdC8ShuX5CqiyIgwE2aeCGA8SudmB87NCMhysSXxmLVgoi1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N97zgKVWbsnVwWYUXw4oyuR/HkAQSy55b467yoj205w=;
 b=HD4hNh50yd5jNRJYB2Im6bircs3JAk8PIgwf3TAayRq0ib2TJ6ro/EBkXvBPhPlvFtxhtBQQNVAJ0XS8Bkfj6mrJQNnihrPCGMBApU9N2+sEAxBp3I6t3qwM4YbA02ZHGnGHgCo8Nk/76S6sekAq/ms9qRguYKnRqyqsgNnaF2I=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1815.namprd22.prod.outlook.com (2603:10b6:610:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 02:18:03 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::4030:a132:aaff:aaa9]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::4030:a132:aaff:aaa9%7]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 02:18:03 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Thread-Topic: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Thread-Index: AQHWlaXfvTpx7KESnEekWqIbdjook6o556gA
Date:   Tue, 26 Jan 2021 02:18:03 +0000
Message-ID: <EB9B1A40-87F9-44ED-AED0-80167DC9E2E2@purdue.edu>
References: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
In-Reply-To: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7240f7c-fcf1-411f-1eb3-08d8c1a09ca0
x-ms-traffictypediagnostic: CH2PR22MB1815:
x-microsoft-antispam-prvs: <CH2PR22MB181583616435FD714E5C1F57DFBC9@CH2PR22MB1815.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0mtLWoT9FnDPQWfkaEGxWrgjPocYA0aGEWdHwKV2Tded4qfuzJF6plu9ptA53g5sviXbePVklJOY0Fc7gSOyKbyjM4KJCltqw/YbAfMkKLV/sA/GyQNLIwR+76PxGKDb8LAIFXtJhVCfNBXa+XQcKZTVoiveiAA8h8t0RJ8tXvHzPXIxUWW7Bjldq8OGvJZw75WIN38xIJ8jpj5Gb9ETeW5kDubLcrjKxY9+azz0IXlXgB8k2b1BxY5Wl6vXI7vixIyitB8/dvte7QN0b7iFEHmU2DD0ydWydZ3QR9AsU8EMH1EeOzW9rDZKzWAPPpNRcqPsjU3hlnQ8iEjAtUWhX00D9EAOkzWT9VjKb/zl/QpVpKHQ37V+GbMp6DLD6DozufNHDO8MeqC9zUUzWHB+WdhFHQrQVsjVHYz4CnY5FKcEM+SS8jcq4NJvA1eRc3CRAhiFzbJzljizxdOT+37hDwRRsxIsZ/2vGc/0NJtRI8fQK2/VDT0hwSFbwLRl9co7/kUvcd1CJKXe4SmLoVlCWBN1Of31rUTtuPaqOoNXxsesFQVfImuk2rT6buMl+xaLxtEq5H5z20+umYn6g6ut/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(39860400002)(376002)(366004)(6486002)(6506007)(53546011)(83380400001)(2906002)(5660300002)(76116006)(66446008)(36756003)(4326008)(66476007)(186003)(26005)(6512007)(2616005)(33656002)(86362001)(8676002)(66946007)(316002)(786003)(110136005)(64756008)(75432002)(71200400001)(66556008)(478600001)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QnFzem4ra2hCUGNTUHFrVk9IOXFjT1dEdUhoK1ZKRFpNdFFtZmZKWkNHK3Yr?=
 =?utf-8?B?cmxlY0NOZEQrWHBNOHJKblI5MVQxR3dPUHhFUjhGWS8wcTR0MGxrMitOTzVE?=
 =?utf-8?B?VHp4ZXF0TmlBSG53aDZmYmVUUmVjZU9MakRwUW1iMzZPWHY5OEtLWGI4UXhK?=
 =?utf-8?B?TnJvSjVEaFhaNWtWbHhvNkxpdVIyL1VRR2YxSE9IZjlqWjF2ZEd1ZzZPd2Q0?=
 =?utf-8?B?b1FqQjU1OHdMelByTzBPVDhCaHA1QlliajVqQnR5dURMeCtFdVR5SFJpWEJk?=
 =?utf-8?B?blF2U29qdjd4bHJJNGN1b056TlkzRHpVSmd2WHAzcXRMVDhoYmp6cmtGYWll?=
 =?utf-8?B?UVBKQU9lNVNkRzZVRjZTaG1VRDJqRkR4aEo5aTlsODQyU3NZU1kvVTZ3cFk3?=
 =?utf-8?B?akR1a3VnM1RsK2hqUjZqUmxmTGxya0FBT2xxNDhiM3JoMHdlUSttdVdsSUtn?=
 =?utf-8?B?VEtKM1hPYzFYeGpmSVpJTTFEaC9Za2Nma1ZTK2hMTXB2akxXTFpadmlPanAw?=
 =?utf-8?B?cWlEWDZ5QTdMc1ZCV3FYZEJaaTUweCtrNExPcFVSRUNUSkFVSysyU2VUVDQy?=
 =?utf-8?B?K3cwK2h2TC95dFNNcWVlWUVTYmFtZG5JV0pFNlF4Y1dmVVlIb0NxRHBQbk82?=
 =?utf-8?B?ZlBmWm5VbnI2aHprWllFTHBBTmQzRms4Z2V5NG4zQWY0UkVwRmR1QS9ZL0JI?=
 =?utf-8?B?Z3oyZitRZDBJTWM1UVVMUDd4djVtdXlQcUZrNG1pSGR1bXJ6d1JiQXFSc3VG?=
 =?utf-8?B?d0dFdU9ma0RoNkk1a0FUL3c4Q1gzS0NqQzc2eDhjWUhiaENhM1BrclJVZVlr?=
 =?utf-8?B?YS9ueE9aT3Ywbys0WTUwemIrUDVmemlKd1BKdDQ3dUt4SGtMQjVudFJJVzZx?=
 =?utf-8?B?K0NpaFBKc2dvN1VwY1FJY2ZTSjNmclp0clFMaFh4SkpIdDkzcnNKR1VJaERR?=
 =?utf-8?B?bVp3OHptVUxFc2llUXBCUEg3Z0ZpMW5PeGMrSWIyV3hWaCtrVWFuUnhSRGx6?=
 =?utf-8?B?cDJEUHhVekJkSW5ucXI1WXg5QTJ6dnFMWXNzRG83U2phb1hhQmVEcTRBNmJE?=
 =?utf-8?B?Q3A2d3hWZitKQ09ta2RUVm45Q3RRUlJWR0dmV05hQ1BWS0kzQ1NpSGF5ajNw?=
 =?utf-8?B?UHhDMnY0d2NZZzlpU2hiV2x6eU1CMEhTdzQwUWxBbTlFRHZ4Skc4UXZ5MlV5?=
 =?utf-8?B?ZjNFQVdPL25Hd1VlUjgvYlVPa3FOMTMyeFJyWFprVjJsbENtaXpKa0QwSUNC?=
 =?utf-8?B?ajR3a2t1UTNud1phKzIyVUVYeXl6cnBEV0lDS0VONkZ0S2ZRQUlEM2RzYkRy?=
 =?utf-8?B?SzdFbXc3Wk5JOWoyUEtIRDE5WGh5YTdYNkRsZSs3bXViUmNVYmFWdW5YWHlG?=
 =?utf-8?B?Sk16TllKNlI3MHNKWExhOHBLU0FRRUplaTNocHM0U1hXdXp6dDBqd2VaUXQr?=
 =?utf-8?B?Y01qTTZNYkl0aVNnNzVPcDB4U2VxQi8vL3BSYUZnPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6A76B6BEB9DB468D10C19B844B2753@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7240f7c-fcf1-411f-1eb3-08d8c1a09ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 02:18:03.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/1J086Kpe6X0+K6Kt7R0nJnSF3UVc6HEGw9mHmtmCqU7pmEgB3yebFTxN/kl5l/K2RaPjoETszK8PN68YKtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1815
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGVsbG8sDQoNCldlIGhhdmUgZm91bmQgb3V0IHdoeSB0aGlzIGJ1ZyBoYXBwZW5zLiBXaGVuIGEg
a2VybmVsIHRocmVhZCBpcyBleGVjdXRpbmcgbG9vcF9jbHJfZmQoKSwgaXQgd2lsbCByZWxlYXNl
IHRoZSBsb29wX2N0bF9tdXRleCBsb2NrIGZvciBhIHNob3J0IHBlcmlvZCBvZiB0aW1lLCBiZWZv
cmUgY2FsbGluZyBfX2xvb3BfY2xyX2ZkKCkuIEhvd2V2ZXIsIGFub3RoZXIga2VybmVsIHRocmVh
ZCBtYXkgdGFrZSB1c2Ugb2YgdGhpcyBzbWFsbCBnYXAsIG9wZW4gdGhlIGxvb3AgZGV2aWNlLCBy
ZWFkIGl0IGFuZCBjYXVzZSBhIEJMS19TVFNfSU9FUlIgZXZlbnR1YWxseS4gVGhpcyBidWcgbWF5
IGxlYWQgdG8gZXJyb3IgbWVzc2FnZXMgb24gdGhlIGtlcm5lbCBjb25zb2xlLCBhcyBtZW50aW9u
ZWQgaW4gdGhlIHByZXZpb3VzIGVtYWlsLg0KDQpUaGUgZm9sbG93aW5nIGludGVybGVhdmluZ3Mg
b2YgdGhpcyBidWcgaXMgc2hvd24gYmVsb3c6DQoNClRocmVhZCAxCQkJCQkJCQlUaHJlYWQgMg0K
Ly8gRXhlY3V0ZSBsb29wX2Nscl9mZCgpDQpsby0+bG9fc3RhdGUgPSBMb19ydW5kb3duDQptdXRl
eF91bmxvY2soJmxvb3BfY3RsX211dGV4KTsNCgkJCQkJCQkJCS8vIEV4ZWN1dGUgbG9fb3Blbigp
DQoJCQkJCQkJCQllcnIgPSBtdXRleF9sb2NrX2tpbGxhYmxlKCZsb29wX2N0bF9tdXRleCk7DQoJ
CQkJCQkJCQnigKYNCgkJCQkJCQkJCWxvID0gYmRldi0+YmRfZGlzay0+cHJpdmF0ZV9kYXRhOw0K
CQkJCQkJCQkJLy8gbG9fb3BlbiByZXR1cm4gYSBzdWNjZXNzDQoJCQkJCQkNCgkJCQkJCQkJCS8v
IFVzZXIgbWFrZXMgYSBrc3lzX3JlYWQoKSByZXF1ZXN0DQoJCQkJCQkJCQkvLyBsb29wX3F1ZXVl
X3JxKCkNCgkJCQkJCQkJCWlmIChsby0+bG9fc3RhdGUgIT0gTG9fYm91bmQpDQoJCQkJCQkJCQkJ
cmV0dXJuIEJMS19TVFNfSU9FUlI7DQovLyBFeGVjdXRlIF9fbG9vcF9jbHJfZmQoKQ0KbXV0ZXhf
bG9jaygmbG9vcF9jdGxfbXV0ZXgpOw0KLi4uDQoNCg0KVGhhbmtzLA0KU2lzaHVhaQ0KDQo+IE9u
IFNlcCAyOCwgMjAyMCwgYXQgMTA6NDQgQU0sIEdvbmcsIFNpc2h1YWkgPHNpc2h1YWlAcHVyZHVl
LmVkdT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IFdlIGZvdW5kIGEgcG90ZW50aWFsIGNvbmN1
cnJlbmN5IGJ1ZyBpbiBsaW51eCBrZXJuZWwgNS4zLjExLiBXZSBhcmUgYWJsZSB0byByZXByb2R1
Y2UgdGhpcyBidWcgaW4geDg2IHVuZGVyIHNwZWNpZmljIHRocmVhZCBpbnRlcmxlYXZpbmdzLiBU
aGlzIGJ1ZyBjYXVzZXMgYSBibGtfdXBkYXRlX3JlcXVlc3QgSS9PIGVycm9yLg0KPiANCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IEtlcm5lbCBjb25zb2xl
IG91dHB1dA0KPiBibGtfdXBkYXRlX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IGxvb3AwLCBzZWN0
b3IgMCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4ODA3MDAgcGh5c19zZWcgMSBwcmlvIGNsYXNzIDAN
Cj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBUZXN0
IGlucHV0DQo+IFRoaXMgYnVnIG9jY3VycyB3aGVuIGtlcm5lbCBmdW5jdGlvbnMgZG9fdmZzX2lv
Y3RsKCkgYW5kIGRvX3JlYWR2KCkgYXJlIGV4ZWN1dGVkIHdpdGggY2VydGFpbiBwYXJhbWV0ZXJz
IGluIHR3byBzZXBhcmF0ZSB0aHJlYWRzIGFuZCBydW4gY29uY3VycmVudGx5Lg0KPiANCj4gVGhl
IHRlc3QgcHJvZ3JhbSBpcyBnZW5lcmF0ZWQgaW4gU3l6a2FsbGVy4oCZcyBmb3JtYXQgYXMgZm9s
bG93czoNCj4gVGVzdCAxIFtydW4gaW4gdGhyZWFkIDFdDQo+IHN5el9yZWFkX3BhcnRfdGFibGUo
MHgwLCAweDEsICYoMHg3ZjAwMDAwMDA2YzApPVt7MHgwLCAweDAsIDB4MTAwfV0pDQo+IFRlc3Qg
MiBbcnVuIGluIHRocmVhZCAyXQ0KPiByMCA9IHN5el9vcGVuX2RldiRsb29wKCYoMHg3ZjAwMDAw
MDAwMDApPScvZGV2L2xvb3AjXHgwMCcsIDB4MCwgMHgwKQ0KPiByZWFkdihyMCwgJigweDdmMDAw
MDAwMDM0MCk9W3smKDB4N2YwMDAwMDAwNDQwKT0iIi80MDk2LCAweDEwMDB9XSwgMHgxKQ0KPiAN
Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IEludGVybGVh
dmluZw0KPiBUaHJlYWQgMQkJCQkJCQkJCQkJCQlUaHJlYWQgMg0KPiAJCQkJCQkJCQkJCQkJCWRv
X3JlYWR2KCkNCj4gCQkJCQkJCQkJCQkJCQktdmZzX3JlYWR2KCkNCj4gCQkJCQkJCQkJCQkJCQkt
LWRvX2l0ZXJfcmVhZCgpDQo+IAkJCQkJCQkJCQkJCQkJLS0tZG9faXRlcl9yZWFkdl93cml0ZXYo
KQ0KPiAJCQkJCQkJCQkJCQkJCS0tLS1ibGtkZXZfcmVhZF9pdGVyKCkNCj4gZG9fdmZzX2lvY3Rs
KCkJCQkJCQkNCj4gLS12ZnNfaW9jdGwoKQkNCj4gLS1ibGtkZXZfaW9jdGwoKQ0KPiAtLS1ibGtk
ZXZfZHJpdmVyX2lvY3RsKCkJCQkJDQo+IC0tLS1sb29wX3NldF9mZCgpDQo+IC0tLS0tYmRfc2V0
X3NpemUoKQ0KPiAJCQkJCQkJCQkJCQkJCQkoZnMvYmxrX2Rldi5jOjE5OTkpDQo+IAkJCQkJCQkJ
CQkJCQkJCWxvZmZfdCBzaXplID0gaV9zaXplX3JlYWQoYmRfaW5vZGUpOw0KPiAJCQkJCQkJCQkJ
CQkJCQlsb2ZmX3QgcG9zID0gaW9jYi0+a2lfcG9zOw0KPiAJCQkJCQkJCQkJCQkJCQlpZiAocG9z
ID49IHNpemUpDQo+IAkJCQkJCQkJCQkJCQkJCQlyZXR1cm4gMDsNCj4gCQkJCQkJCQkJCQkJCQkJ
c2l6ZSAtPSBwb3M7DQo+IA0KPiAJCQkJCQkJCQkJCQkJCS0tLS1nZW5lcmljX2ZpbGVfcmVhZF9p
dGVyKCkNCj4gCQkJCQkJCQkJCQkJCQkJKG1tL2ZpbGVtYXAuYzoyMDY5KQkNCj4gCQkJCQkJCQkJ
CQkJCQkJcGFnZSA9IGZpbmRfZ2V0X3BhZ2UobWFwcGluZywgaW5kZXgpOw0KPiAJCQkJCQkJICAJ
CQkJCQkJCWlmICghcGFnZSkgew0KPiAJCQkJCQkJCQkJCQkJCQkJaWYgKGlvY2ItPmtpX2ZsYWdz
ICYgSU9DQl9OT1dBSVQpDQo+IAkJCQkJCQkJCQkJCQkJCQkJZ290byB3b3VsZF9ibG9jazsNCj4g
CQkJCQkJCQkJCQkJCQkJcGFnZV9jYWNoZV9zeW5jX3JlYWRhaGVhZChtYXBwaW5nLA0KPiANCj4g
CQkJCQkJCQkJCQkJCQkJLS0tLS1wYWdlX2NhY2hlX3N5bmNfcmVhZGFoZWFkKCkNCj4gCQkJCQkJ
CQkJCQkJCQkJLS0tLS0tb25kZW1hbmRfcmVhZGFoZWFkKCkNCj4gCQkJCQkJCQkJCQkJCQkJ4oCm
DQo+IAkJCQkJCQkJCQkJCQkJCS0tLS0tLS0tLS0tLi4uYmxrX3VwZGF0ZV9yZXF1ZXN0KCkNCj4g
CQkJCQkJCQkJCQkJCQkJKGVycm9yKQ0KPiAtLS0tLWxvb3Bfc3lzZnNfaW5pdCgpDQo+IOKApg0K
PiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IEFuYWx5
c2lzDQo+IFdlIG9ic2VydmVkIHRoYXQgd2hlbiB0aHJlYWQgMiBpcyBleGVjdXRlZCBhbG9uZSB3
aXRob3V0IHRocmVhZCAxLCBpX3NpemVfcmVhZCgpIGF0IGZzL2Jsa19kZXYuYzoxOTk5IHJldHVy
bnMgYSBzaXplIG9mIDAsIHRodXMgaW4gc2VxdWVudGlhbCBtb2RlIGJsa2Rldl9yZWFkX2l0ZXIo
KSByZXR1cm5zIGRpcmVjdGx5IGF0IOKAnHJldHVybiAwO+KAnSBIb3dldmVyLCB3aGVuIHR3byB0
aHJlYWRzIGFyZSBleGVjdXRlZCBjb25jdXJyZW50bHksIHRocmVhZCAxIGNoYW5nZXMgdGhlIHNp
emUgb2YgdGhlIHNhbWUgaW5vZGUgdGhhdCB0aHJlYWQgMiBpcyBjb25jdXJyZW50bHkgYWNjZXNz
aW5nLCB0aGVuIHRocmVhZCAyIGdvZXMgaW50byBhIGRpZmZlcmVudCBwYXRoLCBldmVudHVhbGx5
IGNhdXNpbmcgdGhlIGJsa191cGRhdGVfcmVxdWVzdCBJL08gZXJyb3IuDQo+IA0KPiANCj4gVGhh
bmtzLA0KPiBTaXNodWFpDQo+IA0KDQo=
