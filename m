Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E1236683F
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726805; cv=none; b=WExGtdkc6s347uhBTYjEB7c+mX2qR8uL7+x+dwCJck5uKrv72kZsKs/IeMsH3+mrKyXZmSK406GfQdxdUa2rvDArLkZ/f1T4knuWdSmWUqNydP7Q0Xi8TlC5yw/uquo3jeR0Ca1xnhKSMzK++6y+8kX0u1T7PgHtN0ZTz67X91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726805; c=relaxed/simple;
	bh=0LMt4jRHpu2urXzaYdjfgjXEBB8zUcqCUXvSsUOvhyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuiqrUrJTo6LMswBC7/C93KnBKFwot5Xf4CtMTJ0A0fvqZPXafNE+VMwNGHAUXeRM76MigA1AkaDMMrucnBhoyDYyGBFprMmzIPsdCAgQHFP/JtDQYYvA0aZITcQfMKuLYTtdrKUkgC778jyuTVgVlOViKJ/QxbE7KDu1nc2C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OUYay9cn; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OUYay9cn"
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-124abf957dcso1195c88.3
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769726803; x=1770331603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/oKFZQ1e5/OZgmuar7zax65YK2duH1RPNyG6auf6wk=;
        b=OUYay9cnrM/N0nP68l2m4c+33Vzn03ZLZBCOOe2b4z8blut17q1OmhFlbtDeqA4mx8
         t2pj3WEN4hQd16d8qdCegFjeXkpLg2swZR4pBKU9zuTJ2BNzmxX9AUAfCxTicgCqZbnZ
         X9e36wYnhxLfd74Y8ewPCP0venWygdGUYiJe0Hkcyw2CqE9Xmqd0NlGNioGsef7slKSk
         a9oMje0dCuMe8acDccZPM2PPuwe15WlNBa70sd66IRJCVoaYQ6KdIQfNcWjDb+H8os/H
         1vzCVrr44OtXqa+Ocyf+g5N/Bv8x0SzCpKVfm5EcdKq1J8ZGx6/3gIB7xfmHLT2qQQeG
         8N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726803; x=1770331603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/oKFZQ1e5/OZgmuar7zax65YK2duH1RPNyG6auf6wk=;
        b=MQgjFzr8BUz0HnYoRdrxAoD6gWvpsU9FTXyIUlJnFgtg4uwzDzv9DxzWd8ZSNRzRR3
         g6cIWGhjI+TltwMnhbPWsGrxsms53+6b94eNK8reCiMxq+uwi+fLoX5rNMlOiXOgLjbJ
         iNOoZ9kvfYZHxB2XzZGmrf3Pdd9pBHeVn+ISsdyzoomKvWGTw2U5DF4lrvgkXtkTnNHo
         3gnoc5PqjoRM1UfNRURBW6K1K38gGgAFI9NLYoPbhAWSw8TykDPY0vcxWYuUHsA72OF+
         feHuiZoGmx1skpYFFsiDO9J7ETn5DBJr5nqWz/Y1AXNWibd4aBIpm9JyeBybCF3+Jjeo
         yA1A==
X-Forwarded-Encrypted: i=1; AJvYcCXSZ6Zj58aNUb36yx8bJQWhbCyZGLWiHJ6gL1Wa99sRvHeYgA3xsZuVp3DEI7Iz2A/Vlh7lNMfCWQKLCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWFBy/C/y/Z/iBdieOYYD2abNDFoWCPUIUfIaPkDv1vm5CeHD
	a8vNUiiafzIZDGTTOMfz7UAUx90BZA9FZc6MORADvvGdkA5KTcWnHj8H6SIpkmabHdg7fcMWKPS
	rCCTzMN7PzRm421COzC8T7ETGBf38dYNGi0bKFn79aAHSkziI2390
