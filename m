Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6B389E07
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041493; cv=none; b=UXC0tKb5CzWGqwEr6ai1SII0JIl8vdnPg0nE/8Uf4aKk+faKT3Mlib1j2mBcxyuEQJvQMOIfTZ8WexBfMo3kHxfEcCAEnmDw9E07Ua+LvYDjhBbqbCWMsdg6TNMMFBfkKzYbdIzFD1VMrXcWaANM/N11x9jzDfB2JTGnqLFK7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041493; c=relaxed/simple;
	bh=Q5/zdQWz0Amn1o+/OUx4rATy9xjEBYqtx8W87l2OgSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0Yu99KusPa0mhM8QnoMkI2yEK0fCpAQ8HjhYR3tDb64mGVAtF0g1+e0GmPAL4/sNDaZOY+DMqgj3oIJh/ID99AFE2VihMWjyRrZVEz1qcwveN1yB+5FfzGlTFTb+pHPuAXbM1vojY5xDaXj404jMu2a0TAE9efnXtDkd0YBtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uhqHgBpA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uhqHgBpA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786041477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIQUNegZUdNkWjWDpqB8PqELYCjKwKcvkduZflxil3A=;
	b=uhqHgBpA56bOQjmfcTTs6gK8gKNMaTZia/sCKy2VVhR+/QHc9GQ8g9Dp5saCi2+ESEXpWQ
	u/jeeMQ0u6O0k3zU7DZf+n2E3qz23uO/kh1tNPXSC5JU37/7xYvZxBqfn+Il0KVGOiiPR8
	LNIBEA7Uq11NYQTGh9lpvvGUcFWAwrI=
From: Usama Arif <usama.arif@linux.dev>
To: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 1/3] blk-iolatency: clear delay state when freeing policy data
Date: Thu,  6 Aug 2026 11:37:18 -0700
Message-ID: <20260806183742.946953-2-usama.arif@linux.dev>
In-Reply-To: <20260806183742.946953-1-usama.arif@linux.dev>
References: <20260806183742.946953-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

io.latency can throttle a group which has no latency target of its own.
When a sibling misses its target, check_scale_change() scales down its
peers, and a peer that reaches queue depth one gets blkcg_use_delay()
called on it on every further scale-down, even with min_lat_nsec == 0.

iolatency_pd_offline() resets the target through
iolatency_set_min_lat_nsec(), which clears the delay only on a nonzero
to zero transition, so it never clears such a peer.  Freeing the policy
data then leaves blkg->use_delay set and blkcg->congestion_count
elevated with nothing left that can drop it.

blk_cgroup_congested() then returns true for every task in that cgroup
and its descendants for as long as the cgroup lives: page_cache_sync_ra()
cuts readahead to a single page, page_cache_async_ra() skips it
altogether, and __folio_throttle_swaprate() takes swap_avail_lock and
schedules a throttle on anonymous folio allocation.

Clear the delay in iolatency_pd_free().  By then bio-held blkg
references have drained, or the queue is frozen for policy
deactivation, so check_scale_change() cannot re-arm it.  The free
callback can also see policy data which was never attached to a blkg,
hence the pd->blkg check.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 block/blk-iolatency.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 9eb69010c34e6..2caa79a008ad1 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -1043,6 +1043,15 @@ static void iolat_release(struct rcu_head *rcu)
 
 static void iolatency_pd_free(struct blkg_policy_data *pd)
 {
+	struct blkcg_gq *blkg = pd_to_blkg(pd);
+
+	/*
+	 * Groups throttled as collateral have min_lat_nsec == 0, so
+	 * iolatency_pd_offline() leaves their delay set.  Drop it here, where
+	 * no in-flight bio can re-arm it via check_scale_change().
+	 */
+	if (blkg)
+		blkcg_clear_delay(blkg);
 	call_rcu(&pd->rcu_head, iolat_release);
 }
 
-- 
2.53.0-Meta

