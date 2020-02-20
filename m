Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59DDC7619D
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A664421D56
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBTCo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:44:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41054 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgBTCo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:44:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so1141116pgf.8
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4GY3Fkj3YylXp9zuUe95CfCuLdtSRGv1bENxS7eu8k=;
        b=V5TqXChfyC9nK5gEXkIxCvWreupEV1xmTrKflZJjd4nALqtgH6KOsGtlzmOLnnFMoQ
         sv3zzajaTCHrt8RfjDMd/BEU4gjW/eCHVYvzjOu6YH4nNni6mk7Z73t42PlalknUBpxS
         4HvJ+B841k2EuZU8uJTzcoboLNx5m6uGqEVPTFXEEIdzi4QB7Wkux+7eRgWLfS4KbFHy
         q/h6bNbd0uD78X44c2C8NRuw6tJ7xlDDa31z5D7kmy4uvprRM9+G/ZxcFf2ClMcjiV4t
         u+lFC30Vfybrr5wxVVG2jlvGkLvhKGEp4420Hh08F/RzJKdOrDpTDMfd63z96KilO+EI
         0nSg==
X-Gm-Message-State: APjAAAUtXEGVVLu732ZnXN06qF1NFXKDMbAn8S689rav8FcmR310fN40
        Iu7R/jE3bHMrYua8R4pu0IU=
X-Google-Smtp-Source: APXvYqy0UK6n4q/N+hdCkRWxT+0TSKXluXhQScHU1PQ/f6yETP2Mj/R+d6ski8fjsmcoDkRe5yngsQ==
X-Received: by 2002:aa7:96b7:: with SMTP id g23mr29031021pfk.108.1582166697191;
        Wed, 19 Feb 2020 18:44:57 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:56 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 7/8] null_blk: Handle null_add_dev() failures properly
Date:   Wed, 19 Feb 2020 18:44:40 -0800
Message-Id: <20200220024441.11558-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220024441.11558-1-bvanassche@acm.org>
References: <20200220024441.11558-1-bvanassche@acm.org>
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
 
