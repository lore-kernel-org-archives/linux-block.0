Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72D24467A
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066212; cv=none; b=H6f/oevuBN9CqbAV683mQGROX2Eso8od2pS1xMCNGUv+7GMHnWfNGPBp/kpZXJgy1zknmYP8VabKRqCApUh57Vfk/5D4VARhV1XyOWDT5+tdLqADSXboVytzf4JBXd/T2xCubvZhqj714X5Tj+Vhu3pO7BBb9Sn+kRk/32D91e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066212; c=relaxed/simple;
	bh=QpPECCJJWocogr1hmmxxbjw8juMtrhfzGpQIv4fnoU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrP9sH/3R3gkudZ8TOdMVHsVklKy/rnlK5bflqdX50nX8UmnRSrOYhmz09qhUoMeoBuuY3zX6+kRnoMBw4uTtjsvdInPTjS1tkc8HZ0fOc7MSU1B0pjwSJ5MAdW2DxY7W6PXwJlcZydBgEE2UYzrqhU6mcybT0TE22agZ8tSHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APrJUZlh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APrJUZlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NO2W5I0YfcFhRbUTchpDwdQv7olqZScIsLA3MOvRxJk=;
	b=APrJUZlhSYlt9E/MoshqWVD/yjN7HgZRK+BXgZOhuSVp5dAhWsLORwxSlXTLgRs0elbLk9
	WMWwL5HoIJSRnTn20QWjSlUBBvgcHOuDPkdPMeX6EH+PxI3lKyz19DT7JhfnpCFIk+IIDi
	Y1bSn8uSEqBcgItoCbHIsNRApNvzQQM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-lRnRoxC8MM67EBaNQiil4w-1; Sun,
 28 Sep 2025 09:30:05 -0400
X-MC-Unique: lRnRoxC8MM67EBaNQiil4w-1
X-Mimecast-MFC-AGG-ID: lRnRoxC8MM67EBaNQiil4w_1759066203
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C156195608C;
	Sun, 28 Sep 2025 13:30:03 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CA4230001A4;
	Sun, 28 Sep 2025 13:30:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
Date: Sun, 28 Sep 2025 21:29:25 +0800
Message-ID: <20250928132927.3672537-7-ming.lei@redhat.com>
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add hint for using IOCB_NOWAIT to handle loop aio command for avoiding
to cause write(especially randwrite) perf regression on sparse backed file.

Try IOCB_NOWAIT in the following situations:

- backing file is block device

OR

- READ aio command

OR

- there isn't any queued blocking async WRITEs, because NOWAIT won't cause
contention with blocking WRITE, which often implies exclusive lock

With this simple policy, perf regression of randwrite/write on sparse
backing file is fixed.

Link: https://lore.kernel.org/dm-devel/7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 57e33553695b..911262b648ce 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -68,6 +68,7 @@ struct loop_device {
 	struct rb_root          worker_tree;
 	struct timer_list       timer;
 	bool			sysfs_inited;
+	unsigned 		lo_nr_blocking_writes;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
@@ -462,6 +463,33 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return -EIOCBQUEUED;
 }
 
+static inline bool lo_aio_try_nowait(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *inode = file->f_mapping->host;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+
+	/* NOWAIT works fine for backing block device */
+	if (S_ISBLK(inode->i_mode))
+		return true;
+
+	/*
+	 * NOWAIT is supposed to be fine for READ without contending with
+	 * blocking WRITE
+	 */
+	if (req_op(rq) == REQ_OP_READ)
+		return true;
+
+	/*
+	 * If there is any queued non-NOWAIT async WRITE , don't try new
+	 * NOWAIT WRITE for avoiding contention
+	 *
+	 * Here we focus on handling stable FS block mapping via NOWAIT
+	 */
+	return READ_ONCE(lo->lo_nr_blocking_writes) == 0;
+}
+
 static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
 			    int rw)
 {
@@ -473,6 +501,9 @@ static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
 	if (unlikely(ret))
 		goto fail;
 
+	if (!lo_aio_try_nowait(lo, cmd))
+		return -EAGAIN;
+
 	cmd->iocb.ki_flags |= IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
 fail:
@@ -773,12 +804,19 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
+static ssize_t loop_attr_nr_blocking_writes_show(struct loop_device *lo,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", lo->lo_nr_blocking_writes);
+}
+
 LOOP_ATTR_RO(backing_file);
 LOOP_ATTR_RO(offset);
 LOOP_ATTR_RO(sizelimit);
 LOOP_ATTR_RO(autoclear);
 LOOP_ATTR_RO(partscan);
 LOOP_ATTR_RO(dio);
+LOOP_ATTR_RO(nr_blocking_writes);
 
 static struct attribute *loop_attrs[] = {
 	&loop_attr_backing_file.attr,
@@ -787,6 +825,7 @@ static struct attribute *loop_attrs[] = {
 	&loop_attr_autoclear.attr,
 	&loop_attr_partscan.attr,
 	&loop_attr_dio.attr,
+	&loop_attr_nr_blocking_writes.attr,
 	NULL,
 };
 
@@ -862,6 +901,24 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 }
 #endif
 
+static inline void loop_inc_blocking_writes(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	lockdep_assert_held(&lo->lo_mutex);
+
+	if (req_op(blk_mq_rq_from_pdu(cmd)) == REQ_OP_WRITE)
+		lo->lo_nr_blocking_writes += 1;
+}
+
+static inline void loop_dec_blocking_writes(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	lockdep_assert_held(&lo->lo_mutex);
+
+	if (req_op(blk_mq_rq_from_pdu(cmd)) == REQ_OP_WRITE)
+		lo->lo_nr_blocking_writes -= 1;
+}
+
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	struct request __maybe_unused *rq = blk_mq_rq_from_pdu(cmd);
@@ -944,6 +1001,8 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		work = &lo->rootcg_work;
 		cmd_list = &lo->rootcg_cmd_list;
 	}
+	if (cmd->use_aio)
+		loop_inc_blocking_writes(lo, cmd);
 	list_add_tail(&cmd->list_entry, cmd_list);
 	queue_work(lo->workqueue, work);
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2042,6 +2101,8 @@ static void loop_process_work(struct loop_worker *worker,
 		cond_resched();
 
 		spin_lock_irq(&lo->lo_work_lock);
+		if (cmd->use_aio)
+			loop_dec_blocking_writes(lo, cmd);
 	}
 
 	/*
-- 
2.47.0

