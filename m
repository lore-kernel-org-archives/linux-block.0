Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF44C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FF72467D
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCJE0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:26:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38949 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgCJE0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 00:26:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id s2so5728516pgv.6
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 21:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzlOKrcv2Oe/XzzP6feQVhs2X9Bl/DPBL5XHFlPOVT4=;
        b=sw+iwCkgVK55onAxkg0Y11mpHW/8B1iUNKAH4PBREFT716vkP+yQgX3E5KpbjRLzw9
         90FiZDFtQsjInpsPrgLN/Fpu/rKcSQLX2uPveZ8en1PG/399WUpN3LCuhv/wms1XsAM/
         amPMlMSUFUzocGUp9ZlUQWJ6uhiKZekr7AseCQ6YD3Jj9ZY503vSNL/qPqyRS3StI7ZF
         iy1jtnE9Fq21FsF4+4k39F8XRwFajwwavkOP8+DGL1yaI/823pOR1222wBE8mswVdj/4
         ChMTuX3Qli0YK9k9WeUJ7+hvW1jGVbSGM5zW+uZkzHpvZawyhAvR4mU+lEH+FQgLsP8E
         N95A==
X-Gm-Message-State: ANhLgQ1kXbrLxljIlRVeGQlQYcUS1BFwV+eXjW4nUN6CnZKxgZAFrcib
        szMsHj64Fn2aU8HdeHKCPLU=
X-Google-Smtp-Source: ADFU+vs7YOFt7+yv4k8GafzbTijftZDi38oKlPg+vmxJXW/t16zogIi98+gR7awjfPU0hmNM5wVsJw==
X-Received: by 2002:a62:64c9:: with SMTP id y192mr2877289pfb.26.1583814402023;
        Mon, 09 Mar 2020 21:26:42 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c0e4:71da:7a83:2357])
        by smtp.gmail.com with ESMTPSA id l189sm5963240pga.64.2020.03.09.21.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:26:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v4 7/8] null_blk: Handle null_add_dev() failures properly
Date:   Mon,  9 Mar 2020 21:26:22 -0700
Message-Id: <20200310042623.20779-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310042623.20779-1-bvanassche@acm.org>
References: <20200310042623.20779-1-bvanassche@acm.org>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 80d3dcb8722c..d21c82c8863f 100644
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
 
