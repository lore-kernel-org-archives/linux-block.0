Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702534;
	b=qz8E+gyFzCpUleTmZFSsB4xeRqlkegKjp5xnGsrYb5JtobOZYEoDJ3LmkIAh+t2uEHaL
	 De6rkrxAgY/vt5Eyfylns9Mq6ssf/6/ZSwLn/4WuC4/yce6rIB4LWMg1BgILx785Ibjt9
	 A4OMT0lE4MYs/Agv99VJiGpMMkYYvrtIrtW8R/CjFt7QxooDcD/z4VDclCwIbV7gfxr6J
	 isyaUiiHAwMhWY7kvdJCNZualjuHOlFRJuYqRhtAAa/6yDOUW4CdG+dq+nMhmPTaSGki5
	 6HVptaH04LWP5csOL1OgOdYjwcrjdwrbIjs2vAViUeeJ/0e+dfK+M/vg0pkLOErBYlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702534;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=ReTrihaaRabtR47CqLaW3Lxkmv9zbkz3G+ix5184sfA=;
	b=sVNYKP5ZEzk3mL/QpQITMTxWuTPf5z8L9aEUUyAEsSscJdUooxkV1PN2vCKEUZFxs0kM
	 ifvqsIIuhASdmR6twhZ+2VClgIiU8luyr1kS2VzWaRL4iqAZ4jyiK/jlQMft2EwZfSTob
	 mN2RUZRJ0bmQR5ehS6mjMia00aLlQRSfXKpUhpIXm0S+UGxD+dPkYPPpMz4tBkmCXWnMU
	 ssFzyZQbLzH5Kxm2e/EfvOJ3ilDD8+DfuyB8oEa+Z/hO54GBf9JoUw6jySHiieBRRDSSb
	 L0OaK9W8bwHNTxQLh9GUf5m3iZEbYMHoKIdzOwQG19sfQMVI6+xCRrA2hpuxDBxLljg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TZLSp0Za;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED00606C577;
	Tue,  3 Nov 2026 10:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ED00606C577
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TZLSp0Za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ReTrihaaRabtR47CqLaW3Lxkmv9zbkz3G+ix5184sfA=; b=TZLSp0ZalJDXUcqFPq5D7mMOE7
	2lD0b63/ZKViVjMExVT9AN18WWjfKTonTOm5bm+iQTOpYJX5BofbxIhCeN6iobyFonVexqkwPltZq
	n0Q17a2JsTKc/zIv+lS8QYuy7j4EhB3jCjVaDdmHhhnO4k0OBeetxVKNWGveKv3DtNXDMkpzHinVO
	Y2xq0q0ZEGhvQHYe9KWIrQ2ENVFvp3z1x61bCh8BuF2b1W/UC+fnv6JnJWl66wQGNCWvyWrvp32lX
	+HUSZnoBjnuH1kMBo5CjwgBhskCHHF93DtzxJXiuwfRnYEqcezBS9UbPu9g9pKhg4BNKRc99LFBkD
	31e54evg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBy1-0000000238E-33rQ;
	Tue, 03 Nov 2026 10:42:13 +0000
Date: Tue, 3 Nov 2026 02:42:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid repeated notifications for dead disks
Message-ID: <aum6hZ6u9G4bNyCU@infradead.org>
References: <20261031171325.4073830-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031171325.4073830-2-thnkslprpt@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 31, 2026 at 07:13:26PM +0200, Avi Weiss wrote:
> blk_mark_disk_dead() reports disk death even when GD_DEAD is already
> set. For example, NVMe reset failure and subsequent namespace removal
> can call it twice, repeating holder mark_dead callbacks.
> 
> Only report disk death when __blk_mark_disk_dead() first sets GD_DEAD.
> Keep its existing return value for queue drain handling in
> __del_gendisk().

This would be much simpler if we move the test_and_set_bit of GD_DEAD
into the callers:

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..7e4570f9cea7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -659,12 +659,6 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 
 static bool __blk_mark_disk_dead(struct gendisk *disk)
 {
-	/*
-	 * Fail any new I/O.
-	 */
-	if (test_and_set_bit(GD_DEAD, &disk->state))
-		return false;
-
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 
@@ -689,17 +683,19 @@ static bool __blk_mark_disk_dead(struct gendisk *disk)
 void blk_mark_disk_dead(struct gendisk *disk)
 {
 	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
-	__blk_mark_disk_dead(disk);
-	blk_report_disk_dead(disk, true);
+	if (!test_and_set_bit(GD_DEAD, &disk->state)) {
+		__blk_mark_disk_dead(disk);
+		blk_report_disk_dead(disk, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
 static void __del_gendisk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	bool start_drain = false;
 	struct block_device *part;
 	unsigned long idx;
-	bool start_drain;
 
 	might_sleep();
 
@@ -727,9 +723,11 @@ static void __del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	start_drain = __blk_mark_disk_dead(disk);
-	if (start_drain)
-		blk_freeze_acquire_lock(q);
+	if (!test_and_set_bit(GD_DEAD, &disk->state)) {
+		start_drain = __blk_mark_disk_dead(disk);
+		if (start_drain)
+			blk_freeze_acquire_lock(q);
+	}
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
