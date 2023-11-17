Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlWQstF6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56ACE
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 18:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700188548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fvypP67J2PbD+4CInlSISERf8gJTLZ/m1HfR+8iDnc=;
	b=YlWQstF6G1Q3ANlvgdNsLCIlKt+lx5/oxnW7qXiNJY26UDLUIJe26Tt80HbUFBfJNXuW5D
	fHpQQytb5MmEt8tVE8dHJSgP3erwKWPlIZx24OjFOov3qczYaKGypSbUfcLRtvbR0BWhZQ
	Y9pe9K8w7Q4M1JmZHCm0rtK1Oh0/pDE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-EyuYHdJFNVKlxX4qccuSZg-1; Thu,
 16 Nov 2023 21:35:45 -0500
X-MC-Unique: EyuYHdJFNVKlxX4qccuSZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 266B029AA2C6;
	Fri, 17 Nov 2023 02:35:45 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 49125492BE0;
	Fri, 17 Nov 2023 02:35:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] blk-cgroup: bypass blkcg_deactivate_policy after destroying
Date: Fri, 17 Nov 2023 10:35:24 +0800
Message-ID: <20231117023527.3188627-4-ming.lei@redhat.com>
In-Reply-To: <20231117023527.3188627-1-ming.lei@redhat.com>
References: <20231117023527.3188627-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

blkcg_deactivate_policy() can be called after blkg_destroy_all()
returns, and it isn't necessary since blkg_destroy_all has covered
policy deactivation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4a42ea2972ad..4b48c2c44098 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -577,6 +577,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
+	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
@@ -602,6 +603,18 @@ static void blkg_destroy_all(struct gendisk *disk)
 		}
 	}
 
+	/*
+	 * Mark policy deactivated since policy offline has been done, and
+	 * the free is scheduled, so future blkcg_deactivate_policy() can
+	 * be bypassed
+	 */
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (pol)
+			__clear_bit(pol->plid, q->blkcg_pols);
+	}
+
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
-- 
2.41.0

