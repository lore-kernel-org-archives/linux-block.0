Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52F37D110
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571849; cv=none; b=F/StW/4QF7klJiEkmJNF9pF7CKKZazccSQzrNheHNV4H+6+oF84Ul58/1w3QfOhoIy1ImgvHYh5rJR51A2EIMwJtOm8WyKjrU9nbuXEMJCXGuidvj7Zh2g9iZHsX9JRnmyZNcrPtHp98cYzWLp10wuEzC5IZAg2E1ABDhrR/Tiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571849; c=relaxed/simple;
	bh=slyV1DL16N0zVbYjgRIaEWYyIsThlwqkb40ZgMq0yko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CdLwqE0lUAvr8tsSpsw3f5nVDh5d1IYzJblUSOZ3PEgdjBQMGNAJATZu/EX//mn6BXzkEireG6xkbV8Cw9fPNPYqb5vnTzpuCJNzNJ5RduDX1muc7nx0NT0wG3Pss9EvZQqJ9Pw0iq66Z+QCBlgDdJfb8LtVGWTG+XlJK/PGkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FVZ+U3Tu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FVZ+U3Tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SJ
	DUdfHT9xELjpVIvNEFUPlIkzCdc1LmsEBU90e5+u8=; b=FVZ+U3Tuop73PR7GAS
	EKDd4X4D101lG2Rpb95unbAC/l5Dc/yKgK4N3a77MICdMPpfp3+DC2XhSRRt+JdY
	SwhD9d3kLJNThkSFN+TDha8VVZRKHKBybrjzo88HyJH/44/kypcqTNT8auQrfzY9
	wljlEhUuB8V4DFmQTvgqwktQU=
Received: from hh.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXHxDtsqpql2XRQQ--.42685S2;
	Wed, 16 Sep 2026 23:17:02 +0800 (CST)
From: huhai <15815827059@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Henry Hu <huhai@kylinos.cn>
Subject: [PATCH] blk-mq: check passthrough state before reusing cached requests
Date: Wed, 16 Sep 2026 23:16:55 +0800
Message-Id: <20260916151655.2588-1-15815827059@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXHxDtsqpql2XRQQ--.42685S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyfCFyUGw4fGFWxKFykXwb_yoW5Xw48pr
	WYqayqvr409F1IqF40yFWUXFyrKr45CF1xJrZ5C34YvF95GrsFkFyIqr10qFySy393CrWx
	uFs5A3yDZF4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD739UUUUU=
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbC7w8tsmqqsu9bmwAA3i

From: Henry Hu <huhai@kylinos.cn>

blk_mq_alloc_request() and blk_mq_submit_bio() share plug->cached_rqs,
but neither lookup checks the passthrough state. This allows an io_uring
batch to reuse a cached NVMe passthrough request for an ordinary bio.

When an I/O scheduler is enabled, passthrough requests have RQF_SCHED_TAGS
set but RQF_USE_SCHED clear, and skip ->prepare_request(). Reuse updates
rq->cmd_flags without reinitializing the scheduler state, so the request
is inserted into the scheduler on plug flush, while completion skips
->finish_request(). With kyber, this leaks the domain token acquired at
dispatch and can stall further I/O in that domain.

This was reproduced with kyber and request merging disabled on a QEMU
NVMe device by submitting a passthrough read followed by O_DIRECT writes
in one io_uring batch. Tokens leak until the kyber write-domain token pool
is exhausted, blocking ext4 journal I/O and fsync():

  INFO: task jbd2/nvme0n1-8:97 blocked in I/O wait for more than 241 seconds.
    Call Trace:
      schedule+0xe9/0x300
      io_schedule+0xca/0x150
      bit_wait_io+0x1b/0x140
      __wait_on_bit+0x63/0x170
      jbd2_write_superblock+0x3d7/0x600
      jbd2_journal_update_sb_log_tail+0x1e3/0x2d0
      jbd2_journal_commit_transaction+0x11d1/0x5b50

  INFO: task fsynctest:107 blocked in I/O wait for more than 241 seconds.
    Call Trace:
      schedule+0xe9/0x300
      io_schedule+0xca/0x150
      folio_wait_bit_common+0x2ed/0x780
      folio_wait_bit+0x18/0x30
      folio_wait_writeback+0x4b/0x1e0
      __filemap_fdatawait_range+0x120/0x1e0
      file_write_and_wait_range+0xeb/0x130
      ext4_sync_file+0x368/0xa80
      do_fsync+0xa2/0x200

Require the passthrough state to match before reusing a cached request.
With the fix, the workload completes normally.

Assisted-by: LLM
Signed-off-by: Henry Hu <huhai@kylinos.cn>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..3a9d57f6a569 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -648,6 +648,8 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 			return NULL;
 		if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
 			return NULL;
+		if (blk_rq_is_passthrough(rq) != blk_op_is_passthrough(opf))
+			return NULL;
 
 		rq_list_pop(&plug->cached_rqs);
 		blk_mq_rq_time_init(rq, blk_time_get_ns());
@@ -3062,6 +3064,8 @@ static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
 		return NULL;
 	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
 		return NULL;
+	if (blk_rq_is_passthrough(rq) != blk_op_is_passthrough(opf))
+		return NULL;
 	rq_list_pop(&plug->cached_rqs);
 	return rq;
 }
-- 
2.25.1

