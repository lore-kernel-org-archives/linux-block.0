Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5126C3BD
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997592; cv=none; b=PXDLu8G8J1ekDA+RoozleD9i2WLEX8bwj0PZfUUEdRzJQQKq1yCd924k7d4Zo2Gbcs0AE2VYt1OdYeM00Z6T8Uw6frd+oy+Mq0WoE53kicPqBpId4z11coDdbxRCc1A2gg1u+8fNHdLnEyTmRSgOAUZKY5grJmP3mgjM1RvA06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997592; c=relaxed/simple;
	bh=bwu3lJG2Wf3168aCwK2q+o/KnGeFpNU/q2NLY5NX7Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdbqXivuof3bAxw71uQr9X5is5WHc34aItdZv9SfhKinOfd9o7YYeC3nP26fOJT+Ltv5hwKQi/vjBBN72TQGF6iHZLqq+71PA/mwJxwC+UWGAKtycR3nEjialmWtDgsUTPoUDVmJKf1wVSKBTvo3H6hv5PypqWeSt9HdKH9gdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QL7yNPd1; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QL7yNPd1"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6v1zhzz1XM0pp;
	Thu, 28 May 2026 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997586; x=1782589587; bh=N1mPU
	g3esWGZCWkJ15KsHvc4RI/POznXoIDo9NdEKOw=; b=QL7yNPd1LwSPBwqdh+g1W
	Wm0Fa5/UHjXzv+6LUJvd4rPllkLk5q50MtYrWh4S/pycz6L9+ok7tBu+Ql8Zx00A
	d7wbhCHuTsaUBO43A0edP6D72WAbkuUL0526ZFlMEmgmdqii2ohE8wuh7yHtr4gw
	1UbDmAMwHm2JPbhZtjcoVqvfgeS2uNolG2Zd3WK6lIvJVd+eyG6pzsaHP6aQhTmg
	Xm8yychyJ+MbZBXrijzAEghOYEr3ZZbd2k1NQ4GW6iibakvoBWxYtCIghBUylE9v
	tsAGO7GMofQGG2cG5ENIobv4e1DMoxB2okBST1U2PFTlt1xZSw3vQWtmwTbjVT7G
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KSkVS8OLtaGZ; Thu, 28 May 2026 19:46:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6n0ZGHz1XM0ph;
	Thu, 28 May 2026 19:46:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 08/12] block/blk-iocost: Add lock context annotations
Date: Thu, 28 May 2026 12:45:45 -0700
Message-ID: <669c0e4dd3a8e8e038dff8c19aa61f0359df2bd8.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
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
