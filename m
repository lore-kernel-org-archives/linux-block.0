Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AEFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2D260F46
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJSV0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSV0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C676DC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so5680196wmd.0
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dMfaSBYPSk+bqOWtfqC72fmmxN8NldhpDFxApBTDmM=;
        b=K2Yer8ogJ5WrVrbn5OtlNfXf6zwQ3t+Yi4+2+A+djLkLl6bFe2pFNq751DSxahRLpx
         xlNDFY7yGHnZuzNx0SJlCY1m5dJ0bOs7KYgF9H5YI6lOJLVFToDl0qPIrtEKjcvAJh/E
         F7RhzgjI9VOQj6u0DqCXBk6r8V/ZCIJjJNSECMNUOAjAy0mErcxaMScmeoDXucpbXsZr
         W4/R2CFlCQVadArfw//uv5qAeOhOJnomaQn6jCW7K3yfSN/Gl5DuUMZOzJU/9tkgFKjk
         2lvz1KIN2ydgG0A8f+DmoKDgfTof8X7ftBx0qP83c/EAwY9mRXdsYrwzbUcLilcaEUwN
         4TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dMfaSBYPSk+bqOWtfqC72fmmxN8NldhpDFxApBTDmM=;
        b=GdrW/+DT5ecUMldzN9NGN40DSjjRjmANFoQJpdQa2WWcO0TEAs9OpCi5/bn2IOiT77
         ytEcxqBCktFS88tP6Q4rOU03S5od+nB0NEPKEJRCRIc2qPaHnFPQj7itzoOyC1AmILNG
         y2CnU2oa5RpG9avw1gXfhxAVkXI7AUElfMxcUaKh4IRvJJJeh462rpnxu43pbLj0K07W
         IKna8VSzxGsrpCZm/9+sMYlvgaWd1GXrjPscdeG6D/oU6FwqbBQW7OJuZM5s9dLu0gYw
         nAlaxg0OQQJx7eAKBHAhqFg9GSGWgy2lgByKwimUDLUDnY+fvN/rfevHs8MZsF8rl53x
         rsWw==
X-Gm-Message-State: AOAM531TfpdZqFmFsBQQSiP/ncqcmptNBbWrzmyVUjkwUfni3WA0rPN6
        nwG4uiGFRyL/HrDt/TRJw3CB//lIKnN0Eg==
X-Google-Smtp-Source: ABdhPJyCySowCV0MDOyoTBOPNDEsgQ4Dh1IAcIJlF6HfqnHljq+MXfcdKjRso+Kkdr5vLO6hcHpQAw==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr8944155wme.41.1634678680236;
        Tue, 19 Oct 2021 14:24:40 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:39 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 09/16] block: optimise boundary blkdev_read_iter's checks
Date:   Tue, 19 Oct 2021 22:24:18 +0100
Message-Id: <d8660b783e2237063a00f671afcf17a30c2e2c76.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine pos and len checks and mark unlikely. Also, don't reexpand if
it's not truncated.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 21d25ee0e4bf..8f733c919ed1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -503,17 +503,20 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	size_t shorted = 0;
 	ssize_t ret;
 
-	if (pos >= size)
-		return 0;
-
-	size -= pos;
-	if (iov_iter_count(to) > size) {
-		shorted = iov_iter_count(to) - size;
-		iov_iter_truncate(to, size);
+	if (unlikely(pos + iov_iter_count(to) > size)) {
+		if (pos >= size)
+			return 0;
+		size -= pos;
+		if (iov_iter_count(to) > size) {
+			shorted = iov_iter_count(to) - size;
+			iov_iter_truncate(to, size);
+		}
 	}
 
 	ret = generic_file_read_iter(iocb, to);
-	iov_iter_reexpand(to, iov_iter_count(to) + shorted);
+
+	if (unlikely(shorted))
+		iov_iter_reexpand(to, iov_iter_count(to) + shorted);
 	return ret;
 }
 
-- 
2.33.1

