Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E41487F4
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746695; cv=none; b=h0o0dg7adLogur21VWya+Z3mTyT4GsO7Gu8xME31qw2pw4XLz4EBcbgtaEttyq/T6keCrDsgl4Sh8tRpJ7gv9SnCuCZXc6C1ssqsyPl5XbrPrlxLhVwwOgHNl+lBI/xwBq/MG3XwnITdZh/99XtfWdEURpbL0CYxWn5HpTKzvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746695; c=relaxed/simple;
	bh=ueQ+aPpDc0TK9bCs4HiiYBkaW0h8zdVvh8h6Spr+UTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO+n8cbgksAsppftbbqyHQ0sxDGCAVZHL8kt0hFJyeqfWUFsRKDY93y9nGHt6SBxIe9gVGoOAg0SdI1Neos0oCN/rXfGp4QSd9tKsNC88NVq4tSuyZtlR/NL62M+xw7i9fdEpflGbYUaR1BdCmepgYMIhtBBZyAhIs+h8bkxFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRYDNnt5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRYDNnt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724746693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2POjXLS4suf26/CFlDwrLvuDWCdNgPkqz+C0kWqYtjM=;
	b=ZRYDNnt5WgJzvW6wnIsIQPqE6LZ+21ttftwGq+9xo8Ykq+3DQhUJeimVkFacjNQs1/oiB1
	dIjsDsdlcdycgykJjgbWxyvxkEIW9KM3fvZuMsMOkYUwsHkq7cnXkp466T6m1774PVZrPO
	vWyxK+G21P0PfjESsckglATwBy0MPLU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-yPgESvXbOlO8WyU5Ii5kDQ-1; Tue,
 27 Aug 2024 04:18:09 -0400
X-MC-Unique: yPgESvXbOlO8WyU5Ii5kDQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A315A1955F42;
	Tue, 27 Aug 2024 08:18:07 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC8BF30001A1;
	Tue, 27 Aug 2024 08:18:02 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	john.g.garry@oracle.com,
	ltp@lists.linux.it
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCh v2] loop: Increase bsize variable from unsigned short to unsigned int
Date: Tue, 27 Aug 2024 16:17:57 +0800
Message-ID: <20240827081757.37646-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This change allows the loopback driver to handle block size larger than
PAGE_SIZE and increases the consistency of data types used within the driver.
Especially to match the struct queue_limits.logical_block_size type.

Also, this is to get rid of the LTP/ioctl_loop06 test failure:

  12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
  13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
  ...
  18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
  19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly

Thoese fail due to the loop_reconfigure_limits() cast bsize to 'unsined short'
that never gets an expected error when testing invalid logical block size,
which was just exposed since 6.11-rc1 introduced patches:

  commit 9423c653fe61 ("loop: Don't bother validating blocksize")
  commit fe3d508ba95b ("block: Validate logical block size in blk_validate_limits()")

Link: https://lists.linux.it/pipermail/ltp/2024-August/039912.html
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jan Stancek <jstancek@redhat.com>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 78a7bb28defe..86cc3b19faae 100644
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
@@ -977,7 +977,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static unsigned short loop_default_blocksize(struct loop_device *lo,
+static unsigned int loop_default_blocksize(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
 	/* In case of direct I/O, match underlying block size */
@@ -986,7 +986,7 @@ static unsigned short loop_default_blocksize(struct loop_device *lo,
 	return SECTOR_SIZE;
 }
 
-static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize)
+static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-- 
2.46.0

