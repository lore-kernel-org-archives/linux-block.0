Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2283191F98
	for <linux-block@vger.kernel.org>; Sun,  8 Mar 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980761; cv=none; b=aCnHOEKt65agrg8Sh++qUZtN1ugXkAyB+ZjfOG/9QDm3rp4nQu6FEtogBnSA7fz3dtz6JsTMo4n+sn0dCbub7WHsUvfJJnPCtoMRu1k2gcNMElvG0FCBhEUkuuribxsI6Fe9oO3lrHbkyTygSwXDjpoS2qGcW87xb5AehmnbKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980761; c=relaxed/simple;
	bh=WC2lkdnITp0vkwg9HUiPUCYFjRsR2kZ4IiiwuQ6FFfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKGvLNheIaPheWx/Qmc44VVKQbpQQUsiq4MFvkqnFJ6q8mgHugkN5w4vk4TKcQiImtm/KVuQ2NhDNS7oQ20Vuelq7vAwm+AJY5Nmntinlj0DWfEdncbdhZvy2MZ+RrYQlUbpqfkVxdyzNJQAbsa6rvcBJ4eSBRy65QGlxGQ5mR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdR6EPnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdR6EPnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772980758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChnMED9+RXNPD8d21ki0Lnd6qehTqTkb/GNROg6QWOE=;
	b=ZdR6EPnvyCOZ+UjAg3DJGvfzSDs4t2BH6jVFQ+Cl/Nx8UP+p3t6Tl7hW4Qxq17qaswKAc2
	3aVVuIz0PCZkmeU5SOUr/Oz/LIXDdwpG3dsKbu3NEVHaBfMDBwYTW4gF7JIDtGm0+p4iWW
	1i4wCXBaNkX0vQsI9BjSqbv2hGP06aE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-1WsWSRDCNo2wW9Vhlxzhog-1; Sun,
 08 Mar 2026 10:39:13 -0400
X-MC-Unique: 1WsWSRDCNo2wW9Vhlxzhog-1
X-Mimecast-MFC-AGG-ID: 1WsWSRDCNo2wW9Vhlxzhog_1772980752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 233161956048;
	Sun,  8 Mar 2026 14:39:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E45F018001FE;
	Sun,  8 Mar 2026 14:39:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: don't clear GD_SUPPRESS_PART_SCAN for unprivileged daemons
Date: Sun,  8 Mar 2026 22:39:02 +0800
Message-ID: <20260308143902.1643155-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When UBLK_F_NO_AUTO_PART_SCAN is set, GD_SUPPRESS_PART_SCAN is cleared
unconditionally, including for unprivileged daemons. Keep it consistent
with the code block for setting GD_SUPPRESS_PART_SCAN by not clearing
it for unprivileged daemons.

In reality this isn't a problem because ioctl(BLKRRPART) requires
CAP_SYS_ADMIN, but it is more reliable to not clear the bit.

Cc: Alexander Atanasov <alex@zazolabs.com>
Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 004f367243b6..9573a46d0ef4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -4443,7 +4443,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	/* Skip partition scan if disabled by user */
 	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
-		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+		/* Not clear for unprivileged daemons, see comment above */
+		if (!ub->unprivileged_daemons)
+			clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 	} else {
 		/* Schedule async partition scan for trusted daemons */
 		if (!ub->unprivileged_daemons)
-- 
2.47.1

