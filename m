Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A028DB49
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944662; cv=none; b=f8ceRyOZl779rFnb7WNoD/LM8uEweeN8uwneIz93qmzN3qnUx8c5l0R/irE9+YheDQjMLhL4P27zfBPgjfAFQQt4q8rBdO90mmof90MvZRiwxvtdzwGrNeJZXgfjvb5g0tS4agdkqxmD2DJi940gq0w/dNbKlelhHPfnfCK6L+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944662; c=relaxed/simple;
	bh=vrxT16m5cp8hnooQKhpGXNSMbSVI+ItCWpisQc7udsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQFK0e6lq/JkMLadDtpCevJdvElxWtIkDr+IVFP+LoQqAvU8bFMUbTFjkdBGSu0duJPPbHSGi51Bj4J+Gj2yE0yAeOc945Lecttn3Vu8p8d4ZC0BqOJPU2zGDXKmLNeRfS6rhtXtbAog2LPYJSG4fisfXV5Wi03vt9j32Y9Sn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij4ZtqMC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij4ZtqMC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso710578b3a.2
        for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753944660; x=1754549460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S355pAkI7NEC7JgrgQtUxkZyhDtDgj0z6R5QsB/4a/A=;
        b=ij4ZtqMCS2Tu2g5qcHgKq/vZuW5fKz/yPklC3OA+dClZOthBBYHqlX5P5VAvA9+ofv
         OKZXxiK3NbmeA28dT64fgoT7W979NTNS16QT2u6wyiA0fx4qeCoI+5y/JwZ4Iovp7Kv8
         YpY69aZ5Lwnl7KEr1JxyDxfsRqZpfe4BTo1rLh4WCknNG7fmfIUqk0oDwTOmOby78mlL
         YWegZp2BJXvAtVtpdSkAw+F4GzwYFkl/ZIdQQJesnc/8IVJzdOJ/Ni9i93XEdtkazPMj
         Y9Ugrf/SbLPp4h/ava9cqlYbIZjtR9NPq+iqr0cQCE/xVwqV6Nmtdx4uLh0ffjZ1bHWD
         xvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753944660; x=1754549460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S355pAkI7NEC7JgrgQtUxkZyhDtDgj0z6R5QsB/4a/A=;
        b=AxJrJxX6bfCR1M682i5PcwxPkrypWlud45aXhvtnH1in7BRGO1xfzkb23R0cH9gjxj
         6t+0yVPqIedfL/5DPbB4imEVN6mm3NcUA/9Qnkvjwo1hEnME9JrRzjAMrW6F6GE49veY
         nwXyF6QLOXIv5CDgieyWfI68j+jW6rS900l8hMqoYkOx8Qq8lv6RQ/bz3BU9LVcTLdDY
         khw/GrsMn9Y4YBBhbju9TpqXtm3U2JWsMzxj/fbzH93JFZlT2c7NxkkgGRYUb4BA+ZUF
         LM4G5Kl0vUWUeLZ4rv0TXqlz9SDO04oAIxOWG9zVABbqo/Baf0iZsgF092+9GnhTfWO0
         NvCw==
X-Forwarded-Encrypted: i=1; AJvYcCVoH3QZKo7zd3/fmyegSTBKfoC5XOqboOfSdGeFFaiyS+Uxnm2w8R9Q5ddpca8SO2k6ZEyRwvi3MuEosQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKe15lND9qe4D/3yDsjslwV3XJEzLoxHZdXg2Y+CZUpGk2mxO
	TCeW1CU1AndqNBy9hW3le/ZQjG0EpKRdsX1QN5oD3jzNijdYuYG9s9N3OkbMQYNevjsDIg6AOvK
	nRxTNQdjQnCK4Yw8zA8U9
X-Google-Smtp-Source: AGHT+IFMUHJAFt8LKadusLSxWtpDyV1hCcQ6KorKLDjQu0fTBgiS1ZlW3Ro3SPn2MxUk0sYyQq397lMznVYTEcB5
X-Received: from pgah15.prod.google.com ([2002:a05:6a02:4e8f:b0:b42:2a6f:4fcc])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2450:b0:233:951f:a572 with SMTP id adf61e73a8af0-23dc0d58b95mr10119563637.16.1753944660091;
 Wed, 30 Jul 2025 23:51:00 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:49:48 +0000
In-Reply-To: <20250731064949.1690732-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731064949.1690732-1-richardycc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731064949.1690732-3-richardycc@google.com>
Subject: [PATCH v2 2/3] zram: add async writeback infrastructure
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the necessary infrastructure for performing writeback
operations asynchronously.
It adds a dedicated kernel thread (`zram_wb_thread`), a request queue
for managing pending writebacks, and helper functions to deal with
the writeback requests.

This patch lays the foundation for enabling asynchronous writeback in a
subsequent change.

Signed-off-by: Richard Chang <richardycc@google.com>
---
 drivers/block/zram/zram_drv.c |   4 ++
 drivers/block/zram/zram_wb.c  | 114 ++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_wb.h  |  22 +++++++
 3 files changed, 140 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ec8649cad21e..6098c0bb773c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2871,6 +2871,9 @@ static int __init zram_init(void)
 		num_devices--;
 	}
 
+	if (setup_zram_writeback())
+		goto out_error;
+
 	return 0;
 
 out_error:
