Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6199394465
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106816; cv=none; b=hLOVhuh6TCuh0leOxULm4End856XZYH2dmnm0vuMQTWI1pRXueuTMAOzEa9yG7iAy3Y2rQNgjshY5b63JKPaYABGVUyXseoTlPqDfICW2iCSeGtDzCpPnHjH6BNkdExcWfysbyS1wEEX/1ApWP+KSF6IJj3zFfrZ/yDoQBT6ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106816; c=relaxed/simple;
	bh=P4zluyjrFatEHzqDCNyTnPlLpi7Qnyr/jRYxL32Ruhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5F+eO6nlaroGbdMuBYiyJ9WwZHc05JQ4nqXWnkXaWtpU/zIrM2PvvN55qL8llyFFWhqQgT0tgwu3A1u2Bc0XtJZXjZdqclcRu7hJUaUWoH+hVNIdHsNnf4eTuDb6P0eNplKylJxRf+e8HOp3UHGFtQddAQhRyfIMTi8OS2ZXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974E7C19422;
	Tue,  3 Feb 2026 08:20:13 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 8/8] blk-mq: add documentation for new queue attribute async_dpeth
Date: Tue,  3 Feb 2026 16:19:49 +0800
Message-ID: <20260203081952.732210-9-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203081952.732210-1-yukuai@fnnas.com>
References: <20260203081952.732210-1-yukuai@fnnas.com>
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

