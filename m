Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B010F4
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725754027; cv=none; b=CsjpJuezUekUYJpwdPwY0yJ/4PQNznPuOQT/D9A0aMGCUUviiUpfXm+BGR1Jf/SRNjwSH9N1IvWoejiQm8Uldd7WDLLVdpg6IZizSmoPqF2752L6jLfbf4e2Ef/5AXMJd9DgXgDT8U7g97UDdmGwL3nPZbLbaXi2uun+0SXSUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725754027; c=relaxed/simple;
	bh=WeLm/v2C4ziwvqBeuTEjjpNp6w4mY0o4Qoc0HRLL5Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMW+4nvOVVTgR/9GfTmOr8qKBSXjXyyYeUd1geU5xOp8zjhK1F0XHBIfZ+Yxib5PkyrkvyUI7J9Lmeoxur+9aBxlejTDqHKp6EJfFhPEicL8qj7b8AuERxdT9Jd4u7gSPwlhXtcPfKcb7zQw79KWQgZUILp47NMcLp52kaUygvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Uq0KZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Uq0KZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA68FC4CEC2;
	Sun,  8 Sep 2024 00:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725754027;
	bh=WeLm/v2C4ziwvqBeuTEjjpNp6w4mY0o4Qoc0HRLL5Ug=;
	h=From:To:Cc:Subject:Date:From;
	b=o2Uq0KZwcn/T+HkJIif0aqD0W603sbNN976viXn+sWIlsEAOvsY+MMQOkfhEtFYXQ
	 cu17S+PLdFPIIA8IiGR/RWBIMMIJel/DetBDVqvuV9aqqpUU29JIiGfdHIeFZXa1I/
	 BF41V8R1fGCMfo/HzYhrJcfsERWXHr/CXOMRhGg8PbHW6Cn76B2lEuakKnhCwU09I+
	 1wNxjMZBJ5XDoHXOGYgoeVWd9xee1YX8b4y0LfWpMaDw9nLgMYJnGancuqLYTpyvTz
	 /T6ts4xCzlGUJPdbPd0D4WqRkXG4XknXbT77JF6RYRZ3SwpsiFNHTMNpMO3xFXmsVK
	 2LsuqdNWLQ3gA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] block: Prevent deadlocks when switching elevators
Date: Sun,  8 Sep 2024 09:07:04 +0900
Message-ID: <20240908000704.414538-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit af2814149883 ("block: freeze the queue in queue_attr_store")
changed queue_attr_store() to always freeze a sysfs attribute queue
before calling the attribute store() method, to ensure that no IOs are
in-flight when an attribute value is being updated.

However, this change created a potential deadlock situation for the
scheduler queue attribute as changing the queue elevator with
elv_iosched_store() can result in a call to request_module() if the user
requested module is not already registered. If the file of the requested
module is stored on the block device of the frozen queue, a deadlock
will happen as the read operations triggered by request_module() will
wait for the queue freeze to end.

Solve this issue by introducing the load_module method in struct
queue_sysfs_entry, and to calling this method function in
queue_attr_store() before freezing the attribute queue.
The macro definition QUEUE_RW_LOAD_MODULE_ENTRY() is added to define a
queue sysfs attribute that needs loading a module.

The definition of the scheduler atrribute is changed to using
QUEUE_RW_LOAD_MODULE_ENTRY(), with the function
elv_iosched_load_module() defined as the load_module method.
elv_iosched_store() can then be simplified to remove the call to
request_module().

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Reported-by: Jiri Jaburek <jjaburek@redhat.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219166
Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-sysfs.c | 22 +++++++++++++++++++++-
 block/elevator.c  | 21 +++++++++++++++------
 block/elevator.h  |  2 ++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 60116d13cb80..e85941bec857 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -23,6 +23,7 @@
 struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
+	int (*load_module)(struct gendisk *disk, const char *page, size_t count);
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -413,6 +414,14 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.store	= _prefix##_store,			\
 };
 
+#define QUEUE_RW_LOAD_MODULE_ENTRY(_prefix, _name)		\
+static struct queue_sysfs_entry _prefix##_entry = {		\
+	.attr		= { .name = _name, .mode = 0644 },	\
+	.show		= _prefix##_show,			\
+	.load_module	= _prefix##_load_module,		\
+	.store		= _prefix##_store,			\
+}
+
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
@@ -420,7 +429,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
-QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -670,6 +679,17 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (!entry->store)
 		return -EIO;
 
+	/*
+	 * If the attribute needs to load a module, do it before freezing the
+	 * queue to ensure that the module file can be read when the request
+	 * queue is the one for the device storing the module file.
+	 */
+	if (entry->load_module) {
+		res = entry->load_module(disk, page, length);
+		if (res)
+			return res;
+	}
+
 	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
 	res = entry->store(disk, page, length);
diff --git a/block/elevator.c b/block/elevator.c
index f13d552a32c8..c355b55d0107 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -698,17 +698,26 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		return 0;
 
 	e = elevator_find_get(q, elevator_name);
-	if (!e) {
-		request_module("%s-iosched", elevator_name);
-		e = elevator_find_get(q, elevator_name);
-		if (!e)
-			return -EINVAL;
-	}
+	if (!e)
+		return -EINVAL;
 	ret = elevator_switch(q, e);
 	elevator_put(e);
 	return ret;
 }
 
+int elv_iosched_load_module(struct gendisk *disk, const char *buf,
+			    size_t count)
+{
+	char elevator_name[ELV_NAME_MAX];
+
+	if (!elv_support_iosched(disk->queue))
+		return -EOPNOTSUPP;
+
+	strscpy(elevator_name, buf, sizeof(elevator_name));
+
+	return request_module("%s-iosched", strstrip(elevator_name));
+}
+
 ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
diff --git a/block/elevator.h b/block/elevator.h
index 3fe18e1a8692..2a78544bf201 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -148,6 +148,8 @@ extern void elv_unregister(struct elevator_type *);
  * io scheduler sysfs switching
  */
 ssize_t elv_iosched_show(struct gendisk *disk, char *page);
+int elv_iosched_load_module(struct gendisk *disk, const char *page,
+			    size_t count);
 ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
-- 
2.46.0

