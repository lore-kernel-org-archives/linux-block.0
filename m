Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE3274652
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185235; cv=none; b=F5o7aTNmiaQ11HvYExX1s5IGEIrMeJydzZzq3JgY00HLF8o7MQhJuHCTKAXMbsCMrNNCA7BeuYnOjhPBMmnB1oHUNlLpzwojtnPLplV6v3Gytc3+xYIrD1pwQ6MsCsPGoTPBk1wROFWBiAi+WGFy2m1t1o5ZdV/tUPYZF4h5Zpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185235; c=relaxed/simple;
	bh=i6N94zlU2y12u9JlOp9QsfPAr7n0oPPxQmq9aD6WFdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3M4fiL8G5B3Xi19iKbjiHvOUmvmPv9uUov9Qd60H8qa2AUy3CniGMC5pOUllaHDmkxYNBuaQq0yriX61mxSR3Mkg3cXL+RSRH22a6B+R6FxEnrT6cB5RXl+56WYBCVIpjdefwrgDD4lSjspK3Z/DxKd6u3Z+0LQp0FZ05vGxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcd5xttj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcd5xttj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so3304775e9.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782185232; x=1782790032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzdR3o8NjNFisyc6pU+EYg8UCWYaTAz0d/0qRyf0iPU=;
        b=Jcd5xttj04+QGOuTWVQXKZfB1NCeJ2WRQI8Lk6s3koC8m4/8MahOacmfsDRNTH6leZ
         y9yqdU3QHmXmV51xyzDSV20gK2z7nwlpXWdjCLhvJrqP4ka+LJlWNTfECa+cg780n5Zh
         fOi7ZGRDxZ16Lbq4Z7uuzJB1Dcv384NKJQuLC9VA5Sikf5CRFIm4LdYWEXna3PSKJJVk
         JIfWxf22Svl+/YhXQ9Mp+xT8zqIj9wQFoO2z+Amos+1AySjQFtiJ/Ztzue8I87mmN95C
         +aD4eJKEXE2Zz7GUFKkbdhAqirjdcvOKM8dZxa5Hm+wI0LrFIffVGZiQMkM1ju0QAnRd
         ZErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782185232; x=1782790032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzdR3o8NjNFisyc6pU+EYg8UCWYaTAz0d/0qRyf0iPU=;
        b=JNgogceRsK84YSMbDfYBG47tVsBPO5sR/kGzy2HfuzG/fkxnDCrwKgGeg83+KoPNd0
         upEN9SSdW6evHLLgzSNdRNM0eEfjXeMyLxakCPaXQYmhqJUqQiMdNRLUojqRQ1fGhaGu
         MqiKCeUrNraTY/wVr3MbqrAUMRZpuxnQb0o+EoBPqjsDQyCBpVvbs21Tuj3qcs4UzQhT
         mxDH0qMJD42ZP90Iyyu7QioI4LFYKEMosbeNMn47MBtFbJo8PUnkgdccA9gHbF2EzW06
         GY/CGTRRmn/llhzfjCzRwERdKp8LvZFFLtrEJ+SpZCHurKkrt+hYw0YpkwG1LScN3o1V
         Fguw==
X-Gm-Message-State: AOJu0Ywr5AyqEuxJ6/HxBj+oAwWQ5NicWzC5rlCyUp04ujQQO3roDgZ6
	Zh/TYVGp2Ew+sN7dZTryFPyqp6SK61lbyOZip+GNksrg5fPSHU9yMkvkT5g4dg==
