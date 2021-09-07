Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9607C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99446103D
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhIGOXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:23:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17679 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbhIGOXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631024517; x=1662560517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Sgz/gGlnMD8XyPNt5y7peU1arQEbdMxWoyt1ocbzhI=;
  b=cqXRzvFk/dxaUwwIrHjkciegzGP/1jcrDfh9B1CDsXv92Yfg56yTlaM3
   Bx5YORR0H7fsEmh6GjyrMX0GkgRw1vRDg0FNWVRHann/Cxem9CghaWbs5
   Z/tbHfqdyO/tr2yDRSTRfZ4TE+PeHn9HmEwnjX+XEufVIdTuji1K/iW/g
   bG4fkB+DVUTk5ntGPYaB2QSrYBwIDq6IE6ZJCGO8MlIG3pmkDkbgkIIra
   AOj6oTqRM5QlN7VBMfdM3lrX+pmelYri3Q09UyPhuvOL9WBpIfMaFIexK
   2H7MxcV3BVKpDyi22aa49AxXyQZOfDCurGfbSKYhdBuBVpYT6IFa/YgOJ
   g==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184162953"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 22:21:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRTc7BjlWVqaFo672mNZuwHd+itbJY55d6+cblpowBY1V6U5RKwP2NgRQf138TaqnqVkNZ9JtqN8GSb/9JPs3TlV2/wuAe41c+3ilNFHqeArT6+zRh3eH1TzpwdBrVNfYNilyIN3zUt3hAjJpFR6QrHdL08tUfvN4NAZmQKbKXS5wX/axWenILYlSpBlCewpbZpzvQeKrx3MruOhnlYa/WcanyKEo2eTWL86ls9bonvOkpA4DHtvleqsCJRB1zdY6Az3KsnFCoTdtYCGdp5YI2NiS2Oiwp5qXv6vijZgiAcv2UMsSzxADrKhxgQlBH3OOEPBCMwmbIiUYoANJKnpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uOY78QPH6YwX0qHjo/C9tjIsWS3wkLb3W2wzAeqjYf4=;
 b=TsOxDpO9eodLirzJVgp0LT5u2EQYME4VOhacIrW54Im8LJKEoEwER/oVYnwmToZvw+6DHXWyVlIJoWLMQ6rBTkfClRHcpMZRtKrRZG3P3lfV+iKwLuKG0BTHfZ+2CTL3/d7WdZ89G2s/DRhB2OhWnz7UE4BE6FfzTol3yXuG+IxSaWn8VTBajJJMTnWMZlgR3+8+EesJg2/cAS962bUA94xZhh/lm9/e3Ap1/wr6zjqfIrUIOT1JI/fhgWeQ4PMCzK7jvg+6vH+eIg23jErfFToSwV8/1etmPUAOf62bFERJhL70As164RveZbtw7PFPqoXcP1+FvyAG8OexeMO5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOY78QPH6YwX0qHjo/C9tjIsWS3wkLb3W2wzAeqjYf4=;
 b=eKhpHvkn7PaozYQxaMgjnH5C0+ESlXdZqaWPpJN5Ycd+8Xcrx9Y7v3kjsNj+pZXYLjT+zYayeK5FWdOLoZetS8BzQWYSD7o+G7BDPWF8t4r2liUQiv0wiQ8ahd9pmXos5qNrUBO7CeBvn01TAeUeqyAkTUwIeDbaaQarqTMbjfM=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 14:21:56 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 14:21:56 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Topic: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Index: AQHXo/O2L+LBuS/YJECb1WaT3ju4YA==
