Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943F48BD2B;
	Tue,  1 Sep 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284417; cv=none; b=OJm2KsfBvhszdvWkiiTIDSX5TeAOffuwe3Dc0iGf2hmjxfRzvpzpqe99Vn9rKVIeDfyDr5XtdSzwTXz0DIhCy/NjbfEPaXrSeD2ENT81xNJ2Zp5ltRYfPchVWI56CMxXYnasz6mwQ0ASVdd2EtBmnmDhBrZShYDh1PV5P3rRGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284417; c=relaxed/simple;
	bh=o+BiYyHTA2eYb3SI7fyRtwAGevvrPg9Zjjod3z/vGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ5SpVB+CdBL37D/dVfS3u24AP7mEEmjosbNwCT5wfgvWqPFGkh0Qe//j21P3Zz+KzwwdCGfJ1KAdnh0tV9x8oVm6e1wikfxwyenZXBmWiP9vLmKUhS4HuHTMlZNttjFd3cfY9/3x89G0k6EOSutLCvXDVdjgTwu09hMs8YO7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=QrZY31hF; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="QrZY31hF"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788284413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71sn3dbaPtgCkZiSutjY0Za4tGeeJfsylcC5LIB7G/Y=;
	b=QrZY31hFUEYlKdMaV1iOJi8lVrG66kEXMUWbm12eed8mhGAq33epUeb/WXVQFHbFS95iU0
	AhkaCQhKtnguhEeul7rAG67tvIEbjRmL4CJPuz/LMqbnm6Jc4GCOgTOuXbbMH3P9gZPCn9
	oEVc3hks3TCbSWZDvfapOaGGXEl6NlI=
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	davem@davemloft.net,
	glaubitz@physik.fu-berlin.de,
	regressions@lists.linux.dev,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 2/2] sunvdc: fix -EIO issue due to lack of retries
Date: Tue,  1 Sep 2026 19:39:46 +0200
Message-ID: <20260901173947.3292110-3-stian@itx.no>
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

From: Jens Axboe <axboe@kernel.dk>

John reports that since commit:

a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN")

users of Linux inside Solaris ldom see occasional -EIO errors because
the request send loop now times out. The current loop does 10 retries,
and inside vio_ldc_send() a further 1000 1usec retries are done as well.
Even with 10.5 msec of busy loop retries that's apparently not enough to
always succeed.

Rather than introduce continued busy looping, requeue the request and
have the delayed queue kicking retry the request after another 10ms.
This obviously isn't ideal, but there's seemingly no way to wait for
this type of event. And if 10ms of busy looping was not enough to make
progress, then presumably this is an edge condition and we just need to
guarantee to make forward progress at some later point in time. That's
more suitably done through letting the CPU tend to other work, rather
than sitting in a tight loop retrying.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/all/20251006100226.4246-2-glaubitz@physik.fu-berlin.de/
Link: https://lore.kernel.org/all/418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[stian: rebased on top of the cookie-unmap fix, without which every
 requeued attempt leaks LDC map table entries; tested on an
 UltraSPARC T4 LDOM where the vdc_tx_trigger failure condition was
 reproduced and absorbed by the requeue with no I/O error]
Signed-off-by: Stian Halseth <stian@itx.no>
---
 drivers/block/sunvdc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -556,6 +556,7 @@
 	struct vdc_port *port = hctx->queue->queuedata;
 	struct vio_dring_state *dr;
 	unsigned long flags;
+	int ret;
 
 	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 
@@ -577,7 +578,13 @@
 		return BLK_STS_DEV_RESOURCE;
 	}
 
-	if (__send_request(bd->rq) < 0) {
+	ret = __send_request(bd->rq);
+	if (ret == -EAGAIN) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		/* already spun for 10msec, defer 10msec and retry */
+		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
+		return BLK_STS_DEV_RESOURCE;
+	} else if (ret < 0) {
 		spin_unlock_irqrestore(&port->vio.lock, flags);
 		return BLK_STS_IOERR;
 	}
--
2.53.0
