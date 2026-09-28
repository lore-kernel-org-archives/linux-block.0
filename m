Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1A488DB2
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586631; cv=none; b=WUfQoalWfZU2QGyZWpwMxcNOxMVAk6XMdtu/7Fm4V13XOXOHWZpnCsL6zjtxt46CoHkzVJ/FRLxOCD1JQoUr1CbmYQr6vZfym6/HwKV3HZWOEl7QIVpco5P0uVHV98BCLllHqSvQ7k3fB70vO02ucBEQVcY1PabmfNS7suB+iOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586631; c=relaxed/simple;
	bh=AARB+5bx7oBuBrgYQR/GZCScZeMPNlQR049a1iBJjrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AF+NnfMO4F9Gx7d1VYujms8DEVC3+nUG3OBwWLvh4B2TbeQ2qaD/xTc+VAWks5p+SobPOYnLH57Wd3fyum+8NyZz03j98ylomSk1VI1T0bomp8NjINzpAz4669ncAQ6AvCb3dPQxMgxgNi1XSMNSlwIMRj8dTrgxH1NDqiOcAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yb102SG9; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yb102SG9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790586623; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=50YzOCWxJCuuxTDYgTvpqjjeDO0mnxKHSiAGOOIZSbU=;
	b=yb102SG95HG2IoIW6QB4oeLFJ2TLwv59RvOcZqgLptAEG1JSMHjXKtOp8sKp+EdrgIpdD9gsoXtluUGbLf2k64v7Nn+Zc75NW71iF/myW31WZ7zCTqxi20PSkEO+BlxEDA5eKIe/txAXpuTCr5OPNoIUXCN0ASEis3csqKcr8+M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XBkcp3N_1790586622;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XBkcp3N_1790586622 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 17:10:23 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v2 2/2] nbd: fix NULL pointer dereference in nbd_pending_cmd_work()
Date: Mon, 28 Sep 2026 17:10:21 +0800
Message-Id: <20260928091021.2456652-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
References: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nbd_pending_cmd_work() turns nsock->pending into a nbd_cmd and an
nbd_device before it takes any lock:

	struct request *req = nsock->pending;
	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
	struct nbd_device *nbd = cmd->nbd;

nbd_mark_nsock_dead() clears ->pending, and it can run between
schedule_work() in nbd_sched_pending_work() and the work function
starting: recv_work() on a receive error, sock_shutdown(), or
nbd_xmit_timeout() giving up on some other command, as it defers to
this work function for the one that is partial sending.  Since
blk_mq_rq_to_pdu() is rq + 1, a NULL ->pending becomes a bogus pointer
and reading cmd->nbd oopses:

  BUG: kernel NULL pointer dereference, address: 0000000000000088
  Workqueue: events nbd_pending_cmd_work [nbd]
  RIP: 0010:nbd_pending_cmd_work+0x1b/0x120 [nbd]

The race was forced by clearing ->pending immediately before
schedule_work().  The address is sizeof(struct request), since nbd is
the first member of struct nbd_cmd and blk_mq_rq_to_pdu() is rq + 1.

cancel_work_sync() cannot close the window.  Every nbd_mark_nsock_dead()
caller holds nsock->tx_lock, nbd_xmit_timeout() holds cmd->lock as well,
and the work function takes cmd->lock before tx_lock.  There is also no
teardown point that could cancel it, since the work holds a config_refs
reference and nbd_config_put() therefore never reaches the code that
frees the socket while the work is queued.

Track the request in a field of its own that teardown does not clear, and
fail the request if the socket is gone by the time the work runs.  Its
header is already on the wire, so it cannot complete successfully.

Complete the request only once cmd->lock has been dropped.
blk_mq_complete_request() runs nbd_complete_rq() inline whenever
blk_mq_complete_request_remote() decides not to redirect it, and
nbd_complete_rq() ends the request without taking cmd->lock, so holding
that lock does not keep cmd alive.  Anything the work function still
writes in cmd afterwards can land in a request whose tag has already
been recycled.  The deadline branch had the same problem.

Complete it before dropping the config reference, not after.  If this is
the last one, nbd_config_put() tears the device down and nbd_put() runs
nbd_dev_remove() inline unless NBD_DESTROY_ON_DISCONNECT is set, so
del_gendisk() would wait in blk_mq_freeze_queue_wait() for the
q_usage_counter that this request holds until it is completed.

Clear partial_req under tx_lock, where nbd_sched_pending_work() writes
it.  cmd->lock is per-command, so clearing it after tx_lock is dropped
would race with a store from another command and could hand the freshly
armed work a NULL request to dereference.

