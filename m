Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141A1DFDE;
	Sun, 20 Oct 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435253; cv=none; b=P70fNxsKQkQkeHljVi1G3nkhXELfrWByZbVsJGYdyOngauVsOfo7IbteUr3sTHzcL0omQXQ6UxSj6wkmmVk4PZjnn5p+gwU5Non4/VDi+QwIFCe0trzoN48WTyvTTnXkpM9lb0WGCvH7hdrL72VNNDeqiI5pFKkPMt+jFmSxm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435253; c=relaxed/simple;
	bh=ZOyF1uST6LI2Kd4g149Kr79ccs0og3AwNC4M61JitYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvH7Lm3iR9ZTO9fNzxev2mKDGEDQcbXs7D5Fi329BMrXmHMcph8jzRXYbpphEmxMzNRkff6iBNhmJydK0DcDK93hHRCFhJypLGI0D3bahmC6m72Q28vth0JyaSg4Ot6JYRMvSD7e/EtNuPzTHAWlHF5j1+oFfYx4nv2YhLMeerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUC064BA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUC064BA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so566776a91.0;
        Sun, 20 Oct 2024 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729435250; x=1730040050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRn4Amd24EVDYVUH1i1mZ9/GKGJm5YlRavS+SEAAK/Y=;
        b=WUC064BA7R66jFy3ZxJTpqH/mm/tldd8Bax4fKnBCpeyFJ7zBeEYTt+Znv1XARCkvK
         iKT9h/nQlLkCvJkIUupRZ43uQ2fBkGuubmWMWrcDVVqnWF/7Qp0TUDQMjl2BMxGt4/DG
         vKP3XqO5y65plR4EP4uIQC/rRlaVqb4xdEfylMeQ8WV0A0ffplVqeGcqzTvw/iTvPFfm
         isgqtnQZsDAKZTAAOnNMJyZjWR9egsc9Qg/ynubwD6hr9+ajuPf40YoGy7eI8Mqw35jW
         sGMuAtcxsb3Bpvn+91yqFSVNFwAIBmTRdHGGPZ0VPybRF8eMwuurPG4GNmFQuxtbyMG5
         UJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729435250; x=1730040050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRn4Amd24EVDYVUH1i1mZ9/GKGJm5YlRavS+SEAAK/Y=;
        b=rUo1Y9oDhBVTzpQO0lq57CNSucCYEcqbvlQlWL6hT48o2grRoNd3cde0F/pXG9N6Hg
         k7As9XQSf6uynhjrBZrukNzksvp+R/M7vMt4fxwhy74viC3BABH85Snz3KjkNXacaK4u
         umZU9SHEnGms2OmOLdkBt78NV0Ghtf9HfEb/vSw0w58o/Yv7Q34pXQLYPbf92qXSnsAu
         GOMUWnlfxsDHPiJqCEb2S3b2jxaVTclIR+haX8TWckZAfKJh0YESrD2rpkBEmDhVAmZm
         K4XIf2zaSrESj+ExvuwYObt50VK7+Eopl8c05MtwqdjUPuSSTUF/Yc2nTd5FKRwv7mCu
         rkmg==
X-Forwarded-Encrypted: i=1; AJvYcCVbK9BESE+Ez32W4mKLyPj8zgDAOYvZDdrfa0Z3IE+8x+/ASsMRVBnd7gHQQbQKK+R1LEgOR0hZW4HGIw==@vger.kernel.org, AJvYcCX/+5lImsJGcTXLplxqIffzjAg/nVvAKCUNN7kdSIcC2X9rxoNOYNfTUDxan58h+ojJbAwvHc6szA0IZdZs@vger.kernel.org
X-Gm-Message-State: AOJu0YyORlqZvwPiMVxYKA/Q7fYJwP+jjt+wTLo1ekuhQlcF8CQxroZt
	V9BUinvqMEy9CZQ8U+HItNiLIpWbN9ACFOvV1BJhI8NzmYpJpUTi
