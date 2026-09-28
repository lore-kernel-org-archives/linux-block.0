Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F848A8C8
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586632; cv=none; b=lHlPFGZ2ZyIRo/vk/0FxNygh/6ZToBNAKEh0K2ImsXisyFEcH6PtnNeKAhAqc8HxerTA8EFYwdPYAJ65IfbUwTj6IAzKOccQxecovqeJN06i0icCF7M2jNhpKwwSr7uftwP9QXCM70QUyWlok0IagDMSMhCTnTQPU74BM5SgJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586632; c=relaxed/simple;
	bh=MA6bIy1E25HEicgt4OV+3SH0EFpqWL7MFB/vEVKg5h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OknIaS6lhNv5Ntwj3s/9jWqjW68UREfA8gV3lyjyXW4IphN3zywGuCNzP2pm0OThAuP0+IQirp2VIEJJePoUpSzET6OdpfluCvCVCHud77Xdc6SCvQh0tsnAS4aeIE4MXur1k7T/yZPqr+anbmZivNqYajbX1ZNhRU7ARX8kEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C6dtnScN; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C6dtnScN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790586622; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=L2mpZblW46NK5z8PpQY1UAqcYsDp8oxMtRMfEQDOh2s=;
	b=C6dtnScNdiIGP1cHUI1Y9FLGq3aPRopIPu2Fg3UN7t3UjY/l1baIvIQhzqLaWnvQXR2GgrR+TnvCD3k4EeyV1c4KhStgfycUrwz3V8SJhyMWUwtTyvUQzS0HxbKkQ1H0xE9q7EHDHMqN6edZPySMhDq6CdUn/b/fTDD+mu74zbM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XBkcp35_1790586621;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XBkcp35_1790586621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 17:10:22 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v2 1/2] nbd: mark the socket dead when a partial send times out
Date: Mon, 28 Sep 2026 17:10:20 +0800
Message-Id: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nbd_pending_cmd_work() completes the request with BLK_STS_IOERR once its
retry loop passes req->deadline, but leaves nsock->pending set.  Nothing
else clears it: nbd_send_cmd() only does so at its out: label after a
complete send, and nbd_requeue_cmd() does not touch it.

Every later request on that socket then takes this branch in
nbd_handle_cmd():

	if (unlikely(nsock->pending && nsock->pending != req)) {
		nbd_requeue_cmd(cmd);

and is requeued again, forever, since the requeue path does not clear
->pending either.  If the tag is recycled first, ->pending matches the new
request instead and nbd_send_cmd() resumes it in place of the abandoned
one, skipping its header and leaving cmd_cookie alone.

Neither case leaves a usable socket.  The header went out and the rest of
the payload never will, so the stream no longer matches what the server
expects.  Mark the socket dead, which shuts it down and clears the partial
send state.  nbd_xmit_timeout() does the same for a timed out request and
only skips it here because NBD_CMD_PARTIAL_SEND makes it defer to this
work function.

Without this, a write issued after the deadline fires never completes and
the device has to be torn down to recover.

Reproduced by making the resumed send never progress, so the retry loop
runs out req->deadline.  With the socket marked dead a later request is
dispatched instead of requeued, and a reconnect afterwards does clean
O_DIRECT I/O with no oops or warning.

Fixes: 8337b029f788 ("nbd: fix partial sending")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..c2c3dbdd631f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -838,6 +838,14 @@ static void nbd_pending_cmd_work(struct work_struct *work)
 		/* don't bother timeout handler for partial sending */
 		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline) {
 			cmd->status = BLK_STS_IOERR;
+			/*
+			 * The header is on the wire but the rest of the payload
+			 * never will be, so the stream is out of sync with the
+			 * server.  Marking the socket dead also drops the stale
+			 * nsock->pending, which would otherwise make
+			 * nbd_handle_cmd() requeue every later request forever.
+			 */
+			nbd_mark_nsock_dead(nbd, nsock, 1);
 			blk_mq_complete_request(req);
 			break;
 		}
-- 
2.39.3

