Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F41C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5043F60E73
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbhH0MmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 08:42:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40900 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0MmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630068093; x=1661604093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ATUQYGCgx6nNX0hQIo5kUbV7KHY/PrReE3eKXf4bWdk=;
  b=jTkEsWs0xfvYW9timK50n1bZT4jxI9FyxfDIKlPNyLOx5MQQR0cax4On
   YwmMg6+S99WO3Aw5o/86X9/5cglT/4Y3r+M58mAjQKAt8ZHfFO7leROFl
   rIr1QGW0l+to6n+AJDLNKS+3c5631Gr4CLR87orUksbU47v39Rgvto6Tj
   Wq/k/OjocX4/NHVj05DKaGz6sFkdcNSUe7dGFP443rUWYDH+S+qFC1jZJ
   Ff3yTp0MAvPaxSF9nGsMcGHqG51PbaLYWXUyT3xlOE8Fqnmmeho8963Nj
   Vlwey+AXYBsDz0V8wZgBDoIo/Uk2+4KnRZl3tzZDvxTotToGPIsT8dJgy
   A==;
X-IronPort-AV: E=Sophos;i="5.84,356,1620662400"; 
   d="scan'208";a="290179378"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 20:41:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCvfbPl051gtTZkLJFluLNarN20MMzkeZaQ4sCbLSbjBPuUwrzX2///WwQPG8j8adZO/YhvVwhS1QwPLLa4NdELBdDBPA15gN8iIvwu+ENAFFTAWjkDtVynhI40vqbAwdqH9HSEjokPrnc5WcZ24frhmXmUgude4AgxbIJsR13JxzkSvQNrJzHcSisR2YxIm5lMNRpxa4Rc1csyuuX8E3v+AWdFcIftzQQRJ1fzLddPVefNMJ8fE4btAMz7wk8sGnw52sMJWCyIuPkyzAjarqnTkvqDD4JoLqOyoUHcvSSIHgUMWcFtfcLmMoASi/PqFprzU0CAreDgMVY3ZNu76cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=env2/FsOuuXLq85mJtS9uw6DKQgDKZOcYn/xM0x4ZSk=;
 b=TjgTeouwxZ+bzYIV9P88SBdrK0/xGWZ87GIEvh0ts3i0nJULLO107hmJvTvnmFRXmWD9RAA6I/ktvbJddoc0/eGAzMzMygCENuKW4XOzrIDcrDOpfI3jiHH9hLKSDCvFRvVL8+mYLKDSLA2LyVCObf2cSCGP6iR2Gn5xMEbHueJj+W2wKxJbEzVgNu2qsgYzj8bj8he98j3AvUoUw2QRCqe8W8CkO0+8GEKNsXIQEMqfnx076f2u5TOxUOu9LrEyXvecoX2HJqm+3foEoCCJ6sWh9QxV/gW4dp3dAGb0RKmFSeM+JPeUmRh92kREW+o2Spa0hR2Q7325t6kM4+RzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=env2/FsOuuXLq85mJtS9uw6DKQgDKZOcYn/xM0x4ZSk=;
 b=Vyd09gZKwOy01AWI8LNXrUVrF/waF/ik4HerTh61ScrfkFJyRoRXWmkh3PGv3UlQc5U8+oeLW10EkIdqt0Z6sQbxeh/ExAKPSdxyTEhn62SHBOkM0tUNCMr5+nCThVn3oTJRt5HJZqt+lIRGatuO7X+PQaEVkSunPwM+aXPxDrA=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7702.namprd04.prod.outlook.com (2603:10b6:510:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 12:41:32 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%5]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 12:41:32 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Topic: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Index: AQHXm0DcNbCoMv+LuUuRBM4IFE0DyA==
