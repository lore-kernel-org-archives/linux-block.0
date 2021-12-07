Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03983C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 20:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhLGUUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhLGUUS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 15:20:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DCFC061574
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 12:16:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so131875wrn.6
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 12:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFQ+1LnHxWwDNwePXsO3CGQ0r4IXurIiCT4yNvoZFy8=;
        b=i9ZPmOVCn60cx1q9vcv3irdwbbnc8EW8X9J2Ghe0HJDVwb4qJTGIh/R9rQUTHYO9ZF
         3nsOf396KiFByGtPv4LgLhmG5sgdbeS2s+fU/LEpX0qX0Ca4/EkwLmzDU+T0FBaVM4AG
         i9vdyVe6NAZW/DrXzP5H092C0hs5SScj+j+YCd44374r2+S66HJCqPN5Xn686JiWN+VT
         pWTdC2+J9IV5v2dug1yg2x+rs09lwh+o1s1H8c74nk8GS7Ta+vYNbDxnJdgQtw9tbq2T
         SCVwwuZh4w/BMZ1B9X1i9wyBqNU8VRkJRtkLqAJb2DCRmOoBxgUX2X0TNjVG+SZqsqN6
         nxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFQ+1LnHxWwDNwePXsO3CGQ0r4IXurIiCT4yNvoZFy8=;
        b=UfGp6lXXWbGZpM82NoEflNiMLSoyPNcrMC9Rqjqh4uteUlmFufy8krET2RLeiYYHgM
         bx1zlYPgefIF8bgHLxIbyHF1di+vWTaIJbwskz5Blo3yTANdo68acjQQKUMwFyq5fZ/m
         kw40iOyukEOazFL8jUlX6vJ7VTELuOpIBfzDicgN5vtAdpFdvoxmxFzZM5V0dRhJp0Hp
         aTUZEVYEbFwm5j7q9jAL2CzY4pYRae7RKf+95y6nyrgsPJ8YhvTWXwvkOzeOtErrRVle
         lE4mxJXJjBdiXxWOr85uCz9PuTWCs0DO694NaNHQ6vwDlYoeIdhb3bPHaytkGLeBQ+mQ
         tpxw==
X-Gm-Message-State: AOAM5312hWuYOKuC9qSwxwbLokvW5veUBdxlKj2w7BtuVXBmPKTtXbQ+
        WIPOGB/EvnbTE/vKEJy5EizPcBny5uU=
X-Google-Smtp-Source: ABdhPJy2Pn6i4XfjbzizJ65bGsT+8TXobEwNzC0Zg/YMMd+mGOJjrIzR6TxK7jAhg8RpVP/KRiMvCw==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr53721897wrd.33.1638908206075;
        Tue, 07 Dec 2021 12:16:46 -0800 (PST)
Received: from 127.0.0.1localhost ([148.252.132.245])
        by smtp.gmail.com with ESMTPSA id e7sm1079861wrg.31.2021.12.07.12.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:16:45 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH 5.16] block: fix single bio async DIO error handling
Date:   Tue,  7 Dec 2021 20:16:36 +0000
Message-Id: <c9eb786f6cef041e159e6287de131bec0719ad5c.1638907997.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BUG: KASAN: use-after-free in io_submit_one+0x496/0x2fe0 fs/aio.c:1882
CPU: 2 PID: 15100 Comm: syz-executor873 Not tainted 5.16.0-rc1-syzk #1
Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29
04/01/2014
Call Trace:
  [...]
  refcount_dec_and_test include/linux/refcount.h:333 [inline]
  iocb_put fs/aio.c:1161 [inline]
  io_submit_one+0x496/0x2fe0 fs/aio.c:1882
  __do_sys_io_submit fs/aio.c:1938 [inline]
  __se_sys_io_submit fs/aio.c:1908 [inline]
  __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

__blkdev_direct_IO_async() returns errors from bio_iov_iter_get_pages()
directly, in which case upper layers won't be expecting ->ki_complete
to be called by the block layer and will terminate the request. However,
there is also bio_endio() leading to a second ->ki_complete and a double
free.

Fixes: 54a88eb838d37 ("block: add single bio async direct IO helper")
Reported-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index ad732a36f9b3..8d329ca56b0f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -340,8 +340,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	} else {
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_put(bio);
 			return ret;
 		}
 	}
-- 
2.34.0

