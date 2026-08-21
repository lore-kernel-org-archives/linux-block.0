Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8873D0919;
	Fri, 21 Aug 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308285; cv=none; b=ETsWw0L4Z3uiwEcaRz862W67nd5q8j+1q5f1vg4leVMlt15qSSF4dm1MdTvGY1BP18UvemF3t6jPxVUfyz0/ID9CNWNARarb1xYj16+6W7nxMxqWlw64DjFVRS4HIEwZjVYTjg/mutK9wbNi79dCkjbGMzFvfAgSDGWoHxCi5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308285; c=relaxed/simple;
	bh=JjDrGsasVTwvKcsODVUNte54IK6uKoZF+jIbrYoDpDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPIwPPoVOg/BEeD6b0OFOiMJBDSubfZuaEK4JVuUvlI2CXadI3c1ljmfU0/dGzlgsYwI0B42J5DHkPd77Mf5ROiiyDz6QA1u01zkYMG0sF/WlaV6MokJTE+OYfx6x1meM/vXQJo1LaXVH4x/p+leV7+945QhruuP1ToeBpcpuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qXAp3j4M; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qXAp3j4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WL
	0QGpoNPCGOf3+VvUvGNLLASQzajHjy5bEmYBIxAlM=; b=qXAp3j4MALgUhinUjB
	8GwWogBfIy/cI8NdQzUxDPeB8csGdBqFGcjYYx1T23pTQjsZNEGcWUdaaftUvy1i
	J66Rsa+RzPPLCeOmTSkuXeYhUEIM9Tn3cmqTOZwhKy8yMs7tg1DIyQKmFa6U9xz6
	OoQp80hpxDwGZLJ6g4OtRkZB4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnZ5fZKIhq2WaORA--.42749S3;
	Fri, 21 Aug 2026 18:30:52 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: tom.leiming@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH 1/2] ublk: clear force_abort in ublk_queue_reset_io_flags()
Date: Fri, 21 Aug 2026 18:30:46 +0800
Message-Id: <20260821103047.369522-2-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
References: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnZ5fZKIhq2WaORA--.42749S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw18Cr1fWr1rGFyfJr1kXwb_yoW3uwc_Cr
	1rXF4DWr92kF4Ykw1jkF90vr90kr10gF1rXFWxt39agry7ZFyaqw4UXw15WF1UXayYkF13
	Aw17Jr4Ykr4xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8XyCJUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6Rz9jmqIKNyXGQAA3e

Quiesce sets ubq->force_abort for batch I/O. Recovery never clears
it, so batch fetch keeps failing with -ENODEV and the device stays
QUIESCED.

Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/block/ublk_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4d17ed264da1..1a95642b9db9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3024,6 +3024,7 @@ static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
 	ubq->canceling = false;
 	spin_unlock(&ubq->cancel_lock);
 	ubq->fail_io = false;
+	ubq->force_abort = false;
 }
 
 /* device can only be started after all IOs are ready */
-- 
2.25.1

