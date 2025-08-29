Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E891335BAF;
	Fri, 29 Aug 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482529; cv=none; b=XgtyK0G8g03zCADaNMhLv6kLgIXUPuCWtYxEc3ockIcxgKX6GURF4RjdowSrLTYuBFBvSzxZGr9laB+Nl4LQF45uG/nf3pghygpwiitCszXa3r8Uc5OsB0WKws+Y3V2cCFjsRrJ2UyvUH2lYcxF2oJB6o4USjGr4AMaijPwbVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482529; c=relaxed/simple;
	bh=N7iuauUh7P5zsvAS2I3TSB3cjF4+WxMa7Hofz2VW+Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8P7FyrL+4vlLYUG08BRQYZaUVwYIOSrEs5BRlM6nMVY4x9M1c8kXfn0I3eQ6hOXUQ6pdOMADC/QJgj0ZFSQccO7XW/Ior8O4WIVt7BRoXMgn6yIuFkn6H5pF+zqzRY/Qcev5UorlSIm+HM0uU25nEZi1d1Z2kF4INJga8kTK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj7ikhfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj7ikhfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60BAC4CEF0;
	Fri, 29 Aug 2025 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482529;
	bh=N7iuauUh7P5zsvAS2I3TSB3cjF4+WxMa7Hofz2VW+Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lj7ikhfSVP3EdMyviJUXZclCiQF+8nfJ/fekhphSH8XBK4gzNwmLLHl5eZ8c8sIn5
	 WRCMUoM5chRM73MZR3GKYx/elVgVRCPsPRdhyoUf3U4VF7PaCW6PGfq8kLk/AKyzA4
	 92tzab9lPVkIWEtb37ChtS1mTCGTLBoTnGQt5GpOS3j1MgYIgxWI5rZHX8geQX/nbW
	 rOqHmg+JAPbbKBcg6oSCU8VVr5ITtvuQA+Kle/2ne/csvIeyB2elA9PEBK1Iu3C9BE
	 3FfOH38eyqPl37vnPRLzrNlYUxiFjHz0E0t+CUIiWxuKB1n0ZoXc1QdjQLD2tvLknZ
	 qvJzhFMVDTBTQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 10/33] block: Protect against concurrent isolated cpuset change
Date: Fri, 29 Aug 2025 17:47:51 +0200
Message-ID: <20250829154814.47015-11-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block subsystem prevents running the workqueue to isolated CPUs,
including those defined by cpuset isolated partitions. Since
HK_TYPE_DOMAIN will soon contain both and be subject to runtime
modifications, synchronize against housekeeping using the relevant lock.

For full support of cpuset changes, the block subsystem may need to
propagate changes to isolated cpumask through the workqueue in the
future.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..f2d1f2531fca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4241,12 +4241,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		/*
 		 * Rule out isolated CPUs from hctx->cpumask to avoid
-		 * running block kworker on isolated CPUs
+		 * running block kworker on isolated CPUs.
+		 * FIXME: cpuset should propagate further changes to isolated CPUs
+		 * here.
 		 */
+		rcu_read_lock();
 		for_each_cpu(cpu, hctx->cpumask) {
 			if (cpu_is_isolated(cpu))
 				cpumask_clear_cpu(cpu, hctx->cpumask);
 		}
+		rcu_read_unlock();
 
 		/*
 		 * Initialize batch roundrobin counts
-- 
2.51.0

