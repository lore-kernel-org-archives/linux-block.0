Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBE3064B5;
	Tue,  2 Jun 2026 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379214; cv=none; b=kUd46xDyS32iDGvz9NXA4EdiKpI/Sgj9RdsQuZ8az5IaASZbnndmivY8u0CFwMNAhzeIkecrbKnN+dcIKNNC/WRAyrYRpogvo/eP4A27Yi2L66uSSthTt2+dfeetc8Re3Qez1xMWybvluDoQeQPms1DzbLJoc0f3hKH6lGUjPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379214; c=relaxed/simple;
	bh=1zAqYg60GAZgU4KKXvACIRybU0aAzPr4a/WkAX8AOak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppl9QS2txJQB/tLBwQp5Q0ZXLbczwXK4XDmybIZ7pvtLHHlla8XQCk/wuXFZMuY1H2J1n+WAFpUorL0hcPR0xU1Ou6BQ+C0JzAPZzS/2qlTI85QzfeQsdzkfvizqkEcP7NoNBTGPwqfi17kpUF793Lr4Hh9ytvMysG6bkVMkyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2ho+sF/d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ho+sF/d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QU8vL5BYsgr14/B5ViSJNohvg+HvTPRDGcs97wxt6N4=; b=2ho+sF/dXbdRWYOPg7dh8Z77vx
	IbJgqTikKNRmyPyzI/GI96CMlSXMAunHx4P2s/DrMdKfhOe1sBAQnHVyhnIRjBDtHOIQVjSoUljSQ
	EBZlloKyAkFs7QyUkmBcIUjZiqxfixC3m4BuRJiSmUHmPCZeBlhqeEh7IKU1KqxEKvnvItSigZPdH
	F3etd5PDsXElIBZUzIz3m+Dd8ZWIxdBcCaR1YqQhRxbtLkC7cCjK2BLYxS2fA/Q59zSJJCQWi/wbc
	GIvXM20oiTJKM+UouN7BHummWuPCthfsW4+4K5FRLNMmfD2Kl3/RJfBD3FZieeU8+NtpaBnHT017B
	LrvX/oaQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxj-0000000CLCN-2pey;
	Tue, 02 Jun 2026 05:46:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 9/9] block: move the fail request code
Date: Tue,  2 Jun 2026 07:45:41 +0200
Message-ID: <20260602054615.3788425-10-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Keep all error injection in one place, and out of line for the main
I/O submission fast path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c        | 37 ++-----------------------------------
 block/error-injection.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 04a392849ab0..7465dd291272 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -29,7 +29,6 @@
 #include <linux/swap.h>
 #include <linux/writeback.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/fault-inject.h>
 #include <linux/list_sort.h>
 #include <linux/delay.h>
 #include <linux/ratelimit.h>
@@ -534,32 +533,6 @@ bool blk_get_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_get_queue);
 
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-
-static DECLARE_FAULT_ATTR(fail_make_request);
-
-static int __init setup_fail_make_request(char *str)
-{
-	return setup_fault_attr(&fail_make_request, str);
-}
-__setup("fail_make_request=", setup_fail_make_request);
-
-bool should_fail_request(unsigned int bytes)
-{
-	return should_fail(&fail_make_request, bytes);
-}
-
-static int __init fail_make_request_debugfs(void)
-{
-	struct dentry *dir = fault_create_debugfs_attr("fail_make_request",
-						NULL, &fail_make_request);
-
-	return PTR_ERR_OR_ZERO(dir);
-}
-
-late_initcall(fail_make_request_debugfs);
-#endif /* CONFIG_FAIL_MAKE_REQUEST */
-
 static inline void bio_check_ro(struct bio *bio)
 {
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
@@ -764,14 +737,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 
 void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
-	if (unlikely(may_fail_bio(bio))) {
-		if (blk_error_inject(bio))
-			return;
-		if (should_fail_request(bio->bi_iter.bi_size)) {
-			bio_io_error(bio);
-			return;
-		}
-	}
+	if (unlikely(may_fail_bio(bio)) && blk_error_inject(bio))
+		return;
 
 	blk_cgroup_bio_start(bio);
 
diff --git a/block/error-injection.c b/block/error-injection.c
index dc0420c4eb58..45f2454d0bca 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -4,6 +4,7 @@
  */
 #include <linux/debugfs.h>
 #include <linux/blkdev.h>
+#include <linux/fault-inject.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
 #include "blk.h"
@@ -47,6 +48,13 @@ bool __blk_error_inject(struct bio *bio)
 		}
 	}
 	rcu_read_unlock();
+
+	/* legacy I/O error injection */
+	if (should_fail_request(bio->bi_iter.bi_size)) {
+		bio_io_error(bio);
+		return true;
+	}
+
 	return false;
 }
 
@@ -297,3 +305,25 @@ void blk_error_injection_exit(struct gendisk *disk)
 {
 	error_inject_removall(disk);
 }
+
+static DECLARE_FAULT_ATTR(fail_make_request);
+
+bool should_fail_request(unsigned int bytes)
+{
+	return should_fail(&fail_make_request, bytes);
+}
+
+static int __init setup_fail_make_request(char *str)
+{
+	return setup_fault_attr(&fail_make_request, str);
+}
+__setup("fail_make_request=", setup_fail_make_request);
+
+static int __init fail_make_request_debugfs(void)
+{
+	struct dentry *dir = fault_create_debugfs_attr("fail_make_request",
+						NULL, &fail_make_request);
+
+	return PTR_ERR_OR_ZERO(dir);
+}
+late_initcall(fail_make_request_debugfs);
-- 
2.53.0

