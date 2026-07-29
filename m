Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8930F52A
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288619; cv=none; b=gjurnFTvI4zpZzQ1TMYOAb2wR60rQLrv7RnuB7L7dBouJBkdjqJNjPz2+WMwNRL4LkNhZqzMvAI5xAZLhZUF4CHJp7WCpXEKnQRS6e4PwvUC1LsTB0uK89i6y+2hBBVuXk1kMz+Vznih20SS3+NgIdekfq+GZ1oyw61wjwIGfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288619; c=relaxed/simple;
	bh=k4Oc7+lIwZSQ2U2mu/+eBFOofzivTHxInzy55WEsUXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LalS5/nE2wxewX9D2sc/g91yjAlJZPJxbbjOyso6e6QMrSv+mozeLUEkCLByyR/1E0IHYK1n2sU+85DMNy0jPg1A15BZD5S25HIaCTJiadwXPkUVd8PvR+GVgUNj4k/52hFmCYJUwwPk4Im+ogQ8mKZugwimLsz0SS+whOlsS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IgZUUu30; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IgZUUu30"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-8080651d2cfso613587b3.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288605; x=1785893405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPAYAhBh4zQYuPt2xaEKvzehNoeJ7wWO+R9BlBqpmJw=;
        b=IgZUUu30uDhBscm3udQn0bBR44240SQE/so2TxxTo3nTsKKLsxjpgcAKfQoehO5nT9
         N8L7Oj/kXPAv+EN1uI1jFfwWa0gv6+BNoQ8kgV1/nXyrRTlWNSbcNDtz4lRJxdGQRPcA
         86TylRpe9/EIKE/TBkrodR8nG9U9kgzUKbIiNQAUPhIb6EYyYEWCkODTMnlkb5DGdd6l
         54Kc7rSQ8syH+Tde3ZyR+46XSg0zl9Sv3+2e8UYr3x3jk+vUaI3TKZeuD0kt1RvPdASb
         lpzSPtHpd/ORmgcVScmGNWrqe70RFhsXP9yrGNvIayuBR33k/pLvddF2Jg7l4Sh5wjlg
         gGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288605; x=1785893405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPAYAhBh4zQYuPt2xaEKvzehNoeJ7wWO+R9BlBqpmJw=;
        b=dx4js61LhRZRjNasOWqne4+m9OFuu4I04l2tcn9KUZBD6YCXeHVBsE1SHp2qFSwgA5
         lbpy1DI6yEO9xWbfD3gI9Psk1I109y0V+ZAcuxLV6atSuuA7kQjdxVkX71TE1RcSc+3q
         iNJzE1M2YrF8xayfoAEvY6+Bz1kq4NBg8Zn9zmEPl+RV9qCBpAaPKckGRIRwHfKpfhVt
         kXxdsNFg5AkE1NfHvfx7R3L/EMNyw2MjuqTEpZICK59CHSN/RNFiDYvpgP1YF9xzj0dS
         UteiwMm/o8jLha8xh+eZMCloknNkMG1VZ/aH/awpLn7Z9Wx04lvJRcl3L9xmxezQ7ar0
         RXOA==
X-Gm-Message-State: AOJu0YxKcycsST3skByLRvaxNyegYjyBp3BeizGd8CagdtKWQbk2bwo+
	pjt66hHS2dcoOOZ8eHgz/7jrfDSxwf4B1ESqfBcQ0uV+ozIxkmxp5VbuHpUbs9Pm9BFYHas0L8V
	26ZWeiaFEq3qGVK9PTFLjdbPw3ueZYbrPD4XXzmuXLbR3mEK4SYqH
X-Gm-Gg: AR+sD13L65Kvf42II1vRW92l4Oj4qceold9Ei3cex1qYbgTlYquexMT3AGkZFynJP5U
	AWjjX+LrO3/9vw3ijkglV9w6HsUliR1gxl+ghV9KQmy4Y1lNQB+AMru9kP3Is6GimIMfewIfSmS
	TJCQur4bSi6XcVufi+wmH75729gDKtSWnh868vVPeUht4LMufIIq1puU8/v/VJxREYvTPIlERKK
	poWoibbIqaIr+iTdPHpDlwQdDbQ89qFfoUvYEnJoyzSZ4vGW5V1F1Zy7Fe//y+l4frLRalY3Qio
	lVcEd8dDEgq8jkXSfYiE3plGkwpXwZP5dHJjL+uV2uOuhuf7H3hkDq2vIf/X7A+bp9lE4BxyL0Z
	3lIY3WfifV9DV7yXo3g==
X-Received: by 2002:a05:690e:b8b:b0:668:e1:629c with SMTP id 956f58d0204a3-669057c84e6mr1875530d50.4.1785288605158;
        Tue, 28 Jul 2026 18:30:05 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-669122b2d40sm95605d50.10.2026.07.28.18.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 8F3BC40332;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CCCAE40442; Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/6] ublk: initialize io_desc on daemon task
Date: Tue, 28 Jul 2026 19:29:49 -0600
Message-ID: <20260729012951.3744582-5-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729012951.3744582-1-csander@purestorage.com>
References: <20260729012951.3744582-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_setup_iod() is currently called to populate struct ublksrv_io_desc
on the thread submitting I/O to a ublk device. However, only the ublk
server threads read the io_descs. This basically guarantees a cache miss
on both threads for each ublk I/O. There's really no need to initialize
the io_descs on the submitting thread. Move the ublk_setup_iod() call to
ublk_dispatch_req() (for non-UBLK_F_BATCH_IO) and
__ublk_batch_prep_dispatch() (for UBLK_F_BATCH_IO), which runs on the
ublk server daemon thread before dispatching the I/O to userspace.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index efbb0d6af128..46f5ab13f87e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1786,10 +1786,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq, struct request *req)
 {
 	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	u16 tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 
+	ublk_setup_iod(ubq, req);
 	pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
 	/*
@@ -1839,10 +1840,11 @@ static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
 	struct ublk_io *io = &ubq->ios[tag];
 	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
 	enum auto_buf_reg_res res = AUTO_BUF_REG_FALLBACK;
 	struct io_uring_cmd *cmd = data->cmd;
 
+	ublk_setup_iod(ubq, req);
 	if (!ublk_start_io(ubq, req, io))
 		return false;
 
 	if (ublk_support_auto_buf_reg(ubq) && blk_rq_has_data(req)) {
 		res = ublk_auto_buf_register(ubq, req, io, cmd,
@@ -2175,11 +2177,10 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 
 	/* fill iod to slot in io cmd buffer */
 	if (unlikely(!ublk_validate_req(ubq, rq)))
 		return BLK_STS_IOERR;
 
-	ublk_setup_iod(ubq, rq);
 	blk_mq_start_request(rq);
 	return BLK_STS_OK;
 }
 
 /*
-- 
2.54.0

