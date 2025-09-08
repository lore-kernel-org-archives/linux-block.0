Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CD31C57D
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357148; cv=none; b=LieRdwvhkkI5HgTgpbHK6n1IuuxL6iZiCI1U94PmZNKOGyQbbWTW/bbwsA8A6e1pbTaNYSL92W5k3bP8bZMCEoutuZ2iQwy8707DQwiOdfcjj9ivk4MT5ymoFh4k3oDGGHiCgYcRNRaqyoFPFXgIYAyuIu5ll/kj8NgfhMS448k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357148; c=relaxed/simple;
	bh=bs4Y23mCgkbnt3UBx65Ms29RtcfnigDOozwdxRrutj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdvevKjjqyzXiGQhxc+9HOdlY+yRP6+CmxUI01Fx/tlCA0IbK8aV9TwxZxruek/LnH4QtBDKogmigKXfemBubpeSEZQprUc0J3UKfaWfMX9POMBpU6MjKLN7ey6b6gRTRrqu96dQnAhawabFwlsx/jE3cmCoGaIkAeuT9HbggoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BuYk+9mw; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BuYk+9mw"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-80f6846bf6dso67794585a.2
        for <linux-block@vger.kernel.org>; Mon, 08 Sep 2025 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757357145; x=1757961945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/DTdCtvVCgsE2r4Q32039ITkF16WxVWkLE1/TEOzfA=;
        b=BuYk+9mw6KDSQA3ndl+WZDc7PLrIKDYEuBjEEqAtEhqFIDzcW+PdharjtF+G28Mqtk
         HCl5SjmPyY2Xa1aH49OGRv0bwLgmU3k2rTnbGXN0x4HNEhGFCo3+7B+UB7M9GsDjuFBm
         5PerThB+LKlhSRvdTjdtgiemsaWrYsEQVcwv8jX8P+KgiL8rsvIU6LoGg8/vMhXl8xO5
         Es/nM1P0Tks2zSQPBfPmvgNlxBgcCZHkWknOIYKzXTjWzYrUzt8QneTj1hvkaAn7jWRZ
         pZr9YgrBEEAIRElqsdb3v9xRDA7dW8Vz+/3aWL3J8JGv5Zsbpeg5eSyEvO4gbVN6nyA4
         5gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357145; x=1757961945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/DTdCtvVCgsE2r4Q32039ITkF16WxVWkLE1/TEOzfA=;
        b=mbr0V1OCZlNsVzHs6uTwnkFiEafDhHXeObhk262HrL3FwwzYWQEFV9SC3rtuzXJNjs
         h+5kZH8gTuAqHhWZKDQf9Z5V9U8t4pQbu2cwKHx+odUuhZLy/edvlrROFlVcVEFb4Yz4
         uBtErhSekYoVCxB8cJ8xPWnc4KlXgM2uazsHsBdXTxaUwjVGafJdT9fMqRrwteu1egyZ
         zCTsWUzrqZ5ZG2CufrFy755PU6Y2xSgt7vBxrmtbbx6WLWYS8flcKnNWEZyrEcqooavs
         xC1lZKIyBkjhpCGsR0K0t9IIemthr0xotaiTO0vtW9/A/zTmBzJVkD7MrLN6Yaq4Q3bK
         2lBA==
X-Forwarded-Encrypted: i=1; AJvYcCVq+2i5jwheeEW6hqIwwh1kqDRKkF6D/T+3UE7tTUuRarTt/DgKBIApH30VGQv04tR+n0M9jNYoQ4QTAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRi+5hw9Fdpz5YPOocZ08RA5jcDC0DH9jutZpDrGgN+OcTwGh
	Vs4hPBKz2BQUiICkEeao0lBjBb8A0sMwaC12INyn6Yue8Y53XHyLqi1ZM8X2gUDQ69A7ZufT608
	6mfPBcBlikXQyF7B+s7EDNIFSuUwOBV5ADwZs
X-Gm-Gg: ASbGnctFWGsfr+cFtek0gJ1bYHJIYLGE8eB3VY7KzXQq8+5PDywebxhU1W3fWbqA4Hk
	lTeB3R9CDYhEGox5d/R9msucc7B4/nwKGP6FssKgBdAu/ShAUHkFM5363Sne/hcaNHjFpDBvwTp
	aqN6LnucATlGeQr3e8oH/YZS1f3TmklKIoZIyt6drBOALjGu9rZk3gEO1a6TvwAF2nL63X11XLM
	4ISD8hdDagZPiKFN9TpMgg/3lyoyzH8LpmnskHdecKP4pd9dliJBvnbZCaBQ4NgKT+iSojAukle
	g3mJ6iANlIiJ6fT+iCexZbEs60xVr5/rBvMbFjmOQPdZLMjxN3/VtTa2ZvrFiL1HRK6SyTd2
