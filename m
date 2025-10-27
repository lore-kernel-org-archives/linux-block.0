Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C012FF664
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565821; cv=none; b=XUf8bdjA+4si1vhpEAWRSSrsVxlK8tm5ILWlp9HPqxuvMUsiNTgAFGjvlSr2+Q6kzYjQRtEep2M0SdLWPrIM2qL42K8qo29ek+ksMe2moVHDIFyDU3ul6CYhSm9MlWPqBW+Fspqzvw/tQuD3vtD1nkwyTOwrm5KFSlyJIVylE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565821; c=relaxed/simple;
	bh=WMOWN/O6RJirJ8Q0UPgmsuRRzez+5KTXlquqX/LDj/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8X/AFJ7JPLJlxwcLuWctT2XiD55MBQSXnMvXJ2krmCrn3eWp34Plu20H0LVOUrRXM4kGrxKop0B6WvrjTI5udaCcFndKh/xZqH2P//15bQGhWLfm1RHZ73H+qKRxJ0OU/7SHZsiZO7UoPa41BXhQQsK3vBhsFv7n25E9AxLfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L94SDjGm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L94SDjGm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761565818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ8kNxKFg3iXPrsp9ZKvsqgzYCbP0wL+WIk+1iKncOU=;
	b=L94SDjGmKiPtGl5QbRqIXPOpXQkk5Up3neeQSqK3IFAqhe0DgsLWacaDOQOXDg/fDHfQgz
	PI+AbAxvz0EYAs58OlepXPLBbtzXlprqC7yRxHcy4PEZZF6WZ+TvsPd/vRKQuVhqt8f0HU
	V4wHobReTMWDYUBDphhaEqYbJ7HJe3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-nK0UTcaZNj2KZx8SYvPNUg-1; Mon,
 27 Oct 2025 07:50:15 -0400
X-MC-Unique: nK0UTcaZNj2KZx8SYvPNUg-1
X-Mimecast-MFC-AGG-ID: nK0UTcaZNj2KZx8SYvPNUg_1761565814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C639B1808981;
	Mon, 27 Oct 2025 11:50:13 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5361180044F;
	Mon, 27 Oct 2025 11:50:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] selftests: ublk: set CPU affinity before thread initialization
Date: Mon, 27 Oct 2025 19:49:47 +0800
Message-ID: <20251027114950.129414-4-ming.lei@redhat.com>
In-Reply-To: <20251027114950.129414-1-ming.lei@redhat.com>
References: <20251027114950.129414-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6b8123c12a7a..b13918500cdf 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
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

