Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1234D4CB
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654886; cv=none; b=sBBRoZBT5p3AIAhy5QqJHwNrXN0xrLJH0lFes5lTrOuziREzE8qL3LCw9YnwcENJQgK0b9ZJpeqaMYFqfwt3+hnDs4qK1zhQ/qziJxy1bZnu8BS43iixomEfgCPzlivC2n+VQB9s1vyW+QSZqpIDZjMPzPpe4u81Kj2JR0TSw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654886; c=relaxed/simple;
	bh=3zsX9YnjzTM9QaPW8F8WueZexnbQ1OQ0nNW/SXLND+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATFuN9hTSvHQkmIYNutpdDSH7h5riwACZLoQRVC/Vjlc6q/YauCvCF5MSchoy/imk6eUjbN2Yuzl2+7Emc0e8TNd4JCMSZeW16M4Rd2i0uj1mjfmWBamL/0/0rVLTcCiUFhDCXwRmwKHJN8tD8jabTOGJbxxKA3IY+TmuBhYf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwK5imyO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwK5imyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763654869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITW6FmtnBwkjfQyooJCNY0ePQyP5iLpqAn/ndnJI49E=;
	b=FwK5imyOcYiGvs1UIyppfoJuBMaxdmLP3DUbVoGavaBmd+NgxOuCTVGGJTJ8KtXbUh+HjA
	MyfY6USpNgZRFw+xfzPtyoqONK7JgfXItdlf4du/lBTlCHS7Hq/8A56JpQD206ETO/hbKA
	mG63C5LkEqNGgii2gIR6NTyPdanKQ+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-ZCNlGGvyMAmF6Erka_y2aw-1; Thu,
 20 Nov 2025 11:07:47 -0500
X-MC-Unique: ZCNlGGvyMAmF6Erka_y2aw-1
X-Mimecast-MFC-AGG-ID: ZCNlGGvyMAmF6Erka_y2aw_1763654864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 615BD195422D;
	Thu, 20 Nov 2025 16:07:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D74F1940E82;
	Thu, 20 Nov 2025 16:07:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/4] loop: fix error handling in aio functions
Date: Fri, 21 Nov 2025 00:07:18 +0800
Message-ID: <20251120160722.3623884-3-ming.lei@redhat.com>
In-Reply-To: <20251120160722.3623884-1-ming.lei@redhat.com>
References: <20251120160722.3623884-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

