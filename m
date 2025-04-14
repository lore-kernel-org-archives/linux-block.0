Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3F17A2FC
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630054; cv=none; b=upefmkcNMVtTITXCGhAL428dkOBPrSS3FeyMKkLahId3R5uVIR2IiHSG49asZEKHqyTzAR7RLjsCQwl6aLkdGC8cdQN9ncBUsYuadezQ+1R/xqfdA3GmH4URpiI348sGEsTueEjUy98dyOqxn2savkcP2xmwZ45umdRxL+Zs624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630054; c=relaxed/simple;
	bh=6NjzVSEjN4LMrKPKzIMvzI79mHHxujuaVfKQp+anoRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyKgKaVDbgOe6lItkQFw6ZTqrWDJu5BXFyinCuih15Ty1zd2DBBnCxW8cEVTBR57y9im2Pq+phNfYYoCNBtMiKmeO3cZLXl1VOZDiDS93OwYhHVRB+jnTu/N3vUe01DjvYFjDplrhVjFi2US/3sjUUhs3DoECPDdmlndShk/Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deWiUPAr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deWiUPAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744630050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16bddCrtd0ailXVFFCZ2NETIOccVIAhkA7wz0NK8u44=;
	b=deWiUPArqaOqpCpRAK4gJ3/eIo3tqHThgpmU79A6zP7Vi2i2Os6TXHCCNOwKuixKDkdjvc
	/Z2GFUHcZ41hDv4s3LSdg0H2BW4aXD9+hvQEh8gHcdI1Y4S+5rVAV9f616Gu7b5TnG4F/x
	gsu5GOlLJGJfrRuf6EKGiCvMGakFq7k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-n_03gPFDPTub2X6zMgpzNw-1; Mon,
 14 Apr 2025 07:26:27 -0400
X-MC-Unique: n_03gPFDPTub2X6zMgpzNw-1
X-Mimecast-MFC-AGG-ID: n_03gPFDPTub2X6zMgpzNw_1744629986
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 639ED19560B0;
	Mon, 14 Apr 2025 11:26:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B39E3001D13;
	Mon, 14 Apr 2025 11:26:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/9] ublk: remove __ublk_quiesce_dev()
Date: Mon, 14 Apr 2025 19:25:48 +0800
Message-ID: <20250414112554.3025113-8-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove __ublk_quiesce_dev() and open code for updating device state as
QUIESCED.

We needn't to drain inflight requests in __ublk_quiesce_dev() any more,
because all inflight requests are aborted in ublk char device release
handler.

Also we needn't to set ->canceling in __ublk_quiesce_dev() any more
because it is done unconditionally now in ublk_ch_release().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e02f205f6da4..f827c2ef00a9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -209,7 +209,6 @@ struct ublk_params_header {
 
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
-static void __ublk_quiesce_dev(struct ublk_device *ub);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
@@ -1589,11 +1588,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 			/*
 			 * keep request queue as quiesced for queuing new IO
 			 * during QUIESCED state
-			 *
-			 * request queue will be unquiesced in ending
-			 * recovery, see ublk_ctrl_end_recovery
 			 */
-			__ublk_quiesce_dev(ub);
+			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 		} else {
 			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
@@ -1839,22 +1835,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
-/* Now all inflight requests have been aborted */
-static void __ublk_quiesce_dev(struct ublk_device *ub)
-{
-	int i;
-
-	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
-			__func__, ub->dev_info.dev_id,
-			ub->dev_info.state == UBLK_S_DEV_LIVE ?
-			"LIVE" : "QUIESCED");
-	/* mark every queue as canceling */
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->canceling = true;
-	ublk_wait_tagset_rqs_idle(ub);
-	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-}
-
 static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
-- 
2.47.0

