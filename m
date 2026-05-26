Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3593CC7CD
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796711; cv=none; b=Qiet9BV/qavfdDjv6c56p4Suh+ElKNG39hrMFarAkFKnTC6LhmzjAB8lbIybhSSMlyH6JMoWQt8aXfT0TTare5lAJkTVGGa7LFkMOQ1QGvs3nLXHiwGUXBKFKYVpEdC0KzaAF4R1jcSzQjNBeovJZnugD6RtKedeXuaX5I+uOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796711; c=relaxed/simple;
	bh=mhQjryT/CtM8JIpLTqD9zXVgGOvZ1KzjwXEmwd9gt+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bod/pbQSGsx3P/KNS4KKDIqjV/vcjOiZuRwpp3V/qGooub9IMs3c/DvnJc4Xbou20ANsYb630Og0uGnrIw+u+Exf5A2nvkBCwLDR4HzlcIDWlGsrZ559XRnnTMb2lr4MYvjThHxzc/6QborjrCkCyu85gHXwh2O3wiRvFkdWg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gPrpX3yyZzYQv6N
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 19:57:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 23E6B40539
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 19:58:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgC3f1vTihVqw3fQDg--.30881S4;
	Tue, 26 May 2026 19:58:16 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH] Revert "nbd: freeze the queue while we're adding connections"
Date: Tue, 26 May 2026 19:52:52 +0800
Message-ID: <20260526115253.746625-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3f1vTihVqw3fQDg--.30881S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy3tw1rAFWrJryDXry7Jrb_yoW5ZF48pF
	W3Gay7Gr4jvF48urs5ZayxXFyfAwnxK347W3y7J34SvrsxCa4Fva4IyayrWFy8JrWqqr47
	ZrW5Kw4vyw1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY64kExVAv
	wVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUz3kuDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

This reverts commit b98e762e3d71e893b221f871825dc64694cfb258.

Commit b98e762e3d71 ("nbd: freeze the queue while we're adding
connections") added blk_mq_freeze_queue/blk_mq_unfreeze_queue in
nbd_add_socket() to protect krealloc(config->socks) from concurrent I/O
that could cause a Use-After-Free.

However, analysis shows that in all current code paths, concurrent I/O
cannot actually reach nbd_add_socket():

1. nbd_genl_connect() path:
   nbd_add_socket() is called first, and nbd_start_device() -- which
   starts the queue and enables I/O -- is called only after all sockets
   have been added. So the freeze/unfreeze runs against an idle queue,
   marking then waiting on a percpu_ref that is already zero, and then
   resurrecting it -- a pure no-op that burns an RCU grace period per
   socket on multi-core systems.

2. nbd_ioctl(NBD_SET_SOCK) path:
   The task_setup check enforces that only the thread which performed
   the first NBD_SET_SOCK can call NBD_SET_SOCK again. That thread is
   blocked in NBD_DO_IT's wait_event_interruptible, so it cannot issue
   another NBD_SET_SOCK concurrently with I/O. Other threads are
   rejected by the task_setup != current check.

3. nbd_genl_reconfigure() does not call nbd_add_socket() at all; it
   uses nbd_reconnect_socket() which replaces a dead socket in-place
   without reallocating config->socks.

Therefore the freeze/unfreeze provides no actual protection in any
reachable code path, while imposing the cost of blk_mq_freeze_queue
(percpu_ref_kill + RCU grace period wait + percpu_ref_resurrect) on
every socket addition during device setup[1].

Revert the change to eliminate the unnecessary overhead.

Link: https://lore.kernel.org/all/20260327091223.4147956-1-leo.lilong@huaweicloud.com/ [1]
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d..9033d996c9a9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1245,22 +1245,16 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
-	unsigned int memflags;
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
 	if (arg > INT_MAX)
 		return -EINVAL;
+
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
 
-	/*
-	 * We need to make sure we don't get any errant requests while we're
-	 * reallocating the ->socks array.
-	 */
-	memflags = blk_mq_freeze_queue(nbd->disk->queue);
-
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
 		nbd->task_setup = current;
@@ -1300,12 +1294,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
-	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
-
 	return 0;
 
 put_socket:
-	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 	sockfd_put(sock);
 	return err;
 }
-- 
2.52.0

