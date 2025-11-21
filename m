Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F092FA0F3;
	Fri, 21 Nov 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702963; cv=none; b=MozQ2j7psZ4md3uUSfCNmJ5IB7vo0x6QDIxUMn2W4sJZdjqh39c11bNUlL/qO4yiwoAZDQUHzsZ8FFFf8ZPe8w3ez9wVoWqyNAClb2N4uolH05lDV29XtEStnjvtQP9T0tpM9L55PaD0cWfDiSu9h+NxxpP5dSTe3HQ8MHy5wM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702963; c=relaxed/simple;
	bh=P4zluyjrFatEHzqDCNyTnPlLpi7Qnyr/jRYxL32Ruhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giizA2tuVXflDhs8cVT1iuvgVoK/uueIlJ38tv0pCubkb05YFYqv5VUOQO1W0u3Pk3fosEkQ9d3ccJtBiGOwZ9VDPB8hmUXaRLElWzFp17IEfJ6VVlo9fgMwnNRy6DMSUpnmHPsEXYgjkFWNecUAbSMH7vWErcFuYu4LKzRVvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96A9C4AF0B;
	Fri, 21 Nov 2025 05:29:20 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com
Subject: [PATCH v6 8/8] blk-mq: add documentation for new queue attribute async_dpeth
Date: Fri, 21 Nov 2025 13:28:55 +0800
Message-ID: <20251121052901.1341976-9-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121052901.1341976-1-yukuai@fnnas.com>
References: <20251121052901.1341976-1-yukuai@fnnas.com>
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

