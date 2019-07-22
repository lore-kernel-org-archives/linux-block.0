Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F30C76194
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5564321985
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMn0Hwbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfGVNKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:10:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37330 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfGVNKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id i70so6904627pgd.4
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PL4wujbDE/jVNm+cD6uv0bxeBq10mT3Y+rFvonbxsNc=;
        b=cMn0Hwbmr1DioULhwjef22r6ESF9b6HnZEpFttS1rc6wi51ll/EbEyMA6OH7Y31uXS
         YMJ/TQ6odtO+zfte+IAmZKMylCQ7fDD13dQi1X0nVHWE36T14l2F9VoWZlSjO4rLyUWY
         bDKL2dHDKwKOC8l/9h0v1OlMTPZYadun/jlM/pxADIAP/Evd+yo1s3grNScLFEmtghv9
         kdThtJvHbxdgBU1VJhRK7iof5cPZP1fhqHUKtpvt5Czg7T6PmKqa/3nwwlUSPap7Yq0p
         eep5k7wo43f+0G1P7mFWaRxs5EJWrZZItbRRfRMbXFegkSOtFwQ99lqfv8BmLS1K6iYl
         tJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PL4wujbDE/jVNm+cD6uv0bxeBq10mT3Y+rFvonbxsNc=;
        b=hIFT1yEmzhJ1hUeEAk3hJVWRxg1fCV8TBXuI8TElVZqTRrehsSLdZSwYB0TP2Plz7e
         +L/puPRetS16OMPRLZyXzYwWWWtwrPt11YvCaoSBkyEWIIiWYQuao2GTJfljlXSO6f1Y
         AvzNjwFOIBRkbvSBZ7NXwxSPwGqu2b/EoQBb9LgkJcIucIrR9N2rqqPeVgIcZabX2pod
         BhmipuZEuR460y+SFxyq3y4qTBeQU6TxZYWetjVnBLWNSK4dTCnJnaZ8XiwcaSSTfCkl
         Ayct44TUL7hHg9V+DLTHnZObCSbCIDnxT4TBlYBKpDtdDETLFEi76wunuoiTezOL+JkV
         qTug==
X-Gm-Message-State: APjAAAU2g5Q51oMmZqxtqMFNRbrzGM6lxw8NvasDJxIrisg9bH36xhkC
        qvoY7FitrYybigtJIzp0bkCS+Q==
X-Google-Smtp-Source: APXvYqzxj72JpdvTUlUQ8PuSJszrbEqTeVOa7yJTQ8S8TQ7AXPj99cAP4+GA3ADuhMU3Nsp84BGudg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr27270562pjr.116.1563801013959;
        Mon, 22 Jul 2019 06:10:13 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 2/7] mmc: core: Add MMC packed request function
Date:   Mon, 22 Jul 2019 21:09:37 +0800
Message-Id: <4c2e5104da5497985c0d997934e6dc475b15c8f9.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some SD controllers can support packed command or packed request, that
means it can package several requests to host controller to be handled
at one time, which can reduce interrutps and improve the DMA transfer.
As a result, the I/O performence can be improved.

Thus this patch adds MMC packed function to support packed requests or
packe command.

