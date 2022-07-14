Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49335C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiGNSIX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiGNSIR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:17 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CAA68722
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:12 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id v7so2600740pfb.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvL+X45jFqZ/NuM7m5MmSkmtTfBUuTj0MFPEqQi9goQ=;
        b=Wwm//LIQT+dUjFkotC4W1MnM82Ax61389SKPQKwsxOzib2e5v/5tYbyLiMCvhGEik1
         3vgE1lC4KaNNDhHgWpnC0VRxQZB7aA1bOGeYaUOdNr15B2kI9UAA2tzHh1vZJEXytNNN
         Mp3Vglh3TSSaMR29q64KVXymMKhUqIjS7DPVKRiGjYcM6c/jt+0dpgH+qO95q9n8Fkwq
         f1mnCtgg+oi5FaVfczVpeRDVlVWRM274F4LWCGrkgWgAM9jw4iFN2c+3ctXluYi1n1j5
         OObarV1D6AALNEP9MCcsmLZVjJeVPAPnM23geoknkwvYv6RlF+HKdGx0ambvNrQCBB5v
         QrHA==
X-Gm-Message-State: AJIora/9pQD7SkFMEduN+XRxZbeifi0xrXE2y7Q7OoG3V4JQmdU14EPX
        xpz5sQ5+F0dVYnI/QTeaMBA=
X-Google-Smtp-Source: AGRyM1tu2wEDYVESTVYUe3KCBzSOLrXqdnY49e61DSL4irXLNe1RClhqdfZ4vV+/5393GtazJ+RE4w==
X-Received: by 2002:a65:6a48:0:b0:412:a3c3:48e0 with SMTP id o8-20020a656a48000000b00412a3c348e0mr8402130pgu.382.1657822091747;
        Thu, 14 Jul 2022 11:08:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 22/63] dm/core: Rename kcopyd_job.rw into kcopyd.op
Date:   Thu, 14 Jul 2022 11:06:48 -0700
Message-Id: <20220714180729.1065367-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
Cc: Mikulas Patocka <mpatocka@redhat.com>
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
