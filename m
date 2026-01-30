Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46323502AC
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793273; cv=none; b=LHq5TT4o2cRp8063ImwJ9JRJge/CTnk1Mb2qNyy74b0/XXio/3dHkvEIjF0vPDLHLDoy6H2ADo+HI/2PiFnrxtRQ8h9RZYTyLxFUM4QIa66ZPFTx+1WGRIrjGu5k8L6jiFoSZgUiiqyO1t7GrQ2mtPGN3F+yjqFFtXt/zjbIAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793273; c=relaxed/simple;
	bh=0cZw4WoTg3BdK7j57W9095lLp2dvzuFS4CxIHf8f6HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1owytop1mSaJyzIv3W68cKUdg6LoSEr+raJFvD98Bo8u0+WIkK12+tPyomdNu0rUaS6fQRKh2rbQ+BXX+r9qbUtVdtWCHhICZkDrd8zDe6JyPmiUb8U84GTAmhSefNcjNh9VuV4XPNQ8e18vAhvlQHmtsxmtFU3Whayl/ShJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X5KK5dei; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X5KK5dei"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-82362ee87edso59781b3a.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769793271; x=1770398071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzKEcCAgobrhhmQRZuiW3ilTQpyqp+GPnanCxT2FyvI=;
        b=X5KK5deiJW7bRr4YflAN7LlnrKIMu7MwAbRmOywk2JfwXJCwQE+IFpSI2m5j1dsu6y
         1hjdUSrW18xtefzWN7aHuqjZIxqCBIwQMnjR06j2jat85BVcjet5KMoGgELQubhOMYFP
         hCTjZXKthN0qJcij+wRNt68LfYbjmqyqxcBXNvKLE857E2vidPSlCc6vOQ7oqHY6k1dN
         OnglobwGbdgRhHRkL9myp/7IWqgWgo5aqfwQaYM2Oh5osC0k4w+AoMQpawvBFWJFqaC7
         2RzBqt+txLDLLPzTNJBaNC5wgllMmjoQyKIRG5Bcv39rR2/YLnXNQpUKAK7PUFVXOMy9
         q6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793271; x=1770398071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzKEcCAgobrhhmQRZuiW3ilTQpyqp+GPnanCxT2FyvI=;
        b=DD2B/N5XYPxw+Z7tR+e/YUvnZihkeCVNy8TV3r4fP299tNb2EkOOJOi4vIx7CoW+Yu
         ZcVtl14NZb3QdarOIwC+rN2pgRmWIS9tWJ1RfdyKYMBcRhmSuGlaSrorpKDF2V/23bmQ
         LWBSvwVBq2gvo8pw3Aj+wJv0fms9f/FDLxkgRMtWZ+yi4b+ExL9JZWFQ8JRAM94KHYTM
         D0S1dWkB90rOHH/8kqCjuL8/5S9owA5NwOm0wX+Tz7z4YF6WeOwzuGyh1hjmRpW/Arnd
         AFLtFmY7nPYkp9Nn6bxsxRBZzVvMOtIUtufm9eUcO/gspptwtMBR5YcsRzrN9llPXp7G
         rKdA==
X-Forwarded-Encrypted: i=1; AJvYcCW5rGDIE/YxvF6T122eU5ChpuoFu0o1oyyIy2H7FizsXeZOMKkdBlU1+MzUGuf/YGcv4NVI3mVYnDocRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+W9CdLeOIufPedWADptYPPxiM9+JeJuut9UAw5kq1/EUO/q0
	qRrYkBrx4t3k5fN/zM9DQsnTQDvf7dOY2TzPWbh2tbJAGyECXgBjSjrLulgSQ224w3fTiN3W5Ec
	fUx37aRTnNX77uRpgJbkM8Jol+Hi03KoPefVA
