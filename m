Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4526B2DF
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465994; cv=none; b=SZ0lBaOly2CZm/2CL7wxc0RcweqQ7JQNNi7++RZB8usUoWf1+4I50++xyPJ/SUdSpb6aAoTKi0uQzW6iOW0HWNdn4BgPRpJQRDqHN6cTRrTGYiCwqEiC6sn/uO2k241f4ld/9qub3+iQfSfdjqFroFBEC6rZ5G7Q7MQk/2ACHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465994; c=relaxed/simple;
	bh=aODsyg3joXcQ287FoVhkIV5aJfVBMDhrX2MPoMsF9/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWgE7MmOnOHtDWb7ErcMkj5KnnEchgdONnB34AJktfZw3ItaAzAgASCCIeUJfRjW6IwK+hdrB4VhY22njua5dzp3/yoF/L+0vOI56bGoKXwvKrdk1IWseyLBQY4ckFg8NFhZjj+ag+y6mj+A1Ue93k2iS7ALJ24S1GxNUeyrfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GbKWrNHz; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GbKWrNHz"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7087349ce74so1791867b3.3
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746465991; x=1747070791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDBk+OYzCApSnK8VVZgyIgA3ncZhmRQ/48wNK7Y0ijk=;
        b=GbKWrNHzT5fOlzhH4jPGQXmfFjRfiWXRy59ev1xoqxCppbyi8GibE+zJcxyLeZXoIM
         MiqJt4b59XkuZvrmywTbQk0UT2C/hJ4A6o8y8yUSAX+FpaQOpct7UppFRzejtPy836I3
         tUUtvxiJF4KWhqD5V27jjxACWBypiU30O/+iX21UIr0EXro2aN+zSUFjfwIfgZTSOoHU
         6dI6FCLy1mwNUkQtPHI9bTjlSc0ySERArgUFBw5Ll53jhPtXGpKIPQT9GD4EnXoILd5G
         Ty+0A3Mpclxtgd2ewYJ/9eM2XEBt0qVA8ah4lKeQ9pTyn8ExHVJt9tyS5xodUUJfAadB
         jTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465991; x=1747070791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDBk+OYzCApSnK8VVZgyIgA3ncZhmRQ/48wNK7Y0ijk=;
        b=k6/sa+VYuCttcKWblPmT14yGPk3sz6mSdh8xFp0N6LmaChZRiLRfT3SHqKwPgcA/lx
         alLmT+5mwpqA5mTNjIe8i81yh9M+95As6p1eQly+2dqMV9EN237uOeV6zOl3BmsqS+pG
         nlm2+UoOn5QeqVTxW+gIK8M2yjEiKHQ2jD1AoJvN06slAej9Afh4LvqiLF6VsziyyueJ
         odLAV9naF2h8+lcYHnzt4ONfXKXbQy0X1wAu3ihX/jz9GOhxG5B5wkJS9fGxp1u5Jxe4
         eg/G/OWt8BKoEcWW8F1/QYKPUjNNJUblBMGOUOHguB6wKKM844Ri3qHHb1Pd/2oQ7+Jv
         mkig==
X-Forwarded-Encrypted: i=1; AJvYcCUaZb01XlSBROfGJ62NSb6sT8Fr6cgd1czguhuUIG6xCJpkK83y2CBhWNPWsGpXjagKRzSVGhcYIopH7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LDYDcc4cVaiSDSp/jTFSz+J2SnE7kdyCAQKr4M1v1wCDTEW4
	IF/vA+wE1sGYgSYE8gTZYRU0uCgakG7mNMtUVdEz1MGqfOcBQxXs9n4y0BFnJwjtvJL+25E1ehs
	lQ8zqU4Uv7utxYyR/JijS8yfM2kRy2lrjPubwOibpUxu0CPU1
X-Gm-Gg: ASbGncs4X4vPkj6GGzBUpEvIN9lFxdzVRIMe5TrcZqVmSbkVThxpgNPWpLMujUrFj93
	71JnjEZb9QQLJztgBu3u+5sMiQE/IPuxQPSwRX1BWt2sWgAtFfPr9t9TuNnBiDQm1NSLTMT69V+
	AhX+I2rXACvtV1nBuZozGaY2upaNZt09DHf5mARntKTxE5YwIvMggBHPMFqRVlcyu2RvQcKAGbM
	rg5sIrede7e5UWnDupady03tlSGsRnFlEYeaQ4YPRxkJQTM1b2Hp9gm/D1R1vxPFgR8ruDIJrgn
	fENuHlAzK5bch5JJ2N+sMlmTBjystA==
X-Google-Smtp-Source: AGHT+IF8JQQZ9iJZET0yqNKPYRUGBpoq1VA7CgS5xHctkCNPAgyxmvjK72Iq3Quz/EaHkhR44JzXhXdmNEo9
X-Received: by 2002:a05:690c:7108:b0:6ff:8418:5afb with SMTP id 00721157ae682-708cedf5b65mr78859887b3.5.1746465990790;
        Mon, 05 May 2025 10:26:30 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-708c46f219csm20088657b3.60.2025.05.05.10.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:26:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2FBB2340350;
	Mon,  5 May 2025 11:26:30 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 29BA6E41993; Mon,  5 May 2025 11:26:30 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ublk: consolidate UBLK_IO_FLAG_OWNED_BY_SRV checks
Date: Mon,  5 May 2025 11:26:23 -0600
Message-ID: <20250505172624.1121839-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every ublk I/O command except UBLK_IO_FETCH_REQ checks that the ublk_io
has UBLK_IO_FLAG_OWNED_BY_SRV set. Consolidate the separate checks into
a single one in __ublk_ch_uring_cmd(), analogous to those for
UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_NEED_GET_DATA.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
v2: rebase

 drivers/block/ublk_drv.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2c8f28c0d0a1..3650bab40dd0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1924,20 +1924,16 @@ static void ublk_io_release(void *priv)
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				const struct ublk_queue *ubq, unsigned int tag,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
-	const struct ublk_io *io = &ubq->ios[tag];
 	struct request *req;
 	int ret;
 
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
 
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		return -EINVAL;
-
 	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
@@ -1949,21 +1945,16 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 	return 0;
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
-				  const struct ublk_queue *ubq, unsigned int tag,
+				  const struct ublk_queue *ubq,
 				  unsigned int index, unsigned int issue_flags)
 {
-	const struct ublk_io *io = &ubq->ios[tag];
-
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
 
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		return -EINVAL;
-
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		      struct ublk_io *io, __u64 buf_addr)
@@ -2013,16 +2004,12 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
 static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 				 struct ublk_io *io, struct io_uring_cmd *cmd,
 				 const struct ublksrv_io_cmd *ub_cmd)
 {
-	struct request *req;
-
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		return -EINVAL;
+	struct request *req = io->req;
 
-	req = io->req;
 	if (ublk_need_map_io(ubq)) {
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 		 * NEED GET DATA is not enabled or it is Read IO.
 		 */
@@ -2102,10 +2089,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
+	/* only UBLK_IO_FETCH_REQ is allowed if io is not OWNED_BY_SRV */
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) &&
+	    _IOC_NR(cmd_op) != UBLK_IO_FETCH_REQ)
+		goto out;
+
 	/*
 	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
 	 */
 	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
@@ -2119,11 +2111,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
+		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
 			goto out;
 		break;
@@ -2131,12 +2123,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
 		if (ret)
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
 		io->addr = ub_cmd->addr;
 		if (!ublk_get_data(ubq, io))
 			return -EIOCBQUEUED;
 
 		return UBLK_IO_RES_OK;
-- 
2.45.2

