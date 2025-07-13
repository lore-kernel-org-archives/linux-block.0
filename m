Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759D220686
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417276; cv=none; b=P2OUmlW2X6cnkLqtxdHvu4Z+sd3Q10oNbwGeHlvR+g4mpOlDJr9rRzfkwUjJMFDFYyfn6QyH+Dh+w/Da6O03XnMU4AJPg9HxNkD/8pew3RXK8K7mvwW3HX7Qiqre2nmQeS2U06jN5lWdNbBy7qgtJ+e5mBFe06DoRa9tgIYutbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417276; c=relaxed/simple;
	bh=pSFfkeFxLJqarOW1e+1zlXc6EOmtCMv2bQ/WVwKZvqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmhXn7NBoF0aBCewSecA6wPPaquT3hi5zkyTNgH7KTNiGbWXamMhRbLbJlmqyVmdSEwUvcHPk2D2NjcXYqH0OuNcmQ72uHn/hv2/io9NFS4Qi8KNQxv/ipmSpYgHnwmiEWjD7Z7MNDLmjIPqy2pPbi1x9B3fBwHa3gD9IWCpg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADVaK30c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADVaK30c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pFBE3SBSN+Q1cDTsEX5bFpuEsc6AZAqT0TVsF0FxOsc=;
	b=ADVaK30cdsh+RuWmSW+4c93nhecpOMfTpMhYMS+jmqTTwF0CII1erPm4WoYW5KA614xiYc
	6j99wIVtJHj2vrdFZIIAWpVBt80gLY/TqtHsE5HN3orkr+JLbs3nawN2Kt+bNpC+MVGUXy
	sILEXaCAPBjJXjYTOvBPZ2xocphCO1A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-ulg-E7DmMPGjizafxDB5UA-1; Sun,
 13 Jul 2025 10:34:32 -0400
X-MC-Unique: ulg-E7DmMPGjizafxDB5UA-1
X-Mimecast-MFC-AGG-ID: ulg-E7DmMPGjizafxDB5UA_1752417271
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B66919560AE;
	Sun, 13 Jul 2025 14:34:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4539C19560A3;
	Sun, 13 Jul 2025 14:34:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 02/17] ublk: look up ublk task via its pid in timeout handler
Date: Sun, 13 Jul 2025 22:33:57 +0800
Message-ID: <20250713143415.2857561-3-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Look up ublk process via its pid in timeout handler, so we can avoid to
touch io->task, because it is fragile to touch task structure.

It is fine to kill ublk server process and this way is simpler.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2b894de29823..7d1d8bd979c5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1368,14 +1368,23 @@ static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	struct ublk_io *io = &ubq->ios[rq->tag];
-
-	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
-		send_sig(SIGKILL, io->task, 0);
-		return BLK_EH_DONE;
-	}
-
-	return BLK_EH_RESET_TIMER;
+	pid_t tgid = ubq->dev->ublksrv_tgid;
+	struct task_struct *p;
+	struct pid *pid;
+
+	if (!(ubq->flags & UBLK_F_UNPRIVILEGED_DEV))
+		return BLK_EH_RESET_TIMER;
+
+	if (unlikely(!tgid))
+		return BLK_EH_RESET_TIMER;
+
+	rcu_read_lock();
+	pid = find_vpid(tgid);
+	p = pid_task(pid, PIDTYPE_PID);
+	if (p)
+		send_sig(SIGKILL, p, 0);
+	rcu_read_unlock();
+	return BLK_EH_DONE;
 }
 
 static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
-- 
2.47.0

