Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2435968
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937488; cv=none; b=BvcjHLsf30UTbh+m3x5JJ35f/ytoy4zYaM3nvOW2SdBvjRJKJ7begG/OJHa56/vqpnhTJk9xk5OOr20wh7TlT7qIbTwkWK3ByhEUMBPNztzLPHSOnh6BB22k7ak14RynPuwLO9VU9Ko/wmS1rzVoyzrT9vYn9GMJ0Ssqh85URl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937488; c=relaxed/simple;
	bh=OCmzWu6KxOMR5zF8YERHAEIw6Ymc+8g+f4qxv3YtyBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwdSVqw0ly5eJWubL15ArYM1TO75S1zJYMBmPRxpHq6ERhzKiVn8lwcl3c2XU43E1YRkHRbTERjjK0U8s3/Z+fRpX4JUYlg3X/DDOWWALrkkcZTs7Kv8hFSp57bj1kll5QxqA7jrRW+uq7aZDZzm7Ad6QIgnfHHEicP2yQeH6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwaPLrm5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwaPLrm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKDn1h/V684rk1Hy4qtuvqP/ecMpBMUClL+EneS43+c=;
	b=gwaPLrm5nCM0ffkDOtgQZ+u9Fzt/mdAW9Wfes6KElQztuyAsuPGpy7T0UiJHNpJj5NS121
	GnSI839Ocf8uhMMPYA/SP0OVn4V8ilEfbWNgTog0V6mRr5r4LWIXjRVSNGSFY8WYR4nJYZ
	fwixrAAmio6k3ok8GtBbIabOChIGO0k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-sKRN2uyKOUer7aEkLl5qaA-1; Mon,
 07 Jul 2025 21:18:02 -0400
X-MC-Unique: sKRN2uyKOUer7aEkLl5qaA-1
X-Mimecast-MFC-AGG-ID: sKRN2uyKOUer7aEkLl5qaA_1751937481
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FFC2180028C;
	Tue,  8 Jul 2025 01:18:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2548C19560AD;
	Tue,  8 Jul 2025 01:17:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 02/16] ublk: look up ublk task via its pid in timeout handler
Date: Tue,  8 Jul 2025 09:17:29 +0800
Message-ID: <20250708011746.2193389-3-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Look up ublk process via its pid in timeout handler, so we can avoid to
touch io->task, because it is fragile to touch task structure.

It is fine to kill ublk server process and this way is simpler.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 65daa6ed3a8e..d7b5ee96978a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1367,14 +1367,19 @@ static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
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

