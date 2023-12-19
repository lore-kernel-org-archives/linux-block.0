Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3E1381
	for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6Ea/Bsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702949322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f1IZOXG0KcNHQDnHikp/8+mkHes7qJwKHJJatOGHEcw=;
	b=g6Ea/BspzVDzgam4lN0RecSGlbeazm0y5y940uiPKMMyJb87ZoBiG7lg8ZM5QtrFlW5r+n
	cMO61pyqRlkxB4JWfv2GyEFtJFOCo2JZP7CLfWOVqcSgv/zD+GeZ8TGgEuGxrNDIJugHmh
	iUJ8dJdAerBuiQqDqsc9n2kNpmdx3mU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-j0Ycpy2aM42QhcQBDRDqfg-1; Mon, 18 Dec 2023 20:28:39 -0500
X-MC-Unique: j0Ycpy2aM42QhcQBDRDqfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FF8D86EB61;
	Tue, 19 Dec 2023 01:28:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D48F2166B33;
	Tue, 19 Dec 2023 01:28:38 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
Date: Tue, 19 Dec 2023 09:28:33 +0800
Message-ID: <20231219012833.2129540-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

blkg_lookup() is called with either queue_lock or rcu read lock, so
use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
retrieving 'blkg', which way models the check exactly for covering
queue lock or rcu read lock.

Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference_check() usage!"
from blkg_lookup().

Tested-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index fd482439afbc..b927a4a0ad03 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -252,7 +252,8 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	if (blkcg == &blkcg_root)
 		return q->root_blkg;
 
-	blkg = rcu_dereference(blkcg->blkg_hint);
+	blkg = rcu_dereference_check(blkcg->blkg_hint,
+			lockdep_is_held(&q->queue_lock));
 	if (blkg && blkg->q == q)
 		return blkg;
 
-- 
2.42.0

