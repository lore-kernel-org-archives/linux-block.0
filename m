Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFEB6128B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhJSTCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhJSTCE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 15:02:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05353C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 11:59:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so3521167ott.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KOdi8wISjQ00kcc1Bnp9kfXCk0uvrku3t9b/u6XOqxg=;
        b=bzI+1mZLiRzu5MKvsxv5tWo1BUH1qKXAAWQrv9LpwmrkA4OCzR8QdfOExiY//mLtFU
         pMu+N6vN5yOU3YMpIlSQdwWllm3q/GkUr6vN3Yzz9Ez61vNGcrUwdRnVhKiYzqL6QIAV
         77yoCd1fPgudZglSctJi8J4NxKLb7KkY4UKMg1pvVN5O31x6CdSg8X1fUN8GWhK0TYjJ
         n97hs4Foh7y3A5zJaViCu0Wmjlujr07R/J0GKh6QP0/P4/iN0xHuLxMLuaV6u6E3Umbn
         2oV5oHuMYIKHQqGlHtQyevBVxrXHvCRbk+ucqmfTYM2/fG2Fm+s6KI0LsGWZI0O3PdSc
         +5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KOdi8wISjQ00kcc1Bnp9kfXCk0uvrku3t9b/u6XOqxg=;
        b=F4dAcZkdT/ALjqLcfyXnNJ5ZMZlj6jluAkt4pi41iEMI1sZLyBt9NYlvaqCOkmXIlE
         6AeEfYOAFzht7NvQmamVBmVoR8k7966OxeLhVO/hLBdf0UCDQDqe7gIuvStb7wTYjYpS
         Rd4ggjTYSh83ydDIUrQN9OqwycFs1kMmFf5QZhBXnvreaolv25DXdm6E1pXYbp/TGvjG
         zKFlHTdJoYw04udv4FYjEP+KHhr2UWGCxr1CFtune8nFlnGobZ/yx+9GLdA9NOsu7VIT
         GJNtukhrXx5tk4UkuMB4W52eSzwKBKvOaKoadnKmbxN/4FiKdrvY5jL3ppa6W+4zCCpX
         SgPw==
X-Gm-Message-State: AOAM532MeIDvVoRLWtNdNoEMjTwCoKeMfat5mvy63S6OOgNOE9QC3kCq
        sqIX7PnmdcAI+S0j/mHTDIbl843zRcFx2Q==
X-Google-Smtp-Source: ABdhPJxbiKwrzbKOqIw5njnxSc/euq9JsVa3/2H7UClYJ28jSt4dTIkKdg788Di1bkveEtEJnwMfOA==
X-Received: by 2002:a05:6830:19d7:: with SMTP id p23mr6846648otp.33.1634669990147;
        Tue, 19 Oct 2021 11:59:50 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a15sm4195365oiw.53.2021.10.19.11.59.49
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 11:59:49 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: improve error checking in blkdev_bio_end_io_async()
Message-ID: <69df4731-3232-eb2a-664d-47d0db381843@kernel.dk>
Date:   Tue, 19 Oct 2021 12:59:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Track the current error status of the dio with DIO_ERROR in the flags,
which can then avoid diving into dio->bio for the fast path of not
having any errors. This reduces the overhead of the function nicely,
which was previously dominated by this seemingly cheap check:

     4.55%     -1.13%  [kernel.vmlinux]  [k] blkdev_bio_end_io_async

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/fops.c b/block/fops.c
index d4f4fffb7d32..21d265caecff 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -127,6 +127,7 @@ enum {
 	DIO_MULTI_BIO		= 1,
 	DIO_SHOULD_DIRTY	= 2,
 	DIO_IS_SYNC		= 4,
+	DIO_ERROR		= 8,
 };
 
 struct blkdev_dio {
@@ -147,8 +148,10 @@ static void blkdev_bio_end_io(struct bio *bio)
 	struct blkdev_dio *dio = bio->bi_private;
 	unsigned int flags = dio->flags;
 
-	if (bio->bi_status && !dio->bio.bi_status)
+	if (!(flags & DIO_ERROR) && !dio->bio.bi_status) {
 		dio->bio.bi_status = bio->bi_status;
+		flags |= DIO_ERROR;
+	}
 
 	if (!(flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
 		if (!(flags & DIO_IS_SYNC)) {
@@ -157,7 +160,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 
 			WRITE_ONCE(iocb->private, NULL);
 
-			if (likely(!dio->bio.bi_status)) {
+			if (likely(!(flags & DIO_ERROR))) {
 				ret = dio->size;
 				iocb->ki_pos += ret;
 			} else {

-- 
Jens Axboe

