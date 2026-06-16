Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE33368A7;
	Tue, 16 Jun 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619374; cv=none; b=gyhhTPCFy42PXsI9t2E/Dv8Rb6PxmbZ/UwllZTRf5A8MOkSqn6lzhAXHg8QU+FF3sVjnW3maou0qsK9ms8tea7ZXbXkXxJuOeXDicWZL7HCDDuqAxD5NS+cQX5XrtMBNF3+yRlRVSo+MDt8jts+TuNPfnbhHXmb0Z9hGrnM9OCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619374; c=relaxed/simple;
	bh=hISdtdX6j91Ay31ISlKEO9pgxegDz383yFJchnUuyUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cx8vbivAkDMWCsIYYnP9bt6V0DzJHghFnkgI5N8UdNJkHX+MhMFpu2t1new5FOg5eY5Aqed1zGAKRBV81IU0Ujd1DOcQbz/G4jM0RNnEwiNRVKE9E9Lm4wYnFSTqKi9jDlI/P4FPkbkxYxj8rMvsw9LCrv8RdG46U9+w/B69NYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qcK6btTp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcK6btTp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781619370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y6UAyfQyTA+RzEUmLSwPPZJxNPL0IchCjzB2MaaH8ns=;
	b=qcK6btTpkVYmQCxQBZXGljoBRwmluBostRndZvrTMO12ZAnrLkisJaisu30ASbJiixl0AW
	abVnLfhLU1q047EnzgW7IkfwFgwp1dTXGPARXZA8MGs3NeAmwXexrVuNGetykmHVarMsid
	MrbyySmpAeBujGdfZIRZ+x5ntYGH/Bg=
From: Usama Arif <usama.arif@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 0/2] block: invalidate cached plug timestamp on context switch
Date: Tue, 16 Jun 2026 07:15:16 -0700
Message-ID: <20260616141604.328820-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The details for this are in patch 2. The main reason for this series
is to invalidate the cached timestamp on context switch. This was
done in sched_update_worker() only before which was resulting in
blk-iocost reading stale timestamps and throttling based on wrong
information.

Patch 1 is a prerequisite to create the invariant that
PF_BLOCK_TS set implies current->plug != NULL.

v2 -> v3:
  https://lore.kernel.org/all/20260612094042.3350401-1-usama.arif@linux.dev/
  - Add patch 1 to clear PF_BLOCK_TS in copy_process() so the
    invariant survives fork.
  - Drop the if (plug) NULL check inside blk_plug_invalidate_ts(),
    relying on the invariant established by patch 1. (Peter Zijlstra)

v1 -> v2:
  https://lore.kernel.org/all/20260611231428.345098-1-usama.arif@linux.dev/
  - Move the PF_BLOCK_TS check into blk_plug_invalidate_ts() and
    upgrade it to __always_inline (Peter Zijlstra).
  - Drop the tsk parameter; the helper only ever operates on current.
 
Usama Arif (2):
  kernel/fork: clear PF_BLOCK_TS in copy_process()
  block: invalidate cached plug timestamp after task switch

 include/linux/blkdev.h | 16 ++++++----------
 kernel/fork.c          |  1 +
 kernel/sched/core.c    | 12 ++++++++----
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.53.0-Meta

