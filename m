Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C19C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754F16121E
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJTTDS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhJTTDO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 15:03:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1729BC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:01:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r18so167281wrg.6
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jieLNTWmzrvLHzQZ3McWX3OLp16MhU3QtUbl4LNofiE=;
        b=ICNNmSZC0z1QFIo3+zfUIFL9M5OKZERToiGngwwDjkbnSBWJySNFagH7FV1Bv47Npb
         QcDqSzqnnAE4z0RrxmTSFmup5FKmqijLAyX90N6WGNPOWeXA/+/rIX5ayf63m2LCe36W
         rZmfAl1QnLZv6oNOurVExzRe21nZxwNzhefbOdTCn0Wyhw2YjDlUosMhepynaGgXM4XT
         cwJYwS7zSWYEJO0vi7KQK/0uiViKLhzO+P5bGVlRanvQ6RRUbiZFMshNfd6AWdFtH6wT
         2yi77XG1Zw5Z7VEPJ0qyyf/q9OYuuIfMrdU77DidjhNJZ36tjrFLzmGqBpkcjKph3gsg
         NOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jieLNTWmzrvLHzQZ3McWX3OLp16MhU3QtUbl4LNofiE=;
        b=g4l3iJ5YV1n9ZWk+63ZEPMLjbt1tETbV4lzn3c5xSZBgI3Aeat95+Y7M6mE9M3i9X5
         uIsiQFgdCFg+Dk9FCp7wDz4dJoUiWJxmyRBdvp4z/fR85Cl6q1haiiWk0dD51qSPXZUP
         9Z/bViZTMlIQhEHq4KNHxJN4bPGWUuONLNCknu4DrKQEC56IH5riAGkkXHtekO7qOsBH
         iSdm/+1YvNDnuRvky43RUdDE7K53AXG0kW9Wq7k+ImWFb0u00a9F2HQljVMVwHk50CUW
         PuCEyF8WeEZ8wbAy8BqqkKt753bfmjQp9UcTtqOpm0R0wZKjeq/XKLr89mHIIkn850Kd
         Tt3Q==
X-Gm-Message-State: AOAM531DamaCU/uS7YUxzoSj7JmPpDmPeFh8svl+spDpC1t3cfQpXUB2
        GqOYgD8yZaQsGt/JbeV/Bukw2Xq9vxHBGw==
X-Google-Smtp-Source: ABdhPJwzXru6U8FURPjsyw4EyCb7WBWGZJdkTlPi+xaGNO8CPgnAEUvLGyX4j+fubHtbAmJIBDSSOw==
X-Received: by 2002:adf:9791:: with SMTP id s17mr1269466wrb.122.1634756458283;
        Wed, 20 Oct 2021 12:00:58 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id j11sm2743880wmi.24.2021.10.20.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:00:57 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] block: optimise boundary blkdev_read_iter's checks
Date:   Wed, 20 Oct 2021 20:00:48 +0100
Message-Id: <fff34e613aeaae1ad12977dc4592cb1a1f5d3190.1634755800.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634755800.git.asml.silence@gmail.com>
References: <cover.1634755800.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine pos and len checks and mark unlikely. Also, don't reexpand if
it's not truncated.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

