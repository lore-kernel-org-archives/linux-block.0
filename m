Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C7C433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF5361027
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhJRRx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbhJRRx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75BC061765
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n7so17352541iod.0
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlhkTVMRTDUIg6xLkz4mvLFJzbvrzB5LrVKzz1g0kp8=;
        b=q7dIawP9BMGEUvv0nz3zPT66kOxfZ+7PLCOG8Z5ZmdlL1dFDEHcndYGVf45pKY5GXv
         Knoj1wtYK1I+a3ICzhzwEzJCwqY6qZeqCQQI/kcWqo0KxOn+MQKoa1rYBURntA1Dnsfv
         VDpyRuoCrgll8s8pOhl0z4jda7FOt8ezjaOiwW73AYRSaQnQ2gJAWaczQ77bIho4kc6F
         tlPf7Tp+rQe8ClG79Bwg9ysV3kkoKkM1wuUDuhr7UOjzNM2UWYZkOaYyqNQdIP7DWkwr
         YVwK0DCatLhUzETwyQqLqHJyo3YjJfoXiDWGa0Quk/nF+5MTetA4AcEJ4xJ/lM4OQs3U
         plEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlhkTVMRTDUIg6xLkz4mvLFJzbvrzB5LrVKzz1g0kp8=;
        b=yyGYaCN0/uMgKqw9rbWdqghIFrFL3Zh9uDTVwuRRoxyjpuy+wiNJxY3iEJvswCF6S6
         CwqoJk+uZFk1IE0Jll47nxB71gmUaGr9TMRJVAYZUGFSucYR2qR0NssPQri3jqnGjcfD
         lZyzaQFDtYSK7IJxJOQybCQKZlb2C85kzx4pHnU/jXIo/kUPBS9LNgsDmGPGV7IQQqX1
         6U63SsHmRZIqWBkKwneY/t7zOWf39KdV6EOcgYrg4GhAnMdCqEQl1nN/hPRQWqMtkQVo
         ZmSwO22j+93dDY0s1WpBY9tY1MvKIvkaFZa2x1Xe0aOUwKb8VjiPUN3KbqeSQJl1Qjhu
         g5Pg==
X-Gm-Message-State: AOAM5330d+LHGij4yDzNygtCTg1q76MYZRWau5IuRs+akhw0zy0xusay
        2+vkukeBr6q/B+LY9V8WYcfXqkCBTZA=
X-Google-Smtp-Source: ABdhPJw2D0VTGptY83uacStKNDIQi77yURzxzLQGUQuo+ogCij9iocKXK4u5PESrYMVs4Rf4u1/A/Q==
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr15696227iow.48.1634579475906;
        Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] block: align blkdev_dio inlined bio to a cacheline
Date:   Mon, 18 Oct 2021 11:51:09 -0600
Message-Id: <20211018175109.401292-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018175109.401292-1-axboe@kernel.dk>
References: <20211018175109.401292-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We get all sorts of unreliable and funky results since the bio is
designed to align on a cacheline, which it does not when inlined like
this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 2ae8a7bd2b84..e30082ea219a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -137,7 +137,7 @@ struct blkdev_dio {
 	size_t			size;
 	atomic_t		ref;
 	unsigned int		flags;
-	struct bio		bio;
+	struct bio		bio ____cacheline_aligned_in_smp;
 };
 
 static struct bio_set blkdev_dio_pool;
-- 
2.33.1

