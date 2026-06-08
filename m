Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D893B388C;
	Mon,  8 Jun 2026 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907996; cv=none; b=u9bjfD1Kw8eomZfHagAPjADH3qdDZR/qex0oRD3roLVD9IC8fVk57pnZ36j/Oj9Tm6nlxveuYhZq58zgOEAs4W4uQ4AvEcrtyIA0QIN8EMwd1wO5s/iQwn8MO5h4M/2Z0DmTvt8FesTZQiZMBQm9rPlCoouAYAmhYtE8/hL6un8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907996; c=relaxed/simple;
	bh=5bZQEodZYkoQoPTjEr40grAB/HpR0uE3i99cIUUCoNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fk99olIUG0rw6uEuDfbaVNCgCDQ4tmuBh0ScIcMO1ZQTQ9RjUMEEspKP4md9Pg2Y+pDQLRARVmhkaqI6U0Q/TaA/GT3ByxyHGBjzL7N7FWn4Q+llBvhfb5BUuXrX+MU+GMUyRIz22m5+lNeB9VqvSKLpBlWK0RL0DIbcyASX5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3rxYjDj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3rxYjDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA01F00893;
	Mon,  8 Jun 2026 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907992;
	bh=9JSfso993lFR9GmwDHM74cr3hxR62qICnWinSSZM7iA=;
	h=From:Date:Subject:To:Cc;
	b=I3rxYjDjdWSxiRTYMdGUXJtuMrUeTUm2C42SshFb5U48Oa4sZaYqWQjBgEjPFS2rJ
	 KvHzCdZQSe0e0lpGbmP1rY7tdubUjmBfFwCJuB0ii+56fD2EY3TtZpyURKO/qK9SQ0
	 xKanKtd1hpFp4wNzUErOhdZxQM4blZPsJSUpu9uIGQ2UwJKoCzQRJcPTuBDb3Kjix7
	 p1nmF1CwAPXwSeu3Cupp3YE2Iya41sv7GFBqtLkATx/7Jzkl4l2N0lSTaC5CFxUmXu
	 xSfmT+sSQ1+/iMGDy/lD0/x5JFfjyOc7PS+HwDBrETQ8Q9dSEVQVJQQhPrbqcoVru7
	 NBXVd9WfzDYMw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 08 Jun 2026 10:39:43 +0200
Subject: [PATCH] block: fix arg type in `blk_mq_update_nr_hw_queues`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-update-hw-nodes-arg-v1-1-19aba440b32e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM5/JmoC/yXMQQ6CMBBG4auQWTvJCISgVzEuavsDw6KQDqgJ4
 e4UXX6L9zYyJIXRvdgo4a2mU8y4Xgryg4s9WEM2lVI20kjL6xzcAh4+HKcAY5d6vtUCDy9VK45
 yOSd0+v1dH8+/bX2N8Mu5on0/APnTygd3AAAA
X-Change-ID: 20260608-update-hw-nodes-arg-940ecec0380a
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5bZQEodZYkoQoPTjEr40grAB/HpR0uE3i99cIUUCoNY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqJn/PQ5ZX3XRCDrW/Z6cEMwU9zYS+NvcidF05p
 3EBgXcsSNGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiZ/zwAKCRD6UCkIqsW9
 0PgCD/9AKpDysDlpGqetru8na5hXfx2eVwQlbIz2K7IIf5dB4eSL8Ty2L4NSRT55545PMpK11q1
 XZbU/PSudBr3YyxOJqGUuUW+tBqe/Iv9pVRoouWOajqa8NsZ/qksS6qNBFNUjfjoHqvvVBU4Kjf
 QWwselLvsyTYQVAEdjckad+t0gtZXVG4EBxQfOaD1N3YQeTKW3+Fq9d+WHAXl8y4iC8eWds01iP
 +bZdut9AEICQzzONMNckaH+jhLU/9kfFKXg/GfYoqYbfffpPUx+gB/1+72apFTLC+hkaL3J6F+N
 SPzk0RtJRKrCrpcnxwYYpBVufyQjFReNgNEaBrN1d/Fypy1GcuTCRqBZZQKVFsadK87uMDZgYOO
 UFFytA9zKK0V49xQUV7LZGY0cP9SyvtdT5ohGyEvOsBerVhLmM/c+zuJMJ8nvmowiwGeK1rNV/m
 ULjz19dIQQyXrRBXu5HVethYRGxkcraMh2BDcUPyHVuvu/QWdf4BjixIQB9Xo5/NHHtDavqHexS
 62jJwC5q6C9ecNEddFmjh6odU9mk3WN11MJNfeLG/PjrnaO+VnOAV5YW7F0/BroJAn9Xg35bClF
 1pNE3XciZyidPi+1+/VrktBGvQhphGMoE9KK6OlOzUsm0BV55YK0JezFXj/14akV/LqNDEFLuxF
 49Cm5EkGLuC5w3A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The type of the argument `nr_hw_queues` in the function
`blk_mq_update_nr_hw_queues` is a signed integer. This is wrong,
considering the field `nr_hw_queues` of `struct blk_mq_tag_set` is
unsigned. Thus, change the type of the parameter to unsigned.

Cascade the change to downstream functions.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 block/blk-mq.c         | 13 +++++++------
 include/linux/blk-mq.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..5eb9b52f3146 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4816,10 +4816,10 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 
 static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
 				struct blk_mq_tag_set *set,
-				int new_nr_hw_queues)
+				unsigned int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
-	int i;
+	unsigned int i;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
 		return NULL;
@@ -5134,12 +5134,12 @@ static int blk_mq_elv_switch_none(struct request_queue *q,
 }
 
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
-							int nr_hw_queues)
+					 unsigned int nr_hw_queues)
 {
 	struct request_queue *q;
-	int prev_nr_hw_queues = set->nr_hw_queues;
+	unsigned int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
-	int i;
+	unsigned int i;
 	struct xarray elv_tbl;
 	struct blk_mq_tags **new_tags;
 	bool queues_frozen = false;
@@ -5234,7 +5234,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		__blk_mq_free_map_and_rqs(set, i);
 }
 
-void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
+				unsigned int nr_hw_queues)
 {
 	down_write(&set->update_nr_hwq_lock);
 	mutex_lock(&set->tag_list_lock);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..f73b4a1f16db 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -974,7 +974,7 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 			  struct device *dev, unsigned int offset);
-void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260608-update-hw-nodes-arg-940ecec0380a

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


