Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16147C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF75F60F25
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbhH0Mme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 08:42:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14960 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbhH0Mme (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 08:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630068105; x=1661604105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9P2glR/zWaqp22HxB4Qx/gVlrOKHHT9yFaXkj9ec494=;
  b=FFyCZHyABx7Zr2dSSLF2i1249KStmGm4cVF2qyGFbBaL/T0/2+Ubf1Im
   Vx+4Eib3rEu7GG+NOj/1DHqnZvofJF0WiikmHlOiQN0XJaqCXfpUpXgQx
   fXvRLkju84WHpFhpV+cN5Fxt2gWyXX4NBt6XPTFgdMWcr3IQ3A/QKw89l
   Kl0v334DWyxLp/wojXz3OsrljVjLVsGeIVLgCuZGVuQcmVho2yarYhH/t
   stVIpOEWpqotN7q4kShIx18jw7D5er7nuUrIuJniO+4bJMHuQjEKVyE1b
   /OvRfvfAOD4zWFGtZg3tmusQ2BFwV00ipj54JEmStbNFr7dLS/yF1x4y8
   g==;
X-IronPort-AV: E=Sophos;i="5.84,356,1620662400"; 
   d="scan'208";a="179139989"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 20:41:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X17905mfY4AOiqV0oTCHjfw10ETBif0xQ2EiknhXPf6dxQWks+uny7z6wEnpjo4zMGmh6HFi2BxovnfbUivHjQV1wxLqYhupdyFbamDsRbG2an4Ja/zkndPnqDWd9f4a7asVlEriUwJKTAypUVRNe33urlomKpNR8S5dKuT1GYaOmjBki0QmfU8YwBmu9t166R0kvGUgV5yqf1e43iSbbmK4oqDFZpw5xhXZaaSNgaD/tf71Mf74/CrLmYe2MBLknNxpYeiLTuA2epjpPMuJor5yFNulg1m7FeP//ixqylSi4MrRevcRjgp6Z3SxDwRjcrNKkj5QNgWOt111hRVqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdRJstisOH5VwfW7GKZHMaiel2SspOA1gUj3LIeTu3g=;
 b=jounD/l+pGYFpGAiKfUy0VXudt4tlqMpeIr2nlDnomGjNfOVFsM90Luf/lXwY8IYMCa4eQdW91nhkBEIH7Op92elmGraDfRdQXtbU5LlDNKyi1j88l2nfae+6CzXbhdb9wovI0jYvN6cJq7oYC5wqWHQtBPylTqdXUd+VK8O/YhFJ0QRjU5GZDFSHzfMonHJhr13L87eQZbfRbbZdm7T1q5vSOgZ/zCwYCAunBqvAcFvdQXDfprQb1reFCbHI2tIE/qoJYpVhlYbeG2XZlS4FyN62Re8W8ev2k3TbZG9QaVgt/VF2pvHSWKthLDB/hWjXjAzKyxPnVeVaPvZMIWyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdRJstisOH5VwfW7GKZHMaiel2SspOA1gUj3LIeTu3g=;
 b=rJaMBWOdZZerEJ2rFW9TTyPsvFYcdSPs+1AX9irLKENXwhHdhNJF5SlvW1SFBV7UEvUPfPMS8YwZcGjGdXQHNofK7Kh6f8p8lgXYo7W3d/Ayaanb1tOc9G56e8qjOmtfUX+uqwQyfXT3/omyV/Oko6HJHkAYVGDxoaFeMgqRxcE=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7702.namprd04.prod.outlook.com (2603:10b6:510:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 12:41:43 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%5]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 12:41:43 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Topic: [RFC PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Index: AQHXm0Djs+Cyo3cAGkuJk+KGlmF30A==
Date:   Fri, 27 Aug 2021 12:41:43 +0000
Message-ID: <20210827124100.98112-3-Niklas.Cassel@wdc.com>
References: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 093927e7-fbde-4a4c-4d91-08d969580652
x-ms-traffictypediagnostic: PH0PR04MB7702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7702AA84E6414E94493C200DF2C89@PH0PR04MB7702.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/kYXGtlE3wK0+L2q3mF/+3TmEn/Q7a2wdEgpdhHvK6GESUBfVjEwxWrRg/cv6Dfl5XfNffMLZOFLIXffCs/6dMYvzktg6G2NwkF21x41EZODOPWsYWxTdyHZiHsq+Z01LhuVvF6+qVdmoB0WX/13bKWj+EvqGYi5WCzOAx68iwWMNTHol/DtCZSflA6FpsQbu9Ph185As9TVYaFRkiNEGYbIHLjFhzH6z41nAfdQv9qMmbOBdAGvcxkJXol2Qo+tPymgqdxbyTnhTZDrlZSCElJCLYAW5QocnIP9cXdegWC9fjTrsJGpR4gmR9UE8O5w2dnWtCCyH90/1TtZvpJjl55TAPfmHuhlC0KxbZh+z38QVNfumLSI8Vtn0uriIdbkW3x5IiqRcb3xUO/4efooy73PuK1Yqm7nXUk2Rxv8a8/7wrwmRJY0KNTzpelP5sRI03dYPYhkcnXrTFqzijnqAGzjMmhKs8oKJ6rDi/RyqwNqQyiW/PruZv2NdkBV9hJpiOyXuQTUJT6kWXgIY7x/+PVZvr3bPXtiUURnNOp1iaVN5eJYYDXNFAa6wBZFrMsTG050ipa0QjP2rXKW7DpSsVHwa1HJTMB09zvqV/FyhNs0jazzjAiSImrEtiJpSnqUIXYno+1d+fRRC4LiK02XG5DVcQS4/H6ovGwdXkwhcaNNlQquo+xakpuMS3yWbkHO9R3oIrsj4Lg5OLOQi91RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(36756003)(4326008)(5660300002)(91956017)(66556008)(64756008)(38100700002)(38070700005)(6486002)(2616005)(26005)(76116006)(1076003)(66946007)(54906003)(66446008)(122000001)(316002)(186003)(6506007)(83380400001)(66476007)(2906002)(15650500001)(6916009)(86362001)(71200400001)(8676002)(6512007)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xnyiddo1mqjoX8m6V+SZY9FFREOIfbyfo4X0wF7h9sN/DO0oqmi2cDXuHK?=
 =?iso-8859-1?Q?uBRe2gbX4MaBTfMVEKV1zFL5i+R34TvEY3zuxeo1XSRhEceyWHI/Lx+hzL?=
 =?iso-8859-1?Q?BUOs1rEtM/ozxTk+AfdTqoK7EGbOBaEerE+MwQqc1xbc3gh/3SEmvPdl1A?=
 =?iso-8859-1?Q?k/cS5UWVdExuMy+i8mj6g5BbSi2F+uN6n90s3cdKYzN84RrkxHwWFo1oCu?=
 =?iso-8859-1?Q?2B8299+rF9HuENyj56KebYSIEl8blJSdFq9D+HLSFFCJMUOqc8882dgp6M?=
 =?iso-8859-1?Q?jVwiFLqFvFmSSDFGQBvSbrnTFi0Zo/EPQyod/3enlLI9rJxtSifyRc0DgK?=
 =?iso-8859-1?Q?bKLAJxKXACgJDrmSMR9UE1cv+7K4ddzvh2S65wk8RWiBSBesNZnnsi3AlF?=
 =?iso-8859-1?Q?yCshEA8vyYIa4IRoNlhl4BUXYLD4Whs+zUewNgpDCQJ3B2KdFiG7vA3acW?=
 =?iso-8859-1?Q?byjAYPujo/RJQ2mqcZsYsF+S/MTrZU0V0lHOh9QG3sUvTxezGAkBUP+q89?=
 =?iso-8859-1?Q?/cHGUYfRA8FFohKZhfacz+hjOctR10keXkIOSuGTK9LvykyhW2ekLh/+7l?=
 =?iso-8859-1?Q?aJOlviVmf2YoROGUX3xIeKuzEYl/htItHXc1qUlthIdpCSUHO7XQMYRY+z?=
 =?iso-8859-1?Q?LY/v2h/qqJQCIfDfLqCTFNt3wNv+NONDMg7upPL8TrAI5CDjmNpqlPDZ2D?=
 =?iso-8859-1?Q?aQ1cP+hF628Vr8jxUdwkrWNcQ6S4Gc0lSnp9SY9EszLSj3uuNci8KRVvkj?=
 =?iso-8859-1?Q?ZBdlnXELhWYeAVQZCEFYM9aQ/J/zo9kgX7Hihpo3ihA7sflIiO9Bxgki58?=
 =?iso-8859-1?Q?joGakpIMSOpPQndVCDvFI/9PT9gi5oBThcDNt5p47m1Fgfo2xqEKiPnWJT?=
 =?iso-8859-1?Q?jsO2HFD9xY5yEZYvOh2RySGRowg4GrpqvVWBUKws0NU4RfNSYJXK42xZ+w?=
 =?iso-8859-1?Q?cMvuWCNfFfOkazG7ANGuFehrB+GLw7Jdjny+rM/eXc9Ae97Z1RSt54goKy?=
 =?iso-8859-1?Q?909mhdkYrH13XHklEYtJ5UAm9YsNetVrvajxrOWFcGLYLAGxnfNGVRjf3w?=
 =?iso-8859-1?Q?sQtVbUPcmZbzNQurpzF6OhzkhI9Xkui7zP86wx9we5NeY8qnMFDoIvBkWT?=
 =?iso-8859-1?Q?AZEmnIB9eo780kz+fV9Lh0cvkZ5RcEcfkgdppxXaAeSeW2Ml/b5rDUnGm0?=
 =?iso-8859-1?Q?IxwrBJ739FBqfyv0maRT+QgWN8OLBsKEn0rI2TEyenyCHLGhU9DDfx0BKu?=
 =?iso-8859-1?Q?EykcRO5ULF3djqPkiDkgD6U58ClsNbXsqJYu+r2SMViD37SMsopems9fnE?=
 =?iso-8859-1?Q?kCByXNXo9fnkvdQv0C1HsBxj7D2EkreQagpUbaWBHgsUsMFQ2PR9IC6sVY?=
 =?iso-8859-1?Q?2XCf59fGLeA0nM9NW6oml0e2+S8hvHow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093927e7-fbde-4a4c-4d91-08d969580652
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 12:41:43.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxkF3esgJDfe2Irs9DDsQYvYncCRFWUy5y1sKhZGk/i3HdNfsO+SWG4zWjIeQfPCh0uYXr0Ueoca0hXVan/u+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7702
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

This reverts commit b6d2b054e8baaee53fd2d4854c63cbf0f2c6262a.

There is no longer any need to perform any workaround private data magic
in order to track if a request was inserted to the scheduler or not.

blk-mq will no longer call .finish_request() for requests that were
never inserted to the scheduler.

This patch also didn't handle requeues properly, so it would have
required additional private data magic if it wasn't reverted.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/mq-deadline.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 36920670dccc..a5d171b54f8e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -682,7 +682,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hct=
x, struct request *rq,
=20
 	prio =3D ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, inserted, prio);
-	rq->elv.priv[0] =3D (void *)(uintptr_t)1;
=20
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -731,10 +730,12 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *=
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
@@ -761,14 +762,7 @@ static void dd_finish_request(struct request *rq)
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