X-Google-Smtp-Source: AGHT+IH0hiFp3O8QAFN+JSAxhXXkRWwP1nxuqIDaTUk68eT9XVPNqtCv6Pt30CcdJFdko3SP8VS4Qw==
X-Received: by 2002:a05:6a00:2d0e:b0:71e:5b2b:9927 with SMTP id d2e1a72fcca58-71ea31d019dmr5108215b3a.1.1729435250347;
        Sun, 20 Oct 2024 07:40:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7668sm1223326b3a.129.2024.10.20.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 07:40:49 -0700 (PDT)
From: zhuxiaohui <zhuxiaohui400@gmail.com>
X-Google-Original-From: zhuxiaohui <zhuxiaohui.400@bytedance.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	ming.lei@redhat.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq ctx fallback
Date: Sun, 20 Oct 2024 22:40:41 +0800
Message-ID: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>

It is observed that nvme connect to a nvme over fabric target will
always fail when 'nohz_full' is set.

In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
and when nvme connect to a remote target, it may fails on this stack:

        blk_mq_alloc_request_hctx+1
        __nvme_submit_sync_cmd+106
        nvmf_connect_io_queue+181
        nvme_tcp_start_queue+293
        nvme_tcp_setup_ctrl+948
        nvme_tcp_create_ctrl+735
        nvmf_dev_write+532
        vfs_write+237
        ksys_write+107
        do_syscall_64+128
        entry_SYSCALL_64_after_hwframe+118

due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
blk_mq_ctx on the hw queue.

This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
indicate that block layer can fallback to a  blk_mq_ctx whose cpu
is not isolated.

Signed-off-by: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
---
 block/blk-mq.c              | 12 ++++++++++--
 drivers/nvme/host/core.c    |  5 ++++-
 drivers/nvme/host/fabrics.c |  3 ++-
 drivers/nvme/host/nvme.h    |  2 ++
 include/linux/blk-mq.h      |  4 +++-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf626e061dd7..e4e791fd6d80 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -654,8 +654,16 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids)
-		goto out_queue_exit;
+	if (cpu >= nr_cpu_ids) {
+		if (!(flags & BLK_MQ_REQ_ARB_MQ))
+			goto out_queue_exit;
+		/* fallback to the first cpu not isolated */
+		for_each_online_cpu(cpu) {
+			if (!cpu_is_isolated(cpu))
+				break;
+		}
+	}
+
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (q->elevator)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..dbb9cb59e54c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,9 +1130,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		blk_flags |= BLK_MQ_REQ_RESERVED;
 	if (qid == NVME_QID_ANY)
 		req = blk_mq_alloc_request(q, nvme_req_op(cmd), blk_flags);
-	else
+	else {
+		if (flags & NVME_SUBMIT_ARB_MQ)
+			blk_flags |= BLK_MQ_REQ_ARB_MQ;
 		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), blk_flags,
 						qid - 1);
+	}
 
 	if (IS_ERR(req))
 		return PTR_ERR(req);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 432efcbf9e2f..ef34958e33c0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -539,7 +539,8 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 			data, sizeof(*data), qid,
 			NVME_SUBMIT_AT_HEAD |
 			NVME_SUBMIT_RESERVED |
-			NVME_SUBMIT_NOWAIT);
+			NVME_SUBMIT_NOWAIT |
+			NVME_SUBMIT_ARB_MQ);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..a61b35b1cd90 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -880,6 +880,8 @@ enum {
 	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
 	/* Retry command when NVME_STATUS_DNR is not set in the result */
 	NVME_SUBMIT_RETRY = (__force nvme_submit_flags_t)(1 << 3),
+	/* Submit command with arbitrary mq ctx */
+	NVME_SUBMIT_ARB_MQ = (__force nvme_submit_flags_t)(1 << 4),
 };
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..d14be341ea4b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -746,6 +746,8 @@ enum {
 	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
 	/* set RQF_PM */
 	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 2),
+	/* use arbitrary mq ctx */
+	BLK_MQ_REQ_ARB_MQ	= (__force blk_mq_req_flags_t)(1 << 3),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
@@ -824,7 +826,7 @@ static inline int blk_mq_request_completed(struct request *rq)
 }
 
 /*
- * 
+ *
  * Set the state to complete when completing a request from inside ->queue_rq.
  * This is used by drivers that want to ensure special complete actions that
  * need access to the request are called on failure, e.g. by nvme for
-- 
2.39.5

