Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26018C91F
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745660497; cv=none; b=YSXg773GkX1ReyuUhP4PGBUljYx/FSW7ON8htSQL2XjQ3PR7zcPiN/A5aQ293DoVWHnQ+bhY+H6VnWm/lCZ9QA2X9QqFWm3Sv2yrHZjmB1BG7njI9pZqbWucDsAsVU6jjzL1Q0TW3tSiEOBYjss5fntrKhps+LF78uGN5yvqYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745660497; c=relaxed/simple;
	bh=p+TV6poMNE0G56epBrhOmmDOFy2I5G6ZtSzylTMfbYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpNjbwRuZwFFL9Yi0PueVccjgTV/9aZ8ax6EdxKLE/6dx8sXIVRS3rbB4VGEDW0+XyWJThPKwYhpeRmQ4qlE0pvm5SsW6tb7kqNeNQAmoUoY5WNXOe7Ng/pAApuz7yDDDCLbRjspavOWtZScpBViATYVVuTUT5rHVfTK5+m+McE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrnQd7Gl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrnQd7Gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745660494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkbtvAURgu2MDjC/XFH8v/3ECIP4YI/Rg9mk233gYzc=;
	b=RrnQd7GlDNyBEtIF/wS49Lc3ZW7L3PQuqxdAnaLfk608rk0BGGgUZhy88uM2TCNS/Q9dJP
	HPUy8P8vl9gVLLuNFHYXg2SoSTiwR1z9Oim8wi5WKy3SKGL0FOo2aERRyvlvyk4CrXgi1K
	Tmsd8dR0FKzQvN6yJfG8wdXhKQNfbtg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-YFBwUNzNN3-D9yT9RwV5Cg-1; Sat,
 26 Apr 2025 05:41:30 -0400
X-MC-Unique: YFBwUNzNN3-D9yT9RwV5Cg-1
X-Mimecast-MFC-AGG-ID: YFBwUNzNN3-D9yT9RwV5Cg_1745660489
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 982CD18004A7;
	Sat, 26 Apr 2025 09:41:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5542F1956094;
	Sat, 26 Apr 2025 09:41:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] ublk: enhance check for register/unregister io buffer command
Date: Sat, 26 Apr 2025 17:41:07 +0800
Message-ID: <20250426094111.1292637-3-ming.lei@redhat.com>
In-Reply-To: <20250426094111.1292637-1-ming.lei@redhat.com>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
register/unregister io buffer easily, so check it before calling
starting to register/un-register io buffer.

Also only allow io buffer register/unregister uring_cmd in case of
UBLK_F_SUPPORT_ZERO_COPY.

Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 40f971a66d3e..347790b3a633 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -609,6 +609,11 @@ static void ublk_apply_params(struct ublk_device *ub)
 		ublk_dev_param_zoned_apply(ub);
 }
 
+static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
@@ -1950,9 +1955,16 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
+	struct ublk_io *io = &ubq->ios[tag];
 	struct request *req;
 	int ret;
 
+	if (!ublk_support_zero_copy(ubq))
+		return -EINVAL;
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
 	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
 	if (!req)
 		return -EINVAL;
@@ -1968,8 +1980,17 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
+				  struct ublk_queue *ubq, unsigned int tag,
 				  unsigned int index, unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+
+	if (!ublk_support_zero_copy(ubq))
+		return -EINVAL;
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
@@ -2073,7 +2094,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
+		return ublk_unregister_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
-- 
2.47.0