X-Gm-Gg: AZuq6aJLN5HFC6ZnkdGrP571tGLpLiig9odHs0wA9BCvxvu3T5JSr5Y1IEK6VrMBJOA
	3HijQWEqCzlnHio+OvRaH/P6768obE9qlr5GrJzqKPvv3m1KODv1BH7VW03EDFgC3xV8ks55Feg
	H1v/X4OYna1GTGrUnGWhhDJeReEZWaxKDnZFNQ84q/i0r7xjYPa42ElUwqscngSCqPYrHEX9SVE
	A+8+z3T1VTrrxl+OXHC1CxiV4IaYWSjy54S3DWsMONV9J18fL/xKxtbeSoAxgfgn1X80SrqLEz0
	3ZZe4aea2TlT4PNM7begNQC/jhnHk55LN+Xxe0PguxdQ//qWNY/DLyTOpnFD539bQHJrQ5ZjZay
	KRew31QngQSAbbcVk849mywSJ/N4=
X-Received: by 2002:a05:7022:fa6:b0:11b:98e8:624e with SMTP id a92af1059eb24-125c0fe4b12mr285821c88.4.1769726802567;
        Thu, 29 Jan 2026 14:46:42 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-124a9dd3268sm1092804c88.6.2026.01.29.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:46:42 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BBF1A341C9D;
	Thu, 29 Jan 2026 15:46:41 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B0C4AE40971; Thu, 29 Jan 2026 15:46:41 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/4] ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
Date: Thu, 29 Jan 2026 15:46:16 -0700
Message-ID: <20260129224618.975401-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260129224618.975401-1-csander@purestorage.com>
References: <20260129224618.975401-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ublksrv_ctrl_cmd is part of the io_uring_sqe, which may lie in
userspace-mapped memory. It's racy to access its fields with normal
loads, as userspace may write to them concurrently. Use READ_ONCE() for
all the ublksrv_ctrl_cmd field accesses to avoid the race.

Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 77 +++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 29c6942450c2..49510216832f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4188,15 +4188,13 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	spin_unlock(&ublk_idr_lock);
 
 	return ub;
 }
 
-static int ublk_ctrl_start_dev(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_start_dev(struct ublk_device *ub, int ublksrv_pid)
 {
 	const struct ublk_param_basic *p = &ub->params.basic;
-	int ublksrv_pid = (int)header->data[0];
 	struct queue_limits lim = {
 		.logical_block_size	= 1 << p->logical_bs_shift,
 		.physical_block_size	= 1 << p->physical_bs_shift,
 		.io_min			= 1 << p->io_min_shift,
 		.io_opt			= 1 << p->io_opt_shift,
@@ -4346,15 +4344,14 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
 static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header, u64 addr, u16 len)
+		u64 queue, u64 addr, u16 len)
 {
 	void __user *argp = (void __user *)addr;
 	cpumask_var_t cpumask;
-	unsigned long queue;
 	unsigned int retlen;
 	unsigned int i;
 	int ret;
 
 	if (len * BITS_PER_BYTE < nr_cpu_ids)
@@ -4362,11 +4359,10 @@ static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 	if (len & (sizeof(unsigned long)-1))
 		return -EINVAL;
 	if (!addr)
 		return -EINVAL;
 
-	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
 		return -EINVAL;
 
 	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
@@ -4396,23 +4392,22 @@ static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 			info->dev_id, info->flags);
 	pr_devel("\t nr_hw_queues %d queue_depth %d\n",
 			info->nr_hw_queues, info->queue_depth);
 }
 
-static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header,
-			     u64 addr, u16 len)
+static int ublk_ctrl_add_dev(u32 dev_id, u16 qid, u64 addr, u16 len)
 {
 	void __user *argp = (void __user *)addr;
 	struct ublksrv_ctrl_dev_info info;
 	struct ublk_device *ub;
 	int ret = -EINVAL;
 
 	if (len < sizeof(info) || !addr)
 		return -EINVAL;
-	if (header->queue_id != (u16)-1) {
+	if (qid != (u16)-1) {
 		pr_warn("%s: queue_id is wrong %x\n",
-			__func__, header->queue_id);
+			__func__, qid);
 		return -EINVAL;
 	}
 
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
@@ -4473,17 +4468,17 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header,
 		return -EINVAL;
 
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
-	if (header->dev_id != info.dev_id) {
+	if (dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
-			__func__, header->dev_id, info.dev_id);
+			__func__, dev_id, info.dev_id);
 		return -EINVAL;
 	}
 
