Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24D228C92
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775725; cv=none; b=hbr2hatYHpivAv7LiSVOIStjoIfYmaVaYw/SJsZX+ZDEY2Yul6ks8bnGmLWHL9o4mK/DEgzhaIaTn1MdJciNsHxBFQurq/sgsZcfOtXGMsRZbhUp40NqflFT2LJlzKX100j0xdmpM5v7EABKFFML3dQk5cI2HOO+WGSzLDjT2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775725; c=relaxed/simple;
	bh=TlJWOa743p/8sKZk9QwqOmcKUlJui0zwpk9wfSoTDkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxdKcxd5hocwrprsSmRQZlcflGhcW0E33vr9PMNzjHaaa3Jy7htqaK5E4MvSSAjNQrt7DePR3v3003qDHMQSJ31CfWuibRxAP5OIKD0NFLwbsyT7SgnsLFyiM9NUHnyKmRtbAL4vNoIBgZO0u7/w8bpGiWdNiORYSnDQxUcok6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrMWMw3w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrMWMw3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X14XIEAs0MhASoMnJ9wtFGYSlJ4Yp6XE0DuJQEBApJM=;
	b=HrMWMw3wkyuq+GaxzKlOi21JG2OM33zAW++kiAcPKgEVTuyPir882z49Jg1+FSzFc8U2XP
	tjV9K00K9jON66x1z4/+osiTRqzjYNv9K+ZgZVVF3JQTTtUW3yJ+L566QZvV2L6ub3xPQs
	KMGrL9/shrkQO68dCocxZLBxEc6gQe8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-dH7Yq2_zO-WtiGwNy2L85g-1; Tue,
 15 Apr 2025 23:55:19 -0400
X-MC-Unique: dH7Yq2_zO-WtiGwNy2L85g-1
X-Mimecast-MFC-AGG-ID: dH7Yq2_zO-WtiGwNy2L85g_1744775718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1D611801A06;
	Wed, 16 Apr 2025 03:55:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BE811956054;
	Wed, 16 Apr 2025 03:55:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 6/8] ublk: remove __ublk_quiesce_dev()
Date: Wed, 16 Apr 2025 11:54:40 +0800
Message-ID: <20250416035444.99569-7-ming.lei@redhat.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove __ublk_quiesce_dev() and open code for updating device state as
QUIESCED.

We needn't to drain inflight requests in __ublk_quiesce_dev() any more,
because all inflight requests are aborted in ublk char device release
handler.

Also we needn't to set ->canceling in __ublk_quiesce_dev() any more
because it is done unconditionally now in ublk_ch_release().

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b0a7e5acb2eb..bf708e9e9a12 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -209,7 +209,6 @@ struct ublk_params_header {
 
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
-static void __ublk_quiesce_dev(struct ublk_device *ub);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
@@ -1586,7 +1585,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 		ublk_stop_dev_unlocked(ub);
 	} else {
 		if (ublk_nosrv_dev_should_queue_io(ub)) {
-			__ublk_quiesce_dev(ub);
+			/* ->canceling is set and all requests are aborted */
+			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 		} else {
 			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
@@ -1832,21 +1832,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
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

