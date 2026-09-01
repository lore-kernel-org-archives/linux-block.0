Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D248AE0F;
	Tue,  1 Sep 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284415; cv=none; b=cvAG5mynCWQUz7c+GdvS/5jphdAwv2FkM5Wrvhu8DxxVOuYpFqKyblTT8qBRO8GA/ZrhW8fy4CfYTpcpYG2RFfGKoGhZO6iqffH/VpAPuMLdORjbQpI72GjOF4RfqDPL3ogexPebx7GIClJ+GWM2s5+DPYvWnKRWQ7v8jBsPK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284415; c=relaxed/simple;
	bh=DG9q4F+alPlzNXigWDKwk7TboW9yV8qpTW76RapNNzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4oqGqLkuOSEv3mJCSRjb96/LZFJ37SK5nIZwMFJJt2fKEvedBplK97tb2mv/UALb5b94XAMLos1OSfTuLmlrXAfLN7d9qawBl9sU0vcd7mCnKKlXxc+GyB+cSl6RI7ulFriNkPXmkxIaoUv0wmy7LTSEMYRWq5P7cuCw/9pPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=ez9SAQ19; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="ez9SAQ19"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788284411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdf7FbKMLz4DCYCIj+fYBqkvp0H27hy/tU2U3nq3tkk=;
	b=ez9SAQ19hechssclOLVEBbkWn0wQsNwBUAbJ+QoRp2Pn82/IuAQKyOsiJL72Iyhwd09YHn
	zLFyp9g8qivtqx7+QXp8GmdMQciDLVTyc4DKim5w1yVw+BKtfZecd8CqyS03BhRFJoavi/
	tgNCKxv4QTQBaBwHF8M4a3exJHK4WFo=
To: axboe@kernel.dk
Cc: Stian Halseth <stian@itx.no>,
	linux-block@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	davem@davemloft.net,
	glaubitz@physik.fu-berlin.de,
	regressions@lists.linux.dev
Subject: [PATCH 1/2] sunvdc: unmap LDC cookies when the descriptor send fails
Date: Tue,  1 Sep 2026 19:39:45 +0200
Message-ID: <20260901173947.3292110-2-stian@itx.no>
In-Reply-To: <20260901173947.3292110-1-stian@itx.no>
References: <24f8b266-f17c-4909-b43d-8ab05721c5d8@kernel.dk>
 <20260901173947.3292110-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__send_request() maps the request's pages into the LDC channel's map
table (ldc_map_sg()), fills in the descriptor and marks it
VIO_DESC_READY before ringing the doorbell via __vdc_tx_trigger().
When the trigger fails, the error path only prints a message: the
descriptor stays READY and the cookies are never unmapped. The
mapping is normally released in vdc_end_one() when the peer completes
the descriptor - but a descriptor whose doorbell was never sent will
never complete, and since dr->prod is not advanced on failure, the
reset path (vdc_requeue_inflight(), which walks [cons, prod)) never
visits it either. The map table entries are leaked permanently.

Since commit a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop
when vio_ldc_send() returns EAGAIN") trigger failures occur in
practice under load, so every resulting I/O error also leaks one
request's worth of entries from the fixed-size (8192 entries per
channel) map table. Because the allocator hands out contiguous
ranges, fragmentation makes large multi-segment requests fail first
as the table drains, until ldc_map_sg() fails permanently and the
disk is dead until reboot.

It also makes any retry-based recovery unusable: requeuing the
request on -EAGAIN remaps the pages on every attempt, overwriting
desc->cookies and orphaning the previous mapping, so the table
drains at the retry rate. This is the memory exhaustion observed
when the requeue approach was first tested in October 2025.

Roll back on failure: unmap the cookies, mark the descriptor FREE
again and clear the request entry. If the trigger failed with
-ENOTCONN, __vdc_tx_trigger() has already reset the port, which
tears down and reallocates both the dring and the LDC channel
including its map table - nothing to roll back, and the stale
descriptor must not be touched.

Fixes: a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://github.com/sparclinux/issues/issues/2
Signed-off-by: Stian Halseth <stian@itx.no>
---
 drivers/block/sunvdc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -525,6 +525,23 @@
 	err = __vdc_tx_trigger(port);
 	if (err < 0) {
 		printk(KERN_ERR PFX "vdc_tx_trigger() failure, err=%d\n", err);
+		/*
+		 * If the port was reset (-ENOTCONN), the dring and the
+		 * LDC channel including all of its mappings are already
+		 * torn down and reallocated - there is nothing to undo
+		 * and @desc must not be touched.
+		 *
+		 * For any other failure the descriptor was never handed
+		 * to the peer: unmap the cookies and free the descriptor
+		 * again, so that a later retry of the request does not
+		 * leak LDC map table entries.
+		 */
+		if (err != -ENOTCONN) {
+			ldc_unmap(port->vio.lp, desc->cookies,
+				  desc->ncookies);
+			desc->hdr.state = VIO_DESC_FREE;
+			rqe->req = NULL;
+		}
 	} else {
 		port->req_id++;
 		dr->prod = vio_dring_next(dr, dr->prod);
--
2.53.0
