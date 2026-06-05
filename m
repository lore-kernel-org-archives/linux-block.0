Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7437FF4B
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682529; cv=none; b=QsO4V1ghogAV7UoKIxfoHun1/+7frvck63u6hY7dgMWC7czS9Wf5iIeOju8yNbheaEZtKTSOUi+20MCm+QZ6xfgi827yOq2ILlxWQhvmZFBhOd/rKKrEmOuZTo/EPc5iLi+JWkOAn9zH68B8p7mzAOQjB2i+HveuPCeuQG/Z+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682529; c=relaxed/simple;
	bh=0SmXBViRgoK8QcepWccqPhstS/X+DeTJvU5XSd+VY4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbUk/3aWp5UjgFp1CKrJeU+Jpw+s4VPfnKQcjQeNRr+KLEYLohNttjG58jLF5Epi1pkinkfHvF8dBfgwJq86cc3Yj+K1YcWa/rUfweFPIBxfpRVWrNRLAqcBBMSuWcDWzmjKQw/KvAun5odSXiUI2R3KpgVVM/lROnhKL1785j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=T1H761Sv; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="T1H761Sv"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Qm09jnz1XM0pP;
	Fri,  5 Jun 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682514; x=1783274515; bh=7Lqc0
	wU8Z/O9UWeN6jxLvwXPT9hdYccqONhHUa4GPaI=; b=T1H761Svs7Zbqg7B1AH+5
	GzK9wk0m0TzLZ4VgCNPfULCyvzMkGX94zzidqMRQXPNV+DzIvftjEIqo16ivJX2Y
	Oe0LvPLHZFWY6iePMJkLEtg+Xt5facmG+CGKQCvinaYE26GJvjuZKBCfr/t3VPhG
	Q9C/HPXMZZcZTcR8YOqDXaAr4lIA+a6CKoIpQgmRzgjSTahBNWsFkE9cn1N6ZqCQ
	9LStWzAXgfK1UKEHNwfrcVQ5xhQ4HJsEhyLZ4AiBke3P6Y3ITDk7pzyW8spZlLkM
	WoZHbgbKRXOC9iYxQBKK2rFoPz704toqK7lPUHtCcRI0YQb1837ibF95AWtSnEc5
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Oaqj-g_5Ieaj; Fri,  5 Jun 2026 18:01:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8QS1yq7z1XM6Jh;
	Fri,  5 Jun 2026 18:01:51 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v7 09/14] block/blk-iocost: Split ioc_rqos_throttle()
Date: Fri,  5 Jun 2026 11:01:02 -0700
Message-ID: <a6d3ed953cef6669d23a80923bf46600733cbdae.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for inlining iocg_lock() and iocg_unlock() by moving the code
between these two calls into a new function. No functionality has been
changed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c | 163 ++++++++++++++++++++++++++-------------------
 1 file changed, 94 insertions(+), 69 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 302388e99588..8f1468444e97 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2614,6 +2614,88 @@ static u64 calc_size_vtime_cost(struct request *rq=
, struct ioc *ioc)
 	return cost;
 }
=20
+enum over_budget_action {
+	action_retry,
+	action_commit,
+	action_wait,
+	action_return,
+};
+
+static enum over_budget_action
+iocg_handle_over_budget(struct rq_qos *rqos, struct ioc_gq *iocg,
+			struct bio *bio, struct ioc_now *now,
+			struct iocg_wait *wait, bool use_debt, bool ioc_locked,
+			u64 abs_cost, u64 cost)
+{
+	lockdep_assert_held(&iocg->waitq.lock);
+
+	/*
+	 * @iocg must stay activated for debt and waitq handling. Deactivation
+	 * is synchronized against both ioc->lock and waitq.lock and we won't
+	 * get deactivated as long as we're waiting or have debt, so we're good
+	 * if we're activated here. In the unlikely cases that we aren't, just
+	 * issue the IO.
+	 */
+	if (unlikely(list_empty(&iocg->active_list)))
+		return action_commit;
+
+	/*
+	 * We're over budget. If @bio has to be issued regardless, remember
+	 * the abs_cost instead of advancing vtime. iocg_kick_waitq() will pay
+	 * off the debt before waking more IOs.
+	 *
+	 * This way, the debt is continuously paid off each period with the
+	 * actual budget available to the cgroup. If we just wound vtime, we
+	 * would incorrectly use the current hw_inuse for the entire amount
+	 * which, for example, can lead to the cgroup staying blocked for a
+	 * long time even with substantially raised hw_inuse.
+	 *
+	 * An iocg with vdebt should stay online so that the timer can keep
+	 * deducting its vdebt and [de]activate use_delay mechanism
+	 * accordingly. We don't want to race against the timer trying to
+	 * clear them and leave @iocg inactive w/ dangling use_delay heavily
+	 * penalizing the cgroup and its descendants.
+	 */
+	if (use_debt) {
+		iocg_incur_debt(iocg, abs_cost, now);
+		if (iocg_kick_delay(iocg, now))
+			blkcg_schedule_throttle(rqos->disk,
+						(bio->bi_opf & REQ_SWAP) =3D=3D
+							REQ_SWAP);
+		return action_return;
+	}
+
+	/* guarantee that iocgs w/ waiters have maximum inuse */
+	if (!iocg->abs_vdebt && iocg->inuse !=3D iocg->active) {
+		if (!ioc_locked)
+			return action_retry;
+		lockdep_assert_held(&iocg->ioc->lock);
+		propagate_weights(iocg, iocg->active, iocg->active, true, now);
+	}
+
+	/*
+	 * Append self to the waitq and schedule the wakeup timer if we're
+	 * the first waiter.  The timer duration is calculated based on the
+	 * current vrate.  vtime and hweight changes can make it too short
+	 * or too long.  Each wait entry records the absolute cost it's
+	 * waiting for to allow re-evaluation using a custom wait entry.
+	 *
+	 * If too short, the timer simply reschedules itself.  If too long,
+	 * the period timer will notice and trigger wakeups.
+	 *
+	 * All waiters are on iocg->waitq and the wait states are
+	 * synchronized using waitq.lock.
+	 */
+	init_wait_func(&wait->wait, iocg_wake_fn);
+	wait->bio =3D bio;
+	wait->abs_cost =3D abs_cost;
+	wait->committed =3D false; /* will be set true by waker */
+
+	__add_wait_queue_entry_tail(&iocg->waitq, &wait->wait);
+	iocg_kick_waitq(iocg, ioc_locked, now);
+	return action_wait;
+}
+
 static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 {
 	struct blkcg_gq *blkg =3D bio->bi_blkg;
@@ -2623,6 +2705,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, =
struct bio *bio)
 	struct iocg_wait wait;
 	u64 abs_cost, cost, vtime;
 	bool use_debt, ioc_locked;
