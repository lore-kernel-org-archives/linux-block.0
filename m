Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2171FE0FE;
	Wed, 23 Oct 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693886; cv=none; b=BXssdncZxYXtRZyN8KhhSFhBn15xynqp+tVe+GWhz4V+N3hwloMqyTFc0iM+Wl37+HsHHd0XCL5Vsdg2UM0GH5T5ckVJse8MH0C2wMj63r28N8r5Ezs9lg9UrqjEyb3nzK0VfbrVPEM+ZVvKSqkuBRbrriJbWndH7tGBBpagWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693886; c=relaxed/simple;
	bh=wuXzqzJ43QCAo3tVRSE44tiP6oVwXudtbntvjU1cRFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4WTdABGG2CGdA9gyDfJPI385ZEklqb2RHVv1hReJRLsh/D36VxuDb9vkeDCOzaeTYfb5A2SQTl/VAZQNaOI+RzSAvLD6Fm6pieExbonnlMeh0xUrW97kjKy+nln2Nm624ttzB34NH6YiPG0AE14XRU7ALvokJVqBZIJ5hwnQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM/HYJX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM/HYJX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8190FC4CEE4;
	Wed, 23 Oct 2024 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693886;
	bh=wuXzqzJ43QCAo3tVRSE44tiP6oVwXudtbntvjU1cRFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GM/HYJX9584C9S3dmrGz3Sc381nBD0GPoCLykVX1bzSSdHjSTojL8UI5rFMxttCRk
	 D75heDK6n60joKQtmOCYPerfKwCygy7QleIVuUDlVIjxFZIlQPa2qvoqypb3pAsMbh
	 jP8mVlBv4zTAllUGCWmwAuAKtWWxUCED6EdCjYUsW0/5hqdfEogaqnlSh16F8a24tG
	 SyDGALkHuSMl22QZCNHtRlCPCI1B6wEs1Tno7rzp+02sV0SWnpH4jFFxJlHlunBsDk
	 8VUtpbSPqZFEaLGFbfvgjep7wwtpXPpu5QFKrH2JTy/OFYb2PHarOIW+zrHIlz6ejw
	 TqMDOEG5E+Aaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/23] block: Fix elevator_get_default() checking for NULL q->tag_set
Date: Wed, 23 Oct 2024 10:30:50 -0400
Message-ID: <20241023143116.2981369-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 5ff093cb3cf8f..ba072d8f660e6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -558,7 +558,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (!queue_is_mq(q) ||
-	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
+	    (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -569,7 +569,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return NULL;
 
 	if (q->nr_hw_queues != 1 &&
-- 
2.43.0

