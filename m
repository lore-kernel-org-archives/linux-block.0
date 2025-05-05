Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6E2505D6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454718; cv=none; b=f51nF5tg76RmMyq2hch8Zlm8TceyxKuiKqI4sqQs2cdrsjz8v/W55fScUaMFBCYgrkx6ku6cchP17zWVFvvvLMX6U4CssyB1WKPxH1eADmx98iBG+isi1hxfJC0ZegK9beXVkFOn2yVzWOW0v6EC34aP8UnMTDurGdHID7AXiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454718; c=relaxed/simple;
	bh=f6Ws/aKl0hiCia4kpVjXMlUuPlZwZmZuHl7Ufkgnw2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7tPueIuuhwvnXaAS9olU6dpZ6wVmE/x6wiwMkiZxhtVR+Deh6UOiP2HpH8r6ddMdTlrvidCIWwUSOlVK+mnGhzTFnk/abbzEzJbyi9J2fwcLJ2i9gt8FX7b4EmK+yNClfnQUxRUY6evH5NzHxJuCzklhStRiLIlNYjPQHpjj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuQxxQeV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuQxxQeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wA36hOWRz4zzOanRIrOPG4cgnHK+c3+IavYbiJBSkbA=;
	b=IuQxxQeVGTgKs7x6y98OhfEY+OeoY8o+beFQyOtfEVrC1tmdGT/rYtozdC0BcS1soPRw3T
	t9DHMmwmXpIo4sd+IXpS87Ft4uii35yodV5FcUiH69V6guMGjwG4o7Uaqacj5OX+PDVUTL
	Qk+Rdn/lSq1XukZmQcVxeLDfc5SlP5Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-EflQdbUnP_uoOAL-HZITJw-1; Mon,
 05 May 2025 10:18:31 -0400
X-MC-Unique: EflQdbUnP_uoOAL-HZITJw-1
X-Mimecast-MFC-AGG-ID: EflQdbUnP_uoOAL-HZITJw_1746454710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 493831800EC8;
	Mon,  5 May 2025 14:18:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 557F2195608D;
	Mon,  5 May 2025 14:18:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 04/25] block: use q->elevator with ->elevator_lock held in elv_iosched_show()
Date: Mon,  5 May 2025 22:17:42 +0800
Message-ID: <20250505141805.2751237-5-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Use q->elevator with ->elevator_lock held in elv_iosched_show(), since
the local cached elevator reference may become stale after getting
->elevator_lock.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

