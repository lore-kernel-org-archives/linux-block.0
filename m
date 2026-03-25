Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BB2AD00
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475152; cv=none; b=Dv+Z2T3W9gMkNJt814Ylr1cEge1xqPgbp8eRs4Eo2U0Jvq7I4Edk97Z3WWKs805iBX3jcBakEfM2XEuA1mTE6mxCFqJJJ6W4kTiv4U9z3weXiGqElcVS035Q+Wy50/86YnkYGY0IcJ+gCBhnIVQw7r4IY7PB1wJSRA6EMB2Csck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475152; c=relaxed/simple;
	bh=RmYJaaaWNju1c67Y9otaRvcHOBNdysEZBfDXifjhm9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcK71Nx4GbdOAfG3oy/uy6GUZZRCAXOa0Hbe8fcUwGTx2vN3eso591oZtXBcSv3c/8QCYZ1sQ3ocCXlu7oQxELY5npZutK3bCrsVOTrxK8IORjQorHn49MakdFPhlSy8b26bkjHEOyfbzjyM+q+0iVt2Z73vhz7mR5tkZYTNsFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fsnpTOEH; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fsnpTOEH"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0p61vm5zlgyGk;
	Wed, 25 Mar 2026 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475146; x=1777067147; bh=Ru80l
	1Xbc+sEKV8oXW0ZGWCrBrlP4r7ozPMEbgvVHaQ=; b=fsnpTOEH9nCsybA5WnctT
	jGK0j28x1uNg2LDJjvGjXWXTahUgic0VlmFCFF2z6TSkoFI0ErUDrtyPw+eZq8nK
	ZwheyZAzee/2HK3IQySfdhnHFBRCHkV5GEZguD5F7QL8U+n/wx8KH5jQfZJnlxM0
	SifKlwvDxLdH8nUfjfFA2TSqrDa2O9OPZwQsbpk1rFB2mqVS1rniAqKE2KcqZVtV
	aeyU/meRhF1kXfOEfZrSTRMqsMSUYr6tzpCEHHV/qIpocsL1X9i075V2nOMTXWb3
	NbT+ORe0XjXkGRN81Eyymft87DSP2yFVoN33KV8rJZGqhrQL/yxHeH7bwsrMnz+u
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cn-wWDaQGJYm; Wed, 25 Mar 2026 21:45:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0p03D73zlgwN4;
	Wed, 25 Mar 2026 21:45:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 07/26] block/blk-iocost: Add lock context annotations
Date: Wed, 25 Mar 2026 14:44:48 -0700
Message-ID: <20260325214518.2854494-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
index 9f8bdae5a4b3..f161c78e0f21 100644
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
+	__no_context_analysis /* conditional locking */
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
+	__no_context_analysis /* conditional locking */
 {
 	if (unlock_ioc) {
 		spin_unlock(&iocg->waitq.lock);
