Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA31C636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DBB613D4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhGOUdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:33:33 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36625 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhGOUd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:27 -0400
Received: by mail-pg1-f175.google.com with SMTP id a6so408953pgw.3;
        Thu, 15 Jul 2021 13:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HeWfeIkykuv+4j/IPlbH3R6G4wTll7HcXd68DpKeOE0=;
        b=XyHzzTVQC+but7gfQiMydTW2/LrViiA1V2RQ8+c2iIcCh+vwXOhJ2o+Tiv++PSdk9y
         NbsY3asJcdOaxkwc5b9ndBe7SfSXKg5rSAyoqRGH6rlX6A395FC4FtmP207QVQtP8o1H
         rg0xe5ioZOKROcGwfRaNmaMbBDY59JUX92fDO8TZsaxJ9qh8jyDGl+3FQE1HAcsoaZpm
         1N+EEi5elxMl8y+e1SiIngEglzrexrIJOwMs+mOvAE+J1DqFmWWa9RUJ43Sl+0lTJbH2
         EXE0fV12gUE2okcxukEp0L2ASDMbM36KT8wFG4CR8L0Pwuotwxe6k/b0nJMb4oAauSE0
         O7Fg==
X-Gm-Message-State: AOAM531f9Vv3g1BP35WxWnhagnig3llYe8MB7uKWnPeUwxdymc+XhT18
        OC4tClFcLhiTxx63dxhkc5Y=
X-Google-Smtp-Source: ABdhPJz87yr4Z3e5LzNClBk+NMWPxuueNWqFUykX/KbN7dhpdUVYGqpqPgvtzDBc7MLayRz2K5KeAA==
X-Received: by 2002:a63:d612:: with SMTP id q18mr6309107pgg.77.1626381033815;
        Thu, 15 Jul 2021 13:30:33 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id n23sm8220697pgv.76.2021.07.15.13.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:30:33 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 1/5] bcache: remove no longer needed add_disk() check
Date:   Thu, 15 Jul 2021 13:30:21 -0700
Message-Id: <20210715203025.2018218-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715203025.2018218-1-mcgrof@kernel.org>
References: <20210715203025.2018218-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After the patch "block: add flag for add_disk() completion
notation" we no longer need to check the disk was added prior
to calling del_gendisk(), del_gendisk() now deals with the
check for us.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/bcache/super.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 185246a0d855..70ee7a22b2a3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -885,11 +885,7 @@ static void bcache_device_free(struct bcache_device *d)
 		bcache_device_detach(d);
 
 	if (disk) {
-		bool disk_added = (disk->flags & GENHD_FL_UP) != 0;
-
-		if (disk_added)
-			del_gendisk(disk);
-
+		del_gendisk(disk);
 		blk_cleanup_disk(disk);
 		ida_simple_remove(&bcache_device_idx,
 				  first_minor_to_idx(disk->first_minor));
-- 
2.27.0