X-Gm-Gg: AZuq6aK8uQSJVJ4NXRCT54RyozA4HdTyiZWBHF7N3ee2y/7sLtiRKnREUB8pCfDdJ/u
	71ZM1wOxFGCciuPzqbw+nOWCVSTIWrv/rsfmt28l8+tFj3nwf7vnfLAY5+E/xrc9x6N/5SxSP8w
	xsQR8G9mcx2oEesiw4DGviG8aOTw14xxVcQhGYxBTsHXfp9oYCNwJQlIlyjALH2EuAOp4uj1ekP
	OxcdxxR+jt6bV2NJ3c7YL0XVThWSCahj1NCCrmEiQaKy+X3tmhhCEp6o7qcuLxT4YE/E3zF+l4k
	rFD7BFdY7vPAY6a7BfbGrP7TCZwZ3A8B5c6lIqvsNvwZYjcW5AjD6WnT6lSmBrjK23gZd4e8Y0N
	H3eiEF2mfCV0ZlrL2oKlS/vVCszq2/Qv3y+EWbYhzWQ==
X-Received: by 2002:a17:902:e003:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2a8d958e55dmr19048675ad.1.1769793270921;
        Fri, 30 Jan 2026 09:14:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b7f86c3sm10838705ad.53.2026.01.30.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:14:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1856B340603;
	Fri, 30 Jan 2026 10:14:30 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 13438E40249; Fri, 30 Jan 2026 10:14:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/3] ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
Date: Fri, 30 Jan 2026 10:14:13 -0700
Message-ID: <20260130171414.1376543-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260130171414.1376543-1-csander@purestorage.com>
References: <20260130171414.1376543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ublksrv_ctrl_cmd is part of the io_uring_sqe, which may lie in
userspace-mapped memory. It's racy to access its fields with normal
loads, as userspace may write to them concurrently. Use READ_ONCE() to
copy the ublksrv_ctrl_cmd from the io_uring_sqe to the stack. Use the
local copy in place of the one in the io_uring_sqe.

Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 56 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 01088194c8d3..8122b012a7ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4729,16 +4729,15 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
 	if (wait && wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
 		return -EINTR;
 	return 0;
 }
 
-static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
+static inline void ublk_ctrl_cmd_dump(u32 cmd_op,
+				      const struct ublksrv_ctrl_cmd *header)
 {
-	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
-
 	pr_devel("%s: cmd_op %x, dev id %d qid %d data %llx buf %llx len %u\n",
-			__func__, cmd->cmd_op, header->dev_id, header->queue_id,
+			__func__, cmd_op, header->dev_id, header->queue_id,
 			header->data[0], header->addr, header->len);
 }
 
 static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
@@ -5117,13 +5116,12 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 	path_put(&path);
 	return err;
 }
 
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
-		struct io_uring_cmd *cmd)
+		u32 cmd_op, struct ublksrv_ctrl_cmd *header)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)io_uring_sqe_cmd(cmd->sqe);
 	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	char *dev_path = NULL;
 	int ret = 0;
 	int mask;
@@ -5135,11 +5133,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		 * The new added command of UBLK_CMD_GET_DEV_INFO2 includes
 		 * char_dev_path in payload too, since userspace may not
 		 * know if the specified device is created as unprivileged
 		 * mode.
 		 */
