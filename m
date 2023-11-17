Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XelEM4Gz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907CD1A8
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 18:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700188543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUTiqpX1o50fYZ0p27BQ7eV/xDbJcwy477C1lJ4HW/M=;
	b=XelEM4GzPf9YbxQY/Nyy9+kWudrEcPu49tShYuKHDYzRD5N4ew1Nicz3oB11qUj0OSnU77
	TKAKh4RQjeRVM39BRxVyWEX8IyOy7RaQzMfMxmV6NUhzLpxUpHgFX/557Ze1O3GYotbMLD
	W/yiN2Jb2MEabDgyc9brj3ahtr0Da0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-MIp8NyNROHSjLxV-E5v1-Q-1; Thu, 16 Nov 2023 21:35:42 -0500
X-MC-Unique: MIp8NyNROHSjLxV-E5v1-Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE5B685A59D;
	Fri, 17 Nov 2023 02:35:41 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E9A2492BFD;
	Fri, 17 Nov 2023 02:35:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH 2/3] blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()
Date: Fri, 17 Nov 2023 10:35:23 +0800
Message-ID: <20231117023527.3188627-3-ming.lei@redhat.com>
In-Reply-To: <20231117023527.3188627-1-ming.lei@redhat.com>
References: <20231117023527.3188627-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

So far, all callers either holds spin lock or rcu read explicitly, and
most of the caller has added WARN_ON_ONCE(!rcu_read_lock_held()) or
lockdep_assert_held(&disk->queue->queue_lock).

Remove WARN_ON_ONCE(!rcu_read_lock_held()) from blkg_lookup() for
killing the false positive warning from blkg_conf_prep().

Reported-by: Changhui Zhong <czhong@redhat.com>
Fixes: 83462a6c971c ("blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 624c03c8fe64..fd482439afbc 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -249,8 +249,6 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 {
 	struct blkcg_gq *blkg;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
 	if (blkcg == &blkcg_root)
 		return q->root_blkg;
 
-- 
2.41.0

