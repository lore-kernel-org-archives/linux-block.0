Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C17239562;
	Sun, 16 Nov 2025 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763265167; cv=none; b=n/TqYL4DxxeAXOnacmiFLyPsAdwrWepYPJHTcckB/+8/RvcZLFROBPdOvlFxyVKIehHmM6aEx/Q4ISK7J45xhw0mt5sb5zL+N9KxQfBJGHx1W3FKnizuumXLo8toBhbpV3wJb8ok/AO0MRP5K6SCIihohNhrI4vgttIez7rbgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763265167; c=relaxed/simple;
	bh=P4zluyjrFatEHzqDCNyTnPlLpi7Qnyr/jRYxL32Ruhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FddXQgq4PeOXNpO879MVk0p8zSZlnlhU8P5cDvBnzAKcJvCZLoQA1xPJbu3j3tSLG6CpmFVhn+qwRb0/EfTH44i1Hp6I3Y2rjFvnxhpKn4vnfK0o8uJ7Nf3YcnNKJ1G29h12ibzhVkPLlF3DOTyAnyzaenR/bilqZoE9QvjJCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D352AC113D0;
	Sun, 16 Nov 2025 03:52:44 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com,
	nilay@linux.ibm.com,
	bvanassche@acm.org
Subject: [PATCH RESEND v5 7/7] blk-mq: add documentation for new queue attribute async_dpeth
Date: Sun, 16 Nov 2025 11:52:27 +0800
Message-ID: <20251116035228.119987-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116035228.119987-1-yukuai@fnnas.com>
References: <20251116035228.119987-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Explain the attribute and the default value in different case.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/ABI/stable/sysfs-block | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ed10aeff86b..aa1e94169666 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -609,6 +609,40 @@ Description:
 		enabled, and whether tags are shared.
 
 
+What:		/sys/block/<disk>/queue/async_depth
+Date:		August 2025
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] Controls how many asynchronous requests may be allocated in the
+		block layer. The value is always capped at nr_requests.
+
+		When no elevator is active (none):
+		- async_depth is always equal to nr_requests.
+
+		For bfq scheduler:
+		- By default, async_depth is set to 75% of nr_requests.
+		  Internal limits are then derived from this value:
+		  * Sync writes: limited to async_depth (≈75% of nr_requests).
+		  * Async I/O: limited to ~2/3 of async_depth (≈50% of nr_requests).
+
+		  If a bfq_queue is weight-raised:
+		  * Sync writes: limited to ~1/2 of async_depth (≈37% of nr_requests).
+		  * Async I/O: limited to ~1/4 of async_depth (≈18% of nr_requests).
+
+		- If the user writes a custom value to async_depth, BFQ will recompute
+		  these limits proportionally based on the new value.
+
+		For Kyber:
+		- By default async_depth is set to 75% of nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+		For mq-deadline:
+		- By default async_depth is set to nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
-- 
2.51.0