X-Google-Smtp-Source: AGHT+IHw6VuqllmK6/n48bgXeNTTwG0cfLASlmhRZTLoDOwdhBdjsJdOlcCJluCNJ3jDSZ4WJ48NIblCq0t/
X-Received: by 2002:a05:620a:701c:b0:7f9:c230:2cbe with SMTP id af79cd13be357-813c2361ca5mr484273685a.11.1757357144716;
        Mon, 08 Sep 2025 11:45:44 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-80aab3b4eacsm42261585a.8.2025.09.08.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:45:44 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 028AD340199;
	Mon,  8 Sep 2025 12:45:44 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0699EE41BCB; Mon,  8 Sep 2025 12:45:44 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: consolidate nr_io_ready and nr_queues_ready
Date: Mon,  8 Sep 2025 12:45:41 -0600
Message-ID: <20250908184542.472230-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_mark_io_ready() tracks whether all the ublk_device's I/Os have been
fetched by incrementing ublk_queue's nr_io_ready count and incrementing
ublk_device's nr_queues_ready count if the whole queue is ready.
Simplify the logic by just tracking the total number of fetched I/Os on
each ublk_device. When this count reaches nr_hw_queues * queue_depth,
the ublk_device is ready to receive I/O.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3cf6d344d1c0..aa64f530d5e9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -199,11 +199,10 @@ struct ublk_queue {
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
-	unsigned short nr_io_ready;	/* how many ios setup */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
 	struct ublk_io ios[];
 };
 
@@ -232,11 +231,11 @@ struct ublk_device {
 	struct mm_struct	*mm;
 
 	struct ublk_params	params;
 
 	struct completion	completion;
-	unsigned int		nr_queues_ready;
+	u32			nr_io_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 };
@@ -1497,13 +1496,10 @@ static const struct blk_mq_ops ublk_mq_ops = {
 
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
 
-	/* All old ioucmds have to be completed */
-	ubq->nr_io_ready = 0;
-
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
 		/*
 		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
@@ -1548,11 +1544,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
 
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
-	ub->nr_queues_ready = 0;
+	ub->nr_io_ready = 0;
 	ub->unprivileged_daemons = false;
 	ub->ublksrv_tgid = -1;
 }
 
 static struct gendisk *ublk_get_disk(struct ublk_device *ub)
@@ -1846,13 +1842,15 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
-static inline bool ublk_queue_ready(struct ublk_queue *ubq)
+static inline bool ublk_dev_ready(const struct ublk_device *ub)
 {
-	return ubq->nr_io_ready == ubq->q_depth;
+	u32 total = (u32)ub->dev_info.nr_hw_queues * ub->dev_info.queue_depth;
+
+	return ub->nr_io_ready == total;
 }
 
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
@@ -1972,20 +1970,18 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
 	ublk_set_canceling(ub, false);
 	mutex_unlock(&ub->cancel_mutex);
 }
 
 /* device can only be started after all IOs are ready */
-static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_mark_io_ready(struct ublk_device *ub)
 	__must_hold(&ub->mutex)
 {
-	ubq->nr_io_ready++;
-	if (ublk_queue_ready(ubq))
-		ub->nr_queues_ready++;
 	if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
 		ub->unprivileged_daemons = true;
 
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+	ub->nr_io_ready++;
+	if (ublk_dev_ready(ub)) {
 		/* now we are ready for handling ublk io request */
 		ublk_reset_io_flags(ub);
 		complete_all(&ub->completion);
 	}
 }
@@ -2187,12 +2183,12 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	 * When handling FETCH command for setting up ublk uring queue,
 	 * ub->mutex is the innermost lock, and we won't block for handling
 	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
 	 */
 	mutex_lock(&ub->mutex);
-	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-	if (ublk_queue_ready(ubq)) {
+	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
+	if (ublk_dev_ready(ub)) {
 		ret = -EBUSY;
 		goto out;
 	}
 
 	/* allow each command to be FETCHed at most once */
@@ -2207,11 +2203,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
 	if (ret)
 		goto out;
 
 	WRITE_ONCE(io->task, get_task_struct(current));
-	ublk_mark_io_ready(ub, ubq);
+	ublk_mark_io_ready(ub);
 out:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
-- 
2.45.2

