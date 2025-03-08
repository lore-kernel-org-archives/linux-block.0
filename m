Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E6383A2
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450535; cv=none; b=IrFgMtOZNTFNzjIC8GeYKYO+/b5jozZ0L9y/3I0Kc+gITZhpCVIPSOAuP9jiT3TOL3z+2ETWG3Bn8z5hnzMDemynYkoua/SFCQ+O7jZ+fj6C8w7c0xXE9a03JBfZc8c27FKRO1Qka36Nj7buAp1EJoOBl3PRWOTiJSqc+ToFDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450535; c=relaxed/simple;
	bh=u5/4nj2ac7HVWMRc5crLzT65h3we0ohrKVZmSnCOre4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeRoixY0pC6dTt4ZciGLeBjM6b8XKWI9ax1kwnNcc/trdKAWnOSyWke7jXVq5pL5ZNdigg4O31jW/mowwrFWoECF9rhGY4PwFYSKmzXEpIoOFg3MX9XkjGwTsYqijhfc4uCJjFKz5CVn5ypp+UpR6EqqEMlcKsZ5KHpAMIVmKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiwGK//s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiwGK//s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8denhFmEdN5tN08SrQHZAgAryJrIovxDrRi5iaFG/aE=;
	b=ZiwGK//s86ZKze62kkbf5R19MVUzAJ5vIbu6SJr2A5F73J4OfYQdFKwAqyvbQzb5xvl/Om
	plAU6jlUXyUu2+lEkrAU6fx73GC82UIGE/H5c53jLR7D+UeF8medyzUarj4lFaaCu9l0X5
	6N6xfSS8/ZmhykjeojfVlzwXmuQVPis=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-BrFzYQNAMAyqXmsDrUnQbw-1; Sat,
 08 Mar 2025 11:15:27 -0500
X-MC-Unique: BrFzYQNAMAyqXmsDrUnQbw-1
X-Mimecast-MFC-AGG-ID: BrFzYQNAMAyqXmsDrUnQbw_1741450526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEC8C19560AB;
	Sat,  8 Mar 2025 16:15:25 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B58D9300019E;
	Sat,  8 Mar 2025 16:15:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] loop: fallback to buffered IO in case of dio submission failure
Date: Sun,  9 Mar 2025 00:14:52 +0800
Message-ID: <20250308161504.1639157-3-ming.lei@redhat.com>
In-Reply-To: <20250308161504.1639157-1-ming.lei@redhat.com>
References: <20250308161504.1639157-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..2fa15933860d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -562,6 +562,14 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 	lo_rw_aio_do_completion(cmd);
 }
 
+static inline int lo_call_backing_rw_iter(struct file *file,
+		struct kiocb *iocb, struct iov_iter *iter, bool rw)
+{
+	if (rw == WRITE)
+		return call_write_iter(file, iocb, iter);
+	return call_read_iter(file, iocb, iter);
+}
+
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		     loff_t pos, bool rw)
 {
@@ -619,15 +627,18 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == WRITE)
-		ret = call_write_iter(file, &cmd->iocb, &iter);
-	else
-		ret = call_read_iter(file, &cmd->iocb, &iter);
+	ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
 
 	lo_rw_aio_do_completion(cmd);
 
-	if (ret != -EIOCBQUEUED)
+	if (ret >= 0) {
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+	} else if (ret != -EIOCBQUEUED) {
+		/* fallback to buffered IO */
+		cmd->iocb.ki_flags = 0;
+		cmd->ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
+		lo_rw_aio_do_completion(cmd);
+	}
 	return 0;
 }
 
-- 
2.31.1

