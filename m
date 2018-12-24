Return-Path: <SRS0=jPL+=PB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2A4C43387
	for <linux-block@archiver.kernel.org>; Mon, 24 Dec 2018 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D8620869
	for <linux-block@archiver.kernel.org>; Mon, 24 Dec 2018 11:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbeLXLG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:06:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:48675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbeLXLGZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Dec 2018 06:06:25 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LtIZH-1hMIXV1qXb-012qNC; Mon, 24 Dec 2018 12:06:23 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: change return type to bool from int
Date:   Mon, 24 Dec 2018 19:05:54 +0800
Message-Id: <20181224110554.4007-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7yod04UcUip1nxmgB3/3sRhm0OgfPBNMj9GakIFtw/9fF82mCp0
 5sNR2zZ7wrJY4sHVAeqTfcnf0MIRPQn3yP45KKJ6sksfFarRG75vyp8eBsq7PpBcwlQnAIU
 jI6Axq0Jo8WR7odF8P9Sb8b8lYHtxaIEl/ovRgTtIwURgVWN5VdwktCe6N14OdRteZ9/nap
 2oKJm9rTd0cCKo2vgzQpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XPFjrBgJu/s=:qUXn8qWLTpiF1BVBF/Bh29
 da43lS4DofFBUCsxm4yNRUbnKx0N88Ck++MTf/QIl7LVdsRgFwULZaM3LBGyD8G5gq2hU+wK0
 d5EmM3CDdz9bwL7Ce9hjY0fY9v9gLQMmgdLx/yv1uJJTB5lD7LuNXSztux/7St9LBieWUaWBD
 UogotHUka7PeuWibLwzb0MEbAe8fSbvlXyrljHpWkBAOXtBfrSJBSE6/sKrq6NJkIiNLfdhDY
 H/fzwx9jNhxEXPMX9TPCgT+2YkQZaRa8TIvtcFX7P5DQJNSERZZZ9ErvVRFzSLtuq0ui+Sfpm
 EVkgQSM0aSaZuGFKyhuBDjhdOkXNd7dVaIM1+/D1/uOxPTw/9yEqCHy3yOWXMyUZcmd3qqaKw
 Lllvj1Trp3WfnlHoce3EFXdP3oB5hBD+9EhHxFhktfSSsOLwEygi4q4nbmNPw7luG50LqfzoX
 b1CnUJXSxJgEIUpPYb/HlNuswQGmeniVayJ05scR1tehg5q6rlytPSlW/Ugx68rSuj/gcNcL4
 a5VOZ9/dj6hTSKZYm+bB7Gq2u4cJGGkVKQ7OpDrIQp9cxxeN0Dozdc2DfNTZ57FhkFp+Cmp3u
 DuapHrzFPSgQxQiCMNmQKnmzswdR5bRe+3E81yEaSweriDkeAQk3H05RcSAiAyOmIlZUrldM/
 HhMYEPWY1cVjIRRsuYWafxHdQi753DzQGgHhdOBJxS0ppLevyUH7EK3ZCaZiRPxf7HPIpFVpx
 eV9Q6l5GHGm0K3nqhNNdgQkTGfK2kP5Aieqq6zkYCbF9bURMEk6QmdfJpvis1ZDBT8t/E/Lrz
 qBe2TCU97W/hl52tbKYmHCqodXsF/V1omfnQRhb7Oom8Q8D+GGZUdUAmBlLPPfWu4u36+/fjg
 UAcSBPaQX6dmkEaXYN+rTsy7IxNqWcqDV2KL1r/HQ=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change some functions' return type to bool from int
because their checking results could represnt in bool
value.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/cfq-iosched.c      | 4 ++--
 block/elevator.c         | 2 +-
 include/linux/elevator.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index ed41aa978c4a..b58969b8b6ea 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2582,7 +2582,7 @@ cfq_merged_requests(struct request_queue *q, struct request *rq,
 		cfq_del_cfqq_rr(cfqd, cfqq);
 }
 
-static int cfq_allow_bio_merge(struct request_queue *q, struct request *rq,
+static bool cfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 			       struct bio *bio)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
@@ -2608,7 +2608,7 @@ static int cfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 	return cfqq == RQ_CFQQ(rq);
 }
 
-static int cfq_allow_rq_merge(struct request_queue *q, struct request *rq,
+static bool cfq_allow_rq_merge(struct request_queue *q, struct request *rq,
 			      struct request *next)
 {
 	return RQ_CFQQ(rq) == RQ_CFQQ(next);
diff --git a/block/elevator.c b/block/elevator.c
index 8fdcd64ae12e..432717fc782f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -56,7 +56,7 @@ static LIST_HEAD(elv_list);
  * Query io scheduler to see if the current process issuing bio may be
  * merged with rq.
  */
-static int elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
+static bool elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
 {
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 015bb59c0331..f6928aa5cc3d 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -30,10 +30,10 @@ typedef void (elevator_merge_req_fn) (struct request_queue *, struct request *,
 
 typedef void (elevator_merged_fn) (struct request_queue *, struct request *, enum elv_merge);
 
-typedef int (elevator_allow_bio_merge_fn) (struct request_queue *,
+typedef bool (elevator_allow_bio_merge_fn) (struct request_queue *,
 					   struct request *, struct bio *);
 
-typedef int (elevator_allow_rq_merge_fn) (struct request_queue *,
+typedef bool (elevator_allow_rq_merge_fn) (struct request_queue *,
 					  struct request *, struct request *);
 
 typedef void (elevator_bio_merged_fn) (struct request_queue *,
-- 
2.19.2

