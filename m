Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B213ACEF9
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459563; cv=none; b=ekKAvYmHZUnYjHbdJr+FsCktmdwJE1Gykw1ecihJU6HVsg3g+o/YfQoV12fvGcazLVmlmyALN4oXtstqznILBrbI2bwHVWJL+UlP1daOuV5bEmebFXtYP0fpB2W8QVhgiEs+OC7L57YksWLqtSU0A87q6ZxGWOOHl3IJ+9dmWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459563; c=relaxed/simple;
	bh=UfrGnarFt4b+cF79zbnJnFvzMQXS1bvK/hRh9YhiOs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJqJT4OCe26Yv1V66mn57/dkYBOjQQkBzqk6T7NonjU7l2ATVN73cByjIfrW9mdb3Oq0aI7qkbwoTIWVhn1o/kQG+8eAvUMu7f1FiOpGscbQDV09ar4M5qdXtThxbC8TM7neE2GWD4V8vIF1eLWUbJyv2am2CKvRrrschlK77I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvsbPZHc; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvsbPZHc"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8244537ab76so1467854a34.2
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459561; x=1792064361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abvupRISWJ8AC1pdsEvPByUHzHrxkFdQ+n0GAFyK6cw=;
        b=KvsbPZHcXYTgo2Am5T0iFEuImilPXZHG3/UerDLumFnkGBWZNDXMF1b0GqMi/iJIyW
         qrAFMn88L5G8HohpQewILA+QzHPl4U4sge9w9+H+Aafxa2ApBbJ/Xz9DPlqfkMZdlOSN
         2jd8HGseMaacqSJ7og283QAcm5h8QvRfF9fGqrbIlWsZImXOiuxy6bYIEA7Q9BRdoG2d
         lZfLJQTtRfoS7X+111cy4pD8HuWLFvVhEJ0YWfJcrLrClUko/uYDY3GC8cmQhI/3iJEU
         1XGH0ZCc2AhFzm6su9bu2f8JiIpxbB2reVBFGan+J98edAbT6rL1lNRuTEvk57yT3zVS
         7puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459561; x=1792064361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abvupRISWJ8AC1pdsEvPByUHzHrxkFdQ+n0GAFyK6cw=;
        b=v7NML/X2vq3YVMsdfpG1Ii8LUEqzaBDwm+eeQu7t9/UxfnqEJhG4QYWGiTrN+Njnri
         IzcVePwU6JsgfYNizKZOhnrYq5lYyfCX74ht0/bGqPNzzeZ+EzAv3INm2I1I83pvOUE+
         MVuF0Xfds4QGF7YEKdFw5r/8q9G0ltTmFzAF+sBBjUwdR2VDANwTXygGd+T/xeAWyZ4O
         G7kcUVPBYGpw2Vsf6JGRP3CH2k2hc96ZgT8xg/h4a9zR7Fw9xj9FrLgrXlDRtP4qgTe1
         whSIDlBGgf2yBd++hbKMPqkwkszcmViwvbqIcMWPGpyhzm7zX4fhN/0GNv4RepmCLY9f
         8lUw==
X-Gm-Message-State: AFuF++mkw/p7vjk4WvWNvrV/S+YetsW7x3h9zfxzGvP1vEHrVtfFPNdb
	YoCYOtoiXCz+lSrTX8l9/YfWF63uL7Il1/dYzM6QXqIR/8H6PltSqsqfEXAWcVNY
X-Gm-Gg: AYBFou2v8DUUk4w6aIDO8qHGy0Tku+bln5ZkhF0exsjEMCFIJDDHgVrbGvl7/3ujHG2
	U1lcNQO6pCLspmp2hlIYvSsEpNHCgDKUUk2yV/vKh3HzPY3Y2wejb0eu63J4/h8vWMOQIorMMA2
	qwXLMRnTC3KHXi44CZ6TnKfCN7LkmpBe1JqnUtMNt45ChUi69d5xnmt2JILSd3dsVlBSv3fozVS
	3agO7/fSyC8c4uKgP67UkD5EyU/KXrOllkME2+rfgycLtPNm2ipRMnEyeum1uG2bGuvloU4hVWe
	GXhnmfc/AIkz4x5IJ+Zroac8WlcNmI/Z75qdTAC8KuOGLVGw1ccLXV9NyUfsFwYFMwQzNgHcuJ0
	eAwU3iTGDtFkpKkjqX+7WkHedT/3jM7JaNQTtLK9U/eymGmceYCRXPlz/uIsKvotPtJS/SnRW7o
	T7PUZiUdGVep8+fCskbNS+/60L3opr2RPrlOrQMshht2ph/YppjRLv0vuHufseFh3AzyyHUI3q+
	xZsx4ntBbxRHf+Bkn08dgmnXgruk4ARU+4GnTQisxHJHGxA/R3zRrDkZ94yxkqrg59UHQnT2zxs
	TirHJXe9DN26XTNQOhPZNVc/WPc=
