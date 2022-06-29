Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E558C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiF2Xcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiF2Xc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:29 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605A039C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:28 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so988452pjl.5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7E4w7kIKQ96rHwGacVUxrdUZsidv6tQ8vURC751p/RI=;
        b=ucfrex3Ig7gDldDxx2EqB2D4aaGgAydVrg3WfaA4lnya9DNkDr6fvrROfCeor3sY+6
         T0iUY9oF1D6j7aykhHwFrEMolmbV0kPvvwRC1fvBagWxtpP0Teupo1LEynoNHAc6hba+
         bkBld04BoFscop/Qi/zjopjsRW9MQtK+RVVr7eD8a6j2x19UUOrYBHUa1B7onKn/KiBP
         pA7LWvU2kFZLi2/Y8dg7qtG6AcBQwlUJKOqKzwZPRTsGeDfkZ47dKAdsB8MrCIn6GZEn
         zoN9uIt/qsxtTk2Z7MqQHMQOTOjpWzmBas9+VntIvBLGMKyQgGQ3LK6yJKRQ/I0t37Nd
         Zbig==
X-Gm-Message-State: AJIora//Ga0vpTdtWUIWH3UCx5WHiAw+5Zk+ZIjMkX+q5LaSYO33IbL8
        WVxEdYp3dqXBgIvuBM+aXoA=
X-Google-Smtp-Source: AGRyM1vDv0v/6drHeS4Bf5vVknS4B+qxgfyHv5m9xIDw3C7l47u4Rme9qxN/A6h9ZlJtYGbzeDr9Rg==
X-Received: by 2002:a17:902:c101:b0:16a:1272:270e with SMTP id 1-20020a170902c10100b0016a1272270emr12604324pli.163.1656545547790;
        Wed, 29 Jun 2022 16:32:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 22/63] dm/core: Rename kcopyd_job.rw into kcopyd.op
Date:   Wed, 29 Jun 2022 16:31:04 -0700
Message-Id: <20220629233145.2779494-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The member name 'rw' suggests that this member either has the value 'READ'
or 'WRITE' and no other values. Since that member also can have the value
REQ_OP_WRITE_ZEROES, rename 'rw' into 'op'. This patch does not change any
functionality since REQ_OP_READ = READ = 0 and REQ_OP_WRITE = WRITE = 1.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-kcopyd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index a99b994e2b62..9c8f3544e99d 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -350,9 +350,9 @@ struct kcopyd_job {
 	unsigned long write_err;
 
 	/*
-	 * Either READ or WRITE
+	 * REQ_OP_READ, REQ_OP_WRITE or REQ_OP_WRITE_ZEROES.
 	 */
-	int rw;
+	enum req_op op;
 	struct dm_io_region source;
 
 	/*
@@ -418,7 +418,8 @@ static struct kcopyd_job *pop_io_job(struct list_head *jobs,
 	 * constraint and sequential writes that are at the right position.
 	 */
 	list_for_each_entry(job, jobs, list) {
-		if (job->rw == READ || !(job->flags & BIT(DM_KCOPYD_WRITE_SEQ))) {
+		if (job->op == REQ_OP_READ ||
+		    !(job->flags & BIT(DM_KCOPYD_WRITE_SEQ))) {
 			list_del(&job->list);
 			return job;
 		}
@@ -518,7 +519,7 @@ static void complete_io(unsigned long error, void *context)
 	io_job_finish(kc->throttle);
 
 	if (error) {
-		if (op_is_write(job->rw))
+		if (op_is_write(job->op))
 			job->write_err |= error;
 		else
 			job->read_err = 1;
@@ -530,11 +531,11 @@ static void complete_io(unsigned long error, void *context)
 		}
 	}
 
-	if (op_is_write(job->rw))
+	if (op_is_write(job->op))
 		push(&kc->complete_jobs, job);
 
 	else {
-		job->rw = WRITE;
+		job->op = REQ_OP_WRITE;
 		push(&kc->io_jobs, job);
 	}
 
@@ -549,7 +550,7 @@ static int run_io_job(struct kcopyd_job *job)
 {
 	int r;
 	struct dm_io_request io_req = {
-		.bi_opf = job->rw,
+		.bi_opf = job->op,
 		.mem.type = DM_IO_PAGE_LIST,
 		.mem.ptr.pl = job->pages,
 		.mem.offset = 0,
@@ -570,7 +571,7 @@ static int run_io_job(struct kcopyd_job *job)
 
 	io_job_start(job->kc->throttle);
 
-	if (job->rw == READ)
+	if (job->op == REQ_OP_READ)
 		r = dm_io(&io_req, 1, &job->source, NULL);
 	else
 		r = dm_io(&io_req, job->num_dests, job->dests, NULL);
@@ -613,7 +614,7 @@ static int process_jobs(struct list_head *jobs, struct dm_kcopyd_client *kc,
 
 		if (r < 0) {
 			/* error this rogue job */
-			if (op_is_write(job->rw))
+			if (op_is_write(job->op))
 				job->write_err = (unsigned long) -1L;
 			else
 				job->read_err = 1;
@@ -816,7 +817,7 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
 	if (from) {
 		job->source = *from;
 		job->pages = NULL;
-		job->rw = READ;
+		job->op = REQ_OP_READ;
 	} else {
 		memset(&job->source, 0, sizeof job->source);
 		job->source.count = job->dests[0].count;
@@ -825,10 +826,10 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
 		/*
 		 * Use WRITE ZEROES to optimize zeroing if all dests support it.
 		 */
-		job->rw = REQ_OP_WRITE_ZEROES;
+		job->op = REQ_OP_WRITE_ZEROES;
 		for (i = 0; i < job->num_dests; i++)
 			if (!bdev_write_zeroes_sectors(job->dests[i].bdev)) {
-				job->rw = WRITE;
+				job->op = REQ_OP_WRITE;
 				break;
 			}
 	}
