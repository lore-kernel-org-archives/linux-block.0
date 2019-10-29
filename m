Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABBCA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2D3208E3
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mqf32fuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbfJ2PVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:21:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38650 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389299AbfJ2PVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 11:21:16 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so15190828iom.5
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2019 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CIZByL7lenjCCuEF28p3teDdPSwZ8iJ4i512Itw9fgU=;
        b=Mqf32fuDuDB9QwUU6iNUNk/unuSvOIKRAT2iplWgsRGQQiU0AP3DWC5rPEVZUpLNko
         S0eiu5d2JSWvJgL3yK2DrRZhq6pXQNsy9gZgyYukfgLzwz9lfeYg5CjUo59v1el7ykhk
         AhOKEE8VKsViSBA/9e0yH41snEjCQo9SCB5FoVdMX7wONClA5gqyZxVVdysVL4n1mC6h
         Z6b4X3DH2BR789ilqYhFnkiAWw6aR7sYOmMqJavsEjEL+lOS+eqwRiL3h8o1Nz83FJMw
         8y0dShX/+kFWdBw/J/Tydm2xNwph4xSnsUXMRF1qYRajepnLVLjzjzL2XjCYoEG5Ug+d
         z00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CIZByL7lenjCCuEF28p3teDdPSwZ8iJ4i512Itw9fgU=;
        b=d5kHLah9AtfBkNQAXLz/GT9wn2LFsUzDjeEhfjGjLTsVflt/Zm+kJ2Z+uz2IBN2YBd
         o1WVCWuPH/99w+hTh4eYmXTfXuWahhrcNSRlwEeYy5o7/BFKXU9OSoKSD5aVC6x6gj5i
         lGeOVu5dSPlIjwXMfvOCyRuCOuh3KOoArbmQiUuvzl1jGH5xhVbICZsZfAe/4sf6o0fY
         RyEWYxO5GlYEOpfXhai5mrrFJ0y1kzOLDcvRGh6KJHEGriYrCs+XGxJbYrlhd8BUfaP+
         TTeP5NLi8pfpBpASdB5xFD6sAcXLufgcCcz39va7b+9ViUJ6RpMyXYjDjOL19J5TTdYm
         CPOQ==
X-Gm-Message-State: APjAAAU3/KrEJzN2xh/MVVC/+lXTVsvBsPaQI2CnDAc6sssuLwTxGZOH
        2JFVxqgcl4N37aMML91fmixkcRxF/I3oXA==
X-Google-Smtp-Source: APXvYqyw0TUkSpaIjqX3KdkGKPkoPRIG4qiLJ/ROBgKMhxiEgpCHZ9j4RbkMwBwNUwSkVtwu4tJImA==
X-Received: by 2002:a5d:8591:: with SMTP id f17mr4374825ioj.198.1572362473537;
        Tue, 29 Oct 2019 08:21:13 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm2120674ilq.72.2019.10.29.08.21.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 08:21:12 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: support for generic async request cancel
Message-ID: <145702de-3aaf-c240-81fb-67926b00f482@kernel.dk>
Date:   Tue, 29 Oct 2019 09:21:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for IORING_OP_ASYNC_CANCEL, which will attempt to
cancel requests that have been punted to async context and are now
in-flight. This works for regular read/write requests to files, as
long as they haven't been started yet. For socket based IO (or things
like accept4(2)), we can cancel work that is already running as well.

To cancel a request, the sqe must have ->addr set to the user_data of
the request it wishes to cancel. If the request is cancelled
successfully, the original request is completed with -ECANCELED
and the cancel request is completed with a result of 0. If the
request was already running, the original may or may not complete
in error. The cancel request will complete with -EALREADY for that
case. And finally, if the request to cancel wasn't found, the cancel
request is completed with -ENOENT.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Patch is against my for-5.5/io_uring-wq series of patches. There's a
liburing test case for this as well, test/io-cancel.c

 fs/io-wq.c                    |   85 ++++++++++++++++++++++++++++++++++
 fs/io-wq.h                    |    5 ++
 fs/io_uring.c                 |   44 +++++++++++++++++
 include/uapi/linux/io_uring.h |    2 
 4 files changed, 136 insertions(+)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index ced313ca1d04..c90cfb475bbf 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -643,6 +643,91 @@ void io_wq_cancel_all(struct io_wq *wq)
 	rcu_read_unlock();
 }
 
