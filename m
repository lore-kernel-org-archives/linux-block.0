Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682D16A395
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707476; cv=none; b=CjjeJFaqAhjDK9gfY6Of1hXvIsa2F6S+FW+116CckG/3LMmf2B5BzrkDS9q+sv2bp4dMLQAoILgfgdmqpBuqVgfGnwc0KXdtw3zwB9zWcqFmXXLwP9YvgI+RFiMZtEcEQ2q8+8+/d7b1xH1gq2tqWoEPy5RMmMzBRqMD1pfarOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707476; c=relaxed/simple;
	bh=4hpwktsqT+NrcnmoweOTYtsYynOyBuPdV1XmIITfpXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpbB8FQOReEpD5O7XQioVuV8Q/hCYbx5b34hmGiBGKwxv64qW/Kmc6OovsrraYQszXKJT3GT5Yv3oJJY7IXTPF7/FLf/eX/odyDr/sqVkyt2toN+Q/ZixaKmkYiKuQhntghTH1bu+t+5qlBTFr6kaEuKLT2Y/+wg9vrmbTVe6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0EmPpsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0EmPpsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761707472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Te6jXPipCN5v2x3plHjD+WJeCbymeagDI6T0+cYRx2E=;
	b=E0EmPpsv/P9eyVfV8MgdGgsAI0a0FUT6f3nRHRgON/b0UJ386gYyVn9sdxLCQ7K4Blm0qx
	C7Amtz2YjtsTcDtTchG9tyrDpXvMMkCDGXhmP4qLhLMaRL52vKuuDHqib/04tyGVgm1D0v
	e7MiuZAVCkvmoTFI1uAc2+gN1Nuv9m4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-Lhpch8p-OOqHdJI34F6omw-1; Tue,
 28 Oct 2025 23:11:06 -0400
X-MC-Unique: Lhpch8p-OOqHdJI34F6omw-1
X-Mimecast-MFC-AGG-ID: Lhpch8p-OOqHdJI34F6omw_1761707465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4052118001DA;
	Wed, 29 Oct 2025 03:11:05 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D70D7180057C;
	Wed, 29 Oct 2025 03:11:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/5] selftests: ublk: set CPU affinity before thread initialization
Date: Wed, 29 Oct 2025 11:10:30 +0800
Message-ID: <20251029031035.258766-5-ming.lei@redhat.com>
In-Reply-To: <20251029031035.258766-1-ming.lei@redhat.com>
References: <20251029031035.258766-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move ublk_thread_set_sched_affinity() call before ublk_thread_init()
to ensure memory allocations during thread initialization occur on
the correct NUMA node. This leverages Linux's first-touch memory
policy for better NUMA locality.

Also convert ublk_thread_set_sched_affinity() to use
pthread_setaffinity_np() instead of sched_setaffinity(), as the
pthread API is the proper interface for setting thread affinity in
multithreaded programs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6b8123c12a7a..062537ab8976 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -839,7 +839,7 @@ static int ublk_process_io(struct ublk_thread *t)
 static void ublk_thread_set_sched_affinity(const struct ublk_thread *t,
 		cpu_set_t *cpuset)
 {
-        if (sched_setaffinity(0, sizeof(*cpuset), cpuset) < 0)
+	if (pthread_setaffinity_np(pthread_self(), sizeof(*cpuset), cpuset) < 0)
 		ublk_err("ublk dev %u thread %u set affinity failed",
 				t->dev->dev_info.dev_id, t->idx);
 }
@@ -862,15 +862,21 @@ static void *ublk_io_handler_fn(void *data)
 	t->dev = info->dev;
 	t->idx = info->idx;
 
+	/*
+	 * IO perf is sensitive with queue pthread affinity on NUMA machine
+	 *
+	 * Set sched_affinity at beginning, so following allocated memory/pages
+	 * could be CPU/NUMA aware.
+	 */
+	if (info->affinity)
+		ublk_thread_set_sched_affinity(t, info->affinity);
+
 	ret = ublk_thread_init(t, info->extra_flags);
 	if (ret) {
 		ublk_err("ublk dev %d thread %u init failed\n",
 				dev_id, t->idx);
 		return NULL;
 	}
-	/* IO perf is sensitive with queue pthread affinity on NUMA machine*/
-	if (info->affinity)
-		ublk_thread_set_sched_affinity(t, info->affinity);
 	sem_post(info->ready);
 
 	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
-- 
2.47.0

