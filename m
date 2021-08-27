Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F832C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FF060E73
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhH0MmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 08:42:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14933 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0MmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 08:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630068087; x=1661604087;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wQ8xwK9dbPTSGYvpeEXtIDlINN2dm4vaVsrWi906sSw=;
  b=VkA6BKt0V6rpjSs1apaT6rKR2vchminshARH1onxTj1vLbVHltkUgL4n
   0apsOz+M4BDSrvrc11eLR3hmA7hN4s4bNXScJ86QnyBXRzQJPptTQOqOD
   qWsf1Gidb4I4IxCuQZb5QywpbrPkiIuVQXNyVUmyKvQjG7oirbyIHZtNa
   NhKkaividu30tBxEoUGGMhoiQ3TIkFjez8ZYETc1PaZvEtlBDcx2diKta
   nq7EWL7LTI4Rzrb4IzAY0QCXwPvJH52Xg7v1QAF3l9o2LPrW997uC62Bp
   5eIzqfMIpqaWlARLVAxwDMWcX2f++UlMtziwq6EFk5e5sa6QRkYOr/01T
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,356,1620662400"; 
   d="scan'208";a="179139961"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 20:41:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpTPG80AYstvvGxXznglWhe+jZf6xWRyycGdSnZwCNTK70G5ESvGMuCx5kKGTqA23B+FqLk5yppdfPClMg9c033pDiC7aiX+Z/mgqRjENfzPC2bIKnVmHtogHytHN5AjWIfSbkFbJNT+fXCO2vdjd0DujuvsYZXj/Xct7wrsXBJopKeRAGVgsmYo4JXar7CJ8AWoCHB9T7et32f1fdV8Z/Gvbj/GS53ufefqNIniLtaDikDTvStVKJgvL+hcQfG9L988DB+Q1Y6YdBEwrKDmHE4DlDo8eBkdec5Pct8/CC8RgILl2SzomSk/ZqYQnUzYvFeA/7SRpDGa7wJwKbVX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyRuSL/ICraorT7otY4UD9XbtcZGbJDhMrNdEJIzH0E=;
 b=WrVepr5l0K+DKcJxgj/bUg2SXe4I3CQI6kM0DVbN825F7fPielmcRvq8rTuGBav4miAYtXsj0Uj1r83+9JT6OzX6356NLRrBYXgA7POzNwYU+Rn00zLeELzMoylVOGSKaixBaYYUCra3x25OLjpMuLgGeYF/idrNTMtrZsQSdBKAcWbeI31tJXDry2moqbrtIvVzPNTaNGFqoU+U3LtX7UZTFVrHJZmpw2KyKopUSzIc7PLas0RLLWmcoxW0W5bdJSR50kqomu2YJPRIjoRc8xYrGNaVBVvPk1KaSR0E4sxVDYekSJSp2C4HoV4wIEyZdtw/+/QJUK30WysAyoo69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyRuSL/ICraorT7otY4UD9XbtcZGbJDhMrNdEJIzH0E=;
 b=uQJ2Xkj1XyVH2tsdvyujBgAR7va6+2AlOcz4OidvAGFAao31n++3gTps5c5RrHqfQE4c08+t8AEno0597V0PG8wrDEdgakMmSAEzHeNvyczL6pIRW0poX7Y2QOBIeCKFa+eZLE6pIT7l8EcLViqqDpvw5mBk2/c7fJoYmo4ly/0=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7702.namprd04.prod.outlook.com (2603:10b6:510:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 12:41:22 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%5]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 12:41:22 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/2] improve io scheduler callback triggering
