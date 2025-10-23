Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C53148D9
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233634; cv=none; b=XnHUU4gHszju62y5327ESVDiRn94sLE8DQRtlZgllWIUJLiDVOJqUZRcE5TAdk8k0ahCWD8b6wcGfRQ9qXA8ICHEG/9TsqN+jpeFAycNhejHp4PWZpcE37kcSu+o5iXSixsYjDt3EvCAIbnIdGNyF9cgE6TuKVRhTlsmy/+b1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233634; c=relaxed/simple;
	bh=NxmxVEWpsGDB2zMGzIPf4XZBgKs2pU3pBYYFslPCoXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhwSxOKEwSLxEUT9UKLVxmIj5DXDv6YpzqJTx3wRSZCgbvyqqEY3USuybi6JrnvAwNDXJiBk/mYBvjCXgMiLkP33gDrA4iCiP+rq4tY5Hcu+KusqnLtFJnzFt7X2v4C9FCm5hXWL3HUS7azP/YvsT2Wy8swVLr+zCE0QH29jrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gk8XzVEG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk8XzVEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkDNsKCt/F9+WLJ//Z8R4vmPCNjZT65DvorW8oFG93U=;
	b=gk8XzVEGuTvbS9Mchy0ASOiWeSE+ls48gIAO1tcKKIPcE1hepyeKV5ZFUzAFlMS5FY02yH
	nonHOhjnxTMDDhLwARQbUKG8zw/FHAk9xF7RAUePR6L1cG+Uc4Fpx539hg3yNKNxQgq143
	RyvsXk3odPkNFJQ7K9LVfvIfh5G5MRc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-M2MYCeSpMmaaONRC4H58gg-1; Thu,
 23 Oct 2025 11:33:49 -0400
X-MC-Unique: M2MYCeSpMmaaONRC4H58gg-1
X-Mimecast-MFC-AGG-ID: M2MYCeSpMmaaONRC4H58gg_1761233628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26DCE1954213;
	Thu, 23 Oct 2025 15:33:48 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5062180045B;
	Thu, 23 Oct 2025 15:33:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 14/25] ublk: abort requests filled in event kfifo
Date: Thu, 23 Oct 2025 23:32:19 +0800
Message-ID: <20251023153234.2548062-15-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In case of BATCH_IO, any request filled in event kfifo, they don't get
chance to be dispatched any more when releasing ublk char device, so
we have to abort them too.

Add ublk_abort_batch_queue() for aborting this kind of requests.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6b9b47b1b4ca..da89086afce4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2235,6 +2235,26 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 	}
 }
 
+/*
+ * Request tag may just be filled to event kfifo, not get chance to
+ * dispatch, abort these requests too
+ */
+static void ublk_abort_batch_queue(struct ublk_device *ub,
+				   struct ublk_queue *ubq)
+{
+	while (true) {
+		struct request *req;
+		short tag;
+
+		if (!kfifo_out(&ubq->evts_fifo, &tag, 1))
+			break;
+
+		req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+		if (req && blk_mq_request_started(req))
+			__ublk_fail_req(ub, &ubq->ios[tag], req);
+	}
+}
+
 /*
  * Called from ublk char device release handler, when any uring_cmd is
  * done, meantime request queue is "quiesced" since all inflight requests
@@ -2253,6 +2273,9 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			__ublk_fail_req(ub, io, io->req);
 	}
+
+	if (ublk_support_batch_io(ubq))
+		ublk_abort_batch_queue(ub, ubq);
 }
 
 static void ublk_start_cancel(struct ublk_device *ub)
-- 
2.47.0

