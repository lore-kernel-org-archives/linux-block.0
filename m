Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCD2E9ED8;
	Fri, 20 Jun 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433024; cv=none; b=hPqeF9oisZIRGx1lUlwtp8vnTtJS60eR7op7HGE408dRfQNTZBcf7tlg4BvdiAiSTGTBnhOyfN90K6CmxWrB4oZBwEbn1G1A2u64O4JvnhJee/ICi5+fSaPPT3h7Rlb9T4e1vKqMlMa0O5lnj0V+ztELETrgETqKodbl1GSQGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433024; c=relaxed/simple;
	bh=ClR6PLlwiWDX0h6VoGwzQNxAgSSkzMHBGG+huRh08BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIljYmmZY3EXv+ImtXd37A6bEQ08QXUoY1tr12VBKSbzIHTRuEtv6hfkNrv1vnsYBXmaeCCVZd1nSxbFNSGNwEyNqn4lPouPd71rYww2avrhW65KTMooUGwI3PVfKwJAvzO9eYnbCqq0AaBFPWZAKm+UOEDxLNrFiNOIf30K7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsBsaCQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsBsaCQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD56FC4CEE3;
	Fri, 20 Jun 2025 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433024;
	bh=ClR6PLlwiWDX0h6VoGwzQNxAgSSkzMHBGG+huRh08BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsBsaCQzk80iWl6jugTSRK+uSqRdAnNwPrIjft1wUCtNvTrQdY3qNOjBhdhBnOQzC
	 hMZkqCMBXWeg6WxW/p8udJcUASRauoecVnTF50Q65c33m96ltLJU55C9JWQ0j3BHkJ
	 c/FFKaWl066S5dezCUtXI5AhquhiNcH/serTRyR5x5JQQnNLMOxxwYfxtzRovSvECO
	 FWdjeMVhM1cy6N8VOAdDAAoqzTqc1CB9sez7lpggMOXcDvHifk56P5O0VIcXmDckXd
	 SfSLaflg9hWETejvLKHXZsH7PCvFzD6wQ1Z2nOwDJ6m2/JoVB9c1c9iKH6r04LOZqb
	 pecCtS/rdcTlQ==
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
Subject: [PATCH 11/27] block: Protect against concurrent isolated cpuset change
Date: Fri, 20 Jun 2025 17:22:52 +0200
Message-ID: <20250620152308.27492-12-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620152308.27492-1-frederic@kernel.org>
References: <20250620152308.27492-1-frederic@kernel.org>
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
index 4806b867e37d..ece3369825fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4237,12 +4237,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		/*
 		 * Rule out isolated CPUs from hctx->cpumask to avoid
-		 * running block kworker on isolated CPUs
+		 * running block kworker on isolated CPUs.
+		 * FIXME: cpuset should propagate further changes to isolated CPUs
+		 * here.
 		 */
+		housekeeping_lock();
 		for_each_cpu(cpu, hctx->cpumask) {
 			if (cpu_is_isolated(cpu))
 				cpumask_clear_cpu(cpu, hctx->cpumask);
 		}
+		housekeeping_unlock();
 
 		/*
 		 * Initialize batch roundrobin counts
-- 
2.48.1