Date:   Fri, 27 Aug 2021 12:41:31 +0000
Message-ID: <20210827124100.98112-2-Niklas.Cassel@wdc.com>
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
x-ms-office365-filtering-correlation-id: e32570af-78f0-497a-9954-08d96957ff8c
x-ms-traffictypediagnostic: PH0PR04MB7702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB77023C95A59DE5C3DE12B1C2F2C89@PH0PR04MB7702.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4kdCVdQLhpO3IJwDs8DMJBZEQsb1ksUUoDLOfKTLls5AjdfThd/HaMP1lww4tRENyOJp/xvt3T49xDXXHsuzkrYj52ejC+iqz3kdJVW1M1Ixe+wc38+kqNtWq3TmYZduVhRjvF14V5kpAcuvpMTK1di1IQiG9tccqUDdofJOqCnN74i/tBT1vn1tj3k5nHUhbjA1AnarMaGFMht1brLLbedusnSghyFWMRWMHdbPEithl85kvYfffds2G1BmwRIlpy8wXcNBEAYX0vhmtYWxhuGK4xi6tTyHfbiPJm1/jHqwsoAXHQCMn2Ivo54TCMnc/oZD7kA7piu/f5pkOSsLcwI94Y6jEgSWIiBDfIoz/hwmjasEBdo1JItqFB7YYRSf6nGEhBXObtX4hSEfFQLagRZl4HhtfwjzR3jAjUMZKk8IJ+C1WTJNr7gLgI36PM3bKyBvmlXPb/soHx/7MJ9LsGFVZxwQlFJaMnvnIayJQx2ArfrMvYAAu0fbrPZekqqmm2rfnAFsZtr6Q5g7SRORhpesMJTBouBj6cqrCqguUYGT+EnbnvuvC4jMDNjQABFSS7yOMP6t0VVFPCN8vZZf9tPSJm0XTVssXsiIkrSqv6qMKabustUUtiqkURVCLpAT8BT0vAEq00fz/uW5+znSJd080GQ7iinyafNXRY2Gr97TYcSWzOI6K7BNFLDuwk8nS7gASLeYUWdB2E3dyiuJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(36756003)(4326008)(5660300002)(91956017)(66556008)(64756008)(38100700002)(38070700005)(6486002)(2616005)(26005)(76116006)(1076003)(66946007)(54906003)(66446008)(122000001)(316002)(186003)(6506007)(83380400001)(66476007)(2906002)(6916009)(86362001)(71200400001)(8676002)(6512007)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fhGk8qkU29WW7+b952CMmnUKK6jS+TipynBoJcvLlTdE0JNRwExJlvePmj?=
 =?iso-8859-1?Q?9R8CrYDQTxfULUUNjXwIfyRsKlDBAGlQBcvbw8ct1rFgHemUbZgyRmA9MV?=
 =?iso-8859-1?Q?oqu+bQR07fwJZb3zkw5dDsSwhDFQvyQT6QQco8udP6G6UyNCJ5GS/Mlk9M?=
 =?iso-8859-1?Q?hvsVGViG7va8c6gU+ZmE7wfAJnMYrF6h+PHXZe1sN3MG7aYE1DjdY681ja?=
 =?iso-8859-1?Q?cNd94OTb4hpHWDCSwxD14sXNWGpIGKePuqZa9MIFAZZunEKljcj2kCtEge?=
 =?iso-8859-1?Q?BOBYb320X9Ve2nIrZlY98ZURa/bjXfnSB6btfNgk2DavzgLiLeo67kMo0z?=
 =?iso-8859-1?Q?PPrXh9OTUYJpUbHMNOGtTk1UOx020Qgu95HR/d93pITk3XhXeAaQrB7ep5?=
 =?iso-8859-1?Q?heVonl/4e8WOa4NuXlauj0ysYC+hftZNFs8Dm2vROfOqFza1+kAeYZjYbn?=
 =?iso-8859-1?Q?ze1RxZKoWms3Ytzc21l1UM3bln06Ajd2FZQawyTPbESPZ4BYJDO9QtEGo1?=
 =?iso-8859-1?Q?txvafLK4ro8LyzkJBkOfDLlCfU3R9V0W20Dq5J951EqwNJf8ns35Owk85q?=
 =?iso-8859-1?Q?5QFF81bU1wfnOrdoo51XKIrX2u0ANqSRjIMNNUY0qKGK4XrgofIWFJoQOT?=
 =?iso-8859-1?Q?cpWYXD4v2RqMEaVEm/T1imRVv4fJNhY7eryNvMl3jgoDhltrjG+qIKsBtE?=
 =?iso-8859-1?Q?2qfO8bZl27lMg+jeZ6t7ymai7bl/FrVJUx+Mqsev7pSaMkcy1YrP8z+o5B?=
 =?iso-8859-1?Q?fmjrjP/QcuARadA8gkCfEw5y/cCeQyl8Ghmq69gWSbleIVsSzeRGIcqjY9?=
 =?iso-8859-1?Q?+XuDvKreD80iV+EGR7Va0QXmVnoY706BtIATWnnWCAly50/HYZ8EssLOeZ?=
 =?iso-8859-1?Q?5bNT/ik5rERnQcsUXunhefw2P3CB1aalvC55gchhM/jiAb8Rmoxi1vhqKX?=
 =?iso-8859-1?Q?/SzXF4fLeJjjWmdEUR44vhv94dq+uWJfXQt1o3KcsYM4VAn5Xh0McYw7NQ?=
 =?iso-8859-1?Q?maicjVRgWRHMlO6Zvq1Asa6U6otIhY/Mcto63fRvHXLTpfs5L8FyHtBXOc?=
 =?iso-8859-1?Q?WWKOXAiQyosGkY6JniPD5bzlowD+1n4kYktbX2O2B6Ie5eLe//pC373Qia?=
 =?iso-8859-1?Q?3JAT6CZFKfGUjOB25tPZJxZKkZztXoR7jHk3TGTK7Yj4NAxrTxAdAUGQEb?=
 =?iso-8859-1?Q?HJ6US2D7GvLWYZKcsztH14PXtTRxfolHMZb/0C14FiSrjOVoXAslqxjrNH?=
 =?iso-8859-1?Q?O1jqntfytFqFrBM/MW4KwEEdFqbOMryKGVUp/6c7WR7lYXQUj5VDuShCT0?=
 =?iso-8859-1?Q?WjQwm4dIto7JC/R6JebaOHM3GzWvJRhRsjxLy3UtzNc42MxuzVCVd59wNQ?=
 =?iso-8859-1?Q?04jZLoYxPUX8Kwp0Xa2vCthlmk4nay/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32570af-78f0-497a-9954-08d96957ff8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 12:41:31.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzcuuZy2Gj7HRtL0nes8DrjK8/8DT2Ts1lo3EegmdKElAL5Enq4XXdZaSowaiSxNWfxdku1fRXNtiBjwtHJp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7702
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently, __blk_mq_alloc_request() calls ops.prepare_request and sets
RQF_ELVPRIV.

