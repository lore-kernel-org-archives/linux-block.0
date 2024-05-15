Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710731109
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736743; cv=none; b=cOPNJzEFSpTXyOPqYXkPQwXBxXctCEsKXc3KiZs0bxhpkkU7mlGEjFaBfHFgiyySTiWxS3ga+CAcjPtAXA2+nZ0sWuKKLO5ezX4Pychl1kz9UvnBbsDcXa/WsgIJYjABQHLOGCxGJo60hQOG69ccg6JjMRYN05rmz+k55ZeZvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736743; c=relaxed/simple;
	bh=VBX1anXVuOXZFWWxBr/zt1N80yDcketIpljCmGY2oDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDgqhUIcBVd0oYLDCoHHB1nPUTkheqIj56WSDHwWmc0Xfrz1dMhc4F5YiMOUezk891E/+TFBxLjzMfM2onNzg6V8Itqm8SJKCf09oYRSeDeky8aXhKihBZCGRcZ1B4EC8nMG75IgCwtJCoTTPm3U1NcC+IxbzT2LCosZfqEiGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OClMtqv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OClMtqv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715736740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ha7OIQ40eQh3TqHw+pOAQNbUtsXQFI7nGwiHJZy1RnA=;
	b=OClMtqv9fQdLrjQn3PsCREbvQ40PhX2ns+MYYYLWKC8JaMMSQA6z7IvSOiNXpZ6BEo2SEb
	zj5wcOSbUShioO2FyjytxjyIhqPJR5GTLCe2esp5A4rnFNtf/iTpH/h5MRX0gvNHHZB0Zx
	1HyRh17FrvNBTvtVDWbo+epYP2GMeLQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-qYHDQumyPyijQ7lLpRqa9Q-1; Tue,
 14 May 2024 21:32:16 -0400
X-MC-Unique: qYHDQumyPyijQ7lLpRqa9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 052461C01500;
	Wed, 15 May 2024 01:32:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C13E021EE56B;
	Wed, 15 May 2024 01:32:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] blk-cgroup: fix list corruption from reorder of WRITE ->lqueued
Date: Wed, 15 May 2024 09:31:57 +0800
Message-ID: <20240515013157.443672-3-ming.lei@redhat.com>
In-Reply-To: <20240515013157.443672-1-ming.lei@redhat.com>
References: <20240515013157.443672-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

__blkcg_rstat_flush() can be run anytime, especially when blk_cgroup_bio_start
is being executed.

If WRITE of `->lqueued` is re-ordered with READ of 'bisc->lnode.next' in
the loop of __blkcg_rstat_flush(), `next_bisc` can be assigned with one
stat instance being added in blk_cgroup_bio_start(), then the local
list in __blkcg_rstat_flush() could be corrupted.

Fix the issue by adding one barrier.

Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 86752b1652b5..b36ba1d40ba1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1036,6 +1036,16 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 		struct blkg_iostat cur;
 		unsigned int seq;
 
+		/*
+		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
+		 * llist_for_each_entry_safe and clearing `bisc->lqueued` for
+		 * avoiding to assign `next_bisc` with new next pointer added
+		 * in blk_cgroup_bio_start() in case of re-ordering.
+		 *
+		 * The pair barrier is implied in llist_add() in blk_cgroup_bio_start().
+		 */
+		smp_mb();
+
 		WRITE_ONCE(bisc->lqueued, false);
 
 		/* fetch the current per-cpu values */
-- 
2.44.0

