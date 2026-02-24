Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277927C84B
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970652; cv=none; b=fyX8qfDN6I2LUgg72/ZA68hGWBYZHDkZIflOmsL4QOGCqwHJROk9Cx3xwz3fVuEJLruJvalqTYHloJfXCbghXI8T+RLlp5jJSkxjCR0nLbH04c1uAmQpKWRR2BIaT9QOLPOrRY8ZvR98JSs3usnXNm6iDGpHl9G5/TJ5t48Ozv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970652; c=relaxed/simple;
	bh=j6ZAhhHrkG01sOJq5ihE03hbt0FNT+mzeysVRvxpktc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T2Wtcf8yhEFoMKceK82TQts+TY6vQAl2qLKukUPX7Ia9m+LK7iVr8iZv96ttpVeM8baJpd+xWVkqK6r4sFoeSVzwx4KJcXVBIpwY1wVZxLKfMclXqoCJyqEnuzHiiXNmuVX88q/he30TbKcYTkaygiAIhGKXXZl7q4hEETCB9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCP7qQNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCP7qQNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB2C116D0;
	Tue, 24 Feb 2026 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771970651;
	bh=j6ZAhhHrkG01sOJq5ihE03hbt0FNT+mzeysVRvxpktc=;
	h=From:To:Subject:Date:From;
	b=rCP7qQNXakpXiRTLg9jRy7vy23yqhmHiFbQOVL+HlLw1h291bLhDT0q0XRh1u1CmW
	 a79a9CnMjKXgZ0H4YWAS0jUQEPjdCFjwCfHEo0D+vY+TjHv5FOsBhjBnD7vLuBXyYw
	 1iU5j70isnn70nsVxe9CUHX9GdFFxquZeKQDRVes459PaQKEcm3PapyJBsC+LBs6/f
	 2sjStSx9tfBRKsFATCg2WxRr4SIwSA+wYCw4DhkicEBmjFMStvCfpU2BAiZi8H+3qA
	 hSciwsUzqOQpXoFqZ8P8JQEO+HyqeHIMXTMyqZV+TXVEUUgJHmG/8bCxwn1FLPgHoU
	 bYomUWOCIvnrw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: simplify blk_mq_finish_request()
Date: Wed, 25 Feb 2026 06:58:55 +0900
Message-ID: <20260224215855.1709335-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the local q variable as it is not necessary. This also removes a
useless pointer dereference when RQF_USE_SCHED is not set for a request.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9af8c3dec3f6..55a255750ad1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -781,12 +781,10 @@ EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
 static void blk_mq_finish_request(struct request *rq)
 {
-	struct request_queue *q = rq->q;
-
 	blk_zone_finish_request(rq);
 
 	if (rq->rq_flags & RQF_USE_SCHED) {
-		q->elevator->type->ops.finish_request(rq);
+		rq->q->elevator->type->ops.finish_request(rq);
 		/*
 		 * For postflush request that may need to be
 		 * completed twice, we should clear this flag
-- 
2.53.0

