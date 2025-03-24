Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C935FC0A
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824185; cv=none; b=pEBYKMfDC3wi4ZmBlsEMN7BEgkE+8Jumuh9tBjH+hlWP8Hvgr+hJAJSDbDthuH0mryxTBuuyevu/lAXHRkgqLOFYeNWUQ05mKbyJ2qImxSuqYFtva5gDPcgBPsy01wzIylRwRda4TshMTMwCpL7Rm3ZQ2B5qZTgFvJjvecukBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824185; c=relaxed/simple;
	bh=zBixr+hLjSj/maIYndWZb5b66dPQ94MqUfYYH7RN3DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkanN+EkLtc5EeYItt//gEd0/WO6vxvWk6wrkdMEPMH3Uk5QKH4nstLwGQ2WexUhKqkDrY6TukbQJKznQ6IErGSV9zd1KYLtHdOTaZV8aoV4BBTjVEFbCdHghpa9qLdf5gfLw8hcQUwBNw0c2bsDWS80CiEPxR2rjytmf+aPlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frp/be14; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frp/be14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1THNbf8n6U8EvoRTj6F3NGlDsZdOHp6NlaFxnh7CeE=;
	b=frp/be14/RJyPkz0UqzlQhPOi2EOFPf+SxlTdTUJf1zgmBA4aRkAavwqaYrnT9aoyUcGqT
	Zm7OVyH8F5cp66AbUE72P2OQ5tXWXvdjz2qDc2vsjgqZyYYQxTcBJtMA1feVvA8FYlxfhI
	foy03hp7AMZdTqDeUZL6CcfkYibnymM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-6TCceLx2MTaQudKdN9jtFg-1; Mon,
 24 Mar 2025 09:49:38 -0400
X-MC-Unique: 6TCceLx2MTaQudKdN9jtFg-1
X-Mimecast-MFC-AGG-ID: 6TCceLx2MTaQudKdN9jtFg_1742824177
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E24721809CA3;
	Mon, 24 Mar 2025 13:49:36 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AC6B30001A1;
	Mon, 24 Mar 2025 13:49:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] ublk: truncate io command result
Date: Mon, 24 Mar 2025 21:48:58 +0800
Message-ID: <20250324134905.766777-4-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If io command result is bigger than request bytes, truncate it to request
bytes. This way is more reliable, and avoids potential risk, even though
both blk_update_request() and ublk_copy_user_pages() works fine in this
way.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6fa1384c6436..acb6aed7be75 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1071,6 +1071,10 @@ static inline void __ublk_complete_rq(struct request *req)
 		goto exit;
 	}
 
+	/* truncate result in case it is bigger than request bytes */
+	if (io->res > blk_rq_bytes(req))
+		io->res = blk_rq_bytes(req);
+
 	/*
 	 * FLUSH, DISCARD or WRITE_ZEROES usually won't return bytes returned, so end them
 	 * directly.
-- 
2.47.0