+	enum over_budget_action action;
 	unsigned long flags;
=20
 	/* bypass IOs if disabled, still initializing, or for root cgroup */
@@ -2663,80 +2746,22 @@ static void ioc_rqos_throttle(struct rq_qos *rqos=
, struct bio *bio)
 	ioc_locked =3D use_debt || READ_ONCE(iocg->abs_vdebt);
 retry_lock:
 	iocg_lock(iocg, ioc_locked, &flags);
-
-	/*
-	 * @iocg must stay activated for debt and waitq handling. Deactivation
-	 * is synchronized against both ioc->lock and waitq.lock and we won't
-	 * get deactivated as long as we're waiting or has debt, so we're good
-	 * if we're activated here. In the unlikely cases that we aren't, just
-	 * issue the IO.
-	 */
-	if (unlikely(list_empty(&iocg->active_list))) {
-		iocg_unlock(iocg, ioc_locked, &flags);
+	action =3D iocg_handle_over_budget(rqos, iocg, bio, &now, &wait, use_de=
bt,
+					 ioc_locked, abs_cost, cost);
+	iocg_unlock(iocg, ioc_locked, &flags);
+	switch (action) {
+	case action_retry:
+		ioc_locked =3D true;
+		goto retry_lock;
+	case action_commit:
 		iocg_commit_bio(iocg, bio, abs_cost, cost);
 		return;
-	}
-
-	/*
-	 * We're over budget. If @bio has to be issued regardless, remember
-	 * the abs_cost instead of advancing vtime. iocg_kick_waitq() will pay
-	 * off the debt before waking more IOs.
-	 *
-	 * This way, the debt is continuously paid off each period with the
-	 * actual budget available to the cgroup. If we just wound vtime, we
-	 * would incorrectly use the current hw_inuse for the entire amount
-	 * which, for example, can lead to the cgroup staying blocked for a
-	 * long time even with substantially raised hw_inuse.
-	 *
-	 * An iocg with vdebt should stay online so that the timer can keep
-	 * deducting its vdebt and [de]activate use_delay mechanism
-	 * accordingly. We don't want to race against the timer trying to
-	 * clear them and leave @iocg inactive w/ dangling use_delay heavily
-	 * penalizing the cgroup and its descendants.
-	 */
-	if (use_debt) {
-		iocg_incur_debt(iocg, abs_cost, &now);
-		if (iocg_kick_delay(iocg, &now))
-			blkcg_schedule_throttle(rqos->disk,
-					(bio->bi_opf & REQ_SWAP) =3D=3D REQ_SWAP);
-		iocg_unlock(iocg, ioc_locked, &flags);
+	case action_return:
 		return;
+	case action_wait:
+		break;
 	}
=20
-	/* guarantee that iocgs w/ waiters have maximum inuse */
-	if (!iocg->abs_vdebt && iocg->inuse !=3D iocg->active) {
-		if (!ioc_locked) {
-			iocg_unlock(iocg, false, &flags);
-			ioc_locked =3D true;
-			goto retry_lock;
-		}
-		propagate_weights(iocg, iocg->active, iocg->active, true,
-				  &now);
-	}
-
-	/*
-	 * Append self to the waitq and schedule the wakeup timer if we're
-	 * the first waiter.  The timer duration is calculated based on the
-	 * current vrate.  vtime and hweight changes can make it too short
-	 * or too long.  Each wait entry records the absolute cost it's
-	 * waiting for to allow re-evaluation using a custom wait entry.
-	 *
-	 * If too short, the timer simply reschedules itself.  If too long,
-	 * the period timer will notice and trigger wakeups.
-	 *
-	 * All waiters are on iocg->waitq and the wait states are
-	 * synchronized using waitq.lock.
-	 */
-	init_wait_func(&wait.wait, iocg_wake_fn);
-	wait.bio =3D bio;
-	wait.abs_cost =3D abs_cost;
-	wait.committed =3D false;	/* will be set true by waker */
-
-	__add_wait_queue_entry_tail(&iocg->waitq, &wait.wait);
-	iocg_kick_waitq(iocg, ioc_locked, &now);
-
-	iocg_unlock(iocg, ioc_locked, &flags);
-
 	while (true) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (wait.committed)
