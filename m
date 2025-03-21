Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457442A94
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565220; cv=none; b=XurVlaQSWUzATW7coggsF5NzSSfgD0ePJ0lzxdGZ+6i7Ja6YkIeOIjm61Km8Xkbo7AFW3cBbLmea3NN9SBIo9L3PRj+OAeO73mEPf1A54AIVETMRAMyPixUXN9zfiGSfDmutKAjur1Y8wExzaaJSHpEJNVh41S7HV5ejypWXFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565220; c=relaxed/simple;
	bh=EiCilvJlLEdEh5lxdvjcbru8JvGaA1KGjQwvkqX6YWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AH/8ZnUQf3rY2yMuqQEY1R+A26wYMvhSCjyPMh1FfZdMLh1FN9c9M4x/vwCkzuwiDliZ774QFhHoKtqwjuJAyhsfguoOM9GL1GMQXw+/slrVkUnp5lo2WpmKtri+nZU2ETBkfSiE3LS7nbFAa0nNvfV1nHHkSYuV0Wi0pAUvGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U55UIlZ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U55UIlZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742565217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rb/0fycfKxUxKQhOU0nYLz6+WvRJOmWcMbjeI/Z3jM4=;
	b=U55UIlZ8JOc0hpT1I4w16MLuiRdrQDB/quu8NNZpm59eRdZFgpxIcIbQT6rLqYq7BS9a37
	DmLLVu0PjAiXoVgyEI0TBA+hwmY0j4BPWQvcSAe1tEVDzkWCz1Q3RXP3Jwy1j8RMA/q28h
	8EdRTpVxza8dnCDI+MFkw4TlcRbkZLs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-c1cFPPafOHKGBxoYeVd7Hw-1; Fri,
 21 Mar 2025 09:53:35 -0400
X-MC-Unique: c1cFPPafOHKGBxoYeVd7Hw-1
X-Mimecast-MFC-AGG-ID: c1cFPPafOHKGBxoYeVd7Hw_1742565214
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFE3B18EBE8F;
	Fri, 21 Mar 2025 13:53:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 898B91800370;
	Fri, 21 Mar 2025 13:53:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: fix starting ublk device
Date: Fri, 21 Mar 2025 21:53:24 +0800
Message-ID: <20250321135324.259677-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Firstly ublk char device node may not be created by udev yet, so wait
a while until it can be opened or timeout.

Secondly delete created ublk device in case of start failure, otherwise
the device becomes zombie.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c |  4 ++-
 tools/testing/selftests/ublk/kublk.c       | 30 ++++++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 8a07356eccaf..570a5158b665 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -196,11 +196,13 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
 		},
 	};
 
-	assert(dev->tgt.nr_backing_files == 1);
 	ret = backing_file_tgt_init(dev);
 	if (ret)
 		return ret;
 
+	if (dev->tgt.nr_backing_files != 1)
+		return -EINVAL;
+
 	bytes = dev->tgt.backing_file_size[0];
 	dev->tgt.dev_size = bytes;
 	p.basic.dev_sectors = bytes >> 9;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 148355717ee7..11005a87bcfa 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -379,26 +379,34 @@ static int ublk_queue_init(struct ublk_queue *q)
 	return -ENOMEM;
 }
 
+#define WAIT_USEC 	100000
+#define MAX_WAIT_USEC 	(3 * 1000000)
 static int ublk_dev_prep(struct ublk_dev *dev)
 {
 	int dev_id = dev->dev_info.dev_id;
+	unsigned int wait_usec = 0;
+	int ret = 0, fd = -1;
 	char buf[64];
-	int ret = 0;
 
 	snprintf(buf, 64, "%s%d", UBLKC_DEV, dev_id);
-	dev->fds[0] = open(buf, O_RDWR);
-	if (dev->fds[0] < 0) {
-		ret = -EBADF;
-		ublk_err("can't open %s, ret %d\n", buf, dev->fds[0]);
-		goto fail;
+
+	while (wait_usec < MAX_WAIT_USEC) {
+		fd = open(buf, O_RDWR);
+		if (fd >= 0)
+			break;
+		usleep(WAIT_USEC);
+		wait_usec += WAIT_USEC;
+	}
+	if (fd < 0) {
+		ublk_err("can't open %s %s\n", buf, strerror(errno));
+		return -1;
 	}
 
+	dev->fds[0] = fd;
 	if (dev->tgt.ops->init_tgt)
 		ret = dev->tgt.ops->init_tgt(dev);
-
-	return ret;
-fail:
-	close(dev->fds[0]);
+	if (ret)
+		close(dev->fds[0]);
 	return ret;
 }
 
@@ -856,6 +864,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 
 	ret = ublk_start_daemon(ctx, dev);
 	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\b", ret);
+	if (ret < 0)
+		ublk_ctrl_del_dev(dev);
 
 fail:
 	if (ret < 0)
-- 
2.47.1

