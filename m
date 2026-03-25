Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2639891E
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475200; cv=none; b=WFGCYo3eLY8afGhwMNkY7tEtEpHVhHil8PDYD4PjOqAWaXZXxbE8n+9OhqjWWbnrVZSq2BMIyRhMVXbNIQSulHX+S3nE94Yn+WqQhR0a7pA0qNAIjbWyx0/c9tVlfCF4d9vKH+EKdXLAB6swhpQ0zdk2SXDFcxJ96U2RoNo/qwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475200; c=relaxed/simple;
	bh=liXCcqNOPpWB2XXxZb0MvbGTgRDanteEdvjxP4eIcmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJDwSPilfcRRkbjKIenTVXdewAMEENtCqZoBdd1rMfW+Tul7yFGqaJk+MB8nBUUIjRFr5N+JXjL6wPn8Uopd9WXKWfyaDsgVkZYwz9z+KNAHXbCt04qPz7JP9HINPYMym9LXYmSHGGzzgJWN91KSYrreSkIUl+l9Kah7ZKRI7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yJHA6yR7; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yJHA6yR7"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pz4XGmzlgyGn;
	Wed, 25 Mar 2026 21:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475188; x=1777067189; bh=7tXe6
	x9tgQec9STu9zZuxHqvqDsgEQ8Jo7EFEWGKhUA=; b=yJHA6yR7ZOHN3gozaAC/O
	L/3j3xzVUyPR3vCQt5KTf5N2SnXD+qSdt0LjyMgXu5BrstvpkRpZdQPT3B9Yl0a7
	Oi3yG1m9/uSQIof3tNxYZaHZ6C5wqfFhfc2tt6bVjOAMoDjkEHVdxM3KrughbjoC
	7wj0WP5aQh7Jh5NEEdSqR3GD98cBAm4cR40lC5ZuZCXskawLVEZhuslXbKZTzRt7
	yBHrSW9QLxF2eZVBCzvLuKmUYfm7U6b/9uqxFc/ECBcGdXGvR4X4Q7Tr9RY4M4Iv
	IU4aVhG/AmzWnTGPbyr8G6K2a9Ee68ObBuA5BmCHrcidnDxb8Gx0X3TMetMHJaCJ
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XjIETycHAGeg; Wed, 25 Mar 2026 21:46:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pp2qS0zlgyGr;
	Wed, 25 Mar 2026 21:46:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 22/26] ublk: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:03 -0700
Message-ID: <20260325214518.2854494-23-bvanassche@acm.org>
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

Add the lock context annotations that are required by Clang and enable
lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/ublk_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3ba7da94d314..14b59e13b16f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -353,11 +353,13 @@ static inline bool ublk_support_batch_io(const stru=
ct ublk_queue *ubq)
 }
=20
 static inline void ublk_io_lock(struct ublk_io *io)
+	__acquires(&io->lock)
 {
 	spin_lock(&io->lock);
 }
=20
 static inline void ublk_io_unlock(struct ublk_io *io)
+	__releases(&io->lock)
 {
 	spin_unlock(&io->lock);
 }
@@ -3166,6 +3168,7 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
=20
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
 			struct ublk_io *io, u16 q_id)
+	__must_hold(&ub->mutex)
 {
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
@@ -3587,6 +3590,7 @@ static void ublk_batch_revert_prep_cmd(struct ublk_=
batch_io_iter *iter,
 static int ublk_batch_prep_io(struct ublk_queue *ubq,
 			      const struct ublk_batch_io_data *data,
 			      const struct ublk_elem_header *elem)
+	__must_hold(&data->ub->mutex)
 {
 	struct ublk_io *io =3D &ubq->ios[elem->tag];
 	const struct ublk_batch_io *uc =3D &data->header;
