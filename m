Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FD3CCFC2
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441582; cv=none; b=LjnaDt0vnsRae8K9h5iyihuoTZF9xvonxUotU+u5s0xVp83n1lMggNNnVrWmN3UZONhG9NWN+N4uLEqKbeA7FY91orVWOawB8kFhhImR9Fyb82VCdU53GyyYg1JPaeNGOAYG0/Is74UV1CEybT0b5+RJyOQYek6leD5/HYafg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441582; c=relaxed/simple;
	bh=GnjErVpGiiCyZByUuTxW31LY4nuy69WK30bckxE4YTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNN7gDVcZYEI24opiyfFzsxd0NeQfTGNZzjacmfXtkpusAdKGVzTBGg4Wuwfv1cnos5edL/X9DSOd01XhYReKcgDA6YGHtTrruZK4s3PkOqg0jz0efMQU4+P1rCLJa27K3tzQx2f6fIw5Uwzclu9gG0qe2sReSdR5xUunYpOUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SXk8+tzq; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SXk8+tzq"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0Qt0WzHzlfpLr;
	Thu, 30 Jul 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441568; x=1788033569; bh=c43tt
	KfEN6SzfLHEPj4DfUbYjtQ83H9X/sr2qUPw2Xw=; b=SXk8+tzqXmo3nVosleVg3
	jxDVWoxL7Q5cULheqylmA2tM3Zym2IlGmUh6om34PdV6YfGdVpxNDKGIM8LJFMkK
	FTQ7ILHsKF7i8HeqKI4SHGlG8K4Qw84vs8s7cGK2tITm8DkZLjI08ZLg0Nklm9Xd
	c22ICBVxhAzBg+9IxIRRECCTTncLXAD+rtkjn7IUYsgEVy6HP/bL6xQHlg+jxmFT
	fKOd1q1X4tsP3nmSsEaxBHD8FBmNgtfUkmbq7hDj+xQfS41cNVpeZK5LSYeeGxuu
	u7PyUk/Zj8d6FfvSwHx8ef0uepoZrUSfnPeV8w3YesYZGt9Ar17HIhmkFoLqk5/b
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id envt1FdaBlcP; Thu, 30 Jul 2026 19:59:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Qh6QJszlfpLt;
	Thu, 30 Jul 2026 19:59:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 08/12] ublk: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:31 -0700
Message-ID: <e69e4314501a81e81e4ac60e53ccbe3ebb40f9f7.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations that are required by Clang.

Cc: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/ublk_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2a22f9dc1f2f..b18b50efd094 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -373,11 +373,13 @@ static inline bool ublk_support_batch_io(const stru=
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
@@ -3262,6 +3264,7 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
=20
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
 			struct ublk_io *io, u16 q_id)
+	__must_hold(&ub->mutex)
 {
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
@@ -3689,6 +3692,7 @@ static void ublk_batch_revert_prep_cmd(struct ublk_=
batch_io_iter *iter,
 static int ublk_batch_prep_io(struct ublk_queue *ubq,
 			      const struct ublk_batch_io_data *data,
 			      const struct ublk_elem_header *elem)
+	__must_hold(&data->ub->mutex)
 {
 	struct ublk_io *io =3D &ubq->ios[elem->tag];
 	const struct ublk_batch_io *uc =3D &data->header;
@@ -4422,6 +4426,7 @@ static bool ublk_validate_user_pid(struct ublk_devi=
ce *ub, pid_t ublksrv_pid)
  * UNPREP, daemon death), so re-check it under the mutex and wait again.
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
+	__cond_acquires(0, &ub->mutex)
 {
 	while (true) {
 		if (wait_var_event_interruptible(&ub->nr_queue_ready,
@@ -5323,6 +5328,7 @@ static int ublk_char_dev_permission(struct ublk_dev=
ice *ub,
  * already holds ub->mutex when calling del_gendisk() which freezes the =
queue.
 */
 static unsigned int ublk_lock_buf_tree(struct ublk_device *ub)
+	__acquires(&ub->mutex)
 {
 	unsigned int memflags =3D 0;
=20
@@ -5334,6 +5340,7 @@ static unsigned int ublk_lock_buf_tree(struct ublk_=
device *ub)
 }
=20
 static void ublk_unlock_buf_tree(struct ublk_device *ub, unsigned int me=
mflags)
+	__releases(&ub->mutex)
 {
 	if (ub->ub_disk)
 		blk_mq_unfreeze_queue(ub->ub_disk->queue, memflags);
