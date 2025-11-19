Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504BB340A63
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545178; cv=none; b=Gq4aSvPBvtRjmhdhY1MZGw4KR8GWUtqsG+ItIiA+2ifpT1hlijcMm7ySN/meRnnTlwOVMIH+XhNaijgojdVN4SfxUgOh5ZpQTtBx8YdBAjApPlT8ZjS5zXXFPbR+8rge/1fSZCsCyWZn3pIhetDyny1ntymGljBw+0oqiKRVWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545178; c=relaxed/simple;
	bh=3zsX9YnjzTM9QaPW8F8WueZexnbQ1OQ0nNW/SXLND+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAmA/5C7hAEXQJX6EgIzQGo3zha7if6d0Bd3SwiEHrFP+UCrh9/Zqf5pjA9kfqjVnujOhJc0TTpIXvZo8CxI4UNsxVuSQJDyFB4GFxaKEQgBfL430B7+nzmqmGHsQea6qXmEmSM2Xx68KDAjfbFAIUWQ7M/ENOlyBsOC+WH1XnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsUSp8tV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsUSp8tV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763545175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITW6FmtnBwkjfQyooJCNY0ePQyP5iLpqAn/ndnJI49E=;
	b=BsUSp8tV/Ic2Ov2NrTxP6/McLV9f3lHHqocHo3MilqIwbzlp5hiQ78BUvOFNQV59ZFZEjW
	86ot5nVX2bEEflx7bUUOQavX0CdnZtTag+Repjh29p7aObz/3EmZ5aCy68gS8k6RuSi6hi
	BmhVwalZMNVY1HmsW4OxhDcMu6fphBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-yx0ME83ANQmwybaQLqWkfQ-1; Wed,
 19 Nov 2025 04:39:33 -0500
X-MC-Unique: yx0ME83ANQmwybaQLqWkfQ-1
X-Mimecast-MFC-AGG-ID: yx0ME83ANQmwybaQLqWkfQ_1763545172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B1741800343;
	Wed, 19 Nov 2025 09:39:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 562DC300A88D;
	Wed, 19 Nov 2025 09:39:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] loop: fix error handling in aio functions
Date: Wed, 19 Nov 2025 17:38:52 +0800
Message-ID: <20251119093855.3405421-3-ming.lei@redhat.com>
In-Reply-To: <20251119093855.3405421-1-ming.lei@redhat.com>
References: <20251119093855.3405421-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Replace goto fail with direct return in lo_rw_aio() and lo_rw_aio_nowait()
error paths.

We can't call lo_rw_aio_complete() for early completion when lo request
reference isn't initialized yet.

Fixes: 0ba93a906dda ("loop: try to handle loop aio command via NOWAIT IO first")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 64295c141b97..705373b9668d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,12 +458,11 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	if (!cmd->use_aio || !lo_backfile_support_nowait(lo)) {
 		ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
 		if (unlikely(ret))
-			goto fail;
+			return ret;
 	}
 
 	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
-fail:
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return -EIOCBQUEUED;
@@ -505,14 +504,13 @@ static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
 	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
 
 	if (unlikely(ret))
-		goto fail;
+		return ret;
 
 	if (!lo_aio_try_nowait(lo, cmd))
 		return -EAGAIN;
 
 	cmd->iocb.ki_flags |= IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
-fail:
 	if (ret != -EIOCBQUEUED && ret != -EAGAIN)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return ret;
-- 
2.47.0

