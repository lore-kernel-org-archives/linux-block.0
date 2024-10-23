Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2381B4F1F;
	Wed, 23 Oct 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693929; cv=none; b=i/7UjAE8tWT1vwESqlAfi4kc8Da3u10KfZWDylHCUO5e7Mir5Y3OsBwQbihL2/O2SJvpuCCIavxvbgLXVgAz82fcXVT+HM4E6qplrbRPlmXvhY792MzdLbG0tOxH4bKR6167Yi1b2twrEnLw862b4eav2JFXQtvuME38zmMFQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693929; c=relaxed/simple;
	bh=znH46xaZ8Cj1pizTLzXgHTIapoOGAjUCnDx3CD8l0yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Udi7BLvdrijdWBi9Blja4lZjezjimgWTmsK1WlqoRDGIh6vHv1aGlnt2cFac6XANU6djEwOLMWfbeWyHKI71kStEcIZ365dRFcDnZI0A4nIV5NasiZJY1Y+W6qfsfkOuJPkeczTy5e5ea0nzfYlR+aVcom2V7Cle4qzY13IBis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4fnc9r9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4fnc9r9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F75C4CEC6;
	Wed, 23 Oct 2024 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693928;
	bh=znH46xaZ8Cj1pizTLzXgHTIapoOGAjUCnDx3CD8l0yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4fnc9r9Utk43KYODOBm70z2hwFMkjnMMtOwUc1nEP+/l2qTFlHDg1zf4iT5H10Us
	 i1Flx5xgX347+D8rqPkmgPdJohuwySC84Ubws8JVMyLSG2VYBU9XlfZguWe6wtAKse
	 sW0HaHrQCU5CV0JEE64AJyvpcnMgD4M5OiGeNFV89rEjlv6emJXplL1GgLvWJO6VMD
	 38/NN/WDQQ7FT2fSGgE3DOkc1IoPJOAyqDheKSNJo/faHg0jwVCdF56QTLgfbLE2fN
	 Illc+nyUkfMQEOnqFfu/vp9orVTdCzsxidF3hsGv2spHtiJ9VsWQd4liXkfwaBpiox
	 Xof6YmR0jNIpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/17] block: Fix elevator_get_default() checking for NULL q->tag_set
Date: Wed, 23 Oct 2024 10:31:43 -0400
Message-ID: <20241023143202.2981992-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
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
index bd71f0fc4e4b6..06288117e2dd6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -624,7 +624,7 @@ static int elevator_switch_mq(struct request_queue *q,
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (!queue_is_mq(q) ||
-	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
+	    (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -635,7 +635,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return NULL;
 
 	if (q->nr_hw_queues != 1 &&
-- 
2.43.0

