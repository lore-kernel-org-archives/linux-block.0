Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F093BB69A
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681136; cv=none; b=MTkKEx+WjFqq3ugc2wVYNofChnPZomgDCinqntW97dpZWfYe47SGg9YIZHOJR6LkQFLPJGopA3XN7sVPp5IXW/vfbXuG9l5RkdSYsI7iYYDgbWVCb0rhjhPppYKwOa3oKnhWdL/amdA4OM00pKtEUJB3ac1ilL5j3qVqZ+3dDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681136; c=relaxed/simple;
	bh=ZN5JhPhALTTXHtgEujfM1bUdg6VzV56bmdyKweNGP+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtNT58QJpoBzWl+addwr/RaZsPCFCMqUkl8nHfGVHfpt3YSk42tXzE1ADkZl6zEvwPUvrUb4QXtSaTcZUsu5CJyq3NwhUp7nCSkJMyNUIszsJCYpy8VKiK5mA99tzuWj+ERy98ejepf6vY6YL/QoPv1qmp/KR863+XX4wBff15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJXL/sRN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJXL/sRN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so4587426f8f.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681133; x=1782285933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCKCdT6tu1tMpe1z0COn+Geki4JVIuO3ObowJPe/v8M=;
        b=jJXL/sRNIcK/Q+ds110G0jkOhG3JveU6A+9apiDkqgcBLXtjnJOyIW70PmQ0wQbkv9
         NtlXUI0dPSsYhxHhgbN/LVKSXhVqt4vnkH5VmhoSwDHMQ+PUCj/cCclILoznNT7U8YkY
         VjPw6PG+9JRzNZ/eG8fwBoDZ4QHRwazS1i4Bhsc0zdLCi4LlwvlA1H7RZ7ybP192+ieK
         ykLab+R6T5dcO+rrobs4b+miY5M2psaN9ZmULg71qxDlL9NvPr7fKChWAj6MuVCnuvMf
         YcUbuIp+re4+PRBr6mxBkTzL60mVJQpiDUa1hmdrNA4OM0y+cc+0M8bYUEQFpb7Akpxl
         9vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681133; x=1782285933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCKCdT6tu1tMpe1z0COn+Geki4JVIuO3ObowJPe/v8M=;
        b=dXDDD4nYVwcslCGVSjdLFBmabG7YUxQ441O1WMycOc/r9LH4CnqYsjmHXCLV1fDY35
         Sc66gQEePVT4dbo349NAAJRUP7csFRYYGm/6cJCsfWdSz4kOTSwegZR7Z+45IxqJHW86
         rgzpOaZG1xCEZkhDwBeMhNeX9F/KBaqCUinE4PCGpNW7zEXFAB4f93k8UwDImTa840Hi
         SAq33ehKiy/KoErSvKy9moFmYmjvQAJr/4aem9JK6ftzk49ZdTMu970D7Hx6j/Uw6XxP
         iIGPqeGhghqQU5uIe31HX8DRqR2or+8Cc04ClruIVegB4KaoplCChQCZw3nSIW+raIto
         wF8Q==
X-Gm-Message-State: AOJu0YyHWnm8U3QDMzMkrs0cMloGeRswsNM0JnKkZ19YmlINzOWxSoRv
	aZu1cmatUt98TdOzevvhPQQ5pVNVtHuPx+22weSbD8QOvNpDAvprCwAjf6Gy5g==
X-Gm-Gg: AfdE7cntKs24aYUT8gS9qUOo0ymjyLuiF8UB0Zj4Itr/eH5NJg/Wj435QWBpyVYf/yg
	H5romEJGOzJqrIT2n/0yDFP9JsDOb0rgPTdmQ7ymM+bUpbvamkBoWowdo9zvVkQr2EXUxTZIeZu
	HKRz0YPqHB+SvFR0+NC28n1+uDuL0uebSxZpkSreePCot94lDltTTX+Kjg9tnYlaIMdztVFzBIf
	tNj0b0vD/AU3evoDWPqHRcpa5CbqJWkPpPwiOyxinaBTMB0urZPnDtxtYIlTCIAJsJ2XIF+4O5K
	hgL3QWBhsN/gx996clpFmT0wqi38kL/AGZj+45KgrdbpsGkc1Bg4Nqg7NedHm4If9Zy0vDkHsKL
	+a52+OYY/Rwh+j27rFaUk7+9CYumn/stVnqTImpWJp/qtuCsbMHRPtfqOPpKE+fms7nK6WYOyqO
	0X7VP/ZU42TRZWKc/j4AccROZe2sCGF8BpANq4dTytSF7NHf6+iDCIbGNPn+MQLlQQok31vy2sn
	MJ5KEtrwBD0zTw/ucglH6MX4QHrGlJFFMrz
X-Received: by 2002:a5d:62c5:0:b0:460:3210:4348 with SMTP id ffacd0b85a97d-46238132e35mr3102515f8f.41.1781681133093;
        Wed, 17 Jun 2026 00:25:33 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-82-184.dynamic.gprs.plus.pl. [78.30.82.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462a9784497sm3009320f8f.34.2026.06.17.00.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:25:32 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 2/2 blktests] src/miniublk: fall back to legacy opcodes on older kernels
