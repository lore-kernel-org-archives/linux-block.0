Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599503D0A4
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921660; cv=none; b=YojCUsBBZyHUQoJHaKngN6i3LGQYZVVs3vyXn5FYOcJATtwYsuQA5G3f44cHLxGCbBUY9cPTm+dsZ2mIOZ6nU2GTOwwSFVdA+HBHCERIMVZUuyZ6WTdWfuPCbYUGjuu6eUpfMgHBXwe4rDdIJfVI4/V6t+jxgqeTtRLLIPkolhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921660; c=relaxed/simple;
	bh=rWMK0pbuU1ZlChY6naEC8iRYEsHXpak4RN0IB7hiFh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4VdQQ5xG9zQ1ytXZn9PRaDs7qo//5WQb/1S4RgKkyWBxhem18JwcsY522rCWtv6F7mIMsgDw5LBUuLb8XZnxH+wNZ4lYVjYMOjoeYi9cvRgBdTkG9KnR/4TU6C9smDwe1Y37sjG0JfdhpBz58RkmjVielspwA/NfHIrvgbxUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40MB7RJT062284;
	Mon, 22 Jan 2024 19:07:27 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJS1431Ncz2S70L7;
	Mon, 22 Jan 2024 19:00:08 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Jan 2024 19:07:26 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <axboe@kernel.dk>, <mst@redhat.com>, <jasowang@redhat.com>
CC: <xuanzhuo@linux.alibaba.com>, <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>,
        <sunyibuaa@gmail.com>
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_tagset_wait_request_completed()
Date: Mon, 22 Jan 2024 19:07:21 +0800
Message-ID: <20240122110722.690223-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122110722.690223-1-yi.sun@unisoc.com>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40MB7RJT062284

In some cases, it is necessary to wait for all requests to become complete
status before performing other operations. Otherwise, these requests will never
be processed successfully.

For example, when the virtio device is in hibernation, the virtqueues
will be deleted. It must be ensured that virtqueue is not in use before being deleted.
Otherwise the requests in the virtqueue will be lost. This function can ensure
that all requests have been taken out of the virtqueues.

Prepare for fixing this kind of issue by introducing
blk_mq_tagset_wait_request_completed().

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 block/blk-mq-tag.c     | 29 +++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..cb0ef5f66c61 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -479,6 +479,35 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 }
 EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
 
+static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void *data)
+{
+	unsigned int *count = data;
+
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
+		(*count)++;
+	return true;
+}
+
+/**
+ * blk_mq_tagset_wait_request_completed - Wait for all inflight requests
+ * to become completed.
+ *
+ * Note: This function has to be run after all IO queues are shutdown.
+ */
+void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagset)
+{
+	while (true) {
+		unsigned int count = 0;
+
+		blk_mq_tagset_busy_iter(tagset,
+				blk_mq_tagset_count_inflight_rqs, &count);
+		if (!count)
+			break;
+		msleep(20);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_wait_request_completed);
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a676e116085f..17768e154193 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -891,6 +891,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagset);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
-- 
2.25.1

