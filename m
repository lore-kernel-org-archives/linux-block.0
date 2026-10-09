Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA392236FA
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514927; cv=none; b=tQJCIvJCte+2VoUqdoTXMgRtwMGmA/wAKkgEaaIX0LZcb14zdelocktd9r1ogsCWxIMGcG3/YfHS30K26koxUTSzEsVB8pbdx9ACswI4Z77Ea7WYYMQGhgQArIzGJJ4FUeru8eQPybTDTP3xcQYxPZXAY9oGaErOq7XqdTo3vw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514927; c=relaxed/simple;
	bh=pwTTpoYMU+flxyPo7EvjWHAvwBdDZcDZfOmnoQwuyk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN0IpP9c88wmpIFEjE6aFgQd4/+rB+wyYrRVuBR6Uoq9l7zpu0pLLdWYoLbGfxwTsnHwqVCRr+WMg+oJqtLniK1aLdKufzcalIuNKsrMUbvFwRHaBFqT8fa4DFyJtZEeviB1PaumaB40bhffkfk+AMLZTHeKjE6+eTWyt/JeQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=qn20xZUd; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="qn20xZUd"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso7617903eec.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 20:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791514926; x=1792119726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBWPAIqvIDVApxQAhC8lxyajSPGZTusmtwDLAKdJnvw=;
        b=qn20xZUd4DmT+c5BxeddguPntwRHPn/uyUplKOKzhZteyFDJebMGcTjBf/gyybeVU2
         tyj8fqrNW5L+i5SzSeCFi7uDLiD1w0x3hiidmokQUX/wxibwjyI8VOi47JqwSpnihzvB
         V2OASxVwxktn63uej6EjPHdjY9ZDBsl3c9TApnZUHQBS/vckIILAAN8eyzKTcAeTc6i7
         E3BPevS2gsOucLzg7qX83dbmGS0jTPk/cDZXAWUO8pnWwOaw2eXYsQksYMm4WBJwPjZ9
         EwQN85LRUqlVzCJJSZaK5mTfJzXObr/NKGr3BCZN70t8m6r1EEx8I9W5KEN5VQXgo3PP
         2xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514926; x=1792119726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wBWPAIqvIDVApxQAhC8lxyajSPGZTusmtwDLAKdJnvw=;
        b=q06/QwAln5LtRh35vuohXo8alruBPmhQ3WrboKmX75JnIryUaOfXaW5+1ul7uH9i45
         XrsNksajLf3x4YIZW2LhiukxN5coXuyH4rsazTEKO1LY5Ydz/umPwx5evG2q7N1dUMJz
         ZvY7eJUEymCqfqX7qh0QowisDEeZhtadej5g28OjKcdXEW7CDaP7sJ7/p4XjK6QjGrWA
         j/5CSDJcd4MSUtNSp6q0Hpr04pn4LCQeLUTB6Fv5GXq9RYMkdjscoFqDPGyh0bFIwfLJ
         Bf8gLWQ7gey/fesqCmAFDnCIOnU4pH2jRQSqfMqv+rXUeHgT1lC3fHpfVtEbBbxVZcm/
         c57A==
X-Gm-Message-State: AFq9FYK+95tBfsaoToteropZMJ4itNGiWhx5U5JYv9saEVw5hJy5mMyP
	VARnlCHOTfxU4pTQ3byphcdUb9NtaoMkWDdtDwRZlYs4vkRlGuu2s17YESs++roabuRhW7qitRD
	bHY+IwLobxaDGpmtkP0YeiXQCWgJe69p8l3hif9dhGIe7QklDxhH3JGX/j9NeKuNFEUvjf8idIQ
	==
X-Gm-Gg: AYBFou0IbDz+7YZ3Q/1UrYoa/iUHiOovsKg6CiNft/eupXvpX9ptbw01B95Ms9vFGnv
	PizjLER4Gn+ZS395ZO8n9LzUlO3OMTkSWiq8N13pzIKB2N/0h3Y6TCFgdngXOuP/jErQahK7FRA
	7hQ77a7+xCT8inwKg21lz+SwFjFkf3KKhRo7iqfR0ifMhPHXTgvJxbLGmp8o33Z1onm6Ih3MzJk
	tkUrMwPBieTuAPYkSJihaaSHEF/GvfrEcFF7fLf9yetD2ytdIiBLYofnCdJwONPuGON7qjizbCM
	T0b7Bam7tE4Liokq4D3dUBBDKL+9ANGT+G0LQpGxHrtw8v+DUsHHhwo/LRINUKg7WvmRTE8AjAX
	UcKoE/cRpTHXFfTHIXK0NgWqtQazDADN6iJnuC2ULWgq/TsJQdIFHq1+sgerOtzRGcdRafYOX0p
	u0hNDhcPNUjcddKtwcGPbTzml9mrLXS0neJ5izNr9E95s4WgNX/sUphFSTUUnlXVtyyY3CCUcAK
	K6TAdSXZW7ZeNUIl5BS
X-Received: by 2002:a05:7301:7d06:b0:351:4d03:c6a with SMTP id 5a478bee46e88-3537df51463mr951196eec.12.1791514925462;
        Thu, 08 Oct 2026 20:02:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm2427626eec.27.2026.10.08.20.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:02:04 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v1 4/4] block: link request queue debugfs directories to tag sets
Date: Fri,  9 Oct 2026 11:01:11 +0800
Message-ID: <20261009030111.57784-5-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tag set debugfs directories use numeric IDs that do not identify their
attached disks. Starting from a disk's debugfs directory therefore gives
no direct way to find its tag set configuration and CPU mappings.

Add a tagset symlink in each blk-mq request queue's debugfs directory,
pointing to ../../tagset/<id>. Queues sharing a tag set link to the same
directory. Create the link only when both debugfs directories exist.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 298387607049..78a91a1095bb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -644,11 +644,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 
 void blk_mq_debugfs_register(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
+	char target[32];
 
 	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
+	if (!IS_ERR_OR_NULL(q->debugfs_dir) &&
+	    !IS_ERR_OR_NULL(set->debugfs_dir) && set->debugfs_id >= 0) {
+		snprintf(target, sizeof(target), "../../tagset/%d", set->debugfs_id);
+		debugfs_create_symlink("tagset", q->debugfs_dir, target);
+	}
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
 			blk_mq_debugfs_register_hctx(q, hctx);
-- 
2.43.0

