Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9627603F
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388685; cv=none; b=hJ99+LXAMVWxHwNyYXsLZcoQO5w3+nju6/iBjx/hlQDllgEC0ijXwYZnCIVlaP7K0FaUnzNPjChtLm9lmSL4jSlYfNrQWAiSYQIxBAHunAbuAbvdko6Uwp8oVWcPbJp37Q/dwUMkMh1scCIlvL2GB6dlX3cr3R5pDQ3P2JjRRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388685; c=relaxed/simple;
	bh=zI2xuo3X7aanvBoL7PYT2vLZns0JhS9Sa3tsijIIagY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRhDwABeG2OhLqAVJVCFvU5QM6RCzOyaxwNl+v3VCPc+P3bqZwPty6z2JOVnGZjA44tevlnPiEkR5+CKgs7wlDfEQoXsEbCWjrf9bQnIDfZ6Hsje5gGs2IsuFP/Zt9mxFKMb3Tv4eNsNhfZj4859KpYpRKvw3C0GrNbUFPbERmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F2GYrm21; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F2GYrm21"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F54viKXNbfgkmQGoZcoZiJTycAgBg1Einp8YcAmFurg=; b=F2GYrm21VS1eUntf49lLebz7BZ
	pVAR30x5OXVQwXPrrpWvusMgYULNaZROZzBcLdC9295aYZ0tkTM6LV1eMKsdt7oACEMzn939uWWe9
	mN/pS2uQGwyrb0buRg7slq8/OD1VzZ6EGC5yvixLRiC0qS38UgJUvkTSyqZ2MXXDrn09WXWovun1z
	kRMpJQ6dmAiAjGZj59l3igAQbSmsoigaTPwONWrEkRlfneeUmmkr138D9aSgBYgAQVpxFTeTQzR6q
	0V0pEH7Ib7S05ii4zC4drwPXC4v8PGRvGBP1Jjn+i6LvXqmO9z6TgTs+yJggIHYZStm1t+x3JQ6lb
	qYCXbRBw==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8qp-00000005inS-1pPk;
	Tue, 08 Oct 2024 11:58:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: also mark disk-owned queues as dying in __blk_mark_disk_dead
Date: Tue,  8 Oct 2024 13:57:50 +0200
Message-ID: <20241008115756.355936-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008115756.355936-1-hch@lst.de>
References: <20241008115756.355936-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When del_gendisk shuts down access to a gendisk, it could lead to a
deadlock with sd or, which try to submit passthrough SCSI commands from
their ->release method under open_mutex.  The submission can be blocked
in blk_enter_queue while del_gendisk can't get to actually telling them
top stop and wake them up.

As the disk is going away there is no real point in sending these
commands, but we have no really good way to distinguish between the
cases.  For now mark even standalone (aka SCSI queues) as dying in
del_gendisk to avoid this deadlock, but the real fix will be to split
freeing a disk from freezing a queue for not disk associated requests.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 14 ++++++++++++--
 include/linux/blkdev.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980b5..ac1c496ad43343 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -589,8 +589,16 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	if (test_and_set_bit(GD_DEAD, &disk->state))
 		return;
 
-	if (test_bit(GD_OWNS_QUEUE, &disk->state))
-		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
+	/*
+	 * Also mark the disk dead if it is not owned by the gendisk.  This
+	 * means we can't allow /dev/sg passthrough or SCSI internal commands
+	 * while unbinding a ULP.  That is more than just a bit ugly, but until
+	 * we untangle q_usage_counter into one owned by the disk and one owned
+	 * by the queue this is as good as it gets.  The flag will be cleared
+	 * at the end of del_gendisk if it wasn't set before.
+	 */
+	if (!test_and_set_bit(QUEUE_FLAG_DYING, &disk->queue->queue_flags))
+		set_bit(QUEUE_FLAG_RESURRECT, &disk->queue->queue_flags);
 
 	/*
 	 * Stop buffered writers from dirtying pages that can't be written out.
@@ -719,6 +727,8 @@ void del_gendisk(struct gendisk *disk)
 	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
 	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
+		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags))
+			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
 		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
 		__blk_mq_unfreeze_queue(q, true);
 	} else {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da2816..391e3eb3bb5e61 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -590,6 +590,7 @@ struct request_queue {
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 enum {
 	QUEUE_FLAG_DYING,		/* queue being torn down */
+	QUEUE_FLAG_RESURRECT,		/* temporarily dying */
 	QUEUE_FLAG_NOMERGES,		/* disable merge attempts */
 	QUEUE_FLAG_SAME_COMP,		/* complete on same CPU-group */
 	QUEUE_FLAG_FAIL_IO,		/* fake timeout */
-- 
2.45.2