-	if (header->dev_id != U32_MAX && header->dev_id >= UBLK_MAX_UBLKS) {
+	if (dev_id != U32_MAX && dev_id >= UBLK_MAX_UBLKS) {
 		pr_warn("%s: dev id is too large. Max supported is %d\n",
 			__func__, UBLK_MAX_UBLKS - 1);
 		return -EINVAL;
 	}
 
@@ -4505,11 +4500,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header,
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
 	mutex_init(&ub->cancel_mutex);
 	INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
 
-	ret = ublk_alloc_dev_number(ub, header->dev_id);
+	ret = ublk_alloc_dev_number(ub, dev_id);
 	if (ret < 0)
 		goto out_free_ub;
 
 	memcpy(&ub->dev_info, &info, sizeof(info));
 
@@ -4641,17 +4636,15 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
 	if (wait && wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
 		return -EINTR;
 	return 0;
 }
 
-static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
+static inline void ublk_ctrl_cmd_dump(u32 cmd_op, u32 dev_id, u16 qid,
+				      u64 data, u64 addr, u16 len)
 {
-	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
-
 	pr_devel("%s: cmd_op %x, dev id %d qid %d data %llx buf %llx len %u\n",
-			__func__, cmd->cmd_op, header->dev_id, header->queue_id,
-			header->data[0], header->addr, header->len);
+			__func__, cmd_op, dev_id, qid, data, addr, len);
 }
 
 static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
@@ -4819,13 +4812,12 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
 static int ublk_ctrl_end_recovery(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+		const struct ublksrv_ctrl_cmd *header, int ublksrv_pid)
 {
-	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
 
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
 		 header->dev_id);
 
@@ -4869,14 +4861,13 @@ static int ublk_ctrl_get_features(u64 addr, u16 len)
 		return -EFAULT;
 
 	return 0;
 }
 
-static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
+static void ublk_ctrl_set_size(struct ublk_device *ub, u64 new_size)
 {
 	struct ublk_param_basic *p = &ub->params.basic;
-	u64 new_size = header->data[0];
 
 	mutex_lock(&ub->mutex);
 	p->dev_sectors = new_size;
 	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
 	mutex_unlock(&ub->mutex);
@@ -4950,15 +4941,13 @@ static int ublk_wait_for_idle_io(struct ublk_device *ub,
 		ret = 0;
 
 	return ret;
 }
 
-static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
-				 const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_quiesce_dev(struct ublk_device *ub, u64 timeout_ms)
 {
 	/* zero means wait forever */
-	u64 timeout_ms = header->data[0];
 	struct gendisk *disk;
 	int ret = -ENODEV;
 
 	if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
 		return -EOPNOTSUPP;
@@ -5032,10 +5021,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	void __user *argp = (void __user *)*addr;
 	char *dev_path = NULL;
+	u16 dev_path_len;
 	int ret = 0;
 	int mask;
 
 	if (!unprivileged) {
 		if (!capable(CAP_SYS_ADMIN))
@@ -5054,17 +5044,18 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	 * User has to provide the char device path for unprivileged ublk
 	 *
 	 * header->addr always points to the dev path buffer, and
 	 * header->dev_path_len records length of dev path buffer.
 	 */
-	if (!header->dev_path_len || header->dev_path_len > PATH_MAX)
+	dev_path_len = READ_ONCE(header->dev_path_len);
+	if (!dev_path_len || dev_path_len > PATH_MAX)
 		return -EINVAL;
 
-	if (*len < header->dev_path_len)
+	if (*len < dev_path_len)
 		return -EINVAL;
 
-	dev_path = memdup_user_nul(argp, header->dev_path_len);
+	dev_path = memdup_user_nul(argp, dev_path_len);
 	if (IS_ERR(dev_path))
 		return PTR_ERR(dev_path);
 
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd->cmd_op)) {
@@ -5091,12 +5082,12 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		goto exit;
 	}
 
 	ret = ublk_char_dev_permission(ub, dev_path, mask);
 	if (!ret) {
-		*len -= header->dev_path_len;
-		*addr += header->dev_path_len;
+		*len -= dev_path_len;
+		*addr += dev_path_len;
 	}
 	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
 			__func__, ub->ub_number, cmd->cmd_op,
 			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
 			dev_path, ret);
