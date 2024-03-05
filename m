Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9618613E
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646049; cv=none; b=A6a2GQMKpRNjTzpDZ1t3/bok2Vf0C/KCfcLG8Ut5RahDfIWsQmjRBW8ly9B8EdNRfukhHZ0haTclMVE9DgAKmOjC7/d4ArrrxCI4VpdGz3xT1lQsmyRFaIoCReowA4lia7DxM20hTyk0qtHpQGybR8jO95M8eTUyZxWorYuiFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646049; c=relaxed/simple;
	bh=hzsCenhqVervqFR03nuiQmMOWXDgHrCuxk16LwcLHhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKR2gkhNhS2aDLLH5o0wWJGIG1A5mQJu2n6j7L/ULZ4IlOI+H+K8OdNvZ/Zpp6dS3Qhbsby2fTWw9qE/1FXKNzm+KdG9MkM00h7edG7Vjhl4HMk7Z7DGh4g9SDaAiDKIZ12yoVbFS165siPsy1bXPA6MsPaxl3U0N0Qkv8Ma2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4RndfurZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4RndfurZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HGtAw79TfbpqxN7DjdZnzGM38FdIDqy2dwX3NjUJYVw=; b=4RndfurZVf4hgZKhOw+MHdL7Al
	XmJGWhauhoCg+bS2ZCB3elzlA+Y5V1fln1gh7uiWnD1dNfTBVbbz1oODpsJ7QSl4CXSVHK37IU+Lt
	P+7lYzbopD9yXtQJt1g34ivs/pPckR7SYjX4ryqWIEBEtN5LW+eNyb27qbq0u4o6W97MRu3xVOx7i
	0o3D7afmlSymQp8uPSvt7tAD/6tqCctHhvM+ZkOE/1dVAxQY6wUzAAkt9AzxiXLxaAtD4bbHtdCn1
	UMUzmROnQowAfrHiNz+O9oi/n+XHURck+wH+Sy0WizF2qEP6oVE0vhVDoQXLQ8rMBl/yTrdwM88M2
	P+gN80gA==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2F-0000000DqyR-1ll0;
	Tue, 05 Mar 2024 13:40:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH 6/7] drbd: split out a drbd_discard_supported helper
Date: Tue,  5 Mar 2024 06:40:40 -0700
Message-Id: <20240305134041.137006-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to check if discard is supported for a given connection /
backing device combination.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a79b7fe5335de4..94ed2b3ea6361d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1231,24 +1231,33 @@ static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 	return AL_EXTENT_SIZE >> 9;
 }
 
-static void decide_on_discard_support(struct drbd_device *device,
+static bool drbd_discard_supported(struct drbd_connection *connection,
 		struct drbd_backing_dev *bdev)
 {
-	struct drbd_connection *connection =
-		first_peer_device(device)->connection;
-	struct request_queue *q = device->rq_queue;
-	unsigned int max_discard_sectors;
-
 	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
-		goto not_supported;
+		return false;
 
 	if (connection->cstate >= C_CONNECTED &&
 	    !(connection->agreed_features & DRBD_FF_TRIM)) {
 		drbd_info(connection,
 			"peer DRBD too old, does not support TRIM: disabling discards\n");
-		goto not_supported;
+		return false;
 	}
 
+	return true;
+}
+
+static void decide_on_discard_support(struct drbd_device *device,
+		struct drbd_backing_dev *bdev)
+{
+	struct drbd_connection *connection =
+		first_peer_device(device)->connection;
+	struct request_queue *q = device->rq_queue;
+	unsigned int max_discard_sectors;
+
+	if (!drbd_discard_supported(connection, bdev))
+		goto not_supported;
+
 	/*
 	 * We don't care for the granularity, really.
 	 *
-- 
2.39.2

