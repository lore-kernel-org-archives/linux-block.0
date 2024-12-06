Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F21B6D04
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483081; cv=none; b=rBcvun3v6f4usmoSFChbZaQIkAUw74UpjI1OOOY867viQ1AVgIFzGVJ0JTUZWgcpPTk/N1kX73+Bx+O9igsi7WHp/RRu2C6P08Dju1YybGtIWO7T/wVYKp9hG5uTO3bm+4xp1qM1vmBE2VUkBXVpFeVMyhoXRvHNfwGAQK/n10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483081; c=relaxed/simple;
	bh=csTNFJhnxls1cv0z247gJ0fo4gjRdpnf5Qd2cSuxSYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/8J/cAkJbAli2WVI5tOBfF1anG8hJFqGVySxW/92IL/zwDo81VSt4d/mFccYKftUYTZ5/lytyLZkhrjIIwZlybeIDrq5xVWyuWUk5ZfQ63lJioKevjfwdAa5a9oMBEtkbfMG7VNQSPwbNXtKE0f4awaRQ7yxj3h4dFPYx1kW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLcv7mZx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLcv7mZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733483078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4DhosPWwOMnmyw0oxcd0Zk04TO0yhwigr4VF/94iATo=;
	b=DLcv7mZxal+OWPh0MGYw49FsJtc1afdgG0GbEOZW4k/v8RGme1YQA+YAShoIuN4tdYHeUL
	RVZfLybHNLD63A8voMpIqxzgRaVQKxu4igjLz/Bgssx6okAb10I4dOtnlh2hRGo6TqotKB
	PbnazjehfuK+Dqc9lP4WEd40uUGB5os=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-0LW-d8tSPDyPj6ZS520sCg-1; Fri,
 06 Dec 2024 06:04:36 -0500
X-MC-Unique: 0LW-d8tSPDyPj6ZS520sCg-1
X-Mimecast-MFC-AGG-ID: 0LW-d8tSPDyPj6ZS520sCg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C76891955F42;
	Fri,  6 Dec 2024 11:04:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96BFE19560AD;
	Fri,  6 Dec 2024 11:04:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blktests: src/miniublk.c: fix unaligned mmap offset for 64K page size
Date: Fri,  6 Dec 2024 19:04:27 +0800
Message-ID: <20241206110427.976391-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The 'offset' passed to mmap() has to be PAGE_SIZE aligned, which is
always true for 4K page size, but not true for 64K page size.

Fix it by adding helper of ublk_queue_max_cmd_buf_sz().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 src/miniublk.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/miniublk.c b/src/miniublk.c
index 565aa60..73791fd 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -472,14 +472,24 @@ static struct ublk_dev *ublk_ctrl_init()
 	return dev;
 }
 
-static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
+static int __ublk_queue_cmd_buf_sz(unsigned depth)
 {
-	int size =  q->q_depth * sizeof(struct ublksrv_io_desc);
+	int size =  depth * sizeof(struct ublksrv_io_desc);
 	unsigned int page_sz = getpagesize();
 
 	return round_up(size, page_sz);
 }
 
+static int ublk_queue_max_cmd_buf_sz(void)
+{
+	return __ublk_queue_cmd_buf_sz(UBLK_MAX_QUEUE_DEPTH);
+}
+
+static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
+{
+	return __ublk_queue_cmd_buf_sz(q->q_depth);
+}
+
 static void ublk_queue_deinit(struct ublk_queue *q)
 {
 	int i;
@@ -516,8 +526,7 @@ static int ublk_queue_init(struct ublk_queue *q)
 	q->tid = gettid();
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
-	off = UBLKSRV_CMD_BUF_OFFSET +
-		q->q_id * (UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc));
+	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
 	q->io_cmd_buf = (char *)mmap(0, cmd_buf_size, PROT_READ,
 			MAP_SHARED | MAP_POPULATE, dev->fds[0], off);
 	if (q->io_cmd_buf == MAP_FAILED) {
-- 
2.47.0

