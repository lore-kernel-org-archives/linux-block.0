Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451703630AC
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700603; cv=none; b=kD58bpskOocNKoa321IIktBvvV6Ww8/GI5eBNIhsP4giRcLVITadpP95VtZFJoogRXgIEeI8PDK28Ysn0CZRKKa22KiVONf8EeBuOBwwuA0OWuda50RKQGBoIlPs4vzgyFtKTDN/b6iTKWs1vbgsd429jayJ7Iy1gkGdyWuSsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700603; c=relaxed/simple;
	bh=v3qfm6wklJ5sYDyK9S5DVrUEAXOJSlLaBvPqwOkqw8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPv0DeSTDa2medLITvB/EXN3HwKZbArqI3D5G046afQU1Mv/E7vD+UkxTlx0jHOhecHeyrEms0c5Kp++ReuTnzbAqPi/T2dfd/PfMsa1nYkmzkj6wGrZAt58awtSZrfyisZBK26gOBXDlFqF8b5m09pu2gOejPZFlvdHZVi7Gf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPfBGgcm; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPfBGgcm"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8241a56cd70so711388a34.3
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700600; x=1792305400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JzVDiQ4vdqH2cufVW1Y1Q62RqmOwAfXu8K2JkT+aQDc=;
        b=rPfBGgcmeFbN6yJq5Cq4Lxxo+PShNqDJDhov5uXyPVQ4VOjz4dookQoCy29jiIpWQf
         g831Xv5KQiZ7R+et2PF2Pmjwiux7jvuoboZvX9yOCaeN6i+znWhjx7nGurSCovVsHM+z
         4oFCEok0x9WCJjqG1CeAjYTXIh1+JH7My7B0rNhv43Wz2Jn/cZP30z0fx9ZlVSA2BDL/
         RBKFAgHmwZotkNTllguinx8ScrY9fuxzQPwuqpEgQzwm9a148QqNo629Bcs837yhSYGk
         pqTdgA7M1bNoVDmWRLzyYgCRHL2Ev02gIk6+SHyob/GCApembLod0coM9tb2dnhdQhQR
         KG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700600; x=1792305400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JzVDiQ4vdqH2cufVW1Y1Q62RqmOwAfXu8K2JkT+aQDc=;
        b=iuw/hLQ93A+yxvo+xN6pO4YXvRHHaLruynEwGk8/FPN231Y47Y+7P/DGAIfoSEwelX
         8XvTQd7U0Fr7Z5oxHR8jMqValQhMCwQG824mkAAltE5m4NnUHnr+I284oPrg0yTbpM7C
         +LVjgHkFvFq74LMCztKVcknELLdOvosqlkeJF5PlfojaJAMH7Ps2z4RluZwLKHNitLmj
         ZbhhloISYTfOfUGfZUAMo3B5ZKJOh0cr2x8nkgSYU84ZwuVAV8EJnEIvJKnfDgmGE3QQ
         nP5aFj4vB6x+Gb5QfgFI9QumsoO6w5kRhBe83czfluC/DLzKP/h482q8HKwafA1mMMdT
         qwQQ==
X-Gm-Message-State: AFq9FYL67SyBdIP4wTkAbAns5cd9RUK70dLN8QF/bwC7nYqfbhzfDpGT
	u9OziwFUilExPVRBNgViT3kgVYHuE80fSwCXy3X192WnqLLA7AC2qI7lh5ZoXaht
X-Gm-Gg: AYBFou3uQprHSETjb4LIHOPp8HvvunXRjOnBabYqPnAHqXNACFJ44SiGwhmxmgII3Cu
	DrZw/29ZBSQwXxYlPtYmGuE0gyYRyQHZuDn6rVisVuSz+syiYTYQ4vzgyOuVwxlPJkty/ZzxV5z
	rhkbl1ifGCXPpgEPOmfClj1HoFcHxx+WpYO/YY9rpwx0zxLTOnuiwEECmh3KQZigSMZlqEn7pIw
	rjVs+Wo9rK95KXeuku5Wwdk0LLxaO53M0CsK4Hyaf9y8GtssdqiGIWDpVlR6UaawHinaJqqjU6M
	kSTEbrZowRendK7eew1g04tsgXdOveKK/DWGYbmUMI5FYAumdHkZI0xpkXO9EHrt2LU5sHTcBN7
	B4Uw3swDT+XCVoUHLjmHGpBRCN5rFVreW1uGAQ4jWmF4xg3eOHxhMaEUMduqAeTH07tqf/ZTgWq
	FjX2qUpCFl8IjL1rxg7/BDgsQib8BtZKk65j5yCcCVyg5v9GLJQwKMepOAkWVgNKY/0FgtPf9hs
	tDaOYcVXyARRYxX4TCj4A3t9PCJfpncca67J2K4Z44ZD4h5kA/d97+hCkpFD/HtST5yUXfiXUuZ
	nut0PxcSvXaRsa+CCE/NIpI/caxZFXS/I2/8TQ==
