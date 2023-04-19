Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D52C77B78
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjDSQIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjDSQIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 12:08:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B27113
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b621b1dabso15587b3a.0
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681920484; x=1684512484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yig2yzZEbAOAAe0JyonvM0JghOyicJfE8C/+0HCK1lk=;
        b=DeWkNtuqPTtyiz1xD9xydHtV3qfk9uUmEFsjCCRs/4FOZDa2ymQtoKYky1TaCo3VsN
         K6o/Nhlz0c6bhsKlx7LVF4x/zv2tP/LQOJZBKbHPsmwIuoA5sw8krZOQ/gCaoPWSwO3+
         UJ5GmLioZu7zaSfDkRSzrLFh5xUe7XzVHjUdUbMBvzsk5PrTfUJmZw9HyO5D5IjCIP6D
         Q7Ex5XNKKj8SJgOgBGwIY9ltpnpS1nq3njykrcgcPbBQXasZsWKXx5YTnDuCURmbB2Ei
         FtbPjUs4f6Ablq0fMnpv8ZnIZKFj5XV6o7SjWKp8mItH+L2YvUCKILJhsfCU9JSYix4A
         ht2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920484; x=1684512484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yig2yzZEbAOAAe0JyonvM0JghOyicJfE8C/+0HCK1lk=;
        b=HWQ+61e2ysuBn8k7kuxVIixblUD8KXFQrKUALeFQMpB61pMb1LFhjRf1YmLZZEge+7
         ve47UdJEQBpD3zk6VlcRBYbSeqm7SgCRrAH/pHC1E+BkpYIdtI+1aJVNJHpXdKRLB38M
         js3EQRhAALyKe3ALnQgTyWk6XdNk1yJq+b5UmpMRFMS1yy8vbITQEP08nQR0V4ES8MKI
         PJcvZIkPzFahoBN2AEbNIU2JcXGa4cBmmx61zVMLOqG+42q40P6nYiY7ku9y7RaOd5GB
         xbHA0iz92qTLl22ly2mNiXWr8ry/aLf4F9FXR/bMylu7bRgaFarjq1c+5pnfuGaJmVIl
         EpVA==
X-Gm-Message-State: AAQBX9cfNvAEV2A2ZHnqbfSaQY8z7+1UoP3/RtpAbK/T3KYByr+q0rft
        9A7JJyUMVwQrYY5qUH0rUu/sT4/GLxNEiPzb9XU=
X-Google-Smtp-Source: AKy350ZciVqXct423XDE6lR0esPN4tI3W5VGePhZ5SO5efegfMfN2SyJJDxQygvxuUMMaM7QqEKP3Q==
X-Received: by 2002:a17:90a:1a17:b0:247:9e56:d895 with SMTP id 23-20020a17090a1a1700b002479e56d895mr8513454pjk.1.1681920484199;
        Wed, 19 Apr 2023 09:08:04 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik14-20020a17090b428e00b00246f9725ffcsm1566258pjb.33.2023.04.19.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:08:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     luhongfei@vivo.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] io_uring: move poll_refs up a cacheline to fill a hole
Date:   Wed, 19 Apr 2023 10:07:55 -0600
Message-Id: <20230419160759.568904-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419160759.568904-1-axboe@kernel.dk>
References: <20230419160759.568904-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After bumping the flags to 64-bits, we now have two holes in io_kiocb.
The best candidate for moving is poll_refs, as not to split the task_work
related items.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/io_uring_types.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 84f436cc6509..4dd54d2173e1 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -535,6 +535,9 @@ struct io_kiocb {
 	 * and after selection it points to the buffer ID itself.
 	 */
 	u16				buf_index;
+
+	atomic_t			poll_refs;
+
 	u64				flags;
 
 	struct io_cqe			cqe;
@@ -565,9 +568,8 @@ struct io_kiocb {
 		__poll_t apoll_events;
 	};
 	atomic_t			refs;
-	atomic_t			poll_refs;
-	struct io_task_work		io_task_work;
 	unsigned			nr_tw;
+	struct io_task_work		io_task_work;
 	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
 	union {
 		struct hlist_node	hash_node;
-- 
2.39.2

