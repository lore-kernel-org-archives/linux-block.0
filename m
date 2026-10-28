Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180557;
	b=CapBqoTOkgKmC3AuWJaaTAhOuj2QbvpWIvfBYAPbfPNknM8e2oM8wocAXZdo8hEuPGdC
	 4VWb9mAWDi+OgOB+LfebT51fgACrYEps9W+PMxMSLwMmRhki/tK4BjF4w8uL0PMoz3G7V
	 ZQfqOzSgiYVoZsWyihRG2Ghjgl+GnbNbzaH6JnH4791p9e8I7aVTtwfHDg6n1/A3m37L5
	 1VtTuvvLpEan4ZXfhqYDqUt1pBaxTrGd+BQ1UwvYZ2v+UK+Y78z6gUgT8BGisIddCfUMr
	 V+RzRZTZk4iRquHIQQ/utspdRSpeJG+O63BVe+ryh0bcTQaK5vKWiMcf7BbxjcvDyoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180557;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:Subject:
	 Mime-Version:Received:Content-Type:To:Cc:Message-Id:X-Original-From:
	 X-Lms-Return-Path:From:Date:X-Mailer;
	bh=97j+tFEtM11pGBZ28dKTSeR+vf1vjBcYbRFUL5UqKPY=;
	b=aEpGfUtQUnSXzHLdby5i5GfFbRFFLxr/92rbWd+oAHw+A85uNrtXuHbrxuOGgTJ2NC14
	 4raeUMhRpncIp9ArGNpDbbnPrY1Amrgr+OZxYBsUYlVW/zPBp8uVMaBWM+RCT0vhojsVo
	 kFo/4A/GXD6tO5uMv+OQNt6AQqJJvie/JuJi90upkQGIgZc1tRCTIRoer1wvXRsazm74R
	 Svoe99aTCQN8PasEdlnHdykBJlkdJV0iUlDgnkwBKQ30OwILMJ1SqeuSJ0KF2So3LnuQ9
	 ofQxOrIYhD4GNi1Ux9sEwB1kwxK0N+33BJ4famtuf4iEdOPfkT9DsfbBFzdE051GSWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fnnas.com;
	spf=pass smtp.mailfrom=fnnas.com;
	dkim=pass header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=cEAw9UDI;
	arc=none smtp.remote-ip=209.127.231.19
Received: from va-2-19.ptr.blmpb.com (va-2-19.ptr.blmpb.com [209.127.231.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864860A3831
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D864860A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=cEAw9UDI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1793180551;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=97j+tFEtM11pGBZ28dKTSeR+vf1vjBcYbRFUL5UqKPY=;
 b=cEAw9UDI+weH2ZGggkG2xydJVVgF0zReLnFI/C3cXyJgyTAIHwkQ/Bft3UqJukoh+m+ZNS
 zJGOwZApkbykLS6FyYnHl4Pqc5QNFl+OvHcE2evk5bNXbenhlZnKdKxVBwVH3tFXs8QtmC
 3g7Z4MPXWY9tR7YPusBxiNX6PxZU6ALaXiYDobXEEAcyNhHgk0YkypUj4OpZsvxz/CSRkI
 uedpRDOBeyDffQZoIjuBJkmVXHUgRVPP3gjX8VAXOifTYWXBdYJImpaEdRPywwVRuyfJ9g
 Dy6rrDKjlhbc5+EkCBDybpdvtsugF49bFiejFWXcZ4croz6ry37DLQBPoRxhoQ==
Content-Transfer-Encoding: 7bit
Subject: [PATCH] bfq: Transfer allocated request counts when moving queues
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from debian.localdomain ([183.34.160.114]) by smtp.feishu.cn with ESMTPS; Wed, 28 Oct 2026 17:42:28 +0800
Content-Type: text/plain; charset=UTF-8
To: "Yu Kuai" <yukuai@fygo.io>, "Jens Axboe" <axboe@kernel.dk>
Cc: "sunyangkai" <sunyangkai@fnnas.com>, <linux-block@vger.kernel.org>, 
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Tejun Heo" <tj@kernel.org>, "Josef Bacik" <josef@toxicpanda.com>, 
	"Jan Kara" <jack@suse.cz>, "Paolo Valente" <paolo.valente@linaro.org>, 
	<stable@vger.kernel.org>
Message-Id: <20261028094208.716946-1-sunyangkai@fnnas.com>
X-Original-From: sunyangkai <sunyangkai@fnnas.com>
X-Lms-Return-Path: <lba+26ae1c385+2fbb7c+vger.kernel.org+sunyangkai@fnnas.com>
From: "sunyangkai" <sunyangkai@fnnas.com>
Date: Wed, 28 Oct 2026 17:42:08 +0800
X-Mailer: git-send-email 2.53.0

bfq_entity::allocated counts the requests allocated in an entity's
subtree. Request allocation increments the queue entity and its
ancestors, while request release decrements the queue entity and its
current ancestors.

When bfq_bfqq_move() moves a queue with outstanding requests to another
group, it changes entity->parent without transferring these charges.
The old ancestors retain the charges, while subsequent request releases
decrement the new ancestors even though they were never charged. This
can leave the destination group's allocated count negative and the
source group's count inflated after all requests have completed,
distorting the limits enforced by bfqq_request_over_limit().

Subtract the queue's outstanding request count from its old ancestors
before dropping the old group reference, and add it to the new ancestors
after reparenting. Leave the queue's own count unchanged. Shared
ancestors have no net change, and bfqd->lock serializes the transfer
with request accounting.

Fixes: 98f044999ba1 ("bfq: Track number of allocated requests in bfq_entity")
Cc: stable@vger.kernel.org
Signed-off-by: sunyangkai <sunyangkai@fnnas.com>
---
Validation used a QEMU guest running a 6.18.18-based kernel, with BFQ
on a virtio block device. The workload submitted direct asynchronous
reads in /a/child, moved the task to /b, submitted more reads, and waited
for all completions before repeating. A read-only kretprobe observed
bfq_bfqq_move() entry and return counters.

Without the fix, the drained destination group reached allocated=-1
and then -2. With the fix, outstanding charges were transferred and
the drained group counts were zero. Both runs covered migrations with
outstanding requests, completed all reads successfully, and reported
zero missed probes. This was not a runtime test of upstream master.

 block/bfq-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index ef9d63e8542e..e3a98244b9f6 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -645,6 +645,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 	struct bfq_group *old_parent = bfqq_group(bfqq);
+	struct bfq_entity *parent;
 	bool has_pending_reqs = false;
 
 	/*
@@ -685,11 +686,16 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
+	/* Transfer outstanding request charges before dropping the old group. */
+	for (parent = entity->parent; parent; parent = parent->parent)
+		parent->allocated -= entity->allocated;
 	bfqg_and_blkg_put(old_parent);
 
 	bfq_reassign_last_bfqq(bfqq, NULL);
 	entity->parent = bfqg->my_entity;
 	entity->sched_data = &bfqg->sched_data;
+	for (parent = entity->parent; parent; parent = parent->parent)
+		parent->allocated += entity->allocated;
 	/* pin down bfqg and its associated blkg  */
 	bfqg_and_blkg_get(bfqg);
 
-- 
2.53.0
