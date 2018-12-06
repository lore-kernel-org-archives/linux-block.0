Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC5C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24520850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXXWMjxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLFQll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35022 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFQll (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so1237734qtc.2
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lcg2zF1imfNyveimZfa7nNlz5mO8GsZUtILSOxC+mSg=;
        b=bXXWMjxtYPwSge+21FnBLq8KO5ZuuQnl4xQSczn6L5OjEEC8qcPX8nn0ETibu4DwIT
         ijqXOD9NpANlMbYeM0U7kT6c0zF+3BBNzb2t5R3qxoSChdDx+heSQObG11T/QWA0m1DW
         kSqCdocM4v2YeaswKVleIVd2w4Na7vcGCCbZjcI+ck1XxUeBPqruoBlJTYdfpqIj7tq3
         FBd/PWF7Y5RhoByV7ioopLqnJAICSGx0LTgFA/sbZf88vqdMcdJx2QHntl+d3ld1DFzo
         vL6NsqvLGcQEKs9JbcY0FcJdI7kPrs/Nt7KWI3lbzrsZlBEQwMvaswwkghhjotCGdE5N
         LpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Lcg2zF1imfNyveimZfa7nNlz5mO8GsZUtILSOxC+mSg=;
        b=V2uWZQnUS7mk9C80FUwd3XBBLM8DHRpC3frTpbWnSOlxcBSRpEJBpzCJ/krNn2xP4p
         AZHbugZc0BtlPFMMdqBnxgn3BFrvOo9cDbUwAKeCYunY5Tu30FuMAHnXGPWb3DZqUk70
         KHojkGXCARkfexyjUThZ5604EUxY8gRnUAWGE+C5sw+Z3Tsqo8DrTsayV5tCDxE+0Ae3
         JJ6MKjrAWacWaRXwlly6x67P/0uW0RZ6pMTa95uSSsMDYh7evvGsqGuDKJL1ED+9MjJq
         Eu43aV0Xo0QSDPsSC26Aq24+eMpe6pHvus/0LeKnJs4Jcjp+bTmK8ntmFAITqp6A/YV1
         yqQQ==
X-Gm-Message-State: AA+aEWZUBy1mdmfPGuPQTvwBSpiagrYe4ssoXTVh5tb/P7O31woogzJH
        pxWkaKvGxN+c0JBCPnNrORc=
X-Google-Smtp-Source: AFSGD/WwTggLZMmPm8zEhSJJVdCoUyGlt5qRP5wQbg2YwXwbLz8oLBORAbWBA+NfsVGNU/w9Xu/glg==
X-Received: by 2002:a0c:96b5:: with SMTP id a50mr28051792qvd.33.1544114500336;
        Thu, 06 Dec 2018 08:41:40 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f201sm373039qke.0.2018.12.06.08.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:39 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 7/7] dm: remove the pending IO accounting
Date:   Thu,  6 Dec 2018 11:41:22 -0500
Message-Id: <20181206164122.2166-8-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

Remove the "pending" atomic counters, that duplicate block-core's
in_flight counters, and update md_in_flight() to look at percpu
in_flight counters.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h |  2 --
 drivers/md/dm.c      | 34 +++++++++++++++-------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 224d44503a06..6fe883fac471 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -65,7 +65,6 @@ struct mapped_device {
 	 */
 	struct work_struct work;
 	wait_queue_head_t wait;
-	atomic_t pending[2];
 	spinlock_t deferred_lock;
 	struct bio_list deferred;
 
@@ -119,7 +118,6 @@ struct mapped_device {
 	struct srcu_struct io_barrier;
 };
 
-int md_in_flight(struct mapped_device *md);
 void disable_write_same(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a8ae7931bce7..d4bc4237b09a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -646,25 +646,30 @@ static void free_tio(struct dm_target_io *tio)
 	bio_put(&tio->clone);
 }
 
-int md_in_flight(struct mapped_device *md)
+static bool md_in_flight(struct mapped_device *md)
 {
-	return atomic_read(&md->pending[READ]) +
-	       atomic_read(&md->pending[WRITE]);
+	int cpu;
+	struct hd_struct *part = &dm_disk(md)->part0;
+
+	for_each_possible_cpu(cpu) {
+		if (part_stat_local_read_cpu(part, in_flight[0], cpu) ||
+		    part_stat_local_read_cpu(part, in_flight[1], cpu))
+			return true;
+	}
+
+	return false;
 }
 
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
-	int rw = bio_data_dir(bio);
 
 	io->start_time = jiffies;
 
 	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
 			      &dm_disk(md)->part0);
 
-	atomic_inc(&md->pending[rw]);
-
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
@@ -676,8 +681,6 @@ static void end_io_acct(struct dm_io *io)
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 	unsigned long duration = jiffies - io->start_time;
-	int pending;
-	int rw = bio_data_dir(bio);
 
 	generic_end_io_acct(md->queue, bio_op(bio), &dm_disk(md)->part0,
 			    io->start_time);
@@ -687,16 +690,11 @@ static void end_io_acct(struct dm_io *io)
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    true, duration, &io->stats_aux);
 
-	/*
-	 * After this is decremented the bio must not be touched if it is
-	 * a flush.
-	 */
-	pending = atomic_dec_return(&md->pending[rw]);
-	pending += atomic_read(&md->pending[rw^0x1]);
-
 	/* nudge anyone waiting on suspend queue */
-	if (!pending)
-		wake_up(&md->wait);
+	if (unlikely(waitqueue_active(&md->wait))) {
+		if (!md_in_flight(md))
+			wake_up(&md->wait);
+	}
 }
 
 /*
@@ -1904,8 +1902,6 @@ static struct mapped_device *alloc_dev(int minor)
 	if (!md->disk)
 		goto bad;
 
-	atomic_set(&md->pending[0], 0);
-	atomic_set(&md->pending[1], 0);
 	init_waitqueue_head(&md->wait);
 	INIT_WORK(&md->work, dm_wq_work);
 	init_waitqueue_head(&md->eventq);
-- 
2.15.0

