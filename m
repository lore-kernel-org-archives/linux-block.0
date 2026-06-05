Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA3386552
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682526; cv=none; b=Sa9H2UAMYCa61+CDbLkdbFlD6Mid/6Hj+vFWeLSNnxjEdz55BY5WVuzn2wUKng4MIHh1dBIoVRKQ0UrohqYhS2KPdeXXRb0JGwZjoi+owIjwbujNCfm+qB2g8zrU7P2wAG77FUdg3lhWke8IUeTZwM7NhVRCKWlLZlcOZ25qJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682526; c=relaxed/simple;
	bh=Heuijt6q//nRq+5iblMaFTrdTlCdern3MFhnmfHxBjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIvtJz8WZNSgg/qNrRyRjEzaGI0J3sUErHdLUtYh/GgNU6vEKQvdGD5MOF0VBF0si79JvJR1NroJeGBsHh482eta90NPB9lf4ArlkvL7Mzt1tDa+Q7gtCS51ZBokODuBtPhQcQMbKXlo3S0LdjpNjoc1r/jMYLi36/f4zpVe+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uQrKCHm4; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uQrKCHm4"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Qh3H7Tz1XM0pX;
	Fri,  5 Jun 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682517; x=1783274518; bh=vL6IR
	pZU0E9jaKc9ph4/kSwd5xt9Fq5xizmp2SfNGvA=; b=uQrKCHm4UOASLdpXD6L20
	xxOMDpcYGeal8uyDJqv4AwTLYk5/BEn7NjyGgY4Hl9jkHJ//alNKQYbiqm+a/usN
	0TG5eEaeTePz6BMehAZ3cakf+NosbnS2pZnE1CLqLbzhz17fQB+h1AZqQoYQEa6j
	JeLLil//j+es0SgREH8j+bhCqCH6zf2Y+U9OVHgyGejD5LRoiT6Lvfp1+1suM2Zx
	VBD+MTCtK2/0b/UyHU+dORaK2D5hxIQu7KODd/9ZyfPJudwnuCTI9CJhgU3iTSou
	F5LPVS+iD5BN0aUv+Gi4VsgUUYEgEMMI2fbMsvt9hALRV5m9ywAwKXb+IYXXvmA/
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nqagOf4a7d2w; Fri,  5 Jun 2026 18:01:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8QW1Pvjz1XM0pS;
	Fri,  5 Jun 2026 18:01:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v7 10/14] block/blk-iocost: Inline iocg_lock() and iocg_unlock()
Date: Fri,  5 Jun 2026 11:01:03 -0700
Message-ID: <f8c9867788957d2e40a32e23c6d9b866e480ad9d.1780682325.git.bvanassche@acm.org>
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

Both iocg_lock() and iocg_unlock() use conditional locking. Fold these
functions into their callers such that unlocking becomes unconditional.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c | 53 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8f1468444e97..563cc7dcf348 100644
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
@@ -1589,9 +1569,17 @@ static enum hrtimer_restart iocg_waitq_timer_fn(st=
ruct hrtimer *timer)
=20
 	ioc_now(iocg->ioc, &now);
=20
-	iocg_lock(iocg, pay_debt, &flags);
-	iocg_kick_waitq(iocg, pay_debt, &now);
-	iocg_unlock(iocg, pay_debt, &flags);
+	if (pay_debt) {
+		spin_lock_irqsave(&iocg->ioc->lock, flags);
+		spin_lock(&iocg->waitq.lock);
+		iocg_kick_waitq(iocg, pay_debt, &now);
+		spin_unlock(&iocg->waitq.lock);
+		spin_unlock_irqrestore(&iocg->ioc->lock, flags);
+	} else {
+		spin_lock_irqsave(&iocg->waitq.lock, flags);
+		iocg_kick_waitq(iocg, pay_debt, &now);
+		spin_unlock_irqrestore(&iocg->waitq.lock, flags);
+	}
=20
 	return HRTIMER_NORESTART;
 }
@@ -2745,10 +2733,21 @@ static void ioc_rqos_throttle(struct rq_qos *rqos=
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
+		spin_lock_irqsave(&iocg->ioc->lock, flags);
+		spin_lock(&iocg->waitq.lock);
+		action =3D iocg_handle_over_budget(rqos, iocg, bio, &now, &wait,
+						 use_debt, ioc_locked, abs_cost,
+						 cost);
+		spin_unlock(&iocg->waitq.lock);
+		spin_unlock_irqrestore(&iocg->ioc->lock, flags);
+	} else {
+		spin_lock_irqsave(&iocg->waitq.lock, flags);
+		action =3D iocg_handle_over_budget(rqos, iocg, bio, &now, &wait,
+						 use_debt, ioc_locked, abs_cost,
+						 cost);
+		spin_unlock_irqrestore(&iocg->waitq.lock, flags);
+	}
 	switch (action) {
 	case action_retry:
 		ioc_locked =3D true;