X-Received: by 2002:a05:6820:6ae3:b0:6c1:6bdc:466c with SMTP id 006d021491bc7-6ef0d333ad3mr4355409eaf.20.1791700600092;
        Sat, 10 Oct 2026 23:36:40 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:39 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 09/12] selftests: ublk: move the control command helpers into ctrl.c
Date: Sun, 11 Oct 2026 01:35:52 -0500
Message-ID: <20261011063555.1142277-10-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the ublk_ctrl_*() helpers and ublk_setup_ring() out of kublk.c,
so a small test program can send control commands without copying
them. kublk still links every *.c file, ctrl.c included.

ublk_ctrl_deinit() now also exits the control ring, and ublk_ctrl_init()
checks the allocation and closes /dev/ublk-control when the ring setup
fails. kublk calls them only around its own lifetime, but a test which
opens a control handle per thread must not leak.

No functional change for kublk.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/ctrl.c  | 268 ++++++++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.c | 271 ---------------------------
 tools/testing/selftests/ublk/kublk.h |  32 ++++
 3 files changed, 300 insertions(+), 271 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/ctrl.c

diff --git a/tools/testing/selftests/ublk/ctrl.c b/tools/testing/selftests/ublk/ctrl.c
new file mode 100644
index 000000000000..53d54799f909
--- /dev/null
+++ b/tools/testing/selftests/ublk/ctrl.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* ublk control commands, shared by kublk and ublk_cancel_ready */
+
+#include "kublk.h"
+
+static void ublk_ctrl_init_cmd(struct ublk_dev *dev,
+		struct io_uring_sqe *sqe,
+		struct ublk_ctrl_cmd_data *data)
+{
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	struct ublksrv_ctrl_cmd *cmd = (struct ublksrv_ctrl_cmd *)ublk_get_sqe_cmd(sqe);
+
+	sqe->fd = dev->ctrl_fd;
+	sqe->opcode = IORING_OP_URING_CMD;
+	sqe->ioprio = 0;
+
+	if (data->flags & CTRL_CMD_HAS_BUF) {
+		cmd->addr = data->addr;
+		cmd->len = data->len;
+	}
+
+	if (data->flags & CTRL_CMD_HAS_DATA)
+		cmd->data[0] = data->data[0];
+
+	cmd->dev_id = info->dev_id;
+	cmd->queue_id = -1;
+
+	ublk_set_sqe_cmd_op(sqe, data->cmd_op);
+
+	io_uring_sqe_set_data(sqe, cmd);
+}
+
+int __ublk_ctrl_cmd(struct ublk_dev *dev,
+		struct ublk_ctrl_cmd_data *data)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int ret = -EINVAL;
+
+	sqe = io_uring_get_sqe(&dev->ring);
+	if (!sqe) {
+		ublk_err("%s: can't get sqe ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	ublk_ctrl_init_cmd(dev, sqe, data);
+
+	ret = io_uring_submit(&dev->ring);
+	if (ret < 0) {
+		ublk_err("uring submit ret %d\n", ret);
+		return ret;
+	}
+
+	ret = io_uring_wait_cqe(&dev->ring, &cqe);
+	if (ret < 0) {
+		ublk_err("wait cqe: %s\n", strerror(-ret));
+		return ret;
+	}
+	io_uring_cqe_seen(&dev->ring, cqe);
+
+	return cqe->res;
+}
+
+void ublk_ctrl_deinit(struct ublk_dev *dev)
+{
+	io_uring_queue_exit(&dev->ring);
+	close(dev->ctrl_fd);
+	free(dev);
+}
+
+struct ublk_dev *ublk_ctrl_init(void)
+{
+	struct ublk_dev *dev = (struct ublk_dev *)calloc(1, sizeof(*dev));
+	struct ublksrv_ctrl_dev_info *info;
+	int ret;
+
+	if (!dev)
+		return NULL;
+	info = &dev->dev_info;
+	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
+	if (dev->ctrl_fd < 0) {
+		free(dev);
+		return NULL;
+	}
+
+	info->max_io_buf_bytes = UBLK_IO_MAX_BYTES;
+
+	ret = ublk_setup_ring(&dev->ring, UBLK_CTRL_RING_DEPTH,
+			UBLK_CTRL_RING_DEPTH, IORING_SETUP_SQE128);
+	if (ret < 0) {
+		ublk_err("queue_init: %s\n", strerror(-ret));
+		close(dev->ctrl_fd);
+		free(dev);
+		return NULL;
+	}
+	dev->nr_fds = 1;
+
+	return dev;
+}
+
+int ublk_ctrl_stop_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_STOP_DEV,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_try_stop_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_TRY_STOP_DEV,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_start_dev(struct ublk_dev *dev,
+		int daemon_pid)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_START_DEV,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_start_user_recovery(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_START_USER_RECOVERY,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_end_user_recovery(struct ublk_dev *dev, int daemon_pid)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_END_USER_RECOVERY,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_add_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_ADD_DEV,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) &dev->dev_info,
+		.len = sizeof(struct ublksrv_ctrl_dev_info),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_del_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op = UBLK_U_CMD_DEL_DEV,
+		.flags = 0,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_get_info(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_GET_DEV_INFO,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) &dev->dev_info,
+		.len = sizeof(struct ublksrv_ctrl_dev_info),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_set_params(struct ublk_dev *dev,
+		struct ublk_params *params)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_SET_PARAMS,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) params,
+		.len = sizeof(*params),
+	};
+	params->len = sizeof(*params);
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_get_params(struct ublk_dev *dev,
+		struct ublk_params *params)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_GET_PARAMS,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64)params,
+		.len = sizeof(*params),
+	};
+
+	params->len = sizeof(*params);
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_get_features(struct ublk_dev *dev,
+		__u64 *features)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_GET_FEATURES,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) features,
+		.len = sizeof(*features),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_update_size(struct ublk_dev *dev,
+		__u64 nr_sects)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_UPDATE_SIZE,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	data.data[0] = nr_sects;
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_quiesce_dev(struct ublk_dev *dev, unsigned int timeout_ms)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_QUIESCE_DEV,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	data.data[0] = timeout_ms;
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_reg_buf(struct ublk_dev *dev, void *addr, size_t size,
+		      __u32 flags)
+{
+	struct ublk_shmem_buf_reg buf_reg = {
+		.addr = (unsigned long)addr,
+		.len = size,
+		.flags = flags,
+	};
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op = UBLK_U_CMD_REG_BUF,
+		.flags = CTRL_CMD_HAS_BUF,
+		.addr = (unsigned long)&buf_reg,
+		.len = sizeof(buf_reg),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2400b4615766..15ba060ce7a3 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -37,203 +37,6 @@ static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
 	return NULL;
 }
 
