Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6B25F787
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824177; cv=none; b=VpGJC41Yug8TkQucEVAtsTUOwhiq/HEFwzNXmn/ucpinKwKVAduyhwx8/yK0EZfP2uIUJ4datTHfqRHsYBTv/do9wCTox0UIrjJpjygXbRvoBf9DQuTRwnhGchLFJr0Ysojg7BZiqMkNY/foGZQgyLnmM0u9MB6QAvu8wmwm1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824177; c=relaxed/simple;
	bh=YuAkcegAyRS4dk6eHLcbJUDzp+X5sC3owPf8lRFmMzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJO9ddmTPWSBllZ7ud8taaN7JyHqNikVAczFkLI1D6CbIrKxzQj3tkc3QUK2nVkZpkM6mJhAoBUMO2/RQACwg3U5x9b9hX1vg7usMsamNi5LaaGypwa+T/kfNEiT9b4FLpm8VEEGLYgoevhAbzIWFwsgL1+xNPpjLEZdpfvzGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2M2CbJU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2M2CbJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKyGEArXVeaoGS2Cb6Rs9e+ttvvqrZtXk8Cfk2GNra0=;
	b=I2M2CbJUArZwqgHu1F2zwZ3EaSUSV8Ny5RmB7iQvQpqcA6v1jc5zPUb0xDsIdojUT99YLH
	SorpgIx5WSGTvJguk/X3d3CrcJHqW6lC1GY9mjACC9xrn8k/DVuXq1jpRlwblXQBGJhM3J
	VLDhnBrFU1bDyihvVh+So2hnRLK9TNA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-OEe-0KF_O0mqoYD0cqii9A-1; Mon,
 24 Mar 2025 09:49:33 -0400
X-MC-Unique: OEe-0KF_O0mqoYD0cqii9A-1
X-Mimecast-MFC-AGG-ID: OEe-0KF_O0mqoYD0cqii9A_1742824172
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E58AA1800A38;
	Mon, 24 Mar 2025 13:49:31 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F720195609D;
	Mon, 24 Mar 2025 13:49:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/8] ublk: add helper of ublk_need_map_io()
Date: Mon, 24 Mar 2025 21:48:57 +0800
Message-ID: <20250324134905.766777-3-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Ming Lei <tom.leiming@gmail.com>

ublk_need_map_io() is more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2ea1ee209b64..6fa1384c6436 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -596,6 +596,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
 }
 
+static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
+{
+	return !ublk_support_user_copy(ubq);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
@@ -923,7 +928,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	/*
@@ -947,7 +952,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
@@ -1843,7 +1848,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * FETCH_RQ has to provide IO buffer if NEED GET
 			 * DATA is not enabled
@@ -1865,7 +1870,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
-- 
2.47.0

