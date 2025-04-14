Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A517A2FC
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629968; cv=none; b=AqhFxP+UW4+uwOO4enrzsN0/tk7yyfOpm4spi853aeMhWke3IpdFV8QqB0VnURvLcxRI3HlY7XKnUQKYFCe1Wqk/le/FqRvHmKsV/5RHft+NTINMOcaXeEwU1YOSQwhCZaNAUbWX/IxKsB+dWsKPsJPiU2EDAU/2/BJ6kXpZ5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629968; c=relaxed/simple;
	bh=tOrO/KNnNpk5sYJ/4QVkZ5uHJRaG79QKbr2wy+sSajI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmhGgDolhq+uP1ixXzzAUIaQkfirYs4/3vLmck6y06vVdp6uUETfgBd6l1pqd+wiik+q4CwBwxH+FAJ7ZxF08zRrI2xZmHIfC6V9isB1qA1RyZMAFGUN4WJ6/h3KB6d2cpbXPTnY/o0NtXjKaimrWUZ2U6HlEu6Fhi6aL7eBenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K83t9YiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K83t9YiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlY0qbAk+8na8hkjwbfASv3ANfXcyB7VRocc/aWP1bE=;
	b=K83t9YiWGkoxXB6vdfWvJM2El/jtgSt9IPEZsP2fQ8jO+gjUanyjutmm/2/0X0Nj29lLyA
	cmU1VnZys6nlOmGGB1i99rRWGWFcimLes/gJrrk2uyKL4AZYNNDyCHlrh1C8+XzV4wWE+q
	IPMOM02yzqWJsQLM8UGzEgVVnnQI424=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-H7agL0JYNWyV9QW74Dec0Q-1; Mon,
 14 Apr 2025 07:26:03 -0400
X-MC-Unique: H7agL0JYNWyV9QW74Dec0Q-1
X-Mimecast-MFC-AGG-ID: H7agL0JYNWyV9QW74Dec0Q_1744629962
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2C39195608F;
	Mon, 14 Apr 2025 11:26:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98EC119560AD;
	Mon, 14 Apr 2025 11:26:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/9] ublk: don't try to stop disk if ->ub_disk is NULL
Date: Mon, 14 Apr 2025 19:25:42 +0800
Message-ID: <20250414112554.3025113-2-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In ublk_stop_dev(), if ublk device state becomes UBLK_S_DEV_DEAD, we
will return immediately. This way is correct, but not enough, because
ublk device may transition to other state, such UBLK_S_DEV_QUIECED,
when it may have been stopped already. Then kernel panic is triggered.

Fix it by checking ->ub_disk directly, this way is simpler and effective
since ub->mutex covers ->ub_disk change.

Fixes: bbae8d1f526b ("ublk_drv: consider recovery feature in aborting mechanism")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cdb1543fa4a9..15de4881f25b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1784,7 +1784,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	struct gendisk *disk;
 
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
+	if (!ub->ub_disk)
 		goto unlock;
 	if (ublk_nosrv_dev_should_queue_io(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
-- 
2.47.0

