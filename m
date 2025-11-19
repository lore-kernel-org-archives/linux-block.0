Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046133F389
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545173; cv=none; b=ZK1Q/A90nPYSYdfbDYn7VbTXVa7RzJpxVc5vR8QwwJSWO4VkCwVQyd1CScXhFvJsRAkWTYpfNA59bU/PH9TgA+4DdfbbCZK0AHsFSuekNWf87NK+74XXCsT/pL0rax5W3LK1Qm51viNhk2TAU0eAfeQ1P974PT7oV/g1y4Y0l4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545173; c=relaxed/simple;
	bh=7ZM+iUxpYJU5OoPZPKU66pJryakGaXvujNH2tvfTIDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWRdCdmwqCvWWHUbFeo1cnJLCKoI3pioXXTdCGA3XVis/dX8F7GpEBdlTJsE0r64ovIk/7nUeU3yGOIt41xO+4bEIuqh0I51EM8NLiBMeI/Bx7+kAkNGtxis3/ER5/KB3KE0upjRoQ+2QgC4rM7QVd/Fp3nSzz5iAIyGhCSmAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+AHKRBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+AHKRBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763545170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wy6G2kh5eV8l/uL4P2RMMnpb+ZvKskVlTmh/lU/7n1k=;
	b=f+AHKRBuEDKwL8au/VxfqgLmcjlSGRslWeMgX8DCmrrQJQPcAkqXFAppUCQfvE0XhCyvwB
	uZZiaHh73OkKq65vj0rKGfpb5kXktL11NBgJY85dM/f7SBlj36cc4duQTQvbPIfBzXB3Lj
	pXGcbZ047xNSX9hLRjBZsIyPIH8V6So=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-BRK7XItdM52DUTbzgAQSGQ-1; Wed,
 19 Nov 2025 04:39:27 -0500
X-MC-Unique: BRK7XItdM52DUTbzgAQSGQ-1
X-Mimecast-MFC-AGG-ID: BRK7XItdM52DUTbzgAQSGQ_1763545166
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCA8919560B5;
	Wed, 19 Nov 2025 09:39:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A38BC195608E;
	Wed, 19 Nov 2025 09:39:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] loop: move kiocb_start_write to aio prep phase
Date: Wed, 19 Nov 2025 17:38:51 +0800
Message-ID: <20251119093855.3405421-2-ming.lei@redhat.com>
In-Reply-To: <20251119093855.3405421-1-ming.lei@redhat.com>
References: <20251119093855.3405421-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move the kiocb_start_write() call from lo_submit_rw_aio() to lo_rw_aio_prep()
to initialize write accounting earlier in the I/O preparation phase rather
than during submission.

Make sure both kiocb_start_write() and kiocb_end_write() are called just once.

Fixes: 0ba93a906dda ("loop: try to handle loop aio command via NOWAIT IO first")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9b842d767381..64295c141b97 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -402,6 +402,9 @@ static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
 		cmd->iocb.ki_complete = NULL;
 		cmd->iocb.ki_flags = 0;
 	}
+
+	if (req_op(rq) == REQ_OP_WRITE)
+		kiocb_start_write(&cmd->iocb);
 	return 0;
 }
 
@@ -431,11 +434,9 @@ static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-
-	if (rw == ITER_SOURCE) {
-		kiocb_start_write(&cmd->iocb);
+	if (rw == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-	} else
+	else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
-- 
2.47.0

