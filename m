Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2E1DE3DE
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451052; cv=none; b=LjEazSzMshwJ3uewRJeyqnjfPI2KqDkIvGL0S8K3wsgEqVPDwE4RUoIJi3/iawpGFx5e63B+pqIYNu5JTjz57Z8Mm02MnyenccEG+5Dhg3oZnwBBfVWU1s9dZj/zg6zAMugSube+WAQ4dCtqYNrDr9XoXcQCY5tS1sCfpTph7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451052; c=relaxed/simple;
	bh=gL9iMdxsmgDg8iKlpYQ/fFXgO4Fuoc5oKg164Ik7boQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWX+OyLtdWNrV+Ef328NrofkYL/OikwRnHOA4p97uw7ULfDpuk6TMHvuOtk+eL+q3bynZfaJn4twogIoYmaqt95O3pkvkujvhFGBzFq4Uu5ULgGgtYRHiwbeNPGR6H+Hy7MDfQ8zKhXgJ3XbYCbb6i0ZEsoF9Q+X860LxA3Hq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzdDUJSp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzdDUJSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741451050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oe0IUktthmJLl/yJLl+QxisFcC59Da6KFwQUDP6NVbw=;
	b=SzdDUJSpkFxkuGki9RN5q52mu4WOx75W54okxxjDAez5t3zOXeFUTIUTgU85VLaVs41PYG
	PUna0zNpMtLqd7VCBWRKPQ9s/PHNJuz5Oh+reOKECgcwZbyQV2RfyXOgnvF4dj2FKHX0zp
	0+cq7i7YIY9RC9r7h0xOSy5GuaqKenY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-E139ezQoN-GmHTdeu736vQ-1; Sat,
 08 Mar 2025 11:24:07 -0500
X-MC-Unique: E139ezQoN-GmHTdeu736vQ-1
X-Mimecast-MFC-AGG-ID: E139ezQoN-GmHTdeu736vQ_1741451046
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28BC2180049D;
	Sat,  8 Mar 2025 16:24:06 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0831819560AB;
	Sat,  8 Mar 2025 16:24:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH 5/5] loop: add module parameter of 'nr_hw_queues'
Date: Sun,  9 Mar 2025 00:23:09 +0800
Message-ID: <20250308162312.1640828-6-ming.lei@redhat.com>
In-Reply-To: <20250308162312.1640828-1-ming.lei@redhat.com>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add module parameter of 'nr_hw_queues' so that loop can support MQ,
which may reduce contention in case of too many io jobs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 46be0c8e75a6..6378dfee6681 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -91,6 +91,7 @@ struct loop_cmd {
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
+#define LOOP_DEFAULT_NR_HW_Q 1
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd);
 
@@ -1928,6 +1929,26 @@ static const struct kernel_param_ops loop_hw_qdepth_param_ops = {
 device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_depth, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: " __stringify(LOOP_DEFAULT_HW_Q_DEPTH));
 
+static int nr_hw_queues = LOOP_DEFAULT_NR_HW_Q;
+static int loop_set_nr_hw_queues(const char *s, const struct kernel_param *p)
+{
+	int nr, ret;
+
+	ret = kstrtoint(s, 0, &nr);
+	if (ret < 0)
+		return ret;
+	if (nr < 1)
+		return -EINVAL;
+	nr_hw_queues = nr;
+	return 0;
+}
+static const struct kernel_param_ops loop_nr_hw_q_param_ops = {
+	.set	= loop_set_nr_hw_queues,
+	.get	= param_get_int,
+};
+device_param_cb(nr_hw_queues, &loop_nr_hw_q_param_ops, &nr_hw_queues, 0444);
+MODULE_PARM_DESC(nr_hw_queues, "number of hardware queues. Default: " __stringify(LOOP_DEFAULT_NR_HW_Q));
+
 MODULE_DESCRIPTION("Loopback device support");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
@@ -2112,7 +2133,7 @@ static int loop_add(int i)
 	i = err;
 
 	lo->tag_set.ops = &loop_mq_ops;
-	lo->tag_set.nr_hw_queues = 1;
+	lo->tag_set.nr_hw_queues = nr_hw_queues;
 	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-- 
2.47.0

