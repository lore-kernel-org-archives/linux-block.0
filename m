Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2E38DD8
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918348; cv=none; b=r07nuUzRrXkJb/jX/B0bh/Qpz/V+Z4YUgXcWppqSHNJaSCyhQoQNpWJQ0MYcuu4BXpmpfaKNLU57PBhFDpItOErAX7rwuIU/5/Rc6pi057Omr70HMvYxqmlLPULf0em++P4yCYlDH/9QnT5RnO3IHzl+vIVKgAZ+eSADmmw4o6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918348; c=relaxed/simple;
	bh=menII101TGojYykHQ6b+MfZFAVmDh/is6WcbZSElUuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoR+iADNiN/x6a5BBu9/CkZ4T+xqNjwUJ3wJwUk7HyBGzcNpJmiYBrF+6HLg7qBNX9Rzj59fYC1ucQNzSWb8H5k6xBvwBZJnmU/0Edl1by2YMLcj6H92shy9rgUx56EOR6EwholiJ2NupuGZ36G8szv+KW+cjLTY2Fek7/dCBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO9D9FFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO9D9FFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741918345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWBFjWQhhDx9tAlh9GEaUJkOGUMPicNbteHnVS/NWDs=;
	b=MO9D9FFtoOJ/Kgp9Ent2oyPlS/O8f2gKXEIL1xRKF2YKUx6u77O84iMgWLarnTpGGlb1mb
	6ZZhq/eYGx/kxiQyiDiliOFu6E1XgmJS3giCeHGJ0XeeAukIXq6hWTFNDWB46g7KCPgqLp
	QMbfwzukiFo74z8bHL0kLQSUDfsXCWw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-So7hWVESM3q-NwN3DmOVSA-1; Thu,
 13 Mar 2025 22:12:22 -0400
X-MC-Unique: So7hWVESM3q-NwN3DmOVSA-1
X-Mimecast-MFC-AGG-ID: So7hWVESM3q-NwN3DmOVSA_1741918341
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A10D180034D;
	Fri, 14 Mar 2025 02:12:21 +0000 (UTC)
Received: from localhost (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C851B3003770;
	Fri, 14 Mar 2025 02:12:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jooyung Han <jooyung@google.com>,
	Mike Snitzer <snitzer@kernel.org>,
	zkabelac@redhat.com,
	dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] loop: add hint for handling aio via IOCB_NOWAIT
Date: Fri, 14 Mar 2025 10:11:45 +0800
Message-ID: <20250314021148.3081954-6-ming.lei@redhat.com>
In-Reply-To: <20250314021148.3081954-1-ming.lei@redhat.com>
References: <20250314021148.3081954-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add hint for using IOCB_NOWAIT to handle loop aio command for avoiding
to cause write(especially randwrite) perf regression on sparse file.

Try IOCB_NOWAIT in the following situations:

- backing file is block device

- READ aio command

- there isn't queued aio non-NOWAIT WRITE, since retry of NOWAIT won't
cause contention on WRITE and non-NOWAIT WRITE often implies exclusive
lock.

With this simple policy, perf regression of randwrte/write on sparse
backing file is fixed. Meantime this way addresses perf problem[1] in
case of stable FS block mapping via NOWAIT.

Link: https://lore.kernel.org/dm-devel/7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 542b1fe938a7..5bf14549cf8e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,6 +70,7 @@ struct loop_device {
 	struct rb_root          worker_tree;
 	struct timer_list       timer;
 	bool			sysfs_inited;
+	unsigned 		queued_wait_write;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
@@ -522,6 +523,30 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd)
 	return 0;
 }
 
+static inline bool lo_aio_need_try_nowait(struct loop_device *lo,
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
+	/* NOWAIT is supposed to be fine for READ */
+	if (req_op(rq) == REQ_OP_READ)
+		return true;
+
+	/*
+	 * If there is any queued non-NOWAIT async WRITE , don't try new
+	 * NOWAIT WRITE for avoiding contention
+	 *
+	 * Here we focus on handling stable FS block mapping via NOWAIT
+	 */
+	return READ_ONCE(lo->queued_wait_write) == 0;
+}
+
 static blk_status_t lo_rw_aio_nowait(struct loop_device *lo,
 		struct loop_cmd *cmd)
 {
@@ -531,6 +556,9 @@ static blk_status_t lo_rw_aio_nowait(struct loop_device *lo,
 	if (unlikely(ret < 0))
 		return BLK_STS_IOERR;
 
+	if (!lo_aio_need_try_nowait(lo, cmd))
+		return BLK_STS_AGAIN;
+
 	cmd->iocb.ki_flags |= IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, nr_bvec);
 	if (ret == -EAGAIN)
@@ -821,12 +849,18 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
+static ssize_t loop_attr_nr_wait_write_show(struct loop_device *lo, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", lo->queued_wait_write);
+}
+
 LOOP_ATTR_RO(backing_file);
 LOOP_ATTR_RO(offset);
 LOOP_ATTR_RO(sizelimit);
 LOOP_ATTR_RO(autoclear);
 LOOP_ATTR_RO(partscan);
 LOOP_ATTR_RO(dio);
+LOOP_ATTR_RO(nr_wait_write);
 
 static struct attribute *loop_attrs[] = {
 	&loop_attr_backing_file.attr,
@@ -835,6 +869,7 @@ static struct attribute *loop_attrs[] = {
 	&loop_attr_autoclear.attr,
 	&loop_attr_partscan.attr,
 	&loop_attr_dio.attr,
+	&loop_attr_nr_wait_write.attr,
 	NULL,
 };
 
@@ -910,6 +945,30 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 }
 #endif
 
+static inline void loop_inc_wait_write(struct loop_device *lo, struct loop_cmd *cmd)
+{
+	lockdep_assert_held(&lo->lo_mutex);
+
+	if (cmd->use_aio){
+		struct request *rq = blk_mq_rq_from_pdu(cmd);
+
+		if (req_op(rq) == REQ_OP_WRITE)
+			lo->queued_wait_write += 1;
+	}
+}
+
+static inline void loop_dec_wait_write(struct loop_device *lo, struct loop_cmd *cmd)
+{
+	lockdep_assert_held(&lo->lo_mutex);
+
+	if (cmd->use_aio){
+		struct request *rq = blk_mq_rq_from_pdu(cmd);
+
+		if (req_op(rq) == REQ_OP_WRITE)
+			lo->queued_wait_write -= 1;
+	}
+}
+
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	struct request __maybe_unused *rq = blk_mq_rq_from_pdu(cmd);
@@ -992,6 +1051,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		work = &lo->rootcg_work;
 		cmd_list = &lo->rootcg_cmd_list;
 	}
+	loop_inc_wait_write(lo, cmd);
 	list_add_tail(&cmd->list_entry, cmd_list);
 	queue_work(lo->workqueue, work);
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2051,6 +2111,7 @@ static void loop_process_work(struct loop_worker *worker,
 		cond_resched();
 
 		spin_lock_irq(&lo->lo_work_lock);
+		loop_dec_wait_write(lo, cmd);
 	}
 
 	/*
-- 
2.47.0

