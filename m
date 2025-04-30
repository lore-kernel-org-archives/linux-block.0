Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E715D1
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987777; cv=none; b=RVUSLeSj8sDM8NlTt/kv+CD7MV/lstKXsJOZUuecvwKsl9dFwg92gUqcmSwh+zJmPgeJHW1izo9ydZs/toUdo54WwxTBVW0mPg6tg+QkznRgIdzxu5HYuFbzYd27u73fO9i1iv8LZA+fvFlabxxC8WeUj12N5F6+0Zpy/FrpBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987777; c=relaxed/simple;
	bh=loKv8LlJQY1RVS0lPFBFyRMKTPL6/u698rJiczcizrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+GEe4VOrk/53wFbB9jM5GXWSiWgL6D8EWFx0xlFZa19fURnogFFeot6DIDTKFlbZmIo1f0hXjpReTdWDNFFj/MYrGd66rV7k3WIrkj+9f5CkCxqIIKCN8K1uQzT2xyTEl7jE5DItZnhwf1jvU/iTDHx61B8twmTpu7VY47UbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYR85Q0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYR85Q0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzOGnxp4EcAx6S/qq1QtELq1t1GQxUVsmoH3YjVmHQg=;
	b=aYR85Q0VWJ3MEP+tSlrrrgLNjgrJdBf8ItFdcEVVPNA1mNVz8RdzgPdP80g7RYZRL3I00d
	bA71CmU3wbfp5w4tFqLeNCAgwjeubT+EdS5icP/+rEetNxTu7X3iwPukRqZC5F9AILpwAA
	DtZ9K5sXKAszKg2EYJIznIlQasyYJuw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-dXJJjAN4Mh-mu71oSojcvA-1; Wed,
 30 Apr 2025 00:36:09 -0400
X-MC-Unique: dXJJjAN4Mh-mu71oSojcvA-1
X-Mimecast-MFC-AGG-ID: dXJJjAN4Mh-mu71oSojcvA_1745987768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4984619560AF;
	Wed, 30 Apr 2025 04:36:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 789E0180045B;
	Wed, 30 Apr 2025 04:36:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 08/24] block: don't allow to switch elevator if updating nr_hw_queues is in-progress
Date: Wed, 30 Apr 2025 12:35:10 +0800
Message-ID: <20250430043529.1950194-9-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
path, so it can't be done if updating `nr_hw_queues` is in-progress.

Take same approach with not allowing add/del disk when updating
nr_hw_queues is in-progress, by grabbing read lock of
set->update_nr_hwq_sema.

Take the nested variant for avoiding the following false positive
splat[1], and this way is correct because:

- the read lock in elv_iosched_store() is not overlapped with the read lock
in adding/deleting disk:

- storing to kobject attribute is only available after the kobject is added
and before it is deleted

  -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
  -> #3 (&q->limits_lock){+.+.}-{4:4}:
  -> #2 (&disk->open_mutex){+.+.}-{4:4}:
  -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
  -> #0 (kn->active#103){++++}-{0:0}:

Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 4400eb8fe54f..12296f77efbd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	int ret;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
+	down_read_nested(&set->update_nr_hwq_lock, 1);
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
@@ -741,6 +743,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	up_read(&set->update_nr_hwq_lock);
 	return ret;
 }
 
-- 
2.47.0

