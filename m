Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6D47D474
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156289; cv=none; b=Kfb2FSMHCMpShQJY/I/4v3P+YjeQLJkit4fsVTIM/mOaUPSCXzOzpIP4Wy3QvZ7GSoqadHqb8jPRbRyuMgCOhd19ZCbjLEFu8XFEI72vGduUjy65T93gTNWQimYpRldEX6Q1EY/nNyov/HVh21XtxnK3xbqNLJZ0MxXF7RujH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156289; c=relaxed/simple;
	bh=YJvzzP1Bz6XMpF54XRXcZDzXhOzozFFXvF4YzOqGVpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4iE5m+sPD6ujD/rC51ltVDZvcuqq3ON++3ctdJgI/qMMH2g08vXAO1fU9A+9LAEF4Pft5jE9T2hvJprwnUS8TOgoVCD1TzG9cKD7y7oGcQZPDkbZnYt+AaaXZZXh1P3XQyZdNfWfwvh9wDPOyg2FI9Gk/DZtzk4Mmgt42/pCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jAXGv1c2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jAXGv1c2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I/
	WxxpMd2yAbQpw+7TNTw5bCyUNr8mx9UV/o057FKC0=; b=jAXGv1c2MixHIr3WnM
	psj3skegqsHRsjXbcyaSNW4RCG+1wJeKYWinbtzHYdIDSl4PYFdpLafSQr+GYV/w
	24Ghfy2ZnTRYxTHyRpp3nVIaUNkQXy1Uf7kX3r8UMcrBkuL8ngmX9kJQSv0ux3rr
	jGpB4uCbMGQrOeJwawH7WESrA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHx9XenbNqD8njAw--.24710S2;
	Wed, 23 Sep 2026 17:37:35 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <mkp@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] block: reject polled dio with user integrity metadata
Date: Wed, 23 Sep 2026 17:37:32 +0800
Message-Id: <20260923093732.1504291-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHx9XenbNqD8njAw--.24710S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF18Cw17Kw1kWw1rGr17Jrb_yoW8WF1Dpr
	yxJa43Wr4vqF17AF4UJa1UW348CF4DAa97Gayjvr45Cw1DAwnFyF12ka15WF4YyFZ8AF17
	Xrnava4qvr98XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j573kUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwQAnt2qzneBLrQAA3T

IOCB_HAS_METADATA leaves iocb->private as a uio_meta, while
iocb_bio_iopoll() expects a bio. Since 2729a60bbfb9, metadata I/O
always uses __blkdev_direct_IO(), which never publishes the bio for
polling, so IOPOLL calls bio_poll() on the uio_meta.

Reproducer: io_uring IOPOLL plus a PI attribute on an integrity device
(scsi_debug dif=1 dix=1). KASAN reports:

  Oops: general protection fault, probably for non-canonical
  address 0xdffffc0000000004
  KASAN: null-ptr-deref in range
  [0x0000000000000020-0x0000000000000027]
  RIP: 0010:bio_poll+0x9d/0x4b0
  Call Trace:
   iocb_bio_iopoll+0x5b/0x80
   io_uring_classic_poll+0xf3/0x140
   io_do_iopoll+0x4e3/0xc00
   io_iopoll_check+0x275/0x560
   __do_sys_io_uring_enter+0x2e5/0x720

Return -EOPNOTSUPP when HIPRI is combined with user metadata.

Fixes: 2729a60bbfb9 ("block: don't silently ignore metadata for sync read/write")
Assisted-by: LLM
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 block/fops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 2ce7c6c4714e..c915ec0126d7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -402,6 +402,11 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
+	/* HIPRI needs private as bio; HAS_METADATA keeps it as uio_meta */
+	if ((iocb->ki_flags & IOCB_HIPRI) &&
+	    (iocb->ki_flags & IOCB_HAS_METADATA))
+		return -EOPNOTSUPP;
+
 	if (iov_iter_rw(iter) == WRITE) {
 		u16 max_write_streams = bdev_max_write_streams(bdev);
 
-- 
2.25.1

