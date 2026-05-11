Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD50466B4B
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517097; cv=none; b=o9nGUiktByAIRWNFpdn0KsXCImHR2/E/Z5iApx3UFQb0dX8QXfoPHHnsVWaqcq0SjSinOpFT8uodz+MI4ptkTIKODG+SD/5F6Z4wP6rqzzCRzhVl35xlhs+c3H+mTH4DnqFXI/vI38KzRhaEAwsF5AtYGeIW5+dO++TA0SI150U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517097; c=relaxed/simple;
	bh=bwu3lJG2Wf3168aCwK2q+o/KnGeFpNU/q2NLY5NX7Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1u4KUNTOZJE9iBladeDAK5OGen067/zeFPvidmGsjgvlqconhJEFdCyDz5AMC2bDikuZdKrf9bJtrlQntDn1p+MSDthVW1oRnIXEQWJLecNcYpmXzJfeu3sll4kFgSstXMiYFX6FUPOBZ4gBfjiTDBG9ndc40XJJy+33Y8dbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=szXZTTP5; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="szXZTTP5"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbq3N20zlh1SS;
	Mon, 11 May 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517090; x=1781109091; bh=N1mPU
	g3esWGZCWkJ15KsHvc4RI/POznXoIDo9NdEKOw=; b=szXZTTP5sIRBigRFZqluc
	VYXhVkQaIiUi0HlBH0WzC61A3xShR5riM20n0ZpAnPz8+9dEwsHklxpH4XUuwZLC
	VCzw3Cvc+NZ2TLxwe2ktNRXRIsMWYgR5Vbh1lpKTdUDTTHFVJUhiEbvT9u2F4iDf
	rJZs9pciIx6HiCGnm2TMfhVr4eb+rV2FulBt1Q2d8ONQ597NWkEDonCYu1hv9bCm
	ltfQS0MZGdnCdYCEulFW+vFbfqn8p+6sQQY1DXZ+QdwsuJ31lKJLIBC/h0mbI6Rs
	sZUbCltT9/VAMbDUoIg445WxRCtlOx1EtttfrXNXd/Vos9HrOCLRs5iOvrUazXV4
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vWOUyhC0Mklu; Mon, 11 May 2026 16:31:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbh3fnmzlh2g3;
	Mon, 11 May 2026 16:31:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 08/12] block/blk-iocost: Add lock context annotations
Date: Mon, 11 May 2026 09:30:50 -0700
Message-ID: <20260511163100.1887263-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511163100.1887263-1-bvanassche@acm.org>
References: <20260511163100.1887263-1-bvanassche@acm.org>
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
