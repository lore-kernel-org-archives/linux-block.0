Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9D1DE3C1
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508170; cv=none; b=Z0WAXkRAyP8x88BHCo9WDBuQH9eZ9QjBOUoTDiv6Bv/TtGFPobvqd4jVtkxH+C8iSO3LWIjRg+Ia2eTLgL050LzaZSWoySk0W09EZvHa8slzwmnbrSxWw2B5Jb2AxzBzOknHSgaq9OoAKd8OrtpgNgBDK4/KQAlRN+/FLQwk36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508170; c=relaxed/simple;
	bh=icSEhZ3l2hUYv1ETI20eYNkxUZiNLEPUVqhf9An7RGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLAXi3feQMQalOiRL0PPNItG1+rbMtGxAfOd6x46XQtmswrBe9CEUDHpnShiaw6U4LXs2EZ5wqJAUPDAp/Z1iqYagr8oWgzI/xrAxgymocgUYJKmjxvzyBovYrm7y46rDD/KKPtWfObOoAEn3VZwa9Q7f22syFn245zW/B6QQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtPWH0ce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtPWH0ce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pz082JKbairmvvlYLOUOdEM6wXxFK+jSb3Q1hrEBYgc=;
	b=dtPWH0ceKoRAC9FuOvYjj8bRe3xU9qSi2hePqx4Cukjot1uWo5MOn1SNho1BOnIryy4e2r
	gsVZ/5rzJOa4IixPOymEPfewv1/yFf/W08oC6RvIz5V6BcVi2c5zsY5296GRIVJWq0yDQo
	yhXq/NfnngidHzY3vmNrIlezpim2qr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-9CwTrJ_JPmuo18pKLDxKjQ-1; Thu,
 24 Apr 2025 11:22:44 -0400
X-MC-Unique: 9CwTrJ_JPmuo18pKLDxKjQ-1
X-Mimecast-MFC-AGG-ID: 9CwTrJ_JPmuo18pKLDxKjQ_1745508163
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0FA81800875;
	Thu, 24 Apr 2025 15:22:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BF0F19560A3;
	Thu, 24 Apr 2025 15:22:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 12/20] block: add `struct elv_change_ctx` for unifying elevator change
Date: Thu, 24 Apr 2025 23:21:35 +0800
Message-ID: <20250424152148.1066220-13-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add `struct elv_change_ctx` and prepare for unifying elevator change by
[__]elevator_change(). With this way, any input & output parameter can
be provided & observed in top helper.

This way helps to move kobject add/delete & debugfs register/unregister
out of ->elevator_lock & freezing queue.

Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index e70cd4b828a5..4be318b0b4ef 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,6 +45,12 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool uevent;
+};
+
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -621,7 +627,8 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
+			   struct elv_change_ctx *ctx)
 {
 	int ret;
 
@@ -639,7 +646,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, true);
+	ret = elv_register_queue(q, ctx->uevent);
 	if (ret) {
 		elevator_exit(q);
 		goto out_unfreeze;
@@ -678,8 +685,9 @@ static void elevator_disable(struct request_queue *q)
  * Switch this queue to the given IO scheduler.
  */
 static int __elevator_change(struct request_queue *q,
-			     const char *elevator_name)
+			     struct elv_change_ctx *ctx)
 {
+	const char *elevator_name = ctx->name;
 	struct elevator_type *e;
 	int ret;
 
@@ -698,20 +706,21 @@ static int __elevator_change(struct request_queue *q,
 	e = elevator_find_get(elevator_name);
 	if (!e)
 		return -EINVAL;
-	ret = elevator_switch(q, e);
+	ret = elevator_switch(q, e, ctx);
 	elevator_put(e);
 	return ret;
 }
 
-static int elevator_change(struct request_queue *q, const char *elevator_name)
+static int elevator_change(struct request_queue *q,
+			   struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
 	int ret = 0;
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	if (!q->elevator || !elevator_match(q->elevator->type, elevator_name))
-		ret = __elevator_change(q, elevator_name);
+	if (!q->elevator || !elevator_match(q->elevator->type, ctx->name))
+		ret = __elevator_change(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
@@ -723,16 +732,19 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
  */
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
-	const char *name = "none";
+	struct elv_change_ctx ctx = {
+		.name	= "none",
+		.uevent	= true,
+	};
 
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q))
-		name = q->elevator->type->elevator_name;
-	__elevator_change(q, name);
+		ctx.name = q->elevator->type->elevator_name;
+	__elevator_change(q, &ctx);
 	mutex_unlock(&q->elevator_lock);
 }
 
-static void elv_iosched_load_module(char *elevator_name)
+static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
 
@@ -748,7 +760,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
-	char *name;
+	struct elv_change_ctx ctx = {
+		.uevent = true,
+	};
 	int ret;
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -759,12 +773,12 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue is the one for the device storing the module file.
 	 */
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	name = strstrip(elevator_name);
+	ctx.name = strstrip(elevator_name);
 
-	elv_iosched_load_module(name);
+	elv_iosched_load_module(ctx.name);
 
 	down_read_nested(&set->update_nr_hwq_sema, 1);
-	ret = elevator_change(q, name);
+	ret = elevator_change(q, &ctx);
 	if (!ret)
 		ret = count;
 	up_read(&set->update_nr_hwq_sema);
-- 
2.47.0

