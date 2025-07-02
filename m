Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68739184
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429056; cv=none; b=MeQjc5MDliQ9SJIff1Mh6eNwVyKHm6nBA1OV0pQM1qTkmPQ2ClzyXA4j2lRsSmsGe91iNKEg+tOATQy6tDxNPBx3bLpfwOJv9zXwuiOiXgBzTMYHm7CAmscanQHIhYiXydMnI74hGx4ZiZebXEMIBVHbXvCXXGjQ2TE7EgDg+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429056; c=relaxed/simple;
	bh=mHTDVJ6TrAexg2SS+q8gDZIG1q9R/RJk0LaEcT1rmV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh98jEb2oxJb47GC3zSd0LXPjHbhchqJTRuWNqBS/tjjvDrcCtd23I1FTeRfAHGbFf8EL+kVlftbugsuc/IzlnTT1XFDH7J+xPAdDjwPJ0Q/mK75dH9UF7IE1nbKS/Pz+d13ryBrNVVCX0oFr9bQzvnN2XPAg0lkhusqksxX8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQR508Gf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQR508Gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdzGyencAbtyvvOV4UlG/Na5Qeh5MXSMZ62tWj8MM6I=;
	b=CQR508GfRoddhuptJdPMNV+iEx1Zg0XGvoPjkKPVpuUotSQ1TKSy20bwhtWO07HMJuDdGn
	1mkHNfPS1l9nxccxxqnsQEcTTSc+yFPceWg5gCXftHqYoSon8I2FT4s4ix6yCR6Dx9JLP2
	InusZ5/DNER87yPoNCPXe+geRc8ZEXA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-tzvXRsGVODm4VAeSG4unAA-1; Wed,
 02 Jul 2025 00:04:07 -0400
X-MC-Unique: tzvXRsGVODm4VAeSG4unAA-1
X-Mimecast-MFC-AGG-ID: tzvXRsGVODm4VAeSG4unAA_1751429046
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9CB180028B;
	Wed,  2 Jul 2025 04:04:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCCD1195608F;
	Wed,  2 Jul 2025 04:04:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/16] ublk: look up ublk task via its pid in timeout handler
Date: Wed,  2 Jul 2025 12:03:26 +0800
Message-ID: <20250702040344.1544077-3-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Look up ublk process via its pid in timeout handler, so we can avoid to
touch io->task, because it is fragile to touch task structure.

It is fine to kill ublk server process and this way is simpler.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e2de76d78a08..834d4db3b07e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1365,14 +1365,19 @@ static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
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
+	struct task_struct *p;
+	struct pid *pid;
+
+	if (!(ubq->flags & UBLK_F_UNPRIVILEGED_DEV))
+		return BLK_EH_RESET_TIMER;
+
+	rcu_read_lock();
+	pid = find_vpid(ubq->dev->dev_info.ublksrv_pid);
+	p = pid_task(pid, PIDTYPE_PID);
+	if (p)
+		send_sig(SIGKILL, p, 0);
+	rcu_read_unlock();
+	return BLK_EH_DONE;
 }
 
 static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
-- 
2.47.0

