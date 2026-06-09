Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76842421A00
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042816; cv=none; b=RjvWpZ0MTxsfPyv48CeQg6+6DSOkmdP5kt4Js4vgJBbOwYLFvnW/sOfcmzc4uTj8xaLXYfQegjVoPyBBu/0OQBlmk6LhMKWvR+24zLskiKpR5y/Ah//K/GLomOvJLAGuf+70vTmd0f1xm3crucUaeIJLF4/JJ84w5NdNh2jyf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042816; c=relaxed/simple;
	bh=+qNTcdWZ1IsEGJSPGZWNpeC+/zEbJFG5us9dMa70jZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seIPzrGy5aBPxANdLznvja6qsR04sASC8hUhZG+z/OjvpyjwwzPQNXr0xnPVp9sKInJvjaWttmLNH2+goRrtRnAfGaflMDsWBACPmgJio6CIfnYz2VqRyolM0A/Wni41Pqn6CSJ77P7Bx8fKlI4SpoTlF6pFPNTenCd8emxbkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NAeK9vqj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NAeK9vqj"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgM0qn0zlfddT;
	Tue,  9 Jun 2026 22:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042810; x=1783634811; bh=2Ufig
	BaokFgflocWqQ3ViN7dsku1BXVOtVJatlaxNq8=; b=NAeK9vqjj7+8t674pAV4z
	B55DkjZdaMNlSsTxFBQDDnWjM8DrM+SUuiUETWRE/P2vkE9YjyydzTAcrN7QOUN0
	nUMiarKo3K7NjSHH+MvV5W646d7UUnobokRLvd9Xq7KCWkeKU1huPJ5z8kLJNCZi
	E2DbO3+hHVeFBdrxBZHZ3Lwknqla3KgJIvtrVfQVBTNsNO1chDQ8wmswPhCAvmse
	ovfO+xzycYefFR/5DxIf/4YulKPDQoAzH7yFznsBB8V5RVh4AH0h0LDP4cPnzA75
	10VldGwHB4yDiyQkhUSmzxwNH9Q7RzW4bAuStCx3OsR6NtdtLEBnaIx/gqQFm4MO
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id awmnbcFbSiRG; Tue,  9 Jun 2026 22:06:50 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjgC0FvmzlffvQ;
	Tue,  9 Jun 2026 22:06:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 23/27] ublk: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:10 -0700
Message-ID: <0a98c4c6a776f88e8e300ef9b205c190a3857609.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations that are required by Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/ublk_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4f6d9e652187..1e18bc926dff 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -374,11 +374,13 @@ static inline bool ublk_support_batch_io(const stru=
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
@@ -3263,6 +3265,7 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
=20
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
 			struct ublk_io *io, u16 q_id)
+	__must_hold(&ub->mutex)
 {
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
@@ -3686,6 +3689,7 @@ static void ublk_batch_revert_prep_cmd(struct ublk_=
batch_io_iter *iter,
 static int ublk_batch_prep_io(struct ublk_queue *ubq,
 			      const struct ublk_batch_io_data *data,
 			      const struct ublk_elem_header *elem)
+	__must_hold(&data->ub->mutex)
 {
 	struct ublk_io *io =3D &ubq->ios[elem->tag];
 	const struct ublk_batch_io *uc =3D &data->header;
@@ -5290,6 +5294,7 @@ static int ublk_char_dev_permission(struct ublk_dev=
ice *ub,
  * already holds ub->mutex when calling del_gendisk() which freezes the =
queue.
 */
 static unsigned int ublk_lock_buf_tree(struct ublk_device *ub)
+	__acquires(&ub->mutex)
 {
 	unsigned int memflags =3D 0;
=20
@@ -5301,6 +5306,7 @@ static unsigned int ublk_lock_buf_tree(struct ublk_=
device *ub)
 }
=20
 static void ublk_unlock_buf_tree(struct ublk_device *ub, unsigned int me=
mflags)
+	__releases(&ub->mutex)
 {
 	if (ub->ub_disk)
 		blk_mq_unfreeze_queue(ub->ub_disk->queue, memflags);