Thread-Topic: [RFC PATCH 0/2] improve io scheduler callback triggering
Thread-Index: AQHXm0DXb93kkZxy5kiaiP334AkFGA==
Date:   Fri, 27 Aug 2021 12:41:22 +0000
Message-ID: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c613b99-69ab-4f41-5467-08d96957f9fe
x-ms-traffictypediagnostic: PH0PR04MB7702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7702EC9B70DFD3DEB9EBA140F2C89@PH0PR04MB7702.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdO8/4opF9wjOymuX5wx7XSzlIImMnrPFsWZSRRkozBdIYvgGyP5xM2WhZhsWdahj7f1nCurIV7fstIvfYQ7/6SRRBqtaO25epTwJnTuGXOQsfPy9o4jcTeTbn43Y8WqaOfLKdGL1tRTrKSR6Ik22yMIyQBimO/Xaoyy7q2Ls77uG6qk7fRuWNCir6xThn08aQlc7p4SNbKCiqEy+pQiMSA+MF6F9KyL6AbzZdc6nF68xv6ev2PxCV/gUp8Gj/M7KVcvoB2Mduhwvlho2OOXTSHsYT9t/pXmCpun4zrSWuCU0alYiqCcLEmBeNYiQlihLJYw0dpdeW+cOsSyjpcJJOeEHBbzQvGn6c/3NTm94mR3RoQsYSfyfjHXd2csXsj7QOsUS+W7Dq/jpR83P3lfgh3yceykO01gLCD+jdMcgsAatsW+Skdw+zXFRJLVMBSEXsiLc0wWltuo/JS+fIPM1xOT5oZ9Bbjfknkb9Hqb1CRVnetg0PR1RgmIXZwbCnlthGkPRuHtNkmV8Y4B38vyA7hbk9EfXuVL0DVOxLeEmmQFamJ6PZlOcrhBbAlOftq9pHa7sB6OQu43V2hG7fC7bNIJcYhnGDiX3ayJ/PBN6eJLr+dshuimrzYJ+n66XzWEciKNfxIMM04FQ2Cq8bJKv7pWHUYPI/mwP+/VSo+M9BMw3gjbL2tJJxioIDNJFZlgZhRR2M07vZuakMNoI5YYkGtCs9wjrZXM0zS+hKieeD6tZtNkGWLuitSButo7F4gQdfW4fYhE0mN8XFJdmz8gxRGod1nQ+E3xdFajMz6TrGQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(36756003)(4326008)(5660300002)(91956017)(66556008)(64756008)(38100700002)(38070700005)(6486002)(2616005)(26005)(76116006)(1076003)(66946007)(54906003)(966005)(66446008)(122000001)(316002)(186003)(6506007)(83380400001)(66476007)(2906002)(6916009)(86362001)(71200400001)(8676002)(6512007)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DnjEHjQsr4Bupm2phEVePqf+TpTmAri6GRdVYyGHD/xFKsifzjFBp9JvRb?=
 =?iso-8859-1?Q?O51lbrKTqyRBYsnZBNLGT8ZlZZ7EPlYPM6KZW5QsIDHl2QUXNVaQAi1GbY?=
 =?iso-8859-1?Q?p8nSDmVtT5Mkt8aeuhLaByBxdtPnBLNWjGJXd4uja7n2XO/tEjZzyWf9Nc?=
 =?iso-8859-1?Q?PvgeB9Aioe3w2iYpWssJFh8Pj25CXXRCz4G6ARc1oBkUY50lftFcOhDTCq?=
 =?iso-8859-1?Q?9qhvnVARG87lkZX5oE1D/hDNrDdJPjM5pUC1eqH0E4Dqlly1xDayk4nQcE?=
 =?iso-8859-1?Q?xEdL2haVEYY+v8ZLidM9woLnznbmDi5WCCnFY86heUSZTG9q11jz9THdkB?=
 =?iso-8859-1?Q?OJ8v5l+18FeDD0zaI12VCj2HCeeuWlmnLjE0DJKxod4brYHeOHS10MY955?=
 =?iso-8859-1?Q?PaiPwfkwRU5GQ+6xWzdtNcF8nHLxgsbufwXqewHd2HEsfnu6hGoT6dpC1x?=
 =?iso-8859-1?Q?mMcnwh2m/Sdu2A5Pb2HpAIgS+stK36j+2XD4PafZWvl4mARlahkXTvuewy?=
 =?iso-8859-1?Q?cn7KMHjKQouP01ZMxVxSTBXudupxs7doLOWVBFec7tGmbcIud7RdMMgcqB?=
 =?iso-8859-1?Q?hVf+INns4uD0WfdO1KQQa1f7cmLIsMS6tyXKCW+zsWJ2zwV+eXgxA+eyGe?=
 =?iso-8859-1?Q?j44mYwSKyBicvmYWLSWaw40fIKNglnQWECuJnUtYfVWcCJMqzGwB16mn7l?=
 =?iso-8859-1?Q?o+tRTN4ryskcRMZbjj8K0KNIRa60GBmkzFqIan5t+HKzrcNtwRVoX+TMe5?=
 =?iso-8859-1?Q?2+9izQ2nW3q4fiNmIwuZ0DcKFVQ5oKU50gUWHpMNPtj0kAqyXm2sbi1Y41?=
 =?iso-8859-1?Q?KaVyatFn1KCX9DC/1pd0zAOSOG3gc4ig+SKXQK8ZsBd2BSXUIbC7qScTvw?=
 =?iso-8859-1?Q?GBpsfRlRw39dMt+2GWzi3vczyQOnUuj9zPUV5s3dRAoP0YiNVhvxvjw3xw?=
 =?iso-8859-1?Q?FGVWFglJfnePxI5gxd8cJ+782ySBcEv59SFfNVHrxOTzcEhmehP1bsO4mj?=
 =?iso-8859-1?Q?NVX7kQEFiqBnYiio+RzQ+Aaafu3MttRULUjFJqJ7tNBN7OviXB+FRd8a0g?=
 =?iso-8859-1?Q?j8ljzPT7ZX+t68O+8wQ0BxbkgEN1ulNp9EZSk6N4XCydKSpKZV8cBlvK2Y?=
 =?iso-8859-1?Q?5V1eKMorxTuv6wBkOpt+6x0RxFezTxTLPe1Lm/fCljJbCbuUj3S5rk4K04?=
 =?iso-8859-1?Q?mqzo/F7MSVAbjJwhj1szrZfbxRPop7zvQV4Eyv+XOIRUZwWF3qxf6OY/jV?=
 =?iso-8859-1?Q?sPs7J7hwHLwaK+oaWtw95xJ31Zhg8YDz/LcqE5Uqt6aHnaLxn1vP9FqM5w?=
 =?iso-8859-1?Q?SXt53U+V5k7ziSwbQA3SYZCn1l4S3yo0+dPES6hI+JTENkp8uvu5Tn5XH9?=
 =?iso-8859-1?Q?Hybu/Ien6MY4GFM5iXEG68Lov/JOef5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c613b99-69ab-4f41-5467-08d96957f9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 12:41:22.5019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BgTyUgxzVUyUb22iX96f6GvlfflpV6oVDCb5jyWfDZ+N9ZCZNhb71rN/70R+e970KkNm3bsUWmRZBTVMWanKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7702
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Recently, there were some extra "dummy" data added into mq-deadline
rq->elv.priv, that was there for the solve purpose of working around
shortcomings in blk-mq (which called the scheduler callbacks even
for requests that bypassed the scheduler).

Fix blk-mq to behave in a more sane way with regards to scheduler
callback triggering, and remove the now unneeded rq->elv.priv magic.

BFQ should be able to perform a similar cleanup, and should be able
to drop this comment from the code:
https://github.com/torvalds/linux/blob/master/block/bfq-iosched.c#L6456-L64=
62

Considering that I'm quite unfamiliar with the BFQ code, I'd rather
someone who is a bit more familiar with BFQ performs that cleanup.


Kind regards,
Niklas

Niklas Cassel (2):
  blk-mq: don't call callbacks for requests that bypassed the scheduler
  Revert "mq-deadline: Fix request accounting"

 block/blk-mq-sched.c   | 20 ++++++++++++++++++++
 block/blk-mq.c         | 13 -------------
 block/mq-deadline.c    | 16 +++++-----------
 include/linux/blkdev.h |  3 ++-
 4 files changed, 27 insertions(+), 25 deletions(-)

--=20
2.31.1
