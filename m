Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392726B971
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629973; cv=none; b=AYJJqaqbubVINXAtIO+hD6p2OlfDBNGd8H9NxoLmeqmyTL/QXXgByrGzbsSBRkbp1ZHoGbQm7YcEQKa9KunEjKNf7eSS3TmcMn7sXAxCytxl5MYhT70ak1y+c5RABoesuVlvKyesEfPhYWWE9okwYNupkLFMrkdpwNyjoqQyz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629973; c=relaxed/simple;
	bh=vV1jF6s4yzT6TSlK/7SxZagifi048xVOb52MHvKdiy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv2DIeYBM/ekA1GxiJsUArDCpYSEP2dBK82/rVwI3n4Z1j2fPXdin7ym2bjRv0s6hRvqBdZrCNPumCE1zoYZCmL3vZhP2jq3CO5b9rJF8p9nbtfdw0I14aDpbfFI8Ba29YZM6EmaKx94Zdq1VR2AUUUXFvn5GM8YFnGYmN4Emg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mw+W4Xw7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mw+W4Xw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6VkbWQU/Vr9/g/fisYDScHLNEwQRwN0wR0mBlHGQdQ=;
	b=Mw+W4Xw7W7TsO7/fYEo0wyDe9v7rKVXwH9huJKYm56gnZkpEYxVnCgwrR1S4NgFFjgDBhw
	ytkSnJz1GD1DG3OSOWr6IfGFkIdFVfEl/ed8Y3SInhRAvXMah1PNSoiCsCxMq0F2yE4YQ0
	cxV30nfjSrzFI4XaxeGEkLLQc5sIw1E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-sebirYpqP5WSAnuEcSeeUA-1; Mon,
 14 Apr 2025 07:26:07 -0400
X-MC-Unique: sebirYpqP5WSAnuEcSeeUA-1
X-Mimecast-MFC-AGG-ID: sebirYpqP5WSAnuEcSeeUA_1744629966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9252619560BD;
	Mon, 14 Apr 2025 11:26:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 722661808867;
	Mon, 14 Apr 2025 11:26:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Date: Mon, 14 Apr 2025 19:25:43 +0800
Message-ID: <20250414112554.3025113-3-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Uday Shankar <ushankar@purestorage.com>

Most uring_cmds issued against ublk character devices are serialized
because each command affects only one queue, and there is an early check
which only allows a single task (the queue's ubq_daemon) to issue
uring_cmds against that queue. However, this mechanism does not work for
FETCH_REQs, since they are expected before ubq_daemon is set. Since
FETCH_REQs are only used at initialization and not in the fast path,
serialize them using the per-ublk-device mutex. This fixes a number of
data races that were previously possible if a badly behaved ublk server
decided to issue multiple FETCH_REQs against the same qid/tag
concurrently.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 15de4881f25b..79f42ed7339f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1832,8 +1832,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1845,7 +1845,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -1985,17 +1984,25 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
+		mutex_lock(&ub->mutex);
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret = -EBUSY;
-			goto out;
+			goto out_unlock;
 		}
 		/*
 		 * The io is being handled by server, so COMMIT_RQ is expected
 		 * instead of FETCH_REQ
 		 */
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
+			goto out_unlock;
+
+		/*
+		 * Check again (with mutex held) that the I/O is not
+		 * active - if so, someone may have already fetched it
+		 */
+		if (io->flags & UBLK_IO_FLAG_ACTIVE)
+			goto out_unlock;
 
 		if (ublk_need_map_io(ubq)) {
 			/*
@@ -2003,15 +2010,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			 * DATA is not enabled
 			 */
 			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
+				goto out_unlock;
 		} else if (ub_cmd->addr) {
 			/* User copy requires addr to be unset */
 			ret = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
+		mutex_unlock(&ub->mutex);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
@@ -2051,7 +2059,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
- out:
+out_unlock:
+	mutex_unlock(&ub->mutex);
+out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;
-- 
2.47.0

