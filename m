Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713E367F35
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726805; cv=none; b=E5IsYPXbmXx5dQIZmTMutONT24ESiKfbMjJlu72lVfFS9fwJh0mxZ7BYhKaEhhItOnF9zH3IK8QQGumop97E1JT6V/zXzBXWUALqfVnR/JPgso8QXSOEhv8rljWTr0B+qa10Edlr+Kw3IjQjz8XmmlvJghA9bTmpjSpIgQ+U3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726805; c=relaxed/simple;
	bh=Xdmz84zqTTMUE0Z3mzNfDk4hhafk12eGoVesk+W1+ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A++IKqxJqVyU3um3L5XO7MYwqmnwQCZBi2M3wyDcYKHd4IiGy+t31x08/DC81MAIvxsf9njF/UgzIw7PYiV5z90ptkDpe0Yfz9+/xn2/qJWMDE4DbZTu2t3Cppg5M7AXPDjad1AngjC9zxA8c3B6xH2Pfu4hrt9SQUBIVXDd9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gDf9VBGw; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gDf9VBGw"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-888872eb53bso2723036d6.2
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769726803; x=1770331603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vZbymFAgIvRelMo7twIE31eDucHLj7gu7QW6XyWJSs=;
        b=gDf9VBGw1+47AmjAMQ/quL68Z4g++tZivsbZq/bm5Yj6m7IgiZW0kDzUO7l+jK7ypi
         cyr7UQx55zKlGQ30vlIsmGmIbemsgFDuKLSGWqHGjYY8iSdd/ROTDL2FdoGTdGPumK/0
         2jCYXu7vw/sVL/SMLLEzIzdymwpjPRotIxT+HOaNxsCjBSXKLhMsybsgjkKsVFKdmCyS
         zwhqVLoYSZGLqFffkECkJgVC4R68rvX36loO1mE5cHRo02m3rmYVH7bVChtInhTvrpFw
         g2idRHn3Qjlm4dhjDY80r9RvHWX7YPGo4o+ahF3iQ4Xne2NS3s5ef4ZptppLjn+F06Gm
         kL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726803; x=1770331603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1vZbymFAgIvRelMo7twIE31eDucHLj7gu7QW6XyWJSs=;
        b=ks7StQpVSAh3pmigpO4NElzeyL1jMxrogQNr5y72Q1JA1tuyGJDMlRdXFsTpM2P6uF
         9W4eSLpSnnEPk9fpg+SApc7FpxpujAJ/WoffyeQBrkUmYPkGcq1Ja7aiD7MJKpIc6FTA
         cqRQGyRE8kUgh4/2BENtmhtQMZYujYGrjzQ1wo1Pixh9qgKtdgxrKeHoosOzoiHUiGJz
         6T2a/aH5uVD9eul4INcAKDf9ctvAH0IDU1tB6hekSHfNFB5aNi3/cwq2MfSIxT74yVRM
         F+yMFUEYCIgum+d+k1i+VaGusy24qjhfaj++Lq6kw7gxJv/rpbQFJf8mJBVRZP4Mh6qH
         1Z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmAC4bBt7oXjyBDioBnmYWYSGgsDcdSVJlYP/ZlXu93EEn5VPvlpenZE90lYuwDJbC4gSBoa7LwSmoyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYoFFtKEB7TT128R8kWBa+dvTYVziLdjpTygs8wT4/tvreicJ
	PxDHggfZcAtcIvr/9erkTf+NElTUFXA89VOXJtOjSevnVHGj5Xq4u+PMnSqZX4IYgL9n2Dmj8HX
	ZT9p3vgfBWUaqtugq6rX48z5C1Jnd5USEQggQAIzcDsAHyXhWQB/K
X-Gm-Gg: AZuq6aKSJmIRTqnZL4XumjFTUUBbeujR4RPZ44dBBlLNDCfrsyP2iyjrRh7tFoTXrXE
	hnRcM9xdhGC30rkCEQlemxNS2dsDB2awqqYtCd2JyqySWhxnNNAj7hiOg3ZN/ZAgtI0Pk222VXg
	lvlmSxDfSw0hTwLWHW2ymyrd0c7pEqaGR+plCnkJ5DmJ00Qg2gHX2AZRsj5FezqaspDqo58bipG
	sR2ww7HTQVbgm4lzmTyutf8ohZVpQhme+x0ydsFMMPqjKj4kyZFKlOZapeOfYakn/PQDi2Mn3OM
	Iw11Kk6SoJ9EtL04yq86yoz7HGz3vEM7uD7pyIHtc+2v2ZPOS4TpTs8sHn9sMHTTVKmkdDOT+Lq
	/jU5YHkWm2J7IX/IPfjIOSlsqxOs=
