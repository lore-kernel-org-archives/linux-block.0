Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23844C11D24
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDB0222C4
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgBUDXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:23:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgBUDXE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:23:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so444146pfp.13
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4GY3Fkj3YylXp9zuUe95CfCuLdtSRGv1bENxS7eu8k=;
        b=F7XKcvzl/EMtb7Z+J0mjI5WAHvWdX8pbRFGoanzzu3/ET6HzgYUhQOH8JcQbW/+hs/
         aHDMcMGn7lj2edAOhg/wXnHCykmPk3HCzrEJGgbQilE1TMi9/w8IHqGkb+qXTq8Zq63l
         zQVoa36u+BmKCmZaK80BeNftzDgx7gJAuvoIVhERXr87LQsB6r3R3wAiIspSa9tDmzy3
         uR7WmFNrTNbEeMErMpVIKUG7KAAPO6wb7VBk7fJsqy3U9t1vU2Glxx00WXTbfECDQViW
         dzJ2F5DXsYWBP3/lnOrV9acbAw1LyQgqhgdrx0rralrrP60bTwdH1Z0AEI2W6sXaTuXe
         6RyA==
X-Gm-Message-State: APjAAAW2y/elGQIXfbYI2Fi+O+P7/PaMQm7k7Jx2Pz/GF9orUFyhfXhX
        fCL/WSbehf2jr2UISzkhEZ4=
X-Google-Smtp-Source: APXvYqyCpLR90mRPmAZg65Q0xQ3hI5xSgmuo/0YxP0ry3FEagMuAimVlqbQCxLujodeFN7JWj7sZoA==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr17468607pgk.93.1582255383600;
        Thu, 20 Feb 2020 19:23:03 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:23:02 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 7/8] null_blk: Handle null_add_dev() failures properly
Date:   Thu, 20 Feb 2020 19:22:42 -0800
Message-Id: <20200221032243.9708-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221032243.9708-1-bvanassche@acm.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If null_add_dev() fails then null_del_dev() is called with a NULL argument.
Make null_del_dev() handle this scenario correctly. This patch fixes the
following KASAN complaint:

null-ptr-deref in null_del_dev+0x28/0x280 [null_blk]
Read of size 8 at addr 0000000000000000 by task find/1062

Call Trace:
 dump_stack+0xa5/0xe6
 __kasan_report.cold+0x65/0x99
 kasan_report+0x16/0x20
 __asan_load8+0x58/0x90
 null_del_dev+0x28/0x280 [null_blk]
 nullb_group_drop_item+0x7e/0xa0 [null_blk]
 client_drop_item+0x53/0x80 [configfs]
 configfs_rmdir+0x395/0x4e0 [configfs]
 vfs_rmdir+0xb6/0x220
 do_rmdir+0x238/0x2c0
 __x64_sys_unlinkat+0x75/0x90
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 9846648780b6..ba83fd0537ce 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1469,7 +1469,12 @@ static const struct blk_mq_ops null_mq_ops = {
 
 static void null_del_dev(struct nullb *nullb)
 {
-	struct nullb_device *dev = nullb->dev;
+	struct nullb_device *dev;
+
+	if (!nullb)
+		return;
+
+	dev = nullb->dev;
 
 	ida_simple_remove(&nullb_indexes, nullb->index);
 
