Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231377;
	b=asRiI3MzpgaBpkKaIZIamuKUovOH7x335AwVkdVrBRHe5c58lyfmj6VvpvUEzhxJ2PrS
	 g/F0Ma/jQLQ4uGu299WWclw0XdIi2S+d3dIxUge31T7PB9EzgxrBsiTIfXwop1BbLUG5T
	 pUgUD+UMKNC3Ng/VS3fVo3sqd88KAIsIUN8bjzKYYZ4HQ4x3wAZ1lh59AeAc3IaIAihXz
	 4EkRpwfhibFpcCbbaQIFvI3/PxxFZK1TK8tfPS+oHuERomalaeGwlzVTjiwLbCOt5gbU4
	 TGZwrugHs2JLJhZtsbSeAzye/rQbcs3VPsyZDBGUENvCCSzmx7C2gx3OkRVSSTdbe/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=eANwS/bHgf1rJidDNLfDEW7aKgA9KLJZB7Tph30sLj4=;
	b=zeMYDCrx9vqKCvQpHfR7s4L+wWT2R8T5rAr4Y6GGfLokObcZEusQombAYLRVkPQKNRRK
	 QqUHaO+YTDae0xUb3xFmPu2sxJcDk+63OfmDLjmrqhYxxAG16syg0nA+7/mx0Rlf7Uvik
	 7tL4/yzlXt9vSWUOVchdpG3+c9Y6v5+iMinuS2Odc5nGPp/wcAGkwSDy5iqZ3Sr6MEYCp
	 hiPHRPqTLgvrp3N/tM1xC0LsEHjkXezbSEbSy5yNjayioOaNOc/gMLyCGvaZlnomg1I/k
	 FKHr4vjc4aAt2d6scmiV2BanE6IwlkGTZYOzj72EIS6cIjlSP/13UP6cHyHpeNDQKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=GWhDcy7p;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B6606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=GWhDcy7p
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGm31KWzlfvq2;
	Wed, 28 Oct 2026 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231373; x=1795823374; bh=eANwS
	/bHgf1rJidDNLfDEW7aKgA9KLJZB7Tph30sLj4=; b=GWhDcy7pk/HrZlXBmBmC+
	EDYS4/u0Vy9cFJs7LEbJs+ZnEyF6LWFZddBmo7ToiOtijFH79Ow4HD8kFdtVt2/Y
	bNP7mnDbk9+cEkRGvTm8IjySGOioYqevtqWqvyH4RmymLzJWGUi0q6HegDDMud+P
	RsjJLG8t36u0Lml66vi/s3BRsnYHlgciQqeKHbi0sgO2UIhEctzukf9S32StxqjT
	u4KV03XKQd3P7QiZnb1aYOoQyci0Smpm+zzo/VqSkWqwTXNEo+oRjEm1uLJWjf9I
	eW5iyBbAtQdC9DvfKTGF4veSHYJBdxPXQbMgVBzcI9LiBJwiTy5lOa7v6KnzOkqs
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TSNuUElQxcRj; Wed, 28 Oct 2026 23:49:33 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGf4THkzlfvpd;
	Wed, 28 Oct 2026 23:49:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 22/98] mtip32xx: abort commands in flight on surprise removal
Date: Wed, 28 Oct 2026 16:49:08 -0700
Message-ID: <20261028234917.3067347-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-23-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-23-axboe@kernel.dk>
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
> +	/*
> +	 * Nobody will complete the commands a removed device has been given,
> +	 * and del_gendisk() waits for them.
> +	 */
> +	if (dd->sr) {
> +		mtip_stop_service_thread(dd);
> +		blk_mq_quiesce_queue(dd->queue);
> +		blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd);
> +		blk_mq_unquiesce_queue(dd->queue);
> +	}
> +
>  	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
>  		del_gendisk(dd->disk);

Two issues with this ordering:

1. Calling mtip_stop_service_thread(dd) (kthread_stop()) before aborting
   in-flight commands deadlocks with patch 20/98 if
   mtip_service_thread() is blocked inside blk_mark_disk_dead() ->
   fs_bdev_mark_dead() waiting for sb->s_umount while the s_umount
   holder is waiting on those uncompleted NCQ commands.
2. If PCIe link loss happens after mtip_pci_remove() has already checked
   dd->sr (false) and entered del_gendisk(dd->disk),
   MTIP_DDF_REMOVE_PENDING_BIT is already set. mtip_service_thread()
   exits immediately upon seeing MTIP_DDF_REMOVE_PENDING_BIT without
   handling MTIP_PF_SR_BIT or MTIP_PF_TO_ACTIVE_BIT, leaving in-flight
   commands uncompleted forever in del_gendisk().

With the replacement proposed for patch 20/98 (where
mtip_handle_surprise_removal() aborts in-flight commands before calling
blk_mark_disk_dead()), we can instead keep mtip_service_thread() running
until kthread_stop() after del_gendisk(dd->disk) by removing its early
exit on MTIP_DDF_REMOVE_PENDING_BIT (and clearing MTIP_PF_REBUILD_BIT if
remove is pending or mtip_ftl_rebuild_poll(dd) <=3D 0, since rebuild poll
returns -EFAULT once MTIP_DDF_REMOVE_PENDING_BIT is set). That handles
surprise removal both before and during del_gendisk() from the service
thread without racing two tagset iterations.

Below is the replacement for 22/98 on top of the 20/98 replacement +
unmodified 21/98 (checked with checkpatch.pl and syntax-checked with
Clang; not runtime-tested on mtip32xx hardware):

---
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
index 757f9b74871e..b9dfa7112c95 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2504,10 +2504,6 @@ static int mtip_service_thread(void *data)
 			test_bit(MTIP_PF_SVC_THD_STOP_BIT, &port->flags))
 			goto st_out;
=20
-		if (unlikely(test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
-				&dd->dd_flag)))
-			goto st_out;
-
 		set_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags);
=20
 		if (test_and_clear_bit(MTIP_PF_SR_BIT, &port->flags)) {
@@ -2588,7 +2584,9 @@ restart_eh:
 		}
=20
 		if (test_bit(MTIP_PF_REBUILD_BIT, &port->flags)) {
-			if (mtip_ftl_rebuild_poll(dd) =3D=3D 0)
+			if (test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
+				     &dd->dd_flag) ||
+			    mtip_ftl_rebuild_poll(dd) <=3D 0)
 				clear_bit(MTIP_PF_REBUILD_BIT, &port->flags);
 		}
 	}
@@ -3926,6 +3924,9 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
 	mutex_lock(&dd->ioctl_mutex);
=20
+	if (dd->sr && !dd->mtip_svc_handler)
+		mtip_handle_surprise_removal(dd);
+
 	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
 		del_gendisk(dd->disk);
=20
