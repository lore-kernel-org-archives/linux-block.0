Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF988C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C01604AC
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhJYJth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhJYJtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:49:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E4C061224
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so7513050plq.11
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av0r/rjVqFrB/l7qERXJM+4hS0XcNVLfoNKN5vMbJNg=;
        b=xOAqkrP0HrjsX48+je+o53PG2YVd8dM2nPjkvA1GW931f3/u7jXAHVCpoirZqe/36e
         0c6Ip65FUEezJbZXUhHsUzj7F0JGLaN4ZicNmtyiwJ2XjoQLaqHWtvZqyLm1ZKPFDh8x
         BTqcsT9KpbdcR7+ciDxVM2Ozoo5HpLIqiINTiDwMtVjySAEdH3tnObnRRyGJKaK7moQd
         wONL20McEcBXVnYZEq/zpPPd8SO0P7nLHHiRDXcKywelGZVbnTkdC6oV12p2hi4LsrCs
         NRFJct9KJnUoD0ImCkW+qfum8v/iHMrh6jxRBWTqDVtogoK+K9v4/XJrltN2HyBxfWuT
         fypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av0r/rjVqFrB/l7qERXJM+4hS0XcNVLfoNKN5vMbJNg=;
        b=b990aQSNAYT8ReAlS+ZkT5TAQ8BF44LLcJOZRUqPo8iU4xJottahvjv3MqoPjLLWNO
         /wkQ3rVODk7cLV+kJFEhJ1IyBvJqv3ktsv7x4yHefES3jKkZ33ORpr5DmJLfoVhyCYWF
         44rcWOjaVcdvraFit0wcGZq+jJfIdsXN50YfCKxZlEx9kDte4kA28rIJpirJ8yMTf2dR
         7PB5n8NTXJNn4Sj0zX5WpCtWrs0vDbckukPoUlDMCVf9jbLFKINGJo+I5c7dFm/PYAWt
         SWXe81ly6gtAUmS1zYjSfM5pmg9iyPION6f+QdizTriZJHsaz2szl/eggNe7pOJDyvKl
         AOsA==
X-Gm-Message-State: AOAM531jmPyF5w3FPODlULlgmy8WnSL4S8poJ/L1x8ADwAWLpFn76j53
        BYr3smHL6O8H5uQ55LPIGeNi
X-Google-Smtp-Source: ABdhPJy6XTgail4CfgzGrXE97eq+6+UO+3FgXOYxCk4f+rRZvdp0T/8Yqnm08YBSmOhKEQoi7f/JyA==
X-Received: by 2002:a17:90b:1d08:: with SMTP id on8mr34553738pjb.25.1635155156410;
        Mon, 25 Oct 2021 02:45:56 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id oj5sm7404319pjb.45.2021.10.25.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:45:56 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 3/4] loop: Use blk_validate_block_size() to validate block size
Date:   Mon, 25 Oct 2021 17:43:05 +0800
Message-Id: <20211025094306.97-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025094306.97-1-xieyongji@bytedance.com>
References: <20211025094306.97-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove loop_validate_block_size() and use the block layer helper
to validate block size.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/loop.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..dfc72a1f6500 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -273,19 +273,6 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 }
 
 /**
- * loop_validate_block_size() - validates the passed in block size
- * @bsize: size to validate
- */
-static int
-loop_validate_block_size(unsigned short bsize)
-{
-	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
  * loop_set_size() - sets device size and notifies userspace
  * @lo: struct loop_device to set the size for
  * @size: new size of the loop device
@@ -1236,7 +1223,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	}
 
 	if (config->block_size) {
-		error = loop_validate_block_size(config->block_size);
+		error = blk_validate_block_size(config->block_size);
 		if (error)
 			goto out_unlock;
 	}
@@ -1759,7 +1746,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	err = loop_validate_block_size(arg);
+	err = blk_validate_block_size(arg);
 	if (err)
 		return err;
 
-- 
2.11.0

