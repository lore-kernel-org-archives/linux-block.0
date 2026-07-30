Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC41624C0
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373813; cv=none; b=I5eW3k78No4WbLWDUtSijzXhWzkAptZrGSUK/jKcFiBW0cA2iIPUQ3VQadF6k5ENR6cak4VN2OofqkQnbxbfG38IKTwjlZ24Sga+UtwipRiflofQkb6APhtLOAAaieHZ+di4QKifzsADCsMuHnCqtjaACkmYowAO7B+em4xablQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373813; c=relaxed/simple;
	bh=TSnZz0bKjMoWHAJkZX98EvTyZQizRsXuN6HnT3HxbK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOnCLeFeow/aZuApoFnJnY4/GhpfjT5P03WRtrLsl2cg5r641v7/0STXjlOBOFN/PyMTYewbDJLZwVxuk4sl3O/1eaK/t8SjrMH2O0SHefCcgXZnOl8djOnljHJVZz9iF7Htc4RyiPJWN+2wQI9nPH6v48Er3Yx08Kzs1HzR4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DNe988TU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DNe988TU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mg
	+AQ2nu/1KfnOJ4EtgcF48N3V7fRNamVv5vQ1q1+wY=; b=DNe988TUI31k3o1Q1/
	Qa4LQZMAf51laDtKWM7lPabznyP9zRwBSLicaJO38crQKMgPdPYo+YhhbuYL54VR
	YgKTv/iLs5rQLHfHC11KkBdzb7Bhg7TOpWOwJ7JfLWpKvLX4KmIY6mBZXZ3AZkFX
	hxS1Wbok5VGlYev4AiCDz2GLs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3hJo4pGpqNlSGKQ--.42512S4;
	Thu, 30 Jul 2026 09:09:16 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v2 2/2] ublk: clear auto buf reg before updating io->buf in batch commit
Date: Thu, 30 Jul 2026 09:09:10 +0800
Message-Id: <20260730010910.799346-3-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
References: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3hJo4pGpqNlSGKQ--.42512S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruryUXr15GF43AF47JF4kCrg_yoWDZFgEgr
	n2qan7Zwn5CFnxCw1UuFnIvF9aya1ruF4furWYqay3KrW7XFnI9F1DXry3WFn5WF4fCF98
	Cw47Jrs0vw1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnIks3UUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6hxt-WpqpDwjHAAA3B

ublk_batch_commit_io() stored the new auto_buf into io->buf before
calling ublk_clear_auto_buf_reg(). Clear takes the unregister index
from io->buf.auto_reg, so it could drop the new slot and leave the
old registered buffer behind.

Fixes: 1e500e106d5a ("ublk: handle UBLK_U_IO_COMMIT_IO_CMDS")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 041bd3ea023f..e12bc4ee74d3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3782,11 +3782,11 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
 	ret = ublk_batch_commit_io_check(ubq, io, &buf);
 	if (!ret) {
 		io->res = elem->result;
-		io->buf = buf;
 		req = ublk_fill_io_cmd(io, data->cmd);
 
 		if (auto_reg)
 			ublk_clear_auto_buf_reg(io, data->cmd, &buf_idx);
+		io->buf = buf;
 		compl = ublk_need_complete_req(data->ub, io);
 	}
 	ublk_io_unlock(io);
-- 
2.25.1

