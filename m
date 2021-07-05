Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C6FC07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBACC613F3
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhGEK31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhGEK31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625480810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BrkLOCtCzVcIGqvUpk0aa6rOPOX2Lie6Hami/3J/0M=;
        b=H/M3xB6n1Gs8neatJrxo0F5vMAN31bnMLPvLGDSN6VvwH+/0132foXX5fkjusXilXIzLrn
        1xKpxMyptJTeIEvCZ2XKxMJMY1ntjYujW5ITKPjeK0i5Bg8pgluYjt5tUNxgAHaqAXZ9/v
        wS978WVd6szD1/Xll/JykDYzizZ1/8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-IP7ry_Y2M9uMqCyHtWJvUQ-1; Mon, 05 Jul 2021 06:26:47 -0400
X-MC-Unique: IP7ry_Y2M9uMqCyHtWJvUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52D3100B3AE;
        Mon,  5 Jul 2021 10:26:45 +0000 (UTC)
Received: from localhost (ovpn-13-193.pek2.redhat.com [10.72.13.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30D4D5C1A1;
        Mon,  5 Jul 2021 10:26:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 4/6] loop: improve loop_process_work
Date:   Mon,  5 Jul 2021 18:26:05 +0800
Message-Id: <20210705102607.127810-5-ming.lei@redhat.com>
In-Reply-To: <20210705102607.127810-1-ming.lei@redhat.com>
References: <20210705102607.127810-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid to acquire the spinlock for handling every loop command, and hold
lock once for taking all commands.

Cc: Michal Koutný <mkoutny@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b71c8659f140..1234e89f9e37 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2160,21 +2160,26 @@ static void loop_process_work(struct loop_worker *worker,
 {
 	int orig_flags = current->flags;
 	struct loop_cmd *cmd;
+	LIST_HEAD(list);
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+
 	spin_lock(&lo->lo_work_lock);
-	while (!list_empty(cmd_list)) {
-		cmd = container_of(
-			cmd_list->next, struct loop_cmd, list_entry);
-		list_del(cmd_list->next);
-		spin_unlock(&lo->lo_work_lock);
+ again:
+	list_splice_init(cmd_list, &list);
+	spin_unlock(&lo->lo_work_lock);
 
-		loop_handle_cmd(cmd);
-		cond_resched();
+	while (!list_empty(&list)) {
+		cmd = list_first_entry(&list, struct loop_cmd, list_entry);
+		list_del_init(&cmd->list_entry);
 
-		spin_lock(&lo->lo_work_lock);
+		loop_handle_cmd(cmd);
 	}
 
+	spin_lock(&lo->lo_work_lock);
+	if (!list_empty(cmd_list))
+		goto again;
+
 	/*
 	 * We only add to the idle list if there are no pending cmds
 	 * *and* the worker will not run again which ensures that it
-- 
2.31.1

