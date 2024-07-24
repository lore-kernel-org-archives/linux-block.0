Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3462D030
	for <linux-block@vger.kernel.org>; Wed, 24 Jul 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831629; cv=none; b=b1ymW5Rnfca9fOWtSNAkY3xzmJY6v9xu3nFTTqXLq9pCmmfJiszjWP0baRfsWlu+JZWLSm1Wz+61aSCKGUCoOiwwJRF5te34H/UHgOhihQvOSyDpRli9xBYRzHO5p6mPN/BKgOcVxublw/aLTTVcMN0sHiyUXIqdUrzfMm1nCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831629; c=relaxed/simple;
	bh=DZEhDizrIogVZoNsdXUzb6LH2/Me04LJeV62sm9H/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaS3ojUMuxQoUSogPq19hU9hZ2NLa5RvzXvmuoy47VgnlOHJR8jCR8hTcsBCzd8ipPRObOw6w90kF2uAeZHls4z6aZWAv+ElIt19hLBHpFJjwq80CSkvGcSoeuAVpnTIyQvnRHReIufXo2dps7YjKptN7OqYl4cDp/UPM5Uvvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agtIfgN1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agtIfgN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721831626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7gaEGGDhYGp1TNTCLfUvmm4eRuL/itK5OQ4J7sxQhyc=;
	b=agtIfgN1PiQnZWK5EeIhGw+L2JsPy1MU3VRXaVySrRjQQJpCS8kJg9393SowIAMwHeQlUa
	asG5u7yZy4qGGTbH/E/opYQh3XP1ep04oecXGqqaY15Q1ssvS29b4gXBixQLB0/v4qdw5C
	Dg1jgRr823Z3f2hpaCdA9occB0fhpEo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-St-sdEh7P_eFuGWSr7FTtQ-1; Wed,
 24 Jul 2024 10:33:39 -0400
X-MC-Unique: St-sdEh7P_eFuGWSr7FTtQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5182618EB2DB;
	Wed, 24 Jul 2024 14:33:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3444D1955D4C;
	Wed, 24 Jul 2024 14:33:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: fix UBLK_CMD_DEL_DEV_ASYNC handling
Date: Wed, 24 Jul 2024 22:33:11 +0800
Message-ID: <20240724143311.2646330-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In ublk_ctrl_uring_cmd(), ioctl command NR should be used for
matching _IOC_NR(cmd_op).

Fix it by adding one private macro, and this way is clean.

Fixes: 13fe8e6825e4 ("ublk: add UBLK_CMD_DEL_DEV_ASYNC")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6fb799ec0d88..890c08792ba8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -48,6 +48,9 @@
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
+/* private ioctl command mirror */
+#define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
+
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
@@ -2903,7 +2906,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_DEL_DEV:
 		ret = ublk_ctrl_del_dev(&ub, true);
 		break;
-	case UBLK_U_CMD_DEL_DEV_ASYNC:
+	case UBLK_CMD_DEL_DEV_ASYNC:
 		ret = ublk_ctrl_del_dev(&ub, false);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
-- 
2.45.2

