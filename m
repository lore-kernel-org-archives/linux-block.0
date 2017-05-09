Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block, bfq: use pointer entity->sched_data only if set
Date: Tue,  9 May 2017 11:37:27 +0200
Message-Id: <20170509093727.2595-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

In the function __bfq_deactivate_entity, the pointer
entity->sched_data could happen to be used before being properly
initialized. This led to a NULL pointer dereference. This commit fixes
this bug by just using this pointer only where it is safe to do so.

Reported-by: Tom Harrison <l12436.tw@gmail.com>
Tested-by: Tom Harrison <l12436.tw@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-wf2q.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b4fc3e4..8726ede 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1114,12 +1114,21 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-	int is_in_service = entity == sd->in_service_entity;
+	struct bfq_service_tree *st;
+	bool is_in_service;
 
 	if (!entity->on_st) /* entity never activated, or already inactive */
 		return false;
 
+	/*
+	 * If we get here, then entity is active, which implies that
+	 * bfq_group_set_parent has already been invoked for the group
+	 * represented by entity. Therefore, the field
+	 * entity->sched_data has been set, and we can safely use it.
+	 */
+	st = bfq_entity_service_tree(entity);
+	is_in_service = entity == sd->in_service_entity;
+
 	if (is_in_service)
 		bfq_calc_finish(entity, entity->service);
 
-- 
2.10.0
