Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLhsFnXw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9C1A7
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 18:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700188542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnu94bt0MVWaB8kuTWdRTfqGixU4G3fj3vPZ0hUAjyg=;
	b=RLhsFnXwNb52cXijRD2a0hnSwaM14rAnw1Z2sl00dAqfyOvTYxJhtvZf/UpzBUH2otb0PI
	Wls59LX7MYsfD4f6K6AIjhHX7IMG+EI0jqMP9uQIK7k110IZlQIkyWYIaRA3EX3qCiijNH
	ibD24JMmlcbWya66O+V26Rq3JZvSbQg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-ZUgE46LdP8qOxn-JeoFYdA-1; Thu,
 16 Nov 2023 21:35:38 -0500
X-MC-Unique: ZUgE46LdP8qOxn-JeoFYdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 312293C00203;
	Fri, 17 Nov 2023 02:35:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67AC42026D4C;
	Fri, 17 Nov 2023 02:35:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH 1/3] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
Date: Fri, 17 Nov 2023 10:35:22 +0800
Message-ID: <20231117023527.3188627-2-ming.lei@redhat.com>
In-Reply-To: <20231117023527.3188627-1-ming.lei@redhat.com>
References: <20231117023527.3188627-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Inside blkg_for_each_descendant_pre(), both
css_for_each_descendant_pre() and blkg_lookup() requires RCU read lock,
and either cgroup_assert_mutex_or_rcu_locked() or rcu_read_lock_held()
is called.

Fix the warning by adding rcu read lock.

Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 38a881cf97d0..050f8ac6fcb1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1314,6 +1314,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1341,6 +1342,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
-- 
2.41.0

