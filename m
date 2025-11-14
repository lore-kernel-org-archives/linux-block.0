Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEE2F2616
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154285; cv=none; b=hR5J7N/fQ1jSEUswYkyY5KI0xO6p9aqITtCvbxK73tjs1BASf6DbnGTNOHZNxIS/A+/1I9HHtDmW2t3w1BD5R7c5x44uUt6HfJtSPBH2cQEa68g12w2OlKyP/tVoAB4tNz/Y/2EKbnf9ly5tUVC5NSkdRnru7SQq8kzpddk5Ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154285; c=relaxed/simple;
	bh=hGtiSjsqRzBLriuXCXDTwdaS1TCfWH5lyI/lOmL7vXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj07V4J2s/aPy1ISP/86qLuW9vOaKy18KXzM5yLnjCn6rzpIrOEcQuc2h4Pxd/DmmzeIWYdEHz+j7tyAhLm6bECqYyKeZCKRigcyL76JCHvhsCvZ9TbbOOcA58TAG6y5JP8fHpjenmLNC6WTkGt7jvENJKRdLNA/Evaby/vv/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JBhT9Q6T; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JBhT9Q6T"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d7V571V7Szm0fMT;
	Fri, 14 Nov 2025 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1763154281; x=1765746282; bh=u6roq
	oB+/IlLqI3bN1AKGLqItO8NwjkbnyhvZH3nRpc=; b=JBhT9Q6T5C5hUK+7LcKqQ
	7evJNmUJqh6p/ZxWGraonTW8N+f6lhOaoS680kJtvRVPmsppQOTmNGjWIsqsCAts
	mfzJN9qgL2nPhOapEXcgzghwT64O3JtRJ/CLChm6PFLkwNqIUUdYoow9VBdlf3aA
	mjrtkfkqhe08vOI6DH0BEuoalRrnA3xDtdiV/nUKnw1zwVQP37Ie3YUUwBHk3s6Z
	zbELSnzKs5zUb/Z9Jmq56S75roO6EeMPWzEwDzwoYNACKq1zFsPzd/jEwy+xtEy0
	UvUGsu20vtaFHsOp6M+zXuF2pwWkqF52mfM3acpR/RjuoAumK6P8v+ppP8pLOsHG
	g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Mo6kicZsWPxd; Fri, 14 Nov 2025 21:04:41 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d7V4x35GZzm2CT0;
	Fri, 14 Nov 2025 21:04:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v6 1/2] fs: Add the __data_racy annotation to backing_dev_info.ra_pages
Date: Fri, 14 Nov 2025 13:04:06 -0800
Message-ID: <20251114210409.3123309-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114210409.3123309-1-bvanassche@acm.org>
References: <20251114210409.3123309-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some but not all .ra_pages changes happen while block layer I/O is paused
with blk_mq_freeze_queue(). Filesystems may read .ra_pages even while
block layer I/O is paused, e.g. from inside their .fadvise callback.
Annotating all .ra_pages reads with READ_ONCE() would be cumbersome.
Hence, add the __data_racy annotatation to the .ra_pages member
variable.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/backing-dev-defs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev=
-defs.h
index c5c9d89c73ed..30f4bd9ff7c8 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -168,7 +168,9 @@ struct backing_dev_info {
 	u64 id;
 	struct rb_node rb_node; /* keyed by ->id */
 	struct list_head bdi_list;
-	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
+	/* max readahead in PAGE_SIZE units */
+	unsigned long __data_racy ra_pages;
+
 	unsigned long io_pages;	/* max allowed IO size */
=20
 	struct kref refcnt;	/* Reference counter for the structure */
