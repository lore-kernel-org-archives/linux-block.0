Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1933ED5C7
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691820; cv=none; b=PwQ55P68jBB0gulOKwim07E25qLu7yyRkb/wJ6XkPcNpJKyhsUThc+dkjFUVjlOsUBGu7uFko5u22ne+z1oRhSgO1E4rcvJFRVligaFCu+iXqL8pJS7D3nYD65Ee5mwR4QCENNMtOUEUXtdAnvdzWzSatnjn4c7Wcw3CI8Z+5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691820; c=relaxed/simple;
	bh=M767rRZDFfjQCT1/4DOE/Y/6n3nlsFpPq9yHTLVaAfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIsjLTGeYTdloUVhT0qM59b9x9f5wRVNf2LSk3tPx2jdzK5Zjh+6BqgxO8QR01paBEZIX2NmmL7SlF7UjdojWqgifwv8KPJePys53z+07iYV1O5GSnoLLK2tTBqEsFn0BFsb8lVy9dnrPvbgptMCXb8xmiwHc1W1k7FAxBRuvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ucwE7oi3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ucwE7oi3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR631BhczlffvG;
	Mon, 16 Mar 2026 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691815; x=1776283816; bh=T8s3h
	9ybdUQejracHxs/Wiimkq1bDWcGi30DLaDR8d8=; b=ucwE7oi3ABgd2vFi88+2p
	MGbeIJG6Bw4+PmA2S2oAj4h0/Zzn2BGdwaDUminsI0h3M61MdPDYVR/LVmEWDaYy
	njIwHYRKHRtRcVj5zygYnGV7p0/RcRsv0pwti9PLJOnWwyiiRT8a5pPaG/f2f0gP
	ABaQfDluPE/+rQCF7XQ+xeXbNDw6G3X+O152b0Ktr69SaqXP9epGkTxtc+mbqx8/
	dI9Fwy6U7nlovIhXoVN8gcNGae8dKigeNP+g+rH+YmDBairu90iEaTnV6kM2bFxH
	YBwoePAhBOE+CbVGy6G4Xl4iOVf4HUlxQP1f+lIxjkvulPOnnh4/ejnpzeBtKFCH
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nCqqlNA-hNs0; Mon, 16 Mar 2026 20:10:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR5w5lxszlgyGM;
	Mon, 16 Mar 2026 20:10:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 09/12] ublk: Fix the lock context annotations
Date: Mon, 16 Mar 2026 13:08:46 -0700
Message-ID: <20260316200901.4111651-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations that are required by Clang. This patch
prepares for enabling lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/ublk_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9e1ebb8e80da..626269636ebb 100644
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
@@ -3160,6 +3162,7 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
=20
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
 			struct ublk_io *io, u16 q_id)
+	__must_hold(&ub->mutex)
 {
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
@@ -3581,6 +3584,7 @@ static void ublk_batch_revert_prep_cmd(struct ublk_=
batch_io_iter *iter,
 static int ublk_batch_prep_io(struct ublk_queue *ubq,
 			      const struct ublk_batch_io_data *data,
 			      const struct ublk_elem_header *elem)
+	__must_hold(&data->ub->mutex)
 {
 	struct ublk_io *io =3D &ubq->ios[elem->tag];
 	const struct ublk_batch_io *uc =3D &data->header;
