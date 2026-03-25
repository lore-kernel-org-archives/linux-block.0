Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E62DF707
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474680; cv=none; b=hCl9vtgzfLwk53zJp3GX+oX9YmVYmLgrfyFo9szg7JBYEInHCVRJFAdkPQkNyTPAmXBw97sUnUA7/yoYpEVwstXwlZO2Ge+jr5dufJ+0vBmwyzhQGimRYYYMZhyZVnza6fc9CUO2fMFMiq6BeY+awp+hcXCnXhL3gKLAndm7/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474680; c=relaxed/simple;
	bh=9OB6xke2ZbCT8r6Nde15MDC5e/w0yiydX42bwLUPHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5uE3w4BzOe0rmGJjIP24Z9zGgxm9a8nms0PspmVq38oB21atqetNR/MbdDFl8gcXJIdoi048xMM6nU1kjigh6o0sxV6nOjp4GE3OssNugcUDkOMgtMtOa7h8ANvh5PGIAm1m/HCFqJv1dr8EAGMnAWkP718YSKm80coORo66do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tHEOQdyR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tHEOQdyR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0d24JChzlfddm;
	Wed, 25 Mar 2026 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774474666; x=1777066667; bh=zFlGJ
	5Hg/sD1f2lbwWI5MSAAXvxQgejRh5Mze14GvXw=; b=tHEOQdyRboegR9trvoHCk
	ox+hUuUlvmiZfDOIw+0ZCV7cfgAD+8M04db3uGCFv8N1weHXWglC0Y5R31PRzH02
	sX1WYgra3bslm33xtbZer6wJpgE6H6hQt6lL04e9xO3pqvrquYTYRgHu9XHkNfdg
	gnhF0Ep4+/MrMoFXewVcnvxd+2BzPaXOJcxrJh4JyeeFZd3EYBOOXvv4WK5RGL+J
	GqXvPJYS19eq7XmSejaawgtBJ7CpJN/qbq/WZrgedMqOrQg5vUpL/38Yp01CmyVR
	YGSWxduP4onbgfxUqpyn3RI317lK4W7408KLfus5JKKMcmbdp/i8gFnFaaUvxxBn
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AWqTl2gBGToR; Wed, 25 Mar 2026 21:37:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0ck3370zlfgS0;
	Wed, 25 Mar 2026 21:37:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 5/5] null_blk: Support configuring the maximum DMA segment size
Date: Wed, 25 Mar 2026 14:37:15 -0700
Message-ID: <20260325213719.2850619-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325213719.2850619-1-bvanassche@acm.org>
References: <20260325213719.2850619-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for configuring the maximum DMA segment size. The maximum DMA
segment size may be set to a value smaller than the virtual memory page
size. No checks are performed on the new max_segment_size parameter
because all positive values are valid. The value 0 is converted into a
valid value by blk_validate_limits().

Since rq_for_each_segment() may yield bvecs larger than the maximum DMA
segment size, add code in the rq_for_each_segment() loop that restricts
the bvec length to the maximum DMA segment size.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     | 13 +++++++++++++
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 677ac829ef80..c43d74cdfd23 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -169,6 +169,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sector=
s)");
=20
+static unsigned int g_max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
+module_param_named(max_segment_size, g_max_segment_size, int, 0444);
+MODULE_PARM_DESC(max_segment_size, "Maximum size of a DMA segment in byt=
es");
+
 static unsigned int nr_devices =3D 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -450,6 +454,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_segment_size, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -608,6 +613,7 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {
 	&nullb_device_attr_index,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_max_segment_size,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_no_sched,
@@ -805,6 +811,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode =3D g_queue_mode;
 	dev->blocksize =3D g_bs;
 	dev->max_sectors =3D g_max_sectors;
+	dev->max_segment_size =3D g_max_segment_size;
 	dev->irqmode =3D g_irqmode;
 	dev->hw_queue_depth =3D g_hw_queue_depth;
 	dev->blocking =3D g_blocking;
@@ -1251,6 +1258,9 @@ static blk_status_t null_transfer(struct nullb *nul=
lb, struct page *page,
 	unsigned int valid_len =3D len;
 	void *p;
=20
+	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
+		  dev->max_segment_size);
+
 	p =3D kmap_local_page(page) + off;
 	if (!is_write) {
 		if (dev->zoned) {
@@ -1298,6 +1308,8 @@ static blk_status_t null_handle_data_transfer(struc=
t nullb_cmd *cmd,
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len =3D bvec.bv_len;
+		len =3D min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len =3D len;
 		if (transferred_bytes + len > max_bytes)
 			len =3D max_bytes - transferred_bytes;
 		err =3D null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
@@ -1961,6 +1973,7 @@ static int null_add_dev(struct nullb_device *dev)
 		.logical_block_size	=3D dev->blocksize,
 		.physical_block_size	=3D dev->blocksize,
 		.max_hw_sectors		=3D dev->max_sectors,
+		.max_segment_size	=3D dev->max_segment_size,
 		.dma_alignment		=3D 1,
 	};
=20
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/n=
ull_blk.h
index 6c4c4bbe7dad..43dc47789718 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -93,6 +93,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int max_segment_size; /* Max size of a single DMA segment. */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
