Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16E23C51C
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160241; cv=none; b=T1RYvGn6RMNimgiKyW0kXGxE1q/9oITUxpf2GdFBE9D4Bav98zSyU5baUcLw3KUcNOyfVnGnaV4lhiXJ9Z4zzRO7+Zlf+6ozM6FEnK3tHUyaQ1PYPZPe0BizmkDFZGbk49QY1fl75PxpEk2/ZcLfzYy+Hn8tExlGy5uOOAqfSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160241; c=relaxed/simple;
	bh=SADlHgrOrTEn79WvE5EtQJLfGlA1k13iJsqgAnWiaNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC3q+vRa95Wery+/eqAJSmrPnJBHH/gfSb0cLy+uzINgSoL5o3bfpWnVEn8GtsbRYaPHMU1ZyGgQlLvJWZZ2s0qWDivXIgWbxo8HjktD5xOQApEoSzkclEyr6HMJauS+Z8wGYCKZFi1tUifJHEM1mN8zOYrNBDNJwYMDAqPrK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IkrNHWib; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IkrNHWib"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-4b604c17182so225381cf.1
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160237; x=1758765037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QKZxZyP+vsEEnhv8Ftm0VexvVlHS9TFLKY4pSs7XGM=;
        b=IkrNHWib0W+mKEJucZ+ukTsLPO44B0hauglDgo200XYzN81SwdL6LZacBor6catxTS
         GjIKrebSBY+YyIfouLYc8W7H9Xr0gqKBUDf522DYix7Mt0osi76aVCpNq3R7LDVMBf0C
         x+5nlHbTuJksu796y3x/6fGVG/gtnT1w//ZFmeUledf32i3/iqoeeM35ZR6dO3WXgvxK
         pzjm7Qdt2bkk8I1j2RjVr+Q1fWjurx/8tg/Hi3zi/7Cd7JulsuE1KmWRoPO/zc3dgnLG
         s98r90BwRdUlUe3KOLBOOM5ObrD4JwL/Xp7ccGbeucmQIcfsCSbs4ZDUnjipjaFoypeR
         vAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160237; x=1758765037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QKZxZyP+vsEEnhv8Ftm0VexvVlHS9TFLKY4pSs7XGM=;
        b=rN6b45MEzKoZWzaRZY1bcUUi8sUtYc4r/1ArNi04gw3RrdByPsM9dT39sHgnqHHKIn
         GPpTG7j+PP2MefO2STS4J20SyoU0HecW19YNH1QknnHWF3gVo+B73mND3kDrb6lyNo7b
         2m4ocw+XlSd3neKvKzqP2IytEWqTk1qwR3QZ0I8e9aR9yLm9ikFjf+s0UkcCFQIF+W2G
         vEGfYsj/NjMdqprX+kP/JS5yKP9umURISsz/14pNaQnLcaTa96krVW7Fcq/JfKcEfpP9
         mTVLkzOwVvQLWOPpWdnR+2/bVx9b0LGR3CGT6oTzQ2SjcXXcQTsRGftRRAj7nDUJV0k+
         mzsw==
X-Gm-Message-State: AOJu0YzlpYLNdqaC0Q6qzhWLxJ5cWEXtr3pzfjq114S6hsjGZBdl6sZg
	Xpku25tRxFzAOVlW/ggtapvxyYH5ZiQqX33iaXpvBoUrRTRnPTR1FfnC4lAmaDV+ZyvxxdYKQK9
	1MeqF+CnCQyVk11+pL4Oa5agWAQBQjrWF/vP12MewBWKzwvHWE3QY
X-Gm-Gg: ASbGncs/EtCys/TItd+Ete2W8V8rQMvAKK+pdWROaeFxK01TheucEH7uURUjO8v7REE
	hfLnBLYJikzAoNPyPNL9/Ofty57pS83y4gEOd/Xz8X1Rje+QRovkliCFR+SbAvAK5zF8+miq6Uy
	ZJKRzdzMfZo80VABGMpfUb2iuLojbR5jtr4ysD3DiviJrg9AGRE64X3/H+d20EOIdbBxLL9ryfA
	oSjMTt895EmHRY0ACDPxjlfWetPQn5SBsN+VEtm/TgDDm7Ox1HS+XYIMN18gMsbvpgtWjn9Mps3
	099a7Hxy0htVP8zhEieurIt0FhkE4ttHtKrjJeug6m8l/pNJ4tj0+36FnQ==
X-Google-Smtp-Source: AGHT+IEsgIGsNSRRNT38WH7yzSqLp/Ktc3WgoI/FXMkTetjwhZhrLfnLD0dIVWr34qvWWxXEJ54m1NyDRmNv
X-Received: by 2002:ac8:5dc7:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4ba66a30247mr35635721cf.4.1758160237404;
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79350a538c8sm710306d6.33.2025.09.17.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C303334059B;
	Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BDB7BE41B42; Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 07/17] ublk: pass ublk_device to ublk_register_io_buf()
Date: Wed, 17 Sep 2025 19:49:43 -0600
Message-ID: <20250918014953.297897-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid repeating the 2 dereferences to get the ublk_device from the
io_uring_cmd by passing it from ublk_ch_uring_cmd_local() to
ublk_register_io_buf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d6d8dcb72e4b..cb51f3f3cd33 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2123,15 +2123,15 @@ static void ublk_io_release(void *priv)
 	else
 		ublk_put_req_ref(io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
+				struct ublk_device *ub,
 				const struct ublk_queue *ubq,
 				struct ublk_io *io,
 				unsigned int index, unsigned int issue_flags)
 {
-	struct ublk_device *ub = cmd->file->private_data;
 	struct request *req;
 	int ret;
 
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
@@ -2150,10 +2150,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	return 0;
 }
 
 static int
 ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
+			    struct ublk_device *ub,
 			    const struct ublk_queue *ubq, struct ublk_io *io,
 			    unsigned index, unsigned issue_flags)
 {
 	unsigned new_registered_buffers;
 	struct request *req = io->req;
@@ -2163,11 +2164,12 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	 * Ensure there are still references for ublk_sub_req_ref() to release.
 	 * If not, fall back on the thread-safe buffer registration.
 	 */
 	new_registered_buffers = io->task_registered_buffers + 1;
 	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
-		return ublk_register_io_buf(cmd, ubq, io, index, issue_flags);
+		return ublk_register_io_buf(cmd, ub, ubq, io, index,
+					    issue_flags);
 
 	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
@@ -2354,11 +2356,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		/*
 		 * ublk_register_io_buf() accesses only the io's refcount,
 		 * so can be handled on any task
 		 */
 		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
-			return ublk_register_io_buf(cmd, ubq, io, addr,
+			return ublk_register_io_buf(cmd, ub, ubq, io, addr,
 						    issue_flags);
 
 		goto out;
 	}
 
@@ -2376,11 +2378,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_daemon_register_io_buf(cmd, ubq, io, addr,
+		return ublk_daemon_register_io_buf(cmd, ub, ubq, io, addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_check_commit_and_fetch(ubq, io, addr);
 		if (ret)
 			goto out;
-- 
2.45.2