Date: Wed, 17 Jun 2026 09:25:16 +0200
Message-ID: <20260617072516.6238-3-sebastian.chlad@suse.com>
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

Try ioctl-encoded ADD_DEV and GET_DEV_INFO first; if either fails,
retry with the legacy raw opcode. After a successful bootstrap
command, derive use_ioctl from UBLK_F_CMD_IOCTL_ENCODE in dev_info.flags
so all subsequent control and IO commands use the mode reported by the
kernel.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 src/miniublk.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/src/miniublk.c b/src/miniublk.c
index 5a35ca7..494a4ae 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -112,6 +112,7 @@ struct ublk_dev {
 	int fds[2];	/* fds[0] points to /dev/ublkcN */
 	int nr_fds;
 	int ctrl_fd;
+	bool use_ioctl;
 	struct io_uring ring;
 };
 
@@ -235,7 +236,7 @@ static inline int ublk_setup_ring(struct io_uring *r, int depth,
 
 static inline void ublk_ctrl_init_cmd(struct ublk_dev *dev,
 		struct io_uring_sqe *sqe,
-		struct ublk_ctrl_cmd_data *data)
+		struct ublk_ctrl_cmd_data *data, __u32 cmd_op)
 {
 	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
 	struct ublksrv_ctrl_cmd *cmd = (struct ublksrv_ctrl_cmd *)ublk_get_sqe_cmd(sqe);
@@ -255,25 +256,34 @@ static inline void ublk_ctrl_init_cmd(struct ublk_dev *dev,
 	cmd->dev_id = info->dev_id;
 	cmd->queue_id = -1;
 
-	ublk_set_sqe_cmd_op(sqe, data->cmd_op);
+	ublk_set_sqe_cmd_op(sqe, cmd_op);
 
 	io_uring_sqe_set_data(sqe, cmd);
 }
 
+static void ublk_update_ioctl_encoding(struct ublk_dev *dev)
+{
+	dev->use_ioctl = !!(dev->dev_info.flags & UBLK_F_CMD_IOCTL_ENCODE);
+}
+
 static int __ublk_ctrl_cmd(struct ublk_dev *dev,
 		struct ublk_ctrl_cmd_data *data)
 {
 	struct io_uring_sqe *sqe;
 	struct io_uring_cqe *cqe;
+	__u32 cmd_op = data->cmd_op;
 	int ret = -EINVAL;
 
+	if (!dev->use_ioctl)
+		cmd_op = _IOC_NR(cmd_op);
+
 	sqe = io_uring_get_sqe(&dev->ring);
 	if (!sqe) {
 		ublk_err("%s: can't get sqe ret %d\n", __func__, ret);
 		return ret;
 	}
 
-	ublk_ctrl_init_cmd(dev, sqe, data);
+	ublk_ctrl_init_cmd(dev, sqe, data, cmd_op);
 
 	ret = io_uring_submit(&dev->ring);
 	if (ret < 0) {
@@ -321,8 +331,19 @@ int ublk_ctrl_add_dev(struct ublk_dev *dev)
 		.addr = (__u64)&dev->dev_info,
 		.len = sizeof(struct ublksrv_ctrl_dev_info),
 	};
+	int ret;
 
-	return __ublk_ctrl_cmd(dev, &data);
+	ret = __ublk_ctrl_cmd(dev, &data);
+	if (ret < 0) {
+		/* retry with legacy opcode on older kernels */
+		dev->use_ioctl = false;
+		ret = __ublk_ctrl_cmd(dev, &data);
+	}
+
+	if (ret >= 0)
+		ublk_update_ioctl_encoding(dev);
+
+	return ret;
 }
 
 int ublk_ctrl_del_dev(struct ublk_dev *dev)
@@ -343,8 +364,19 @@ int ublk_ctrl_get_info(struct ublk_dev *dev)
 		.addr = (__u64)&dev->dev_info,
 		.len = sizeof(struct ublksrv_ctrl_dev_info),
 	};
+	int ret;
 
-	return __ublk_ctrl_cmd(dev, &data);
+	ret = __ublk_ctrl_cmd(dev, &data);
+	if (ret < 0 && dev->use_ioctl) {
+		/* retry with legacy opcode on older kernels */
+		dev->use_ioctl = false;
+		ret = __ublk_ctrl_cmd(dev, &data);
+	}
+
+	if (ret >= 0)
+		ublk_update_ioctl_encoding(dev);
+
+	return ret;
 }
 
 int ublk_ctrl_set_params(struct ublk_dev *dev,
@@ -453,6 +485,8 @@ static struct ublk_dev *ublk_ctrl_init()
 	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
 	int ret;
 
+	dev->use_ioctl = true; /* use ioctl opcodes by default */
+
 	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
 	if (dev->ctrl_fd < 0) {
 		ublk_err("control dev %s can't be opened: %m %d\n", CTRL_DEV, errno);
@@ -628,6 +662,9 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
 	else
 		cmd_op = UBLK_U_IO_FETCH_REQ;
 
+	if (!q->dev->use_ioctl)
+		cmd_op = _IOC_NR(cmd_op);
+
 	sqe = io_uring_get_sqe(&q->ring);
 	if (!sqe) {
 		ublk_err("%s: run out of sqe %d, tag %d\n",
-- 
2.51.0

