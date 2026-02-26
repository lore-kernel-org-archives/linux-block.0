Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1436B055;
	Thu, 26 Feb 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113263; cv=none; b=ON40Ik6GEdMkvVGk/T5Z12cb1ZmsWE+486H+AhBbZNlUfMDsq9u01ZBlWVTov/ef4MJQRHW9SL3Yq6PexYW2T1uE0EufHy+4zkguFfbVBSBxrz5TyOL7Ym6FJer0EtCKW6zfpAVzlxZhksS/B2iZ/ald1gi731QAdjShJhhBT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113263; c=relaxed/simple;
	bh=2eeVb+zoDlOmD27kv8yJ2Z71w8S3koXAwM5JTxOP9Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vw1xOvgIp1eixt2x5aSjFqTBF3GsNG7+Z/ZlKsjo15jKx2T9BId7B2/01qWVW0zoWI/U8CxSqxeDUqCpTHXHlTc1LS0RgFaKfPKlSXbcNeMxlZHqtHbZ9YtUoN1crV5Gh7VOjbpLpWQQTuKqhDzKgF6Awv9vzXeetVWdVFHg/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVRVl7Dm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVRVl7Dm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D21FC19423;
	Thu, 26 Feb 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113263;
	bh=2eeVb+zoDlOmD27kv8yJ2Z71w8S3koXAwM5JTxOP9Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kVRVl7DmCTMD7dun7p1l3c0b+fLQDADieEnBM5Km3bpiPK2wV+ynl7BnBKqSuw1Dw
	 JaW2qMwfT8n3K3BKwg0XD2Tt3kzFEi9wOvy4Y0teutExQhhnnLTl305Yx8IOwIK98h
	 2fCHLGpfxFcvDQNlDTKpghCCSmCgswV7bfI4vwqGP8ReT8F2t730EReLN818YzVh5G
	 zP5IS5jQMEQ7w3w57krCFz5MaBgRQDt6VYhGvfoRhP7tiFb/cjEf8/bme0b6AOa4Gv
	 1efMu4OiDNY3Q7ceJ5Ur2CczR6+0InButBy4g6/B2JMSG4sYPTwF8lFNKWktakfVNz
	 MLmfOTlKPBjpw==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 26 Feb 2026 14:40:37 +0100
Subject: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu hotplug
 lock in group_cpus_evenly"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
In-Reply-To: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.

The reason the lock was removed was that the nvme-pci driver reset
handler attempted to acquire the CPU read lock during CPU hotplug
offlining (holds the CPU write lock). Consequently, the block layer
offline notifier callback could not progress because in-flight requests
were detected.

Since then, in-flight detection has been improved, and the nvme-pci
driver now explicitly updates the hctx state when it is safe to ignore
detected in-flight requests. As a result, it's possible to reintroduce
the CPU read lock in group_cpus_evenly.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 lib/group_cpus.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..533c722b5c2c 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -510,25 +510,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
+	/* Stabilize the cpumasks */
+	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
-	/*
-	 * Make a local cache of 'cpu_present_mask', so the two stages
-	 * spread can observe consistent 'cpu_present_mask' without holding
-	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
-	 * hotplug code.
-	 *
-	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
-	 * we can live with the case because it only affects that hotplug
-	 * CPU is handled in the 1st or 2nd stage, and either way is correct
-	 * from API user viewpoint since 2-stage spread is sort of
-	 * optimization.
-	 */
-	cpumask_copy(npresmsk, data_race(cpu_present_mask));
-
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+				  cpu_present_mask, nmsk, masks);
 	if (ret < 0)
 		goto fail_node_to_cpumask;
 	nr_present = ret;
@@ -543,13 +531,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
  fail_node_to_cpumask:
+	cpus_read_unlock();
 	free_node_to_cpumask(node_to_cpumask);
 
  fail_npresmsk:

-- 
2.53.0