X-Received: by 2002:a05:6830:4c05:b0:7fa:5c68:d04d with SMTP id 46e09a7af769-82ad01bf80emr6839814a34.23.1791459561561;
        Thu, 08 Oct 2026 04:39:21 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:21 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 03/11] ublk: mark the batch fetch command cancelable before linking it
Date: Thu,  8 Oct 2026 06:38:59 -0500
Message-ID: <20261008113907.4000838-4-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_U_IO_FETCH_IO_CMDS has the same order problem as the per-io
commands: ublk_batch_attach() links the fetch command into fcmd_head
and marks it cancelable only after dropping evts_lock. A cancel from
the control path (ublk_batch_cancel_queue()) can take it in between and
complete it, and the later mark puts a completed request on io_uring's
cancelable list.

Mark it before linking it. evts_lock orders the mark before the link,
which is where the cancel finds it.

Batch commands are not bounced to task work, so they can run from io-wq
without uring_lock, and io_uring's cancel walk can now find a fetch
command before it is linked. Two things make that safe:

 - initialize fcmd->node: it came from kzalloc(), so list_empty() saw a
   linked node and ublk_batch_cancel_cmd() would list_del_init() NULL
   pointers
 - on the -ENODEV path, complete the command with io_uring_cmd_done()
   before freeing fcmd: that removes it from the cancelable list under
   uring_lock, after which nothing can see fcmd

Also use data->cmd instead of fcmd->cmd after dropping evts_lock: once
fcmd is linked and not the active one, a control-path cancel may
complete and free it.

Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing")
Cc: stable@vger.kernel.org # v7.0+
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6015fb2fb925..5e37b8e9d9ac 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -815,6 +815,8 @@ ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
 	if (fcmd) {
 		fcmd->cmd = cmd;
 		fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
+		/* a cancel may look at it before it is linked */
+		INIT_LIST_HEAD(&fcmd->node);
 	}
 	return fcmd;
 }
@@ -3915,6 +3917,15 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	bool free = false;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(data->cmd);
 
+	/*
+	 * Mark it cancelable before linking it into fcmd_head, where a cancel
+	 * from the control path can take and complete it: see
+	 * ublk_prep_cancel(). evts_lock orders the mark before the link.
+	 */
+	pdu->ubq = ubq;
+	pdu->fcmd = fcmd;
+	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
+
 	spin_lock(&ubq->evts_lock);
 	if (unlikely(ubq->force_abort || ubq->canceling)) {
 		free = true;
@@ -3925,14 +3936,12 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	spin_unlock(&ubq->evts_lock);
 
 	if (unlikely(free)) {
+		/* off the cancelable list first, then nothing can see fcmd */
+		io_uring_cmd_done(data->cmd, -ENODEV, data->issue_flags);
 		ublk_batch_free_fcmd(fcmd);
-		return -ENODEV;
+		return -EIOCBQUEUED;
 	}
 
-	pdu->ubq = ubq;
-	pdu->fcmd = fcmd;
-	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
-
 	if (!new_fcmd)
 		goto out;
 
@@ -3940,9 +3949,12 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	 * If the two fetch commands are originated from same io_ring_ctx,
 	 * run batch dispatch directly. Otherwise, schedule task work for
 	 * doing it.
+	 *
+	 * Use data->cmd, not fcmd->cmd: once fcmd is linked and not active,
+	 * a cancel from the control path may complete and free it.
 	 */
 	if (io_uring_cmd_ctx_handle(new_fcmd->cmd) ==
-			io_uring_cmd_ctx_handle(fcmd->cmd)) {
+			io_uring_cmd_ctx_handle(data->cmd)) {
 		data->cmd = new_fcmd->cmd;
 		ublk_batch_dispatch(ubq, data, new_fcmd);
 	} else {
-- 
2.55.0