X-Gm-Gg: AfdE7cms+a4iWGAvokEQ3ZMbfJx9TcCA8neDMkMHhlDrlaYw08s2cUp02BMQodxUbPH
	rFfYFplfIRv+wURhumiaJ88GgPMN/Y3OSvZaTVuK12cU8O9tB5XgLojl76riTIns4f1YmwRSJbb
	W7xPZGVXZjR8bUGyYCzoLxczeBfpjMdqxu8yFIY7f++uOAg/BtWB3R0Qv8mTbcrT8oSHnI/SjLG
	dDXSN1kNfPQpI0QT4CEUyTXTnjs9APMaWDGLQTDF4pXxcDloDIryHnMvdD2hPdggr1rrinq7xt7
	NXnJWjmuBJGyURgZv4NSVuTt9f6WxS+eRswkGdBCCLPKXVj3YLTIlxdrHEkaSo90OyQWjhdt6Hx
	vCW76KNU2OB3gMisUqMEoh7Pv6Yq+SSN3KQb0TyXvUE9YlzKoxd7oNN4qLo6Qp639YtdbpxjhnT
	Da2sSgBt42iPqbPbN10Gna3q1JaEo3G0DkxxChwnV12Juec1PZre2ArEMLyZfuu+Er9xFQcWhHh
	X4bRhTV+LKg+xT9IdX/B1o=
X-Received: by 2002:a05:600c:5010:b0:492:1e36:9a90 with SMTP id 5b1f17b1804b1-4925a0da5cdmr24080885e9.18.1782185231919;
        Mon, 22 Jun 2026 20:27:11 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-83-17.dynamic.gprs.plus.pl. [78.30.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm577781005e9.0.2026.06.22.20.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 20:27:11 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests v2 1/2] src/miniublk: switch to ioctl-encoded ublk commands
Date: Tue, 23 Jun 2026 05:27:06 +0200
Message-ID: <20260623032707.14439-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernels built without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES reject the
legacy raw UBLK_CMD_* and UBLK_IO_* opcodes. Switch miniublk to use
the ioctl-encoded UBLK_U_CMD_* and UBLK_U_IO_* variants defined in
linux/ublk_cmd.h instead.

