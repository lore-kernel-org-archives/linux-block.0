Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD8137C52
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766335326; cv=none; b=GwS/6s29XYwq788zHAZMAIJVbSJvq0D65GyRaot+ETPj/DbGV5Hh/F24mLHxd5715EHizpb5ahcqde33lo/xO3r99tfVF6rT4CHl7jchm6CcF3Z7mUlvT1oMEoJ7x6SaJ+2DrJjMgXTJ8J+gDYUQWIMuXHecdMaeVz2mxHR689I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766335326; c=relaxed/simple;
	bh=X61DOEUVn91fl39bMxHtlA2d16M05wrtu54FzQAu7xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgqnjiBo5mN9uIH6KX7DcqVXq4PyYp1qrJjzdF58NQ5LJQTC3M5a08F6qqah/BD20YqL4AtAR7yETQ0revLUulXV6/pt0/TdBvdXyi6KdFZ6twUXJoQbBLPRXHAJX8UsMxqadsYW/S1go/u8KFsqZSPcR1hn3S709T6CJOd5iYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPNc1L7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPNc1L7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766335322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c9BiTNSlgUaCxPY/hqnNL/Jiogiy9palPJFOOwML7s=;
	b=QPNc1L7v9JBBMPfSKyNYQFSdFqntqE5P26sNuiR5W8TWq09gvknV4GWr6nHZ6KkTUS93IY
	aFHixq1vijb4G3KxF2nL0MXMeUhX8PEkZ6DtExR0zx5DVFTrkZNDLvubowx9xfhCgygKxS
	lkzbSefhOTL9m/yPeCvJLwHYkYU1vVA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-0cxDnWgzMNaIPkPJkJDikA-1; Sun,
 21 Dec 2025 11:41:58 -0500
X-MC-Unique: 0cxDnWgzMNaIPkPJkJDikA-1
X-Mimecast-MFC-AGG-ID: 0cxDnWgzMNaIPkPJkJDikA_1766335317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6892B180035A;
	Sun, 21 Dec 2025 16:41:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87F1E180049F;
	Sun, 21 Dec 2025 16:41:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] ublk: scan partition in async way
Date: Mon, 22 Dec 2025 00:41:41 +0800
Message-ID: <20251221164145.1703448-2-ming.lei@redhat.com>
In-Reply-To: <20251221164145.1703448-1-ming.lei@redhat.com>
References: <20251221164145.1703448-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Implement async partition scan to avoid IO hang when reading partition
tables. Similar to nvme_partition_scan_work(), partition scanning is
deferred to a work queue to prevent deadlocks.

When partition scan happens synchronously during add_disk(), IO errors
can cause the partition scan to wait while holding ub->mutex, which
can deadlock with other operations that need the mutex.

Changes:
- Add partition_scan_work to ublk_device structure
- Implement ublk_partition_scan_work() to perform async scan
- Always suppress sync partition scan during add_disk()
- Schedule async work after add_disk() for trusted daemons
- Add flush_work() in ublk_stop_dev() before grabbing ub->mutex

Reported-by: Yoav Cohen <yoav@nvidia.com>
Closes: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 49c208457198..21593826ad2d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -237,6 +237,7 @@ struct ublk_device {
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 	struct delayed_work	exit_work;
+	struct work_struct	partition_scan_work;
 
 	struct ublk_queue       *queues[];
 };
@@ -254,6 +255,20 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
+static void ublk_partition_scan_work(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, partition_scan_work);
+
+	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+					     &ub->ub_disk->state)))
+		return;
+
+	mutex_lock(&ub->ub_disk->open_mutex);
+	bdev_disk_changed(ub->ub_disk, false);
+	mutex_unlock(&ub->ub_disk->open_mutex);
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2026,6 +2041,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
+	flush_work(&ub->partition_scan_work);
 	ublk_cancel_dev(ub);
 }
 
@@ -2954,9 +2970,14 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	ublk_apply_params(ub);
 
-	/* don't probe partitions if any daemon task is un-trusted */
-	if (ub->unprivileged_daemons)
-		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+	/*
+	 * Suppress partition scan to avoid potential IO hang.
+	 * If a path error occurs during partition scan, the IO may wait
+	 * while holding ub->mutex, which can deadlock with other operations
+	 * that need the mutex. Defer partition scan to async work.
+	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set permanently.
+	 */
+	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
 	ublk_get_device(ub);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
@@ -2973,6 +2994,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	set_bit(UB_STATE_USED, &ub->state);
 
+	/* Schedule async partition scan for trusted daemons */
+	if (!ub->unprivileged_daemons)
+		schedule_work(&ub->partition_scan_work);
+
 out_put_cdev:
 	if (ret) {
 		ublk_detach_disk(ub);
@@ -3138,6 +3163,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
 	mutex_init(&ub->cancel_mutex);
+	INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
-- 
2.47.0

