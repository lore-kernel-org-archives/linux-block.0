Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54087451983
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580263; cv=none; b=l1gaAem53vdwQe2aWZIULN4FwpIPJ6Z6FLMC+FP5bq3ZNq3aXFpaFaxVGtaORtZD3kBSu7UuqQKmEFG1JwlPLEXiQ1DO+ySu5CmPCyHcrbfLhr4FSnw32MOcfrPmiimbnhj3fAZkJNV/rDblmKXUoLQLsUDB+puXIk1AyJjIcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580263; c=relaxed/simple;
	bh=MA6bIy1E25HEicgt4OV+3SH0EFpqWL7MFB/vEVKg5h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZ+vSCHVjPavQwl4o1eBErGuFh0JkBPdcWxbxVFLfQIB4wvaAgENRLuIo4175tKjRs+jAoyJ9fz5xTa4B/qtNWfDwSA9C0a3u0moNUnLM6ITg0LHs2p0eTUkWUk89IHKUnq7NdxzVdPUuqrrQV5AcNrfFrNbYSqOT+QWyA1efQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pjb/qke2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pjb/qke2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790580256; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=L2mpZblW46NK5z8PpQY1UAqcYsDp8oxMtRMfEQDOh2s=;
	b=pjb/qke2X28JujoRVDP8vmKp7PHPcTbHrbv4UelCU3xdQFwX3T/VzjQVCSoVCxMU+bNZiAWxTs4L4oigtOjAmn7wJSdkY30VnT4HcWsn8lL9O1NjOhHzN2K20P9hIB3iGlETGVY8jymMZ3AR/iI9WoR44m3gylQ08tzHFpKJBPk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XBk5eiv_1790580255;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XBk5eiv_1790580255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 15:24:16 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH 1/2] nbd: mark the socket dead when a partial send times out
Date: Mon, 28 Sep 2026 15:24:14 +0800
Message-Id: <20260928072415.2239692-1-joseph.qi@linux.alibaba.com>
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

