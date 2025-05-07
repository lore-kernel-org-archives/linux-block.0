Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367001C863D
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609952; cv=none; b=el1znHbnp2kJ4k4O+sLdLz4XuR8tfF72PIFJUJM92YUddxzV1ks3UpJGUomyqUFY3bdmS71wonyQLb1aXLDVvuu3HHFW5sbCciEpNvYJ+UoFCrsR9YuCZDzwfLsXTI0lxI0fpZhhSPRoOHskHgTUJMHcEKFjZXy5CS3IyUXDpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609952; c=relaxed/simple;
	bh=m7Oe0hrO/SaSK9CbLbnbQuqHRlsZQ3cJqFAQRSV5YFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9Ft8vceHvqpuJMWrzV0DhPLLWBi7Npslzfe0E0A6zsfKyWz0eVI/BZP9hRCSAIJ9ae2x+rbFNV9XKN+FueNKoPT/IGVodHrrzxXfOcyv/5JjgeBW0hogaFLt4H7ijjNS22nlUCxcRaFmg6TALvZqUuosCVEANDo2mOlZ4QGAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn94X2+T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn94X2+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746609948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q45Fl1fG5Qw7jOH7vbx+Agmkts6hCtTaXHH5IfYLwxo=;
	b=cn94X2+T/ZmCMS/IJYHhK+wnYdIL4no69MveWSHFulAoVn2ROKnCqr2wiPmCBBbrOZuDiq
	lKWeaDEa0lRu3KbDclu3/0dWo9fA/oUJPUBE85fph/Yc5VtJ8omPhnSlz8hvGq6ZYJLFmU
	msdMWYRazgTOosE8mHYzl2KFTyFVhd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-dUhqL3nKP8SYnYpTcboI4g-1; Wed,
 07 May 2025 05:25:46 -0400
X-MC-Unique: dUhqL3nKP8SYnYpTcboI4g-1
X-Mimecast-MFC-AGG-ID: dUhqL3nKP8SYnYpTcboI4g_1746609945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B631195608A;
	Wed,  7 May 2025 09:25:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E75518004A7;
	Wed,  7 May 2025 09:25:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: fix warning on 'make htmldocs'
Date: Wed,  7 May 2025 17:25:37 +0800
Message-ID: <20250507092537.3009112-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix the following warning when running 'make htmldocs':

+WARNING: include/linux/blk-mq.h:532 struct member 'update_nr_hwq_lock' not described in 'blk_mq_tag_set'

Fixes: 98e68f67020c ("block: prevent adding/deleting disk during updating nr_hw_queues")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250507163220.00141d77@canb.auug.org.au/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ef84d53095a6..906bf330ffb5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -507,6 +507,9 @@ enum hctx_type {
  *		   request_queue.tag_set_list.
  * @srcu:	   Use as lock when type of the request queue is blocking
  *		   (BLK_MQ_F_BLOCKING).
+ * @update_nr_hwq_lock:
+ * 		   Synchronize updating nr_hw_queues with add/del disk &
+ * 		   switching elevator.
  */
 struct blk_mq_tag_set {
 	const struct blk_mq_ops	*ops;
-- 
2.47.1

