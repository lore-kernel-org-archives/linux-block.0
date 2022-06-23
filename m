Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8AFCCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiFWTBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiFWTAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:36 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6422B8F98
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:59 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id q140so164215pgq.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDqNnq3ycTkek69rhOHXG+EejSmdPdxwDYQLdTGKsOQ=;
        b=eA7bJI1+mPmPezv9H+TYLRIqyNhASFG6H2mcw4pHjgebE2g++Fnz5I/dW4zCcJwnUo
         S1BuXfoP54Flx1YpDUhYoFr+OXz9K/RInBcCJcRmuBXz8a/G2PzOKD/FoSL2UXTVPwtP
         7RCgmh5YKuIfQnJu9EG+danjp8w6DEpR+7ptsQA652adIT/4H+J/8NCx5fVwIyaU4z3B
         6UjU2e483voxuNS5Mk0JEUM/pssZIpyXprN7yQ1Wc5TPIM3yvU/pj4H6xH+lyLItfAPz
         h5bKGQjCdwlBq8pANySyScgsWwG7s+wa+7IyiY+UW5lIKBhM4/EcCXbJTRjD7QqGM85q
         6gWA==
X-Gm-Message-State: AJIora8veInh2XUtPABJW9iBmVZxyoX+evJ5JM1tIOsP7W2rO/V9iYzn
        wwCdv5Ulg+rQTOsvZp+RkUCUS5Hyt8w=
X-Google-Smtp-Source: AGRyM1t9vZ23+yPgmIpqDR8YwUBjLiwOwGAb+CH1IqLMHL30r2AiK172aJsApEw1NkV6hWtfpGUrGw==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr8386592pgw.599.1656007559256;
        Thu, 23 Jun 2022 11:05:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 16/51] dm/kcopyd: Rename kcopyd_job.rw into kcopyd_job.op
Date:   Thu, 23 Jun 2022 11:04:53 -0700
Message-Id: <20220623180528.3595304-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code that assigns kcopyd_job.rw to the bio.op member shows that it
represents a request operation type (REQ_OP_). Rename kcopyd_job.rw into
kcopyd_job.op to make this clear and only assign REQ_OP_* constants to
that structure member. This patch does not change any functionality
since REQ_OP_READ = READ = 0 and REQ_OP_WRITE = WRITE = 1.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-kcopyd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 37b03ab7e5c9..a3d0d6ca95af 100644
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
-		.bi_op = job->rw,
+		.bi_op = job->op,
 		.bi_op_flags = 0,
 		.mem.type = DM_IO_PAGE_LIST,
 		.mem.ptr.pl = job->pages,
@@ -571,7 +572,7 @@ static int run_io_job(struct kcopyd_job *job)
 
 	io_job_start(job->kc->throttle);
 
-	if (job->rw == READ)
+	if (job->op == REQ_OP_READ)
 		r = dm_io(&io_req, 1, &job->source, NULL);
 	else
 		r = dm_io(&io_req, job->num_dests, job->dests, NULL);
@@ -614,7 +615,7 @@ static int process_jobs(struct list_head *jobs, struct dm_kcopyd_client *kc,
 
 		if (r < 0) {
 			/* error this rogue job */
-			if (op_is_write(job->rw))
+			if (op_is_write(job->op))
 				job->write_err = (unsigned long) -1L;
 			else
 				job->read_err = 1;
@@ -817,7 +818,7 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
 	if (from) {
 		job->source = *from;
 		job->pages = NULL;
-		job->rw = READ;
+		job->op = REQ_OP_READ;
 	} else {
 		memset(&job->source, 0, sizeof job->source);
 		job->source.count = job->dests[0].count;
@@ -826,10 +827,10 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
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