-static inline int ublk_setup_ring(struct io_uring *r, int depth,
-		int cq_depth, unsigned flags)
-{
-	struct io_uring_params p;
-
-	memset(&p, 0, sizeof(p));
-	p.flags = flags | IORING_SETUP_CQSIZE;
-	p.cq_entries = cq_depth;
-
-	return io_uring_queue_init_params(depth, r, &p);
-}
-
-static void ublk_ctrl_init_cmd(struct ublk_dev *dev,
-		struct io_uring_sqe *sqe,
-		struct ublk_ctrl_cmd_data *data)
-{
-	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
-	struct ublksrv_ctrl_cmd *cmd = (struct ublksrv_ctrl_cmd *)ublk_get_sqe_cmd(sqe);
-
-	sqe->fd = dev->ctrl_fd;
-	sqe->opcode = IORING_OP_URING_CMD;
-	sqe->ioprio = 0;
-
-	if (data->flags & CTRL_CMD_HAS_BUF) {
-		cmd->addr = data->addr;
-		cmd->len = data->len;
-	}
-
-	if (data->flags & CTRL_CMD_HAS_DATA)
-		cmd->data[0] = data->data[0];
-
-	cmd->dev_id = info->dev_id;
-	cmd->queue_id = -1;
-
-	ublk_set_sqe_cmd_op(sqe, data->cmd_op);
-
-	io_uring_sqe_set_data(sqe, cmd);
-}
-
-static int __ublk_ctrl_cmd(struct ublk_dev *dev,
-		struct ublk_ctrl_cmd_data *data)
-{
-	struct io_uring_sqe *sqe;
-	struct io_uring_cqe *cqe;
-	int ret = -EINVAL;
-
-	sqe = io_uring_get_sqe(&dev->ring);
-	if (!sqe) {
-		ublk_err("%s: can't get sqe ret %d\n", __func__, ret);
-		return ret;
-	}
-
-	ublk_ctrl_init_cmd(dev, sqe, data);
-
-	ret = io_uring_submit(&dev->ring);
-	if (ret < 0) {
-		ublk_err("uring submit ret %d\n", ret);
-		return ret;
-	}
-
-	ret = io_uring_wait_cqe(&dev->ring, &cqe);
-	if (ret < 0) {
-		ublk_err("wait cqe: %s\n", strerror(-ret));
-		return ret;
-	}
-	io_uring_cqe_seen(&dev->ring, cqe);
-
-	return cqe->res;
-}
-
-static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_STOP_DEV,
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_try_stop_dev(struct ublk_dev *dev)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_TRY_STOP_DEV,
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_start_dev(struct ublk_dev *dev,
-		int daemon_pid)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_START_DEV,
-		.flags	= CTRL_CMD_HAS_DATA,
-	};
-
-	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_start_user_recovery(struct ublk_dev *dev)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_START_USER_RECOVERY,
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_end_user_recovery(struct ublk_dev *dev, int daemon_pid)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_END_USER_RECOVERY,
-		.flags	= CTRL_CMD_HAS_DATA,
-	};
-
-	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_add_dev(struct ublk_dev *dev)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_ADD_DEV,
-		.flags	= CTRL_CMD_HAS_BUF,
-		.addr = (__u64) (uintptr_t) &dev->dev_info,
-		.len = sizeof(struct ublksrv_ctrl_dev_info),
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_del_dev(struct ublk_dev *dev)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op = UBLK_U_CMD_DEL_DEV,
-		.flags = 0,
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_get_info(struct ublk_dev *dev)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_GET_DEV_INFO,
-		.flags	= CTRL_CMD_HAS_BUF,
-		.addr = (__u64) (uintptr_t) &dev->dev_info,
-		.len = sizeof(struct ublksrv_ctrl_dev_info),
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_set_params(struct ublk_dev *dev,
-		struct ublk_params *params)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_SET_PARAMS,
-		.flags	= CTRL_CMD_HAS_BUF,
-		.addr = (__u64) (uintptr_t) params,
-		.len = sizeof(*params),
-	};
-	params->len = sizeof(*params);
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_get_params(struct ublk_dev *dev,
-		struct ublk_params *params)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_GET_PARAMS,
-		.flags	= CTRL_CMD_HAS_BUF,
-		.addr = (__u64)params,
-		.len = sizeof(*params),
-	};
-
-	params->len = sizeof(*params);
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_get_features(struct ublk_dev *dev,
-		__u64 *features)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_GET_FEATURES,
-		.flags	= CTRL_CMD_HAS_BUF,
-		.addr = (__u64) (uintptr_t) features,
-		.len = sizeof(*features),
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
 static int parse_param_types(const char *arg, __u32 *types)
 {
 	char buf[128], *save = NULL, *tok;
@@ -283,30 +86,6 @@ static void ublk_init_params_from_ctx(const struct dev_ctx *ctx,
 	};
 }
 
