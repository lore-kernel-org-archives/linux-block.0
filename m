Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB662309B9
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160238; cv=none; b=c/Xy868cSEkxDkO3zzKQ0vSxI4Z46QajhXEfz/IDAl6aTSLUea86CEHYiPyjeyJuCYeFkKPfgUeH5pNE7RmmFpcvXQNrLE5I0Xm0QQ3FlzYYh+fPfeBiFw6AOR8vmOXxR2qwlsQkDxzbjo4tFyZ6FhB4rL1D/S35R1f8RAO0rQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160238; c=relaxed/simple;
	bh=hxn3BKuTiiWjfVAHX7tPq6EobZQe9Ya48ubEsGAaYuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFOyiYcb2oV3dL8q8ABAC8kz8V7fbEgex6B85HBlkYKqEnS4K+xsIaX6pY15fAwdrCItyLOw4/qCbF3pJ4Go1Btg5s8h2oSPDq3kMGPiCWt4ovzdj/x4F7O6eKPZ4alkvAUsw8Y8BoGynNyXjUhxhSgM7cDaLVLg2Jsh5YMSDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IPjp3zaR; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IPjp3zaR"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-267f15eb5d3so668715ad.3
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160236; x=1758765036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlg78m3Ev0QtoikD/oo2CO7iAsfO2QZiXUPUhq6FYRw=;
        b=IPjp3zaRtdMhYYy4QkP79M5alW63KtArdeFT4MMPZByZtz8lE8gf1K3U4cgdTNEgjU
         iGcaIZEHilhmK2NDfSdFLf7uBx9fou2wk9UFTWY1CxIDrrkwmNWRUphJ4CSoVAFfvBaN
         wnBa5rWtzatTnMbiWR+ZoWPCTy81YK9TID+gfxTAsOvHpdDAGg0MQbNYDrtPhwQ5rCmn
         gVmVNtXUbJLlWFg+2oOYmDIPmSaOJN4Jt56dBdglWw7K9XROcl4obwnbQEZif73F+ETu
         CF/+2SxtUwKzd5zW6oEK+r0StU5YK45xhCQIUfIG8yXg9yu/oyRv02ZJRa28d13p8eg9
         TzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160236; x=1758765036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlg78m3Ev0QtoikD/oo2CO7iAsfO2QZiXUPUhq6FYRw=;
        b=b0ZEBMAHuPUnZqJxXeUSvb1j/X1aR5NXXgDe3NWDvAVWm6+J86lODe9kJuR+SMG2ll
         9sYvyNDVZ9lr/JiYEzfY2yismyrgrlTG2uJBen2c+m9fyHHWvCUNTEQQYSt+I0mWa8QY
         6p6fW4iSMa2he6IHW7+F3Dt5FvFVVhXGA5LC3fb/OIRX4nLrTwZMt7wEl2K28y1aNgIn
         5BCu1YIRTiQwo2Gv1OyqEVsenp3vYzzXQlMxYuSWXPRjfTRl/wF2u6omqyAtjP0gsMjg
         snaHfckRrmsp9+PGPvCB0N33IsZtI0DLVHaBUL0EjeilaWgCOYDw/mzm1J1Ev/pUAgHX
         yeAQ==
X-Gm-Message-State: AOJu0YxogmwRocz0JL5acbkOTjEcz2zv8JyrZMS2oQQAD4TupeseUe3y
	811/Se/eibJMzjb8Its5VL9U/SyYqqzoMx1USEDpZSr6/6Q5FDR4LtxCwkzBEZLr93tJ6sKrsPR
	ui56lZJaWrjFgnEeJWIvQBLLetJ28JbUzHxKdv89et04TDeg62p12
X-Gm-Gg: ASbGncthJMkzQCaCVYxQwzoccfQMsH9G1to8awp6CNkJ1AaCSyifVf1WVSIkR92js9k
	HQu4VNkPgiWIE8ezyLKJS/4hGl8m8AlyazMDnm1fXKB8XAEHVWOttJWcJ3fx+07bIdhi1D1tKP5
	r0qS7mhjq2ISIOLQPmfzske1TsIe2usTNSmBtSuzQp8AmFHTEJ+wRfnn5Vg9Zxoys2w6nlrvY9m
	XMDIRS0G1J8yFSaHg2ZcT00jH3rXZo/HA5wpptIH7QcCkw3j4hWO79MdViVBfm1CFMoMKS/83Gp
	tvLd9kP28H6grEJkRQR1WNup6d3ePKyCNtl04rCAplP8OUhU8hbLKEE3uw==
X-Google-Smtp-Source: AGHT+IHj9QM0F6hgUxJ21zdX1Ylz68rApTHUPioBu4FMtIsDFauGSTQ8b1kTLdV4AbDZH+sT6hWv12TmQb7s
X-Received: by 2002:a17:90b:4b51:b0:32e:e18a:368d with SMTP id 98e67ed59e1d1-32ee3fc0567mr2677579a91.8.1758160235729;
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32eddbbec5dsm292836a91.3.2025.09.17.18.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1764F340508;
	Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 143F3E41B42; Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 03/17] ublk: don't pass ublk_queue to __ublk_fail_req()
Date: Wed, 17 Sep 2025 19:49:39 -0600
Message-ID: <20250918014953.297897-4-csander@purestorage.com>
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

__ublk_fail_req() only uses the ublk_queue to get the ublk_device, which
its caller already has. So just pass the ublk_device directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bac16ec3151c..4cb023d26593 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1706,16 +1706,16 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	pfn = virt_to_phys(ublk_queue_cmd_buf(ub, q_id)) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
-static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		struct request *req)
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
 		__ublk_complete_rq(req);
 	}
@@ -1735,11 +1735,11 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			__ublk_fail_req(ubq, io, io->req);
+			__ublk_fail_req(ub, io, io->req);
 	}
 }
 
 static void ublk_start_cancel(struct ublk_device *ub)
 {
-- 
2.45.2