Also make re-arming from inside the work loop a no-op rather than a second
schedule_work().  test_and_set_bit() tells the two cases apart, and the
loop re-reads nsock->sent on its next pass, so the resumed send continues
from where it stopped.  This removes the WARN_ON_ONCE that fired on that
path and avoids taking a second config reference for a work item that is
already running.

Tested with the race forced as above: the request completes with EIO
instead of oopsing, and a reconnect afterwards does clean O_DIRECT
reads and writes.  Also re-ran the partial send happy path (64
requests, 64 work invocations, no requeues), the deadline path, a
reconnect with 256 MiB of O_DIRECT writes and reads, and rmmod, all
with no oops, warning or leaked config reference.

Fixes: 8337b029f788 ("nbd: fix partial sending")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
v2: Complete before nbd_config_put() to avoid latent deadlock, suggested
    by sashiko

 drivers/block/nbd.c | 58 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c2c3dbdd631f..9909774dbfbb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -63,6 +63,7 @@ struct nbd_sock {
 	int fallback_index;
 	int cookie;
 	struct work_struct work;
+	struct request *partial_req;
 };
 
 struct recv_thread_args {
@@ -637,12 +638,24 @@ static void nbd_sched_pending_work(struct nbd_device *nbd,
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 
-	/* pending work should be scheduled only once */
-	WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));
-
 	nsock->pending = req;
 	nsock->sent = sent;
-	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
+
+	/*
+	 * Already armed: this is nbd_pending_cmd_work() re-entering because the
+	 * resumed send was interrupted again.  Its work is still running, so
+	 * just refresh the resume point above and let its loop pick it up
+	 * instead of taking another config reference and requeueing the work.
+	 */
+	if (test_and_set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
+		return;
+
+	/*
+	 * nbd_mark_nsock_dead() clears ->pending, so the work function cannot
+	 * rely on it to find the request it owns.  Keep a copy that only it
+	 * clears.
+	 */
+	nsock->partial_req = req;
 	refcount_inc(&nbd->config_refs);
 	schedule_work(&nsock->work);
 }
@@ -817,11 +830,12 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 static void nbd_pending_cmd_work(struct work_struct *work)
 {
 	struct nbd_sock *nsock = container_of(work, struct nbd_sock, work);
-	struct request *req = nsock->pending;
+	struct request *req = nsock->partial_req;
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
 	unsigned long deadline = READ_ONCE(req->deadline);
 	unsigned int wait_ms = 2;
+	bool complete = false;
 
 	mutex_lock(&cmd->lock);
 
@@ -830,6 +844,18 @@ static void nbd_pending_cmd_work(struct work_struct *work)
 		goto out;
 
 	mutex_lock(&nsock->tx_lock);
+	/*
+	 * nbd_mark_nsock_dead() can tear the socket down between schedule_work()
+	 * and here, and it clears ->pending and ->sent.  The header is already
+	 * on the wire so this request can never be answered; fail it rather than
+	 * resuming a send on a socket that is gone.
+	 */
+	if (!nsock->pending) {
+		cmd->status = BLK_STS_IOERR;
+		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+		complete = true;
+		goto unlock;
+	}
 	while (true) {
 		nbd_send_cmd(nbd, cmd, cmd->index);
 		if (!nsock->pending)
@@ -846,16 +872,36 @@ static void nbd_pending_cmd_work(struct work_struct *work)
 			 * nbd_handle_cmd() requeue every later request forever.
 			 */
 			nbd_mark_nsock_dead(nbd, nsock, 1);
-			blk_mq_complete_request(req);
+			complete = true;
 			break;
 		}
 		msleep(wait_ms);
 		wait_ms *= 2;
 	}
+unlock:
+	/*
+	 * nbd_sched_pending_work() writes partial_req under tx_lock, and
+	 * cmd->lock is per-command, so this has to be under tx_lock too.
+	 */
+	nsock->partial_req = NULL;
 	mutex_unlock(&nsock->tx_lock);
 	clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
 out:
 	mutex_unlock(&cmd->lock);
+
+	/*
+	 * Complete before nbd_config_put(): if this is the last config
+	 * reference, nbd_put() runs nbd_dev_remove() inline unless
+	 * NBD_DESTROY_ON_DISCONNECT is set, and del_gendisk() would then wait
+	 * in blk_mq_freeze_queue_wait() for the q_usage_counter that this
+	 * request holds until it is completed.  The config reference is what
+	 * keeps nbd itself alive across the completion, but cmd must not be
+	 * touched afterwards, since nbd_complete_rq() may run inline and ends
+	 * the request without taking cmd->lock.
+	 */
+	if (complete)
+		blk_mq_complete_request(req);
+
 	nbd_config_put(nbd);
 }
 
-- 
2.39.3

