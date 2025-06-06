Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C541224AE4
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246032; cv=none; b=paUAbCdmOpmCTNhK4RPz+161sVr9DoiepSuzWZ5X5uH3p5IAXhivZNaDknu6z2fnzY+fdToUSwoo29M+vJ9Rrgf0/OUGZXAy2tTYO3cAf3mzS+mrjwsZ/BGjenEgbacs/92hUczVpGvL6KLjwpfCtuUF0O/Q2U7UMQLFFsgUXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246032; c=relaxed/simple;
	bh=byip2/peJMqMfCGylUXRwHAj8KW3al1kIqdFB83W68g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLCvi2KAp1q82aoEqcMWa0wO9mJOy8buzyOcq7Kh2YI0YxpTIrNVegdJEBoKhl2C93LPxf2Iznc7egHr2YK+LT5l+bDidwBufJgM21R7vTYLqgAlW4/e1mN5R2tPHAEYz8DPbf1iucuLz8ObmNPCzOQWp3J2cpG78Qo6jZyC75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kocjt3uz; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kocjt3uz"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-86cf1792451so6557339f.3
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246029; x=1749850829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZHHA4b3T+DZmexzzF9+lz03kaElagaarwrQClEQ+QA=;
        b=Kocjt3uzSnrxSIU87QKubQnce8HWm/Wp9IaIwrq7XbelrBMiIqaGBwFd80PnY0gBWT
         K8XMQ1NbKgZBi5MSYKEK78lUkvPKbNaiK+6UYwZwF9q+Wm4uBxQ2VjEJHwqDJE4RrzAz
         QQpM/uiZd5HV5FrGFawMrFuHyPiVmEQP4yXAk/jCf5pJ3qk2dmRhoyw5K/GtHTgIXO7n
         0cZFZ0IhIH3NTq/BEA7s+ifRCY+c0RMqfsPVDqS6i9lGNj2pIfN+/qfJ4IML4gTLKHOx
         tXTLkJYZtzwxGtdZBZ57RfYPceOrQNt0iDeBVG2V4SZxxqGEF1tVyorx5ECqYcEVT/vn
         W52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246029; x=1749850829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZHHA4b3T+DZmexzzF9+lz03kaElagaarwrQClEQ+QA=;
        b=O0aZ1gg1mWdyaGv44FN6PNKYDNmShQft7WiarzGreQUua1aEBt5fXmLZAfN/MfjUeJ
         tgaifjqWnDze2HcEIRCGpHO30iGVcXMDoDEUGF0rflnuqSgbxpDK1sk8en/NhDYyeFYW
         HnP9s76WgwswXqMAzHKwyNg4Sftu//Uf2+FXcw5H/tcQE9PLTqs05+Exu+wb1UzQ+T3/
         KX+7LDPlBMoKNWUxu/LRv/Qu5MNeUgpgSPlwxRSqa2D0DipRy6jV7bCoFMQI9WsFr+jq
         StcKePSblGEvey2TgYWb2wWQxM8ENDY6IhFBr2+H2dSglAWWDrcnBNhYs3PW53R/Q7vf
         IFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRn3RMlJdqCRpSU7Lrh4QZYLnGNohro7DYSJSO2qpcq5HNOkUuKXPk35iwM4xvsBsO+lm84wC00mvqag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFgzVCWTuP/CWp91Jq+1B7CEN4A+QyhaOTDmcX7fhnzFf4fdRV
	nrCRmIS4IuMd1yP8MIXD1+RxdT0TCZU6PFDygvXsboXBoEM8RfbxrC8EEsBiU32x8bJRoGGDGeC
	YcT6u2Ts2ZOZIfbnFnTZzVF3mECO3iu0ZWepYWZ7mQQ0EHlVV/FqV
X-Gm-Gg: ASbGncvFdo1QipfuLp3gdhWZUSlageN4SoJEjTNO5SohCMIC/hdMwpdVEz1S4O6cv3J
	80MQWyNbnwTi+nAA5PgZYTUhXhvJhth/88FHw3io+SrNLg5dEFy/0icRD/FGcDL4qg0sqSiMa6q
	xfySCf2TqWj/OIeTjTMa6MNU3otwc0PPrl2QxsCb3qAwPHS6f988VqJ0VCBY+XxCeuYNoQH73Nd
	C36efjjE2ZOB21uk92MHyHp7wdfBYAWTbAmh3qkXk/kCxuXS9LdoOdZ9w8lm2dGEkPlN1iUb2nU
	oDHCnzRs/6LzHTvGQ/x7PFKYN3KLHw==