@@ -2880,6 +2883,7 @@ static int __init zram_init(void)
 
 static void __exit zram_exit(void)
 {
+	destroy_zram_writeback();
 	destroy_devices();
 }
 
diff --git a/drivers/block/zram/zram_wb.c b/drivers/block/zram/zram_wb.c
index 0bc10f725939..63a16dae5796 100644
--- a/drivers/block/zram/zram_wb.c
+++ b/drivers/block/zram/zram_wb.c
@@ -5,9 +5,16 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/freezer.h>
 
 #include "zram_wb.h"
 
+static struct task_struct *wb_thread;
+static DECLARE_WAIT_QUEUE_HEAD(wb_wq);
+static struct zram_wb_request_list wb_req_list;
+
 unsigned long alloc_block_bdev(struct zram *zram)
 {
 	unsigned long blk_idx = 1;
@@ -33,3 +40,110 @@ void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
+static void complete_wb_request(struct zram_wb_request *req)
+{
+	struct zram *zram = req->zram;
+	unsigned long blk_idx = req->blk_idx;
+
+	free_block_bdev(zram, blk_idx);
+	free_wb_request(req);
+}
+
+void enqueue_wb_request(struct zram_wb_request_list *req_list,
+			struct zram_wb_request *req)
+{
+	spin_lock_bh(&req_list->lock);
+	list_add_tail(&req->node, &req_list->head);
+	req_list->count++;
+	spin_unlock_bh(&req_list->lock);
+}
+
+static struct zram_wb_request *dequeue_wb_request(
+	struct zram_wb_request_list *req_list)
+{
+	struct zram_wb_request *req = NULL;
+
+	spin_lock_bh(&req_list->lock);
+	if (!list_empty(&req_list->head)) {
+		req = list_first_entry(&req_list->head,
+				       struct zram_wb_request,
+				       node);
+		list_del(&req->node);
+		req_list->count--;
+	}
+	spin_unlock_bh(&req_list->lock);
+
+	return req;
+}
+
+static void destroy_wb_request_list(struct zram_wb_request_list *req_list)
+{
+	struct zram_wb_request *req;
+
+	while (!list_empty(&req_list->head)) {
+		req = dequeue_wb_request(req_list);
+		free_block_bdev(req->zram, req->blk_idx);
+		free_wb_request(req);
+	}
+}
+
+static bool wb_ready_to_run(void)
+{
+	int count;
+
+	spin_lock_bh(&wb_req_list.lock);
+	count = wb_req_list.count;
+	spin_unlock_bh(&wb_req_list.lock);
+
+	return count > 0;
+}
+
+static int wb_thread_func(void *data)
+{
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		wait_event_freezable(wb_wq, wb_ready_to_run());
+
+		while (1) {
+			struct zram_wb_request *req;
+
+			req = dequeue_wb_request(&wb_req_list);
+			if (!req)
+				break;
+			complete_wb_request(req);
+		}
+	}
+	return 0;
+}
+
+void free_wb_request(struct zram_wb_request *req)
+{
+	struct bio *bio = req->bio;
+	struct page *page = bio_first_page_all(bio);
+
+	__free_page(page);
+	bio_put(bio);
+	kfree(req);
+}
+
+int setup_zram_writeback(void)
+{
+	spin_lock_init(&wb_req_list.lock);
+	INIT_LIST_HEAD(&wb_req_list.head);
+	wb_req_list.count = 0;
+
+	wb_thread = kthread_run(wb_thread_func, NULL, "zram_wb_thread");
+	if (IS_ERR(wb_thread)) {
+		pr_err("Unable to create zram_wb_thread\n");
+		return -1;
+	}
+	return 0;
+}
+
+void destroy_zram_writeback(void)
+{
+	kthread_stop(wb_thread);
+	destroy_wb_request_list(&wb_req_list);
+}
+
diff --git a/drivers/block/zram/zram_wb.h b/drivers/block/zram/zram_wb.h
index c2f5984e7aa2..b86de0398346 100644
--- a/drivers/block/zram/zram_wb.h
+++ b/drivers/block/zram/zram_wb.h
@@ -6,12 +6,34 @@
 #include <linux/bio.h>
 #include "zram_drv.h"
 
+struct zram_wb_request {
+	struct zram *zram;
+	unsigned long blk_idx;
+	struct zram_pp_slot *pps;
+	struct zram_pp_ctl *ppctl;
+	struct bio *bio;
+	struct list_head node;
+};
+
+struct zram_wb_request_list {
+	struct list_head head;
+	int count;
+	spinlock_t lock;
+};
+
 #if IS_ENABLED(CONFIG_ZRAM_WRITEBACK)
 unsigned long alloc_block_bdev(struct zram *zram);
 void free_block_bdev(struct zram *zram, unsigned long blk_idx);
+int setup_zram_writeback(void);
+void destroy_zram_writeback(void);
+void free_wb_request(struct zram_wb_request *req);
+void enqueue_wb_request(struct zram_wb_request_list *req_list,
+			struct zram_wb_request *req);
 #else
 inline unsigned long alloc_block_bdev(struct zram *zram) { return 0; }
 inline void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
+inline int setup_zram_writeback(void) { return 0; }
+inline void destroy_zram_writeback(void) {}
 #endif
 
 #endif /* _ZRAM_WRITEBACK_H_ */
-- 
2.50.1.565.gc32cd1483b-goog

