Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B5370AD5
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887429; cv=none; b=u5Vi4Lm6M3Aqyy3wIBhszj62ngdFtGcqVzidQ2+sMbinnH/5xrMS7GvRo+sO8Nyuf5XlNwlsyaj2I+eAT5C68ckUAEiUyal0Eu9LpGT+bU64lfnGdN3G/mqfuTeM+Nv2MnUtX6fdaR9rvuzN6HG3/QtU/hRIBRH4wHKeZH8t8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887429; c=relaxed/simple;
	bh=U/+FDvvGx/uY20Rd05tJux8xUhNWj4u4aJamozobyuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h53VWMYZa28NI6D2sXgqC8nS7qvYslXx5uCC0ACJF2FRgRogq4vzCuctF4Jr4LTkt79ydeM1Ll1SCrbTtdPl8Wu/55Ajocqy32Re52e9IwJ4OGB1qqOpWubRybw4nGsMsiM8quYxgmDOAgrDNS0e7sySPmj1KsVMzEvRwGb5o+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oZU8yv+O; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oZU8yv+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/B
	1PjG4410+CxkG/geZhvV6BzkAhNhJSEYFJ2VjTLVU=; b=oZU8yv+OA8ic/RAA/8
	aU6BkZ9aCfzZO9mwxRZKPkUmQ6LC56cemWfy7gjmJeMLfcLQYWWGuq8e7w+gvi1V
	dMIVl6A+cFUbImeM/FJJi38tvDN6WQkzWA6DXLxCIpvVTLty6c35YODRPeb3HV/d
	nnQARe5HshO8u5cnM2q4UqUAQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnb6VxOGNq42bKKw--.58003S2;
	Fri, 24 Jul 2026 18:03:30 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] ublk: configure io buffer before taking uring_cmd
Date: Fri, 24 Jul 2026 18:03:27 +0800
Message-Id: <20260724100327.43482-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb6VxOGNq42bKKw--.58003S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfCF4ktr4fZry7uFyxAFb_yoW8CF43pF
	45u34jkFy8WF4fXF4UA397Xa4Yg3yxCayUCrWS9w1S9r15ArZIvFW7KF45JFWxtrW8XF15
	XF40yF18GF47CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UR89_UUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwhKdLmpjOHLlQgAA3H

With UBLK_F_AUTO_BUF_REG, ublk_config_io_buf() may fail on invalid
auto buffer register data in sqe->addr. Calling ublk_fill_io_cmd()
first leaves UBLK_IO_FLAG_ACTIVE set while io_uring has already
completed the uring_cmd. The tag can no longer be fetched, and
device teardown may hang or complete a stale command.

Fixes: 52460dda3a77 ("ublk: move auto buffer register handling into one dedicated helper")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/block/ublk_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c2c11f2a01e7..d932a4026031 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3295,9 +3295,9 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
 	 */
 	mutex_lock(&ub->mutex);
-	ret = __ublk_fetch(cmd, ub, io, q_id);
+	ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
 	if (!ret)
-		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
+		ret = __ublk_fetch(cmd, ub, io, q_id);
 	if (!ret)
 		ublk_mark_io_ready(ub, q_id, io);
 	mutex_unlock(&ub->mutex);
@@ -3447,19 +3447,18 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
-		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
+		if (ret)
+			goto out;
+		req = ublk_fill_io_cmd(io, cmd);
 		compl = ublk_need_complete_req(ub, io);
 
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
 			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
-
-		if (ret)
-			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		/*
-- 
2.25.1

