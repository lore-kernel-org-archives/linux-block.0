Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231375;
	b=5Sd/vhCXIySoXX/+dE9q+6GScy/XzWYDWGmSpjAZ3DZ2eEgTqRlAACFfQfWQl+VZLKYs
	 Sng9LP2ejZRSq9NSjbkR9tcoAjnXrkSwfbyhzRwG+09jMlMdEtgwILsrWL5JGIntI7kLT
	 78kX2jE8mejcDGTn+2C7tZcX1uE18Dkk3wZr6gz3urB0adk2nPelhb8/F7+l1Dzt3SgoO
	 Wrhchb7nYyQU80Am9Lezr2bQMcE6eQNHv9jubZxi5qHAN0lyBZ1d4K1+qkzk3pu9sqrLp
	 0aU+2F4z1GBG7Fj15ZLBdA9v8kpMn6ojIUSHEXLuR6RANgtjR6zfZNs3gMVCQy9Pk4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rHNteLc+yyndyxB6qFu1j3mF5UMqHzN/7ve5fmhNnLs=;
	b=5KkrWyPGjhGHIK/oAedDSTg7PI1kVvUhKecTEvSA8DdLXSbWQmC4KBcDFOt2n6iz5byo
	 DYdKLTZ7v7HZMR+atwO2R24U9WcIXbC8QUf8/qqACn3zMZaILFghl4FdzORRKeyk7hfPj
	 xI85d5GfiXEfknHXbNmd+SgFjfFAFyxPgb7mzZB547Llqf3z2IfHxBf/TvclQ1oNaTNlD
	 1Hy9tjRitS99VXCKklIA5TKvJthYLfKgJlh3TsaSs32ZZ5oLA/AULhs2J83z98SgVHJd5
	 ZyhjwYJAWUyRpg7AqbPP8M2IMWmCZU1hZexFEb+IhNtZQ6RTr8eDb4UOn9loAj6bKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=TljxFTEf;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7101606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7101606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=TljxFTEf
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGk3npjzlfvq6;
	Wed, 28 Oct 2026 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231370; x=1795823371; bh=rHNte
	Lc+yyndyxB6qFu1j3mF5UMqHzN/7ve5fmhNnLs=; b=TljxFTEfxhJ87hmwY1CeS
	bxtsMUh6wMEvZE2hRLMHsJt4ZGWlhOnOeDUW5TC+/mryTlf0zd0IeT4m7p4ZnAWu
	RF/yRV4PnWdobHIm+A44+I1K+vrQ+aQMfphVH96fN95AF4a29KbvnG9X90wowTAH
	tgYbbBKFZ+WDPt5C6g8S2+tHrUCC4rBLaXT8AlbVIGmfnEw6BTgnRbuKAA1sO5NE
	+prwYKUfQ3wBcjriKbmBtiduhSLDawTXRebFzKin/WG+oLDEqK+GuwITIgZVfhE4
	YqecA2FNbjoq2cuVoHk3kVLDGjwLpInV0hzEYt/NhuQVThqzx16erQaoNcMr2euP
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Yr65UADLwNiX; Wed, 28 Oct 2026 23:49:30 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGd2MDZzlfvpc;
	Wed, 28 Oct 2026 23:49:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 20/98] mtip32xx: don't mark the disk dead in the irq handler
Date: Wed, 28 Oct 2026 16:49:07 -0700
Message-ID: <20261028234917.3067347-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-21-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-21-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/26 09:41, Jens Axboe wrote:
> @@ -2492,6 +2512,9 @@ static int mtip_service_thread(void *data)
> =20
>  		set_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags);
> =20
> +		if (test_and_clear_bit(MTIP_PF_SR_BIT, &port->flags))
> +			mtip_check_surprise_removal(dd);
> +
>  restart_eh:

Deferring blk_mark_disk_dead() out of the hardirq handler is needed, but
calling blk_mark_disk_dead(dd->disk) in mtip_service_thread() before
aborting in-flight NCQ commands can deadlock when a filesystem is
mounted on the device:

1. blk_mark_disk_dead() invokes fs_bdev_mark_dead(), which takes
   sb->s_umount via bdev_super_lock() and calls sync_filesystem(). If
   another task already holds s_umount while waiting for in-flight I/O
   on the dead PCIe device, mtip_service_thread() blocks on s_umount.
2. In patch 22/98, mtip_pci_remove() calls mtip_stop_service_thread(dd)
   (kthread_stop()) before aborting in-flight commands, so
   mtip_pci_remove() blocks waiting for mtip_service_thread() before it
   can abort the commands holding up s_umount.

Also, mtip_abort_cmd() currently calls mtip_softirq_done_fn(req)
directly without transitioning the request through
blk_mq_complete_request().

How about keeping mtip_check_surprise_removal() non-sleeping everywhere
(setting dd->sr, a new MTIP_DDF_DEAD_BIT to fail new normal and reserved
requests immediately with BLK_STS_IOERR, and waking the service thread
with MTIP_PF_SR_BIT), and having a helper mtip_handle_surprise_removal()
quiesce dd->queue and abort in-flight requests via
blk_mq_tagset_busy_iter() + blk_mq_complete_request() before calling
blk_mark_disk_dead(dd->disk)?

Patch 21/98 still applies cleanly on top of this replacement, and my
reply to patch 22/98 has the matching follow-up change. Checked with
checkpatch.pl and syntax-checked with Clang; not runtime-tested on
mtip32xx hardware:

