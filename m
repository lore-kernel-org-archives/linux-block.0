Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1903F075B
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155233; cv=none; b=fYxtv20sZbFpow0yGBrVIqA0sRYt8oKXklseO/YT2JrRvYv8pUvhxGfOT2pfIVtWjCsdfCsqbvoch8Fd2jKqAmbqrnBLys16Og4DSHwfcOL/IOlCDqU1ej7dLCvDb7WKe0eYMcYJFOP5rNCYLmn4J/i3A7chcNTKd5V2aRowSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155233; c=relaxed/simple;
	bh=bwu3lJG2Wf3168aCwK2q+o/KnGeFpNU/q2NLY5NX7Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYooiDEnCDhGC4ebiJeuIsCuodJTUJc9RE1zZlle0WJpRqfF/znWxvXwGqoaUgku269nIDNlHy19/14yrybAGce5rUBhs8RI/Z75iI20cr5u+GufZ0dGpFeqNEAxvA1sNbX+zgHJlI2vslK3h6kFxn9V3MUNk+3crk7OjbacZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tZiQfHwG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tZiQfHwG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJZ6YLWzlfwHS;
	Thu,  2 Apr 2026 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155226; x=1777747227; bh=N1mPU
	g3esWGZCWkJ15KsHvc4RI/POznXoIDo9NdEKOw=; b=tZiQfHwG0Nrg4J2dArMUp
	2NYkaBuxP8OVwgH7j6/Hvkd8/a9nMfQmn55xzJlY7MXGyu2OjvCvTf4RedUi2dDx
	ndQJMzNBl3M+jwAGsvC81p0AvcXfShuoCvt/b4t9ffgqpGgIGN03VlXL7NA07VMB
	0noSiOcIOaHvohQuQfrsiziyGpPSOQxBKRMQREs/0KqxwSyQxNs4CIDiCwiYYJ07
	N+/ZHZMuIk0toimUMphW2NF2w7YNxoc9+ZaJURwXSSkURQFDS//38+2HxdwyOsqG
	s5mmToKBBMuP6Ox/oxBmwEXG2naBnAMF+jcGR3gm6U9WfAzMt3C1QltK2g1yxITr
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KA6hVbpDp2Zc; Thu,  2 Apr 2026 18:40:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJS3f1JzlfwJB;
	Thu,  2 Apr 2026 18:40:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 07/12] block/blk-iocost: Add lock context annotations
Date: Thu,  2 Apr 2026 11:39:39 -0700
Message-ID: <20260402183950.3626956-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since iocg_lock() and iocg_unlock() both use conditional locking,
annotate both with __no_context_analysis and use token_context_lock() to
introduce a new lock context.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 353c165c5cd4..3bb8ce50af42 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -727,7 +727,11 @@ static void iocg_commit_bio(struct ioc_gq *iocg, str=
uct bio *bio,
 	put_cpu_ptr(gcs);
 }
=20
+token_context_lock(ioc_lock);
+
 static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long =
*flags)
+	__acquires(ioc_lock)
+	__context_unsafe(conditional locking)
 {
 	if (lock_ioc) {
 		spin_lock_irqsave(&iocg->ioc->lock, *flags);
@@ -738,6 +742,8 @@ static void iocg_lock(struct ioc_gq *iocg, bool lock_=
ioc, unsigned long *flags)
 }
=20
 static void iocg_unlock(struct ioc_gq *iocg, bool unlock_ioc, unsigned l=
ong *flags)
+	__releases(ioc_lock)
+	__context_unsafe(conditional locking)
 {
 	if (unlock_ioc) {
 		spin_unlock(&iocg->waitq.lock);
