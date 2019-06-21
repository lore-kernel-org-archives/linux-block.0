Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFBC43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F266F2084E
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="GzjUtHPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfFUMGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:06:14 -0400
Received: from mail-eopbgr660102.outbound.protection.outlook.com ([40.107.66.102]:5728
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfFUMGO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 08:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZNhqcVQQODlQVOjXQyu2JoQGLQDhA0IwWArIDjp9y0=;
 b=GzjUtHPcPyVH9okBj+dWSQy4FGyHapgtIdcQGWSU9vQxFfr79mxZF8Hk1bVekzx8ztoUwXTh1tEsvk8cWilC7pST1L4+TXF42iHzn1o9+JznywAF+UPKWhwTYCSnXu1XiVW+bP/FWXZK5AaiMjEFIbfSRkIpsB45fagfp4t2LM4=
Received: from QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM (52.132.87.149) by
 QB1PR01MB3027.CANPRD01.PROD.OUTLOOK.COM (52.132.87.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 21 Jun 2019 12:06:11 +0000
Received: from QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::400d:d19c:d963:ff7f]) by QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::400d:d19c:d963:ff7f%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 12:06:10 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "fio-owner@vger.kernel.org" <fio-owner@vger.kernel.org>
Subject: Re: [io_uring]: fio's ./t/io_uring on /dev/nullb0 causing CPU stalls
Thread-Topic: [io_uring]: fio's ./t/io_uring on /dev/nullb0 causing CPU stalls
Thread-Index: AQHVJzNoqMZLPoH9zEK2xahrKo7BiaamFcGA
Date:   Fri, 21 Jun 2019 12:06:10 +0000
Message-ID: <5660C665-196B-4A4F-B61A-0A7569B6056C@raithlin.com>
References: <02CA47A4-B51C-4393-9C90-8EAFFE825669@raithlin.com>
In-Reply-To: <02CA47A4-B51C-4393-9C90-8EAFFE825669@raithlin.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [95.44.250.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7795568-8b7a-4256-1f8d-08d6f640d9af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:QB1PR01MB3027;
x-ms-traffictypediagnostic: QB1PR01MB3027:
x-microsoft-antispam-prvs: <QB1PR01MB3027D0EC86AF911351CA9D84AAE70@QB1PR01MB3027.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39830400003)(376002)(366004)(189003)(199004)(5640700003)(305945005)(7736002)(186003)(26005)(99286004)(81156014)(81166006)(8936002)(33656002)(102836004)(76176011)(8676002)(6506007)(229853002)(476003)(508600001)(558084003)(256004)(6916009)(446003)(11346002)(2616005)(486006)(6116002)(6436002)(66066001)(36756003)(3846002)(2501003)(6486002)(5660300002)(71200400001)(71190400001)(53936002)(6246003)(4326008)(2351001)(54906003)(6512007)(25786009)(14454004)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(91956017)(76116006)(2906002)(68736007)(58126008)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:QB1PR01MB3027;H:QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TDhRGYddzwEuoPHbMlJlxj4tRw/HB83Vgt86eSGfFEmUsK3Ge115MuER/MWQCmlR9zqEdFv2MJaP8kZvptvpyUpZjgFpK1N8Rq7P0HTRhnJ/zYL46krLlBjxdyTkDhDbeKDkkGvqUtpEQ9bU7v5i1MjaMQF6KH/VYMFAjDdneKmI0jfD+T2/dRb5cieNaG68DOHQ5dp7zKAcjwXLg2eU0okLd9bFimi39jeajpuKzl54JOa+FhlKoyXnoeT9G0OxcJYiZQ9mAM9qwsdFIRsoFW4dJ0i3/sz9fOQqf/PvFa5lXwR3FUgiHrfSxYAKCKCSH4x2Z5l3FixVQXw0f4XHkWDaNL4jD7E3btcaYAvTfmypocEow73Sv5yOf0030WEAB5CvKKl1QH5M7++k5aXI+ZtVqE6Xq723OmgqXFDqLrs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF84104186F64A4B949EBDC3532DC55E@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7795568-8b7a-4256-1f8d-08d6f640d9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 12:06:10.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgDQoNCj4gSSBoaXQgdGhlIGZvbGxvd2luZyBCVUcgd2hlbiB0ZXN0aW5nIGZpbydzIHQvaW9f
dXJpbmcgdGVzdCBvbiBhIG51bGwgYmxvY2sgZGV2aWNlDQoNCkkgY29uZmlybWVkIHRoZSBzYW1l
IEJVRyBvY2N1cnMgb24gNS4yLXJjNS4gSSBhbHNvIG1hbmFnZWQgdG8gaGl0IGEgc2ltaWxhciBi
dWcgaWYgSSB1c2UgdGhlIGlvX3VyaW5nIGVuZ2luZSBpbiBmaW8gYnV0IG9ubHkgd2hlbiB0aGUg
aGlwcmkgZW5naW5lIG9wdGlvbiBpcyBlbmFibGVkLiANCg0KU3RlcGhlbiAgICANCg0K
