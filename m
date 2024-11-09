Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF43FB8B
	for <linux-block@vger.kernel.org>; Sat,  9 Nov 2024 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119280; cv=none; b=O+KKmArW9/jNBnMEc47UX4YW6jL9mgTxc2i6vK7ScWPxN76NmTrFq/RCDlDMr2shH0L/4vJoTqNoLOeg+UjLm/LDcFCCcJcSbehOPnCzBy/SSfV7Jz0hkchBoE3covqHiNE3ZmL+3parvtgNSk5qEGzUdsFJgp0mqeH8IRTS4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119280; c=relaxed/simple;
	bh=ViDUck4i+N5EpNg1wEOZXbt6ZtrxItQMeVSl3T9oDFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IedAwrO6AbGsC/HcaHAyr1RAkF9jyyclD3YrxQsoTzhHPGpbY7m+26wN4TJPxz083RWrrs8SGSRF6nsh12hRl2lxglffsO26EX9IZhPFgPFx/Esp5wKKrNOBFNG7w4Y3PmQftPuZKO85YNq8/j89valGbr1cVPTZDHdOV4E3A8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwJHDR1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwJHDR1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731119277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4i2n7EuPgV3NJ6Yg+CPY7/orplxgDOJQtxtk6kTi3U=;
	b=DwJHDR1PgY/06nB4iq0DzXCMyR2mNrMivNt0FSzcx/75rR1s+jmKYI1mbbPsLyqxCGVCpG
	m2SHq8k0YXY6x2JxHJPTIWxblTajHlvqrG0uPTNOW1KcWexTad88GCOFRM8oog8g55zQmO
	Qm4QK/Q8bMEHHtDGcmzd9xcBdBcPn6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-unuwCi9UNruoP2P06HqVCQ-1; Fri,
 08 Nov 2024 21:27:55 -0500
X-MC-Unique: unuwCi9UNruoP2P06HqVCQ-1
X-Mimecast-MFC-AGG-ID: unuwCi9UNruoP2P06HqVCQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B745195608A;
	Sat,  9 Nov 2024 02:27:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.23])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 059B91953880;
	Sat,  9 Nov 2024 02:27:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Li Wang <liwang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3] loop: fix type of block size
Date: Sat,  9 Nov 2024 10:27:44 +0800
Message-ID: <20241109022744.1126003-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Li Wang <liwang@redhat.com>

PAGE_SIZE may be 64K, and the max block size can be PAGE_SIZE, so any
variable for holding block size can't be defined as 'unsigned short'.

Unfortunately commit 473516b36193 ("loop: use the atomic queue limits
update API") passes 'bsize' with type of 'unsigned short' to
loop_reconfigure_limits(), and causes LTP/ioctl_loop06 test failure:

  12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
  13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
  ...
  18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
  19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly

Fixes the issue by defining 'block size' variable with 'unsigned int', which is
aligned with block layer's definition.

Fixes: 473516b36193 ("loop: use the atomic queue limits update API")
Cc: John Garry <john.g.garry@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
(improve commit log & add fixes tag)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- improve commit log
	- add fixes tag

 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f21f4254b038..fe9bb4fb5f1b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -173,7 +173,7 @@ static loff_t get_loop_size(struct loop_device *lo, struct file *file)
 static bool lo_bdev_can_use_dio(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
-	unsigned short sb_bsize = bdev_logical_block_size(backing_bdev);
+	unsigned int sb_bsize = bdev_logical_block_size(backing_bdev);
 
 	if (queue_logical_block_size(lo->lo_queue) < sb_bsize)
 		return false;
@@ -976,7 +976,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static unsigned short loop_default_blocksize(struct loop_device *lo,
+static unsigned int loop_default_blocksize(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
 	/* In case of direct I/O, match underlying block size */
@@ -985,7 +985,7 @@ static unsigned short loop_default_blocksize(struct loop_device *lo,
 	return SECTOR_SIZE;
 }
 
-static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize)
+static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-- 
2.44.0

