Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A9C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FAE6103B
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhIGOXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:23:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17679 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbhIGOXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631024515; x=1662560515;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=CCjGXlIFKAvSqwDCiM+j9euV6uJgQIC5PyrIfnajK/Q=;
  b=gUlpJ5yGjfbtqnaM9GlzI+OLi2SzqWvCDuXdKBzrRPCmmFbAlK1t1XHq
   RJf2GzTM7hBLzYVga3uARu97K27kih+6VL7iOq4EW+HCiaSWD542y3JZi
   DECzTk2MmwVvIgremB1d0shSBQ43dMs9tRUC2x8aqChh68Xp6zp7rj4Ud
   bavhP9C4CMEoE0YgtEV2YuxVBuQX4mN7KZeeMQ8/jOsX34zVj07fIH5cH
   iyyydGnbXdkHksWmmI8AxW66Jz0BDtsmML/gdJ95L4JCvcDocQOGeMtYT
   2W/GZmVdVDHvIG5znJKAySNqpSkfr9S6FRVY2M0wTEbfG0XClmrLt97Nz
   w==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184162945"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 22:21:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvAZrs+zq8vo0VkRGEnWJDlFGalOPJ8PKFSAqL1HLmjJD9NN9kLwtWEuw8fapwg7zzj4YSbRjVXpDr0IC0SnrA3/e0lQXDyRAtcd/5Xg3ztorZS6YdGVGY8ufucmdg9xMBdRjSgaLlUNzpLxk1mEByXM1IotOuWq2vSvk1grArfdFXOf2wO4dYzStcrfCsv/cXUymI7ZfFdHCJuvnCEaPzb4tctvibQ5GhZwF2P4RKB7r2kivSX4X+vieu0izKQXOQ+sP8rMXNV4eWBsCtRSd72aipHPurRE9Q5m2l4bak0HlMNKaeFMtkUly4vKbHNrx16l7DmqkM3JjCS6SsIXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UeTrvjV6dCfm4FFAYkNOEFEcrGl7TG9y4GYSXqs3ujA=;
 b=KHFzUYVz6EEEgZsloCDGAio6KAGrydwypvX5TADG/fYkLS+EQj+6AjnlOQ/BOGs5Mq3SlmE4ijX2rLIvS+leYZA73xLCpQnT022W+iNo59VwPwCJJ58tuOzxwIwOfJ75BVEvR/1RFScsHeyRgKl8Wx0XHUFmTnxsJljHN6Sdi4PZgvdtaUxI1hKllb8HpDFXkq6jkQAcjtJPOKVx+64RIHWOEtn0825JRZ+7nLl85/bTYAF2xRFjwoRheNiKwbwbZa82lTILaGDrK3mAlAkIxAmCmcW651Pp6VTRi1uRmFD4s2diN5HEvjgUap/yNJaXh2TXmRHVwpe52plBjY7l3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeTrvjV6dCfm4FFAYkNOEFEcrGl7TG9y4GYSXqs3ujA=;
 b=s5NF8x2IW42h7VIa62HHeK8Cbc6xF3aOK5pLGt+pFyT881YNPYoJtnwwwghYsb0fXm0kv1RlIAD2rhdwwMFDcp5XRf/U7NzizGRAusBmYHk+YFjoGbPC3UGhbBmUgNFQxz3zwYcRLkxtvz9nF+q35q8YIAqdkihME0v2Z2hIiI8=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 14:21:54 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 14:21:54 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] don't call io scheduler callbacks for passthrough
 requests
Thread-Topic: [PATCH 0/2] don't call io scheduler callbacks for passthrough
 requests