For IO commands, the ioctl-encoded opcode is used for submission while
_IOC_NR() extracts the raw NR bits for build_user_data(), keeping the
user_data tag encoding intact.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
Co-authored-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
changes in v2:
1. Makefile as prepared by Shin'ichiro Kawasaki
2. restored else if to check if (io->flags & UBLKSRV_NEED_FETCH_RQ)

 src/Makefile   |  9 +++++++++
 src/miniublk.c | 28 ++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index d8833bf..adfe3ef 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -8,6 +8,10 @@ HAVE_C_MACRO = $(shell if echo "$(H)include <$(1)>" |	\
 		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
+HAVE_C_DEF = $(shell if echo -e "$(H)include <$(1)>\n#ifdef $(2)\nHAVE_$(2)\n#endif" | \
+		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep HAVE_$(2) > /dev/null 2>&1; \
+		then echo 1;else echo 0; fi)
+
 C_TARGETS := \
 	dio-offsets \
 	loblksize \
@@ -27,6 +31,7 @@ C_UBLK_TARGETS := miniublk
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
+HAVE_NEW_UBLK_INTF := $(call HAVE_C_DEF,linux/ublk_cmd.h,UBLK_U_CMD_START_DEV)
 
 CXX_TARGETS := \
 	discontiguous-io
@@ -37,8 +42,12 @@ SYZKALLER_TARGETS := \
 TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
 
 ifeq ($(HAVE_UBLK_HEADER), 1)
+ifeq ($(HAVE_NEW_UBLK_INTF), 1)
 C_URING_TARGETS += $(C_UBLK_TARGETS)
 else
+$(info Skip $(C_UBLK_TARGETS) build due to missing new ublk interface(v6.4+))
+endif
+else
 $(info Skip $(C_UBLK_TARGETS) build due to missing kernel header(v6.0+))
 endif
 
diff --git a/src/miniublk.c b/src/miniublk.c
index f98f850..628207a 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -294,7 +294,7 @@ static int __ublk_ctrl_cmd(struct ublk_dev *dev,
 int ublk_ctrl_stop_dev(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_STOP_DEV,
+		.cmd_op	= UBLK_U_CMD_STOP_DEV,
 	};
 
 	return __ublk_ctrl_cmd(dev, &data);
@@ -304,7 +304,7 @@ int ublk_ctrl_start_dev(struct ublk_dev *dev,
 		int daemon_pid)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_START_DEV,
+		.cmd_op	= UBLK_U_CMD_START_DEV,
 		.flags	= CTRL_CMD_HAS_DATA,
 	};
 
@@ -316,7 +316,7 @@ int ublk_ctrl_start_dev(struct ublk_dev *dev,
 int ublk_ctrl_add_dev(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_ADD_DEV,
+		.cmd_op	= UBLK_U_CMD_ADD_DEV,
 		.flags	= CTRL_CMD_HAS_BUF,
 		.addr = (__u64)&dev->dev_info,
 		.len = sizeof(struct ublksrv_ctrl_dev_info),
@@ -328,7 +328,7 @@ int ublk_ctrl_add_dev(struct ublk_dev *dev)
 int ublk_ctrl_del_dev(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op = UBLK_CMD_DEL_DEV,
+		.cmd_op = UBLK_U_CMD_DEL_DEV,
 		.flags = 0,
 	};
 
@@ -338,7 +338,7 @@ int ublk_ctrl_del_dev(struct ublk_dev *dev)
 int ublk_ctrl_get_info(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_GET_DEV_INFO,
+		.cmd_op	= UBLK_U_CMD_GET_DEV_INFO,
 		.flags	= CTRL_CMD_HAS_BUF,
 		.addr = (__u64)&dev->dev_info,
 		.len = sizeof(struct ublksrv_ctrl_dev_info),
@@ -351,7 +351,7 @@ int ublk_ctrl_set_params(struct ublk_dev *dev,
 		struct ublk_params *params)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_SET_PARAMS,
+		.cmd_op	= UBLK_U_CMD_SET_PARAMS,
 		.flags	= CTRL_CMD_HAS_BUF,
 		.addr = (__u64)params,
 		.len = sizeof(*params),
@@ -364,7 +364,7 @@ static int ublk_ctrl_get_params(struct ublk_dev *dev,
 		struct ublk_params *params)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_GET_PARAMS,
+		.cmd_op	= UBLK_U_CMD_GET_PARAMS,
 		.flags	= CTRL_CMD_HAS_BUF,
 		.addr = (__u64)params,
 		.len = sizeof(*params),
@@ -378,7 +378,7 @@ static int ublk_ctrl_get_params(struct ublk_dev *dev,
 static int ublk_ctrl_start_user_recover(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_START_USER_RECOVERY,
+		.cmd_op	= UBLK_U_CMD_START_USER_RECOVERY,
 		.flags	= 0,
 	};
 
@@ -389,7 +389,7 @@ static int ublk_ctrl_end_user_recover(struct ublk_dev *dev,
 		int daemon_pid)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_END_USER_RECOVERY,
+		.cmd_op	= UBLK_U_CMD_END_USER_RECOVERY,
 		.flags	= CTRL_CMD_HAS_DATA,
 	};
 
@@ -624,9 +624,9 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
 		return 0;
 
 	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
-		cmd_op = UBLK_IO_COMMIT_AND_FETCH_REQ;
+		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
 	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
-		cmd_op = UBLK_IO_FETCH_REQ;
+		cmd_op = UBLK_U_IO_FETCH_REQ;
 
 	sqe = io_uring_get_sqe(&q->ring);
 	if (!sqe) {
@@ -637,7 +637,7 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
 
 	cmd = (struct ublksrv_io_cmd *)ublk_get_sqe_cmd(sqe);
 
-	if (cmd_op == UBLK_IO_COMMIT_AND_FETCH_REQ)
+	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
 		cmd->result = io->result;
 
 	/* These fields should be written once, never change */
@@ -650,7 +650,7 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
 	cmd->addr	= (__u64)io->buf_addr;
 	cmd->q_id	= q->q_id;
 
-	user_data = build_user_data(tag, cmd_op, 0, 0);
+	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
 	io_uring_sqe_set_data64(sqe, user_data);
 
 	io->flags = 0;
@@ -658,7 +658,7 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
 	q->cmd_inflight += 1;
 
 	ublk_dbg(UBLK_DBG_IO_CMD, "%s: (qid %d tag %u cmd_op %u) iof %x stopping %d\n",
-			__func__, q->q_id, tag, cmd_op,
+			__func__, q->q_id, tag, _IOC_NR(cmd_op),
 			io->flags, !!(q->state & UBLKSRV_QUEUE_STOPPING));
 	return 1;
 }
-- 
2.51.0

