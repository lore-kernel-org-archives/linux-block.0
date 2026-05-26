Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A13DD851;
	Tue, 26 May 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791921; cv=none; b=XLnB7sLKG92ZCYP15kJCvHtiyeWbjf2hoVoEwYf05R22sJ4Jhb6xtgW6JWiH60TF7SAIv0RCBwBcrZ7URjNEYkQ92KJ777rPqFqvrVYIdLMkigD9Vy06VD44mN/DhfPQubx2m9LvOrXasoCYD48oyXTViwZS0PusSyagoB2i3+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791921; c=relaxed/simple;
	bh=qKkrkRNzeFgSaGcMsLG4aejjIv6r8+VbWjIFSLCCRpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rZjUXMGmxyZXo3yq6vgfWHSP6+2+anOFW5zIDfnC9b77nN00cBkiHk5sgJq5yMS8gJxTi2Idnfg4+IZO1KwWjeBLLAADE8zq25wsTezG4NmRJWIXT+mbbO0CKA6H5wMjsgXJRDfDFmgdJ9Z6QRfMbC93xmhGHB9ZWR4EedukXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADHq+IreBVqhfdsEg--.1565S2;
	Tue, 26 May 2026 18:38:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] block: blk-mq: fix ws_active refcount leak in blk_mq_mark_tag_wait()
Date: Tue, 26 May 2026 10:37:22 +0000
Message-Id: <20260526103722.2287587-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHq+IreBVqhfdsEg--.1565S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3JFyUZr47XF4DZrykGrg_yoWkWFc_Gr
	1rA348CayDGrs0kr4qkrW3Wrna9wn7J3WUJ3y8KFy2krWrGF43Jr4SgrZ5JrsrWa47uay5
	Cw4DWFyxJw12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8miiUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUTA2oVdFkKzgAAsP

blk_mq_mark_tag_wait() calls sbitmap_queue_get() which increments
sbq->ws_active. On the error path where the waitqueue_active() check
fails and the function returns early, sbq->ws_active is not decremented,
leaking the reference.

Fix this by calling sbitmap_queue_clear() to properly release the
ws_active reference before returning on the error path.

Fixes: c27d53fb445f ("blk-mq: Reduce the number of if-statements in blk_mq_mark_tag_wait()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f..e1c2ac416693 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1952,6 +1952,8 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	spin_lock_irq(&wq->lock);
 	spin_lock(&hctx->dispatch_wait_lock);
 	if (!list_empty(&wait->entry)) {
+		list_del_init(&wait->entry);
+		atomic_dec(&sbq->ws_active);
 		spin_unlock(&hctx->dispatch_wait_lock);
 		spin_unlock_irq(&wq->lock);
 		return false;
-- 
2.34.1