+struct io_cb_cancel_data {
+	struct io_wqe *wqe;
+	work_cancel_fn *cancel;
+	void *caller_data;
+};
+
+static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
+{
+	struct io_cb_cancel_data *data = cancel_data;
+	struct io_wqe *wqe = data->wqe;
+	bool ret = false;
+
+	/*
+	 * Hold the lock to avoid ->cur_work going out of scope, caller
+	 * may deference the passed in work.
+	 */
+	spin_lock_irq(&wqe->lock);
+	if (worker->cur_work &&
+	    data->cancel(worker->cur_work, data->caller_data)) {
+		send_sig(SIGINT, worker->task, 1);
+		ret = true;
+	}
+	spin_unlock_irq(&wqe->lock);
+
+	return ret;
+}
+
+static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
+					       work_cancel_fn *cancel,
+					       void *cancel_data)
+{
+	struct io_cb_cancel_data data = {
+		.wqe = wqe,
+		.cancel = cancel,
+		.caller_data = cancel_data,
+	};
+	struct io_wq_work *work;
+	bool found = false;
+
+	spin_lock_irq(&wqe->lock);
+	list_for_each_entry(work, &wqe->work_list, list) {
+		if (cancel(work, cancel_data)) {
+			list_del(&work->list);
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irq(&wqe->lock);
+
+	if (found) {
+		work->flags |= IO_WQ_WORK_CANCEL;
+		work->func(&work);
+		return IO_WQ_CANCEL_OK;
+	}
+
+	rcu_read_lock();
+	found = io_wq_for_each_worker(wqe, &wqe->free_list, io_work_cancel,
+					&data);
+	if (found)
+		goto done;
+
+	found = io_wq_for_each_worker(wqe, &wqe->busy_list, io_work_cancel,
+					&data);
+done:
+	rcu_read_unlock();
+	return found ? IO_WQ_CANCEL_RUNNING : IO_WQ_CANCEL_NOTFOUND;
+}
+
+enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
+				  void *data)
+{
+	enum io_wq_cancel ret = IO_WQ_CANCEL_NOTFOUND;
+	int i;
+
+	for (i = 0; i < wq->nr_wqes; i++) {
+		struct io_wqe *wqe = wq->wqes[i];
+
+		ret = io_wqe_cancel_cb_work(wqe, cancel, data);
+		if (ret != IO_WQ_CANCEL_NOTFOUND)
+			break;
+	}
+
+	return ret;
+}
+
 static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 {
 	struct io_wq_work *work = data;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index e93f764b1fa4..3de192dc73fc 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -43,6 +43,11 @@ void io_wq_flush(struct io_wq *wq);
 void io_wq_cancel_all(struct io_wq *wq);
 enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork);
 
+typedef bool (work_cancel_fn)(struct io_wq_work *, void *);
+
+enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
+					void *data);
+
 #if defined(CONFIG_IO_WQ)
 extern void io_wq_worker_sleeping(struct task_struct *);
 extern void io_wq_worker_running(struct task_struct *);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7df3dd147817..400be4e87659 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2132,6 +2132,47 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
+static bool io_cancel_cb(struct io_wq_work *work, void *data)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+
+	return req->user_data == (unsigned long) data;
+}
+
+static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			   struct io_kiocb **nxt)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	enum io_wq_cancel ret;
+	void *sqe_addr;
+
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->flags || sqe->ioprio || sqe->off || sqe->len ||
+	    sqe->cancel_flags)
+		return -EINVAL;
+
+	sqe_addr = (void *) (unsigned long) READ_ONCE(sqe->addr);
+	ret = io_wq_cancel_cb(ctx->io_wq, io_cancel_cb, sqe_addr);
+	switch (ret) {
+	case IO_WQ_CANCEL_OK:
+		ret = 0;
+		break;
+	case IO_WQ_CANCEL_RUNNING:
+		ret = -EALREADY;
+		break;
+	case IO_WQ_CANCEL_NOTFOUND:
+		ret = -ENOENT;
+		break;
+	}
+
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
+	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_put_req(req, nxt);
+	return 0;
+}
+
 static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			const struct io_uring_sqe *sqe)
 {
@@ -2216,6 +2257,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_ACCEPT:
 		ret = io_accept(req, s->sqe, nxt, force_nonblock);
 		break;
+	case IORING_OP_ASYNC_CANCEL:
+		ret = io_async_cancel(req, s->sqe, nxt);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f82d90e617a6..6877cf8894db 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -33,6 +33,7 @@ struct io_uring_sqe {
 		__u32		msg_flags;
 		__u32		timeout_flags;
 		__u32		accept_flags;
+		__u32		cancel_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -70,6 +71,7 @@ struct io_uring_sqe {
 #define IORING_OP_TIMEOUT	11
 #define IORING_OP_TIMEOUT_REMOVE	12
 #define IORING_OP_ACCEPT	13
+#define IORING_OP_ASYNC_CANCEL	14
 
 /*
  * sqe->fsync_flags
-- 
Jens Axboe

