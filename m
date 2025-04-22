Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E401B3950;
	Tue, 22 Apr 2025 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288220; cv=none; b=eRCaxboCDsQf/AjHmnG9P+2wrt1c76CWT64momTDbdU8SSDQDaR2qC2KNSiZ4XFl7Yajnm8wXNLcnda430NdAvR4giGuKPWupGFa0vEP63mSZNob9oocrDYRujRNWeYQ9yl10eaWNxzBouht66iLtu4wd2Ld63Nqhv8HBDOGnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288220; c=relaxed/simple;
	bh=evr6wmvZmoWl9BNqiGKI3+LkDOEuI22eTDlcAMeN4L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGaT7yePsvYNqUIA9PZOzHx/BjUjUr0WMc3T0Y9YEWyj0jJLS0MfbG555ZOMEp7Zrij0p9ZL+K8eFoxlERrZeqHGj5AMXagRn3tJ3aPYkyKn3GurApBzAohlIRGwelRTri5w7u/Ujs1Fz4AQLinTKkQgr/OuIzdCalah7GRfun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrW5tdo0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrW5tdo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF4EC4CEE4;
	Tue, 22 Apr 2025 02:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288220;
	bh=evr6wmvZmoWl9BNqiGKI3+LkDOEuI22eTDlcAMeN4L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrW5tdo0b4vcSRDDfnB/j3laa90lC1xG9tiDOO9kw7iWpLzLqwhRenBJh7encG7m9
	 MBniNU7HPqnktk9FrpWh6xY86xGm7+Lz1U2u+mIte6FLyBwvLBnXMR2H/ZjCcgrPif
	 IPnmVwm9XgaLgZa+HLgxBNuUkc2rNHEFMvwqtTf39Pz76QputCDYhMsvQ7zIJZ841E
	 KqZKzQKwuYQIU6hl1zSOaKPvn0XVqIcZXSQq4BB/SpQoXCsquvvmox75rvz1novH6R
	 gxuRZA4YiFHuRNd4uU8+DmRTyqVSejx1rsrw3CB0puDcvZyQj5QKtLheNpkOC0flXG
	 l6Y5jUVG6fqkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 28/30] ublk: add ublk_force_abort_dev()
Date: Mon, 21 Apr 2025 22:15:48 -0400
Message-Id: <20250422021550.1940809-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 00b3b0d7cb454d614117c93f33351cdcd20b5b93 ]

Add ublk_force_abort_dev() for handling ublk_nosrv_dev_should_queue_io()
in ublk_stop_dev(). Then queue quiesce and unquiesce can be paired in
single function.

Meantime not change device state to QUIESCED any more, since the disk is
going to be removed soon.

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 971b793dedd03..611a4b2afbbf3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1638,22 +1638,20 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 }
 
-static void ublk_unquiesce_dev(struct ublk_device *ub)
+static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
 
-	pr_devel("%s: unquiesce ub: dev_id %d state %s\n",
+	pr_devel("%s: force abort ub: dev_id %d state %s\n",
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
-	/* quiesce_work has run. We let requeued rqs be aborted
-	 * before running fallback_wq. "force_abort" must be seen
-	 * after request queue is unqiuesced. Then del_gendisk()
-	 * can move on.
-	 */
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE)
+		ublk_wait_tagset_rqs_idle(ub);
+
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->force_abort = true;
-
 	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	/* We may have requeued some rqs in ublk_quiesce_queue() */
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
@@ -1681,11 +1679,8 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
-			__ublk_quiesce_dev(ub);
-		ublk_unquiesce_dev(ub);
-	}
+	if (ublk_nosrv_dev_should_queue_io(ub))
+		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
-- 
2.39.5