-static int ublk_ctrl_update_size(struct ublk_dev *dev,
-		__u64 nr_sects)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_UPDATE_SIZE,
-		.flags	= CTRL_CMD_HAS_DATA,
-	};
-
-	data.data[0] = nr_sects;
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
-static int ublk_ctrl_quiesce_dev(struct ublk_dev *dev,
-				 unsigned int timeout_ms)
-{
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_U_CMD_QUIESCE_DEV,
-		.flags	= CTRL_CMD_HAS_DATA,
-	};
-
-	data.data[0] = timeout_ms;
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
 static const char *ublk_dev_state_desc(struct ublk_dev *dev)
 {
 	switch (dev->dev_info.state) {
@@ -426,38 +205,6 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 	fflush(stdout);
 }
 
-static void ublk_ctrl_deinit(struct ublk_dev *dev)
-{
-	close(dev->ctrl_fd);
-	free(dev);
-}
-
-static struct ublk_dev *ublk_ctrl_init(void)
-{
-	struct ublk_dev *dev = (struct ublk_dev *)calloc(1, sizeof(*dev));
-	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
-	int ret;
-
-	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
-	if (dev->ctrl_fd < 0) {
-		free(dev);
-		return NULL;
-	}
-
-	info->max_io_buf_bytes = UBLK_IO_MAX_BYTES;
-
-	ret = ublk_setup_ring(&dev->ring, UBLK_CTRL_RING_DEPTH,
-			UBLK_CTRL_RING_DEPTH, IORING_SETUP_SQE128);
-	if (ret < 0) {
-		ublk_err("queue_init: %s\n", strerror(-ret));
-		free(dev);
-		return NULL;
-	}
-	dev->nr_fds = 1;
-
-	return dev;
-}
-
 static size_t __ublk_queue_cmd_buf_sz(const struct ublk_queue *q, __u16 depth)
 {
 	size_t size = depth * (size_t)q->io_desc_size;
@@ -1283,24 +1030,6 @@ static void ublk_shmem_unregister_all(void)
 	shmem_count = 0;
 }
 
-static int ublk_ctrl_reg_buf(struct ublk_dev *dev, void *addr, size_t size,
-			     __u32 flags)
-{
-	struct ublk_shmem_buf_reg buf_reg = {
-		.addr = (unsigned long)addr,
-		.len = size,
-		.flags = flags,
-	};
-	struct ublk_ctrl_cmd_data data = {
-		.cmd_op = UBLK_U_CMD_REG_BUF,
-		.flags = CTRL_CMD_HAS_BUF,
-		.addr = (unsigned long)&buf_reg,
-		.len = sizeof(buf_reg),
-	};
-
-	return __ublk_ctrl_cmd(dev, &data);
-}
-
 /*
  * Handle one client connection: receive memfd, mmap it, register
  * the VA range with kernel, send back the assigned index.
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d98f3d612d88..99b8ceff853c 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -294,6 +294,38 @@ struct ublk_dev {
 
 extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 
+static inline int ublk_setup_ring(struct io_uring *r, int depth,
+		int cq_depth, unsigned int flags)
+{
+	struct io_uring_params p;
+
+	memset(&p, 0, sizeof(p));
+	p.flags = flags | IORING_SETUP_CQSIZE;
+	p.cq_entries = cq_depth;
+
+	return io_uring_queue_init_params(depth, r, &p);
+}
+
+/* ctrl.c: control commands */
+struct ublk_dev *ublk_ctrl_init(void);
+void ublk_ctrl_deinit(struct ublk_dev *dev);
+int __ublk_ctrl_cmd(struct ublk_dev *dev, struct ublk_ctrl_cmd_data *data);
+int ublk_ctrl_add_dev(struct ublk_dev *dev);
+int ublk_ctrl_del_dev(struct ublk_dev *dev);
+int ublk_ctrl_get_info(struct ublk_dev *dev);
+int ublk_ctrl_set_params(struct ublk_dev *dev, struct ublk_params *params);
+int ublk_ctrl_get_params(struct ublk_dev *dev, struct ublk_params *params);
+int ublk_ctrl_get_features(struct ublk_dev *dev, __u64 *features);
+int ublk_ctrl_start_dev(struct ublk_dev *dev, int daemon_pid);
+int ublk_ctrl_stop_dev(struct ublk_dev *dev);
+int ublk_ctrl_try_stop_dev(struct ublk_dev *dev);
+int ublk_ctrl_start_user_recovery(struct ublk_dev *dev);
+int ublk_ctrl_end_user_recovery(struct ublk_dev *dev, int daemon_pid);
+int ublk_ctrl_update_size(struct ublk_dev *dev, __u64 nr_sects);
+int ublk_ctrl_quiesce_dev(struct ublk_dev *dev, unsigned int timeout_ms);
+int ublk_ctrl_reg_buf(struct ublk_dev *dev, void *addr, size_t size,
+		      __u32 flags);
+
 static inline int __ublk_use_batch_io(__u64 flags)
 {
 	return flags & UBLK_F_BATCH_IO;
-- 
2.55.0

