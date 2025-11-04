Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522918C933;
	Tue,  4 Nov 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237303; cv=none; b=plZUnu5yxHlI4GrPzyUcDoDXGFgblluSiT9zoxkC/2Dt8nG7GY5D0VIRJFf2EKzWcWlgqNYhZCTpE15fUy4oPbLmwZ9YEwnPvrpOnh96Wj715vmLmuA+nKGLeZo7EeS/j8Y+JGK4xTSueph+q3OaHBo3vB30KIIEiuFimQ/8T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237303; c=relaxed/simple;
	bh=rC7j2N1SkGmfCrflixlud1j3F7KJscRsP8Cmk3WjFRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hX1MbJdVbHLxU2bFCuuUZrAxABkqxlJelmF0+RDq8G1qKzUOyLJAFhRc+WnWdC2k08wghszBCcXgi/RN3ykOVqX2jXCSQ98oEN+EGIRlSDAHlaANdCKvDs5S/+dYwM1APDxW1lMosCxF3Ji9kj/jCip2IGw0kX4Ai8cIB8AzTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4d0yvp0WkCzB7P0P;
	Tue,  4 Nov 2025 14:19:02 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Tue, 4 Nov 2025 14:21:29 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>, shechenglong
	<shechenglong@xfusion.com>
Subject: [PATCH] block: fix typos in comments and strings in blk-core.c
Date: Tue, 4 Nov 2025 14:21:13 +0800
Message-ID: <20251104062113.1929-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)

This patch fixes multiple spelling mistakes in comments and documentation
in the file block/blk-core.c.

No functional changes intended.

Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 block/blk-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14ae73eebe0d..7757cd589b59 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -662,13 +662,13 @@ static void __submit_bio(struct bio *bio)
  *    bio_list of new bios to be added.  ->submit_bio() may indeed add some more
  *    bios through a recursive call to submit_bio_noacct.  If it did, we find a
  *    non-NULL value in bio_list and re-enter the loop from the top.
- *  - In this case we really did just take the bio of the top of the list (no
+ *  - In this case we really did just take the bio off the top of the list (no
  *    pretending) and so remove it from bio_list, and call into ->submit_bio()
  *    again.
  *
  * bio_list_on_stack[0] contains bios submitted by the current ->submit_bio.
  * bio_list_on_stack[1] contains bios that were submitted before the current
- *	->submit_bio, but that haven't been processed yet.
+ *	->submit_bio(), but that haven't been processed yet.
  */
 static void __submit_bio_noacct(struct bio *bio)
 {
@@ -743,7 +743,7 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-	 * to collect a list of requests submited by a ->submit_bio method while
+	 * to collect a list of requests submitted by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
 	if (current->bio_list) {
@@ -901,7 +901,7 @@ static void bio_set_ioprio(struct bio *bio)
  *
  * submit_bio() is used to submit I/O requests to block devices.  It is passed a
  * fully set up &struct bio that describes the I/O that needs to be done.  The
- * bio will be send to the device described by the bi_bdev field.
+ * bio will be sent to the device described by the bi_bdev field.
  *
  * The success/failure status of the request, along with notification of
  * completion, is delivered asynchronously through the ->bi_end_io() callback
@@ -991,7 +991,7 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 	 * point to a freshly allocated bio at this point.  If that happens
 	 * we have a few cases to consider:
 	 *
-	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
+	 *  1) the bio is being initialized and bi_bdev is NULL.  We can just
 	 *     simply nothing in this case
 	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
 	 *     this and return 0
-- 
2.33.0

