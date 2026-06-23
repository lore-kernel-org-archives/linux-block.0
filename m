Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BE331EC1
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185237; cv=none; b=mQpYhPuVwrgkAlN392EYrnBU3HelwLSZDNPeJHoUnePpzi5p8o4R462u3IFaMBb2Mee8vhlUUQt5sR+xdPR1AgEPEFk0ZGIYmOTeRvEo0wY1862DlP5HI7g5mkbK1nvAgpVLUD8Ga8oAm8+Z0bcSsCMEt2GvZldCkB2yQyQ1m/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185237; c=relaxed/simple;
	bh=UaIg/W70jad9y3hm4PM7i9LbDnNElSxFM88ZY98KeYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKKupkxDLKng29tdPVX93zvFZICCi5LAQP6aBuSp5ONIDAjxfenhXCwG+Y0xbXsiOZN9SU4EeLEMYXrbkd7bYnAf7je13Iu4GHP0MGL5PcfS3V2kfqYLfTllpiX2+5OojGPvdLS6yEZMvtAerNT9baDM1proTL4OFaQbPok5fuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn9YSzKa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn9YSzKa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so39743665e9.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782185234; x=1782790034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0MxdLA8fA9f6zO0DHTOluuac+507x4UYeSWNuPxgvo=;
        b=Pn9YSzKaxdT7V3kLSyXvSB+nvyhzGnUziQXditgvFZ3dXGLJ0xwnhLAmdKutAp+xUt
         1NgoZ1KnUx6az6xxYtqpTsUsdHYrQkZCgrLHN5J5oVPrX2Wql6U9fpXqJkTer5mmz4v0
         1xGnlf7LO1sQzW0RUYlCtlzpSnbHHgQ2/eXTjlpM7LUy9NVCsFDJz2x4ta7DBWMPkBKz
         RkV4ZRd/pPHx6I97I/97f1hX+mWeP1oQYl1KWgmukQtp87tjEd6TmK6sLKHV9nicQoVY
         t+D0KOzqQ9LBab/mcCTuhF7ttG6wLnAGNb+dswtbT4Jh8DA8hGPSh8Gq2ZNPJEtxvnV+
         8A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782185234; x=1782790034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0MxdLA8fA9f6zO0DHTOluuac+507x4UYeSWNuPxgvo=;
        b=C1qGFXOSsxW046yAVGts+xek0rwzlJqvRC9sFsHxsFQ2e3NAxfi9yPuiYudk4ypnMk
         gp+AbpJpxpHXPrmiVl9veAs5Ly219rrZS2F5AdyrI9eJgXEIOBkQQlJ/HZoEXo/C4C1R
         +DolJZdQ+7YqgO3r8ok4SaUM9iAhawJii4h+phM0o5fx3Due3jtVpcaDht/xYDoKdVBI
         Iyc30lcdWLYZj68MZNbK5rfgya/7Oj4yf6Xpwdb9W2EvXaEghYpvCyD2Fs+vcnY8/0ad
         3DGwVRy8/iLW3+UvEyeTZ7SbTxUK0LzgCpHShB1IDCxEUDjS+SchAzPpb1P8W+j5sVAi
         vWlQ==
X-Gm-Message-State: AOJu0Yyg5Ps/YtrV8DnexM20Q42Op03ufpmt+HoVZXHrsAL70duPM83k
	+Ar2HLeJ4IVi6vYfOZrmIfaICVD0S7OlIu/8ER8YKLR+49ZZWklPzZ+B9OqM1g==
X-Gm-Gg: AfdE7cmBENmqfV0ZbQgD2i86owIRcsefB1thPkYqf6WSoSGK2D63lASdLq/sOJy/iF8
	apaUF47UjLpuugeLDTtAgpdmf76US/5Nl9KzggVXg6s+tVw3uyyrIeOJEHARdi903LOFaoEqx3S
	W2+aPjnpUrm+KA3tR+640U8UcV4/e3AmxtJWdJN5IwWNEEUcJYiv1Ib6TH8117jtm1YdLbvhwbg
	om0g+Ko3ezxPtVjZY+6U2hXxM9ljPlwC42oNm63GWYZHE+L9zl0DUgA5eXL1HU68KWNJEAO7WpW
	eMlxslVDaNdnAbmFBtBb8lUKea1mEXtc18Huuq7P4qjRy6oO198RlFikedjWL9zO5s7+DTZf6yh
	VurWgznAmD5S50ZeRBnR1htNhHnljCBHzrrNjmFKXpsJJ6ty7HLkVFxUOTKEUHoG3CVYuTxUPAR
	uXlScWFwHQe6h3cbqR1BTpP+QZkuz4RIlCUFGh5WSKf83c9LyDjHLJV9AwASEVN0Kh81UbW9kvf
	UcDFYY7/CEpPhQDgdNYjLia7ivVMjFOtg==
X-Received: by 2002:a05:600c:e547:20b0:492:53e2:7712 with SMTP id 5b1f17b1804b1-4925b3ad732mr7444585e9.21.1782185233722;
        Mon, 22 Jun 2026 20:27:13 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-83-17.dynamic.gprs.plus.pl. [78.30.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm577781005e9.0.2026.06.22.20.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 20:27:13 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests v2 2/2] src/miniublk: fall back to legacy opcodes on older kernels
Date: Tue, 23 Jun 2026 05:27:07 +0200
Message-ID: <20260623032707.14439-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260623032707.14439-1-sebastian.chlad@suse.com>
References: <20260623032707.14439-1-sebastian.chlad@suse.com>
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
index 628207a..b0c308b 100644
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
 	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
 		cmd_op = UBLK_U_IO_FETCH_REQ;
 
+	if (!q->dev->use_ioctl)
+		cmd_op = _IOC_NR(cmd_op);
+
 	sqe = io_uring_get_sqe(&q->ring);
 	if (!sqe) {
 		ublk_err("%s: run out of sqe %d, tag %d\n",
-- 
2.51.0

