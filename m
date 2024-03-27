Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03114D6EA
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560112; cv=none; b=tlDS7ekCqNgNIZclT+U6GlFiAxdwwfyOiqiz+NvZf9s1mqBwLu8IHMp+Zy2ntKrJWsKMzyw4jOJ2KocPsZAt4Aobw9L+yngc/fMIknY1uCdz6E8CYZQomZqm/kC5Xyz2ajgdtUZXicQ07ZPC+zXxSvaGrt051qIqqPoXU3ECSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560112; c=relaxed/simple;
	bh=xBDlBQTeionAa7BitgK6+Y1KkNbqDzeo3ZWLYmN7Yn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UreZuhl/38jnBTn/q5JMvbsZjDVmxv/yZUGmXlPXQsMvybDFiXa+Z0pROFbBtuRKUyuS3oHLM152HHulmEvs8/Qhee/4p4wcVWH5Y1ty0YwaVlc7g+lN2pqo2LYT8zMpOkMwv30ZR6ekXrKKtgSW7kISOYZY4bEAQs73ZuLfhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jG/QyNM7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jG/QyNM7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DZ0DaQAcEntvKxWanANi3dsLKA1cy5dkz9RnbD1mfQw=; b=jG/QyNM7r9QuiZIXh+DbrkWBwb
	cgzwfFABhfUpmuz416KPQrM7prhsXHePlgDTUKhJ7eotQRYqLEHbZrCPm04D5APoQ2AtNEfim+0v+
	1FTSWi2IncaMlxmOU/MGVSjxI0DfBAWjSpV1N/esqbf3Os1b117j5dEyi1BMwIfzp0+/8dHdBSw50
	xd7FjX4z4Tin1/5YFBxfE/krVKeZdz6zvifzJWsX9mrnh0okhEPrawiP66wMRUdE2NM9vCV1SJELL
	7UZ2RFwZ/o35g04Q9RZNH8PqbUwRV4shDpHXXq17U51PNKquQiLzXeQXtlGbrBsZLEYUY8lzoFmvG
	K//4tGwg==;
Received: from 089144220178.atnat0029.highway.webapn.at ([89.144.220.178] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWyD-0000000AH5M-1whv;
	Wed, 27 Mar 2024 17:21:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a helper to cancel atomic queue limit updates
Date: Wed, 27 Mar 2024 18:21:44 +0100
Message-Id: <20240327172145.2844065-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drivers might have to perform complex actions to determine queue limits,
and those might fail.  Add a helper to cancel a queue limit update
that can be called in those cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9b87c39cab047..39fedc8ef9c41f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -892,6 +892,19 @@ int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
 
+/**
+ * queue_limits_cancel_update - cancel an atomic update of queue limits
+ * @q:		queue to update
+ *
+ * This functions cancels an atomic update of the queue limits started by
+ * queue_limits_start_update() and should be used when an error occurs after
+ * starting update.
+ */
+static inline void queue_limits_cancel_update(struct request_queue *q)
+{
+	mutex_lock(&q->limits_lock);
+}
+
 /*
  * Access functions for manipulating queue properties
  */
-- 
2.39.2

