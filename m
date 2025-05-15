Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582021CC70
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326377; cv=none; b=CYnk4R1UjsyyowAlkyiBaMHRQHTodXmLnNHqkM/Hh2V0/u8UQ2b+tlAKk0agjXXNdW3rF6uUd36cPZnVTXTmjvoqvDOpaf1migm7AmKNXxIVKbqJQRauwSZDq7fyWxKVd1mwYM27gOp47S/d2+3ngcPijwkYjiGvE9JSxBhMny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326377; c=relaxed/simple;
	bh=8im9bz+wFVRemM3Yi3xKVh+cV+0EhVXmpJQbunq6Hi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJ/WuT1CBWXXObfHV6C/8d1HxPzX0qqJUKnqkNMNEOn/EYjH+cOKewuiNKjlcKMkIMqhk+LbDk4laxorMuwIMo4SnGhPPZACRaT/r/cGZH38vYwlpD7kQ1Yg0DyJJ+sG1DY+Ftv553Imv0AVCL0F0OJgRRYEoqnSUbngNRz357U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBMZPlRr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBMZPlRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747326374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d0di3BD/q2pbid+vun9UScyV72KOyFYQbPTD8NVYJx8=;
	b=CBMZPlRrbVg0h9mr6MqgIMKvovOlW6np5QJjroxNgUu5tjVZ//4U9CDW42P2sW2tSLc0vV
	8N6tzF/waH51P+LGbQLxXWWvlxqHYRFyt6isuTMKSoxuO7vkFRjzq86OrrFlBz/BvHHlId
	T4XPDnP/Nnag1gJMpztIYT894hyby1Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-baod9Tk_NjuzDgnBxUMLfg-1; Thu,
 15 May 2025 12:26:11 -0400
X-MC-Unique: baod9Tk_NjuzDgnBxUMLfg-1
X-Mimecast-MFC-AGG-ID: baod9Tk_NjuzDgnBxUMLfg_1747326370
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F5E1956086;
	Thu, 15 May 2025 16:26:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3DB019560A7;
	Thu, 15 May 2025 16:26:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] ublk: fix dead loop when canceling io command
Date: Fri, 16 May 2025 00:26:01 +0800
Message-ID: <20250515162601.77346-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd")
adds request state check in ublk_cancel_cmd(), and if the request is
started, skip canceling this uring_cmd.

However, the current uring_cmd may be in ACTIVE state, without block
request coming to the uring command. Meantime, the cached request in
tag_set.tags[tag] is recycled and has been delivered to ublk server,
then this uring_cmd can't be canceled.

ublk requests are aborted in ublk char device release handler, which
depends on canceling all ACTIVE uring_cmd. So cause dead loop.

Fix this issue by not taking stale request into account when canceling
uring_cmd in ublk_cancel_cmd().

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn/
Fixes: f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f9032076bc06..dc104c025cd5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1708,7 +1708,7 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 	 * that ublk_dispatch_req() is always called
 	 */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
-	if (req && blk_mq_request_started(req))
+	if (req && blk_mq_request_started(req) && req->tag == tag)
 		return;
 
 	spin_lock(&ubq->cancel_lock);
-- 
2.47.1

