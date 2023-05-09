Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C93C77B7C
	for <linux-block@archiver.kernel.org>; Tue,  9 May 2023 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjEIPTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 May 2023 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2023 11:19:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E149D3
        for <linux-block@vger.kernel.org>; Tue,  9 May 2023 08:19:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-763970c9a9eso21004039f.1
        for <linux-block@vger.kernel.org>; Tue, 09 May 2023 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683645556; x=1686237556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/jkxiCP4JthB71tD2UnyEZpZa4CleF0O3E0hHUUj2s=;
        b=J6MxwIbuqm1FKPUVMo9wqx01RiXxThePQKhHVy9j81JKUdegB1fL4DBWREmXRH+rZ4
         qZv7P7RINWlFaZ9Cz2qLfTP+9QGOotFhAcP7QnL/KU4QbjumB5po5OqR0GoygqKGuKwI
         RoKETRjpu8bcVE3sGs+IFxNkdLn7MCCl0Tr8Nvhdl+zLaxgboAdYFeozzfYSosKLTwd+
         /3rbddUSD0rRtgtrW9G+Rzh1nKJOIgE3BVmWzJnTXWrrNtj2Na2rkwJhm3kYupLgJWyB
         5RdTqpFXpXCg0swOFL0t3sOa7xXLTcFEUV/F43oTl/uTDNmqYjL8NLdBl4re/AS8bXL9
         vR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645556; x=1686237556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/jkxiCP4JthB71tD2UnyEZpZa4CleF0O3E0hHUUj2s=;
        b=HJL/tHPqWxUq+oIlPryXhayEODtg+xaADtnDHBkAI8j2mD8YLVoqVQcEqHL7MZ6lAi
         YBYxRBYIaOWvCVPTLHmzqwBjWo0mpJBc/szI/r0SQj49dT7MZecWJcLMsiUO1axEh5IZ
         90oJ0gu7Mp+YJfhDlZBV0zasnm3u0w8wRTjbS7SitgiCAW8YWf68DYR4yLrjnKGlqYWb
         viYfHx5fHutd99+0L5I8j3YDdBiMTLkCNR1rsEMoq0eG1wWUCbX/xxoi+SHppoYYG36d
         mLWWV5RmCL/ec8iK4V3gs3Mcaz+LSNYAEuQ+EHk5zSCrLURe55CUa18Itrl+rwpCS0/e
         beOQ==
X-Gm-Message-State: AC+VfDzItyknajEinypKdR00S9QUws1vNSh4h+NiQc6rl149sxgiHdyv
        miPhrgEFsmehrUrGtioUjCY37A==
X-Google-Smtp-Source: ACHHUZ42L5EZpZexHnQ9E+vXfaofOXLtZIeIku+36oDtyPUueapg5a63UVr1ieq5fEbsZx2fBD0DhQ==
X-Received: by 2002:a6b:5f09:0:b0:760:f7e4:7941 with SMTP id t9-20020a6b5f09000000b00760f7e47941mr6891056iob.0.1683645556246;
        Tue, 09 May 2023 08:19:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z1-20020a056638240100b0041659b1e2afsm677390jat.14.2023.05.09.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:19:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: mark bdev files as FMODE_NOWAIT if underlying device supports it
Date:   Tue,  9 May 2023 09:19:09 -0600
Message-Id: <20230509151910.183637-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509151910.183637-1-axboe@kernel.dk>
References: <20230509151910.183637-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We set this unconditionally, but it really should be dependent on if
the underlying device is nowait compliant.

Cc: linux-block@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/fops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..ab750e8a040f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -481,7 +481,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	 * during an unstable branch.
 	 */
 	filp->f_flags |= O_LARGEFILE;
-	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
+	filp->f_mode |= FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
@@ -494,6 +494,9 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	if (bdev_nowait(bdev))
+		filp->f_mode |= FMODE_NOWAIT;
+
 	filp->private_data = bdev;
 	filp->f_mapping = bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
-- 
2.39.2

