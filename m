Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D4DC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1C82074B
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 07:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSzQ9wyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgFKHXJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:23:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45206 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbgFKHXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 03:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591860188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rTjWKx86t+Cil0yXSIdKV7v4L5KnY0ijXJXmVkgzvUg=;
        b=RSzQ9wygAXIo74HsTQEXzOTDleWN/jRLsLlwDIqbqKHjUrC58CBnmlj64tgOn0Gi6aIh7C
        xEfnyJ3Tg8kAG4y699MXgtE8NtEjBGvs5IQ6HQwsG31YcSrhyQW2VtWwutaMQBnRw06IMj
        8OAzfRYkq4zB1l9zVNHry4FixqkOEiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-lv1MmWNJMrCyiNAkR1bmOw-1; Thu, 11 Jun 2020 03:23:03 -0400
X-MC-Unique: lv1MmWNJMrCyiNAkR1bmOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB62872FE1;
        Thu, 11 Jun 2020 07:23:02 +0000 (UTC)
Received: from localhost (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AF71891E2;
        Thu, 11 Jun 2020 07:22:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] fs/fs-writeback.c: not WARN on unregistered BDI
Date:   Thu, 11 Jun 2020 15:22:51 +0800
Message-Id: <20200611072251.474246-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BDI is unregistered from del_gendisk() which is usually done in device's
release handler from device hotplug or error handling context, so BDI
can be unregistered anytime.

It should be normal for __mark_inode_dirty to see un-registered BDI,
so kill the WARN().

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/fs-writeback.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..5e718580d4bf 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2318,10 +2318,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			wb = locked_inode_to_wb_and_lock_list(inode);
 
-			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
-			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
-
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
-- 
2.25.2