X-Received: by 2002:a05:622a:654:b0:4f1:96c5:b592 with SMTP id d75a77b69052e-505d22f91admr11287031cf.10.1769726802985;
        Thu, 29 Jan 2026 14:46:42 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d36c15bfsm8682096d6.9.2026.01.29.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:46:42 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 81EF6340603;
	Thu, 29 Jan 2026 15:46:42 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 77E28E40456; Thu, 29 Jan 2026 15:46:41 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/4] ublk: don't write to struct ublksrv_ctrl_cmd
Date: Thu, 29 Jan 2026 15:46:15 -0700
Message-ID: <20260129224618.975401-3-csander@purestorage.com>
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

ublk_ctrl_uring_cmd_permission() writes to struct ublksrv_ctrl_cmd's
addr and len fields, which is racy because ublksrv_ctrl_cmd is part of
the io_uring_sqe, which may lie in userspace-mapped memory. Store the
values of addr in len in local variables instead to avoid the race.

Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 72ee83ae303d..29c6942450c2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4346,24 +4346,24 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
 static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+		const struct ublksrv_ctrl_cmd *header, u64 addr, u16 len)
 {
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)addr;
 	cpumask_var_t cpumask;
 	unsigned long queue;
 	unsigned int retlen;
 	unsigned int i;
 	int ret;
 
-	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
+	if (len * BITS_PER_BYTE < nr_cpu_ids)
 		return -EINVAL;
-	if (header->len & (sizeof(unsigned long)-1))
+	if (len & (sizeof(unsigned long)-1))
 		return -EINVAL;
-	if (!header->addr)
+	if (!addr)
 		return -EINVAL;
 
 	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
 		return -EINVAL;
@@ -4375,15 +4375,15 @@ static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 		if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[i] == queue)
 			cpumask_set_cpu(i, cpumask);
 	}
 
 	ret = -EFAULT;
-	retlen = min_t(unsigned short, header->len, cpumask_size());
+	retlen = min_t(unsigned short, len, cpumask_size());
 	if (copy_to_user(argp, cpumask, retlen))
 		goto out_free_cpumask;
-	if (retlen != header->len &&
-	    clear_user(argp + retlen, header->len - retlen))
+	if (retlen != len &&
+	    clear_user(argp + retlen, len - retlen))
 		goto out_free_cpumask;
 
 	ret = 0;
 out_free_cpumask:
 	free_cpumask_var(cpumask);
@@ -4396,18 +4396,19 @@ static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 			info->dev_id, info->flags);
 	pr_devel("\t nr_hw_queues %d queue_depth %d\n",
 			info->nr_hw_queues, info->queue_depth);
 }
 
-static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header,
+			     u64 addr, u16 len)
 {
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)addr;
 	struct ublksrv_ctrl_dev_info info;
 	struct ublk_device *ub;
 	int ret = -EINVAL;
 
-	if (header->len < sizeof(info) || !header->addr)
+	if (len < sizeof(info) || !addr)
 		return -EINVAL;
 	if (header->queue_id != (u16)-1) {
 		pr_warn("%s: queue_id is wrong %x\n",
 			__func__, header->queue_id);
 		return -EINVAL;
@@ -4682,16 +4683,15 @@ static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
 out:
 	ublk_put_disk(disk);
 	return ret;
 }
 
-static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_get_dev_info(struct ublk_device *ub, u64 addr, u16 len)
 {
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)addr;
 
-	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
+	if (len < sizeof(struct ublksrv_ctrl_dev_info) || !addr)
 		return -EINVAL;
 
 	if (copy_to_user(argp, &ub->dev_info, sizeof(ub->dev_info)))
 		return -EFAULT;
 
@@ -4712,24 +4712,23 @@ static void ublk_ctrl_fill_params_devt(struct ublk_device *ub)
 		ub->params.devt.disk_minor = 0;
 	}
 	ub->params.types |= UBLK_PARAM_TYPE_DEVT;
 }
 
