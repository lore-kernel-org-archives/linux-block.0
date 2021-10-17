Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEEFC433FE
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B538E60F6F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbhJQBkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244790AbhJQBkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC4CC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s17so12140951ioa.13
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WTC+xPmGleKsJJr9wn3PUo4M9NVD4IQgB+kOuNx48Y=;
        b=vie/4XpYIeo9XAcZZJtanDRw6EnMI9sbL6xmesWHAWFFcJpn+oy/jbD+1UAWcbKfnR
         0t+1NOprsmu569H+Xjjk8M/EDfLvC4yNhZiS2ShdKcLu8auYmO50BJyYpCxIYIFg9BAt
         jZhiGUU6G5+V3UtgA/KuFhL9ZGH5170VQvLIOHWZxa3re3WGQZm7bN2zQ8u/umbnq9bd
         HulmgMf9X0opeMyN0d+mn5Jnxqzqh/Kf4SDHYKPwYND0sFs6RPDQpGVeQ7RMfK6MEK1A
         XiXKXWz9P08+KSJI39YTgA6anbrkcLHG9YP3Ml0EnqKnvCbYd9Y8KcrBfnhTjkpBKZXP
         gQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WTC+xPmGleKsJJr9wn3PUo4M9NVD4IQgB+kOuNx48Y=;
        b=raaWc4IUbIH+ZVXhWkJq7t1QFLmc/m/QcEHf9Vo7XqCLGeNe4A2eRErBnsjJLMS33C
         nqJY0/oPIRWRlIxCDhqekEQs2NjT6CHTZMp7Hibw+mpR6LC3qq/pabE1Mp6MRqyKaGvr
         eakG9cZ/uu5FbmSNn6eg1cr5c3XOWvgJoBwHv+QWYrS4we3eqIFdCmBGNuEKDjc/8Qyl
         hthGP7LjdzhobniRSwD+06W7wcXZouhCF6hJVugX+/rAwnelZQKCNxAMt62MDIrVGtax
         2vnPPGaN/hr7u8BWqo5wjxeNZm2jJXbr7ef0GwLfJCiDYu0B1xR9iSQkfH/KaZFrrKZ1
         Seyw==
X-Gm-Message-State: AOAM533Qc8Ll68XD/FecDdm6Ka2ElHtinxGl1cb68c9E3OPT3Tte8qU1
        HMnjYT7aykVh2Gexx4HFqHKWd2+lVVJOng==
X-Google-Smtp-Source: ABdhPJygUntO9Srr19wt2XYmiUwn/zX1ADDtIQqPBQaCIZ2fZXHku9r2IQ+WgPBXaoIa9xj9YZNF9w==
X-Received: by 2002:a05:6638:134f:: with SMTP id u15mr13365938jad.145.1634434674981;
        Sat, 16 Oct 2021 18:37:54 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 05/14] block: don't call blk_status_to_errno() for success status
Date:   Sat, 16 Oct 2021 19:37:39 -0600
Message-Id: <20211017013748.76461-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only need to call it to resolve the blk_status_t -> errno mapping
if the status is different than BLK_STS_OK. Check that it is before
doing so.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ffccc5f0f66a..fa5b12200404 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -676,9 +676,11 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 bool blk_update_request(struct request *req, blk_status_t error,
 		unsigned int nr_bytes)
 {
-	int total_bytes;
+	int total_bytes, blk_errno = 0;
 
-	trace_block_rq_complete(req, blk_status_to_errno(error), nr_bytes);
+	if (unlikely(error != BLK_STS_OK))
+		blk_errno = blk_status_to_errno(error);
+	trace_block_rq_complete(req, blk_errno, nr_bytes);
 
 	if (!req->bio)
 		return false;
-- 
2.33.1

