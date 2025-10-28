Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACB2BDC13
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641827; cv=none; b=Uqcznisd/Llaxd/I6RFS5n9fejKMWXCYBRjMmDBe6/CjKEUsjw49Nl3DcVjSEKRiio+wnJAFqmQE6+nV9pmabUQU9baibk2fR/ClaHaGTAmAm5wP6eFENpVpERaWxm5vl7VF7AHmtOx8UgkKWtp17L7fWDYYUZrLcqfDU9T5yMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641827; c=relaxed/simple;
	bh=4hpwktsqT+NrcnmoweOTYtsYynOyBuPdV1XmIITfpXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvQkmNSo7gmT+3u+Qk6NzPpLGr4fxLETjXomo2bg5jMAZ6C3CQ6aZ5vitUc7YoHPlRjGGmggY7iATtFEfnel2NTEto8NoIpvys4YbcItlblQiFlLxMDDxAqI5LPloBwRgnrX6emHfPWk/yLuuHnP74kaOqgOyt0cPmYWZNR6j6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXBjAleI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXBjAleI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761641824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Te6jXPipCN5v2x3plHjD+WJeCbymeagDI6T0+cYRx2E=;
	b=WXBjAleIsEAhalSMMQxAWFBdD0EMi7sfUDgac3azostONVkRPdAgK/uMAuxBQArr5c8Inp
	CTFFjD4NJp9qlJ7RagQy+KmT0UWjSsQrEr7g1p6YI8tYYvndLwwUxc6Et86BKYeN0+US31
	sBNUQMf42TEm82ViHrLDDhbcCM5QgBo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-7tjhi-TZM2iVT8GJxBqb0w-1; Tue,
 28 Oct 2025 04:57:03 -0400
X-MC-Unique: 7tjhi-TZM2iVT8GJxBqb0w-1
X-Mimecast-MFC-AGG-ID: 7tjhi-TZM2iVT8GJxBqb0w_1761641822
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29D0B19541BD;
	Tue, 28 Oct 2025 08:57:02 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 248461800451;
	Tue, 28 Oct 2025 08:57:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/5] selftests: ublk: set CPU affinity before thread initialization
Date: Tue, 28 Oct 2025 16:56:33 +0800
Message-ID: <20251028085636.185714-5-ming.lei@redhat.com>
In-Reply-To: <20251028085636.185714-1-ming.lei@redhat.com>
References: <20251028085636.185714-1-ming.lei@redhat.com>
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

