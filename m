Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627893A5E9F
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859299; cv=none; b=HftGKMDwifqtanAg3g8zaO39hHRgAjzMMcfyNCyyBiNvM3Dtxy73QQlSX9fjRAjp2P8S7bfwk2KVlLcF98E5W5MKWhdiO20fLkFSB00gL2U6MWjUshtJakl5VAhfTKsgZdRQaup2El/4GN71WFAvQwRT00Zv6fA/JhSM660O1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859299; c=relaxed/simple;
	bh=v3qfm6wklJ5sYDyK9S5DVrUEAXOJSlLaBvPqwOkqw8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5clUfO19N/BntB79ZRPs+whcBWWRHLdrORXbD4St4aFrhk5iNSvn/Nxi0fq8UEMKf2FkDP7Pz4RWwm0DmGBabO0623SxLcdnEmiNkU/16jb2JaDF8GSl9UfjhDOQoIW5rneY8Aw6K7Fdd6CcznkAjHM8eXxbo/wuHcQHcidCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNvPyAec; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNvPyAec"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6def0527340so12038eaf.0
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859296; x=1791464096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JzVDiQ4vdqH2cufVW1Y1Q62RqmOwAfXu8K2JkT+aQDc=;
        b=XNvPyAecAgtHZ74WWBnscd3DeULoMB4dks5Y2v+dURKGmh3Ba7HLMNiJMR4SbDHIln
         7AyeDAOxBA3osOKjqBbfhljmnwVeko4cpvQyaKwbT00aq37U8vZLGnfRAoFW/4JfMoPA
         ctJqmioktppS1JwAixFJMmWgzyYYdAy0T/+dCdQDcAas+ZbwHINJiXKK5mEKNmYMN+z0
         zb+A0atlInQAb/yGDFUlYe92flUHNYSI92hnYJG/WjDhIA8piXMGaZQZcIy+vhV/1Nqs
         3LGsWAqEXs2MZgw4TytKkCUaAMrRtQSY1T7DRs7seQTFknfn82/u3UQbfJRY1wTpqtvz
         Fhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859296; x=1791464096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JzVDiQ4vdqH2cufVW1Y1Q62RqmOwAfXu8K2JkT+aQDc=;
        b=Zn449AG9Wyq0/QnHeJV4LMJ0RuAZm/55h3WrxXR9ePRytb0t9Q4UTHC91ecRH1k/xp
         hYazYzyEDpoV1I/q58JmhFJYb3JJ4E2PnCkvZOowQfyLpqH0YqMZMN8557w3U86RJSvz
         bPOJEJZY+b4qltdxSsqUNXR765UVRuCaPGYbXi/WnP6+Wm+105HvOyRgLcYbUPQEEvC2
         HmNBFPTTC/v2H2d8BMIU9PRdCkD84P1O8/c1/+jhH+IhY1sFMRftRqlzDBkOBQd1pkLP
         AAwqluih9y5SkRdMeVg+YWquUjLbF9WE4FqGJDwlKGgBP69dNA3zi04Dga2ebVe7IvqP
         5QEQ==
X-Gm-Message-State: AFuF++kTBZS9UmszsrGFc3pf0BFbrDGfi60Rj8q/6Kj6oJcgS2QfT6QK
	It+rPGbycXXQi8pnvMdbxF/TVUUNYFhHkBat/UsaVoAwh4DZEFbd5mjVI8HWhg==
X-Gm-Gg: AYBFou38GJsz4VWWHKZTJ8cDo3OT5+fRJqbB92Vj0a3M/Zzw21SNlmhHOSVrjHPT8D8
	PTHSTE5wBEg/eRBeKMGnC65vgi6UCceDJDl7QF3nFe9VJ9eoG50XQzkAshcl2wFcsCFPZbaEwnC
	Jd+bd6VPC2UUrrA9wc6k8V7M/Tyi+j/MfnV8nEC3yAC8DoDrU7Rbj6kI4g1ygNclVF//0YSg/8b
	fQw+iiddTjmp4U9Kms4bY2Gz/xDuRwBUt061OZXtuRmtW96qtltGj2vyqlipzXBTsS1EiywUZ3e
	fiioDRzGvGT0r1O16qNm2QOT5c+ZvYK5wshZxxSKmVaGTuvKwCs8KhRmSNUDZL8RXFMpkzIw8Dy
	DGfopwzpP5oD2zD+gLZFExncni1wBj5AasivltPq5F8QWeTrA6ublp03EDzPIsoBW5VjvkBgrF4
	Hflrta5CRINDAYyQ8DfdyMVkdNrRmkJ7mF0b2cudyMwH2U05LUiX4AXjHIhapTJW0ndLPEa3YnG
	TziW1ecSQHxIP6BNkvlSBSwr2eR/JjFWP477YMX4K3GMK+AJzvTG21zydZG1jVKEFkiCBh3tJIT
	mJ1hPOfpd6zjassg0pPN1U/USps=
X-Received: by 2002:a05:6820:4df3:b0:6ca:4a52:798d with SMTP id 006d021491bc7-6dcf425e567mr4869368eaf.28.1790859296099;
        Thu, 01 Oct 2026 05:54:56 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:55 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 7/8] selftests: ublk: move the control command helpers into ctrl.c
Date: Thu,  1 Oct 2026 07:54:21 -0500
Message-ID: <20261001125422.1364260-8-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
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

