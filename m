Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305793BBFA8
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681133; cv=none; b=EkKLVKFOtawv25zYCJ5n5NldqvQxleW0N6mGELaP4DjAnqeCL07PeNo6oAC2zDz+iCozspRD47OQm5jP9fvuCpsbd8/wvycLIY42uZZ8yBTtCMwd++5K2lhZHTQy9YlK5AYX8jVAxL4TkYlixsv8PnUdwjkCftSbkoeZ8Es7cDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681133; c=relaxed/simple;
	bh=qvhfMmIxud1XmISJfwAsuQyU9oBpc+wFEHZJdjWASWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1s3LL+s3swDMTSqyiAYDCysJ2qBDhMdCMQOOFNQ0nE+iMtMWBO4n3B3eFRgJYtJS74vXEsjpBFuman0lOlaCmrSu/ILdFAB+8qmqyyIp6OhBC2E9J8idPjRGhf2q7vo2rtc+S8hOfku1cJM4XN0NyOPLQG8NlI2r0SQpHliZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXrAYk5n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXrAYk5n"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b613a17bso49239095e9.3
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681131; x=1782285931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFVbsHHpc1qYgupS20qWp5u1QSWkUyJVoPVpXgOVACc=;
        b=QXrAYk5nMbCDb/7QpPl865Bx6X/fOcn2EGleyzFb50n1zqX9hscJtEITaOFnV9AwNl
         hu9onlDkxEXBxcTehA62Sc7LLt2jg4TdKSSBdSL/WYCznZo4uOyoNrHiGnibw+OOw/Kt
         oyT63PNefxIx3fXHCBqEOMuLGn/xSM4Lt9xzHVXPThL/uNIq2ut14nsBoqYK8rAq76JH
         T/PE2vy05QH/Yt35phi7nsVDJc+beFJPaLMM0gycs1E6WjXpVQPmP8tauVT0pzFKnVtm
         dnuaJxIWeNGZYgQ5gQnHw42j7zgIwe6HhVucbYKi24VepZMh1EH8UGltKz2gE2X9slAx
         9SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681131; x=1782285931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QFVbsHHpc1qYgupS20qWp5u1QSWkUyJVoPVpXgOVACc=;
        b=DgH31wszXoS98XZ3oGpBA1f+a6lKpxfwexue060rzikrZx9MaKRt4eoMWjfc7nns40
         +cMgDFNAE+qkA8o/QDBs8XQTvBuiljr2wBHQdos+bnXNkfukEJFafCvijCqZgbpznPSl
         zIyQs4TkUi2GL1oNLDy0MhkLgfmihPorY5rtdSolMWrR3uvLaPeC8TkLfcUAvInqdQu7
         lwU57U0CoPgTpGw6pLOhx2QJrlL0+sXgdfVb2CCsFtjq6TvP2a//b7pJn/FQ7KnUAMOJ
         Mr2e8B01H3apx5KYw+dyJqC2fwShhYJjRINwfV5gZhsD0Ml1uDaW7C2Qvu1efozB750r
         6R0g==
X-Gm-Message-State: AOJu0YwyXIt6seDz8QufwpnZM1/AbT1udPtZjmJ5Ih/ohGbJUKudNiYx
	bNoQLiplY4THOsNSY7O+AsQJlqaOh1mPy+3qyRGAKLfLdDEER3ShJwP+P0qQCg==
X-Gm-Gg: Acq92OEzm3GIDLEkm5nE1JvjXhxO7fvXRZ86hrlMVzuAcXwfZuw3U8W/tvIvH/Uobfy
	vp2d22vX8Ef0LznyQzHu5C3JVEc6r99TnHOb6+CM7QehBMdCL/534PN9PywC+sZYmAmVvUaxxi8
	nnlW3monUhjUehg8nrPEAmNtMFTx6OmlJAiJIdPcIJWhhhYllOQjZtg6fgEdcip8MqKpCC3yvPI
	5QKUvv4e56X7RH4UCplTSsZDs9PHRSte+dkyxfh+39QOt50e42xVCfsRY9el+kWMJFGxD7C99ov
	2bsTApPrz555cqkvMt3vfvay97bJppxT3Z151o8q6dKadQPUeLEEoCDPy4ry2oV1OWApG714oOy
	q/Adzmsqm0X5sZROjxZYWBdFTZbyM3fg82+EAbFr5tDP4KAg6hHqFUaNKvuaX/slBLcONWoahPQ
	VUjTJA6k6A+1f1hqmjfR1ji0yoRAx4IF4FzhW4aIbXwfaw7rI/hsfDwaaGZfrDTl/fJbepGvF+D
	XIAIKIFQmyPZoG2RZ2PIJ68SQ==
X-Received: by 2002:a05:600c:6305:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-492333cfed3mr38175125e9.22.1781681130555;
        Wed, 17 Jun 2026 00:25:30 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-82-184.dynamic.gprs.plus.pl. [78.30.82.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462a9784497sm3009320f8f.34.2026.06.17.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:25:28 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 1/2 blktests] src/miniublk: switch to ioctl-encoded ublk commands
Date: Wed, 17 Jun 2026 09:25:15 +0200
Message-ID: <20260617072516.6238-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260617072516.6238-1-sebastian.chlad@suse.com>
References: <20260617072516.6238-1-sebastian.chlad@suse.com>
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
---
 src/miniublk.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/miniublk.c b/src/miniublk.c
index f98f850..5a35ca7 100644
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
-	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
-		cmd_op = UBLK_IO_FETCH_REQ;
+		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
+	else
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