Date:   Tue, 7 Sep 2021 14:21:56 +0000
Message-ID: <20210907142145.112096-3-Niklas.Cassel@wdc.com>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88aa69fe-3444-42e0-55b5-08d9720ad8c6
x-ms-traffictypediagnostic: PH0PR04MB7382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB738234411D164F525A1500D8F2D39@PH0PR04MB7382.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QZTT/Ij7oW2kGVsU3eHlV0ZI6mSSQYK2pN6cQA072BICTFwOlKsq0mJOATFKRwynhfx/G/VIFRCyNUrF/bwTFGRWMo/gP0vdNm3jSDrR2EKSqpWSDkWhrJwOECLEWNaBowirydjdiaffjtEhxnXIOPlSuxAdaP8ec/8+SXkN+3LNq2ItpTIjfBA/r2EhVZyZ2ogm88bvrOzMgCOC4caXt9XbpldlECw9mSaY19vcSo50mo4NJbjNlXLkixv/ayBd9dZbffAmj7Sea6eVbGkx2OBEK54+mrC49QkAR/kiN18z0EjBkUGkCRHkPCPMgVL9X0/Dw8a+ahbqmXbVzuPhMQh1JCTf7bkeqDMxPkIeqclxXoaS0Ruwy9wZCfFSjNK9odhtv8sMSEp/QmS8OfcVu4uA+I1T/Hycv6rt8ulok7kX/4cor7clqRL+7FDo4DIPEJdiWph8z29nvpxuvNB/XXAy4hdeA5UiYTVRF6mu8IUbMd/WvhcNUjYt3QRZcMcXQxiu/8ZNjIMMmaO/H2I0b3DPPmIEcc0x5qZJ/m4qmaU6lahzQ+HgrWOez9qkUJWyF3M8fL58SiNny57UbZNdbSpSIBJiAyHejEc3cXZwHaaA+90l1WK6dRJWUblHvsJWkiBh1uMCuCQtbk+ySmlfUcDf5mjJs1tTsEBOfDm0gOCUMeaIjrR1E+dhq6Et8+XTfVLPuJ9Ecnwc968xbLD0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(6916009)(2906002)(478600001)(5660300002)(8936002)(2616005)(36756003)(186003)(1076003)(64756008)(66476007)(26005)(15650500001)(38070700005)(38100700002)(71200400001)(6512007)(122000001)(66446008)(86362001)(66556008)(76116006)(83380400001)(4326008)(6486002)(8676002)(6506007)(91956017)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7wmGab3acS/FcazQCAHeO0vel5rMHf1/NCNMnXqvw7xBoNKCWgmZecHxee?=
 =?iso-8859-1?Q?uWTZx1vob9dzNmqovgUUiZ09//ZD/9Cp421LixBFXvQ/HEwKVY5HsgqMcT?=
 =?iso-8859-1?Q?mVZ0e6W4f0RuoTSoBA2Cf6ynTEm1n41Oi0PV8G7Mw4s9GSHNv2rIqaIV/5?=
 =?iso-8859-1?Q?2WiEXAOjn2J+HesHU1vblM8IR0WBWsEk2RMkZFsMJXLdK6qufZKby8SVN3?=
 =?iso-8859-1?Q?Jfg++EFGQi8zOFPIglcmqr54MDKpGPgPihrayn15mlgLrbcTEnRsaREmuL?=
 =?iso-8859-1?Q?lfvE3ePnSIlOMJWy/FFk8EPKwCMBSTj3yIP74qOFuQQ40yRodrDovC4wi5?=
 =?iso-8859-1?Q?GU+AhrZpIh8GfcNk4+p0877JrTs15MM53Nzo2/nk9jiEMwOEOXFN++25Zi?=
 =?iso-8859-1?Q?VtNwsWMh1B1pHLkH6tqImljRHwQWd9cdTSmF1jujPvIIocx3lLdQGq9ODF?=
 =?iso-8859-1?Q?+kMVKgD2FYPFwJayFcwSi8qB5c29enBfqufxU3nwVwWyoeoPMEbtWTnK0j?=
 =?iso-8859-1?Q?FcPkaY0Mh1OF3SYuHXQ9IkRFSUvNkA+T7b+rMR7YiXS8mklP7QYCzSraAq?=
 =?iso-8859-1?Q?+O1e440OlZO7NU3JUwrFhce02tP7L3xd/fRSojQM+kEdW1AO2+zDlReclf?=
 =?iso-8859-1?Q?Ui/OdbvkWjZ1obkqJosttPWWerSfczPxBBMHjXHvF4Sh2ROgC2INYz+4Sv?=
 =?iso-8859-1?Q?bBK+/UYTuto2ML0CATKDuN0/8DRrDLVxsUB5Lp805OVqGwi1EMf+YlwCdi?=
 =?iso-8859-1?Q?icIONmYJ6NjH5j92CuPifKMe6MH9l/cSEXrFQZSBYxIYLG8Hn1vYqxBiTN?=
 =?iso-8859-1?Q?jwtM38ihLPmI2j0R/ApF6S68W9PnNLAxUiSaIsnzLK1tYSlkAM1EtEXsNt?=
 =?iso-8859-1?Q?Bg9Z/2qUMGXJUZzGu2r2RY6hj7JyFWqulkZ0JaPHkWv26Yrg6UKmWBHIDm?=
 =?iso-8859-1?Q?27KAp2+OfcbEenRyOp47WKNs5mL2glVuZaNz2Xt0lDAnAQ8IFeoNqPwhbv?=
 =?iso-8859-1?Q?r9p5Mc7to5jzf4C3WZvGJRzzw0InefGdW4r9Dd31ER1HHG5rh5/D2vYH5X?=
 =?iso-8859-1?Q?58Qo9WJ4a+WwqxEQfFIrZXVj//p93ENophMlUQUuQKpA10BFnNRVU9sXIf?=
 =?iso-8859-1?Q?7wJOHuchrE1Y8t4qov1monX5Hdwa27I7fZpAxI9pg66bTbFY/hr/qt4/aJ?=
 =?iso-8859-1?Q?P8IydAyenOy3NMmX7S8eKBmUYSzHX7XA2W0ADBcu/Db4d64BxMmI9qJume?=
 =?iso-8859-1?Q?tLpn5KzmNjTnZ6bHpnirK3sYXFUlBuPVwqZkmJKMNVuoQKCfQxJC8LmquJ?=
 =?iso-8859-1?Q?5nAr9g2AiWmKBa2vIVOTtI2Xc8Q7LgoGZ9w2dhODwdpRsJHVCSS3JMV+PO?=
 =?iso-8859-1?Q?wWCLLkAgiJlaj5xAMXnd3yD7ksurPAmA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aa69fe-3444-42e0-55b5-08d9720ad8c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 14:21:56.0407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37cK5aB6Ga1Ajwvf+oMkoTTD9RqgU3FFAg2izBHGNygok0pdiTW9ZxWQLpuCKr9XG1YDGDtERmv9Qt7LCXJQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