-		if (_IOC_NR(cmd->cmd_op) != UBLK_CMD_GET_DEV_INFO2)
+		if (_IOC_NR(cmd_op) != UBLK_CMD_GET_DEV_INFO2)
 			return 0;
 	}
 
 	/*
 	 * User has to provide the char device path for unprivileged ublk
@@ -5156,11 +5154,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	dev_path = memdup_user_nul(argp, header->dev_path_len);
 	if (IS_ERR(dev_path))
 		return PTR_ERR(dev_path);
 
 	ret = -EINVAL;
-	switch (_IOC_NR(cmd->cmd_op)) {
+	switch (_IOC_NR(cmd_op)) {
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 	case UBLK_CMD_GET_PARAMS:
 	case (_IOC_NR(UBLK_U_CMD_GET_FEATURES)):
@@ -5186,11 +5184,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	if (!ret) {
 		header->len -= header->dev_path_len;
 		header->addr += header->dev_path_len;
 	}
 	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
-			__func__, ub->ub_number, cmd->cmd_op,
+			__func__, ub->ub_number, cmd_op,
 			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
 			dev_path, ret);
 exit:
 	kfree(dev_path);
 	return ret;
@@ -5210,11 +5208,13 @@ static bool ublk_ctrl_uring_cmd_may_sleep(u32 cmd_op)
 }
 
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
+	/* May point to userspace-mapped memory */
+	const struct ublksrv_ctrl_cmd *ub_src = io_uring_sqe_cmd(cmd->sqe);
+	struct ublksrv_ctrl_cmd header;
 	struct ublk_device *ub = NULL;
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
 
 	if (ublk_ctrl_uring_cmd_may_sleep(cmd_op) &&
@@ -5222,74 +5222,80 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		return -EAGAIN;
 
 	if (!(issue_flags & IO_URING_F_SQE128))
 		return -EINVAL;
 
-	ublk_ctrl_cmd_dump(cmd);
+	header.dev_id = READ_ONCE(ub_src->dev_id);
+	header.queue_id = READ_ONCE(ub_src->queue_id);
+	header.len = READ_ONCE(ub_src->len);
+	header.addr = READ_ONCE(ub_src->addr);
+	header.data[0] = READ_ONCE(ub_src->data[0]);
+	header.dev_path_len = READ_ONCE(ub_src->dev_path_len);
+	ublk_ctrl_cmd_dump(cmd_op, &header);
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
 	if (cmd_op == UBLK_U_CMD_GET_FEATURES) {
-		ret = ublk_ctrl_get_features(header);
+		ret = ublk_ctrl_get_features(&header);
 		goto out;
 	}
 
 	if (_IOC_NR(cmd_op) != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
-		ub = ublk_get_device_from_id(header->dev_id);
+		ub = ublk_get_device_from_id(header.dev_id);
 		if (!ub)
 			goto out;
 
-		ret = ublk_ctrl_uring_cmd_permission(ub, cmd);
+		ret = ublk_ctrl_uring_cmd_permission(ub, cmd_op, &header);
 		if (ret)
 			goto put_dev;
 	}
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_CMD_START_DEV:
-		ret = ublk_ctrl_start_dev(ub, header);
+		ret = ublk_ctrl_start_dev(ub, &header);
 		break;
 	case UBLK_CMD_STOP_DEV:
 		ublk_ctrl_stop_dev(ub);
 		ret = 0;
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
-		ret = ublk_ctrl_get_dev_info(ub, header);
+		ret = ublk_ctrl_get_dev_info(ub, &header);
 		break;
 	case UBLK_CMD_ADD_DEV:
-		ret = ublk_ctrl_add_dev(header);
+		ret = ublk_ctrl_add_dev(&header);
 		break;
 	case UBLK_CMD_DEL_DEV:
 		ret = ublk_ctrl_del_dev(&ub, true);
 		break;
 	case UBLK_CMD_DEL_DEV_ASYNC:
 		ret = ublk_ctrl_del_dev(&ub, false);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
-		ret = ublk_ctrl_get_queue_affinity(ub, header);
+		ret = ublk_ctrl_get_queue_affinity(ub, &header);
 		break;
 	case UBLK_CMD_GET_PARAMS:
-		ret = ublk_ctrl_get_params(ub, header);
+		ret = ublk_ctrl_get_params(ub, &header);
 		break;
 	case UBLK_CMD_SET_PARAMS:
-		ret = ublk_ctrl_set_params(ub, header);
+		ret = ublk_ctrl_set_params(ub, &header);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
-		ret = ublk_ctrl_start_recovery(ub, header);
+		ret = ublk_ctrl_start_recovery(ub, &header);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
-		ret = ublk_ctrl_end_recovery(ub, header);
+		ret = ublk_ctrl_end_recovery(ub, &header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, header);
+		ublk_ctrl_set_size(ub, &header);
 		ret = 0;
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
-		ret = ublk_ctrl_quiesce_dev(ub, header);
+		ret = ublk_ctrl_quiesce_dev(ub, &header);
 		break;
 	case UBLK_CMD_TRY_STOP_DEV:
 		ret = ublk_ctrl_try_stop_dev(ub);
 		break;
 	default:
@@ -5300,11 +5306,11 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
  put_dev:
 	if (ub)
 		ublk_put_device(ub);
  out:
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
-			__func__, ret, cmd->cmd_op, header->dev_id, header->queue_id);
+			__func__, ret, cmd_op, header.dev_id, header.queue_id);
 	return ret;
 }
 
 static const struct file_operations ublk_ctl_fops = {
 	.open		= nonseekable_open,
-- 
2.45.2

