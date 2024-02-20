Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4A5DF2B
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418981; cv=none; b=iZAeg7LCyUnNCbRQYaGnxmhoRd4i1DFToyhvvQ2pLPlFE8ZMn/gI0wyhWfv7S0ji3AdEoNjYSypQJ0x17IB3sekIlqCLNVhbT8XeLdEUsLKOZgsPT1qlIgH9FOyk1+Weh0iV7PC6VAqJBrVe8gGCjEY7nipQkbFcqP42YCIAilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418981; c=relaxed/simple;
	bh=OsAFS7njEVGlC+CAlb/I9tE7EFje1TFeh//d1gj2KqI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJPPN/ynmKQI/rHHWaVqvsXAabH8MigP5oVsJN6xUvQnY6FLkOU0J9HfBn1lbvqysIBU1WgjF8a7uwH2NRDo7kph2D6meIt76WnVBcjxX7OFJkBZPKsGZJSeonT9yawE5uE47v+uPBAg+rDRFtV+Wzo/1voB5l9VbLuzfIdc84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q+Xuv9UD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+Xuv9UD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-Type:Content-ID:Content-Description;
	bh=qK76sLiKHDaIugADThNdCeAdCITdHp3R7WCpvZ/50Ys=; b=q+Xuv9UDwXHK+tkLGsYolzNTXG
	R4i+Mt0BZDHHWj0bFjoTaTV4Uf+ZLRjvOqwQnQ1QjdrjASB6LM+HWRzK56SCswy2aYtxd+lwQfOUz
	M1bu2VrcT7cgwkCOsvMNYemtsmevCZLF7gegxUDWG7sE9LYMV7Jb7xt7TyJ/9iUSdR4RG5IIK1ajt
	m5YEP4N9yEmyRAdoE62Vt5brNcei+BJohjnoWUwfYatrm4fKoPJDech8QrTVHR7nWoGlpFKJoBK6e
	/0W1zm/+qrYqHmXJDwLThtVyh3O1D/IfYEdgsCSgxxBHtaCdU8NUXUWYRwFAljvbygirx8S5992Sk
	E75cYLdg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLoo-0000000DnUj-02wS;
	Tue, 20 Feb 2024 08:49:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] xen-blkfront: don't redundantly set max_sements in blkif_recover
Date: Tue, 20 Feb 2024 09:49:34 +0100
Message-Id: <20240220084935.3282351-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220084935.3282351-1-hch@lst.de>
References: <20240220084935.3282351-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blkif_set_queue_limits already sets the max_sements limits, so don't do
it a second time.  Also remove a comment about a long fixe bug in
blk_mq_update_nr_hw_queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 1258f24b285500..7664638a0abbfa 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2008,14 +2008,10 @@ static int blkif_recover(struct blkfront_info *info)
 	struct request *req, *n;
 	int rc;
 	struct bio *bio;
-	unsigned int segs;
 	struct blkfront_ring_info *rinfo;
 
 	blkfront_gather_backend_features(info);
-	/* Reset limits changed by blk_mq_update_nr_hw_queues(). */
 	blkif_set_queue_limits(info);
-	segs = info->max_indirect_segments ? : BLKIF_MAX_SEGMENTS_PER_REQUEST;
-	blk_queue_max_segments(info->rq, segs / GRANTS_PER_PSEG);
 
 	for_each_rinfo(info, rinfo, r_index) {
 		rc = blkfront_setup_indirect(rinfo);
@@ -2035,7 +2031,9 @@ static int blkif_recover(struct blkfront_info *info)
 	list_for_each_entry_safe(req, n, &info->requests, queuelist) {
 		/* Requeue pending requests (flush or discard) */
 		list_del_init(&req->queuelist);
-		BUG_ON(req->nr_phys_segments > segs);
+		BUG_ON(req->nr_phys_segments >
+		       (info->max_indirect_segments ? :
+			BLKIF_MAX_SEGMENTS_PER_REQUEST));
 		blk_mq_requeue_request(req, false);
 	}
 	blk_mq_start_stopped_hw_queues(info->rq, true);
-- 
2.39.2