This reverts commit b6d2b054e8baaee53fd2d4854c63cbf0f2c6262a.

blk-mq will no longer call the I/O scheduler .finish_request() callback
for requests that were never inserted to the I/O scheduler.

Therefore, we can remove the logic inside mq-deadline that was added to
workaround the (no longer existing) quirky behavior of blk-mq.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/mq-deadline.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 7f3c3932b723..b2d1e3adcb39 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -678,7 +678,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hct=
x, struct request *rq,
=20
 	prio =3D ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, inserted, prio);
-	rq->elv.priv[0] =3D (void *)(uintptr_t)1;
=20
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -727,10 +726,12 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *=
hctx,
 	spin_unlock(&dd->lock);
 }
=20
-/* Callback from inside blk_mq_rq_ctx_init(). */
+/*
+ * Nothing to do here. This is defined only to ensure that .finish_request
+ * method is called upon request completion.
+ */
 static void dd_prepare_request(struct request *rq)
 {
-	rq->elv.priv[0] =3D NULL;
 }
=20
 /*
@@ -757,14 +758,7 @@ static void dd_finish_request(struct request *rq)
 	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
=20
-	/*
-	 * The block layer core may call dd_finish_request() without having
-	 * called dd_insert_requests(). Hence only update statistics for
-	 * requests for which dd_insert_requests() has been called. See also
-	 * blk_mq_request_bypass_insert().
-	 */
-	if (rq->elv.priv[0])
-		dd_count(dd, completed, prio);
+	dd_count(dd, completed, prio);
=20
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
--=20
2.31.1