The basic concept of this function is that, we try to collect more
requests from block layer as much as possible to be linked into
MMC packed queue by mmc_blk_packed_issue_rw_rq(). When the last
request of the hardware queue comes, or the collected request numbers
are larger than 16, or a larger request comes, then we can start to
pakage a packed request to host controller. The MMC packed function
also supplies packed algorithm operations to help to package qualified
requests. After finishing the packed request, the MMC packed function
will help to complete each request, at the same time, the MMC packed
queue will allow to collect more requests from block layer. After
completing each request, the MMC packed function can try to package
another packed request to host controller directly in the complete path,
if there are enough requests in MMC packed queue or the request pending
flag is not set. If the pending flag was set, we should let the
mmc_blk_packed_issue_rw_rq() collect more request as much as possible.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/core/Kconfig   |    2 +
 drivers/mmc/core/Makefile  |    1 +
 drivers/mmc/core/block.c   |   71 ++++++-
 drivers/mmc/core/block.h   |    3 +-
 drivers/mmc/core/core.c    |   51 +++++
 drivers/mmc/core/core.h    |    3 +
 drivers/mmc/core/packed.c  |  478 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/queue.c   |   28 ++-
 include/linux/mmc/core.h   |    1 +
 include/linux/mmc/host.h   |    3 +
 include/linux/mmc/packed.h |  123 ++++++++++++
 11 files changed, 760 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/core/packed.c
 create mode 100644 include/linux/mmc/packed.h

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index c12fe13..50d1a2f 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -81,3 +81,5 @@ config MMC_TEST
 	  This driver is only of interest to those developing or
 	  testing a host driver. Most people should say N here.
 
+config MMC_PACKED
+	bool
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 95ffe00..dd303d9 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
+obj-$(CONFIG_MMC_PACKED)	+= packed.o
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a43..e7a8b2c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -44,6 +44,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
+#include <linux/mmc/packed.h>
 
 #include <linux/uaccess.h>
 
@@ -2208,11 +2209,77 @@ static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
 {
 	if (mq->use_cqe)
 		return host->cqe_ops->cqe_wait_for_idle(host);
+	else if (host->packed)
+		return mmc_packed_wait_for_idle(host->packed);
 
 	return mmc_blk_rw_wait(mq, NULL);
 }
 
-enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_packed_req_done(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq =
+		container_of(mrq, struct mmc_queue_req, brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+
+	mutex_lock(&mq->complete_lock);
+	mmc_blk_mq_poll_completion(mq, req);
+	mutex_unlock(&mq->complete_lock);
+
+	mmc_blk_mq_post_req(mq, req);
+}
+
+static int mmc_blk_packed_issue_rw_rq(struct mmc_queue *mq, struct request *req,
+				      bool last)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
+	unsigned long nr_rqs;
+	int err;
+
+	/*
+	 * If the packed queue has pumped all requests, then we should check if
+	 * need retuning firstly.
+	 */
+	nr_rqs = mmc_packed_queue_length(host->packed);
+	if (!nr_rqs)
+		host->retune_now = host->need_retune && !host->hold_retune;
+
+	mutex_lock(&mq->complete_lock);
+	mmc_retune_hold(host);
+	mutex_unlock(&mq->complete_lock);
+
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+	mmc_pre_req(host, &mqrq->brq.mrq);
+	mqrq->brq.mrq.done = mmc_blk_packed_req_done;
+
+	err = mmc_packed_start_req(host, &mqrq->brq.mrq);
+	if (err) {
+		mutex_lock(&mq->complete_lock);
+		mmc_retune_release(host);
+		mutex_unlock(&mq->complete_lock);
+
+		mmc_post_req(host, &mqrq->brq.mrq, err);
+
+		return err;
+	}
+
+	/*
+	 * If it is the last request from block layer or a larger request or
+	 * request count is larger than MMC_PACKED_MAX_REQUEST_COUNT, we should
+	 * pump requests to controller. Otherwise we should try to combine
+	 * requests as much as we can.
+	 */
+	if (last || blk_rq_bytes(req) > MMC_PACKED_FLUSH_SIZE ||
+	    nr_rqs > MMC_PACKED_MAX_REQUEST_COUNT)
+		mmc_packed_pump_requests(host->packed);
+
+	return 0;
+}
+
+enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req,
+				    bool last)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -2257,6 +2324,8 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 		case REQ_OP_WRITE:
 			if (mq->use_cqe)
 				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
+			else if (host->packed)
+				ret = mmc_blk_packed_issue_rw_rq(mq, req, last);
 			else
 				ret = mmc_blk_mq_issue_rw_rq(mq, req);
 			break;
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f6..8bfb89f 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -9,7 +9,8 @@
 
 enum mmc_issued;
 
-enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req);
+enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req,
+				    bool last);
 void mmc_blk_mq_complete(struct request *req);
 void mmc_blk_mq_recovery(struct mmc_queue *mq);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2211273..924e733 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/packed.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
 
@@ -329,6 +330,7 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 
+	INIT_LIST_HEAD(&mrq->packed_list);
 	return 0;
 }
 
@@ -487,6 +489,55 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL(mmc_cqe_start_req);
 
+int mmc_packed_start_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	int err;
+
+	if (mmc_card_removed(host->card))
+		return -ENOMEDIUM;
+
+	err = mmc_retune(host);
+	if (err)
+		return err;
+
+	mrq->host = host;
+
+	mmc_mrq_pr_debug(host, mrq, true);
+
+	err = mmc_mrq_prep(host, mrq);
+	if (err)
+		return err;
+
+	err = mmc_packed_queue_request(host->packed, mrq);
+	if (err)
+		return err;
+
+	trace_mmc_request_start(host, mrq);
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_packed_start_req);
+
+void mmc_packed_request_done(struct mmc_host *host, struct mmc_request *mrq)
+{
+	mmc_should_fail_request(host, mrq);
+
+	/* Flag re-tuning needed on CRC errors */
+	if (mrq->data && mrq->data->error == -EILSEQ)
+		mmc_retune_needed(host);
+
+	trace_mmc_request_done(host, mrq);
+
+	if (mrq->data) {
+		pr_debug("%s:     %d bytes transferred: %d\n",
+			 mmc_hostname(host),
+			 mrq->data->bytes_xfered, mrq->data->error);
+	}
+
+	mrq->done(mrq);
+}
+EXPORT_SYMBOL(mmc_packed_request_done);
+
 /**
  *	mmc_cqe_request_done - CQE has finished processing an MMC request
  *	@host: MMC host which completed request
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 328c78d..b88b3b3 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -138,6 +138,9 @@ static inline void mmc_claim_host(struct mmc_host *host)
 void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_cqe_recovery(struct mmc_host *host);
 
+int mmc_packed_start_req(struct mmc_host *host, struct mmc_request *mrq);
+void mmc_packed_request_done(struct mmc_host *host, struct mmc_request *mrq);
+
 /**
  *	mmc_pre_req - Prepare for a new request
  *	@host: MMC host to prepare command
diff --git a/drivers/mmc/core/packed.c b/drivers/mmc/core/packed.c
new file mode 100644
index 0000000..91b7e9d
--- /dev/null
+++ b/drivers/mmc/core/packed.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MMC packed request support
+//
+// Copyright (C) 2019 Linaro, Inc.
+// Author: Baolin Wang <baolin.wang@linaro.org>
+
+#include <linux/slab.h>
+#include <linux/export.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/packed.h>
+
+#include "block.h"
+#include "card.h"
+#include "core.h"
+#include "host.h"
+#include "queue.h"
+
+#define MMC_PACKED_REQ_DIR(mrq)					\
+	(((mrq)->cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||	\
+	  (mrq)->cmd->opcode == MMC_READ_SINGLE_BLOCK) ? READ : WRITE)
+
+static void mmc_packed_allow_pump(struct mmc_packed *packed)
+{
+	struct mmc_packed_request *prq = &packed->prq;
+	unsigned long flags, remains;
+	bool need_pump;
+
+	/* Allow requests to be pumped after completing previous requests. */
+	spin_lock_irqsave(&packed->lock, flags);
+	prq->nr_reqs = 0;
+	need_pump = !packed->rqs_pending;
+	remains = packed->rqs_len;
+
+	if (packed->waiting_for_idle && !remains) {
+		packed->waiting_for_idle = false;
+		wake_up(&packed->wait_queue);
+	}
+
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	/*
+	 * If there are not enough requests in queue and the request pending
+	 * flag was set, then do not pump requests here, and let the
+	 * mmc_blk_packed_issue_rw_rq() combine more requests and pump them.
+	 */
+	if ((need_pump && remains > 0) || remains >= packed->max_entries)
+		mmc_packed_pump_requests(packed);
+}
+
+static void mmc_packed_complete_work(struct work_struct *work)
+{
+	struct mmc_packed *packed =
+		container_of(work, struct mmc_packed, complete_work);
+	struct mmc_request *mrq, *t;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&packed->lock, flags);
+	list_splice_tail_init(&packed->complete_list, &head);
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	list_for_each_entry_safe(mrq, t, &head, packed_list) {
+		list_del(&mrq->packed_list);
+		mmc_packed_request_done(packed->host, mrq);
+	}
+
+	mmc_packed_allow_pump(packed);
+}
+
+/**
+ * mmc_packed_finalize_requests - finalize one packed request
+ * if the packed request is done
+ * @host: the host controller
+ * @prq: the packed request need to be finalized
+ * @err: error number
+ */
+void mmc_packed_finalize_requests(struct mmc_host *host,
+				  struct mmc_packed_request *prq)
+{
+	struct mmc_packed *packed = host->packed;
+	struct mmc_request *mrq, *t;
+	LIST_HEAD(head);
+	unsigned long flags;
+
+	if (packed->ops->unprepare_hardware &&
+	    packed->ops->unprepare_hardware(packed))
+		pr_err("failed to unprepare hardware\n");
+
+	/*
+	 * Clear busy flag to let more requests link into MMC packed queue,
+	 * but now we can not pump them to controller, we should wait for all
+	 * requests are completed. During the period of completing request,
+	 * we should collect more requests from block layer as much as possible.
+	 */
+	spin_lock_irqsave(&packed->lock, flags);
+	list_splice_tail_init(&prq->list, &head);
+	packed->busy = false;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	list_for_each_entry_safe(mrq, t, &head, packed_list) {
+		if (mmc_host_done_complete(host)) {
+			list_del(&mrq->packed_list);
+
+			mmc_packed_request_done(host, mrq);
+		}
+	}
+
+	/*
+	 * If we cannot complete these requests in this context, so
+	 * queue a work to do this.
+	 *
+	 * Note: we must make sure all requests are completed before
+	 * pumping new requests to host controller.
+	 */
+	if (!mmc_host_done_complete(host)) {
+		spin_lock_irqsave(&packed->lock, flags);
+		list_splice_tail_init(&head, &packed->complete_list);
+		spin_unlock_irqrestore(&packed->lock, flags);
+
+		schedule_work(&packed->complete_work);
+		return;
+	}
+
+	mmc_packed_allow_pump(packed);
+}
+EXPORT_SYMBOL_GPL(mmc_packed_finalize_requests);
+
+/**
+ * mmc_packed_queue_length - return the request number in MMC packed queue
+ * @packed: the mmc_packed
+ */
+unsigned long mmc_packed_queue_length(struct mmc_packed *packed)
+{
+	unsigned long flags;
+	unsigned long len;
+
+	spin_lock_irqsave(&packed->lock, flags);
+	len = packed->rqs_len;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_queue_is_empty);
+
+/**
+ * mmc_packed_queue_is_busy - if the MMC packed queue is busy or not
+ * @packed: the mmc_packed
+ *
+ * If the MMC hardware is busy now, we should not add more rquests
+ * into MMC packed queue, instead we should return busy to block layer,
+ * to make block layer tell MMC layer there are more requests will be coming.
+ */
+bool mmc_packed_queue_is_busy(struct mmc_packed *packed)
+{
+	unsigned long flags;
+	bool busy;
+
+	spin_lock_irqsave(&packed->lock, flags);
+	busy = packed->busy;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	return busy;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_queue_is_busy);
+
+/**
+ * mmc_packed_queue_commit_rqs - tell us more request will be coming
+ * @packed: the mmc_packed
+ */
+void mmc_packed_queue_commit_rqs(struct mmc_packed *packed)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&packed->lock, flags);
+
+	/* Set pending flag which indicates more request will be coming */
+	if (!packed->rqs_pending)
+		packed->rqs_pending = true;
+
+	spin_unlock_irqrestore(&packed->lock, flags);
+}
+EXPORT_SYMBOL_GPL(mmc_packed_queue_is_busy);
+
+/**
+ * mmc_packed_queue_request - add one mmc request into packed list
+ * @packed: the mmc_packed
+ * @mrq: the MMC request
+ */
+int mmc_packed_queue_request(struct mmc_packed *packed,
+			     struct mmc_request *mrq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&packed->lock, flags);
+
+	if (!packed->running) {
+		spin_unlock_irqrestore(&packed->lock, flags);
+		return -ESHUTDOWN;
+	}
+
+	list_add_tail(&mrq->packed_list, &packed->list);
+
+	/* New request comes, then clear pending flag */
+	if (packed->rqs_pending)
+		packed->rqs_pending = false;
+
+	packed->rqs_len++;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_queue_request);
+
+/**
+ * mmc_packed_queue_start - start the MMC packed queue
+ * @packed: the mmc_packed
+ */
+int mmc_packed_queue_start(struct mmc_packed *packed)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&packed->lock, flags);
+
+	if (packed->running || packed->busy) {
+		spin_unlock_irqrestore(&packed->lock, flags);
+		return -EBUSY;
+	}
+
+	packed->running = true;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_queue_start);
+
+static bool mmc_packed_queue_is_idle(struct mmc_packed *packed)
+{
+	unsigned long flags;
+	bool is_idle;
+
+	spin_lock_irqsave(&packed->lock, flags);
+	is_idle = !packed->prq.nr_reqs && list_empty(&packed->list);
+
+	packed->waiting_for_idle = !is_idle;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	return is_idle;
+}
+
+/**
+ * mmc_packed_queue_stop - stop the MMC packed queue
+ * @packed: the mmc_packed
+ */
+int mmc_packed_queue_stop(struct mmc_packed *packed)
+{
+	unsigned long flags;
+	u32 timeout = 500;
+	int ret;
+
+	ret = wait_event_timeout(packed->wait_queue,
+				 mmc_packed_queue_is_idle(packed),
+				 msecs_to_jiffies(timeout));
+	if (ret == 0) {
+		pr_warn("could not stop mmc packed queue\n");
+		return -ETIMEDOUT;
+	}
+
+	spin_lock_irqsave(&packed->lock, flags);
+	packed->running = false;
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_queue_stop);
+
+/**
+ * mmc_packed_wait_for_idle - wait for all requests are finished
+ * @packed: the mmc_packed
+ */
+int mmc_packed_wait_for_idle(struct mmc_packed *packed)
+{
+	wait_event(packed->wait_queue, mmc_packed_queue_is_idle(packed));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_wait_for_idle);
+
+/**
+ * mmc_packed_algo_rw - the algorithm to pack read or write requests
+ * @packed: the mmc_packed
+ *
+ * TODO: we can add more condition to decide if we can package this
+ * request or not.
+ */
+void mmc_packed_algo_rw(struct mmc_packed *packed)
+{
+	struct mmc_packed_request *prq = &packed->prq;
+	struct mmc_request *mrq, *t;
+	u32 i = 0;
+
+	list_for_each_entry_safe(mrq, t, &packed->list, packed_list) {
+		if (++i > packed->max_entries)
+			break;
+
+		list_move_tail(&mrq->packed_list, &prq->list);
+		prq->nr_reqs++;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_packed_algo_rw);
+
+/**
+ * mmc_packed_algo_ro - the algorithm only to pack read requests
+ * @packed: the mmc_packed
+ *
+ * TODO: more condition need to consider
+ */
+void mmc_packed_algo_ro(struct mmc_packed *packed)
+{
+	struct mmc_packed_request *prq = &packed->prq;
+	struct mmc_request *mrq, *t;
+	u32 i = 0;
+
+	list_for_each_entry_safe(mrq, t, &packed->list, packed_list) {
+		if (++i > packed->max_entries)
+			break;
+
+		if (MMC_PACKED_REQ_DIR(mrq) != READ) {
+			if (!prq->nr_reqs) {
+				list_move_tail(&mrq->packed_list, &prq->list);
+				prq->nr_reqs = 1;
+			}
+
+			break;
+		}
+
+		list_move_tail(&mrq->packed_list, &prq->list);
+		prq->nr_reqs++;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_packed_algo_ro);
+
+/**
+ * mmc_packed_algo_wo - the algorithm only to pack write requests
+ * @packed: the mmc_packed
+ *
+ * TODO: more condition need to consider
+ */
+void mmc_packed_algo_wo(struct mmc_packed *packed)
+{
+	struct mmc_packed_request *prq = &packed->prq;
+	struct mmc_request *mrq, *t;
+	u32 i = 0;
+
+	list_for_each_entry_safe(mrq, t, &packed->list, packed_list) {
+		if (++i > packed->max_entries)
+			break;
+
+		if (MMC_PACKED_REQ_DIR(mrq) != WRITE) {
+			if (!prq->nr_reqs) {
+				list_move_tail(&mrq->packed_list, &prq->list);
+				prq->nr_reqs = 1;
+			}
+
+			break;
+		}
+
+		list_move_tail(&mrq->packed_list, &prq->list);
+		prq->nr_reqs++;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_packed_algo_wo);
+
+/**
+ * mmc_packed_pump_requests - start to pump packed request to host controller
+ * @packed: the mmc_packed
+ */
+void mmc_packed_pump_requests(struct mmc_packed *packed)
+{
+	struct mmc_packed_request *prq = &packed->prq;
+	struct mmc_host *host = packed->host;
+	struct mmc_request *mrq;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&packed->lock, flags);
+
+	/* Make sure we are not already running a packed request */
+	if (packed->prq.nr_reqs) {
+		spin_unlock_irqrestore(&packed->lock, flags);
+		return;
+	}
+
+	/* Make sure there are remain requests need to pump */
+	if (list_empty(&packed->list) || !packed->running) {
+		spin_unlock_irqrestore(&packed->lock, flags);
+		return;
+	}
+
+	/* Try to package requests */
+	packed->ops->packed_algo(packed);
+
+	packed->rqs_len -= packed->prq.nr_reqs;
+	packed->busy = true;
+
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	if (packed->ops->prepare_hardware) {
+		ret = packed->ops->prepare_hardware(packed);
+		if (ret) {
+			pr_err("failed to prepare hardware\n");
+			goto error;
+		}
+	}
+
+	ret = packed->ops->packed_request(packed, prq);
+	if (ret) {
+		pr_err("failed to packed requests\n");
+		goto error;
+	}
+
+	return;
+
+error:
+	spin_lock_irqsave(&packed->lock, flags);
+
+	list_for_each_entry(mrq, &packed->prq.list, packed_list) {
+		struct mmc_data *data = mrq->data;
+
+		data->error = ret;
+		data->bytes_xfered = 0;
+	}
+
+	spin_unlock_irqrestore(&packed->lock, flags);
+
+	mmc_packed_finalize_requests(host, prq);
+}
+EXPORT_SYMBOL_GPL(mmc_packed_pump_requests);
+
+int mmc_packed_init(struct mmc_host *host, const struct mmc_packed_ops *ops,
+		    int max_packed)
+{
+	struct mmc_packed *packed;
+
+	packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
+	if (!packed)
+		return -ENOMEM;
+
+	packed->max_entries = max_packed;
+	packed->ops = ops;
+	packed->host = host;
+	spin_lock_init(&packed->lock);
+	INIT_LIST_HEAD(&packed->list);
+	INIT_LIST_HEAD(&packed->complete_list);
+	INIT_LIST_HEAD(&packed->prq.list);
+	INIT_WORK(&packed->complete_work, mmc_packed_complete_work);
+	init_waitqueue_head(&packed->wait_queue);
+
+	host->packed = packed;
+	packed->running = true;
+
+	dev_info(host->parent, "Enable MMC packed requests, max packed = %d\n",
+		 packed->max_entries);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_init);
+
+void mmc_packed_exit(struct mmc_host *host)
+{
+	struct mmc_packed *packed = host->packed;
+
+	mmc_packed_queue_stop(packed);
+	kfree(packed);
+	host->packed = NULL;
+}
+EXPORT_SYMBOL_GPL(mmc_packed_exit);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index e327f80..0a1782d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -244,7 +244,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct mmc_host *host = card->host;
 	enum mmc_issue_type issue_type;
 	enum mmc_issued issued;
-	bool get_card, cqe_retune_ok;
+	bool get_card, cqe_retune_ok, last = false;
 	int ret;
 
 	if (mmc_card_removed(mq->card)) {
@@ -270,6 +270,15 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 		break;
 	case MMC_ISSUE_ASYNC:
+		/*
+		 * If packed request is busy now, we can return BLK_STS_RESOURCE
+		 * to tell block layer to queue them later and MMC packed layer
+		 * will try to combine requests as much as possible.
+		 */
+		if (host->packed && mmc_packed_queue_is_busy(host->packed)) {
+			spin_unlock_irq(&mq->lock);
+			return BLK_STS_RESOURCE;
+		}
 		break;
 	default:
 		/*
@@ -305,9 +314,12 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 				   !host->hold_retune;
 	}
 
+	if (host->packed)
+		last = bd->last && !blk_mq_hctx_has_pending(hctx);
+
 	blk_mq_start_request(req);
 
-	issued = mmc_blk_mq_issue_rq(mq, req);
+	issued = mmc_blk_mq_issue_rq(mq, req, last);
 
 	switch (issued) {
 	case MMC_REQ_BUSY:
@@ -339,8 +351,20 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static void mmc_mq_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct mmc_queue *mq = hctx->queue->queuedata;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+
+	/* Tell MMC packed more requests will be coming */
+	if (host->packed)
+		mmc_packed_queue_commit_rqs(host->packed);
+}
+
 static const struct blk_mq_ops mmc_mq_ops = {
 	.queue_rq	= mmc_mq_queue_rq,
+	.commit_rqs	= mmc_mq_commit_rqs,
 	.init_request	= mmc_mq_init_request,
 	.exit_request	= mmc_mq_exit_request,
 	.complete	= mmc_blk_mq_complete,
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b7ba881..1602556 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -165,6 +165,7 @@ struct mmc_request {
 	bool			cap_cmd_during_tfr;
 
 	int			tag;
+	struct list_head	packed_list;
 };
 
 struct mmc_card;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb..8ecc244 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -13,6 +13,7 @@
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/packed.h>
 #include <linux/mmc/pm.h>
 #include <linux/dma-direction.h>
 
@@ -441,6 +442,8 @@ struct mmc_host {
 	/* Ongoing data transfer that allows commands during transfer */
 	struct mmc_request	*ongoing_mrq;
 
+	struct mmc_packed	*packed;
+
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	struct fault_attr	fail_mmc_request;
 #endif
diff --git a/include/linux/mmc/packed.h b/include/linux/mmc/packed.h
new file mode 100644
index 0000000..a952889
--- /dev/null
+++ b/include/linux/mmc/packed.h
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Linaro, Inc.
+// Author: Baolin Wang <baolin.wang@linaro.org>
+
+#ifndef MMC_PACKED_H
+#define MMC_PACKED_H
+
+#include <linux/list.h>
+#include <linux/mmc/core.h>
+#include <linux/wait.h>
+
+#define MMC_PACKED_MAX_REQUEST_COUNT	16
+#define MMC_PACKED_FLUSH_SIZE		(128 * 1024)
+
+struct mmc_packed;
+
+struct mmc_packed_request {
+	struct list_head list;
+	u32 nr_reqs;
+};
+
+struct mmc_packed_ops {
+	void (*packed_algo)(struct mmc_packed *packed);
+	int (*prepare_hardware)(struct mmc_packed *packed);
+	int (*unprepare_hardware)(struct mmc_packed *packed);
+	int (*packed_request)(struct mmc_packed *packed,
+			      struct mmc_packed_request *prq);
+};
+
+struct mmc_packed {
+	struct list_head list;
+	bool busy;
+	bool rqs_pending;
+	bool running;
+	bool waiting_for_idle;
+	spinlock_t lock;
+	u32 max_entries;
+	unsigned long rqs_len;
+
+	struct mmc_host *host;
+	struct mmc_packed_request prq;
+	const struct mmc_packed_ops *ops;
+
+	struct work_struct complete_work;
+	struct list_head complete_list;
+
+	wait_queue_head_t wait_queue;
+};
+
+#ifdef CONFIG_MMC_PACKED
+int mmc_packed_init(struct mmc_host *host, const struct mmc_packed_ops *ops,
+		    int max_packed);
+void mmc_packed_exit(struct mmc_host *host);
+void mmc_packed_finalize_requests(struct mmc_host *host,
+				  struct mmc_packed_request *prq);
+int mmc_packed_queue_request(struct mmc_packed *packed,
+			      struct mmc_request *mrq);
+void mmc_packed_pump_requests(struct mmc_packed *packed);
+bool mmc_packed_queue_is_busy(struct mmc_packed *packed);
+unsigned long mmc_packed_queue_length(struct mmc_packed *packed);
+void mmc_packed_queue_commit_rqs(struct mmc_packed *packed);
+int mmc_packed_wait_for_idle(struct mmc_packed *packed);
+
+int mmc_packed_queue_start(struct mmc_packed *packed);
+int mmc_packed_queue_stop(struct mmc_packed *packed);
+
+/* Some packed algorithm helpers */
+void mmc_packed_algo_rw(struct mmc_packed *packed);
+void mmc_packed_algo_ro(struct mmc_packed *packed);
+void mmc_packed_algo_wo(struct mmc_packed *packed);
+#else
+static inline int mmc_packed_init(struct mmc_host *host,
+				  const struct mmc_packed_ops *ops,
+				  int max_packed)
+{
+	return 0;
+}
+static inline void mmc_packed_exit(struct mmc_host *host)
+{ }
+static inline void mmc_packed_finalize_requests(struct mmc_host *host,
+						struct mmc_packed_request *prq)
+{ }
+static inline int mmc_packed_queue_request(struct mmc_packed *packed,
+					   struct mmc_request *mrq)
+{
+	return -EINVAL;
+}
+static inline int mmc_packed_pump_requests(struct mmc_packed *packed)
+{
+	return -EINVAL;
+}
+static inline bool mmc_packed_queue_is_busy(struct mmc_packed *packed)
+{
+	return false;
+}
+static inline unsigned long mmc_packed_queue_length(struct mmc_packed *packed)
+{
+	return 0;
+}
+static inline void mmc_packed_queue_commit_rqs(struct mmc_packed *packed)
+{ }
+static inline int mmc_packed_wait_for_idle(struct mmc_packed *packed)
+{
+	return -EBUSY;
+}
+static inline int mmc_packed_queue_start(struct mmc_packed *packed)
+{
+	return -EINVAL;
+}
+static inline int mmc_packed_queue_stop(struct mmc_packed *packed)
+{
+	return -EINVAL;
+}
+static inline void mmc_packed_algo_rw(struct mmc_packed *packed)
+{ }
+static inline void mmc_packed_algo_ro(struct mmc_packed *packed)
+{ }
+static inline void mmc_packed_algo_wo(struct mmc_packed *packed)
+{ }
+
+#endif
+
+#endif
-- 
1.7.9.5

