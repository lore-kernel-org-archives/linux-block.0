Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD59C433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Feb 2022 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiBAKEG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Feb 2022 05:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBAKEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Feb 2022 05:04:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D1C061714
        for <linux-block@vger.kernel.org>; Tue,  1 Feb 2022 02:04:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f80-20020a1c1f53000000b0035399b8bedcso1161750wmf.0
        for <linux-block@vger.kernel.org>; Tue, 01 Feb 2022 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GiD98DA7hNaCyllVp86U7owD2H4WGbPzlBm1oDwIIXI=;
        b=I5SuTaQS6vZvSbHSD5E24aVZOump0+bjt1QE3/e+MFD3kA80AY44gqQoQaCt6ew+er
         JP0FKBPbZ9+EVfppj/K+mraeJI7US34A/QYQOjxeLCcmK/Z1kJpMFRnThj4KRxqXq278
         rI2AqFI6C9XBDsAREQIQ/gZzsjsYytSbhSXI2ma3FVOnK29T5rxjJoMbZdf0+e4eJoum
         ZcIeWMz/cUxQEmrYNYx28lUbIJZls2N2Tb0tT2JMKdZQWQ5NZgh/90wDiMRCTCoYqdLe
         bltlzgX7Jsyg0ZfZY8bbVf/YJi3+Qw4kP6Oyg8/MbGNS+tfs+U2dSUCgrrJdD+fraxLG
         5gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GiD98DA7hNaCyllVp86U7owD2H4WGbPzlBm1oDwIIXI=;
        b=0TE5zCOaQAqyx1eZ8wsOCBBXsdgMowoTfNP1cpXToEBWqL2+eKXSfJxlmkaGyDEXUu
         VvLXV/OumEz8OWd2nWHDUD4at9MIv7C27qIO8Lnk2Xt0huiMiEn6BPMTrzFiF/gTwNnJ
         jPPFHycxlXTVA08RqqE/JqIV7oKhD8GZ+/NnPb7TM3mYbdkN8gKmpXZMquTXJ6mTtwPO
         moq/mX/KzEcCBdiPOD9c9rzqXeMi9dPfyDtpIHhSOswzSm9vDmi1pfXnhkf4j83CAn8n
         5W/UvaSE/P7KWjmd9ZDDHdgK9iutD2wBNCBxGvdXnNo1nkK28pJjuqRfkgihqUd5wzsY
         F8MQ==
X-Gm-Message-State: AOAM531L+o5UxZp4aZAVAPBdwBZnmqa0/UQlz/lxb2vmwYxl3AIU0ZCg
        dEITabui+WEjDMHDBCd1zK2lZP3sRig=
X-Google-Smtp-Source: ABdhPJxTSqOeqQDF+KyJ6gm9maURMWD6CJX1AWJj9Av0yR/TZzriKnivchfX5RtHCOLLmYOnEfqTxw==
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr1087925wmq.90.1643709843800;
        Tue, 01 Feb 2022 02:04:03 -0800 (PST)
Received: from kwango.local (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id d6sm14019819wrs.85.2022.02.01.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:04:03 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH] block: fix DIO handling regressions in blkdev_read_iter()
Date:   Tue,  1 Feb 2022 11:04:20 +0100
Message-Id: <20220201100420.25875-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit ceaa762527f4 ("block: move direct_IO into our own read_iter
handler") introduced several regressions for bdev DIO:

1. read spanning EOF always returns 0 instead of the number of bytes
   read.  This is because "count" is assigned early and isn't updated
   when the iterator is truncated:

     $ lsblk -o name,size /dev/vdb
     NAME SIZE
     vdb    1G
     $ xfs_io -d -c 'pread -b 4M 1021M 4M' /dev/vdb
     read 0/4194304 bytes at offset 1070596096
     0.000000 bytes, 0 ops; 0.0007 sec (0.000000 bytes/sec and 0.0000 ops/sec)

     instead of

     $ xfs_io -d -c 'pread -b 4M 1021M 4M' /dev/vdb
     read 3145728/4194304 bytes at offset 1070596096
     3 MiB, 1 ops; 0.0007 sec (3.865 GiB/sec and 1319.2612 ops/sec)

2. truncated iterator isn't reexpanded
3. iterator isn't reverted on blkdev_direct_IO() error
4. zero size read no longer skips atime update

Fixes: ceaa762527f4 ("block: move direct_IO into our own read_iter handler")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/fops.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 26bf15c770d2..4f59e0f5bf30 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -566,34 +566,37 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	loff_t size = bdev_nr_bytes(bdev);
-	size_t count = iov_iter_count(to);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
 	ssize_t ret = 0;
+	size_t count;
 
-	if (unlikely(pos + count > size)) {
+	if (unlikely(pos + iov_iter_count(to) > size)) {
 		if (pos >= size)
 			return 0;
 		size -= pos;
-		if (count > size) {
-			shorted = count - size;
-			iov_iter_truncate(to, size);
-		}
+		shorted = iov_iter_count(to) - size;
+		iov_iter_truncate(to, size);
 	}
 
+	count = iov_iter_count(to);
+	if (!count)
+		goto reexpand; /* skip atime */
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
 		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
-						iocb->ki_pos + count - 1))
-				return -EAGAIN;
+			if (filemap_range_needs_writeback(mapping, pos,
+							  pos + count - 1)) {
+				ret = -EAGAIN;
+				goto reexpand;
+			}
 		} else {
-			ret = filemap_write_and_wait_range(mapping,
-						iocb->ki_pos,
-					        iocb->ki_pos + count - 1);
+			ret = filemap_write_and_wait_range(mapping, pos,
+							   pos + count - 1);
 			if (ret < 0)
-				return ret;
+				goto reexpand;
 		}
 
 		file_accessed(iocb->ki_filp);
@@ -603,12 +606,14 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			iocb->ki_pos += ret;
 			count -= ret;
 		}
+		iov_iter_revert(to, count - iov_iter_count(to));
 		if (ret < 0 || !count)
-			return ret;
+			goto reexpand;
 	}
 
 	ret = filemap_read(iocb, to, ret);
 
+reexpand:
 	if (unlikely(shorted))
 		iov_iter_reexpand(to, iov_iter_count(to) + shorted);
 	return ret;
-- 
2.19.2

