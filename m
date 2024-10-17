Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8E1DA112
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164998; cv=none; b=PvVmfhf0IGwvKgFDTujYsEORJiSaTsQI/KixbmYdznaArHjN7vlTWL775njSo4KYqzYnQY+Kynqoa4ek1eAMNsHQnPfhV21hLUYl63f/UZtBt22b6IHnok4O4vzmTmfVx+OBmIkG5m2jdz5ui1XeVYG1t6Y+7JB/WaSSEnp5zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164998; c=relaxed/simple;
	bh=i6w8ieQcXW1K6B7GzLm0kqGCyIC97IVhovqIAIro8Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFeq2g1Vbpb6Kunktdzjvrw6N43rVBqNg1jKRn6iANu6yFATpG+W/2uzym+VP1/ktu07PqMB4mD8x8GFLRHwVeBEkI/F8VIohzOugRGxod6OSHrDaB25l0ejXt3rZuq/y/8srFyYmPXH8hCeHJ+w/aZpsSPvAhUrpwINEn6HbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhcJzcIq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhcJzcIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729164994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n0WSr1WmF7RA4Fe9ll4u+vzJx+IjPh5Yd91Xl29OH1Q=;
	b=MhcJzcIqoBUi/3wgBvJoyq+ZSevSeA+DZw8s0j4/hOV9A5+yXzqgjU/3KQAy+KhV1G7FVI
	L09P1HIWPiztoYIX5WfJ3qODcKe1PtyVIDmxyFsUAQCrzOngb06V/J1gSzKXQLEMY9lhnr
	+gkLRcHIqiIVEpaeZ17icGv9nL7Bdz8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Ri7peXqmOdOR5cjOSO91rQ-1; Thu,
 17 Oct 2024 07:36:31 -0400
X-MC-Unique: Ri7peXqmOdOR5cjOSO91rQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1516195609F;
	Thu, 17 Oct 2024 11:36:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.161])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 826AB19560AD;
	Thu, 17 Oct 2024 11:36:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: josef@toxicpanda.com,
	nbd@other.debian.org,
	eblake@redhat.com,
	Ming Lei <ming.lei@redhat.com>,
	vincent.chen@sifive.com,
	Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] nbd: fix partial sending
Date: Thu, 17 Oct 2024 19:36:14 +0800
Message-ID: <20241017113614.2964389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

nbd driver sends request header and payload with multiple call of
sock_sendmsg, and partial sending can't be avoided. However, nbd driver
returns BLK_STS_RESOURCE to block core in this situation. This way causes
one issue: request->tag may change in the next run of nbd_queue_rq(), but
the original old tag has been sent as part of header cookie, this way
confuses nbd driver reply handling, since the real request can't be
retrieved any more with the obsolete old tag.

Fix it by retrying sending directly, this way is reasonable & safe since
nothing can move on if the current hw queue(socket) has pending request,
and unnecessary requeue can be avoided in this way.

Cc: vincent.chen@sifive.com
Cc: Leon Schuermann <leon@is.currently.online>
Cc: Bart Van Assche <bvanassche@acm.org>
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
Kevin,
	Please test this version, thanks!

 drivers/block/nbd.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..ef84071041e3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -701,8 +701,9 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 			if (sent) {
 				nsock->pending = req;
 				nsock->sent = sent;
+			} else {
+				set_bit(NBD_CMD_REQUEUED, &cmd->flags);
 			}
-			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
 			return BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -743,7 +744,6 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 					 */
 					nsock->pending = req;
 					nsock->sent = sent;
-					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
 					return BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
@@ -778,6 +778,35 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 	return BLK_STS_OK;
 }
 
+/*
+ * Send pending nbd request and payload, part of them have been sent
+ * already, so we have to send them all with current request, and can't
+ * return BLK_STS_RESOURCE, otherwise request tag may be changed in next
+ * retry
+ */
+static blk_status_t nbd_send_pending_cmd(struct nbd_device *nbd,
+		struct nbd_cmd *cmd)
+{
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+	unsigned long deadline = READ_ONCE(req->deadline);
+	unsigned int wait_ms = 2;
+	blk_status_t res;
+
+	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
+
+	while (true) {
+		res = nbd_send_cmd(nbd, cmd, cmd->index);
+		if (res != BLK_STS_RESOURCE)
+			return res;
+		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline)
+			break;
+		msleep(wait_ms);
+		wait_ms *= 2;
+	}
+
+	return BLK_STS_IOERR;
+}
+
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
 			  struct nbd_reply *reply)
 {
@@ -1111,6 +1140,8 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		goto out;
 	}
 	ret = nbd_send_cmd(nbd, cmd, index);
+	if (ret == BLK_STS_RESOURCE && nsock->pending == req)
+		ret = nbd_send_pending_cmd(nbd, cmd);
 out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_config_put(nbd);
-- 
2.44.0

