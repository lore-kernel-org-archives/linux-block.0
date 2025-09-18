Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BC22E406
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160238; cv=none; b=ta9LF+FtaEddUATrK5UnbQNCIZ1VubrCK9aOwf4OOdQ3uOvcvkKYl+NhesDSfkQ+MbOAyPaqihlc2QQfO/xV0brkA5+E57Tib3mtnWhFG6CFLtHxEPMw/59uZ5udXDJ4tKYO3+vZrlNzWSt49Lsjeu6m+CRCzv1V+gte5sMm73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160238; c=relaxed/simple;
	bh=aihcCgDUah0uIajlVxvCd9cKsxGun+acjCd2aDD6Qe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiGgzkXvmMIe9vwC4ovtUdK/8/HvJRlMwI5v2yE3d5sDWqA6cnt1rbacFGqx2LcplyyYETA4h7DT5v689auAiWIeoyi5qsrbqsWFuY/XDYPSRt1pA++kh0YN7bEFSAH3yCVtDi//oOdq7O8RwaTiHcEaAEy9dqUwIdAmzadpZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FXk83H/O; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FXk83H/O"
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-424164be5b0so68465ab.1
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160235; x=1758765035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI3aBy5hd/OB/zGPV0D+8NoJtVOoBqGtJe9tiG8XJ4M=;
        b=FXk83H/O/QDpXl+2GrMRJU/q+l7FYugLhpymSVHFdhG82j65AK709UT+WvRZyCvGPh
         TkpEjzFRr3LkDIHpRtA/pzdp4aUBuQYM2n3wlj1J7RxpSE4fWOLdN9Capo9p9m6H1M7r
         +C3X3AswunZr/T3hvvwRLKJoXX2I4vNy+YeagJH6CpQlFTdOqOuLNUMS/Qkzh7vCniTd
         YbpCJ09L2vP3MxHDVmnvmBWVTOm6YqfowuA1VVs2yu6c87nZjpsr3UswCKwDq+KrEehv
         CW/WFwHY59oJ7vLS2o4mLID6w9FVPMgZ/gjsKdpyUlr0O1kGUItrpu/soS+LIRzjmPfM
         P1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160235; x=1758765035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI3aBy5hd/OB/zGPV0D+8NoJtVOoBqGtJe9tiG8XJ4M=;
        b=JW84reG69TEO6l9dZyypTuy/Mozby/Cx27si9iICL2hixlcKoZR9L8+fpcfzi6EDsH
         KcG2KrSWj17Md4D73ZVuaIRqQ3tFdPYilw7qMgScdkKq+0ZwGvJM+IbpxlYq7cGsowTM
         3Hmyze9dT7jbKJJ7yqTLaFO3QCmQO+qbSuRWx6Vu6NemXp2ydTlPMkYPiwHOKDYLF3q9
         l7awQ6n/efG6aKFnDWpzDb+OTiFoyE/b4YPAM6yqBmvWIUTB5f9GppC/GICaemmWYx/R
         dyxwh0JTKDF5u/1xFfylFxPE9l5oltrCB6CysG6dKCCF7cX+0KV2/trHrVqvGbk2P7zF
         YO9A==
X-Gm-Message-State: AOJu0YwqdR5h2wCf1KKUFfuj/3QmbYD0AQpt1o/CZUwY56eXM4d6Eh+c
	S01quE34uhER/EdUV9wVDOtDVt/cj0ig/f8jslEn9ZAZdfOuYVBhjbbKnue/HhBCzhhOPZHc5p7
	AjsFWvgJxxckCMNRUQkCaVBYzhoehaxFOFlrbXul9DmMYmFWqQopq
X-Gm-Gg: ASbGnctE/3g5YAkH8CYeJz49W7MfvQ+nni5cmbjAJcHeM9u1Ilb73Ul9gb5AOW5XwiF
	1D6XYrJIBaXcfWlEXmLCZ4dWr0gBw8Wes6XXDvVdZYdEvPNGTWW7uSJV8N1eJAZEJETCAh5gITz
	PzlwTGgYVft0nA+SOJqk7R2HBXnQh9eygp/OdYs651mY6//V41wZe7Y73B4cRBWKFoLwE7Xivcy
	j/fwkvCFb16LBP4LgXRVdSxYsKFR96mDRpJoQTGzgeWNj3eN0ptu0E6OPASopiu4WY0kiSGHtRq
	gVOMVpKnbtTSgvwWu6eSkpzoM6QszjQf3OZJ+n/gS7Chke9FJYTZNAAwYg==
X-Google-Smtp-Source: AGHT+IENRKG99R2VW0x9/thmh8Jnepggaoa54jhETJac3wY0mEKuStB4SCrX1/3ae0dO2b3/sMjdieE7qhXq
X-Received: by 2002:a05:6e02:2781:b0:424:1774:6908 with SMTP id e9e14a558f8ab-4241a3e8592mr22236915ab.0.1758160235222;
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d5106212bsm63180173.28.2025.09.17.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 96B9F340325;
	Wed, 17 Sep 2025 19:50:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 91B4FE41B42; Wed, 17 Sep 2025 19:50:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 02/17] ublk: don't pass q_id to ublk_queue_cmd_buf_size()
Date: Wed, 17 Sep 2025 19:49:38 -0600
Message-ID: <20250918014953.297897-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_queue_cmd_buf_size() only needs the queue depth, which is the same
for all queues. Get the queue depth from the ublk_device instead so the
q_id parameter can be dropped.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9f2db91af481..bac16ec3151c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -760,15 +760,13 @@ ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 static inline int __ublk_queue_cmd_buf_size(int depth)
 {
 	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
 }
 
-static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
+static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub)
 {
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-
-	return __ublk_queue_cmd_buf_size(ubq->q_depth);
+	return __ublk_queue_cmd_buf_size(ub->dev_info.queue_depth);
 }
 
 static int ublk_max_cmd_buf_size(void)
 {
 	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
@@ -1701,11 +1699,11 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	q_id = (phys_off - UBLKSRV_CMD_BUF_OFFSET) / max_sz;
 	pr_devel("%s: qid %d, pid %d, addr %lx pg_off %lx sz %lu\n",
 			__func__, q_id, current->pid, vma->vm_start,
 			phys_off, (unsigned long)sz);
 
-	if (sz != ublk_queue_cmd_buf_size(ub, q_id))
+	if (sz != ublk_queue_cmd_buf_size(ub))
 		return -EINVAL;
 
 	pfn = virt_to_phys(ublk_queue_cmd_buf(ub, q_id)) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
@@ -2563,11 +2561,11 @@ static const struct file_operations ublk_ch_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
 static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
-	int size = ublk_queue_cmd_buf_size(ub, q_id);
+	int size = ublk_queue_cmd_buf_size(ub);
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2590,11 +2588,11 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	spin_lock_init(&ubq->cancel_lock);
 	ubq->flags = ub->dev_info.flags;
 	ubq->q_id = q_id;
 	ubq->q_depth = ub->dev_info.queue_depth;
-	size = ublk_queue_cmd_buf_size(ub, q_id);
+	size = ublk_queue_cmd_buf_size(ub);
 
 	ptr = (void *) __get_free_pages(gfp_flags, get_order(size));
 	if (!ptr)
 		return -ENOMEM;
 
-- 
2.45.2

