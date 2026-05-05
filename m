Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480619995E;
	Tue,  5 May 2026 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974397; cv=none; b=DPuYeyfbtK4HudnZ4E4vnZckiMDWImNs4dQPJ3bz5u/XGwPn03Sde9pa6/4K94ldCj0WcZ/AOFGFOgkQZaOaWhdOIOLAqpLFGZds2h8zlxhDdZV0OTjdmrVl8+Gyz5B1nXfUCBMmMVgGOkDexA2cGsLSvHQA2LJ+oa0J1Q4DZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974397; c=relaxed/simple;
	bh=zflWjVoS9s6SDIhDb/b5qkfXbHAON0pEvBkWxg1FfXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LguBVrlMEpWYzAEUk7n7vPZixWrgOB+H2dzcPq0q1NPIHMAjOh9c9eZRKG1JKGqCAayfbY1gfbVRdIcf/Cjd9N2k4kRalxa476GsAMyL4YwfyIC91WyoJurQieSIGJ5rik/6ibUq93ULiedhe1T+w1yOg+5wQXMG+nLo/EA/j/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JAUvZ9Hn; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JAUvZ9Hn"
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:d121:0:640:6cfa:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 209558046C;
	Tue, 05 May 2026 12:46:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp) with ESMTPSA id NkcOoG0RMmI0-vr7eI2NN;
	Tue, 05 May 2026 12:46:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777974384; bh=jqQFwau9LJ50tY/yXJ0MgbY28h7Fi94OPgZo5znRT/Y=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JAUvZ9HnbFiyieWgn29946Wm5Zk7Vh9ajvLJ1PplHeW3s3stUBn4dgIcdq7xk7DJK
	 MqNEt7+iJ9Rq5FsW9KAXiePsqO305GHCJ8ay7rPFwaY/SXQyI2S3tZ4LMWOnrx7V69
	 H1+a8cN9Zl8OHNjjVgWm+b9vkQtLSxRH5fZe+OFk=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
Date: Tue,  5 May 2026 12:45:29 +0300
Message-ID: <20260505094529.406783-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Local fuzzing has observed the following issue with 6.12.82 (and
then reproduced with 6.12.85 as well):

BUG: memory leak
unreferenced object 0xffff88810c568000 (size 2048):
  comm "syz.2.17", pid 1369, jiffies 4294894662
  hex dump (first 32 bytes):
    a8 62 6f 15 80 88 ff ff 00 00 00 00 00 00 00 00  .bo.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 43ffe8f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    slab_post_alloc_hook mm/slub.c:4152 [inline]
    slab_alloc_node mm/slub.c:4197 [inline]
    __do_kmalloc_node mm/slub.c:4331 [inline]
    __kmalloc_node_noprof+0x428/0x510 mm/slub.c:4338
    __kvmalloc_node_noprof+0xb5/0x240 mm/util.c:658
    kvmalloc_array_node_noprof include/linux/slab.h:1040 [inline]
    want_pages_array lib/iov_iter.c:992 [inline]
    iov_iter_extract_user_pages lib/iov_iter.c:1818 [inline]
    iov_iter_extract_pages+0x51b/0x14d0 lib/iov_iter.c:1884
    bio_map_user_iov+0x325/0xa50 block/blk-map.c:304
    blk_rq_map_user_iov+0x248/0x790 block/blk-map.c:646
    blk_rq_map_user+0x123/0x190 block/blk-map.c:673
    scsi_bsg_sg_io_fn+0x8d4/0xb00 drivers/scsi/scsi_bsg.c:53
    bsg_sg_io+0x1b7/0x2b0 block/bsg.c:67
    bsg_ioctl+0x3a4/0x5b0 block/bsg.c:151
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:907 [inline]
    __se_sys_ioctl fs/ioctl.c:893 [inline]
    __x64_sys_ioctl+0x194/0x220 fs/ioctl.c:893
    do_syscall_x64 arch/x86/entry/common.c:47 [inline]
    do_syscall_64+0x90/0x170 arch/x86/entry/common.c:78
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Since 'iov_iter_extract_user_pages()' may reallocate (that is,
replace an initial stack-allocated array with the one allocated via
'kvmalloc_array()'), this array must be freed, if actually replaced,
when handling error returned from 'iov_iter_extract_pages()'.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
(not sure about Fixes: due to a lot of renames and moves in this area)
---
 block/blk-map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-map.c b/block/blk-map.c
index b5fd1d857461..8523646054f0 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -305,6 +305,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 					       nr_vecs, extraction_flags, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
+			if (pages != stack_pages)
+				kvfree(pages);
 			goto out_unmap;
 		}
 
-- 
2.54.0

