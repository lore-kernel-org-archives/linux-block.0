Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46018B0A;
	Mon, 24 Nov 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763950800; cv=none; b=pV42jjVeBJH5LtiWK3BWvNrMnkdgzL7bkROC8tWAAQi/47gJzMpE0G36cZkHL7YWBr+BEIf4Yp8P2uobh8I1W82seAIJVlqkCiCuc4bXGz1Dna/++pvfBTE/HvknpkqJfnNBWT+XOA2NmOC1FxmvMwJ89L4k9uxwa9FKIoFFNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763950800; c=relaxed/simple;
	bh=ie0gj8wY77Jlfqx4kJJF+9LMvcIjxzq8ymFXAV6j3Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEf5igM2/eIIydsCk7Dye5cOWxfBIGD43+W8eSQJpj8ULJ3wf710+zMKdoXnzlPXzys6b61YUX3xKJZHCJQsOVV2ZHxCSWe8k5ghT2gnFOVr9oDJLBUol6hMhloNLuQlL6MZ+dU+aBRAm12Qa56QlViOCpDUOjQoyhuYI4ZlQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4dF8G81fNQzB6C7F;
	Mon, 24 Nov 2025 10:02:08 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Mon, 24 Nov 2025 10:03:10 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <axboe@kernel.dk>, <hch@infradead.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kch@nvidia.com>, <stone.xulei@xfusion.com>, <chenjialong@xfusion.com>,
	shechenglong <shechenglong@xfusion.com>
Subject: [PATCH v2 1/1] block: fix typos in comments and strings in blk-core
Date: Mon, 24 Nov 2025 10:02:58 +0800
Message-ID: <20251124020258.1022-2-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20251124020258.1022-1-shechenglong@xfusion.com>
References: <20251104123500.1330-2-shechenglong@xfusion.com>
 <20251124020258.1022-1-shechenglong@xfusion.com>
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

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 block/blk-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14ae73eebe0d..8387fe50ea15 100644
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
@@ -743,8 +743,8 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-	 * to collect a list of requests submited by a ->submit_bio method while
-	 * it is active, and then process them after it returned.
+	 * to collect a list of requests submitted by a ->submit_bio method
+	 * while it is active, and then process them after it returned.
 	 */
 	if (current->bio_list) {
 		if (split)
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

