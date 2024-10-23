Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A1212D1D;
	Wed, 23 Oct 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693960; cv=none; b=N8odHuRKQRwbPWJf6LDjIsT+EBne7ZNI9paQf/TemDsCWrftPStvug3m3/ME02DhD7pOlR6MGu3DZC2s8QsTqi3sGPCLnsJo4W06BRyPd+fPYzal5ihtGhNnd+rtxHPWi2EboxK2yLdd/y+0i2hRScmGqrlmFEcduFQEnRERuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693960; c=relaxed/simple;
	bh=gckRkumOpsyq7F5/Ugf40vPgAuzb0zs8QhJu1JFTphw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phVtu77Gk1erjNt9TiEHR+NrDu+3fD4UtveWJWakSM8U3bbunrfs4/Azq5QBjT02t5cLnTdO6ba+Ga5c+EApQ+oS9vH+dJBLKQFSLTW3opdHjtay7R+YcS5WcBCbTckMViTsbDFDBaVhngFr0gu1ObxPP5f6RntcrrHE5LJQ3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSnHt6e+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSnHt6e+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5EBC4CEC6;
	Wed, 23 Oct 2024 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693960;
	bh=gckRkumOpsyq7F5/Ugf40vPgAuzb0zs8QhJu1JFTphw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSnHt6e+ht3TuatZ9akcmi7poMzQcaZbVLJeEW7UQBDk80atwVLS0nyqenYH6cJ+H
	 +SGG5Mvx3OfD5Ba7N5+yRwn1oVRLq0zvXjV4vNO/M0CYG8ilbL4gcJHqLlP9Z0I6cZ
	 /2uaDjkRLL59T7WchGXkR/snM3MGr+mfrM06n7YCpB348pdZMJXoTZCGNKNxxUYfZp
	 nQc6g+3F4LZml7hCbN12I0IGj4hdlkwydlRnEFrtVKker4Z9VpEjF1weyXTyqs8Vu3
	 GdGuCeKFqKfuAIxg2eDZDfJZkxOSHBVcM6EY+BQaomy2sHRTgrlYmC1Ojb/js/e3ug
	 7tFaEXpSXgZkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/10] block: Fix elevator_get_default() checking for NULL q->tag_set
Date: Wed, 23 Oct 2024 10:32:24 -0400
Message-ID: <20241023143235.2982363-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143235.2982363-1-sashal@kernel.org>
References: <20241023143235.2982363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
Content-Transfer-Encoding: 8bit

From: SurajSonawane2415 <surajsonawane0215@gmail.com>

[ Upstream commit b402328a24ee7193a8ab84277c0c90ae16768126 ]

elevator_get_default() and elv_support_iosched() both check for whether
or not q->tag_set is non-NULL, however it's not possible for them to be
NULL. This messes up some static checkers, as the checking of tag_set
isn't consistent.

Remove the checks, which both simplifies the logic and avoids checker
errors.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
Link: https://lore.kernel.org/r/20241007111416.13814-1-surajsonawane0215@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 1b5e57f6115f3..a98e8356f1b87 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -620,7 +620,7 @@ int elevator_switch_mq(struct request_queue *q,
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (!queue_is_mq(q) ||
-	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
+	    (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -631,7 +631,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return NULL;
 
 	if (q->nr_hw_queues != 1 &&
-- 
2.43.0

