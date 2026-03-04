Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C23A4503
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653781; cv=none; b=FeaH6ga0wkjUI8Q5YDm8lbZX28fnWxriZ23PZRRw7LmECLJmzT03AvKDQ6zDWue4JXuAT6TON4n0Q0sbq3UM5jjocjrWoGeBMED/Ll5SGb8l/beijSi9kyw0VP4/yVGmO9JSMS6Z7BO8n7H6Hphz7JbrRxrBdLqGZDDPTJzaxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653781; c=relaxed/simple;
	bh=9hg1pS7J/xb6xuMbC7sA3DcPxwOmW+8AVjK3lu+triA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUO5MT0vjbBWLqhna2MhvhL0b+ozuVqZRTQ5aT5ehqxfVKX1fVbJ/7Bn4s33BkzXHxRUIcOY/B2yzONnjXgB1HSJ4yYUCgDRiORClHIEbrh7Ztu+sJMRXZTYjbxngyv3MZWZMzZxUkPe3CPpS82uXjqyE/+Pk6IS/yS0llFCJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zNSpEKcn; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zNSpEKcn"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cl56YDz1XM6JV;
	Wed,  4 Mar 2026 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653774; x=1775245775; bh=V6hyG
	sWpW0SzvYUESJNz3pGgzGtFAhgHeWjZkos+WGk=; b=zNSpEKcn2Nu1XzwVi711l
	UeKMdI9dZSG+Tg/EuKRvQfh+LtOGF5QSbKZdcfsJNy9fcCVzRVGPaJuL73qa9O0B
	htVNv3Lx8I87e6GSLIPqAQMZu0krpHexs+mtjvmZFmd+wMriZEWDK1M14ICHdk7r
	SL2/Awy/FeHAslWtFP7WF9UctwaTdIfIEP04hM2hAw1isB6e7Coxj1nUQjQnxUxT
	6/7z+RZp2KMVyfJFE3oLOAVyE9N6fKGxMNKpoztY0mI3ISpdiNv9uBnXFm+G6eyc
	bJulfaoj8/ikspuYnOomdEMntlyd6wHne4LxzFaE4BWXWMjrvZ3VKM+rUNRsmXZD
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5jq35YIzniuO; Wed,  4 Mar 2026 19:49:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3Cc4x03z1XLyhT;
	Wed,  4 Mar 2026 19:49:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 11/14] ublk: Fix the lock context annotations
Date: Wed,  4 Mar 2026 11:48:30 -0800
Message-ID: <20260304194843.760669-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations that are required by Clang. Remove the
__must_hold(&ub->mutex) annotation from ublk_mark_io_ready() because not
all callers hold ub->mutex.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/ublk_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 34ed4f6a02ef..70f2ebde3be9 100644
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
@@ -2926,7 +2928,6 @@ static void ublk_queue_reset_io_flags(struct ublk_q=
ueue *ubq)
=20
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
-	__must_hold(&ub->mutex)
 {
 	struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
=20
@@ -3160,6 +3161,7 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
=20
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
 			struct ublk_io *io, u16 q_id)
+	__must_hold(&ub->mutex)
 {
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
@@ -3598,9 +3600,11 @@ static int ublk_batch_prep_io(struct ublk_queue *u=
bq,
 	}
=20
 	ublk_io_lock(io);
+	__acquire(&data->ub->mutex);
 	ret =3D __ublk_fetch(data->cmd, data->ub, io, ubq->q_id);
 	if (!ret)
 		io->buf =3D buf;
+	__release(&data->ub->mutex);
 	ublk_io_unlock(io);
=20
 	if (!ret)
