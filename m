Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D741AAC
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763594564; cv=none; b=iRd3jNTARndQyV6R6lS9qpZTcinVFuVVy8eW3BFyhroS3YtoNzzxdU17oCYtz8esl+3AILlnvXaxbt5MKdmmjJHJXeNKIYxqtow+k/eAjUG1bbzzbgmstITP41oV7XVzEcumbjjsM6TRkA0HJjJBp3T4R/TK9CZN67HcaguUz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763594564; c=relaxed/simple;
	bh=0FGShSFtRq2vVZa/FLv4CCVQlJggDUDPzj31PEcbTSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fl25XULGA1lW5DNVhYipbvpVbftye3Xu0TQ14Y7hSfRaHG7jb/BFx7mEWwJes+ga2B4+E3cWxkMIZbEM4F7Vz2cwhTZX36H2gk8boVxShAQFAeKFpcZWHm/QiKOxkRVTkfbhCpWI6uDKQzFIfIG7trL5ZimJx5/W0tTNpbsRfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljy1ACWF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljy1ACWF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b75e366866so110506b3a.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763594562; x=1764199362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/ArKJUZQmA06yg9FqEojH0cZqvhzHJY9akF8FwKHE8=;
        b=Ljy1ACWFke1290heWKGyH0Fg6M0xQtAA2saW+vYq3Oa1dZRW/Ks+Cf7iod+kPe5z5z
         EQauVpTM9dXlzWBxhJn5fYe/zjRgwYWqp5uLBKj7SeotIZX8r7xg++tT7f7gli3R6x9g
         JJpYq98cakArWimY6tlEamQG7cruNvA+hv7fch0maTDLRn9/2G16qdkPqeBSznzzGb6m
         cYqfrNy768fgajkKvD+BLuZUG1Tap30zGR40MLNuzPMo3m48ooFs+uofKvhMjvYK7dzM
         5gdtDMy7sXEEjja1RzxM5QZv2dIGKCkQWXDFwpEaB+srGHoSXc9J/7luSKmrFhr25k0y
         ugRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763594562; x=1764199362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/ArKJUZQmA06yg9FqEojH0cZqvhzHJY9akF8FwKHE8=;
        b=H0cKs5ir01ChhpuUm+4ne/jwYIErmmH+LYErefiz3Z0C5NHOccANtIcVpTfo5NuJOB
         XKWQgc62S1Yono8RDe3Bg8Keo0z2gcvZYvFTWPgYbAk7n6d0tH6Q1Ft8Dukj7HeHFG+B
         8R1rcA3q/9N14o9S38/mYIRPrKoe4cpeQ4UcV4dJh7gKKUp40QMyrOvkfXaM3KlplPNl
         ckdCl2WVFLys2Dz23S4txI5sgjQ09pVuCKqqQeuQvKTopVgs22DEPrqY4LgnK8iYsKeM
         dFcQ9IDmoNQHHEocHnKfpQr9gZuQoGhOPeF1upBFAfi4q/+uei5/vnZmmCmYGFo/uisL
         rq+w==
X-Gm-Message-State: AOJu0YxUrUG3dLD+Ht5WxYY9ledUB4ii4D03t2pkfr32/MG0oSFFnoYd
	9YNfi9b442O8lqgRHUek+7aN9gz4+eaZ6guFh+EjWzJAEBpGi7awUJok
X-Gm-Gg: ASbGncttkS/whYosYYVT3r5hDV12DKtNXRdth+mfcVwlb9yLUbJkXQO28II1DTsKk4Q
	MKHaT/VthONvMeF9EDT+nXXOdfSHS8xdSW1NjzZ/Y3pBm+lXFIahpX4+JpVUY8v6Kx8L6OGZnsd
	TIrEr3LDBZDWGQNQ3TYwIgif5To3Uvs+ePLg0jL9oxqQvoNy2sXttZYNHdSTu6rMZWZkRtG2UWY
	Tmig2xPsLkoDVdsCrtRGBmNhnwhoRv9/5oFmNvYEfqq5QPpuzKFDz6pL/Xl0B5q5l1J5C2fMG2y
	O1KHibJrz/uy2Rpb8NvPfGoKJkNlKkh329dON3tyAmvLSikD6wZ6SQEAmSM2gFz3GpcQiGQTaQD
	fFR0Wiv7qqA5I5u9e435pvOKE6uIQQGxLADRDJaTm7Ka1KkuX7kbeaVgWLpVQ/R4tl3eD3aNU0Y
	23/i5YNoaE6THLNkcOnqs29LMBibE1VvJetumwzG0ck+PCtcomZCpRNrfgsWFeF9oCZ/4T
X-Google-Smtp-Source: AGHT+IGBF4WqCbSUbuCc+HgtqM4IoB61LGPOVfGMTE1GA3t1nARtDH14IKI7p8i20djFsMblXSTLZw==
X-Received: by 2002:a05:7022:e98e:b0:119:e55a:9beb with SMTP id a92af1059eb24-11c93810b81mr368010c88.7.1763594561752;
        Wed, 19 Nov 2025 15:22:41 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6da4dsm1997083c88.9.2025.11.19.15.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 15:22:41 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 2/2] zloop: clear nowait flag in workqueue context
Date: Wed, 19 Nov 2025 15:22:34 -0800
Message-Id: <20251119232234.9969-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
References: <20251119232234.9969-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zloop driver advertises REQ_NOWAIT support through BLK_FEAT_NOWAIT
(enabled by default for all blk-mq devices), and honors the nowait
behavior throughout zloop_queue_rq().

However, actual I/O to the backing file is performed in a workqueue,
where blocking is allowed.

To avoid imposing unnecessary non-blocking constraints in this blocking
context, clear the REQ_NOWAIT flag before processing the request in the
workqueue context.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

v1->v2:-

Unset REQ_NOWAIT at the start of the workqueue context. (Damien)

HEAD:-

commit 6dbcc40ec7aa17ed3dd1f798e4201e75ab7d7447 (HEAD -> for-next, origin/for-next)
Merge: 58625d626327 ba13710ddd1f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Nov 5 18:24:17 2025 -0700

    Merge branch 'for-6.19/block' into for-next
    
    * for-6.19/block:
      rust: block: update ARef and AlwaysRefCounted imports from sync::aref


---
 drivers/block/zloop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..1a97b21f5fed 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -498,6 +498,10 @@ static void zloop_handle_cmd(struct zloop_cmd *cmd)
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct zloop_device *zlo = rq->q->queuedata;
 
+	/* We can block in this context, so ignore REQ_NOWAIT. */
+	if (rq->cmd_flags & REQ_NOWAIT)
+		rq->cmd_flags &= ~REQ_NOWAIT;
+
 	switch (req_op(rq)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
-- 
2.40.0

