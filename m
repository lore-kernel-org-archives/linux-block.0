Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BF3264FA
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646074; cv=none; b=jriKVi2TwJenADSKmS+Sse1tH5jzNtThnl9bl95gRsXDaWrYN35W7tpNhg1ihaPHN+5WYEfZrdu98ibE0pyMHKfS6ETMWxCnSxzfu7uhX1dj4y5Wxs5AUJigPlyoYv8Yt28ELFnocWFWjRih2BCfjxuXxpIAAi6J1IqijcR8jGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646074; c=relaxed/simple;
	bh=IJiaKf9dpzCPsKjFVld6H8pg5IZJwyl9iXgObDj0y7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKGMKEdGje2iKUdKh4xnP2avsHUQ65jjXafnVPfEPyiNC+p0HTYn4lf3mDWXPc5hy+hl5DrMoTE7WltblzlzFzKL9E2bkINdVNAhQlNYfwysJAr9e+sKcUMILEOQMlfTVqyQq7/FTAcHudbxTuIaAwJdAqexX2+EA4wq+NVPPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sNagp7Vj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sNagp7Vj"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD150XSrzlfvq4;
	Fri, 27 Mar 2026 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774646058; x=1777238059; bh=jMTmE
	SdzD/Kur7zHz14kWcWb0BpuhM6IWSAWJ814Asw=; b=sNagp7Vjl/q0Aqw/vHS8u
	gDqNHFWPgmk8m2S/YIXWVJElV07nStt5Vo3Amteq7srFZTqiRysL8rARE2Co/HML
	+dyqVNRWzYOLSFPeIVrjLz2Id8SN9mesOnBvwjNGIjXQpX9/KI3TeO3FjVwtohkP
	hcwPNFsNSKPh5UeXnqtk1ner8OR4vG9RWrR6M6jwDLBJpYztXYYdapkLaqkFLykM
	crfZw70fo2gVBXla9vkWjkKtMXUnkFpB2mVYtavPtzvQOHWx92ULHhyGC2EW5+vM
	dez7r6Qgm0IX7E4eBMuCfuUfav4i8XnCd/ybNqeBIsAdF9f4nkQTxwI701ly/DAR
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7Tzg3h4c0RUb; Fri, 27 Mar 2026 21:14:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0j28SfzlfvqD;
	Fri, 27 Mar 2026 21:14:13 +0000 (UTC)
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 5/6] null_blk: Support configuring the maximum DMA segment size
Date: Fri, 27 Mar 2026 14:13:45 -0700
Message-ID: <20260327211349.2239633-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260327211349.2239633-1-bvanassche@acm.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for configuring the maximum DMA segment size. The maximum DMA
segment size may be set to a value smaller than the virtual memory page
size. Reject invalid max_segment_size values.

Since rq_for_each_segment() may yield bvecs larger than the maximum DMA
segment size, add code in the rq_for_each_segment() loop that restricts
the bvec length to the maximum DMA segment size.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     | 43 +++++++++++++++++++++++++++++++
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index f8c0fd57e041..d5fbbc5d63ed 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -169,6 +169,32 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sector=
s)");
=20
+static unsigned int g_max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
+
+static int nullb_set_max_segment_size(const char *val,
+				      const struct kernel_param *kp)
+{
+	int res;
+
+	res =3D kstrtouint(val, 0, &g_max_segment_size);
+	if (res < 0)
+		return res;
+
+	if (g_max_segment_size < BLK_MIN_SEGMENT_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct kernel_param_ops max_segment_size_ops =3D {
+	.set =3D nullb_set_max_segment_size,
+	.get =3D param_get_uint,
+};
+
+module_param_cb(max_segment_size, &max_segment_size_ops, &g_max_segment_=
size,
+		0444);
+MODULE_PARM_DESC(max_segment_size, "Maximum size of a DMA segment in byt=
es");
+
 static unsigned int nr_devices =3D 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -442,6 +468,14 @@ static int nullb_apply_poll_queues(struct nullb_devi=
ce *dev,
 	return ret;
 }
=20
+static int nullb_apply_max_segment_size(struct nullb_device *dev,
+					unsigned int max_segment_size)
+{
+	if (max_segment_size < BLK_MIN_SEGMENT_SIZE)
+		return -EINVAL;
+	return 0;
+}
+
 NULLB_DEVICE_ATTR(size, ulong, NULL);
 NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
 NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
@@ -450,6 +484,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_segment_size, uint, nullb_apply_max_segment_size);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -608,6 +643,7 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {
 	&nullb_device_attr_index,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_max_segment_size,
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_no_sched,
@@ -805,6 +841,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode =3D g_queue_mode;
 	dev->blocksize =3D g_bs;
 	dev->max_sectors =3D g_max_sectors;
+	dev->max_segment_size =3D g_max_segment_size;
 	dev->irqmode =3D g_irqmode;
 	dev->hw_queue_depth =3D g_hw_queue_depth;
 	dev->blocking =3D g_blocking;
@@ -1248,6 +1285,9 @@ static blk_status_t null_transfer(struct nullb *nul=
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
@@ -1295,6 +1335,8 @@ static blk_status_t null_handle_data_transfer(struc=
t nullb_cmd *cmd,
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len =3D bvec.bv_len;
+		len =3D min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len =3D len;
 		if (transferred_bytes + len > max_bytes)
 			len =3D max_bytes - transferred_bytes;
 		err =3D null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
@@ -1958,6 +2000,7 @@ static int null_add_dev(struct nullb_device *dev)
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