Thread-Index: AQHXo/O1SmyNM8u59EWUacCSWXPwmA==
Date:   Tue, 7 Sep 2021 14:21:54 +0000
Message-ID: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 188ea190-c8d1-42f7-bab9-08d9720ad7c0
x-ms-traffictypediagnostic: PH0PR04MB7382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB738292A49D778759D9188DE1F2D39@PH0PR04MB7382.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkPD0enj3ZRzTFnYcXCl+af+gxBc1U4bKx8cvt+ME8Ak1+wVZ8Bq43jde1/Nu0IlN2cjHH+7PzqbhlPFGYnDg8HzHeYSPRX812Sq5w3o81qo3SJgzEjBs/0WiWFlXHpzoWcFAsrlZVPnJRG3ApgP1T3CoUHIkk9s3CrW4vkXVKrRvqXG4sOsL7R9GCTBaeMvpvYtfAs2dKUh+UVb9Am4LnEeIGpcGwhyV4DINdIZRDJyqmbkWkENSdxkwsuui/HPKVWMLeUAberd0RdEjRfaGHOfuBycSiGIhUqs1+HP9A/8aPF9a1LzysWKza+g5qgjV4KrfTW4Na1JFnElk8cPuohM6dNxLzAHEgJTCPmQsldpTzHK+y0j4H9axqQlRFou9RvrxkoZyPEwD5FwaiJAd1y0U69G5qPXEU0aoDU6P0oGlfusjuNxHwrfxvdQOku8acputj9aBJHLuNk6AJZdhvsTRv17/CLw1Z1h6qqTQfqXqR6mPyUR0Oju+w7Mtckdu+tU6UOaMJGF74PNEu8BVVn+HedCzc0PrB6kbvXoFNQ2SEO2VFUMoxPnZx8oBNt0DpYKYzOEKDpXQUOAUjzTtwJPSVbc3fvf5rRJaTBNyYzfQ99oBu3LDPpvBMVuRrpzYf1c9rnwT8qeRIH8kxO7cyNiD5fmr1EBR6ziPbICVmLPVYtdoe2QJH3/saj2J4xXb1nhjFFXswC2DfCXANJP3lcKma/rnweLaV6O2Mn975A5GWAhp9WzykBH5KLe1rkYn3bDQuMcVtBrM3t4/Yqpl4xd0qiY//ELHA/eJAclTAE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(6916009)(2906002)(478600001)(5660300002)(8936002)(2616005)(36756003)(186003)(1076003)(64756008)(66476007)(26005)(38070700005)(38100700002)(71200400001)(6512007)(122000001)(66446008)(86362001)(66556008)(76116006)(83380400001)(4326008)(6486002)(8676002)(6506007)(966005)(91956017)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yM8FrrizDfsNEFfoAT6jq8xeKgczVQ72HkgBjFi0QnGwIuHoQH8HF6ZyhQ?=
 =?iso-8859-1?Q?sQ+Mq8s6RFNJI0NIF+pgHQgIX/0ccElql1PzGBssKEx99J+FKgMnQeG6Ir?=
 =?iso-8859-1?Q?+ehrJz3TMQ0qvdkgxY3vEZiLM1sd8EXatPPhGlBJguYDOMlszSv3kLRf2d?=
 =?iso-8859-1?Q?E0KwfT5mGs/VZTbgT6M791vK/Eo9SMfLNKW3OEHgyBfAklW9UF3cZjOHsP?=
 =?iso-8859-1?Q?EE6IyE4LF/g9FXD36oj1tjpCCzm9VM7C6snbJLCHwlUazQA/2FXRJJ0BAP?=
 =?iso-8859-1?Q?Q95tflWGY/5e2oD56uetHsBS3e/1fgzJYPsEmjSinms93vpnclxbo6fR0y?=
 =?iso-8859-1?Q?GmYj+Ptb3ig4fxaYmjDh82OKrrcj5YiiZAuGrGIe28aPlTQfCsvkZzD6Ht?=
 =?iso-8859-1?Q?WVDQYTo9LyUf7j7T0dnM+91Kf1I+b3OWaITc8ej9wAVD9IHtNccIJTx3sn?=
 =?iso-8859-1?Q?C7+6VYednGxjZp8mzHfiuW6SIdxy/dxhVYnox3bzeqDpjvjeG0BwDp/8V1?=
 =?iso-8859-1?Q?AwuACESZ8xqdycRmdbEhg1q0uxyPjoaOzn22xkqJwqY60ue5RDeaGqGhkT?=
 =?iso-8859-1?Q?B7NJ9XD7UliFLiaP2EMUoRjv5WjNlsxFZLXlFGTT1YaBxd9cslF36wjFKM?=
 =?iso-8859-1?Q?OjSrYu6uSA9Q2uISDW5PUBehEwUR0G9CF9ZdfuGd3qHUVwHwNnxNwCFfCb?=
 =?iso-8859-1?Q?xVLM5fdg2X8CDOr70xzviOzND3HdPnEi4Hy4lOWCtIaZLILcjRxKNzl4rO?=
 =?iso-8859-1?Q?PsM4AFVTGLqs1ixlRIvnYppASxBvcMl4SFmoUKk2fp7RKW7lprDTYOcbJX?=
 =?iso-8859-1?Q?dvwhwXVBhPdNPHoBKsaqyIa1GeTdN4AvXTBZPFtFY04ZGxzWuk3L18sZnF?=
 =?iso-8859-1?Q?CpscLoxUml1MnT4XaYJTiDdizDNhERVOaNMXCsT58cgnk6e+A447RPHWHP?=
 =?iso-8859-1?Q?oKks6Vvjj2cr6coILB411JJqZF7KMUK/+uFTfLFBqNcXC3bTk4CaBu1ikN?=
 =?iso-8859-1?Q?I/c/Tl5HdJhNL31PGkCVd0Z/r9DTkfe78BLgmcjsiYTJN2d97MyQ4nFgrG?=
 =?iso-8859-1?Q?sEVAsLEQhteZKZb11WcCZEKjvx4n3qk0KhZz9+BsE32CdU0/b7usum8AyY?=
 =?iso-8859-1?Q?pdlKLI5riDI1et2ceYmaoYVRQFp2NqjuJeQwcNTh1YSEFweGcwkkrkpwAA?=
 =?iso-8859-1?Q?f8zHDlbfSydj2G4oOz4bJAKYuN7OcQi28fx5cPIXWguvdy2YAwYKt01gDy?=
 =?iso-8859-1?Q?UIcnWad+dPa5/xzjLUm0LQX9GP1Inyelzxq/ezkp5QZMIAJi3LgSmphcMe?=
 =?iso-8859-1?Q?8ADmjQU98gZZLTuUMOeXTOsSlOOhkKzjeMsdrnuk1f5cITC/4wfQ6QIoVA?=
 =?iso-8859-1?Q?q3JKD893nNPDH9jf5OqD21UXcn7RxUNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ea190-c8d1-42f7-bab9-08d9720ad7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 14:21:54.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYn9hipk9xnDQ40AF0EZonEn2+PpN65FRxBwRIAZFucuh4lkDdP9Eqq6lghj3hqwQTEdtREaSTv2my9RQnZ8Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Recently, there were some extra "dummy" data added into mq-deadline
rq->elv.priv, that was added for the solve purpose of working around
quirky behavior in blk-mq (which called the scheduler callbacks even
for requests that bypassed the scheduler).

Fix blk-mq to not call the I/O scheduler callbacks for passthrough requests=
,
since they will later bypass the I/O scheduler anyway.

This way, we can remove unnecessary logic in mq-deadline that was added to
deal with this quirky behavior.

BFQ should be able to perform a similar cleanup, if they wish, and should
then be able to drop this comment from the code:
https://github.com/torvalds/linux/blob/v5.14/block/bfq-iosched.c#L6456-L646=
2

Considering that I'm quite unfamiliar with the BFQ code, I'd rather
someone who is a bit more familiar with BFQ performs that cleanup.


Kind regards,
Niklas

Niklas Cassel (2):
  blk-mq: don't call callbacks for requests that bypassed the scheduler
  Revert "mq-deadline: Fix request accounting"

 block/blk-mq.c      |  7 ++++++-
 block/mq-deadline.c | 16 +++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

--=20
2.31.1