Therefore, (if the request is not a flush) the RQF_ELVPRIV flag will be
set for the request in blk_mq_submit_bio(), regardless if the request
was submitted to a scheduler, or bypassed the scheduler.

Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
if it is, the ops.finish_request callback will be called.

The problem with this is that the finish_request scheduler callback
will be called for requests that bypassed the scheduler.

Fix this by calling the scheduler ops.prepare_request callback, and
set the RQF_ELVPRIV flag only immediately before calling the insert
callback.

This way, we can reuse the flag, and we don't need to add any
additional checks in blk_mq_sched_requeue_request() and
blk_mq_free_request(), since they already only do the callback
if RQF_ELVPRIV is set, and the existing .prepare_request callbacks
should still work without needing modifications.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/blk-mq-sched.c   | 20 ++++++++++++++++++++
 block/blk-mq.c         | 13 -------------
 include/linux/blkdev.h |  3 ++-
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0f006cabfd91..eacacb7088c1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -466,6 +466,14 @@ void blk_mq_sched_insert_request(struct request *rq, b=
ool at_head,
 	if (e) {
 		LIST_HEAD(list);
=20
+		rq->elv.icq =3D NULL;
+		if (e && e->type->ops.prepare_request) {
+			if (e->type->icq_cache)
+				blk_mq_sched_assign_ioc(rq);
+
+			e->type->ops.prepare_request(rq);
+			rq->rq_flags |=3D RQF_ELVPRIV;
+		}
 		list_add(&rq->queuelist, &list);
 		e->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
@@ -495,6 +503,18 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx=
 *hctx,
=20
 	e =3D hctx->queue->elevator;
 	if (e) {
+		struct request *rq;
+
+		list_for_each_entry(rq, list, queuelist) {
+			rq->elv.icq =3D NULL;
+			if (e && e->type->ops.prepare_request) {
+				if (e->type->icq_cache)
+					blk_mq_sched_assign_ioc(rq);
+
+				e->type->ops.prepare_request(rq);
+				rq->rq_flags |=3D RQF_ELVPRIV;
+			}
+		}
 		e->type->ops.insert_requests(hctx, list, false);
 	} else {
 		/*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d4fdc2be88a..3527dd9fd10e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -328,19 +328,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_m=
q_alloc_data *data,
 	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	refcount_set(&rq->ref, 1);
=20
-	if (!op_is_flush(data->cmd_flags)) {
-		struct elevator_queue *e =3D data->q->elevator;
-
-		rq->elv.icq =3D NULL;
-		if (e && e->type->ops.prepare_request) {
-			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
-
-			e->type->ops.prepare_request(rq);
-			rq->rq_flags |=3D RQF_ELVPRIV;
-		}
-	}
-
 	data->hctx->queued++;
 	return rq;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2e12320cb121..a5047c7e9448 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -81,7 +81,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_FAILED		((__force req_flags_t)(1 << 10))
 /* don't warn about errors */
 #define RQF_QUIET		((__force req_flags_t)(1 << 11))
-/* elevator private data attached */
+/* The request has been inserted to an elevator, and thus has private
+   data attached */
 #define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
 /* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
--=20
2.31.1
