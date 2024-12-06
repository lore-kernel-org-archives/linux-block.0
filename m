Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC203D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473367; cv=none; b=pRUGCd1u+Mg+IvLDYPmyFE1HfQLj7VeEa3zKLW1OEOOhfH8x7yMpcso3erF8nV44FDzEsM3t7EmYsVoAGFayDMOE1SWQ+Lg4MI+d06rSJo/Ty6BzFBXUIzzhi1j4l8tmcK+bMu/wBm+nHxdGIXRNYcecqbmpvOSJcxAKalRMkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473367; c=relaxed/simple;
	bh=2oPIYu2XDu1bMFb6lG3adoh3yGDOzYdDvr+B54LR9wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHEQkza30nPd7jTn6/biffhGAeonK/E/APaVlGU041N6IqJTUIjdTSZisqYvc9VxkiBscUNv0s3bH8f3Xkp90KaxzT9G+deuIdyjmWO0txH3uTupO0p7vTRMEhuRdyaQaknnSg12Oy7MQsu5xbJDygkG2gkDcGuZtHMzz7Jgzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pz/y4Ols; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pz/y4Ols"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGaaRf1WvXqk0+ZbmbiORzv6Xjsd1DlYTsaS8yOqyzk=;
	b=Pz/y4Ols2/K/wyxDrUW0s1Sqau0B6DfrBAAIAtNtsOY02Zdw8+woMNvM864ReUx+xXy2Ai
	KCu092GXmUq8LoYcmDj6PAYfwBFhw+oYP3oODTVbj0JDZ25PvpEIaflI3/WM0YLoH+a8OB
	eOavhwJ3bJcVm4mo2tftgztx5W9xjeo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-7oucmW5rNY-u8mrZTqMRDg-1; Fri,
 06 Dec 2024 03:22:43 -0500
X-MC-Unique: 7oucmW5rNY-u8mrZTqMRDg-1
X-Mimecast-MFC-AGG-ID: 7oucmW5rNY-u8mrZTqMRDg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3D761956088;
	Fri,  6 Dec 2024 08:22:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 899F81955F3F;
	Fri,  6 Dec 2024 08:22:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] ubd_drv: fix io command buffer mapping
Date: Fri,  6 Dec 2024 16:21:59 +0800
Message-ID: <20241206082202.949142-6-ming.lei@redhat.com>
In-Reply-To: <20241206082202.949142-1-ming.lei@redhat.com>
References: <20241206082202.949142-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Unit of vma->vm_pgoff is PAGE_SIZE, so have to compute physical offset
first.

Without this patch, io command buffer gets corrupted in case of MQ.

Fixes: 54f5156aa8d1 ("ubd_drv: prepare for supporting MQ")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ubd_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ubd_drv.c b/drivers/block/ubd_drv.c
index 3b3723d78084..bbcbb2f05840 100644
--- a/drivers/block/ubd_drv.c
+++ b/drivers/block/ubd_drv.c
@@ -558,14 +558,17 @@ static int ubd_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct ubd_device *ub = filp->private_data;
 	size_t sz = vma->vm_end - vma->vm_start;
 	unsigned max_sz = UBD_MAX_QUEUE_DEPTH * sizeof(struct ubdsrv_io_desc);
-	unsigned long pfn, end;
+	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
 	int q_id;
 
 	end = UBDSRV_CMD_BUF_OFFSET + ub->dev_info.nr_hw_queues * max_sz;
-	if (vma->vm_pgoff < UBDSRV_CMD_BUF_OFFSET || vma->vm_pgoff >= end)
+	if (phys_off < UBDSRV_CMD_BUF_OFFSET || phys_off >= end)
 		return -EINVAL;
 
-	q_id = (vma->vm_pgoff - UBDSRV_CMD_BUF_OFFSET) / max_sz;
+	q_id = (phys_off - UBDSRV_CMD_BUF_OFFSET) / max_sz;
+	pr_devel("%s: qid %d, pid %d, addr %lx pg_off %lx sz %lu\n",
+			__func__, q_id, current->pid, vma->vm_start,
+			phys_off, sz);
 
 	if (sz != ubd_queue_cmd_buf_size(ub, q_id))
 		return -EINVAL;
-- 
2.31.1