---
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
index 113bdb868c46..35568d0e74cf 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -141,8 +141,11 @@ static bool mtip_check_surprise_removal(struct drive=
r_data *dd)
 	pci_read_config_word(dd->pdev, 0x00, &vendor_id);
 	if (vendor_id =3D=3D 0xFFFF) {
 		dd->sr =3D true;
-		if (dd->disk)
-			blk_mark_disk_dead(dd->disk);
+		set_bit(MTIP_DDF_DEAD_BIT, &dd->dd_flag);
+		if (dd->port) {
+			set_bit(MTIP_PF_SR_BIT, &dd->port->flags);
+			wake_up_interruptible(&dd->port->svc_wait);
+		}
 		return true; /* device removed */
 	}
=20
@@ -2438,9 +2441,12 @@ static bool mtip_abort_cmd(struct request *req, vo=
id *data)
=20
 	dbg_printk(MTIP_DRV_NAME " Aborting request, tag =3D %d\n", req->tag);
=20
+	if (blk_mq_request_completed(req))
+		return true;
+
 	clear_bit(req->tag, dd->port->cmds_to_issue);
 	cmd->status =3D BLK_STS_IOERR;
-	mtip_softirq_done_fn(req);
+	blk_mq_complete_request(req);
 	return true;
 }
=20
@@ -2462,6 +2468,18 @@ static bool mtip_queue_cmd(struct request *req, vo=
id *data)
  *	0
  */
=20
+static void mtip_handle_surprise_removal(struct driver_data *dd)
+{
+	if (dd->queue) {
+		blk_mq_quiesce_queue(dd->queue);
+		blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd);
+		blk_mq_unquiesce_queue(dd->queue);
+	}
+	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag) &&
+	    !test_and_set_bit(MTIP_DDF_DISK_DEAD_BIT, &dd->dd_flag))
+		blk_mark_disk_dead(dd->disk);
+}
+
 static int mtip_service_thread(void *data)
 {
 	struct driver_data *dd =3D (struct driver_data *)data;
@@ -2492,6 +2510,15 @@ static int mtip_service_thread(void *data)
=20
 		set_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags);
=20
+		if (test_and_clear_bit(MTIP_PF_SR_BIT, &port->flags)) {
+			mtip_handle_surprise_removal(dd);
+			clear_bit(MTIP_PF_EH_ACTIVE_BIT, &port->flags);
+			clear_bit(MTIP_PF_TO_ACTIVE_BIT, &port->flags);
+			clear_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags);
+			clear_bit(MTIP_PF_REBUILD_BIT, &port->flags);
+			continue;
+		}
+
 restart_eh:
 		/* Demux bits: start with error handling */
 		if (test_bit(MTIP_PF_EH_ACTIVE_BIT, &port->flags)) {
@@ -3241,6 +3268,8 @@ static inline bool is_stopped(struct driver_data *d=
d, struct request *rq)
 		return true;
 	if (test_bit(MTIP_DDF_REBUILD_FAILED_BIT, &dd->dd_flag))
 		return true;
+	if (test_bit(MTIP_DDF_DEAD_BIT, &dd->dd_flag))
+		return true;
=20
 	return false;
 }
@@ -3279,6 +3308,9 @@ static blk_status_t mtip_issue_reserved_cmd(struct =
blk_mq_hw_ctx *hctx,
 		dd->port->command_list + sizeof(struct mtip_cmd_hdr) * rq->tag;
 	struct mtip_cmd_sg *command_sg;
=20
+	if (test_bit(MTIP_DDF_DEAD_BIT, &dd->dd_flag))
+		return BLK_STS_IOERR;
+
 	if (mtip_commands_active(dd->port))
 		return BLK_STS_DEV_RESOURCE;
=20
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/m=
tip32xx.h
index 0963c07b5845..af0249e3c550 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -134,11 +134,13 @@ enum {
 	MTIP_PF_ISSUE_CMDS_BIT      =3D 5,
 	MTIP_PF_REBUILD_BIT         =3D 6,
 	MTIP_PF_SVC_THD_STOP_BIT    =3D 8,
+	MTIP_PF_SR_BIT              =3D 11, /* surprise removal seen */
=20
 	MTIP_PF_SVC_THD_WORK	=3D ((1 << MTIP_PF_EH_ACTIVE_BIT) |
 				  (1 << MTIP_PF_ISSUE_CMDS_BIT) |
 				  (1 << MTIP_PF_REBUILD_BIT) |
 				  (1 << MTIP_PF_SVC_THD_STOP_BIT) |
+				  (1 << MTIP_PF_SR_BIT) |
 				  (1 << MTIP_PF_TO_ACTIVE_BIT)),
=20
 	/* below are bit numbers in 'dd_flag' defined in driver_data */
@@ -150,12 +152,15 @@ enum {
 	MTIP_DDF_RESUME_BIT         =3D 6,
 	MTIP_DDF_INIT_DONE_BIT      =3D 7,
 	MTIP_DDF_REBUILD_FAILED_BIT =3D 8,
+	MTIP_DDF_DEAD_BIT           =3D 9,
+	MTIP_DDF_DISK_DEAD_BIT      =3D 10,
=20
 	MTIP_DDF_STOP_IO      =3D ((1 << MTIP_DDF_REMOVE_PENDING_BIT) |
 				(1 << MTIP_DDF_SEC_LOCK_BIT) |
 				(1 << MTIP_DDF_OVER_TEMP_BIT) |
 				(1 << MTIP_DDF_WRITE_PROTECT_BIT) |
-				(1 << MTIP_DDF_REBUILD_FAILED_BIT)),
+				(1 << MTIP_DDF_REBUILD_FAILED_BIT) |
+				(1 << MTIP_DDF_DEAD_BIT)),
=20
 };
=20
