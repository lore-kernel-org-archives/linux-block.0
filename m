Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFA1CC165;
	Wed, 23 Oct 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693827; cv=none; b=Xr9SqWJW58DH0FRhXBGA1ofnHOHJspxSbJcCfl5AbloB00t7zncyfxy39raTgw9rJGH4fAwybkIu8zshgxFUlB6kmEQn+EDK6YvsdNGLWFGdFRpVZkN/6Sp2qgnNsu5iaXj5RnUUgRg1W6CuQIHSrEUlOf38v3VaZKCvOkRaG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693827; c=relaxed/simple;
	bh=18GHT5I4LSLh3erJ4viP7sGeXISYiFC4RNGK/AUkD9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8gngWak1e5UgJ0SBkDMyLx+MOmg/sypLlXw0mhz51QksAkRJOCZfMsRsKP3/MuyJHPwLtf5/4GwvtO3URiQVgi60SFhwYLKDE8qbat6Khkzdaj5uzAMyAWZPHUZx3q1dOnyiwWNres/PJZlt+2sMnETabWpeWnjgrJ6lHpv9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzyjfan3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzyjfan3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F8DC4CEE9;
	Wed, 23 Oct 2024 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693827;
	bh=18GHT5I4LSLh3erJ4viP7sGeXISYiFC4RNGK/AUkD9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzyjfan3hHSqdmc+j5awMN/NSRGHEG/3EGUuBrp+yXuXsbjRhTf5RVz6g60Efra5B
	 fYKbi69Db71DuWwx6kvNdyHragC9uR7rIkK04jAvql7XiSxRk1LjvV4vnAnQBSErvA
	 GYN3iArSNjV1sZzT5cayL/JxlyUhKWzOMZAOGj02G/dKlhcGmBR+EwAb560ss42wSW
	 IILtJqohho4F6Wh+p6AZhrsogTcbsQ6jYUGif3R16LcpyTVyvYfuyKiC7bsvqpvenT
	 CJoaXlbcA3SHyITcylKM7YVrh3rwgYqfyiQ/6quC+mHOKNXaCAnWRh8Vq0xIyNSr8c
	 ZhJz7hBgV75rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 09/30] block: Fix elevator_get_default() checking for NULL q->tag_set
Date: Wed, 23 Oct 2024 10:29:34 -0400
Message-ID: <20241023143012.2980728-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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
index 4122026b11f1a..60497e3b25b0d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (!queue_is_mq(q) ||
-	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
+	    (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -562,7 +562,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return NULL;
 
 	if (q->nr_hw_queues != 1 &&
-- 
2.43.0

