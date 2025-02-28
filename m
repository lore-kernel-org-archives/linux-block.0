Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B51DED6B
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784477; cv=none; b=U59xppGqNGxumc2RcoSWi0olBY7qS7ga6eZNjMul8Tsz8CB8NQLk2Z79pmQ/4cO08eqAWinFAHYVnXUyYmxlRGHstmIooyzPFaQR5C+cqRQsKES/uVxMDL/DbuHyM04ModHOD+rfW3GvG19OW9MwjRSBIqT17H9jHhwADH0igI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784477; c=relaxed/simple;
	bh=sXf5/A1zFytM8lFmj2gEeV5EMeYDWOAN3JXS2CuB0z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cu6Xh5F/S40vpKFZ69uR7mbGgQQJ/PdpbIiacgeq2zamjOhcQC8ju93aLHS9U1MEm/TOohQ42LkVxqU6TpI4U6IkHB4zx2pU5OlRtvJqEPNhD/oxJ1wlKDl7iyD0V4eSEEm+oO9GtfkGDQV3gTv8ntc4Y5IJirAwQVPU3zFjr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ClO6Qt1+; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ClO6Qt1+"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2bc69a33810so125285fac.0
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740784475; x=1741389275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=td3QLI6VMDUiQOrb4BUroNuidyjitBQIjpVlt7JOrWo=;
        b=ClO6Qt1+RSnuk4+Sh77B2GRSKqwrpoxIB8lU93xNfEioWZ5F7VpXnqSOA1RnwLK5x8
         JlWypEp/n5tX4nhY74Khnv2DxyBH1DmgIiY6aPDXSvwJBqHk3muIvTy32NgfqNfBk7tQ
         rDnf6RpgI63X3ZHy4m/AGDBXRXq10e+vxtVD5zk8olEHbzw344TyNLQsokqvWgZPTioK
         ISuFymSEMelPwuM5SkAVNBgkJl8NaBjN7eWvXb6etFi+okXdSqQMsYtRxK+NFp1TVvfb
         j1kNMlgh+sFOXOs61oAbhCkxXy+fiuD7ATt1vy9Z0G0ZL1xqz+dYopPJAAl5CzPqaw0o
         MAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784475; x=1741389275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=td3QLI6VMDUiQOrb4BUroNuidyjitBQIjpVlt7JOrWo=;
        b=sPuSYizKFMbCsdjktfNovN+2bIbzJe8YLvMZVslS14TjPrDAOkpzLt0q53os5s+I0O
         xBhhP5F/6JS+oa7MJmTCI8Xto6sU2tOLh5JAh/qzPrDKkJQi4dQ45Mh2xmS8ff0but2F
         WN9y3Ekq21j3Eo9CnKc69lNelssWNIhaZjDG/nRB3Yoc7rY/ub33RJWO/BtGwIcIJg2+
         l5WC149R0rK3QnEz9AHNcxh0VOEzmTHY0C+z1YzhquTOBi6NDLrgLxEpGQCDoQywPXRe
         2nTazdxc3TUH/YCqhosn8graXIlwujyxlh0d+vhyx0MfBlUq9P9jPo7qoXl44uDX6XT2
         BmKg==
X-Forwarded-Encrypted: i=1; AJvYcCXZNpbMYqpIn18QH+fICy6A8p2L//NaE9pRP41dJFR1MdOiy0aEqw5CW1r8Kd5lUh7WX3FbeBcIvrvUbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjacZTCnsEP/Er27wsw3iRZyaGcWaBcHff/KiGwSbJ0N8XAKqu
	9wLlSlQTIvHxlUa79HKC/fJqkVG1SEiwXnMTAsNsq902IArkK9Igga+6KjaKzpVP7OiajaI3SM0
	yAcnn6JyTscVqnNk79BQCNxpPpnYtHaIBU5IksDxa/DJ2a99+
X-Gm-Gg: ASbGncuRgyTwdECWwmPrShLnKnuGyKgI4tHG3awSQzLyJSoYpt8rYzJ93q1G48yghVQ
	ZlZzJ2mzoZxba8b6FhrUTUNNYxhnpkYdtFhfGkhNfZYp0Dv09M1WlxAodu6mhCANe5IHA7VzEBr
	50Hro8Z46JPknie77rWMU29CRMLMjHWwpbU64eGlU79234iWrV8wpy5aT0+m59f/VfS8hVxi0Px
	mDzxt8Ppj41wL9Z5CrnGMSrXN0i0FfcNbhRQpYk+tWO7frqqmWkTOaRlv9oBSpNt/1+9yoxxP7K
	5RZCCGt2a0NOga/nOBFElWzzamZFBra9FA==
X-Google-Smtp-Source: AGHT+IE1+WxOcP+PFDf9gVT8bBwaZ8BjfRRqOWZNPk/1wluXto7KDqsniux9pWhX0MxzxMrxHOiWccWukV59
X-Received: by 2002:a05:6871:3804:b0:297:270f:d79d with SMTP id 586e51a60fabf-2c1786717b0mr1131713fac.8.1740784474779;
        Fri, 28 Feb 2025 15:14:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c15c4d775fsm235764fac.34.2025.02.28.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:14:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A9BF934028F;
	Fri, 28 Feb 2025 16:14:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9E713E419D4; Fri, 28 Feb 2025 16:14:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH] io_uring/ublk: report error when unregister operation fails
Date: Fri, 28 Feb 2025 16:14:31 -0700
Message-ID: <20250228231432.642417-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to userspace applications if a UBLK_IO_UNREGISTER_IO_BUF
command specifies an invalid buffer index by returning an error code.
Return -EINVAL if no buffer is registered with the given index, and
-EBUSY if the registered buffer is not a kernel bvec.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c     |  3 +--
 include/linux/io_uring/cmd.h |  4 ++--
 io_uring/rsrc.c              | 18 ++++++++++++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b5cf92baaf0f..512cbd456817 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1785,12 +1785,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 				  const struct ublksrv_io_cmd *ub_cmd,
 				  unsigned int issue_flags)
 {
-	io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
-	return 0;
+	return io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
 }
 
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index cf8d80d84734..05d7b6145731 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -127,9 +127,9 @@ static inline struct io_uring_cmd_data *io_uring_cmd_get_async_data(struct io_ur
 }
 
 int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 			    void (*release)(void *), unsigned int index,
 			    unsigned int issue_flags);
-void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			       unsigned int issue_flags);
+int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
+			      unsigned int issue_flags);
 
 #endif /* _LINUX_IO_URING_CMD_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 45bfb37bca1e..29c0c31092eb 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -975,30 +975,40 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
 
-void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			       unsigned int issue_flags)
+int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
+			      unsigned int issue_flags)
 {
 	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
 	struct io_rsrc_node *node;
+	int ret = 0;
 
 	io_ring_submit_lock(ctx, issue_flags);
-	if (index >= data->nr)
+	if (index >= data->nr) {
+		ret = -EINVAL;
 		goto unlock;
+	}
 	index = array_index_nospec(index, data->nr);
 
 	node = data->nodes[index];
-	if (!node || !node->buf->is_kbuf)
+	if (!node) {
+		ret = -EINVAL;
 		goto unlock;
+	}
+	if (!node->buf->is_kbuf) {
+		ret = -EBUSY;
+		goto unlock;
+	}
 
 	io_put_rsrc_node(ctx, node);
 	data->nodes[index] = NULL;
 unlock:
 	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
 
 static int io_import_fixed(int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
-- 
2.45.2

