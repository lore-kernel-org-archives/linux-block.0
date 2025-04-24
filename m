Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E01DBB37
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508137; cv=none; b=ScQ9l98LnwYAQihKUhDrGJ9F6KNK7qokEXMBTs3FklT8lEIsR+juxDPqMkYAcGfx0nNWA5za4XF8Abf0gVuCx6V5J1KWcA7tGURQLiB47PHgnRu2a/xwSGFm0n6ow0K2HSKTYyMC+KispmfgrKHyH7O1DukPZFI7Xbf+rpJmTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508137; c=relaxed/simple;
	bh=luC1BasH1BvlXXPcmR5JVJyPP7CFR8fOpClCZ2mfJJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elzEOdkLHla46ueFfX1npHJbU0QSq4r1TZ6cyRpqBo+x1Q0MiPD0gen/RuGhlBuXse0BAv1B5o0+6mQ4Hoc6EFrE5wqDMLlSwx2NwodCkVyxKqgzhBh4kiHX6tmWuTd/fkDlZiwlSk/we/4ezzwumjBapTVFa+VoDj7z6bH9+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G98MbIuS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G98MbIuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrB/1pTVzuMRiEsdVq7OLwCCciJroPOzOxWAN2vrso=;
	b=G98MbIuSf0mJbtFLLoINaMlIRbKQcZm1EjlxSy+ebmVZViABQ1wSDhbQ726AUmI4p9tuCy
	RtHqVzD9T80IxRn3sDAALNfP3BxP9EwE4MVqNH7hgnVkCrZbyvTbkGguZZTg6Eb8ygsEJU
	kfQJ0OqiZqTVcEKWLK9tneHDwWm0gYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-_MmRL7OdPV-952wgfCBomA-1; Thu,
 24 Apr 2025 11:22:13 -0400
X-MC-Unique: _MmRL7OdPV-952wgfCBomA-1
X-Mimecast-MFC-AGG-ID: _MmRL7OdPV-952wgfCBomA_1745508131
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5E711956095;
	Thu, 24 Apr 2025 15:22:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2123180045C;
	Thu, 24 Apr 2025 15:22:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 04/20] block: use q->elevator with ->elevator_lock held in elv_iosched_show()
Date: Thu, 24 Apr 2025 23:21:27 +0800
Message-ID: <20250424152148.1066220-5-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use q->elevator with ->elevator_lock held in elv_iosched_show(), since
the local cached elevator reference may become stale after getting
->elevator_lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5051a98dc08c..b32815594892 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -739,7 +739,6 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 {
 	struct request_queue *q = disk->queue;
-	struct elevator_queue *eq = q->elevator;
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
@@ -748,7 +747,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 		len += sprintf(name+len, "[none] ");
 	} else {
 		len += sprintf(name+len, "none ");
-		cur = eq->type;
+		cur = q->elevator->type;
 	}
 
 	spin_lock(&elv_list_lock);
-- 
2.47.0

