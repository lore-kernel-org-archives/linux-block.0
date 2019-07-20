Return-Path: <SRS0=aPd3=VR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C8C76188
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3039720873
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 14:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BXLmyn6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfGTOpM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jul 2019 10:45:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfGTOpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jul 2019 10:45:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so15680015pgp.12
        for <linux-block@vger.kernel.org>; Sat, 20 Jul 2019 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iOpyKl3OvQzjxMEarGutJN7T21363nKRMIqZYIkKSuU=;
        b=BXLmyn6O0r7X/V/l1j0827qnBmHzcCIaau1i17RwOM8KttHPRSD3ikrjlDhhcjXmew
         b4trLhZap8+LfpiPWadExaFdymJ3+CEK+Z8sMLEOA/r5wKqGGw85Oux1HGppOUxI7qJa
         V68angrYi3bDUxR/KMlFiZ//3d8rfNLVmy2z4ZQxIZo+tANRMc+CkymmauNjIVYQ4/N5
         ArbEaj4lzi37t1IVG7sNFGchNnNnFdeMqqjCWMoNOy/LXt7fH/PS/VGfshUubF3SZYkY
         sDWgcUYWWPluXz9qqBuFkpB8O7MHk+UXr/y5B4ObRn416nHe8FDVKkVWCIeFOESdxsX5
         hYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iOpyKl3OvQzjxMEarGutJN7T21363nKRMIqZYIkKSuU=;
        b=IydNIJtU9XwqaPYEkMKjurjhQlnOp/LGvPkbHWKOqWAMHLib6uz3YeMDLMoUOsm6QA
         ox91XuZw4Ikkd4TKORw33LOUvuKJLKFR8fCLkzIzA+31+CyWb1xsvx+Suzc6rg/y7+sm
         D8xoxr0+L4cX2braqR24hivP8qQO7Dy13BzCW6kQY8FZ7wcKQPkmmyGoIGqlhBM8Uit6
         dVMy0yJJa+Pfr14cj+z8pD5oPTTdqECNWzh6/vzV7bwzFebTv2dlSmMSLO8QAtdqjPPB
         tejYulamDZzFNdZlgLeBte0uJLLxpk2Xs2HT/e7nQxoH+lWSAcpfn1pI1F8QIDK0+cQ8
         PCmA==
X-Gm-Message-State: APjAAAV4co4JMzctPproHpQiy2f8a+lTchJOg+VTjzQNUWJQtdx2Fttq
        vvpDG1hlYOgNwUJyFyUKLik=
X-Google-Smtp-Source: APXvYqxLyd555szeEKMvrQIChm3o/FNvuiBfAoVvCgaHX23YzrTI4QSr+ChHgFuGFw3xaWGN/7ugpQ==
X-Received: by 2002:a65:43c2:: with SMTP id n2mr60193854pgp.110.1563633911381;
        Sat, 20 Jul 2019 07:45:11 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id p2sm47202730pfb.118.2019.07.20.07.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 07:45:10 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: don't use iov_iter_advance() for fixed buffers
Message-ID: <d13f2023-4385-cb30-46d4-a2221d5b6267@kernel.dk>
Date:   Sat, 20 Jul 2019 08:45:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hrvoje reports that when a large fixed buffer is registered and IO is
being done to the latter pages of said buffer, the IO submission time
is much worse:

reading to the start of the buffer: 11238 ns
reading to the end of the buffer:   1039879 ns

In fact, it's worse by two orders of magnitude. The reason for that is
how io_uring figures out how to setup the iov_iter. We point the iter
at the first bvec, and then use iov_iter_advance() to fast-forward to
the offset within that buffer we need.

However, that is abysmally slow, as it entails iterating the bvecs
that we setup as part of buffer registration. There's really no need
to use this generic helper, as we know it's a BVEC type iterator, and
we also know that each bvec is PAGE_SIZE in size, apart from possibly
the first and last. Hence we can just use a shift on the offset to
find the right index, and then adjust the iov_iter appropriately.
After this fix, the timings are:

reading to the start of the buffer: 10135 ns
reading to the end of the buffer:   1377 ns

Or about an 755x improvement for the tail page.

Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2f97a1204df6..040a4b727069 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1066,8 +1066,44 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	 */
 	offset = buf_addr - imu->ubuf;
 	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
-	if (offset)
-		iov_iter_advance(iter, offset);
+
+	if (offset) {
+		/*
+		 * Don't use iov_iter_advance() here, as it's really slow for
+		 * using the latter parts of a big fixed buffer - it iterates
+		 * over each segment manually. We can cheat a bit here, because
+		 * we know that:
+		 *
+		 * 1) it's a BVEC iter, we set it up
+		 * 2) all bvecs are PAGE_SIZE in size, except potentially the
+		 *    first and last bvec
+		 *
+		 * So just find our index, and adjust the iterator afterwards.
+		 * If the offset is within the first bvec (or the whole first
+		 * bvec, just use iov_iter_advance(). This makes it easier
+		 * since we can just skip the first segment, which may not
+		 * be PAGE_SIZE aligned.
+		 */
+		const struct bio_vec *bvec = imu->bvec;
+
+		if (offset <= bvec->bv_len) {
+			iov_iter_advance(iter, offset);
+		} else {
+			unsigned long seg_skip;
+
+			/* skip first vec */
+			offset -= bvec->bv_len;
+			seg_skip = 1 + (offset >> PAGE_SHIFT);
+
+			iter->bvec = bvec + seg_skip;
+			iter->nr_segs -= seg_skip;
+			iter->count -= (seg_skip << PAGE_SHIFT);
+			iter->iov_offset = offset & ~PAGE_MASK;
+			if (iter->iov_offset)
+				iter->count -= iter->iov_offset;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1

-- 
Jens Axboe

