Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65314A4CC
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323287; cv=none; b=cPPfQIsO+AiL/6TsmOqZ7+QhkpC+J5GQbpmcVxxNYeX1uVrJeFxvV7d45hprLgcRGfXfrzCMA6tng49zp4LVO49xbwE2ylnZYaCTniRSeCd4wqqxK9HE5E/C2YTFabbmH7LMSAOyLmgYYx4ga+ZNCyp65Pj/TwAZwXgnvS5Eo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323287; c=relaxed/simple;
	bh=0uPxHOJ+sj69W/L/OkLAMnrWb0DbLrUmsy57DgXu5Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrhlyP25JmVkCXii61IGJUpW2PaHywRLIV8SMXfzNez5IjtvwjJrU+3WBy66pTRbCKAHgOHevV/0rfhSj3mn53Vg08y6dx+MpC0xY//JnTKu7hRw4/l69VXnPhgSqv10ozzZKn7tWFqkDV1CZstIO0fD0xOOzJSaFJb8mfusrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwLxximy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwLxximy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731323285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UVl+OBJhB8sRg3MP+KVq5HyvNgJbxxEQa9bNm4wE2mA=;
	b=DwLxximyzEggKCCKaFhnkZGpBDQ2OtKlDlN2jcIxdee8a16MSTUgaYpcVCK1rPO0cyHqC6
	uNQLBYA8qlg26/Fg13WVDAS4cQpPQiDcPcr3uipZZjTckLenqY57Ppw3t3Zga/VHeehzgQ
	DwOv7jTMncL/G6vQWIWAmZW4Wu39Phg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-8U0PZwMyNbW6TwY59GFrCg-1; Mon,
 11 Nov 2024 06:08:03 -0500
X-MC-Unique: 8U0PZwMyNbW6TwY59GFrCg-1
X-Mimecast-MFC-AGG-ID: 8U0PZwMyNbW6TwY59GFrCg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99CF51955F3C;
	Mon, 11 Nov 2024 11:08:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CEBE300019E;
	Mon, 11 Nov 2024 11:08:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: fix ublk_ch_mmap() for 64K page size
Date: Mon, 11 Nov 2024 19:07:18 +0800
Message-ID: <20241111110718.1394001-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In ublk_ch_mmap(), queue id is calculated in the following way:

	(vma->vm_pgoff << PAGE_SHIFT) / `max_cmd_buf_size`

'max_cmd_buf_size' is equal to

	`UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc)`

and UBLK_MAX_QUEUE_DEPTH is 4096 and part of UAPI, so 'max_cmd_buf_size'
is always page aligned in 4K page size kernel. However, it isn't true in
64K page size kernel.

Fixes the issue by always rounding up 'max_cmd_buf_size' with PAGE_SIZE.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 59951e7c2593..4ae4fdb8bb7f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -669,12 +669,21 @@ static inline char *ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
 
+static inline int __ublk_queue_cmd_buf_size(int depth)
+{
+	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
+}
+
 static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 
-	return round_up(ubq->q_depth * sizeof(struct ublksrv_io_desc),
-			PAGE_SIZE);
+	return __ublk_queue_cmd_buf_size(ubq->q_depth);
+}
+
+static int ublk_max_cmd_buf_size(void)
+{
+	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
 }
 
 /*
@@ -1358,7 +1367,7 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct ublk_device *ub = filp->private_data;
 	size_t sz = vma->vm_end - vma->vm_start;
-	unsigned max_sz = UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc);
+	unsigned max_sz = ublk_max_cmd_buf_size();
 	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
 	int q_id, ret = 0;
 
-- 
2.44.0

