Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF203F4DE2
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420126; cv=none; b=QlDeutjnGrrLK+Nv34RD2zlygrlC4CHv1tbbY3CGpEuTsCWDeV9rY8VPdEzM9BJ7tOKISQr9oaMEAhhuYpl5b6n5wNjOJxTYVvogyfNEu11hq1N7sCD7qrZHX2aa+bAtuLnHzyYXPbEuwUSm4ZvmEpXkK7w7MIUaz3cyHzJJdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420126; c=relaxed/simple;
	bh=oONaFj2FqSQz65z2kW+SG1QoMGPZ0bLGF8/2DR2xRng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLb/7cE35oKyNg2QR4wRqrPLJfNkEfBjSZbV5hveiNUqOfJ2qAMOQrFd2ArW8+8jER+wkOghLXG8OF0OXwd/+ZWprYmUcCShfvprffsMNU7Yr6rpmVdukoW2qF6iwffz7UkeJPCy2B2H6C6bXfTu1K4DxnVWcCwrpNhKh0+aRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IcUYsjjJ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IcUYsjjJ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNX643Fz1XM0nw;
	Tue,  2 Jun 2026 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420116; x=1783012117; bh=7sxDz
	r234ly4JMo61FQM3nkkOybUDS/BD/v33622zU4=; b=IcUYsjjJQtUd0mnugwfB7
	27Of1Gv1N2v0jza3PPghxg0TrcNxBgkjqN17jvYxiBXTgvlhrc7jufdgFnyORJaf
	wq8M2L/kWlNMfotmmYqQzMg8wultr6n2+CjgRY0rr5sTEUYQcF+N0hem2H47HWlo
	vzB6f+kqTBilAx7PyBxB+BC0ZYga5qGzePdZNVMqxu4P6pJoebTI4Je6yZMFwbrp
	MpjiwknbrejWEIxfprEudC+42UiXxQ6gAxlFp+fWcM/V3IKHHIh1JBnv5fMnoDo6
	48CnoZE8FWoIzEKRtK778dWxV9RduPEjXSC/EuD2WYLF625sauwD1qgptNflu1tS
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cI14BulBs4hk; Tue,  2 Jun 2026 17:08:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHNM097xz1XM0nn;
	Tue,  2 Jun 2026 17:08:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 10/14] block/blk-iocost: Inline iocg_lock() and iocg_unlock()
Date: Tue,  2 Jun 2026 10:07:39 -0700
Message-ID: <e0e81fbd746bfb54c31cb84f8671a0c23dcdedb2.1780419600.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
References: <cover.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Both iocg_lock() and iocg_unlock() use conditional locking. Fold these
functions into their callers such that unlocking becomes unconditional.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c | 49 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8f1468444e97..e58274bc83e0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -727,26 +727,6 @@ static void iocg_commit_bio(struct ioc_gq *iocg, str=
uct bio *bio,
 	put_cpu_ptr(gcs);
 }
=20
-static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long =
*flags)
-{
-	if (lock_ioc) {
-		spin_lock_irqsave(&iocg->ioc->lock, *flags);
-		spin_lock(&iocg->waitq.lock);
-	} else {
-		spin_lock_irqsave(&iocg->waitq.lock, *flags);
-	}
-}
-
-static void iocg_unlock(struct ioc_gq *iocg, bool unlock_ioc, unsigned l=
ong *flags)
-{
-	if (unlock_ioc) {
-		spin_unlock(&iocg->waitq.lock);
-		spin_unlock_irqrestore(&iocg->ioc->lock, *flags);
-	} else {
-		spin_unlock_irqrestore(&iocg->waitq.lock, *flags);
-	}
-}
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/iocost.h>
=20
@@ -1585,13 +1565,17 @@ static enum hrtimer_restart iocg_waitq_timer_fn(s=
truct hrtimer *timer)
 	struct ioc_gq *iocg =3D container_of(timer, struct ioc_gq, waitq_timer)=
;
 	bool pay_debt =3D READ_ONCE(iocg->abs_vdebt);
 	struct ioc_now now;
-	unsigned long flags;
=20
 	ioc_now(iocg->ioc, &now);
=20
-	iocg_lock(iocg, pay_debt, &flags);
-	iocg_kick_waitq(iocg, pay_debt, &now);
-	iocg_unlock(iocg, pay_debt, &flags);
+	if (pay_debt) {
+		guard(spinlock_irqsave)(&iocg->ioc->lock);
+		guard(spinlock)(&iocg->waitq.lock);
+		iocg_kick_waitq(iocg, pay_debt, &now);
+	} else {
+		guard(spinlock_irqsave)(&iocg->waitq.lock);
+		iocg_kick_waitq(iocg, pay_debt, &now);
+	}
=20
 	return HRTIMER_NORESTART;
 }
@@ -2706,7 +2690,6 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, =
struct bio *bio)
 	u64 abs_cost, cost, vtime;
 	bool use_debt, ioc_locked;
 	enum over_budget_action action;
-	unsigned long flags;
=20
 	/* bypass IOs if disabled, still initializing, or for root cgroup */
 	if (!ioc->enabled || !iocg || !iocg->level)
@@ -2745,10 +2728,18 @@ static void ioc_rqos_throttle(struct rq_qos *rqos=
, struct bio *bio)
 	use_debt =3D bio_issue_as_root_blkg(bio) || fatal_signal_pending(curren=
t);
 	ioc_locked =3D use_debt || READ_ONCE(iocg->abs_vdebt);
 retry_lock:
-	iocg_lock(iocg, ioc_locked, &flags);
-	action =3D iocg_handle_over_budget(rqos, iocg, bio, &now, &wait, use_de=
bt,
-					 ioc_locked, abs_cost, cost);
-	iocg_unlock(iocg, ioc_locked, &flags);
+	if (ioc_locked) {
+		guard(spinlock_irqsave)(&iocg->ioc->lock);
+		guard(spinlock)(&iocg->waitq.lock);
+		action =3D iocg_handle_over_budget(rqos, iocg, bio, &now, &wait,
+						 use_debt, ioc_locked, abs_cost,
+						 cost);
+	} else {
+		guard(spinlock_irqsave)(&iocg->waitq.lock);
+		action =3D iocg_handle_over_budget(rqos, iocg, bio, &now, &wait,
+						 use_debt, ioc_locked, abs_cost,
+						 cost);
+	}
 	switch (action) {
 	case action_retry:
 		ioc_locked =3D true;
