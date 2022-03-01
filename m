Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1AC433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiCAJMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCAJMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 04:12:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F169D42A34
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 01:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646125886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IJYnydBgVXSc4NHbs0PQXBTCZ7scLe516glr6sYgtlA=;
        b=AQ6QMiNMdjDdHtfCNQxLbEYPJrKRMd90L2SeCCalatqZJp6bUBEA4MjXMnWmWnVKcY5aqH
        RD+BVWdhqcTU/YAmKo5e4LtSilwxVIaK4vAAjXP5XMw3M21WSC0tbtbbgKIYgZdk7KuM2H
        BnTr0pfPkDVcTtBZF4SEmJcSUROI05I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-3s4wWoahOx-xqfEsJZWvAg-1; Tue, 01 Mar 2022 04:11:23 -0500
X-MC-Unique: 3s4wWoahOx-xqfEsJZWvAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987975200;
        Tue,  1 Mar 2022 09:11:22 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E37CF5ED38;
        Tue,  1 Mar 2022 09:10:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] blk-mq: kill warning when building block/blk-mq-debugfs-zoned.c
Date:   Tue,  1 Mar 2022 17:10:55 +0800
Message-Id: <20220301091055.1215013-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following warning when building block/blk-mq-debugfs-zoned.c:

In file included from block/blk-mq-debugfs-zoned.c:7:
block/blk-mq-debugfs.h:24:14: warning: ‘struct blk_mq_hw_ctx’ declared inside parameter list will not be visible outside of this definition or declaration
   24 |       struct blk_mq_hw_ctx *hctx);
      |              ^~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index a68aa6041a10..37fe2716e96e 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_BLK_DEBUG_FS
 
 #include <linux/seq_file.h>
+#include <linux/blk-mq.h>
 
 struct blk_mq_debugfs_attr {
 	const char *name;
-- 
2.31.1