X-Google-Smtp-Source: AGHT+IFi6HvCw3b/J8osdYvOjzgLaLuYVcWALCf0KflENqxTTmUs5FaW1qkUAx/gX7oWt/3rnpAVyvHuF7pj
X-Received: by 2002:a05:6602:341d:b0:85e:12c1:fe90 with SMTP id ca18e2360f4ac-8733671f204mr177958339f.5.1749246029350;
        Fri, 06 Jun 2025 14:40:29 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-87338a79ed4sm12016139f.29.2025.06.06.14.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:29 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 83B1E340332;
	Fri,  6 Jun 2025 15:40:28 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7AC27E41EEA; Fri,  6 Jun 2025 15:40:28 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
Date: Fri,  6 Jun 2025 15:40:09 -0600
Message-ID: <20250606214011.2576398-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250606214011.2576398-1-csander@purestorage.com>
References: <20250606214011.2576398-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF are
only permitted on the ublk_io's daemon task. But this restriction is
unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req() to
look up the request from the tagset and atomically take a reference on
the request without accessing the ublk_io. ublk_unregister_io_buf()
doesn't use the q_id or tag at all.

So allow these opcodes even on tasks other than io->task.

Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io since
the buffer index being unregistered is not necessarily related to the
specified q_id and tag.

Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use to
determine whether the kernel supports off-daemon buffer registration.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 37 +++++++++++++++++++++--------------
 include/uapi/linux/ublk_cmd.h |  8 ++++++++
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a8030818f74a..2084bbdd2cbb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -68,11 +68,12 @@
 		| UBLK_F_ZONED \
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
-		| UBLK_F_PER_IO_DAEMON)
+		| UBLK_F_PER_IO_DAEMON \
+		| UBLK_F_BUF_REG_OFF_DAEMON)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
@@ -2018,20 +2019,10 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	}
 
 	return 0;
 }
 
-static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
-				  const struct ublk_queue *ubq,
-				  unsigned int index, unsigned int issue_flags)
-{
-	if (!ublk_support_zero_copy(ubq))
-		return -EINVAL;
-
-	return io_buffer_unregister_bvec(cmd, index, issue_flags);
-}
-
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		      struct ublk_io *io, __u64 buf_addr)
 {
 	struct ublk_device *ub = ubq->dev;
 	int ret = 0;
@@ -2184,10 +2175,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
+	/*
+	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
+	 * so no need to validate the q_id, tag, or task
+	 */
+	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
+		return io_buffer_unregister_bvec(cmd, ub_cmd->addr,
+						 issue_flags);
+
 	ret = -EINVAL;
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
 	ubq = ublk_get_queue(ub, ub_cmd->q_id);
@@ -2204,12 +2203,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
 	}
 
-	if (READ_ONCE(io->task) != current)
+	if (READ_ONCE(io->task) != current) {
+		/*
+		 * ublk_register_io_buf() accesses only the request, not io,
+		 * so can be handled on any task
+		 */
+		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
+			return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr,
+						    issue_flags);
+
 		goto out;
+	}
 
 	/* there is pending io cmd, something must be wrong */
 	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
 		ret = -EBUSY;
 		goto out;
@@ -2224,12 +2232,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
-	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 
@@ -2918,11 +2924,12 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	 */
 	ub->dev_info.flags &= UBLK_F_ALL;
 
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
 		UBLK_F_URING_CMD_COMP_IN_TASK |
-		UBLK_F_PER_IO_DAEMON;
+		UBLK_F_PER_IO_DAEMON |
+		UBLK_F_BUF_REG_OFF_DAEMON;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
 				UBLK_F_AUTO_BUF_REG))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 77d9d6af46da..034497ec3d2a 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -279,10 +279,18 @@
  * (qid1,tag1) and (qid2,tag2), if qid1 == qid2, then the same task must
  * be responsible for handling (qid1,tag1) and (qid2,tag2).
  */
 #define UBLK_F_PER_IO_DAEMON (1ULL << 13)
 
+/*
+ * If this feature is set, UBLK_U_IO_REGISTER_IO_BUF/UBLK_U_IO_UNREGISTER_IO_BUF
+ * can be issued for an I/O on any task.
+ * If it is unset, zero-copy buffers can only be registered and unregistered by
+ * the I/O's daemon task.
+ */
+#define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
 #define UBLK_S_DEV_QUIESCED	2
 #define UBLK_S_DEV_FAIL_IO 	3
-- 
2.45.2

