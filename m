Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DE5399
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXfzVvzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B79C433C7;
	Mon, 20 Nov 2023 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700463973;
	bh=Ev7BCXOvpPYc/Al0YTKIY4d9AhUlRDRQH8KEZ2oEd0k=;
	h=From:To:Subject:Date:From;
	b=qXfzVvzhVM+J6ouQfrEVzK7VPLtqcyRkKuvnqoz2utW1m2teyZnI4NQt8AUPLP0Bu
	 NphpQl4MN2bBHnFd0UsF3sOUbngNOTeAuTTTDWermVcCCgWwMaHpZD7XO8ltQRhpG/
	 M1Ik5j6VSQYE1aLNtrZQH+KxMTyWKaczWxrudykuIySkaNFnXVxwqB0e7Itqs9rqhN
	 IDd/45otLiQyLPStCezD9XBp5XbkmHhHRBdxZJpPJhkwCOCiFD7BOXSOhXBSjyWfMk
	 adsaGftXaupdr/a5PWDz6MbKba0/yKgfkeRaUgR4G3WCyMTqpKTQZ6pw2VIfYRW2qe
	 UwJzz6N7soaug==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: Remove blk_set_runtime_active()
Date: Mon, 20 Nov 2023 16:06:11 +0900
Message-ID: <20231120070611.33951-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function blk_set_runtime_active() is called only from
blk_post_runtime_resume(), so there is no need for that function to be
exported. Open-code this function directly in blk_post_runtime_resume()
and remove it.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-pm.c         | 33 +++++----------------------------
 include/linux/blk-pm.h |  1 -
 2 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 6b72b2e03fc8..42e842074715 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -163,38 +163,15 @@ EXPORT_SYMBOL(blk_pre_runtime_resume);
  * @q: the queue of the device
  *
  * Description:
- *    For historical reasons, this routine merely calls blk_set_runtime_active()
- *    to do the real work of restarting the queue.  It does this regardless of
- *    whether the device's runtime-resume succeeded; even if it failed the
+ *    Restart the queue of a runtime suspended device. It does this regardless
+ *    of whether the device's runtime-resume succeeded; even if it failed the
  *    driver or error handler will need to communicate with the device.
  *
  *    This function should be called near the end of the device's
- *    runtime_resume callback.
+ *    runtime_resume callback to correct queue runtime PM status and re-enable
+ *    peeking requests from the queue.
  */
 void blk_post_runtime_resume(struct request_queue *q)
-{
-	blk_set_runtime_active(q);
-}
-EXPORT_SYMBOL(blk_post_runtime_resume);
-
-/**
- * blk_set_runtime_active - Force runtime status of the queue to be active
- * @q: the queue of the device
- *
- * If the device is left runtime suspended during system suspend the resume
- * hook typically resumes the device and corrects runtime status
- * accordingly. However, that does not affect the queue runtime PM status
- * which is still "suspended". This prevents processing requests from the
- * queue.
- *
- * This function can be used in driver's resume hook to correct queue
- * runtime PM status and re-enable peeking requests from the queue. It
- * should be called before first request is added to the queue.
- *
- * This function is also called by blk_post_runtime_resume() for
- * runtime resumes.  It does everything necessary to restart the queue.
- */
-void blk_set_runtime_active(struct request_queue *q)
 {
 	int old_status;
 
@@ -211,4 +188,4 @@ void blk_set_runtime_active(struct request_queue *q)
 	if (old_status != RPM_ACTIVE)
 		blk_clear_pm_only(q);
 }
-EXPORT_SYMBOL(blk_set_runtime_active);
+EXPORT_SYMBOL(blk_post_runtime_resume);
diff --git a/include/linux/blk-pm.h b/include/linux/blk-pm.h
index 2580e05a8ab6..004b38a538ff 100644
--- a/include/linux/blk-pm.h
+++ b/include/linux/blk-pm.h
@@ -15,7 +15,6 @@ extern int blk_pre_runtime_suspend(struct request_queue *q);
 extern void blk_post_runtime_suspend(struct request_queue *q, int err);
 extern void blk_pre_runtime_resume(struct request_queue *q);
 extern void blk_post_runtime_resume(struct request_queue *q);
-extern void blk_set_runtime_active(struct request_queue *q);
 #else
 static inline void blk_pm_runtime_init(struct request_queue *q,
 				       struct device *dev) {}
-- 
2.42.0