@@ -5123,23 +5114,29 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	struct ublk_device *ub = NULL;
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
+	u32 dev_id;
+	u16 qid;
+	u64 data;
 	u64 addr;
 	u16 len;
 
 	if (ublk_ctrl_uring_cmd_may_sleep(cmd_op) &&
 	    issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
 	if (!(issue_flags & IO_URING_F_SQE128))
 		return -EINVAL;
 
+	dev_id = READ_ONCE(header->dev_id);
+	qid = READ_ONCE(header->queue_id);
+	data = READ_ONCE(header->data[0]);
 	addr = READ_ONCE(header->addr);
 	len = READ_ONCE(header->len);
-	ublk_ctrl_cmd_dump(cmd);
+	ublk_ctrl_cmd_dump(cmd_op, dev_id, qid, data, addr, len);
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
@@ -5148,42 +5145,42 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 	}
 
 	if (_IOC_NR(cmd_op) != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
-		ub = ublk_get_device_from_id(header->dev_id);
+		ub = ublk_get_device_from_id(dev_id);
 		if (!ub)
 			goto out;
 
 		ret = ublk_ctrl_uring_cmd_permission(ub, cmd, &addr, &len);
 		if (ret)
 			goto put_dev;
 	}
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_CMD_START_DEV:
-		ret = ublk_ctrl_start_dev(ub, header);
+		ret = ublk_ctrl_start_dev(ub, data);
 		break;
 	case UBLK_CMD_STOP_DEV:
 		ublk_ctrl_stop_dev(ub);
 		ret = 0;
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
 		ret = ublk_ctrl_get_dev_info(ub, addr, len);
 		break;
 	case UBLK_CMD_ADD_DEV:
-		ret = ublk_ctrl_add_dev(header, addr, len);
+		ret = ublk_ctrl_add_dev(dev_id, qid, addr, len);
 		break;
 	case UBLK_CMD_DEL_DEV:
 		ret = ublk_ctrl_del_dev(&ub, true);
 		break;
 	case UBLK_CMD_DEL_DEV_ASYNC:
 		ret = ublk_ctrl_del_dev(&ub, false);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
-		ret = ublk_ctrl_get_queue_affinity(ub, header, addr, len);
+		ret = ublk_ctrl_get_queue_affinity(ub, data, addr, len);
 		break;
 	case UBLK_CMD_GET_PARAMS:
 		ret = ublk_ctrl_get_params(ub, addr, len);
 		break;
 	case UBLK_CMD_SET_PARAMS:
@@ -5191,18 +5188,18 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
 		ret = ublk_ctrl_start_recovery(ub, header);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
-		ret = ublk_ctrl_end_recovery(ub, header);
+		ret = ublk_ctrl_end_recovery(ub, header, data);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, header);
+		ublk_ctrl_set_size(ub, data);
 		ret = 0;
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
-		ret = ublk_ctrl_quiesce_dev(ub, header);
+		ret = ublk_ctrl_quiesce_dev(ub, data);
 		break;
 	case UBLK_CMD_TRY_STOP_DEV:
 		ret = ublk_ctrl_try_stop_dev(ub);
 		break;
 	default:
@@ -5213,11 +5210,11 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
  put_dev:
 	if (ub)
 		ublk_put_device(ub);
  out:
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
-			__func__, ret, cmd->cmd_op, header->dev_id, header->queue_id);
+			__func__, ret, cmd_op, dev_id, qid);
 	return ret;
 }
 
 static const struct file_operations ublk_ctl_fops = {
 	.open		= nonseekable_open,
-- 
2.45.2