-static int ublk_ctrl_get_params(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_get_params(struct ublk_device *ub, u64 addr, u16 len)
 {
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)addr;
 	struct ublk_params_header ph;
 	int ret;
 
-	if (header->len <= sizeof(ph) || !header->addr)
+	if (len <= sizeof(ph) || !addr)
 		return -EINVAL;
 
 	if (copy_from_user(&ph, argp, sizeof(ph)))
 		return -EFAULT;
 
-	if (ph.len > header->len || !ph.len)
+	if (ph.len > len || !ph.len)
 		return -EINVAL;
 
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
@@ -4742,24 +4741,23 @@ static int ublk_ctrl_get_params(struct ublk_device *ub,
 	mutex_unlock(&ub->mutex);
 
 	return ret;
 }
 
-static int ublk_ctrl_set_params(struct ublk_device *ub,
-		const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_set_params(struct ublk_device *ub, u64 addr, u16 len)
 {
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)addr;
 	struct ublk_params_header ph;
 	int ret = -EFAULT;
 
-	if (header->len <= sizeof(ph) || !header->addr)
+	if (len <= sizeof(ph) || !addr)
 		return -EINVAL;
 
 	if (copy_from_user(&ph, argp, sizeof(ph)))
 		return -EFAULT;
 
-	if (ph.len > header->len || !ph.len || !ph.types)
+	if (ph.len > len || !ph.len || !ph.types)
 		return -EINVAL;
 
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
@@ -4857,16 +4855,16 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
  out_unlock:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
-static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_get_features(u64 addr, u16 len)
 {
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)addr;
 	u64 features = UBLK_F_ALL;
 
-	if (header->len != UBLK_FEATURES_LEN || !header->addr)
+	if (len != UBLK_FEATURES_LEN || !addr)
 		return -EINVAL;
 
 	if (copy_to_user(argp, &features, UBLK_FEATURES_LEN))
 		return -EFAULT;
 
@@ -5028,15 +5026,15 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 	path_put(&path);
 	return err;
 }
 
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
-		struct io_uring_cmd *cmd)
+		struct io_uring_cmd *cmd, u64 *addr, u16 *len)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)io_uring_sqe_cmd(cmd->sqe);
+	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	void __user *argp = (void __user *)*addr;
 	char *dev_path = NULL;
 	int ret = 0;
 	int mask;
 
 	if (!unprivileged) {
@@ -5059,11 +5057,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	 * header->dev_path_len records length of dev path buffer.
 	 */
 	if (!header->dev_path_len || header->dev_path_len > PATH_MAX)
 		return -EINVAL;
 
-	if (header->len < header->dev_path_len)
+	if (*len < header->dev_path_len)
 		return -EINVAL;
 
 	dev_path = memdup_user_nul(argp, header->dev_path_len);
 	if (IS_ERR(dev_path))
 		return PTR_ERR(dev_path);
@@ -5093,12 +5091,12 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		goto exit;
 	}
 
 	ret = ublk_char_dev_permission(ub, dev_path, mask);
 	if (!ret) {
-		header->len -= header->dev_path_len;
-		header->addr += header->dev_path_len;
+		*len -= header->dev_path_len;
+		*addr += header->dev_path_len;
 	}
 	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
 			__func__, ub->ub_number, cmd->cmd_op,
 			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
 			dev_path, ret);
@@ -5125,36 +5123,40 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	struct ublk_device *ub = NULL;
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
+	u64 addr;
+	u16 len;
 
 	if (ublk_ctrl_uring_cmd_may_sleep(cmd_op) &&
 	    issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
 	if (!(issue_flags & IO_URING_F_SQE128))
 		return -EINVAL;
 
+	addr = READ_ONCE(header->addr);
+	len = READ_ONCE(header->len);
 	ublk_ctrl_cmd_dump(cmd);
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
 	if (cmd_op == UBLK_U_CMD_GET_FEATURES) {
-		ret = ublk_ctrl_get_features(header);
+		ret = ublk_ctrl_get_features(addr, len);
 		goto out;
 	}
 
 	if (_IOC_NR(cmd_op) != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
 		ub = ublk_get_device_from_id(header->dev_id);
 		if (!ub)
 			goto out;
 
-		ret = ublk_ctrl_uring_cmd_permission(ub, cmd);
+		ret = ublk_ctrl_uring_cmd_permission(ub, cmd, &addr, &len);
 		if (ret)
 			goto put_dev;
 	}
 
 	switch (_IOC_NR(cmd_op)) {
@@ -5165,29 +5167,29 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ublk_ctrl_stop_dev(ub);
 		ret = 0;
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
-		ret = ublk_ctrl_get_dev_info(ub, header);
+		ret = ublk_ctrl_get_dev_info(ub, addr, len);
 		break;
 	case UBLK_CMD_ADD_DEV:
-		ret = ublk_ctrl_add_dev(header);
+		ret = ublk_ctrl_add_dev(header, addr, len);
 		break;
 	case UBLK_CMD_DEL_DEV:
 		ret = ublk_ctrl_del_dev(&ub, true);
 		break;
 	case UBLK_CMD_DEL_DEV_ASYNC:
 		ret = ublk_ctrl_del_dev(&ub, false);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
-		ret = ublk_ctrl_get_queue_affinity(ub, header);
+		ret = ublk_ctrl_get_queue_affinity(ub, header, addr, len);
 		break;
 	case UBLK_CMD_GET_PARAMS:
-		ret = ublk_ctrl_get_params(ub, header);
+		ret = ublk_ctrl_get_params(ub, addr, len);
 		break;
 	case UBLK_CMD_SET_PARAMS:
-		ret = ublk_ctrl_set_params(ub, header);
+		ret = ublk_ctrl_set_params(ub, addr, len);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
 		ret = ublk_ctrl_start_recovery(ub, header);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
-- 
2.45.2

