Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9871B4F1F
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666505; cv=none; b=gat8vazs7tqte9etJjwCKi4WQ+FrCPaOuDzsBSSYE4mkqYuTtpnp9jMTheLmoce11gsoCr1pEJjJWzlufKdkQGvcO3khGNO1ZlyjoSTkMfPAhY1F8vJbFNWmTfulAu7vKNF2e7an1/1jCZ/PT24sbaWcr57kCJRpyDSMmr76760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666505; c=relaxed/simple;
	bh=NuUmjLMUtcYAS9vmKwhz97jTzyTkA2wkRihWiH1GgHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVuPwjrbXN3JvdhIYGz3K+MS0bUfxqnogxB0R42XcmhTlT2SDiKH5Qpj7bZV5yf3BRV87oEbKuolZ+hZafzIvQYn1dJcv9dFdhua/dKULcqH478hL44hU3Q8gRf51jjf8kITiQzqJG/vucbR1moLcfvpoBlm44+JszApJCD36g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfxGt2gY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfxGt2gY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752666502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DR20ExHE6uIl9noYL+gPHlfASsbJtMBDIWvVan4s0IU=;
	b=BfxGt2gY2YpiqrIUnXRe1IzXNLSfEYjWqUiRNBd/P74SaUsgyI677M/C0iBAtShK7r7wYx
	Ad5War2Nrg9GVA+oCKWv0x4XNRP3oxwhAvLunvzzGOiNBTDP+Fgfo27EOUulfcrrnxbCKK
	L/9UgpYXU/d1bGglV+EsrbsMnx0ndHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-TuzIw2VNPF60aToc_Bg1-A-1; Wed,
 16 Jul 2025 07:48:19 -0400
X-MC-Unique: TuzIw2VNPF60aToc_Bg1-A-1
X-Mimecast-MFC-AGG-ID: TuzIw2VNPF60aToc_Bg1-A_1752666497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E0B11800282;
	Wed, 16 Jul 2025 11:48:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B737180049D;
	Wed, 16 Jul 2025 11:48:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] loop: use kiocb helpers to fix lockdep warning
Date: Wed, 16 Jul 2025 19:48:08 +0800
Message-ID: <20250716114808.3159657-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The lockdep tool can report a circular lock dependency warning in the loop
driver's AIO read/write path:

```
[ 6540.587728] kworker/u96:5/72779 is trying to acquire lock:
[ 6540.593856] ff110001b5968440 (sb_writers#9){.+.+}-{0:0}, at: loop_process_work+0x11a/0xf70 [loop]
[ 6540.603786]
[ 6540.603786] but task is already holding lock:
[ 6540.610291] ff110001b5968440 (sb_writers#9){.+.+}-{0:0}, at: loop_process_work+0x11a/0xf70 [loop]
[ 6540.620210]
[ 6540.620210] other info that might help us debug this:
[ 6540.627499]  Possible unsafe locking scenario:
[ 6540.627499]
[ 6540.634110]        CPU0
[ 6540.636841]        ----
[ 6540.639574]   lock(sb_writers#9);
[ 6540.643281]   lock(sb_writers#9);
[ 6540.646988]
[ 6540.646988]  *** DEADLOCK ***
```

This patch fixes the issue by using the AIO-specific helpers
`kiocb_start_write()` and `kiocb_end_write()`. These functions are
designed to be used with a `kiocb` and manage write sequencing
correctly for asynchronous I/O without introducing the problematic
lock dependency.

The `kiocb` is already part of the `loop_cmd` struct, so this change
also simplifies the completion function `lo_rw_aio_do_completion()` by
using the `iocb` from the `cmd` struct directly, instead of retrieving
the loop device from the request queue.

Fixes: 39d86db34e41 ("loop: add file_start_write() and file_end_write()")
Cc: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 500840e4a74e..8d994cae3b83 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -308,14 +308,13 @@ static void lo_complete_rq(struct request *rq)
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct loop_device *lo = rq->q->queuedata;
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
 	if (req_op(rq) == REQ_OP_WRITE)
-		file_end_write(lo->lo_backing_file);
+		kiocb_end_write(&cmd->iocb);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -391,7 +390,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 
 	if (rw == ITER_SOURCE) {
-		file_start_write(lo->lo_backing_file);
+		kiocb_start_write(&cmd->iocb);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	} else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
-- 
2.50.1

