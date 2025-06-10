Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E128DEFD;
	Tue, 10 Jun 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553266; cv=none; b=amBFB8tldpJogZpW6CgJu/YyiXLl2LPVZvJ4DMOOqX/SD1MbFTMozo9bHHCGzxHqZU0VClGYoGp48v98al/9CMrW0cNL+gLRzEDxL/lFCyPd5/mTGO56z8Z4QwHCjLx4sM0Vo+QuVGu0QCxx0aqFUZf5cAtnArEt/YqFHrA+rH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553266; c=relaxed/simple;
	bh=bj9uORPBFKQmCBXHlGeWes/1XCM6rht+aJmn71UB9oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxFoupkZRl8NzkdazrefvrvSQiw9Sm9quyQOU9f4L5FhS9Ek8EqvGHULDT7JdIv8x62nNzkSNozcOQwveT+EQHn2iU/Ww/rdd4i6kjuuv7qxfqW0uooPx/C80bwDvWY2E54i48Ii+4mvtdN9VsSAIz6EtmLfSlmwtVzIrXUZZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=rD05dWhA; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="rD05dWhA"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1749553261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vo2Zyt9N71XXrlfkHINXeqxc3IbbEl+K1MiiDygVfoA=;
	b=rD05dWhANm9OTqpuJH3lQwF+whvZek3EPSJRgYLqb3tHk/P62dAXAwVqk7+2J2HKL0p0aB
	UcazLSGFlZVFC5QopSN6WOk/SKa3kndL0apJSx9GcBelM58b0LBU/Mkd9AG6WpIqAQMlyR
	c8g/18EW1L77VPYSGmQ1ZpBYQlSPp1Q=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Yuan Can <yuancan@huawei.com>,
	Chen Jun <chenjun102@huawei.com>
Subject: [PATCH 5.10] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
Date: Tue, 10 Jun 2025 14:00:59 +0300
Message-ID: <20250610110100.19025-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Jun <chenjun102@huawei.com>

commit 943f45b9399ed8b2b5190cbc797995edaa97f58f upstream.

There is a kmemleak caused by modprobe null_blk.ko

unreferenced object 0xffff8881acb1f000 (size 1024):
  comm "modprobe", pid 836, jiffies 4294971190 (age 27.068s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 00 53 99 9e ff ff ff ff  .........S......
  backtrace:
    [<000000004a10c249>] kmalloc_node_trace+0x22/0x60
    [<00000000648f7950>] blk_mq_alloc_and_init_hctx+0x289/0x350
    [<00000000af06de0e>] blk_mq_realloc_hw_ctxs+0x2fe/0x3d0
    [<00000000e00c1872>] blk_mq_init_allocated_queue+0x48c/0x1440
    [<00000000d16b4e68>] __blk_mq_alloc_disk+0xc8/0x1c0
    [<00000000d10c98c3>] 0xffffffffc450d69d
    [<00000000b9299f48>] 0xffffffffc4538392
    [<0000000061c39ed6>] do_one_initcall+0xd0/0x4f0
    [<00000000b389383b>] do_init_module+0x1a4/0x680
    [<0000000087cf3542>] load_module+0x6249/0x7110
    [<00000000beba61b8>] __do_sys_finit_module+0x140/0x200
    [<00000000fdcfff51>] do_syscall_64+0x35/0x80
    [<000000003c0f1f71>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

That is because q->ma_ops is set to NULL before blk_release_queue is
called.

blk_mq_init_queue_data
  blk_mq_init_allocated_queue
    blk_mq_realloc_hw_ctxs
      for (i = 0; i < set->nr_hw_queues; i++) {
        old_hctx = xa_load(&q->hctx_table, i);
        if (!blk_mq_alloc_and_init_hctx(.., i, ..))		[1]
          if (!old_hctx)
	    break;

      xa_for_each_start(&q->hctx_table, j, hctx, j)
        blk_mq_exit_hctx(q, set, hctx, j); 			[2]

    if (!q->nr_hw_queues)					[3]
      goto err_hctxs;

  err_exit:
      q->mq_ops = NULL;			  			[4]

  blk_put_queue
    blk_release_queue
      if (queue_is_mq(q))					[5]
        blk_mq_release(q);

[1]: blk_mq_alloc_and_init_hctx failed at i != 0.
[2]: The hctxs allocated by [1] are moved to q->unused_hctx_list and
will be cleaned up in blk_mq_release.
[3]: q->nr_hw_queues is 0.
[4]: Set q->mq_ops to NULL.
[5]: queue_is_mq returns false due to [4]. And blk_mq_release
will not be called. The hctxs in q->unused_hctx_list are leaked.

To fix it, call blk_release_queue in exception path.

Fixes: 2f8f1336a48b ("blk-mq: always free hctx after request queue is freed")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20221031031242.94107-1-chenjun102@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2022-49901
Link: https://nvd.nist.gov/vuln/detail/CVE-2022-49901
---
 block/blk-mq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21531aa163cb..6dd1398d0301 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3335,9 +3335,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return q;
 
 err_hctxs:
-	kfree(q->queue_hw_ctx);
-	q->nr_hw_queues = 0;
-	blk_mq_sysfs_deinit(q);
+	blk_mq_release(q);
+
 err_poll:
 	blk_stat_free_callback(q->poll_cb);
 	q->poll_cb = NULL;
-- 
2.43.0

