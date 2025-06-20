Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E82BDC17
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432219; cv=none; b=BsfaDNuubZP9V6ycpS+a7+K9cWAzJUQaBA1ypVU+RpCyt8s7ST81laYG5N6PPP5KqNUAUs5Qf7eV79vo2++WXH5IFE7z8VDE3LKZxjkf7rYUC71pOjkkEt5dsLq+apfaPa6HbulfY/6ovG15zXeura2iwJwRAOlamx7hre1coVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432219; c=relaxed/simple;
	bh=HvJWqsz/bu+vFciye21aWCD3pV4Wu6rTettGS0bfa/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzUQMw7vBrEq1S8lxLUCTfJjJmh5sTB7tia8tGLIGT+f00JGupsVwtzI2xG90BeB9/Elr1ibpp0m4IGneMgZLDDFMf1hdWi0QlR5j94BYQAdF4AlVVTZvTI4EOKNu2Pq3PZoxylL5AOUCDqMhxeWoiVdOA9mHOpf5d+i1qBBwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Fo344Js2; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Fo344Js2"
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3de2b02c6e0so755515ab.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432217; x=1751037017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znEkwpRWaeom9QsrDAXuxNHFcaMqkIL22doD6zVDtpk=;
        b=Fo344Js2IrDN3T8PS5TKu93ymDcH0jVWJUr9EvyiuZcZbf2c3bGTqwMelSgZb6QjNw
         a6x1JrtHwnapr6GmaYVcmoVyK+Ffy8kCDa0V7N6UwXlsJUuxALVRB9tkL9sGuH5UfB4+
         MJHrs934gnDt2gpZbtZbFHuMC+1ZdvIpsxENHUTCuJipiJ/e+iHGE1xivyCaHXQwqE+K
         lTGic/CQwJOK/d2+AaAFj36YULdVCmMmnioPRd5voSXyDzAT3ZH2Mt0LuTMfuiLkAD4+
         rHGpih5QczNvgPUS4XV6FqMKVcQWqlfj2eSOxBcfe9hb0cLKpwYThztbEthSfTmApEo+
         dKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432217; x=1751037017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znEkwpRWaeom9QsrDAXuxNHFcaMqkIL22doD6zVDtpk=;
        b=HTFYMCHzA+6wK1F1opM+/Gk7yRRDxJR6ApFyWkeXCd5bavE3lPEOsUNSij7X5f3o+j
         bKStZzClRuKkIhrHMOu9JC5J13gY52aZbzVY9vwQBvoqMShPPDiaoCy6RYmOwyjdcGyr
         p+BhqPKUh+vtpeekKZtgm1FS9lz9+Dq/wx9hAHFfwh0CGt0NwS5yY50RjtRpdrz1g5Q7
         npKAnRajyRuGvqq7AISeJ4FPQ+2snZfhYbNngoolFeHgykoGYlg9gw5AL0XtWiP7neJW
         ylgrMilmk72n3M59jt+65SeDl4UYVN/pqS+K3gIqluWmBBYlxoxKhm1dvS/oYtWwjFzA
         xZzw==
X-Gm-Message-State: AOJu0Yw9/EoUF0qCb7mc2tRYqksnttwhLAEXUwjD9DfzZXrz1yyifJMs
	Y0zhPMpTkw3r7LKaM5GGS5aGdj1cGPpKd0yBqHPFj+EOUh238qYQfCmLPPOFpCNQc0WqBmLIXKl
	38tvQUKE+W6aeUHyFwtSYuxmxzCGqR+p7DPxQlDZ7cSxiACRpYE+U
X-Gm-Gg: ASbGncvMmhxLi+9+2EnFxs9CWFcD/VEk4ukAfPp7sEOaOHSfmVGfxkQJkyCIVzWVV70
	zvEwZ1EDnY8HiRhlj2lm+Zi8HDtqh7yFVJjfgoXZp5VvqX9FGHLD59M0iTrf2sPJQaVVzQ2MSfr
	Oq945L2VYqDJJXD5dE0u2zFnpWJs6SzkckRAHRxkEToquiCL7eDB5AXcOkoZQ4Ke3V004XstUaS
	1duC8CNEdqKihJc4GpqpoCuyspp49A9QBuhmYrhGvXBKY2PxRxXQZEfUDycd7OOSZTO02+8uopI
	4kT6NALgzk/k8upGqheBa6cVyjjPXYWNpVlBB5Vs
X-Google-Smtp-Source: AGHT+IHto1YK7Wn/X9cmc+hrElYDA3vB4O1RvKy5keFdp0qM4Oij2QmmzSOIaVkGS+NnfBvJ63PtKYpENVTl
X-Received: by 2002:a05:6602:2c10:b0:864:9c2b:f842 with SMTP id ca18e2360f4ac-8762cd4a230mr97968539f.0.1750432216917;
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5019e04ced6sm98053173.41.2025.06.20.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0AE613405F1;
	Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0A33DE4548E; Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 09/14] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
Date: Fri, 20 Jun 2025 09:10:03 -0600
Message-ID: <20250620151008.3976463-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
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
 drivers/block/ublk_drv.c      | 27 ++++++++++++++++++++++-----
 include/uapi/linux/ublk_cmd.h | 10 ++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 237d50490923..11aa65f36ec9 100644
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
 
@@ -2186,10 +2187,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
+	/*
+	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
+	 * so no need to validate the q_id, tag, or task
+	 */
+	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
+		return ublk_unregister_io_buf(cmd, ub, ub_cmd->addr,
+					      issue_flags);
+
 	ret = -EINVAL;
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
 	ubq = ublk_get_queue(ub, ub_cmd->q_id);
@@ -2206,12 +2215,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
 	}
 
-	if (READ_ONCE(io->task) != current)
+	if (READ_ONCE(io->task) != current) {
+		/*
+		 * ublk_register_io_buf() accesses only the io's refcount,
+		 * so can be handled on any task
+		 */
+		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
+			return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr,
+						    issue_flags);
+
 		goto out;
+	}
 
 	/* there is pending io cmd, something must be wrong */
 	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
 		ret = -EBUSY;
 		goto out;
@@ -2226,12 +2244,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr, issue_flags);
-	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ub, ub_cmd->addr, issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 
@@ -2932,11 +2948,12 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
index 77d9d6af46da..a7b52f6c1ba4 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -279,10 +279,20 @@
  * (qid1,tag1) and (qid2,tag2), if qid1 == qid2, then the same task must
  * be responsible for handling (qid1,tag1) and (qid2,tag2).
  */
 #define UBLK_F_PER_IO_DAEMON (1ULL << 13)
 
+/*
+ * If this feature is set, UBLK_U_IO_REGISTER_IO_BUF/UBLK_U_IO_UNREGISTER_IO_BUF
+ * can be issued for an I/O on any task. q_id and tag are also ignored in
+ * UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
+ * If it is unset, zero-copy buffers can only be registered and unregistered by
+ * the I/O's daemon task. The q_id and tag of the registered buffer are required
+ * in UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
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

